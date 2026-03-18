---
id: p2-linq-imessage
title: "iMessage via Linq"
phase: p2
status: not-started
assignee: asif
priority: 1
dependencies: [p1-claude-connector]
blocked: false
blocked_reason: ""
---

# P2 Scope 1: iMessage via Linq — Spec

> **Phase:** P2
> **Gantt ID:** `p2-linq-imessage`
> **FRD:** `scopes/p2/linq-imessage/frd.md`
> **Comp:** [Poke](https://poke.com/) — iMessage-first AI assistant, also built on Linq. Same playbook but solo/general-purpose. Tryps is group + travel-scoped.

## What

A Tryps travel agent that lives in your iMessage group chat. Add the number, everyone in the chat is on the trip. No app download needed to start planning.

## Why

Trip planning already happens in the group chat. Tryps shouldn't replace that — it should plug into it. The agent captures, organizes, and facilitates so nothing gets lost. The app is the rich layer on top.

## Intent

> "You text this number in a group chat with your three best friends and you're all automatically signed up for Tryps. There's a travel agent in your group chat now. Everything you text writes back to the app. It literally feels like you just texted a new travel agent and now everything is just holding."
>
> "People instantly get it. They're like, 'Oh yeah this is actually helpful.'"
>
> "It should feel like Poke, but for your friend group planning a trip."

## Success Criteria

### Onboarding & Group Setup

- [ ] **SC-1.** A user adds the Tryps number to an existing iMessage group chat. The agent sends a welcome message within 5 seconds — who it is, one example of what to ask, and an App Store link. Verified by: add Tryps number to a 4-person group chat -> agent responds with welcome -> message is under 6 lines.

- [ ] **SC-2.** Everyone in the group chat is automatically part of the trip. No signup, no app download, no email. Verified by: 4 people in group chat, none have the app -> add Tryps number -> all 4 appear as trip members on the backend, linked by phone number.

- [ ] **SC-3.** If someone downloads the app later, all the data from the group chat is already there — expenses, activities, flights, everything. Verified by: Jake texts "$80 for Uber" and "let's do Nobu Friday" in group chat -> downloads app -> opens trip -> sees the expense and the activity.

- [ ] **SC-4.** A person added to the iMessage group joins the trip automatically. Verified by: trip has 4 members -> add Sarah to iMessage group -> Sarah appears as trip member within 10 seconds.

- [ ] **SC-5.** A person who leaves the iMessage group leaves the trip. Verified by: Sarah leaves group chat -> Sarah removed from trip members within 10 seconds.

- [ ] **SC-6.** Early in onboarding, the agent prompts each person to take the trip vibe quiz. If Linq supports native polling, the vibe quiz runs directly in iMessage. If not, the agent sends a deep link into the app or asks the vibe questions as individual text prompts (e.g., "Beach or mountains?" -> user replies "beach"). Verified by: new group with 4 members -> within first 5 minutes, each member receives a vibe quiz prompt -> completing it (in-chat or via app) saves their vibe profile to the trip.

### Expense Tracking via Text

- [ ] **SC-7.** A user texts an expense and the agent logs it. Verified by: Jake texts "I paid $120 for dinner, split 4 ways" -> agent responds "Confirmed, added to expenses" (one line) -> expense shows in app with $30 per person.

- [ ] **SC-8.** The agent asks clarifying questions when the expense is ambiguous. Verified by: Jake texts "I paid for the Uber" (no amount) -> agent asks "How much was it?" -> Jake replies "$45" -> expense logged.

- [ ] **SC-9.** A user texts a custom split and the agent handles it. Verified by: Jake texts "I paid $90 for dinner, split between me Sarah and Tom" -> agent confirms -> expense split 3 ways at $30 each, other group members excluded.

- [ ] **SC-10.** A user sends a receipt photo and the agent extracts the expense. Verified by: Jake sends a photo of a $67.50 restaurant receipt -> agent parses total -> confirms "Got it — $67.50. Who's splitting?" -> Jake replies "everyone" -> expense logged split equally.

### Voting & Polls via Text

- [ ] **SC-11.** A user starts a vote in the group chat. The agent creates a poll and sends numbered options. If Linq supports native polling, the poll uses iMessage's native format. If not, the agent sends a numbered text list and members reply with a number. Verified by: Jake texts "let's vote: Nobu, Zuma, or Komodo" -> agent creates poll -> sends options -> members vote -> votes recorded in app.

- [ ] **SC-12.** A user changes their vote. Verified by: Sarah voted "2" for Zuma -> texts "switch me to Nobu" -> vote updated -> agent confirms.

- [ ] **SC-13.** The agent announces results when a poll closes. Verified by: poll has 4 votes, 48hr window expires -> agent texts group "Zuma won with 3 votes. Added to the itinerary."

- [ ] **SC-14.** Voting works without native polling support. The numbered-reply pattern ("Reply 1, 2, or 3") is the baseline. Architecture is built so native Linq polling plugs in when available — same data, better UX. Verified by: poll created -> agent sends numbered text options -> 3 of 4 members reply with numbers -> votes recorded correctly -> same poll visible in app.

### Trip Planning & Queries via Text

- [ ] **SC-15.** A user adds an activity via text. Verified by: Jake texts "add dinner at Nobu on Friday" -> agent confirms "Added — Nobu, Friday" -> activity appears in app itinerary.

- [ ] **SC-16.** A user asks about the plan and gets a concise answer. Verified by: Sarah texts "what's the plan for Saturday?" -> agent responds with Saturday's itinerary, under 6 lines.

- [ ] **SC-17.** A user asks about balances. Verified by: Tom texts "what do I owe?" -> agent responds with Tom's balance per person (e.g., "You owe Jake $30, Sarah $15").

- [ ] **SC-18.** A user asks who's going. Verified by: Sarah texts "who's going?" -> agent responds with the participant list.

- [ ] **SC-19.** A user pastes a link and the agent captures it. Verified by: Jake pastes an Airbnb listing URL -> agent extracts name, dates, price -> adds to trip as accommodation option -> confirms in chat.

### Proactive Agent Behavior

- [ ] **SC-20.** The agent sends a reminder when arriving at the destination. Verified by: trip start date arrives -> agent texts group "Hey, here's the Airbnb address. It's 45 minutes from the airport." with the actual address.

- [ ] **SC-21.** The agent reminds the group about open votes. Verified by: poll has been open 24hrs with 2 of 5 people not voted -> agent nudges group "2 people still haven't voted on dinner spot — poll closes tomorrow."

- [ ] **SC-22.** The agent sends notifications about trip updates to the group. Verified by: a new expense is added in-app -> agent texts group "{name} added $80 for Uber."

### Agent Message Behavior

- [ ] **SC-23.** Every agent message is 6 lines or fewer. Verified by: trigger 10 different agent responses (expense confirm, vote prompt, itinerary query, etc.) -> none exceeds 6 lines.

- [ ] **SC-24.** The agent sends at most 3 messages in a row before waiting for user input. Verified by: trigger a complex action that could generate multiple responses -> agent sends no more than 3 messages -> waits.

- [ ] **SC-25.** The agent uses 1:1 DMs for private info instead of the group. Verified by: Tom texts "what do I owe?" -> balance response goes to Tom privately, not the group chat.

### Edge Cases & Error States

- [ ] **SC-26.** A group chat with only 2 people (plus the Tryps number). Verified by: add Tryps number to a 2-person chat -> agent handles it via 1:1 messages to each person (Linq requires 3+ for groups).

- [ ] **SC-27.** The agent can't parse what someone said. Verified by: Jake texts "asdfjkl random nonsense" -> agent does NOT respond. It stays quiet on messages it doesn't understand.

- [ ] **SC-28.** A user texts an expense with no trip context (first message ever). Verified by: brand new group, first message is "$50 for gas" -> agent creates the trip first, then logs the expense, confirms both.

- [ ] **SC-29.** The agent is asked something outside its scope. Verified by: Sarah texts "book us a flight to Miami" -> agent responds "I can't book flights yet — coming soon. For now, paste your flight confirmation and I'll track it."

- [ ] **SC-30.** The welcome message names who added the agent and gives everyone a way to remove it. Any group member — not just the person who added it — can text "remove" to kick the agent. Verified by: Jake adds Tryps number -> welcome message includes "Jake added me" and "text REMOVE to kick me out" -> Tom texts "remove" -> agent sends goodbye message and stops responding to this group.

- [ ] **SC-31.** When two expenses with similar descriptions and amounts are logged within 5 minutes, the agent flags the potential duplicate: "Heads up — Jake and Tom both logged ~$120 for dinner. Is this one expense or two?" Verified by: Jake texts "$120 for dinner" -> Tom texts "$120 for dinner" within 2 minutes -> agent asks group to confirm duplicate.

- [ ] **SC-32.** When multiple polls are active, a bare number reply like "2" triggers disambiguation: "Which poll — dinner spot or hotel?" The agent uses labeled prefixes (e.g., "DINNER: Reply D1, D2, D3 / HOTEL: Reply H1, H2, H3") when polls overlap. Verified by: create two polls -> user replies "2" -> agent asks which poll -> user clarifies -> vote recorded correctly.

- [ ] **SC-33.** If the trip owner leaves the iMessage group, trip ownership transfers to another member automatically. Verified by: trip owner Jake leaves group chat -> ownership transfers to the next member (e.g., Sarah) -> Sarah can now manage the trip -> agent confirms ownership transfer to the group.

- [ ] **SC-34.** A user texts the Tryps number in a 1:1 DM (no group). The agent responds as a personal assistant — shows their active trips, lets them query balances across all trips, and offers to create a new trip ("Add me to a group chat with your friends to get started"). Verified by: Jake texts "hey" to Tryps number directly -> agent shows Jake's 3 active trips -> Jake texts "what do I owe across everything?" -> agent responds with balances per trip.

- [ ] **SC-35.** A user can undo or correct the last agent action via text. "Actually $35 not $45" updates the amount. "Delete last expense" removes it. "Change Nobu to Saturday" edits the activity. Verified by: Jake texts "$45 Uber" -> agent confirms -> Jake texts "actually $35" -> agent updates expense to $35 -> confirms new amount -> app shows $35.

### Should NOT Happen

- [ ] **SC-36.** The agent does NOT respond to every message in the group. Normal conversation between friends gets no response. Verified by: send 5 casual messages ("lol", "see you there", "can't wait", a meme, "haha") -> agent stays silent on all 5.

- [ ] **SC-37.** The agent does NOT send walls of text. No message exceeds 6 lines. No more than 3 messages in a row. Verified by: run through all agent response types -> check line counts and message counts.

- [ ] **SC-38.** The agent does NOT announce every background action. If it's silently logging or processing, it stays quiet unless confirmation is needed. Verified by: agent processes 5 link scrapes in a row -> only confirms the ones that resulted in added content, not the processing steps.

- [ ] **SC-39.** Non-trip-members do NOT see trip data. A phone number not in the iMessage group cannot query trip info. Verified by: outsider texts the Tryps number asking "what's the plan for Miami?" -> agent does not reveal trip details.

- [ ] **SC-40.** The iMessage group and the trip membership are always in sync. A user cannot be in the trip but not in the group, or in the group but not in the trip. They move together. Verified by: remove a participant in-app -> they are also removed from the iMessage group (or if Linq can't remove, agent stops tracking them and DMs explanation) -> add someone to iMessage group -> they appear in the trip.

### Out of Scope

- **Agentic execution (booking flights, making reservations)** — Phase 3. Architecture must support plugging this in. The agent says "coming soon" if asked.
- **Agent personality & conversational design** — separate scope. Research needed on how to design the agent's voice, routing architecture, and common conversation patterns. Log conversations from day one to inform this.
- **Android group chat behavior** — open question. iMessage-first for now.
- **Payment processing in-thread** — Phase 3 with x402. For now, expense tracking only.
- **In-app Linq settings/history screens** — separate scope. Ship the agent first.

### Regression Risk

| Area | Why | Risk |
|------|-----|------|
| Expense ledger | Agent writes expenses via same path as app | High |
| Participant list | Group membership syncs from iMessage | High |
| Voting system | Agent creates/manages polls via same tables | Medium |
| Trip itinerary | Agent adds activities to same data | Medium |

- [ ] Typecheck passes

---

## Kickoff Prompt

> Copy and paste this into any Claude Code terminal to run the autonomous scope pipeline for iMessage via Linq. Follow-ups have been routed to ClickUp.

```
Run the autonomous scope pipeline for "iMessage via Linq" (p2-linq-imessage), Steps 3→7.

## Variables

- FEATURE: linq-imessage
- SCOPE_DIR: /Users/jakestein/tryps-docs/scopes/p2/linq-imessage
- BRANCH: feat/linq-imessage
- WORKSTREAM_ID: p2-linq-imessage

## How It Works

Use the **Agent tool** to run each step. Each agent is a full Opus session with its own context.

For each step:
1. **Check if output already exists** and passes verification — if yes, skip to the next step
2. Construct the step prompt using the spec and variables above
3. Spawn an Agent with: `model: "opus"`, `mode: "bypassPermissions"`, the prompt
4. Wait for the agent to complete
5. Verify the output file exists
6. Update Mission Control, print status, move to next step

## Steps

| # | Name | Output | Skip If |
|---|------|--------|---------|
| 3 | Plan | /Users/jakestein/tryps-docs/scopes/p2/linq-imessage/plan.md | Exists and >300 bytes |
| 4 | Work | /Users/jakestein/tryps-docs/scopes/p2/linq-imessage/work-log.md | Exists and branch `feat/linq-imessage` exists |
| 5 | Review | /Users/jakestein/tryps-docs/scopes/p2/linq-imessage/review.md | Exists and not a placeholder |
| 6 | Compound | /Users/jakestein/tryps-docs/scopes/p2/linq-imessage/compound-log.md | Exists and not a placeholder |
| 7 | Agent Ready | /Users/jakestein/tryps-docs/scopes/p2/linq-imessage/agent-ready.md | Contains a PR URL |

### Step 3 (Plan) Context
Read the spec at SCOPE_DIR/spec.md. Every unchecked success criterion (SC-1 through SC-40) is a task. Skip items marked [NEEDS DESIGN]. Group related criteria by subsystem (onboarding & group setup, expense tracking, voting & polls, trip planning & queries, proactive agent behavior, message behavior, edge cases). Write the plan to SCOPE_DIR/plan.md.

### Step 4 (Work) Context
Implement every task from the plan. Run `npm run typecheck` after each change. Commit after each fix with format "feat(linq): short description". Check off each criterion in the spec as it's completed. Write progress to SCOPE_DIR/work-log.md.

### Step 5 (Review) Context
Review all changes on BRANCH against the spec criteria. Flag anything that doesn't match the "Verified by:" test. Write SCOPE_DIR/review.md. If review says FAIL, re-run Steps 4→5. Max 2 retries.

### Step 6 (Compound) Context
Document any patterns, gotchas, or reusable solutions discovered during work. Write SCOPE_DIR/compound-log.md.

### Step 7 (Agent Ready) Context
Create PR targeting `develop` with title "[P2] iMessage via Linq — agent in group chat, expenses, voting, planning". Request review from `asifraza1013` and `Nadimkhan120`. Write SCOPE_DIR/agent-ready.md with PR URL and summary.

## After Each Step

```bash
curl -s -X PATCH -H "x-api-key: $(cat ~/.mission-control-api-key)" -H "Content-Type: application/json" "https://marty.jointryps.com/api/workstreams/p2-linq-imessage/pipeline/{step_key}" -d '{"status": "complete"}'
```

Print: `[pipeline] ✓ Step N: {name} complete` or `[pipeline] ✗ Step N: {name} FAILED`

## Rules

- Do NOT open files in Marked 2 during Steps 3-6. Only open agent-ready.md after Step 7.
- Do NOT ask me anything. Run all steps autonomously.
- Each agent prompt must include: "Do NOT open files with open -a. Write files only."
- Skip criteria marked [NEEDS DESIGN] — those require Figma work first.

## After Step 7

Print the final report with all artifact paths and PR URL.
Open /Users/jakestein/tryps-docs/scopes/p2/linq-imessage/agent-ready.md in Marked 2.
```
