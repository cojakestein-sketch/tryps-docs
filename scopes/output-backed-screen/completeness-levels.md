---
id: output-backed-screen
type: reference-doc
status: draft
blocks: [SC-14, SC-15, SC-16, SC-17, SC-18, SC-19]
consumed_by: [imessage-agent-SC-25, imessage-agent-SC-53]
last_updated: 2026-03-22
---

> Parent: [[output-backed-screen/objective|Output-Backed Screen Objective]]

# Trip Completeness Level System

This document defines the adaptive milestone system that drives trip planning progression. It is the source of truth for completeness levels. The iMessage Agent (scope 7, SC-53) consumes this system for daily check-ins. The Output-Backed Screen (scope 16) visualizes it.

## Core Principle: Adaptive, Not Fixed

The level system is not a rigid 1-to-10 ladder. It's an adaptive checklist that flexes based on what THIS trip needs.

- A complex international multi-city trip with flights, multiple stays, and 20+ activities might have ~15 applicable milestones.
- A weekend road trip with friends in the same city might have 3-4.
- A direct trip ("Aspen, March 15-18, skiing") starts with several milestones already complete on creation.
- An ideated trip ("6 friends, don't know where or when") starts nearly empty.

The system assesses the trip on creation and selects applicable milestones. Milestones can be added later if the trip evolves (e.g., group decides to fly instead of drive).

## The Trip Spectrum

Every trip falls somewhere on this spectrum:

```
DIRECT                                                    IDEATED
"Aspen, these dates, just do it"          "6 friends, no idea where/when/what"
├── Destination known                      ├── Only participants known
├── Dates known                            ├── No destination
├── Activity type known                    ├── No dates
├── Maybe flights known                    ├── No plans
└── System skips ahead                     └── System starts from scratch
```

The opening move from the agent/system is essentially: "Tell me what you've got and what you want." The system fills in the gaps.

## Full Milestone Universe

These are ALL possible milestones. The system selects which ones apply to each trip.

### Foundation (applies to all trips)

| # | Milestone | Completion Condition | Agent Behavior When Incomplete |
|---|-----------|---------------------|-------------------------------|
| 1 | **Trip created** | Trip exists with a name and at least 2 participants | N/A — this is the starting point |
| 2 | **Dates locked** | Trip has confirmed start and end dates | "when are we thinking? want me to throw up a date vote?" |
| 3 | **Destination locked** | Trip has a confirmed destination (city/region) | "where to? I can suggest some options based on everyone's vibe" |
| 4 | **Vibes collected** | All participants have completed the vibe quiz or communicated preferences | "still need vibes from Sarah and Mike. I'll send them a nudge" |

### Logistics (conditionally applied)

| # | Milestone | Applies When | Completion Condition | Agent Behavior When Incomplete |
|---|-----------|-------------|---------------------|-------------------------------|
| 5 | **Flights aligned** | Participants in different cities / destination requires air travel | All participants have flight info logged (booked or confirmed arrival time) | "flights are the big one. want me to look at options that land within 90 min of each other?" |
| 6 | **Stay picked** | Trip is overnight (not a day trip) | At least one confirmed accommodation for the trip duration | "still need to lock down where we're staying. I found 3 options, want me to throw them up for a vote?" |
| 7 | **Transport sorted** | Destination requires ground transport (airport transfers, rental car, etc.) | Ground transport plan exists (rental confirmed, ride scheduled, or "we'll Uber" acknowledged) | "how are we getting around? rental car, Ubers, or someone driving?" |

### Planning (conditionally applied based on trip complexity)

| # | Milestone | Applies When | Completion Condition | Agent Behavior When Incomplete |
|---|-----------|-------------|---------------------|-------------------------------|
| 8 | **Activities proposed** | Trip is 2+ days | At least 1 activity per day proposed (via agent recommendations or user input) | "want me to suggest some things to do? I've got ideas based on the group's vibe" |
| 9 | **Activities decided** | Activities were proposed and need group alignment | All proposed activities have been voted on or confirmed | "3 activities still need votes. want me to nudge everyone?" |
| 10 | **Reservations made** | Trip includes activities/restaurants that need reservations | All reservation-required items have confirmed bookings | "Nobu needs a rez. want me to book for 8pm Friday?" |
| 11 | **Itinerary built** | Trip has dates + activities | Day-by-day plan exists with activities assigned to specific days/times | "we've got the pieces, just need to put them in order. want me to draft an itinerary?" |

### Financial (conditionally applied)

| # | Milestone | Applies When | Completion Condition | Agent Behavior When Incomplete |
|---|-----------|-------------|---------------------|-------------------------------|
| 12 | **Expenses aligned** | Trip has shared costs (stay, group activities) | Cost-split expectations are clear — who's paying for what is established | "quick heads up, the Airbnb is $1200. Jake's booking it. everyone else owes $300" |

### Pre-Departure (applies to most trips)

| # | Milestone | Applies When | Completion Condition | Agent Behavior When Incomplete |
|---|-----------|-------------|---------------------|-------------------------------|
| 13 | **Packing/prep done** | Trip requires travel (not local) | Packing list generated or user acknowledges they're ready | "trip's in 3 days. packing list is ready if you want it" |
| 14 | **Itinerary finalized** | Itinerary exists | All participants have reviewed the itinerary (viewed it in app or received the final infographic) | "here's the final plan. everyone good?" |
| 15 | **Trip ready** | All other applicable milestones complete | All applicable milestones are complete or acknowledged | Celebration moment — "you're all set. have an amazing trip" |

## How the System Selects Milestones

On trip creation, the system evaluates:

1. **Participant locations:** Same city? Different cities? Different countries? → Determines if flights and transport milestones apply.
2. **Trip duration:** Day trip? Overnight? Multi-day? → Determines if stay, activities, itinerary milestones apply.
3. **Pre-filled data:** Did the creator specify dates, destination, or activities upfront? → Auto-completes applicable milestones.
4. **Trip type signals:** Keywords, vibe quiz results, or explicit user input about trip style.

### Example: Direct Trip

"Aspen, March 15-18, skiing with 4 friends from Denver"

- Auto-completed on creation: Trip created, Dates locked, Destination locked
- Skipped: Flights aligned (everyone's driving from Denver)
- Remaining: Vibes collected, Stay picked, Transport sorted (rental car?), Activities proposed (beyond skiing), Itinerary built, Expenses aligned, Itinerary finalized, Trip ready
- **Starting completeness: ~30%**

### Example: Ideated Trip

"Want to see my 6 college friends, no idea where or when"

- Auto-completed on creation: Trip created
- Applicable: Everything — dates, destination, vibes, flights, stay, transport, activities, reservations, itinerary, expenses, prep, finalized, trip ready
- **Starting completeness: ~7%**

### Example: Simple Local Trip

"Dinner and concert downtown Saturday with 3 friends"

- Auto-completed on creation: Trip created, Dates locked, Destination locked
- Skipped: Flights, Stay, Transport, Packing/prep
- Remaining: Vibes collected (optional for simple trips), Activities decided, Reservations made, Expenses aligned, Trip ready
- **Starting completeness: ~40%**

## Milestone State Machine

Each milestone can be in one of three states:

```
NOT APPLICABLE ──(trip changes)──→ INCOMPLETE
                                      │
                                      ├──(condition met)──→ COMPLETE
                                      │                        │
                                      │                   (data invalidated)
                                      │                        │
                                      │                        ▼
                                      │                  NEEDS ATTENTION
                                      │                        │
                                      │                   (data restored)
                                      │                        │
                                      └────────────────────────┘
                                                (back to COMPLETE)
```

- **Not Applicable:** This milestone doesn't apply to this trip. Not shown in the overview. Not counted in completeness percentage.
- **Incomplete:** Applies to this trip but not yet done. Shown in the overview as empty/pending.
- **Complete:** Condition met. Shown as checked/filled.
- **Needs Attention:** Was complete, but something changed (Airbnb cancelled, flight changed). Shown with a flag. Completeness percentage does NOT decrease — the flag is a call to action, not a regression.

## How the Agent Uses This System

The iMessage Agent (scope 7) reads milestone state to drive its daily check-ins:

1. **Identify the highest-priority incomplete milestone.** Priority roughly follows the milestone order (foundation → logistics → planning → financial → pre-departure), but the agent can skip ahead if context warrants it.
2. **Make a specific ask.** Not "your trip needs work" — instead "still need to lock down the stay. I found 3 options, want me to throw them up for a vote?"
3. **Call out specific people** when they're blocking a milestone (e.g., "Sarah, Mike, still need your vibes").
4. **Reference progress when motivating.** "You're almost there — just need to finalize the itinerary and you're set."

The agent NEVER says "you're at level 7 of 12." It describes what's needed in plain language. The level number is internal.

## How the Overview Visualizes This System

The Output-Backed Screen (scope 16) turns this into the visual:

- **App:** Progress bar or checklist (design deliverable) showing applicable milestones with their states. Each section on the overview maps to one or more milestones.
- **Infographic:** Same progress visualization rendered as a static image for iMessage.
- **Celebration:** When all applicable milestones hit Complete or N/A, confetti fires.

## Design Deliverables

These need Figma work:

1. **Milestone visualization** — How does the progress bar / checklist look in the app? How do the three states (incomplete, complete, needs attention) render visually?
2. **Empty state treatment** — What does an incomplete milestone look like on the overview? Grayed out? Prompt text? Illustrated placeholder?
3. **Needs attention flag** — Visual treatment for "was complete, now needs attention." Must be distinct from "incomplete."
4. **Infographic milestone rendering** — How does the completeness visualization translate to the static infographic image?
5. **Celebration moment** — Confetti design, animation, messaging in both app and iMessage.
