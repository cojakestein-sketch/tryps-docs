---
id: group-decision-making
title: "Group Decision-Making: Facilitation Engine"
status: in-progress
assignee: rizwan
wave: 2
dependencies: [imessage-agent, agent-intelligence]
clickup_ids: ["86e0emu5q"]
criteria_count: 25
criteria_done: 5
last_updated: 2026-04-02
links:
  objective: ./objective.md
  state: ./state.md
---

> Parent: [[group-decision-making/objective|Group Decision-Making Objective]]

# Group Decision-Making: Facilitation Engine — Spec

## What

The agent's core intelligence loop for shepherding a group from a blank trip to a trip that's planned enough for everyone's comfort. It decides what to ask, when to ask it, who to ask, and when to stop.

## Why

Without this, Tryps is a trip container. This is what makes it a travel agent. The facilitation engine is the product — it turns a group chat into a planned trip without any single person doing the work.

## Intent

> "We are the facilitation engine in your iMessage. We are the referee, we are the shepherd, we are the travel agent. We are responsible for making sure that the trip actually gets planned. Everybody else's job is nothing. It's not a job at all. It's just like a creative vibe communication process. That's what our users feel."
>
> "Level one is a completely blank trip card and level ten is when the people in chat feel like the entire trip is planned — suffice for their level of comfort."
>
> "It catches a vibe for this group and says, 'All right, we think planning is kind of done. Hey, we could continue to plan more but it seems like you guys are kind of done. Does anybody want to keep going or are we good?'"
>
> It should feel like a great travel agent — the group just vibes, and everything gets handled.
>
> "Getting good at this is gonna be a core competency of ours. There's not a clear science to this. It's more of an art and we need to be artists in this domain."
>
> "Most people will just add Tryps to the group chat in which everybody is already going on THIS trip. The agent should know who's in the chat."
>
> It should feel like group chat energy — a friend in the chat who's really organized, not an app.

## Key Concepts

**Criticality Matrix:** Two inputs drive how often the agent reaches out: (1) time until the trip and (2) how much is still unplanned. 6 months out with plenty of time → ~2x/week. 6 days out with nothing planned → 1-2x/day. If the group chat is active, the agent is more likely to drop a message because it feels natural. If the chat is dead, it backs off to avoid annoying people.

**Default Priority Order:** The agent follows a loose default sequence when deciding what to ask next: location + dates → group members confirmed → flights → stay → activities → fun extras (Spotify playlist, vibe tab). This order adapts — if the group gives info out of order, the agent accepts it and steers back to whatever foundational piece is still missing.

**Done Detection:** Level 10 is not "every field filled." It's when the group feels done. The agent reads a combination of signals — response drop-off on planning prompts, completeness of core fields, and explicit statements — then offers an off-ramp rather than pushing more planning.

**Trip Creator Authority:** The person who started the trip is the tiebreaker. When the group can't agree and compromise fails, the trip creator has final say.

**Emoji Voting:** The universal decision mechanism for every group planning question. The agent proposes options with Apple's default iOS tapback reactions (👍, ❤️, ‼️, 👎, 😂, ❓) mapped to choices. Users react to vote. Tallying is flexible — majority can end a vote early, otherwise a timeout (tied to the criticality matrix) triggers the tally. Low-stakes results auto-apply. High-stakes results (booking, money) need confirmation. The poll message itself is the onboarding — no extra explanation needed.

**Participant Awareness:** The agent knows who's in the group chat. Everyone in the chat is assumed to be on the trip. No join links for people already present. If someone refers others for a *different* trip, the agent starts a separate conversation with those people.

**Vote Prediction:** For users with built-out profiles, the agent can surface predicted preferences transparently. Predictions are clearly suggestions, never silent auto-votes. In early interactions (profile not built out), no predictions at all. The agent can call people out: "Sarah, we think you'd prefer X — any thoughts?" Clear delineation between agent-predicted and human votes at all times.

---

## Success Criteria

### Core Behavior

- [ ] **SC-1.** The agent's first facilitation prompt on a new trip asks about location and dates if neither is set. Verified by: create a trip with 4 members and no info → agent's first proactive message asks about where and when, not flights or activities.

- [ ] **SC-2.** The agent picks the next question based on what's missing, following the default priority: location/dates → flights → stay → activities → extras. Verified by: set location and dates on a trip → agent's next facilitation prompt is about flights or stay, not activities or Spotify.

- [ ] **SC-3.** The agent adapts when the group gives info out of order. Verified by: in a trip with no dates set, a user texts "let's do Nobu on Friday" → agent logs the activity, confirms it, then steers back to ask about dates.

- [ ] **SC-4.** The agent's proactive frequency follows the criticality matrix. Verified by: create two trips — one 6 months away (both blank), one 6 days away (both blank). Over 7 days, the far trip receives 2-3 messages. The near trip receives 5-7 messages.

- [ ] **SC-5.** The agent never sends more than one proactive message per day to the group chat. Verified by: monitor a 4-person trip over 5 days → count proactive group messages → none exceed 1 per calendar day.

- [ ] **SC-6.** Group-level questions go to the group chat. Individual questions go to DMs. Verified by: agent asks "when are we thinking for dates?" in the group → agent asks Jake individually "what airport are you flying out of?" via DM.

- [ ] **SC-7.** When one person hasn't responded to a planning prompt, the agent nudges in the group chat. Verified by: agent asks about dates → 3 of 4 respond within 24 hours → 1 doesn't → agent's next group message references the non-responder by name (e.g., "still need to hear from Sarah on dates").

- [ ] **SC-8.** When the group disagrees, the agent proposes a compromise before anything else. Verified by: in a destination vote, 2 pick beach and 2 pick mountains → agent suggests a coastal or hybrid destination as a third option, not a binding vote.

- [ ] **SC-9.** When a compromise fails, the trip creator has final say. Verified by: after a compromise suggestion gets rejected by the group → agent asks the trip creator directly to make the call → trip creator's choice is applied.

- [ ] **SC-10.** The agent detects when planning is "done enough" and offers an off-ramp. Verified by: fill in location, dates, flights, and stay on a trip → leave activities empty → after 2 unanswered activity prompts, agent sends a message like "looks like the big stuff is locked in — want to keep planning activities or are we good?"

### Participant Awareness

- [x] **SC-15.** `✅ DONE` The agent knows who is in the group chat and addresses them by name. It never suggests sending a join link to someone already present. Verified by: create a trip in a group chat with Jake, Diego, and Sarah → agent's first message references the group → agent does not suggest sending anyone a join link or share a join URL for any participant.

- [ ] **SC-16.** When a trip is created in a group chat, all chat participants are automatically treated as trip members. Verified by: Jake texts "plan a trip to NYC" in a group chat with 3 others → trip is created with all 4 as members → no enrollment prompts are sent.

- [ ] **SC-17.** When someone refers other people for a separate trip, the agent starts a new conversation with those people instead of adding them to the current trip. Verified by: in a group chat about "NYC trip," Jake says "my friend Mike wants to use Tryps for his Rome trip, his number is 555-1234" → agent contacts Mike separately about Rome → Mike is NOT added to the NYC trip.

### Emoji Voting

- [x] **SC-18.** `✅ DONE` The agent proposes group decisions as emoji polls using Apple's default iOS tapback reactions. Each option maps to one emoji. The message format is self-explanatory. Verified by: agent needs to ask about dates → sends "when works best? react to vote: 👍 = July, ❤️ = August, ‼️ = September" → single message with clear emoji-to-option mapping.

- [x] **SC-19.** `✅ DONE` The agent tallies emoji votes using a flexible timeout tied to the criticality matrix. Trips far out get longer windows; trips soon get shorter. Majority can trigger an early tally. Verified by: 4-person trip 2 weeks away, 3 of 4 vote within 1 hour → agent tallies and announces without waiting for the 4th. Same trip 4 months away → agent waits at least 24 hours before tallying.

- [x] **SC-20.** `✅ DONE` Low-stakes vote results (dates, destination, activities) auto-apply to the trip. High-stakes results (booking, payment) require explicit group confirmation. Verified by: date vote resolves to July → trip dates update automatically. Hotel vote resolves to Marriott → agent says "Marriott won — want me to book it?" and waits for confirmation.

- [ ] **SC-21.** Before the voting timeout expires, the agent nudges non-voters by name in the group chat. Verified by: 4-person trip, 3 vote within 4 hours, Sarah hasn't → agent sends "still waiting on Sarah — any preference?" in the group.

- [ ] **SC-22.** For users with built-out profiles, the agent surfaces vote predictions transparently. Predictions are clearly marked as suggestions, never recorded as votes. Verified by: Sarah has a detailed travel profile → agent sends "Sarah, you usually prefer beach trips — any thoughts?" → prediction is NOT counted as a vote unless Sarah responds.

### Facilitation → Booking Transition

- [ ] **SC-23.** When a vote resolves a planning decision, the agent immediately offers the next action in the facilitation sequence. Verified by: group votes on destination (result: Cancun) → agent's next message is "Cancun it is! want me to search flights?" — no gap, no waiting for the criticality timer.

### Edge Cases & Error States

- [ ] **SC-11.** Solo trip (1 person in group chat). Verified by: create a trip with 1 member → agent skips voting, skips social pressure nudges, and asks direct questions ("where are you headed?").

- [ ] **SC-12.** Trip with no date set and travel date is unknown. Verified by: user says "I want to go to Vegas this year" → agent logs Vegas as destination, generates a trip name → next prompt asks about dates, doesn't ask about flights.

### Should NOT Happen

- [ ] **SC-13.** The agent never books or commits money without explicit group approval. Verified by: agent recommends a hotel → user says "that looks great" → agent asks "want me to book it?" and waits for a clear yes before any booking action.

- [ ] **SC-14.** The agent never asks the same person the same type of question in consecutive check-ins. Verified by: agent asks Jake about flight preferences on Monday → Tuesday's check-in does not ask Jake about flights again, even if he didn't respond.

- [x] **SC-24.** `✅ DONE` The agent never sends a join or invite link to someone already in the group chat. Verified by: create a trip in a group chat where Diego is a participant → at no point does the agent say "send Diego the link" or share a join URL for Diego.

- [ ] **SC-25.** The agent never auto-votes on behalf of a user in their first few interactions with Tryps. Verified by: new user (no profile data, first trip) is in a group → vote poll is sent → agent does NOT predict or auto-fill their vote.

### Out of Scope

- Native iMessage polling extension — future feature. Emoji tapback reactions are the v1 mechanism.
- 22 notification triggers — separate implementation pass, wired after facilitation logic ships.
- Role cards / engagement tiers — needs its own design pass.
- Booking and payment execution — covered by Payments Infrastructure and Travel Booking scopes. This spec covers the handoff from vote → booking offer, not the booking itself.
- Vote-on-behalf (agent voting autonomously without surfacing it) — covered by Agent Intelligence scope.

### Regression Risk

| Area | Why | Risk |
|------|-----|------|
| iMessage Agent routing logic | Facilitation prompts share the same message pipeline as reactive responses | High |
| Agent Intelligence memory | Facilitation decisions depend on what the agent remembers about user preferences | Med |
| Existing voting flows | Compromise proposals and tiebreaks interact with the vote engine | Med |
| Rate limiter (SC-61) | Criticality matrix frequency must respect the existing 1-message-per-4-hour rate limit | High |
| Linq participant API | Agent's contextual awareness depends on Linq providing accurate group member data | High |
| Existing in-app voting | Emoji voting in iMessage runs parallel to the in-app vote screen — must stay in sync | Med |

### Open Questions

- Exact criticality matrix formula: what are the thresholds? Needs a design doc with visual demo (Jake wants to see this).
- How does the off-ramp interact with the trip completeness level display on the overview tab?
- Does the rate limiter from Agent Intelligence (SC-61, max 1 proactive per 4-hour window) need to be relaxed for high-criticality trips?
- What constitutes a "built-out profile" sufficient for the agent to predict votes? Needs threshold definition.
- Formal vote timeout algorithm — Rizwan to design and document the window durations per criticality level.
- How does the agent read tapback reactions from iMessage? Does Linq expose reaction event data?
- What happens if someone reacts with an emoji NOT in the poll options?

- [ ] Typecheck passes

---

## Kickoff Prompt

Copy/paste this to start implementation:

> **Scope:** Group Decision-Making — Facilitation Engine
> **Spec:** `~/tryps-docs/scopes/group-decision-making/spec.md`
> **What:** Build the agent's facilitation intelligence loop — the system that decides what planning question to ask next, when to ask it, who to ask, and when to stop. 25 success criteria across three areas:
>
> 1. **Core facilitation loop (SC-1–14):** Criticality matrix (time-to-trip × planning completeness → message frequency), default priority order (location/dates → flights → stay → activities → extras), done detection (offer off-ramp when group energy drops), compromise-first disagreement resolution with trip creator as tiebreaker.
> 2. **Participant awareness (SC-15–17):** Agent knows who's in the group chat, auto-enrolls all participants as trip members, never sends join links to people already present. Referral detection for separate trips.
> 3. **Emoji voting (SC-18–25):** Agent proposes decisions as emoji polls using Apple iOS tapback reactions. Flexible tally timeout (criticality-linked), majority can end early. Low-stakes auto-apply, high-stakes need confirmation. Non-voter nudging. Transparent vote prediction for built-out profiles. Immediate transition from vote → booking offer.
>
> **Priority order:** Start with SC-15–16 (participant awareness — this is a live bug per Issue #341), then SC-18–20 (emoji voting core), then SC-1–5 (facilitation loop). Read the full spec first.
