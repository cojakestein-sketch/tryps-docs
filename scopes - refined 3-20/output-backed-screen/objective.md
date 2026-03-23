---
id: output-backed-screen
title: "Output-Backed Screen"
scope_number: 16
owner: jake
created: 2026-03-22
last_updated: 2026-03-22
review_status: reviewed
---

## What

A single, glanceable view that shows everything about your trip — flights, stay, day-by-day itinerary — living in both iMessage and the app. The "second before you leave" test: if you looked at this one thing, you'd know everything you need to know.

In iMessage, it's a dynamically generated infographic that the agent sends on demand and with each daily check-in. Tapping it opens the app. In the app, it's the full interactive experience — inline editing, drag-and-drop reordering, the works.

The whole group builds toward this together. It's a due diligence checklist for trip planning: milestones get checked off as the group makes decisions, agents execute on people's behalf, and the thing fills in until the trip is fully planned.

## Why

Right now, texting in the group chat feels ephemeral. You log an expense, you vote on dinner, but there's no sense that you're building toward a finished product. The output-backed screen makes the trip feel tangible — like a checklist filling in, progress advancing, a thing that exists and is yours. It gives the agent's daily facilitation a destination: "we're working toward THIS."

This is also the key to making iMessage-first feel complete. Non-app users see the infographic and have a real deliverable — not just a stream of texts. If they trust the plan, they never need the app.

## The Feeling (from Jake)

> "All I really care about is that there's something in iMessage with draggable components that links to a screen in the app as well, with draggable components, where it's super easy for me to, in one view, look at everything I need to know about my trip. Almost like if there was only one thing that you looked at the second before the trip was about to start, you would know everything that you needed to know."

> "I almost think of it as a due diligence checklist where these are all of the scopes that we actually need to go build. The group is checking them off as we go along."

> "How do we service all types of customers who come to us with all sorts of different combinations of groups and different levels of wants and preferences? The opening question is like: tell me what you want, tell me where you are, and we can help you."

## Key Concepts

- **One View, Everything You Need:** Flights, stay, day-by-day itinerary, all in one glanceable screen. The "second before departure" test is the bar.

- **Due Diligence Checklist:** The group is checking off milestones as planning progresses. Empty items show what's left. Filled items show what's decided. The whole thing builds toward "trip ready."

- **Adaptive Completeness Levels:** The milestone system flexes based on the trip. A complex international trip might have ~15 milestones. A road trip might have 3-4. The system assesses what THIS trip needs and builds the checklist dynamically. Levels are an internal concept for the agent — they drive what it asks for next. See `completeness-levels.md` for the full milestone universe.

- **Trip Spectrum:** Every trip lands between two poles. **Direct:** "Aspen, skiing, these dates, just do it" — destination/dates/activity already known, system skips ahead. **Ideated:** "6 friends, no idea where/when/what" — system starts from scratch, guides everything. The opening move assesses where the group is.

- **iMessage = Infographic Preview:** A dynamically generated image showing the trip overview. Tapping opens the app. Updates on demand ("what's the plan?") and with the daily check-in. Same pattern as the existing trip card rich link — preview in iMessage, full experience in app.

- **App = Full Interactive Experience:** Inline editing on the overview. Drag-and-drop for itinerary reordering — moving activities between days, reordering within a day. The app is where you touch things.

- **Draggable Itinerary:** Drag solves itinerary reordering: "move dinner to Wednesday," "move the flight to the afternoon," "swap the order of these two activities." Drag operates within and between days.

- **Celebration Moment:** When the trip hits the final milestone — everything locked, itinerary finalized — confetti. In both iMessage (agent sends something) and the app (animation). The group built this together and it's done.

- **Post-Trip Handoff:** After the trip, the deliverable freezes as a memory and becomes the post-trip review artifact (scope 6). The overview transforms from planning tool to trip record.

## Success Looks Like

- Users in an iMessage group chat can SEE the trip taking shape as a tangible infographic, not just a stream of texts
- The overview shows what's done and what's still needed — progress is visible and motivating
- Non-app users see the infographic and have enough to go on the trip successfully
- In the app, users can drag activities between days and reorder within a day
- In the app, users can edit sections inline without leaving the overview
- The milestone system adapts to the trip type — road trips get fewer milestones, international multi-city trips get more
- When the trip is fully planned, confetti. The group feels like they accomplished something.
- The agent's daily check-ins reference the overview ("here's where we are, here's what's next")
- After the trip, the deliverable freezes as a memory/review artifact

## What This Is NOT

- Not a redesign of the existing trip card — the trip card is the front face / entry point
- Not a fixed 10-level system — levels are adaptive per trip
- Not an app-only feature — the iMessage infographic is a first-class deliverable
- Not a separate product — it's the visual layer on top of the adaptive completeness system
- Not blocking existing trip flows — everything that works today keeps working

## Dependencies

- **iMessage Agent (scope 7):** Daily check-ins (SC-25) reference the overview. Agent sends the infographic. Completeness levels (SC-53) are DEFINED in this scope's `completeness-levels.md` and CONSUMED by the agent.
- **Core Trip Experience (scope 2):** Existing trip card, itinerary, and activity data model are the foundation.
- **Agent Intelligence (scope 8):** Recommendations and vote results populate sections of the overview.
- **Post-Trip & Retention (scope 6):** The deliverable transforms into the post-trip review artifact after the trip ends.
- **Linq platform:** Determines what the iMessage infographic can look like (image generation, rich link format).

## Open Questions (Resolved in Spec Session)

| Question | Answer |
|----------|--------|
| Card stack vs. scroll vs. other? | Neither — it's a single overview/checklist view. The sketch was thinking-out-loud, not a spec. |
| How much interactivity in iMessage? | Infographic (image) that taps through to the app. iMessage is view-only. |
| Levels fixed or adaptive? | Adaptive. Complex trip ~15 milestones, road trip 3-4. System selects what applies. |
| Can levels go backward? | No — "needs attention" flag instead. |
| What happens post-trip? | Freezes as memory, becomes post-trip review artifact (scope 6). |
| Editing in detail view or inline? | Inline on the overview. |
| Direct vs. ideated trips? | System handles full spectrum. Assesses where the group is and builds remaining checklist. |

## Wave Assignment

- **Wave 1:** Define adaptive milestone system, Linq capability audit for infographic rendering, design the overview layout (app + infographic)
- **Wave 2:** Build the app overview (inline editing + draggable itinerary), build infographic generation pipeline, integrate with agent daily check-ins
- **Wave 3:** Celebration moment (confetti), post-trip freeze/handoff, QA pass

## Reference

- Jake's sketch: `sketch-card-stack.png` (early thinking — the final form is an overview, not a card stack)
- Trip completeness levels: `completeness-levels.md` (full milestone universe)
- iMessage Agent: `scopes - refined 3-20/imessage-agent/spec.md` SC-53, SC-25
- Existing trip card: Core Trip Experience (scope 2)
- Strategy intake: `docs/p2-p3-strategy-intake.md` Q5-Q10
