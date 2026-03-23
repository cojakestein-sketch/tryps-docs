# iMessage via Linq — Implementation Plan

**Spec:** `scopes/p2/linq-imessage/spec.md` (40 success criteria)
**FRD:** `scopes/p2/linq-imessage/frd.md` (v0.3)
**Branch:** `feat/linq-imessage`
**Date:** 2026-03-17

---

## Table of Contents

1. [Key Architectural Decisions](#1-key-architectural-decisions)
2. [Dependency Graph](#2-dependency-graph)
3. [Overall Implementation Order](#3-overall-implementation-order)
4. [Subsystem 0: Foundation Layer](#subsystem-0-foundation-layer)
5. [Subsystem 1: Onboarding & Group Setup (SC-1 through SC-6)](#subsystem-1-onboarding--group-setup)
6. [Subsystem 2: Expense Tracking via Text (SC-7 through SC-10)](#subsystem-2-expense-tracking-via-text)
7. [Subsystem 3: Voting & Polls via Text (SC-11 through SC-14)](#subsystem-3-voting--polls-via-text)
8. [Subsystem 4: Trip Planning & Queries via Text (SC-15 through SC-19)](#subsystem-4-trip-planning--queries-via-text)
9. [Subsystem 5: Proactive Agent Behavior (SC-20 through SC-22)](#subsystem-5-proactive-agent-behavior)
10. [Subsystem 6: Agent Message Behavior (SC-23 through SC-25)](#subsystem-6-agent-message-behavior)
11. [Subsystem 7: Edge Cases & Error States (SC-26 through SC-35)](#subsystem-7-edge-cases--error-states)
12. [Subsystem 8: Should NOT Happen (SC-36 through SC-40)](#subsystem-8-should-not-happen)
13. [Testing Strategy](#testing-strategy)

---

## 1. Key Architectural Decisions

### Linq Webhook Integration

Linq delivers inbound iMessages to our Supabase edge function via real-time webhooks. The architecture:

```
User (iMessage) -> Linq Server -> POST linq-webhook (Edge Function)
  -> Verify HMAC-SHA256 signature
  -> Log to linq_messages table
  -> Resolve user by phone (E.164)
  -> Resolve conversation -> trip mapping
  -> Route to NLP intent processor (Claude Haiku)
  -> Execute action handler
  -> Send response via Linq outbound REST API
```

**Key difference from existing Twilio path:** Linq delivers group chat messages with a `conversation_id` that maps to an iMessage group thread. This is the core primitive that maps group chats to trips. Twilio's `inbound-sms` handles 1:1 only; Linq handles both group and 1:1.

### Transport Abstraction Layer

Build a `MessageTransport` interface so the intent processing pipeline is transport-agnostic:

```typescript
interface MessageTransport {
  send(to: string, body: string, options?: SendOptions): Promise<SendResult>;
  sendToGroup(conversationId: string, body: string, options?: SendOptions): Promise<SendResult>;
  verifyWebhook(req: Request): Promise<boolean>;
  parseInbound(req: Request): Promise<InboundMessage>;
}
```

Two implementations: `LinqTransport` (new) and `TwilioTransport` (adapter for existing `send-sms`/`inbound-sms`). The `linq-webhook` and `inbound-sms` both feed into the same shared intent pipeline.

### NLP / Intent Processing

Use Claude Haiku via API for intent classification + entity extraction. The system prompt includes trip context (participant names, recent activity, active polls) so the model can resolve references like "Sarah" to a specific participant.

**Fallback chain:** Claude Haiku -> regex-based detection (existing `smsIntentDetection.ts`) -> `unknown` intent.

**Intent list (14 intents):**
`add_expense`, `query_balance`, `add_activity`, `query_itinerary`, `query_participants`, `add_link`, `add_flight`, `create_poll`, `vote`, `undo_action`, `remove_agent`, `help`, `casual_chat` (ignore), `unknown`

### Message Routing

- **Group messages** -> trip context resolved by `conversation_id` -> response goes to group
- **1:1 DMs** -> personal assistant mode -> response goes to 1:1
- **Private info** (balances) -> always 1:1 DM even if triggered from group
- **Casual chat** -> no response (SC-36)

### Conversation State

Multi-turn flows (clarifying questions, poll voting) tracked in `linq_conversation_state` table. Keyed by `(phone_number, conversation_id)`. Timeout after 15 minutes of inactivity.

---

## 2. Dependency Graph

```
Subsystem 0: Foundation Layer (DB, transport, NLP)
    |
    +---> Subsystem 1: Onboarding & Group Setup (SC-1..6)
    |         |
    |         +---> Subsystem 2: Expense Tracking (SC-7..10)
    |         |         |
    |         |         +---> Subsystem 5: Proactive Agent (SC-20..22)
    |         |
    |         +---> Subsystem 3: Voting & Polls (SC-11..14)
    |         |         |
    |         |         +---> Subsystem 5: Proactive Agent (SC-20..22)
    |         |
    |         +---> Subsystem 4: Trip Planning (SC-15..19)
    |
    +---> Subsystem 6: Agent Message Behavior (SC-23..25) [parallel, cross-cutting]
    |
    +---> Subsystem 7: Edge Cases (SC-26..35) [after subsystems 1-4]
    |
    +---> Subsystem 8: Should NOT Happen (SC-36..40) [after subsystems 1-4]
```

**Subsystem 6** (message behavior constraints) is cross-cutting and implemented as middleware in the response formatter. Built alongside Foundation but enforced everywhere.

**Subsystem 8** (negative tests) is validation of all other subsystems, implemented last.

---

## 3. Overall Implementation Order

| Phase | What | SCs | Estimated Effort |
|-------|------|-----|-----------------|
| **Phase 0** | Foundation: DB migration, transport layer, NLP engine, webhook handler | -- | 3-4 days |
| **Phase 1** | Onboarding & Group Setup | SC-1..6 | 2-3 days |
| **Phase 2a** | Expense Tracking via Text | SC-7..10 | 2 days |
| **Phase 2b** | Voting & Polls via Text | SC-11..14 | 2-3 days |
| **Phase 2c** | Trip Planning & Queries | SC-15..19 | 2 days |
| **Phase 3** | Proactive Agent Behavior | SC-20..22 | 1-2 days |
| **Phase 4** | Agent Message Behavior (hardening) | SC-23..25 | 1 day |
| **Phase 5** | Edge Cases & Error States | SC-26..35 | 3-4 days |
| **Phase 6** | Should NOT Happen (negative validation) | SC-36..40 | 1-2 days |

**Total estimated effort:** 16-22 days

---

## Subsystem 0: Foundation Layer

This subsystem has no SCs of its own but is required by every other subsystem. It provides the database schema, transport abstraction, NLP engine, and webhook plumbing.

### Database Changes

#### New Tables

**`linq_conversations`** -- Maps iMessage group threads to trips

```sql
CREATE TABLE linq_conversations (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  conversation_id TEXT NOT NULL UNIQUE,      -- Linq's group thread ID
  trip_id         UUID REFERENCES trips(id) ON DELETE SET NULL,
  linq_line_id    TEXT,                       -- Which Linq phone line
  is_active       BOOLEAN DEFAULT TRUE,       -- Agent not removed
  group_name      TEXT,                       -- iMessage group name if available
  created_at      TIMESTAMPTZ DEFAULT NOW(),
  updated_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_linq_conversations_conversation_id ON linq_conversations(conversation_id);
CREATE INDEX idx_linq_conversations_trip_id ON linq_conversations(trip_id);

ALTER TABLE linq_conversations ENABLE ROW LEVEL SECURITY;

-- Service role only (edge functions). No client access.
```

**`linq_messages`** -- Full message lifecycle tracking

```sql
CREATE TABLE linq_messages (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  linq_message_id   TEXT UNIQUE,              -- Linq's message ID
  conversation_id   TEXT,                     -- FK conceptual to linq_conversations
  user_id           UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  phone_number      TEXT NOT NULL,
  direction         TEXT NOT NULL CHECK (direction IN ('inbound', 'outbound')),
  body              TEXT,
  media_url         TEXT,
  media_content_type TEXT,
  trip_id           UUID REFERENCES trips(id) ON DELETE SET NULL,
  parsed_intent     TEXT,
  parsed_entities   JSONB DEFAULT '{}'::JSONB,
  intent_confidence FLOAT,
  delivery_status   TEXT DEFAULT 'received',
  error_message     TEXT,
  response_to       UUID REFERENCES linq_messages(id),  -- Links response to inbound
  created_at        TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_linq_messages_conversation ON linq_messages(conversation_id);
CREATE INDEX idx_linq_messages_phone ON linq_messages(phone_number);
CREATE INDEX idx_linq_messages_trip ON linq_messages(trip_id);
CREATE INDEX idx_linq_messages_created ON linq_messages(created_at DESC);
CREATE INDEX idx_linq_messages_user ON linq_messages(user_id);

ALTER TABLE linq_messages ENABLE ROW LEVEL SECURITY;
-- Service role only.
```

**`linq_conversation_state`** -- Multi-turn conversation tracking

```sql
CREATE TABLE linq_conversation_state (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  phone_number    TEXT NOT NULL,
  conversation_id TEXT,                      -- NULL for 1:1 DMs
  active_trip_id  UUID REFERENCES trips(id) ON DELETE SET NULL,
  pending_action  JSONB,                     -- Partial multi-turn action
  last_intent     TEXT,
  last_action_type TEXT,                     -- For undo support (SC-35)
  last_action_id  UUID,                      -- ID of last created/modified entity
  last_action_data JSONB,                    -- Snapshot for rollback
  last_message_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(phone_number, conversation_id)
);

ALTER TABLE linq_conversation_state ENABLE ROW LEVEL SECURITY;
-- Service role only.
```

**`linq_pending_users`** -- Phone numbers not yet linked to accounts

```sql
CREATE TABLE linq_pending_users (
  id                     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  phone_number           TEXT NOT NULL UNIQUE,
  conversation_ids       TEXT[] DEFAULT '{}',   -- Group threads they're in
  phantom_participant_id UUID,                  -- Participant record created for them
  trip_ids               UUID[] DEFAULT '{}',   -- Trips they belong to
  message_count          INT DEFAULT 0,
  first_seen_at          TIMESTAMPTZ DEFAULT NOW(),
  linked_user_id         UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  linked_at              TIMESTAMPTZ
);

ALTER TABLE linq_pending_users ENABLE ROW LEVEL SECURITY;
-- Service role only.
```

**`polls`** -- General-purpose text polls (new -- existing voting is per-entity)

```sql
CREATE TABLE polls (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  trip_id         UUID NOT NULL REFERENCES trips(id) ON DELETE CASCADE,
  conversation_id TEXT,                      -- Source iMessage thread
  created_by      TEXT NOT NULL,             -- Phone number of creator
  question        TEXT NOT NULL,
  options         JSONB NOT NULL,            -- [{label: "Nobu", prefix: "D1"}, ...]
  status          TEXT DEFAULT 'open' CHECK (status IN ('open', 'closed', 'cancelled')),
  closes_at       TIMESTAMPTZ,              -- Auto-close time (48hr default)
  result_option   INT,                       -- Winning option index
  created_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_polls_trip ON polls(trip_id);
CREATE INDEX idx_polls_status ON polls(status) WHERE status = 'open';
CREATE INDEX idx_polls_conversation ON polls(conversation_id);

ALTER TABLE polls ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Trip members can view polls" ON polls
  FOR SELECT USING (
    trip_id IN (SELECT trip_id FROM trip_members WHERE user_id = auth.uid())
    OR trip_id IN (SELECT id FROM trips WHERE owner_id = auth.uid())
  );
```

**`poll_votes`** -- Individual votes on polls

```sql
CREATE TABLE poll_votes (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  poll_id     UUID NOT NULL REFERENCES polls(id) ON DELETE CASCADE,
  phone_number TEXT NOT NULL,               -- Voter phone (may not have account)
  user_id     UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  option_index INT NOT NULL,                -- Which option (0-based)
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(poll_id, phone_number)             -- One vote per person per poll
);

CREATE INDEX idx_poll_votes_poll ON poll_votes(poll_id);

ALTER TABLE poll_votes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Trip members can view poll votes" ON poll_votes
  FOR SELECT USING (
    poll_id IN (
      SELECT id FROM polls WHERE trip_id IN (
        SELECT trip_id FROM trip_members WHERE user_id = auth.uid()
      )
    )
  );
```

#### Columns Added to Existing Tables

**`participants`** -- Add phone-based linking

```sql
ALTER TABLE participants ADD COLUMN IF NOT EXISTS linq_phone TEXT;
ALTER TABLE participants ADD COLUMN IF NOT EXISTS is_phantom BOOLEAN DEFAULT FALSE;
-- is_phantom: participant created from iMessage group, no Tryps account yet
```

**`trips`** -- Add Linq conversation reference

```sql
ALTER TABLE trips ADD COLUMN IF NOT EXISTS linq_conversation_id TEXT;
```

**`outbound_sms_queue`** -- Extend trigger_type for new event types

```sql
ALTER TABLE outbound_sms_queue DROP CONSTRAINT IF EXISTS outbound_sms_queue_trigger_type_check;
ALTER TABLE outbound_sms_queue ADD CONSTRAINT outbound_sms_queue_trigger_type_check
  CHECK (trigger_type IN (
    'voting_deadline', 'expense_added', 'trip_reminder',
    'settlement_received', 'participant_joined', 'itinerary_update',
    'poll_reminder', 'poll_result', 'welcome', 'proactive_arrival',
    'app_expense_notification', 'ownership_transfer', 'agent_removed'
  ));
```

### New Files/Modules

#### Edge Functions (Deno, `supabase/functions/`)

| File | Purpose |
|------|---------|
| `supabase/functions/linq-webhook/index.ts` | Inbound Linq webhook handler. Verifies HMAC, logs message, resolves user+trip, routes to intent processor, sends response. ~500 LOC. |
| `supabase/functions/linq-response/index.ts` | Outbound message sender via Linq REST API. Supports group and 1:1. ~150 LOC. |
| `supabase/functions/linq-delivery-status/index.ts` | Delivery/read receipt webhook handler. Updates `linq_messages.delivery_status`. ~80 LOC. |

#### Shared Modules (Deno, `supabase/functions/_shared/`)

| File | Purpose |
|------|---------|
| `supabase/functions/_shared/linq-types.ts` | Linq API type definitions -- webhook payloads, API requests/responses, event types. |
| `supabase/functions/_shared/message-transport.ts` | `MessageTransport` interface definition + `SendResult`, `InboundMessage`, `SendOptions` types. |
| `supabase/functions/_shared/linq-transport.ts` | `LinqTransport` class implementing `MessageTransport`. Handles Linq API auth, HMAC-SHA256 verification, send to individual, send to group, typing indicator. |
| `supabase/functions/_shared/user-resolver.ts` | Phone -> user resolution. Checks `user_profiles.phone_number` with E.164 variants, checks `linq_pending_users`, creates phantom participants. Shared between Linq and Twilio paths. |
| `supabase/functions/_shared/trip-resolver.ts` | Conversation -> trip resolution. Looks up `linq_conversations` by `conversation_id`. For 1:1 DMs, uses "most recent active trip" heuristic or asks for disambiguation. |
| `supabase/functions/_shared/conversation-state.ts` | Multi-turn state manager. Read/write `linq_conversation_state`. Handles pending actions, timeout (15 min), last action tracking for undo. |
| `supabase/functions/_shared/intent-processor.ts` | Claude Haiku NLP engine. System prompt with trip context (participants, active polls, recent expenses). Returns `{intent, entities, confidence}`. Falls back to regex (`smsIntentDetection.ts` patterns) on API failure. |
| `supabase/functions/_shared/intent-router.ts` | Maps intent string to handler function. Dispatches to appropriate handler. Handles `casual_chat` (return null = no response) and `unknown` (clarification prompt). |
| `supabase/functions/_shared/action-handlers.ts` | All intent handler functions: `handleAddExpense`, `handleQueryBalance`, `handleAddActivity`, `handleQueryItinerary`, `handleQueryParticipants`, `handleAddLink`, `handleCreatePoll`, `handleVote`, `handleVoteChange`, `handleUndoAction`, `handleRemoveAgent`, `handlePersonalAssistant`, `handleOutOfScope`, `handleHelp`. |
| `supabase/functions/_shared/response-formatter.ts` | Formats handler results into iMessage text. Enforces 6-line limit (SC-23), 3-message max (SC-24), routes private info to 1:1 DM (SC-25). |
| `supabase/functions/_shared/group-sync.ts` | iMessage group <-> trip participant sync. Handles: new group detection, member added/left, ownership transfer (SC-33), bidirectional sync (SC-40). |
| `supabase/functions/_shared/welcome-message.ts` | Generates welcome message. Includes who added agent, example command, App Store link, removal instruction. Under 6 lines. |
| `supabase/functions/_shared/vibe-quiz.ts` | Vibe quiz via text. Sends questions as prompts or deep link. Saves responses to trip vibe profile. |
| `supabase/functions/_shared/proactive-triggers.ts` | Logic for proactive triggers: arrival reminder (SC-20), poll nudge (SC-21), expense notification (SC-22). |
| `supabase/functions/_shared/duplicate-detector.ts` | Expense deduplication. Checks recent expenses (5 min window) for similar amount/description before logging (SC-31). |

#### New Edge Function

| File | Purpose |
|------|---------|
| `supabase/functions/close-polls/index.ts` | Cron job (hourly). Closes expired polls, tallies votes, announces results, adds winner to itinerary. |

#### Migration File

| File | Purpose |
|------|---------|
| `supabase/migrations/YYYYMMDD000000_linq_imessage_tables.sql` | All new tables + column additions in a single migration. |

### Implementation Order (Within Foundation)

1. `linq-types.ts` -- Type definitions for Linq payloads
2. `message-transport.ts` -- Interface definition
3. Migration SQL -- All tables
4. `linq-transport.ts` -- Linq API client
5. `user-resolver.ts` -- Phone-to-user resolution
6. `trip-resolver.ts` -- Conversation-to-trip resolution
7. `conversation-state.ts` -- State manager
8. `intent-processor.ts` -- Claude Haiku NLP engine
9. `intent-router.ts` -- Intent dispatch
10. `response-formatter.ts` -- Message formatting + constraints
11. `action-handlers.ts` -- Stub handlers (fleshed out per subsystem)
12. `linq-webhook/index.ts` -- Wire everything together
13. `linq-response/index.ts` -- Outbound sender
14. `linq-delivery-status/index.ts` -- Delivery tracking

---

## Subsystem 1: Onboarding & Group Setup

### Success Criteria

- **SC-1.** Add Tryps number to iMessage group -> welcome message within 5s, under 6 lines, with App Store link.
- **SC-2.** All group members auto-added to trip as participants (linked by phone, no signup required).
- **SC-3.** Data from group chat is already in app when user downloads later.
- **SC-4.** Person added to iMessage group joins trip automatically within 10s.
- **SC-5.** Person who leaves iMessage group leaves trip within 10s.
- **SC-6.** Agent prompts vibe quiz in first 5 minutes of onboarding.

### Database Changes

Uses tables from Foundation: `linq_conversations`, `linq_pending_users`, plus `participants.linq_phone` and `participants.is_phantom` columns.

No additional tables needed beyond Foundation.

### Required New Files/Modules

| File | What It Does |
|------|-------------|
| `supabase/functions/_shared/group-sync.ts` | Core module for syncing iMessage group membership with trip participants. Handles: new group detection, member added, member left, trip creation for new groups. |
| `supabase/functions/_shared/welcome-message.ts` | Generates the welcome message template. Includes: who added the agent, one example command, App Store link. Under 6 lines. |
| `supabase/functions/_shared/vibe-quiz.ts` | Manages vibe quiz prompts via text. Sends questions ("Beach or mountains?") as individual prompts or deep link to app quiz. Saves responses to trip vibe profile. |

### Dependencies

- **Foundation layer** (transport, webhook handler, user resolver)
- Linq must provide: `conversation_id`, group membership change events (`member.joined`, `member.left`), sender identification

### Implementation Order

1. **Group detection** -- When Linq fires `message.received` with a new `conversation_id`, check if `linq_conversations` has a mapping. If not, it's a new group.

2. **SC-1: Welcome message** -- On new group detection:
   - Create `linq_conversations` record
   - Create a new trip (name: "Trip" or extracted from group name)
   - Send welcome: `"Hey! I'm Tryps, your trip planning assistant. {adder_name} added me.\n\nTry: 'Add $50 for dinner' or 'What's the plan?'\n\nGet the app: jointryps.com/download\n\nText REMOVE to kick me out."`
   - Must respond within 5 seconds (webhook processing target)

3. **SC-2: Auto-add all members** -- On new group:
   - Linq webhook includes list of group participants (phone numbers)
   - For each phone: look up `user_profiles.phone_number` -> if found, create participant with `userId` link. If not found, create phantom participant (`is_phantom=true`, `linq_phone` set) + `linq_pending_users` record.
   - All appear as trip members on backend immediately.

4. **SC-3: Data available on app download** -- When a user signs up with a phone number that matches a `linq_pending_users` entry:
   - Database trigger: on `user_profiles` insert/update where `phone_number` matches `linq_pending_users.phone_number`
   - Link phantom participant to real user (`participants.userId`, clear `is_phantom`)
   - Update `linq_pending_users.linked_user_id`
   - All expenses, activities, flights created via group chat are already linked to the trip -> they appear in app.

5. **SC-4: Person added to group** -- Linq fires group membership change event:
   - Parse the new member's phone number
   - Create participant (phantom or linked) on the mapped trip
   - Within 10 seconds SLA

6. **SC-5: Person leaves group** -- Linq fires group membership change event:
   - Remove participant from trip (or mark inactive)
   - Within 10 seconds SLA
   - If the person was trip owner, trigger ownership transfer (SC-33, handled in Subsystem 7)

7. **SC-6: Vibe quiz** -- After welcome message + member sync:
   - Schedule vibe quiz prompts (delayed 2-3 minutes after welcome)
   - For each member, send 1:1 DM with first vibe question or deep link
   - If text-based: "Beach or mountains?" -> capture reply -> next question -> save vibe profile
   - Uses `linq_conversation_state.pending_action` to track multi-turn quiz state

### Testing Strategy

- **Unit tests:** `group-sync.ts` -- test member list diffing, phantom participant creation, trip auto-creation
- **Unit tests:** `welcome-message.ts` -- test message is under 6 lines, includes required elements
- **Integration tests:** Webhook -> new group -> trip created + participants added + welcome sent
- **Integration tests:** Member join/leave events -> participant list updated within 10s

---

## Subsystem 2: Expense Tracking via Text

### Success Criteria

- **SC-7.** "I paid $120 for dinner, split 4 ways" -> logged, confirmed in one line, shows in app.
- **SC-8.** Ambiguous expense ("I paid for the Uber", no amount) -> agent asks clarifying question -> user replies -> logged.
- **SC-9.** Custom split: "I paid $90 for dinner, split between me Sarah and Tom" -> split 3 ways, others excluded.
- **SC-10.** Receipt photo -> OCR -> agent asks who's splitting -> logged.

### Database Changes

No new tables. Uses existing `expenses` and `expense_participants` tables via `supabaseStorage.addExpense()`.

The `linq_conversation_state.pending_action` field stores partial expense data during multi-turn flows (SC-8, SC-10).

### Required New Files/Modules

Handlers added to `supabase/functions/_shared/action-handlers.ts`:

| Handler | What It Does |
|---------|-------------|
| `handleAddExpense()` | Parses NLP entities (amount, description, payer, split participants). If complete, writes expense via Supabase. If incomplete, stores partial state and asks clarifying question. |
| `handleExpenseClarification()` | Continues multi-turn expense flow. Merges new info (amount, split) with pending state. |

### Dependencies

- **Subsystem 0** (Foundation: NLP, transport, conversation state)
- **Subsystem 1** (Onboarding: participants must exist to split expenses)
- Existing: `supabaseStorage.addExpense()`, `ledger.ts` for balance calculations
- Existing: `parse-image` edge function for receipt OCR (SC-10)

### Implementation Order

1. **SC-7: Simple expense** -- Intent `add_expense` with complete data:
   - NLP extracts: `{amount: 12000, description: "dinner", payer: "sender", split: "equal", splitCount: 4}`
   - Resolve payer phone -> participant ID
   - Call Supabase: insert expense, link all participants
   - Respond: `"Got it -- $120 for dinner, split 4 ways."`

2. **SC-8: Clarifying questions** -- Incomplete expense:
   - NLP detects `add_expense` but missing amount
   - Store partial: `{pending_action: {intent: "add_expense", description: "Uber", payer: "sender"}}`
   - Respond: `"How much was the Uber?"`
   - Next message from same user: NLP or simple number parse -> merge with pending -> complete expense

3. **SC-9: Custom split** -- Named participants:
   - NLP extracts: `{split: "custom", splitNames: ["me", "Sarah", "Tom"]}`
   - Resolve names to participant IDs using fuzzy match against trip participants
   - If ambiguous name, ask: `"Which Sarah -- Sarah J or Sarah K?"`
   - Create expense with only those participant IDs

4. **SC-10: Receipt photo** -- MMS handling:
   - Linq webhook includes media attachment URL
   - Download image, send to `parse-image` edge function (reuse existing)
   - Extract amount + merchant
   - Ask: `"Got it -- $67.50 at [merchant]. Who's splitting?"`
   - User replies "everyone" -> split equally among all trip participants
   - Store partial state between image parse and split confirmation

### Testing Strategy

- **Unit tests:** Expense NLP entity extraction (amount parsing, name resolution, split type detection)
- **Unit tests:** Multi-turn state management (partial -> complete flow)
- **Integration tests:** Full webhook -> expense in DB -> balance recalculation
- **Integration tests:** Receipt photo -> parse-image -> clarification -> expense logged

---

## Subsystem 3: Voting & Polls via Text

### Success Criteria

- **SC-11.** "Let's vote: Nobu, Zuma, or Komodo" -> agent creates poll, sends numbered options, members vote, votes recorded in app.
- **SC-12.** Vote change: "switch me to Nobu" -> vote updated, agent confirms.
- **SC-13.** Poll closes after 48hr -> agent announces results, adds winner to itinerary.
- **SC-14.** Voting works without native polling (numbered reply pattern is baseline).

### Database Changes

Uses `polls` and `poll_votes` tables from Foundation migration.

### Required New Files/Modules

Handlers in `action-handlers.ts`:

| Handler | What It Does |
|---------|-------------|
| `handleCreatePoll()` | Parses poll options from text, creates `polls` record, generates labeled options (numbered or prefixed), sends to group. |
| `handleVote()` | Matches vote reply (number or name) to active poll(s). Records/updates `poll_votes`. If ambiguous (multiple active polls), asks which poll (SC-32 overlap). |
| `handleVoteChange()` | Detects "switch/change my vote" intent, updates existing `poll_votes` record. |

New scheduled function:

| File | What It Does |
|------|-------------|
| `supabase/functions/close-polls/index.ts` | Cron job (hourly). Finds polls past `closes_at`. Tallies votes, sets `result_option`, updates status to 'closed'. Sends result announcement to group. Adds winner to itinerary as activity. |

### Dependencies

- **Subsystem 0** (Foundation: NLP, transport)
- **Subsystem 1** (Onboarding: participants must exist to vote)
- Existing: `supabaseStorage.addTripActivity()` for adding winner to itinerary

### Implementation Order

1. **SC-14 + SC-11: Basic poll creation + numbered voting**
   - Intent `create_poll` with entities: `{options: ["Nobu", "Zuma", "Komodo"]}`
   - Create `polls` record with options JSONB: `[{label: "Nobu", prefix: "1"}, {label: "Zuma", prefix: "2"}, {label: "Komodo", prefix: "3"}]`
   - Set `closes_at` to 48 hours from now
   - Send to group: `"Vote!\n1. Nobu\n2. Zuma\n3. Komodo\nReply 1, 2, or 3"`
   - Handle vote reply: bare number or option name -> `poll_votes` upsert

2. **SC-12: Vote change**
   - Intent `vote_change` with entity: `{newOption: "Nobu"}`
   - Look up existing vote for this user on active polls
   - Update `poll_votes.option_index`
   - Respond: `"Updated -- you're now voting for Nobu."`

3. **SC-13: Poll closing + result announcement**
   - `close-polls` cron job:
     - Query `polls WHERE status = 'open' AND closes_at <= NOW()`
     - For each: tally `poll_votes`, determine winner
     - Update `polls.status = 'closed'`, `polls.result_option = winner_index`
     - Send to group: `"[Winner] won with X votes! Added to the itinerary."`
     - Create trip activity for the winner

### Testing Strategy

- **Unit tests:** Poll creation from NLP entities, option labeling, prefix generation
- **Unit tests:** Vote matching (number, name, partial match)
- **Unit tests:** Vote tallying and winner determination (ties)
- **Integration tests:** Create poll -> vote -> close -> result announced -> activity created
- **Integration tests:** Multi-poll disambiguation (tested more in Subsystem 7, SC-32)

---

## Subsystem 4: Trip Planning & Queries via Text

### Success Criteria

- **SC-15.** "Add dinner at Nobu on Friday" -> confirmed, appears in app itinerary.
- **SC-16.** "What's the plan for Saturday?" -> Saturday's itinerary, under 6 lines.
- **SC-17.** "What do I owe?" -> per-person balance sent privately.
- **SC-18.** "Who's going?" -> participant list.
- **SC-19.** Paste Airbnb URL -> name, dates, price extracted -> added as accommodation option.

### Database Changes

No new tables. Uses existing trip activities, expenses, participants, accommodations tables.

### Required New Files/Modules

Handlers in `action-handlers.ts`:

| Handler | What It Does |
|---------|-------------|
| `handleAddActivity()` | Parses venue + date from NLP, creates trip activity via `supabaseStorage.addTripActivity()`. |
| `handleQueryItinerary()` | Fetches trip activities for requested date/day, formats as concise list under 6 lines. |
| `handleQueryBalance()` | Calls `ledger.calculateBalances()`, formats per-person debts. Sends as 1:1 DM (private). |
| `handleQueryParticipants()` | Fetches participant list, formats names. |
| `handleAddLink()` | Extracts URL, classifies type (accommodation/flight/restaurant), calls existing `scrape-accommodation` or `scrape-link` edge functions, adds to trip. |

### Dependencies

- **Subsystem 0** (Foundation: NLP, transport)
- **Subsystem 1** (Onboarding: trip and participants must exist)
- Existing: `supabaseStorage.addTripActivity()`, `ledger.calculateBalances()`, `scrape-accommodation`, `scrape-link`
- Existing: URL extraction + classification from `inbound-sms` (reuse `extractAllUrls()`, `classifyLinkType()`)

### Implementation Order

1. **SC-15: Add activity** -- Most common planning action
   - NLP: `{intent: "add_activity", venue: "Nobu", date: "Friday", category: "dinner"}`
   - Resolve "Friday" to actual date using trip date range
   - Create via `supabaseStorage.addTripActivity()`
   - Respond: `"Added -- Nobu, Friday Mar 20"`

2. **SC-16: Query itinerary** -- Read-only, low risk
   - NLP: `{intent: "query_itinerary", day: "Saturday"}`
   - Fetch activities for that date, format:
     ```
     Saturday Mar 21:
     10am - Surfing at Waikiki
     1pm - Lunch at Duke's
     7pm - Dinner at Nobu
     ```
   - Enforce 6-line limit; if more items, truncate with "...and 3 more. Check the app for full itinerary."

3. **SC-17: Query balance** -- Send privately via 1:1 DM
   - NLP: `{intent: "query_balance"}`
   - Calculate balances for requesting user
   - Send as 1:1 DM (not group): `"You owe Jake $30, Sarah $15."`

4. **SC-18: Query participants**
   - NLP: `{intent: "query_participants"}`
   - Format: `"Going: Jake, Sarah, Tom, Emma (4 people)"`

5. **SC-19: URL parsing** -- Reuse existing infrastructure
   - Detect URL in message body (reuse `extractAllUrls()`)
   - Classify: accommodation -> `scrape-accommodation`, restaurant -> `scrape-link`, other -> `scrape-link`
   - Add to trip as appropriate entity type
   - Respond: `"Added to Stay options -- Oceanfront Villa, $450/night, Mar 20-23"`

### Testing Strategy

- **Unit tests:** Date resolution ("Friday" -> actual date given trip range)
- **Unit tests:** Balance formatting (multi-person debts)
- **Unit tests:** Itinerary formatting with 6-line truncation
- **Integration tests:** Add activity via text -> appears in trip activities table
- **Integration tests:** URL paste -> scrape -> accommodation added
- **Integration tests:** Balance query -> response sent to 1:1 DM (not group)

---

## Subsystem 5: Proactive Agent Behavior

### Success Criteria

- **SC-20.** Trip start date arrives -> agent texts group with Airbnb address + travel time from airport.
- **SC-21.** Poll open 24hrs with non-voters -> agent nudges group.
- **SC-22.** Expense added in-app -> agent texts group "{name} added $80 for Uber."

### Database Changes

No new tables. Uses `outbound_sms_queue` with extended trigger types (from Foundation migration).

### Required New Files/Modules

| File | What It Does |
|------|-------------|
| `supabase/functions/_shared/proactive-triggers.ts` | Logic for each proactive trigger: arrival reminder, poll nudge, expense notification. Generates message text + recipient list. |

Extend existing `supabase/functions/check-proactive-triggers/index.ts` to also check:
- Trips starting today with Linq conversations (SC-20)
- Open polls > 24hrs with missing voters (SC-21)

New database trigger for SC-22:

```sql
-- Trigger on expenses insert -> queue notification to Linq group
CREATE OR REPLACE FUNCTION notify_linq_expense_added()
RETURNS TRIGGER AS $$
BEGIN
  -- Only if trip has a Linq conversation
  IF EXISTS (SELECT 1 FROM linq_conversations WHERE trip_id = NEW.trip_id AND is_active = TRUE) THEN
    -- Queue group notification (handled by linq-response)
    INSERT INTO outbound_sms_queue (user_id, phone_number, body, trip_id, trigger_type, scheduled_for)
    VALUES (
      NEW.payer_id,
      'GROUP:' || (SELECT conversation_id FROM linq_conversations WHERE trip_id = NEW.trip_id LIMIT 1),
      '', -- Body generated at send time with payer name + amount
      NEW.trip_id,
      'app_expense_notification',
      NOW()
    );
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_linq_expense_notification
  AFTER INSERT ON expenses
  FOR EACH ROW
  EXECUTE FUNCTION notify_linq_expense_added();
```

### Dependencies

- **Subsystem 0** (Foundation: transport, outbound sender)
- **Subsystem 1** (Onboarding: trip-conversation mapping must exist)
- **Subsystem 3** (Voting: polls must exist for SC-21)
- Existing: `check-proactive-triggers` cron job, `outbound_sms_queue` table

### Implementation Order

1. **SC-22: Expense notification** -- Simplest trigger (database trigger)
   - DB trigger on `expenses` INSERT
   - Check if trip has `linq_conversation_id`
   - Format: `"{payer_name} added ${amount} for {description}."`
   - Send to group via `linq-response`

2. **SC-21: Poll reminder** -- Extend existing proactive trigger cron
   - In `check-proactive-triggers`: find open polls > 24hrs with < 100% votes
   - Format: `"2 people still haven't voted on {poll_question} -- poll closes tomorrow."`
   - Send to group

3. **SC-20: Arrival reminder** -- Extend proactive trigger cron
   - Find trips starting today with Linq conversations
   - Look up accommodation address
   - Format: `"Hey, here's the Airbnb address: {address}. It's {time} from the airport."`
   - Send to group
   - Note: travel time estimation may need Google Maps API or be approximate

### Testing Strategy

- **Unit tests:** Message formatting for each trigger type
- **Unit tests:** Non-voter detection for poll reminders
- **Integration tests:** Insert expense -> outbound_sms_queue populated -> message sent
- **Integration tests:** Poll open > 24hrs -> reminder sent
- **Integration tests:** Trip start date = today -> arrival message sent

---

## Subsystem 6: Agent Message Behavior

### Success Criteria

- **SC-23.** Every agent message is 6 lines or fewer.
- **SC-24.** Agent sends at most 3 messages in a row before waiting for user input.
- **SC-25.** Agent uses 1:1 DMs for private info (balances) instead of group.

### Database Changes

None. This is enforced in the response formatter middleware.

### Required New Files/Modules

All logic lives in `supabase/functions/_shared/response-formatter.ts`:

| Function | What It Does |
|----------|-------------|
| `enforceLineLimit(text, maxLines=6)` | Truncates message to 6 lines. If truncated, appends "...check the app for more." |
| `enforceMessageLimit(messages[], max=3)` | If handler returns >3 messages, batches remaining into fewer messages or truncates. |
| `routeResponse(intent, response)` | Determines if response goes to group or 1:1 DM. Balance queries, personal data -> 1:1. Confirmations, announcements -> group. |

### Dependencies

- **Subsystem 0** (Foundation: transport must support both group send and 1:1 DM send)

### Implementation Order

1. **SC-23: Line limit** -- Implement `enforceLineLimit()`, integrate into all response paths
2. **SC-25: Private DM routing** -- Implement `routeResponse()` with routing rules:
   - `query_balance` -> 1:1 DM
   - `query_personal_data` -> 1:1 DM
   - Everything else -> group (or whatever conversation the message came from)
3. **SC-24: Message count limit** -- Implement `enforceMessageLimit()`, wrap all handler outputs

### Testing Strategy

- **Unit tests:** Line counting and truncation
- **Unit tests:** Route determination per intent type
- **Unit tests:** Message batching when handler produces 4+ messages
- **Integration tests:** Trigger all 10+ response types -> verify none exceeds 6 lines
- **Integration tests:** Balance query from group -> response arrives in 1:1 DM

---

## Subsystem 7: Edge Cases & Error States

### Success Criteria

- **SC-26.** 2-person chat (below Linq group minimum) -> agent handles via 1:1 messages.
- **SC-27.** Unparseable message -> agent does NOT respond.
- **SC-28.** First message ever is an expense -> agent creates trip first, then logs expense.
- **SC-29.** Out-of-scope request ("book us a flight") -> "coming soon" response.
- **SC-30.** Welcome message names who added agent, any member can text "remove" to kick it.
- **SC-31.** Two similar expenses within 5 min -> duplicate detection alert.
- **SC-32.** Multiple active polls + bare number reply -> disambiguation.
- **SC-33.** Trip owner leaves iMessage group -> ownership transfers.
- **SC-34.** 1:1 DM to Tryps number -> personal assistant mode (shows active trips, cross-trip balances).
- **SC-35.** Undo/correct last action: "actually $35 not $45", "delete last expense", "change Nobu to Saturday".

### Database Changes

Uses `linq_conversation_state.last_action_type`, `last_action_id`, `last_action_data` columns (included in Foundation migration).

### Required New Files/Modules

| File / Handler | What It Does |
|----------------|-------------|
| `_shared/action-handlers.ts` :: `handleRemoveAgent()` | Marks `linq_conversations.is_active = false`. Sends goodbye. Stops responding. |
| `_shared/action-handlers.ts` :: `handleUndoAction()` | Reads `last_action_*` from conversation state. Reverses: update expense amount, delete expense, update activity date. |
| `_shared/action-handlers.ts` :: `handlePersonalAssistant()` | 1:1 DM mode: lists active trips, shows cross-trip balances, offers to create new trip. |
| `_shared/duplicate-detector.ts` | On `add_expense`: query recent expenses (last 5 min) for same trip with similar amount/description. If match found, ask before logging. |
| `_shared/group-sync.ts` :: `handleOwnershipTransfer()` | When owner leaves, transfer to longest-tenured co-host or participant. Announce to group. |

### Dependencies

- **All previous subsystems** (this subsystem tests edge cases across all features)
- **Subsystem 1** specifically for SC-26, SC-28, SC-30, SC-33
- **Subsystem 2** for SC-31, SC-35 (expense undo)
- **Subsystem 3** for SC-32 (poll disambiguation)

### Implementation Order

1. **SC-27: Silent on unparseable messages** -- In intent router: if intent is `casual_chat` or `unknown` with low confidence, return `null` (no response). Webhook returns 200 but sends nothing.

2. **SC-30: Remove agent** -- Intent `remove_agent` triggered by "remove", "stop", "leave":
   - Set `linq_conversations.is_active = false`
   - Send: `"Thanks for using Tryps! Your trip data is still in the app. Add me back anytime."`
   - All subsequent messages to this conversation are ignored (check `is_active` early in pipeline)

3. **SC-29: Out of scope** -- Intent `out_of_scope` for booking/reservation requests:
   - Respond: `"I can't book flights yet -- coming soon. For now, paste your flight confirmation and I'll track it."`

4. **SC-28: First message creates trip** -- In trip resolver: if no trip exists for this conversation:
   - Auto-create trip with default name
   - Then process the original intent (expense, activity, etc.)
   - Respond with both: `"Created a new trip! And logged $50 for gas."`

5. **SC-34: Personal assistant mode** -- Detect 1:1 DM (no `conversation_id` or 2-party conversation):
   - Fetch all trips for user
   - Show: `"Your trips:\n1. Miami Trip (3 expenses)\n2. Ski Weekend (1 expense)\n\nWhat do I owe across everything?\nJake: $30 (Miami)\nSarah: $15 (Ski)"`

6. **SC-26: 2-person chat** -- Detect conversation with only 2 members (+ Tryps):
   - Linq may report this differently (groups require 3+ on iMessage)
   - Fallback: treat as 1:1 to each person, link both to same trip

7. **SC-31: Duplicate expense detection** -- Before writing expense:
   - Query `expenses WHERE trip_id = X AND created_at > NOW() - INTERVAL '5 minutes'`
   - Check for similar amount (within 10%) and similar description (fuzzy match)
   - If found: `"Heads up -- {name1} and {name2} both logged ~$120 for dinner. Is this one expense or two?"`
   - Store pending state; wait for confirmation

8. **SC-32: Multi-poll disambiguation** -- When voting with bare number:
   - Check active polls for this trip
   - If >1 active: `"Which poll -- dinner spot or hotel?"`
   - When polls are created with overlap, use labeled prefixes: `"DINNER: Reply D1, D2, D3 / HOTEL: Reply H1, H2, H3"`

9. **SC-33: Ownership transfer** -- Triggered by SC-5 (member leave) when leaver is trip owner:
   - Find next eligible owner: co-host first, then longest-tenured participant
   - Update `trips.owner_id`
   - Announce: `"Jake left the group. Sarah is now the trip organizer."`

10. **SC-35: Undo/correct** -- Intent `undo_action`:
    - Read `last_action_*` from conversation state
    - Parse correction: "actually $35 not $45" -> update expense amount
    - "Delete last expense" -> soft delete expense
    - "Change Nobu to Saturday" -> update activity date
    - Respond with confirmation of the change

### Testing Strategy

- **Unit tests:** Duplicate detection (similar amounts, fuzzy description matching)
- **Unit tests:** Undo parsing (amount correction, deletion, date change)
- **Unit tests:** Ownership transfer logic (co-host priority, longest-tenured fallback)
- **Unit tests:** Multi-poll prefix generation and disambiguation
- **Integration tests:** Each SC verified against its "Verified by" scenario
- **Integration tests:** Personal assistant mode with multiple trips
- **Integration tests:** Remove agent -> subsequent messages ignored

---

## Subsystem 8: Should NOT Happen

### Success Criteria

- **SC-36.** Agent does NOT respond to casual conversation ("lol", "see you there", memes).
- **SC-37.** No message exceeds 6 lines. No more than 3 messages in a row.
- **SC-38.** Agent does NOT announce every background action (silent processing).
- **SC-39.** Non-trip-members cannot see trip data.
- **SC-40.** iMessage group and trip membership are always in sync.

### Database Changes

None. These are behavioral constraints enforced across the system.

### Required New Files/Modules

No new files. These criteria are enforced by:

| SC | Enforcement Point |
|----|-------------------|
| SC-36 | `intent-processor.ts`: `casual_chat` intent returns null response. NLP prompt explicitly trained to classify "lol", "haha", "can't wait", emojis, memes as `casual_chat`. |
| SC-37 | `response-formatter.ts`: `enforceLineLimit()` + `enforceMessageLimit()` (Subsystem 6). |
| SC-38 | `action-handlers.ts`: Only send response when handler returns a non-null message. Link scraping, background processing -> no message unless result is actionable. |
| SC-39 | `trip-resolver.ts`: Before returning trip data, verify the requesting phone number is a member of that trip's conversation. `linq_messages` RLS prevents cross-trip leaks. |
| SC-40 | `group-sync.ts`: Bidirectional sync. Group change -> participant change (SC-4, SC-5). App participant removal -> if Linq supports removing from group, call API; if not, DM the person explaining they were removed from the trip and stop tracking their messages for this conversation. |

### Dependencies

- **All previous subsystems** (these are validation constraints)
- **Subsystem 6** specifically (SC-37 is the same as SC-23 + SC-24)

### Implementation Order

1. **SC-36: No response to casual chat** -- Already handled by intent classifier. Add explicit test: send 5 casual messages -> verify 0 responses.

2. **SC-37: Message limits** -- Already enforced by Subsystem 6. Verify across all response types.

3. **SC-38: Silent background processing** -- Review all handlers. Ensure scraping, parsing, and internal processing steps do NOT send intermediate messages. Only final results get responses.

4. **SC-39: Authorization check** -- Add phone-in-conversation check to `trip-resolver.ts`. If a phone not in the group queries trip data, return nothing. Outsider texting Tryps number asking about a specific trip gets: no trip details revealed.

5. **SC-40: Bidirectional membership sync** -- Two directions:
   - iMessage -> app: Already handled (SC-4, SC-5)
   - App -> iMessage: On participant removal in app, check if trip has `linq_conversation_id`. If yes, try Linq API to remove from group. If API doesn't support removal, send 1:1 DM to removed person: `"You've been removed from [trip name]. Your data has been saved."` Mark them inactive in the conversation mapping.

### Testing Strategy

- **Negative tests:** Send casual messages -> verify silence
- **Negative tests:** Send >6 line triggers -> verify truncation
- **Negative tests:** Query trip data from non-member phone -> verify no data leaked
- **Sync tests:** Remove participant in app -> verify they stop receiving group messages or get DM notification
- **Sync tests:** Add participant in app -> verify they appear in trip (iMessage group add may require manual step if Linq doesn't support it)

---

## Testing Strategy (Global)

### Test Levels

| Level | Framework | Location | What It Tests |
|-------|-----------|----------|---------------|
| Unit | Jest | `__tests__/utils/linq/` | Intent parsing, entity extraction, formatters, state management, balance calculation |
| Unit (Edge Fn) | Deno test | `supabase/functions/_shared/__tests__/` | Handler logic, transport abstraction, NLP prompt validation |
| Integration | Jest + Supabase local | `__tests__/integration/linq/` | Full webhook -> DB write -> response cycles |
| E2E | Manual + Maestro | `.maestro/linq/` | Actual Linq sandbox -> real iMessage -> verify responses |

### Test Fixtures

Create `__tests__/fixtures/linq-webhooks/` with sample payloads:
- `new-group-message.json` -- First message in a new group
- `expense-simple.json` -- "I paid $120 for dinner"
- `expense-ambiguous.json` -- "I paid for the Uber"
- `vote-create.json` -- "Let's vote: A, B, or C"
- `vote-reply.json` -- "2"
- `casual-chat.json` -- "lol can't wait"
- `receipt-mms.json` -- Image attachment
- `url-paste.json` -- Airbnb link
- `balance-query.json` -- "What do I owe?"

### Per-Subsystem Test Counts (Target)

| Subsystem | Unit Tests | Integration Tests |
|-----------|-----------|-------------------|
| 0: Foundation | 15 | 5 |
| 1: Onboarding | 10 | 8 |
| 2: Expenses | 12 | 6 |
| 3: Polls | 10 | 5 |
| 4: Planning | 8 | 5 |
| 5: Proactive | 6 | 3 |
| 6: Behavior | 8 | 3 |
| 7: Edge Cases | 15 | 10 |
| 8: Negative | 8 | 5 |
| **Total** | **92** | **50** |

### NLP Prompt Regression Tests

Maintain a test suite of 50+ message examples with expected intents and entities. Run against Claude Haiku on every prompt change to detect regressions. Store in `__tests__/fixtures/nlp-examples.json`:

```json
[
  {"input": "I paid $120 for dinner, split 4 ways", "intent": "add_expense", "entities": {"amount": 12000, "description": "dinner", "splitCount": 4}},
  {"input": "lol", "intent": "casual_chat"},
  {"input": "what do I owe?", "intent": "query_balance"}
]
```

### Typecheck Gate

Every change runs `npm run typecheck` before commit. The edge function types are checked separately via `deno check` in the `supabase/functions/` directory.

---

## Appendix: File Tree (New Files)

```
supabase/
  migrations/
    YYYYMMDD000000_linq_imessage_tables.sql     # All new tables + alterations
  functions/
    _shared/
      linq-types.ts                              # Linq API type definitions
      message-transport.ts                       # Transport interface
      linq-transport.ts                          # Linq API client
      user-resolver.ts                           # Phone -> user resolution
      trip-resolver.ts                           # Conversation -> trip resolution
      conversation-state.ts                      # Multi-turn state manager
      intent-processor.ts                        # Claude Haiku NLP engine
      intent-router.ts                           # Intent -> handler dispatch
      action-handlers.ts                         # All intent handlers
      response-formatter.ts                      # 6-line limit, 3-msg limit, DM routing
      group-sync.ts                              # iMessage group <-> trip participant sync
      welcome-message.ts                         # Welcome message template
      vibe-quiz.ts                               # Vibe quiz via text prompts
      proactive-triggers.ts                      # SC-20..22 trigger logic
      duplicate-detector.ts                      # SC-31 expense dedup
    linq-webhook/
      index.ts                                   # Inbound webhook handler (~500 LOC)
    linq-response/
      index.ts                                   # Outbound message sender (~150 LOC)
    linq-delivery-status/
      index.ts                                   # Delivery status handler (~80 LOC)
    close-polls/
      index.ts                                   # Poll closing cron job

__tests__/
  utils/linq/
    intent-processor.test.ts
    action-handlers.test.ts
    response-formatter.test.ts
    group-sync.test.ts
    duplicate-detector.test.ts
    conversation-state.test.ts
  fixtures/
    linq-webhooks/                               # Sample Linq webhook payloads
    nlp-examples.json                            # NLP regression test cases
```

---

## Appendix: Existing Code Reuse Map

| Existing File | Reused For | How |
|---------------|-----------|-----|
| `supabase/functions/inbound-sms/index.ts` | URL extraction, email parsing, image parsing patterns | Extract shared functions to `_shared/` |
| `supabase/functions/send-sms/index.ts` | Outbound queue processing pattern | `linq-response` follows same pattern |
| `supabase/functions/parse-image/index.ts` | Receipt OCR (SC-10) | Called directly from `handleAddExpense` |
| `supabase/functions/scrape-accommodation/index.ts` | URL -> accommodation (SC-19) | Called from `handleAddLink` |
| `supabase/functions/scrape-link/index.ts` | Generic URL parsing (SC-19) | Called from `handleAddLink` |
| `supabase/functions/check-proactive-triggers/index.ts` | Proactive messages (SC-20..22) | Extended with Linq-specific triggers |
| `utils/ledger.ts` | Balance calculations (SC-17) | `calculateBalances()` called server-side |
| `utils/smsIntentDetection.ts` | Regex fallback for NLP | Patterns reused in `intent-processor.ts` |
| `utils/smsCommandHandlers.ts` | Response formatting patterns | Patterns adapted for `action-handlers.ts` |
| `utils/proactiveMessages.ts` | Message templates (SC-20..22) | Templates adapted for Linq format |
