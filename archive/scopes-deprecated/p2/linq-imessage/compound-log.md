# P2 Linq iMessage — Compound Log

> Patterns, gotchas, and reusable solutions from implementation

## Reusable Patterns

### Transport Abstraction Layer
The `MessageTransport` interface (`message-transport.ts`) decouples all handler logic from the delivery mechanism. The interface has four methods: `send`, `sendToGroup`, `verifyWebhook`, `parseInbound`. Every handler works with `InboundMessage` and `ActionResult` types — never with Linq-specific payloads. This means adding a Twilio or WhatsApp transport later requires zero changes to intent processing, action handlers, or response formatting. Future integrations should follow this pattern: define an interface at the boundary, implement per-provider, keep business logic transport-agnostic.

### NLP with Regex Fallback
`intent-processor.ts` uses Claude Haiku as the primary classifier but falls back to regex patterns on API failure. The regex layer covers all 14+ intents with reasonable accuracy. This dual-layer approach guarantees zero downtime for the messaging pipeline even if the Anthropic API is unreachable. The pattern: try the smart path, catch errors, fall back to deterministic heuristics, never throw to the user.

### Phantom Participant Pattern
`user-resolver.ts` creates "phantom" participants for phone numbers without Tryps accounts. These participants get real `participants` table rows with `is_phantom = TRUE` and `linq_phone` set. A DB trigger (`link_linq_pending_user`) on `user_profiles` automatically links phantoms to real accounts when a user signs up with a matching phone number. The key insight: all business logic (expenses, polls, activities) references `participant_id`, which persists through the phantom-to-real transition. No data migration needed on signup.

### Multi-Turn Conversation State
`conversation-state.ts` uses a `pending_action` JSONB column keyed by `(phone_number, conversation_id)` to track incomplete multi-turn flows. A 15-minute timeout automatically clears stale state. The pattern: set `pendingAction` when you need more info, check for it before NLP classification on the next message, clear it on completion or timeout. This avoids the complexity of a full state machine while supporting clarifying questions, poll disambiguation, and vibe quiz flows.

### Response Constraint Pipeline
`response-formatter.ts` applies two hard limits to every outbound message: 6-line max per message (truncates with "...check the app for more.") and 3-message max per batch (combines overflow). These constraints are applied uniformly via `formatResponse()` — individual handlers never need to worry about message length. Future messaging features should route through this same formatter.

### Conversation-to-Trip Auto-Creation
`trip-resolver.ts` auto-creates a trip when a message arrives from an unknown `conversation_id`. The first message in any group chat creates the trip, maps the conversation, syncs all participants, and sends a welcome — all in one webhook invocation. This eliminates any setup friction. The pattern: resolve-or-create at the boundary, then all downstream handlers can assume a valid trip context.

## Gotchas

### HMAC Verification Consumes the Request Body
`LinqTransport.verifyWebhook()` must clone the request (`req.clone()`) before reading the body for signature verification. The webhook handler then reads `req.json()` separately. If you forget to clone, the body stream is consumed and the second read fails silently or throws. This is a Deno/Web Streams API footgun — always `req.clone()` when you need to read the body more than once.

### Phone Number Normalization Variants
`user-resolver.ts` checks four phone number variants when looking up users: the normalized E.164, the raw input, and both with `+1` stripped. This is necessary because user_profiles may store phone numbers inconsistently (with or without country code, with or without `+`). The `phoneHelpers.ts` utility handles normalization, but lookups must still check multiple formats because the DB may contain any variant.

### RLS Policy for Service-Role-Only Tables
All `linq_*` tables use `auth.role() = 'service_role'` for both USING and WITH CHECK. This is correct for tables that only edge functions access, but it means the Supabase client in the app (which uses `anon` key) cannot read these tables at all. If you later need client-side access (e.g., showing message history in-app), you need to add a separate SELECT policy with user-scoped filtering, similar to what was done for `polls` and `poll_votes`.

### Missing RPCs Referenced in Code
`linq_add_conversation_to_pending` and `increment_linq_message_count` are called in application code but never defined in the migration. They are wrapped in `.catch()` so they fail silently, but this means `linq_pending_users.message_count` and `conversation_ids` array will never update. Lesson: grep the codebase for all `.rpc()` calls before finalizing a migration, and either create the RPCs or remove the calls.

### DB Trigger Depends on Pre-Existing Table
The `notify_linq_expense_added` trigger inserts into `outbound_sms_queue`, which is assumed to exist from a prior migration. If that table does not exist, the trigger will fail on every expense insert — and since it is an AFTER INSERT trigger, it could cause expense creation to appear successful while silently failing the notification. Always verify cross-table dependencies in triggers, and use `IF EXISTS` checks in trigger functions for non-critical side effects.

### `req.json()` Called Twice in Webhook Handler
The webhook handler calls `transport.verifyWebhook(req.clone())` and then `req.json()` separately, but `transport.parseInbound()` (which also does `req.json()`) is not used — the handler manually destructures the event data instead. This creates a subtle inconsistency: if the `LinqWebhookEvent` type changes, you need to update both `parseInbound()` and the manual destructuring in the webhook handler. Prefer using `parseInbound()` everywhere and passing the parsed message downstream.

### Vibe Quiz Trigger Never Wired
`generateVibeQuizPrompt()` is fully implemented but never called during onboarding. The welcome message flow in `intent-router.ts` sends the welcome but does not follow up with vibe quiz prompts. The handler for answering the quiz works, but there is no trigger to start it. This is a pattern to watch: building handler + response logic without wiring the trigger/initiation path.

### Media URL Not Checked in Intent Router
`intent-router.ts` passes only `message.body` to `processIntent()`. When a user sends a photo, `message.mediaUrl` is present but ignored. The receipt parsing flow (SC-10) has the multi-turn completion handler but no initiation path. Always check for media attachments before text classification — a photo with no body text should still be actionable.

## Key Decisions

### Single Foundation Commit Instead of Phased Delivery
The plan specified 8 subsystem phases, but implementation was done in a single commit. Rationale: the handler logic is tightly coupled to shared modules (intent processor, conversation state, response formatter). Building stubs and filling them in across 8 phases would have created more merge conflicts and wasted effort on interface contracts that would change. The dependency graph was followed — modules were built bottom-up — but delivered atomically.

### Claude Haiku for NLP, Not a Custom Model
Selected `claude-haiku-4-20250414` for intent classification. It is fast (~200ms), cheap, and the system prompt with trip context (participant names, active polls) gives it enough information to resolve ambiguous references. A custom fine-tuned model would have better accuracy on edge cases but adds training pipeline complexity that is not justified at this scale. The regex fallback covers the gap.

### Service-Role-Only RLS for Infrastructure Tables
Linq infrastructure tables (`linq_conversations`, `linq_messages`, `linq_conversation_state`, `linq_pending_users`) are restricted to `service_role` only. This is a security-first decision: these tables contain phone numbers and full message content. Client-side access goes through existing tables (`participants`, `expenses`, `polls`) that have proper user-scoped RLS. The messaging layer is a server-side concern.

### Conversation State Timeout (15 Minutes)
Multi-turn flows expire after 15 minutes of inactivity. This is shorter than a typical "session timeout" because iMessage conversations are bursty — if someone starts an expense but does not finish, it is better to reset after 15 minutes than to surprise them with a stale prompt hours later. The timeout is checked on every `getState()` call, not via a cron job.

### Phone Number as Primary Key for Voting
`poll_votes` uses `UNIQUE(poll_id, phone_number)` rather than `UNIQUE(poll_id, user_id)`. This is necessary because phantom participants (no Tryps account) can vote. Phone numbers are the universal identifier in the Linq context. The `upsert` on this constraint naturally handles vote changes (SC-12) without separate update logic.

### Polls Table Separate from Existing Survey/Vote Infra
A new `polls` table was created rather than reusing any existing voting infrastructure. Rationale: Linq polls are text-driven, phone-number-keyed, and have auto-close behavior. They need `conversation_id`, `closes_at`, and phone-based votes — none of which fit the existing data model. The trade-off is some duplication, but the independence avoids coupling the iMessage feature to unrelated code.

## What Worked Well

### 15 Shared Modules with Clear Responsibilities
Each module in `_shared/` has a single, well-scoped responsibility: types, transport, user resolution, trip resolution, conversation state, intent processing, intent routing, action handlers, response formatting, welcome messages, group sync, vibe quiz, duplicate detection, proactive triggers. This made the code reviewable and testable in isolation. The import graph is clean and acyclic.

### Existing Edge Function Reuse
Receipt parsing reuses `parse-image`, link scraping reuses `scrape-accommodation` and `scrape-link`, phone normalization reuses `phoneHelpers.ts`. No duplicate business logic was created. This saved significant implementation time and ensures behavior consistency between the app and iMessage interfaces.

### Type Safety Throughout
Full TypeScript types for all webhook payloads, internal messages, action results, and conversation state. No use of `any`. Union types for event types, intent types, delivery statuses, and poll statuses. The `IntentResult` and `ActionResult` interfaces create a clean contract between the NLP layer and the handler layer.

### Idempotent Participant Resolution
`resolveParticipantForTrip()` is safe to call multiple times for the same phone + trip. It checks by `user_id` first, then by `linq_phone`, and only creates if neither match. This means `syncGroupMembers()` can be called on every message without creating duplicates — important because Linq sends the full participant list with every event.

### Comprehensive Regex Fallback
The regex fallback in `intent-processor.ts` covers all 14+ intents with sensible patterns. It even handles partial expenses (bare `$35` messages) and casual chat detection (emoji-only, slang like "bet", "fire", "no cap"). This means the system degrades gracefully rather than catastrophically when Claude API is unavailable.

## What Could Be Better

### Missing Integration Wiring
Three features have handler logic but no trigger: vibe quiz prompt (SC-6), proactive reminders (SC-20/21), and receipt photo parsing (SC-10). The pattern of building the handler without the trigger should be caught in review. A checklist item: "Is the initiation path implemented, not just the handler?"

### Bidirectional Sync Not Implemented
Participant sync is one-directional: iMessage group changes sync to trips, but in-app changes do not sync back to Linq. This was called out in the plan but deferred. A DB trigger on `participants` DELETE could insert into `outbound_sms_queue` with a notification, similar to the expense notification trigger.

### No Automated Tests
The implementation passes typecheck but has no unit or integration tests. The intent processor regex layer is highly testable — it is a pure function with string input and structured output. The duplicate detector similarity functions are also pure and testable. Adding tests for these would provide high confidence with low effort.

### Webhook Handler Duplicates Parsing Logic
The `linq-webhook/index.ts` handler manually destructures the event data instead of using `transport.parseInbound()`. This creates two places to update if the payload format changes. The handler should use `parseInbound()` and pass the resulting `InboundMessage` to `routeIntent()`.

### 2-Person Chat Edge Case Unhandled
Linq requires 3+ participants for group chats. A 2-person chat would arrive as `isGroup: false`, which routes to personal assistant mode instead of trip planning mode. The spec calls for handling this via 1:1 messages to each person, but no special-case logic exists. This is a Linq platform constraint that needs a workaround.

### Proactive Triggers Need a Cron Home
`checkLinqProactiveTriggers()` exists but is not called by any scheduled function. The `close-polls` cron is the natural home — it already runs hourly and handles poll lifecycle. Adding a call to `checkLinqProactiveTriggers()` at the end of that function would wire up arrival reminders and poll nudges.

## Reusable Modules

| Module | Path | What It Does | Reuse Potential |
|--------|------|-------------|-----------------|
| `message-transport.ts` | `supabase/functions/_shared/` | Transport-agnostic messaging interface | Any new messaging channel (Twilio SMS, WhatsApp, Slack) |
| `linq-transport.ts` | `supabase/functions/_shared/` | Linq API client + HMAC verification | Template for any HMAC-signed webhook integration |
| `intent-processor.ts` | `supabase/functions/_shared/` | Claude Haiku NLP + regex fallback | Any text-based command interface (Slack bot, in-app chat) |
| `response-formatter.ts` | `supabase/functions/_shared/` | Line/message limit enforcement | Any channel with message length constraints |
| `duplicate-detector.ts` | `supabase/functions/_shared/` | Expense dedup (time window + fuzzy match) | Any feature that creates records from natural language input |
| `conversation-state.ts` | `supabase/functions/_shared/` | Multi-turn state with timeout | Any multi-step flow over messaging (onboarding, surveys) |
| `user-resolver.ts` | `supabase/functions/_shared/` | Phone-to-user resolution + phantom creation | Any feature that needs to bridge phone numbers to accounts |
| `group-sync.ts` | `supabase/functions/_shared/` | External group membership sync + ownership transfer | Any external platform integration with group concepts |
| `proactive-triggers.ts` | `supabase/functions/_shared/` | Time-based trigger checks for conversations | Any scheduled messaging feature (reminders, nudges) |
| `welcome-message.ts` | `supabase/functions/_shared/` | Onboarding message generation | Template for branded first-contact messages |
