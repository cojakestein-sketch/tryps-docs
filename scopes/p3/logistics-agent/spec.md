---
id: p3-logistics-agent
title: "Logistics Agent"
phase: p3
status: not-started
assignee: unassigned
priority: 4
dependencies: []
blocked: true
blocked_reason: "P3 dev slot open — waiting on hire"
---

## What

An AI agent layer that handles trip logistics — flights, hotels, restaurants, transportation — on behalf of the group. Users trigger it from the Tryps app. The agent researches options, presents ranked recommendations, and books after group approval.

## Why

Planning group trips is a coordination nightmare. Someone has to do the legwork — searching flights, comparing restaurants, finding hotels that fit the budget. The agent does that work so the group can focus on deciding together, not researching alone.

## Intent

> "It should feel like a high-end travel concierge, not a search engine. But when it shows options,
> think Citymapper — a clean layout of all the different possible options with the time frame and
> what it would take you. Ranked by cost and time so you can compare at a glance."

## Success Criteria

### Core Behavior

- [ ] Tapping a section button (e.g. "Find Flights" on the Flights section of the trip card) creates an agent task tied to that trip and category. Verified by: Trip with 3 members -> Alice taps "Find Flights" on trip card -> agent task appears in chat thread within 3 seconds with a "Searching..." status.

- [ ] Empty state prompts trigger the agent. Verified by: Trip with no dinner planned -> Activities section shows "No dinner yet — want me to find one?" -> Alice taps it -> agent task starts for the dinner category.

- [ ] Free-text chat triggers the agent. Verified by: Alice types "find a hotel in Rome under $200/night for March 18-22" in trip chat -> agent parses intent and starts a hotel search task.

- [ ] Agent returns ranked options in both the chat thread and the activity feed. Verified by: Agent completes a flight search -> 3-5 options appear in chat thread ranked by cost + time -> same options appear in the activity feed on the trip card.

- [ ] Each option shows cost, time/duration, and key details at a glance (like Citymapper). Verified by: Flight options show airline, departure/arrival times, duration, price per person, and total group price. Restaurant options show cuisine, rating, price range, and available time slots.

- [ ] Group votes on options. Majority wins within a 48-hour voting window. Verified by: 5-member trip -> agent presents 3 dinner options -> Alice, Bob, Carol vote for Option B -> Option B is marked "Selected" and moves to booking confirmation.

- [ ] Non-voters get a push notification reminder at the 24-hour mark. Verified by: 48-hour vote starts at 2pm Monday -> at 2pm Tuesday, Dave and Eve (who haven't voted) each receive a push: "Vote on dinner — 24 hours left."

- [ ] If no majority after 48 hours, the proposer's preference wins. Verified by: 4-member trip -> 2 vote Option A, 2 vote Option B, tie after 48h -> Alice (who triggered the search) picks Option A -> Option A moves to booking.

- [ ] Booking confirmation updates the trip card section and sends a push to all members. Verified by: Hotel booking confirmed -> Stay section on trip card shows hotel name, dates, and confirmation number -> all 4 members get push: "Hotel booked: Grand Roma, March 18-22."

- [ ] Duplicate requests get deduplicated. Verified by: Alice triggers "Find dinner in Rome for March 20" -> 10 minutes later Bob triggers the same request -> Bob sees "Alice already started this search — results coming soon" -> only one agent task runs.

- [ ] Agent can contact external parties to gather info. Verified by: Alice asks "Can you email the event organizer for ticket availability?" -> agent sends an outbound email -> response from organizer appears in the chat thread.

### Edge Cases & Error States

- [ ] First agent task on a trip shows an onboarding message. Verified by: New trip with no prior agent tasks -> Alice taps "Find Flights" -> chat thread shows a one-time intro: "I'm your trip concierge. I'll search, you decide."

- [ ] Selected option sells out before booking. Agent auto-recovers with alternatives ranked by cost + time. Verified by: Group votes for Flight Option A -> agent attempts booking -> flight sold out -> agent returns 3 alternative flights ranked by cost and departure time within 30 seconds -> group sees "Option A sold out — here are alternatives."

- [ ] Alternatives also fail. Agent escalates to the group. Verified by: Original option sold out -> 3 alternatives also unavailable -> agent posts: "All similar options are gone. Want me to search again with different dates or a bigger budget?"

- [ ] Price changes between recommendation and booking. Agent flags the delta. Verified by: Option B quoted at $450 -> at booking time price is $490 -> agent shows: "Price changed from $450 to $490 (+$40). Confirm or pick another?"

- [ ] API is down. Agent notifies and retries. Verified by: Duffel API returns 500 -> agent shows "Flight search temporarily unavailable. Retrying..." -> retries 3 times over 5 minutes -> if still down: "Flight search is down. I'll try again in 30 minutes."

- [ ] Solo trip (1 member). No voting phase — skip straight to confirmation. Verified by: Trip with 1 member -> Alice triggers "Find Flights" -> options appear -> Alice taps "Book This" -> booking proceeds immediately, no vote timer.

- [ ] Free-text input the agent can't parse. Verified by: Alice types "do the thing for the stuff" -> agent responds: "I didn't catch that. Try something like 'Find flights from NYC to Rome on March 18.'"

### Should NOT Happen

- [ ] Agent NEVER books anything without explicit human confirmation (unless the user has enabled auto-book in trip settings).

- [ ] Agent NEVER charges real user money in v1. All costs are Tryps-subsidized and logged internally.

- [ ] Group bookings (2+ members) NEVER proceed without group approval, even if auto-book is enabled for the proposer. Auto-book only applies to solo actions.

- [ ] Agent NEVER sends push notifications for intermediate steps (searching, processing, comparing). Push only fires for: options ready, 24h vote reminder, booking confirmed, booking failed.

### Out of Scope

- Trip Cash / referral rewards program — separate spec. Agent costs are Tryps-subsidized in v1.
- User-facing cost breakdown or billing UI — internal logging only for now.
- iMessage / Linq integration for agent triggers — P2 work, agent only triggered from in-app for now.
- Traveler DNA personalization (ranking options by group vibe preferences) — v2 enhancement.
- Detailed agent activity log UI — v2. Agent logs exist internally, but no user-facing drill-down yet.

### Architecture Notes

This is Phase 3 of the three-layer architecture (see `memory/tryps-architecture.md`):

- **Orchestration**: Agent receives structured intent from the app via Supabase edge functions. Intent includes: trip ID, category (flight/hotel/dining/transport), parameters (dates, location, headcount, budget), and proposer ID.
- **Execution**: Agent calls external APIs — Duffel (flights), OpenTable/Resy (dining), hotel APIs TBD. Payment via X-402 micropayment protocol from Tryps Cash wallet.
- **Communication**: Results written to Supabase -> realtime subscriptions push to app (chat thread + activity feed). Push notifications via Expo push service.
- **Open question**: Where does the orchestration brain live? (Supabase edge function, Marty, or separate service — decision pending Tommy's input.)

### Auto-Book Setting

- [ ] Trip settings include an "Auto-book" toggle, off by default. Verified by: Trip settings screen -> "Agent Booking" section -> toggle labeled "Let agent book without asking" -> default is off.

- [ ] With auto-book on, solo agent tasks skip the vote and book the top option immediately. Verified by: Alice enables auto-book -> triggers "Find dinner for 1" -> agent finds options -> books the top-ranked option -> Alice gets push: "Dinner booked: Trattoria Luca, 8pm."

- [ ] Auto-book does NOT apply to group tasks. Verified by: Alice has auto-book on -> triggers "Find dinner for 4" on a group trip -> options still go to group vote with 48-hour window.

### Regression Risk

| Area | Why | Risk |
|------|-----|------|
| Trip card sections | Agent results write to same data model | Medium |
| Chat / activity feed | New message types (agent options, votes) | Medium |
| Push notifications | New notification types added | Low |
| Expense ledger | Bookings may create expenses | High |

- [ ] Typecheck passes
