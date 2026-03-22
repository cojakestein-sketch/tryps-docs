---
id: output-backed-screen
title: "Output-Backed Screen"
scope_number: 16
owner: jake
created: 2026-03-22
last_updated: 2026-03-22
review_status: draft
---

## What

A tangible, visual deliverable that users receive and work toward throughout the trip planning process — living natively in iMessage and in the app. When someone creates a trip in iMessage today, it doesn't register that they're building something real. The output-backed screen fixes that: it's the thing you're making together as a group, and when it's complete, you have a fully planned trip end to end.

Think of it as a card-stack or scroll-book: the trip card is the front face (what exists today), and behind it are stacked section cards (flights, stay, activities, etc.) that fill in as planning progresses. The final section is the itinerary — a draggable, interactive view where everything comes together. The trip completeness levels (from iMessage Agent scope 7, SC-53) drive which cards are filled vs. empty.

## Why

Right now, texting in the group chat feels ephemeral. You log an expense, you vote on dinner, but there's no sense that you're building toward a finished product. The output-backed screen makes the trip feel tangible — like a document filling in, a progress bar advancing, a thing that exists and is yours. It gives the agent's daily facilitation a destination: "we're working toward THIS."

This is also the key to making iMessage-first feel complete. If the output-backed screen works end to end in iMessage (not just the app), non-app users have a real deliverable they can see and interact with — not just a stream of texts.

## The Feeling (from Jake)

> "I don't know exactly what I want, but I know what I want it to feel like. Users in an iMessage have a really clear deliverable that they receive, that they are working towards. When they finish that entire deliverable they have a fully planned trip end to end."

The trip card is the front. Behind it, maybe it's a stack of cards, maybe a scroll book. Inside there's the itinerary section with draggable components so someone can see all the trip stuff at a glance, easily edit natively within iMessage or the app, and physically drag things around to rearrange.

## Key Concepts

- **Card-Stack Metaphor:** Trip card is the cover. Behind it: section cards for each planning domain (flights, stay, activities, transport, expenses, etc.). Each card fills in as the group makes decisions. Empty cards show what's still needed. (See `sketch-card-stack.png` in this folder for Jake's original sketch.)
- **Itinerary as the Culmination:** The final card is the full itinerary — draggable, interactive, everything in one place. When this card is complete, the trip is planned.
- **Completeness = Levels:** This is the visual expression of the trip completeness level system (iMessage Agent SC-53). Level 1 = trip card with dates and location. Level 10 = every card filled, itinerary locked. The output-backed screen IS the level system, made tangible.
- **iMessage-Native (as much as possible):** The deliverable should work in iMessage, not require the app. Linq's capabilities and iMessage's constraints (rich links, contact cards, etc.) will determine how much interactivity is possible natively. The app version can be richer, but the iMessage version must be functional and feel real.
- **Draggable Itinerary:** Inside the itinerary card, components are draggable — users can reorder activities, move things between days, see the full picture at a glance. This works in the app for sure; iMessage version may be view-only or have limited interactivity depending on Linq.

## Success Looks Like

- Users in an iMessage group chat can SEE the trip taking shape as a tangible deliverable, not just a stream of texts
- The output-backed screen shows what's done and what's still needed — it makes "level 3 out of 10" feel real
- Non-app users can interact with the deliverable in iMessage (at minimum view, ideally edit)
- The itinerary section has draggable components in the app
- When the deliverable is "complete" (level 10), the group has a fully planned trip with itinerary, stay, flights, activities, and expenses all in one place
- The agent's daily check-ins reference the deliverable ("your trip card is at level 4, here's what we need for level 5")

## What This Is NOT

- Not a redesign of the existing trip card — the trip card is the front face of this
- Not an app-only feature — iMessage-native is the priority
- Not a separate product — it's the visual layer on top of trip completeness levels
- Not blocking existing trip flows — everything that works today keeps working

## Dependencies

- **iMessage Agent (scope 7):** Trip completeness levels (SC-53) define what each level means. The output-backed screen is the visual expression of those levels.
- **Core Trip Experience (scope 2):** The existing trip card, itinerary, and activity data model are the foundation.
- **Agent Intelligence (scope 8):** Recommendations and vote-on-behalf results populate sections of the deliverable.
- **Linq platform:** What's possible natively in iMessage determines the iMessage version's interactivity.

## Open Questions (for spec session)

- What iMessage-native formats can Linq render? Rich links? Contact cards? Inline images? Interactive elements?
- How much interactivity is possible in iMessage vs. app? Is iMessage view-only or can users tap/drag?
- Is the metaphor a card stack (swipeable), a scroll (vertical), or something else?
- How do section cards map to completeness levels? 1:1 or more fluid?
- What happens to the deliverable after the trip? Does it become the post-trip review artifact?
- Does each section card have its own mini-editing UI, or does editing always happen in the full app?

## Wave Assignment

- **Wave 1:** Define the card-stack structure, map sections to completeness levels, Linq capability audit for iMessage rendering
- **Wave 2:** Build the app version (card stack + draggable itinerary), build the iMessage version (best possible within Linq constraints)
- **Wave 3:** Integration with agent daily check-ins, QA pass

## Reference

- Jake's sketch: `sketch-card-stack.png` (trip card → section cards → itinerary with draggable components)
- Trip completeness levels: `scopes - refined 3-20/imessage-agent/spec.md` SC-53
- Existing trip card: Core Trip Experience (scope 2)
