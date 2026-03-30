---
title: "Cross-Scope Dependencies"
date: 2026-03-30
purpose: Team reference for inter-scope blocking relationships
---

# Cross-Scope Dependencies

> Flag for the team: these are the interfaces where one scope's work depends on or feeds into another's. If you're working on one side of a dependency, coordinate with the owner of the other side.

## Critical Path (blocks demo gate)

```
Agent Intelligence SC-59/60/61  ←→  iMessage Agent SC-52/53/56/57
  DM delivery pipeline, vote override routing, rate limiter
  OWNERS: Rizwan ↔ Asif
  STATUS: Needs joint design session. 4+ days pending.
  ACTION: Asif + Rizwan sync this week. These SCs are the interface
          between the agent brain and the iMessage channel.
```

## Booking Chain

```
Travel Booking SC-37–40 (payment handoff)  →  Travel Booking SC-59–70 (Stripe)
  Booking finalization requires card-on-file to exist.
  OWNER: Asif + Rizwan (same scope now)
  ACTION: Build Stripe card-on-file (SC-59–61) before attempting
          any booking finalization.

Travel Identity SC-40–44 (booking passthrough)  →  Travel Booking
  Loyalty numbers and passport data auto-applied at booking time.
  OWNERS: Nadeem (identity) → Asif/Rizwan (booking)
  ACTION: Identity's data model must expose loyalty/passport to
          booking edge functions. Define the interface early.
```

## Agent ← Data Dependencies

```
Travel Identity SC-17–19 (group vibe summary)  →  Agent Intelligence
  Agent recommendations powered by group vibe data.
  OWNERS: Nadeem (identity) → Rizwan (agent)
  ACTION: Group vibe summary API must be consumable by the
          recommendation engine. Align on the data shape.

Travel Identity SC-15–16 (agent DNA nudge)  →  iMessage Agent
  Agent sends contextual nudge in group chat when DNA incomplete.
  OWNERS: Nadeem (identity) → Asif (iMessage)
  ACTION: Define the trigger condition and message format.
```

## Output → Retention

```
Core Trip Experience (overview/itinerary)  →  Post-Trip SC-1–3
  Trip complete trigger reads trip end date and activity list.
  OWNER: Nadeem (both scopes)
  ACTION: No cross-person dependency. Nadeem owns both sides.

Post-Trip SC-4–5 (top 3 favorites)  →  Agent Intelligence (recommendations)
  Favorite activity data feeds the recommendation algorithm.
  OWNERS: Nadeem (post-trip) → Rizwan (agent)
  ACTION: Define where favorite selections are stored and how
          the recommendation engine reads them.
```

## Facilitation Chain

```
Group Decision-Making SC-1–14  →  iMessage Agent
  Voting, facilitation, notification triggers wire through iMessage.
  OWNERS: Rizwan (group decision) → Asif (iMessage)
  ACTION: Group Decision-Making spec defines WHAT gets voted on.
          iMessage Agent defines HOW votes are presented in chat.
          Align on the vote-trigger interface.
```

## Onboarding (Low Risk)

```
Onboarding SC-1–5 (first trip tooltips)  →  Core Trip Experience
  Tooltips overlay trip screens. Needs z-index and modal awareness.
  OWNER: Nadeem (both scopes)
  ACTION: No cross-person dependency.
```

---

## Summary: Who Needs to Talk

| People | About | Priority |
|--------|-------|----------|
| **Asif + Rizwan** | SC-59/60/61 interface (DM delivery, vote override, rate limiter) | URGENT |
| **Nadeem + Rizwan** | Group vibe summary data shape for recommendations | This week |
| **Nadeem + Rizwan** | Top 3 favorites → recommendation engine data flow | Before post-trip work starts |
| **Rizwan + Asif** | Group Decision-Making vote triggers → iMessage presentation | Before GDM work starts |
| **Nadeem + Asif/Rizwan** | Travel Identity booking passthrough interface | Before booking finalization |
