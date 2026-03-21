---
id: imessage-agent
title: "iMessage Agent"
status: specced
assignee: asif
wave: 1
dependencies: [brand-design-system]
clickup_ids: ["86e0emu7g", "86e0f948t"]
criteria_count: 51
criteria_done: 0
last_updated: 2026-03-21
links:
  design: ./design.md
  testing: ./testing.md
  objective: ./objective.md
  state: ./state.md
  voice_guide: ./voice-guide.md
---

# iMessage Agent — Spec

## What

A Tryps travel agent in your iMessage group chat via Linq. Add the number, everyone's on the trip. Expenses, voting, trip queries, proactive facilitation, and a personality that passes the Jennifer Test, all without requiring the app.

## Why

iMessage is acquisition. The app is retention. The agent is the "holy shit" moment, the first time someone texts with it and realizes this isn't a bot, it's a travel agent. This is the Partiful playbook applied to travel: one person adds it, everyone experiences it, some download the app.

## Intent

> "You text this number in a group chat with your three best friends and you're all automatically signed up for Tryps. There's a travel agent in your group chat now. Everything you text writes back to the app. It literally feels like you just texted a new travel agent and now everything is just holding."
>
> "The Turing test is: if you told your grandmother this was a human travel agent named Jennifer, she would 1000% believe it. If grandma can't tell it's AI, we win."

## Key Concepts

**Jennifer Test:** If you told your grandmother the agent was a human travel agent named Jennifer, she would 100% believe it. The bar for April 2: a written voice guide the system prompt follows, behavioral tests where strangers can't tell it's AI, and Jake reviews a conversation transcript and approves it.

**System Prompt Architecture:** Three layers: (1) routing logic (when the agent speaks vs. stays silent), (2) persona instructions (voice, tone, personality), (3) context window management (trip data, user data, conversation history). Must be modular so memory and intelligence plug in later.

**85/15 Rule:** 85% reactive and helpful. 15% personality, a witty concierge who occasionally drops a one-liner. Never gimmicky. Never performing.

**Routing Principle:** The agent responds only when directly addressed or when it detects actionable travel intent. Normal friend conversation gets silence.

---

## Success Criteria

### Onboarding & Group Setup

- [ ] **SC-1.** A user adds the Tryps number to an existing iMessage group chat. The agent sends a welcome message within 5 seconds: who it is, one example of what to ask, and a prompt to get started. Verified by: add Tryps number to a 4-person group chat -> agent responds with welcome -> message arrives as 2-3 short texts, not one wall.

- [ ] **SC-2.** Everyone in the group chat is automatically part of the trip. No signup, no app download, no email. Verified by: 4 people in group chat, none have the app -> add Tryps number -> all 4 appear as trip members on the backend, linked by phone number.

- [ ] **SC-3.** If someone downloads the app later, all the data from the group chat is already there, expenses, activities, flights, everything. Verified by: Jake texts "$80 for Uber" and "let's do Nobu Friday" in group chat -> downloads app -> opens trip -> sees the expense and the activity.

- [ ] **SC-4.** A person added to the iMessage group joins the trip automatically. Verified by: trip has 4 members -> add Sarah to iMessage group -> Sarah appears as trip member within 10 seconds.

- [ ] **SC-5.** A person who leaves the iMessage group leaves the trip. Verified by: Sarah leaves group chat -> Sarah removed from trip members within 10 seconds.

- [ ] **SC-6.** Early in onboarding, the agent prompts each person to take the trip vibe quiz. If Linq supports native polling, the vibe quiz runs directly in iMessage. If not, the agent sends a deep link into the app or asks the vibe questions as individual text prompts (e.g., "beach or mountains?" -> user replies "beach"). Verified by: new group with 4 members -> within first 5 minutes, each member receives a vibe quiz prompt -> completing it (in-chat or via app) saves their vibe profile to the trip.

### Expense Tracking via Text

- [ ] **SC-7.** A user texts an expense and the agent logs it. Verified by: Jake texts "I paid $120 for dinner, split 4 ways" -> agent responds "got it, $120 for dinner, split 4 ways" (one short text) -> expense shows in app with $30 per person.

- [ ] **SC-8.** The agent asks clarifying questions when the expense is ambiguous. Verified by: Jake texts "I paid for the Uber" (no amount) -> agent asks "how much was it?" -> Jake replies "$45" -> expense logged.

- [ ] **SC-9.** A user texts a custom split and the agent handles it. Verified by: Jake texts "I paid $90 for dinner, split between me Sarah and Tom" -> agent confirms -> expense split 3 ways at $30 each, other group members excluded.

- [ ] **SC-10.** A user sends a receipt photo and the agent extracts the expense. Verified by: Jake sends a photo of a $67.50 restaurant receipt -> agent parses total -> confirms "got it, $67.50. who's splitting?" -> Jake replies "everyone" -> expense logged split equally.

### Voting & Polls via Text

- [ ] **SC-11.** A user starts a vote in the group chat. The agent creates a poll and sends numbered options. If Linq supports native polling, the poll uses iMessage's native format. If not, the agent sends a numbered text list and members reply with a number. Verified by: Jake texts "let's vote: Nobu, Zuma, or Komodo" -> agent creates poll -> sends options -> members vote -> votes recorded in app.

- [ ] **SC-12.** A user changes their vote. Verified by: Sarah voted "2" for Zuma -> texts "switch me to Nobu" -> vote updated -> agent confirms.

- [ ] **SC-13.** The agent announces results when a poll closes. Verified by: poll has 4 votes, 48hr window expires -> agent texts group "Zuma won, 3 to 1. added to Friday night"

- [ ] **SC-14.** Voting works without native polling support. The numbered-reply pattern ("reply 1, 2, or 3") is the baseline. Architecture is built so native Linq polling plugs in when available, same data, better UX. Verified by: poll created -> agent sends numbered text options -> 3 of 4 members reply with numbers -> votes recorded correctly -> same poll visible in app.

### Trip Planning & Queries via Text

- [ ] **SC-15.** A user adds an activity via text. Verified by: Jake texts "add dinner at Nobu on Friday" -> agent confirms "added, Nobu, Friday" -> activity appears in app itinerary.

- [ ] **SC-16.** A user asks about the plan and gets a concise answer. Verified by: Sarah texts "what's the plan for Saturday?" -> agent responds with Saturday's itinerary, under 6 lines.

- [ ] **SC-17.** A user asks about balances. Verified by: Tom texts "what do I owe?" -> agent responds with Tom's balance per person (e.g., "you owe Jake $30, Sarah $15").

- [ ] **SC-18.** A user asks who's going. Verified by: Sarah texts "who's going?" -> agent responds with the participant list.

- [ ] **SC-19.** A user pastes a link and the agent captures it. Verified by: Jake pastes an Airbnb listing URL -> agent extracts name, dates, price -> adds to trip as accommodation option -> confirms in chat.

### Proactive Agent Behavior

- [ ] **SC-20.** The agent sends a reminder when arriving at the destination. Verified by: trip start date arrives -> agent texts group with the Airbnb address and distance from the airport.

- [ ] **SC-21.** The agent reminds the group about open votes. Verified by: poll has been open 24hrs with 2 of 5 people not voted -> agent nudges group "2 people haven't voted on dinner yet, poll closes tomorrow"

- [ ] **SC-22.** The agent sends notifications about trip updates to the group. Verified by: a new expense is added in-app -> agent texts group "{name} added $80 for Uber"

- [ ] **SC-23.** The agent surfaces when it detects an opportunity in group conversation. Verified by: someone texts "Yo we should go to the club at midnight" -> agent responds "I can look into tickets for that if you want" -> does NOT interrupt if the message has no actionable travel intent.

- [ ] **SC-24.** The agent nudges the group when planning has stalled. Verified by: no trip-related activity in the group for 3+ days -> agent sends a single nudge that includes what's needed next (e.g., "3 days since anyone's touched this trip. still need to pick dates, want me to throw up a vote?") -> does NOT nudge again for at least 3 more days.

- [ ] **SC-25.** The agent suggests next steps based on the planning funnel (vibe -> needs -> facilitation -> booking). Verified by: group has completed vibe quiz but hasn't picked dates -> agent suggests "everyone's vibes are in, want to vote on dates next?" -> suggestion matches the logical next step in the funnel.

### Agent Personality & Jennifer Test

- [ ] **SC-26.** A voice & tone guide exists as a copy doc that defines the agent's personality, phrasing patterns, banned words/phrases, messaging-native rules, and boundaries. The system prompt references it directly. Verified by: document exists (voice-guide.md), system prompt includes its directives, and agent responses match the guide's examples.

- [ ] **SC-27.** The agent's personality follows the 85/15 rule: 85% reactive and helpful, 15% personality. Verified by: review 20 agent responses across different scenarios -> 17+ are purely functional, 1-3 include a subtle personality touch (observation, warm aside) -> zero are gimmicky or try-hard.

- [ ] **SC-28.** The agent passes the Jennifer Test in a blind review. Verified by: show 10 agent conversation excerpts to someone who doesn't know it's AI -> they believe it's a human travel agent named Jennifer -> if they identify it as AI on more than 2 of 10, it fails.

- [ ] **SC-29.** Jake reviews a full conversation transcript (trip setup through planning through proactive nudges) and approves it as passing the Jennifer Test. Verified by: Jake says "this passes."

- [ ] **SC-30.** The agent never uses gimmicky language, emojis, slang, em-dashes, or AI-tell phrases (see Kill List in voice-guide.md). It matches the brand voice: warm, casual, inviting, like a text from your most organized friend. Verified by: review 20 agent responses -> zero contain banned words/phrases from the Kill List -> tone is consistent across all responses.

- [ ] **SC-31.** The agent handles tension gracefully. When someone is difficult ("I don't care, stop asking me"), the agent de-escalates: acknowledges, moves on, doesn't push. Verified by: send 3 hostile/dismissive messages -> agent responds warmly and briefly or stays silent -> never argues, never guilt-trips, never gets defensive.

### System Prompt Architecture

- [ ] **SC-32.** The system prompt is modular: separate sections for persona/voice, routing logic, trip context, and user context. Verified by: code review shows the system prompt is assembled from distinct, labeled components, not a single monolithic string.

- [ ] **SC-33.** The system prompt includes current trip data (dates, destination, itinerary, expenses, participants, open votes) so the agent can answer queries without additional API calls. Verified by: ask 5 trip-specific questions -> agent answers all correctly from context -> no hallucinated trip data.

- [ ] **SC-34.** The architecture supports plugging in per-user and per-trip memory later (scope 8). Verified by: code review shows clear extension points where user preferences and trip history would be injected into the system prompt, even if not populated yet.

### Agent Message Behavior

- [ ] **SC-35.** Every agent message is 6 lines or fewer. Verified by: trigger 10 different agent responses (expense confirm, vote prompt, itinerary query, etc.) -> none exceeds 6 lines.

- [ ] **SC-36.** The agent sends at most 3 messages in a row before waiting for user input. Verified by: trigger a complex action that could generate multiple responses -> agent sends no more than 3 messages -> waits.

- [ ] **SC-37.** The agent uses 1:1 DMs for private info instead of the group. Verified by: Tom texts "what do I owe?" -> balance response goes to Tom privately, not the group chat.

### Edge Cases & Error States

- [ ] **SC-38.** A group chat with only 2 people (plus the Tryps number). Verified by: add Tryps number to a 2-person chat -> agent handles it via 1:1 messages to each person (Linq requires 3+ for groups).

- [ ] **SC-39.** The agent can't parse what someone said. Verified by: Jake texts "asdfjkl random nonsense" -> agent does NOT respond. It stays quiet on messages it doesn't understand.

- [ ] **SC-40.** A user texts an expense with no trip context (first message ever). Verified by: brand new group, first message is "$50 for gas" -> agent creates the trip first, then logs the expense, confirms both.

- [ ] **SC-41.** The agent is asked something outside its scope. Verified by: Sarah texts "book us a flight to Miami" -> agent responds "can't book flights yet, coming soon. paste your confirmation and I'll track it"

- [ ] **SC-42.** When two expenses with similar descriptions and amounts are logged within 5 minutes, the agent flags the potential duplicate. Verified by: Jake texts "$120 for dinner" -> Tom texts "$120 for dinner" within 2 minutes -> agent asks group to confirm duplicate.

- [ ] **SC-43.** When multiple polls are active, a bare number reply triggers disambiguation. Verified by: create two polls -> user replies "2" -> agent asks which poll -> user clarifies -> vote recorded correctly.

- [ ] **SC-44.** If the trip owner leaves the iMessage group, trip ownership transfers to another member automatically. Verified by: trip owner Jake leaves group chat -> ownership transfers to Sarah -> agent confirms to group.

- [ ] **SC-45.** A user texts the Tryps number in a 1:1 DM (no group). The agent responds as a personal assistant: shows active trips, lets them query balances, offers to create a new trip. Verified by: Jake texts "hey" to Tryps number directly -> agent shows Jake's 3 active trips -> Jake texts "what do I owe across everything?" -> agent responds with balances per trip.

- [ ] **SC-46.** A user can undo or correct the last agent action via text. Verified by: Jake texts "$45 Uber" -> agent confirms -> Jake texts "actually $35" -> agent updates expense to $35 -> confirms -> app shows $35.

### Should NOT Happen

- [ ] **SC-47.** The agent does NOT respond to every message in the group. Normal conversation between friends gets no response. The agent only responds when directly addressed or when it detects actionable travel intent. Verified by: send 5 casual messages ("lol", "see you there", "can't wait", a meme, "haha") -> agent stays silent on all 5.

- [ ] **SC-48.** The agent does NOT send walls of text. No message exceeds 6 lines. No more than 3 messages in a row. Verified by: run through all agent response types -> check line counts and message counts.

- [ ] **SC-49.** The agent does NOT announce every background action. If it's silently logging or processing, it stays quiet unless confirmation is needed. Verified by: agent processes 5 link scrapes -> only confirms the ones that resulted in added content.

- [ ] **SC-50.** Non-trip-members do NOT see trip data. Verified by: outsider texts the Tryps number asking "what's the plan for Miami?" -> agent does not reveal trip details.

- [ ] **SC-51.** The iMessage group and the trip membership are always in sync. Verified by: remove a participant in-app -> they are removed from the iMessage group (or agent stops tracking them and DMs explanation) -> add someone to iMessage group -> they appear in the trip.

---

## Out of Scope

- **Agentic booking execution** (booking flights, making reservations): scope 10 (Travel Booking). Agent says "coming soon" if asked.
- **Per-user and per-trip memory**: scope 8 (Agent Intelligence). Architecture must support plugging it in.
- **Claude MCP Connector** (Claude's "Connect your apps" integration): scope 8. Totally separate from the iMessage agent backend.
- **Android group chat support**: post-April 2.
- **Payment processing in-thread**: scope 9 (Payments Infrastructure). For now, expense tracking only.
- **Daily/morning trip summaries**: cut from April 2 (too likely to annoy).
- **In-app Linq settings/history screens**: post-April 2.
- **Agent removal mechanic** (text REMOVE to kick agent): TBD, may not be technically possible via Linq. Deferred.

## Regression Risk

| Area | Why | Risk |
|------|-----|------|
| Expense ledger | Agent writes expenses via same path as app | High |
| Participant list | Group membership syncs from iMessage | High |
| Voting system | Agent creates/manages polls via same tables | Medium |
| Trip itinerary | Agent adds activities to same data | Medium |
| System prompt | Changes to prompt architecture affect all agent behavior | High |

## Dependencies

| Scope | What's Needed | Blocks |
|-------|--------------|--------|
| brand-design-system (#11) | Voice & tone guide (copy doc) | SC-26 through SC-31 (personality). Draft complete. |
| agent-intelligence (#8) | Memory architecture (per-user, per-trip) | Future upgrade, architect for it now |

## References

- Old spec: `scopes - deprecated/p2/linq-imessage/spec.md` (40 criteria, all migrated, 11 new added)
- Voice guide: `scopes - refined 3-20/imessage-agent/voice-guide.md` (copy doc, drafted)
- Strategy intake: `docs/p2-p3-strategy-intake.md` (Q5-Q10: iMessage agent vision)
- Brand strategy: `shared/brand-strategy.md` (voice, tone, personality)
- Brand tokens: `shared/brand.md` (word lists, copy rules)

---

## Kickoff Prompt

> Copy and paste this into any Claude Code terminal to run the scope pipeline for iMessage Agent.

```
Run the autonomous scope pipeline for "iMessage Agent" (imessage-agent).

## Variables

- FEATURE: imessage-agent
- SCOPE_DIR: /Users/jakestein/tryps-docs/scopes - refined 3-20/imessage-agent
- BRANCH: feat/imessage-agent
- WORKSTREAM_ID: imessage-agent

## Context

Read these files first:
1. SCOPE_DIR/spec.md (51 success criteria)
2. SCOPE_DIR/objective.md (key concepts, wave assignment)
3. SCOPE_DIR/voice-guide.md (voice & tone copy doc)
4. SCOPE_DIR/design.md (what's blocked on design)
5. ~/tryps-docs/shared/brand-strategy.md (voice & tone reference)
6. ~/tryps-docs/docs/p2-p3-strategy-intake.md (Q5-Q10 for agent vision)

## Steps

| # | Name | Output | Skip If |
|---|------|--------|---------|
| 1 | Plan | SCOPE_DIR/plan.md | Exists and >300 bytes |
| 2 | Work | SCOPE_DIR/work-log.md | Exists and branch exists |
| 3 | Review | SCOPE_DIR/review.md | Exists and not a placeholder |
| 4 | Compound | SCOPE_DIR/compound-log.md | Exists and not a placeholder |
| 5 | Agent Ready | SCOPE_DIR/agent-ready.md | Contains a PR URL |

### Plan Context
Every unchecked SC-1 through SC-51 is a task. Group by subsystem. Write plan to SCOPE_DIR/plan.md.

### Work Context
Implement every task. Run typecheck after each change. Commit with "feat(imessage-agent): short description". Write progress to SCOPE_DIR/work-log.md.

### Review Context
Review all changes against spec criteria. Flag anything that doesn't match "Verified by" tests. Write SCOPE_DIR/review.md.

### Compound Context
Document patterns, gotchas, reusable solutions. Write SCOPE_DIR/compound-log.md.

### Agent Ready Context
Create PR targeting develop. Title: "iMessage Agent: Jennifer Test, expenses, voting, proactive facilitation". Request review from asifraza1013 and Nadimkhan120. Write SCOPE_DIR/agent-ready.md with PR URL.

## Rules

- Do NOT open files in Marked 2 during Steps 1-4.
- Do NOT ask me anything. Run autonomously.
- The voice-guide.md is the source of truth for all agent copy and personality decisions.
```
