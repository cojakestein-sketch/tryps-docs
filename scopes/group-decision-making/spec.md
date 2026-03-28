---
id: group-decision-making
title: "Group Decision-Making: Facilitation Engine"
status: specced
assignee: rizwan
wave: 2
dependencies: [imessage-agent, agent-intelligence]
clickup_ids: ["86e0emu5q"]
criteria_count: 14
criteria_done: 0
last_updated: 2026-03-28
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

## Key Concepts

**Criticality Matrix:** Two inputs drive how often the agent reaches out: (1) time until the trip and (2) how much is still unplanned. 6 months out with plenty of time → ~2x/week. 6 days out with nothing planned → 1-2x/day. If the group chat is active, the agent is more likely to drop a message because it feels natural. If the chat is dead, it backs off to avoid annoying people.

**Default Priority Order:** The agent follows a loose default sequence when deciding what to ask next: location + dates → group members confirmed → flights → stay → activities → fun extras (Spotify playlist, vibe tab). This order adapts — if the group gives info out of order, the agent accepts it and steers back to whatever foundational piece is still missing.

**Done Detection:** Level 10 is not "every field filled." It's when the group feels done. The agent reads a combination of signals — response drop-off on planning prompts, completeness of core fields, and explicit statements — then offers an off-ramp rather than pushing more planning.

**Trip Creator Authority:** The person who started the trip is the tiebreaker. When the group can't agree and compromise fails, the trip creator has final say.

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

### Edge Cases & Error States

- [ ] **SC-11.** Solo trip (1 person in group chat). Verified by: create a trip with 1 member → agent skips voting, skips social pressure nudges, and asks direct questions ("where are you headed?").

- [ ] **SC-12.** Trip with no date set and travel date is unknown. Verified by: user says "I want to go to Vegas this year" → agent logs Vegas as destination, generates a trip name → next prompt asks about dates, doesn't ask about flights.

### Should NOT Happen

- [ ] **SC-13.** The agent never books or commits money without explicit group approval. Verified by: agent recommends a hotel → user says "that looks great" → agent asks "want me to book it?" and waits for a clear yes before any booking action.

- [ ] **SC-14.** The agent never asks the same person the same type of question in consecutive check-ins. Verified by: agent asks Jake about flight preferences on Monday → Tuesday's check-in does not ask Jake about flights again, even if he didn't respond.

### Out of Scope

- Voting mechanics (destination, date, activity voting) — already built.
- 22 notification triggers — separate implementation pass, wired after facilitation logic ships.
- Role cards / engagement tiers — needs its own design pass.
- Booking and payment execution — covered by Payments Infrastructure (scope #9) and Travel Booking (scope #10).
- Vote-on-behalf — covered by Agent Intelligence (scope #8).

### Regression Risk

| Area | Why | Risk |
|------|-----|------|
| iMessage Agent routing logic | Facilitation prompts share the same message pipeline as reactive responses | High |
| Agent Intelligence memory | Facilitation decisions depend on what the agent remembers about user preferences | Med |
| Existing voting flows | Compromise proposals and tiebreaks interact with the vote engine | Med |
| Rate limiter (SC-61) | Criticality matrix frequency must respect the existing 1-message-per-4-hour rate limit | High |

### Open Questions

- Exact criticality matrix formula: what are the thresholds? Needs a design doc with visual demo (Jake wants to see this).
- How does the off-ramp interact with the trip completeness level display on the overview tab?
- Does the rate limiter from Agent Intelligence (SC-61, max 1 proactive per 4-hour window) need to be relaxed for high-criticality trips?

- [ ] Typecheck passes

---

## Kickoff Prompt

Copy/paste this to start implementation:

> **Scope:** Group Decision-Making — Facilitation Engine
> **Spec:** `~/tryps-docs/scopes/group-decision-making/spec.md`
> **What:** Build the agent's facilitation intelligence loop — the system that decides what planning question to ask next, when to ask it, who to ask, and when to stop. Core concepts: criticality matrix (time-to-trip × planning completeness → message frequency), default priority order (location/dates → flights → stay → activities → extras), done detection (offer off-ramp when group energy drops), compromise-first disagreement resolution with trip creator as tiebreaker. 14 success criteria. Read the spec, then start with SC-1 through SC-5 (the core loop and criticality matrix).
