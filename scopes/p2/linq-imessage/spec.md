---
feature: iMessage via Linq
date: 2026-03-15
status: draft
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

- [ ] A user adds the Tryps number to an existing iMessage group chat. The agent sends a welcome message within 5 seconds — who it is, one example of what to ask, and an App Store link. Verified by: add Tryps number to a 4-person group chat -> agent responds with welcome -> message is under 6 lines.

- [ ] Everyone in the group chat is automatically part of the trip. No signup, no app download, no email. Verified by: 4 people in group chat, none have the app -> add Tryps number -> all 4 appear as trip members on the backend, linked by phone number.

- [ ] If someone downloads the app later, all the data from the group chat is already there — expenses, activities, flights, everything. Verified by: Jake texts "$80 for Uber" and "let's do Nobu Friday" in group chat -> downloads app -> opens trip -> sees the expense and the activity.

- [ ] A person added to the iMessage group joins the trip automatically. Verified by: trip has 4 members -> add Sarah to iMessage group -> Sarah appears as trip member within 10 seconds.

- [ ] A person who leaves the iMessage group leaves the trip. Verified by: Sarah leaves group chat -> Sarah removed from trip members within 10 seconds.

### Expense Tracking via Text

- [ ] A user texts an expense and the agent logs it. Verified by: Jake texts "I paid $120 for dinner, split 4 ways" -> agent responds "Confirmed, added to expenses" (one line) -> expense shows in app with $30 per person.

- [ ] The agent asks clarifying questions when the expense is ambiguous. Verified by: Jake texts "I paid for the Uber" (no amount) -> agent asks "How much was it?" -> Jake replies "$45" -> expense logged.

- [ ] A user texts a custom split and the agent handles it. Verified by: Jake texts "I paid $90 for dinner, split between me Sarah and Tom" -> agent confirms -> expense split 3 ways at $30 each, other group members excluded.

- [ ] A user sends a receipt photo and the agent extracts the expense. Verified by: Jake sends a photo of a $67.50 restaurant receipt -> agent parses total -> confirms "Got it — $67.50. Who's splitting?" -> Jake replies "everyone" -> expense logged split equally.

### Voting & Polls via Text

- [ ] A user starts a vote in the group chat. Verified by: Jake texts "let's vote: Nobu, Zuma, or Komodo" -> agent creates poll -> sends numbered options to the group -> members reply with a number -> votes recorded in app.

- [ ] A user changes their vote. Verified by: Sarah voted "2" for Zuma -> texts "switch me to Nobu" -> vote updated -> agent confirms.

- [ ] The agent announces results when a poll closes. Verified by: poll has 4 votes, 48hr window expires -> agent texts group "Zuma won with 3 votes. Added to the itinerary."

### Trip Planning & Queries via Text

- [ ] A user adds an activity via text. Verified by: Jake texts "add dinner at Nobu on Friday" -> agent confirms "Added — Nobu, Friday" -> activity appears in app itinerary.

- [ ] A user asks about the plan and gets a concise answer. Verified by: Sarah texts "what's the plan for Saturday?" -> agent responds with Saturday's itinerary, under 6 lines.

- [ ] A user asks about balances. Verified by: Tom texts "what do I owe?" -> agent responds with Tom's balance per person (e.g., "You owe Jake $30, Sarah $15").

- [ ] A user asks who's going. Verified by: Sarah texts "who's going?" -> agent responds with the participant list.

- [ ] A user pastes a link and the agent captures it. Verified by: Jake pastes an Airbnb listing URL -> agent extracts name, dates, price -> adds to trip as accommodation option -> confirms in chat.

### Proactive Agent Behavior

- [ ] The agent sends a reminder when arriving at the destination. Verified by: trip start date arrives -> agent texts group "Hey, here's the Airbnb address. It's 45 minutes from the airport." with the actual address.

- [ ] The agent reminds the group about open votes. Verified by: poll has been open 24hrs with 2 of 5 people not voted -> agent nudges group "2 people still haven't voted on dinner spot — poll closes tomorrow."

- [ ] The agent sends notifications about trip updates to the group. Verified by: a new expense is added in-app -> agent texts group "{name} added $80 for Uber."

### Agent Message Behavior

- [ ] Every agent message is 6 lines or fewer. Verified by: trigger 10 different agent responses (expense confirm, vote prompt, itinerary query, etc.) -> none exceeds 6 lines.

- [ ] The agent sends at most 3 messages in a row before waiting for user input. Verified by: trigger a complex action that could generate multiple responses -> agent sends no more than 3 messages -> waits.

- [ ] The agent uses 1:1 DMs for private info instead of the group. Verified by: Tom texts "what do I owe?" -> balance response goes to Tom privately, not the group chat.

### Edge Cases & Error States

- [ ] A group chat with only 2 people (plus the Tryps number). Verified by: add Tryps number to a 2-person chat -> agent handles it via 1:1 messages to each person (Linq requires 3+ for groups).

- [ ] The agent can't parse what someone said. Verified by: Jake texts "asdfjkl random nonsense" -> agent does NOT respond. It stays quiet on messages it doesn't understand.

- [ ] A user texts an expense with no trip context (first message ever). Verified by: brand new group, first message is "$50 for gas" -> agent creates the trip first, then logs the expense, confirms both.

- [ ] The agent is asked something outside its scope. Verified by: Sarah texts "book us a flight to Miami" -> agent responds "I can't book flights yet — coming soon. For now, paste your flight confirmation and I'll track it."

### Should NOT Happen

- [ ] The agent does NOT respond to every message in the group. Normal conversation between friends gets no response. Verified by: send 5 casual messages ("lol", "see you there", "can't wait", a meme, "haha") -> agent stays silent on all 5.

- [ ] The agent does NOT send walls of text. No message exceeds 6 lines. No more than 3 messages in a row. Verified by: run through all agent response types -> check line counts and message counts.

- [ ] The agent does NOT announce every background action. If it's silently logging or processing, it stays quiet unless confirmation is needed. Verified by: agent processes 5 link scrapes in a row -> only confirms the ones that resulted in added content, not the processing steps.

- [ ] Non-trip-members do NOT see trip data. A phone number not in the iMessage group cannot query trip info. Verified by: outsider texts the Tryps number asking "what's the plan for Miami?" -> agent does not reveal trip details.

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
