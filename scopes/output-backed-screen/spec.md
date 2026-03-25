---
id: output-backed-screen
title: "Output-Backed Screen"
status: specced
assignee: nadeem
wave: 1
dependencies: [core-trip-experience, imessage-agent, agent-intelligence, post-trip-retention]
clickup_ids: []
criteria_count: 48
criteria_done: 0
last_updated: 2026-03-22
links:
  design: ./design.md
  testing: ./testing.md
  objective: ./objective.md
  state: ./state.md
  completeness_levels: ./completeness-levels.md
---

# Output-Backed Screen — Spec

## What

A single, glanceable view of your entire trip — flights, stay, day-by-day itinerary — that lives as an interactive overview in the app and as a dynamically generated infographic in iMessage. The group builds toward it together like a due diligence checklist, checking off milestones as planning progresses.

## Why

Trip planning in a group chat feels ephemeral. The output-backed screen makes the trip feel like a THING — a checklist filling in, progress visible, a deliverable the group owns together. It gives the agent's daily facilitation a destination and gives non-app users a real artifact, not just a thread of texts.

## Intent

> "All I really care about is that there's something in iMessage that links to a screen in the app where it's super easy for me to, in one view, look at everything I need to know about my trip. Almost like if there was only one thing that you looked at the second before the trip was about to start, you would know everything."
>
> "I almost think of it as a due diligence checklist. The group is checking them off as we go along. Agents are executing on scopes on the people's behalf or people are making decisions."
>
> "How do we service all types of customers with all sorts of different combinations of groups and different levels of wants and preferences? The opening question is: tell me what you want, tell me where you are, and we can help you."

## Key Concepts

**One View:** Flights, stay, day-by-day itinerary, completeness progress — all on one screen. The "second before departure" test.

**Adaptive Completeness:** The milestone system flexes per trip. Complex international trip: ~15 milestones. Road trip: 3-4. The system assesses what THIS trip needs. See `completeness-levels.md`.

**Trip Spectrum:** Direct trips ("Aspen, these dates, just book it") skip ahead. Ideated trips ("6 friends, don't know where or when") start from scratch. Everything in between.

**iMessage Infographic:** Dynamically generated image showing trip overview. Tapping opens the app. Updates on demand and with daily check-in.

**App Interactive Overview:** Inline editing, drag-and-drop itinerary reordering (within and between days). The full experience.

---

## Success Criteria

### Trip Overview — App

- [ ] **SC-1.** A single screen in the app shows the complete trip overview: trip name, dates, destination, participants, and all planning sections (flights, stay, activities, transport, reservations, itinerary). Verified by: open a trip with data in all sections -> one screen shows everything -> no section requires navigating to a separate page to see its summary.

- [ ] **SC-2.** Each planning section on the overview shows its current state: completed (data filled), in progress (partial data), or empty (nothing yet). Verified by: create a trip with flights booked but no stay -> flights section shows flight details -> stay section shows empty state with prompt -> visual distinction between the three states is immediately obvious.

- [ ] **SC-3.** The overview shows the trip's completeness progress as a visual indicator (progress bar, checklist, or combination — design deliverable). Verified by: trip has 5 of 8 applicable milestones completed -> progress indicator reflects ~62% -> adding a milestone visibly advances the indicator.

- [ ] **SC-4.** The overview adapts to the trip type. Sections that don't apply to THIS trip are not shown. Verified by: create a road trip (no flights) -> flights section does not appear on the overview -> completeness is calculated based on applicable sections only.

- [ ] **SC-5.** The overview loads in under 2 seconds with all sections populated. Verified by: open a fully planned trip with flights, stay, 10+ activities, and itinerary -> overview renders completely within 2 seconds on a standard connection.

### Inline Editing

- [ ] **SC-6.** A user can edit any section inline on the overview without navigating to a separate screen. Verified by: tap the stay section -> edit the check-in date directly on the overview -> change saves -> overview reflects updated date without page navigation.

- [ ] **SC-7.** Inline edits sync to the backend and are reflected in iMessage (next time the infographic is generated). Verified by: edit an activity time inline -> save -> request infographic in iMessage ("what's the plan?") -> infographic shows the updated time.

- [ ] **SC-8.** Inline editing supports all editable fields across sections: activity names/times, stay details, flight details, transport details, reservation details. Verified by: attempt to edit at least one field in each section type -> all edits save correctly.

### Draggable Itinerary

- [ ] **SC-9.** Activities within a single day can be reordered via drag-and-drop. Verified by: day has 3 activities (beach, lunch, dinner) -> drag lunch above beach -> order updates to (lunch, beach, dinner) -> order persists after closing and reopening.

- [ ] **SC-10.** Activities can be moved between days via drag-and-drop. Verified by: Tuesday has "dinner at Nobu" -> drag it to Wednesday -> Tuesday no longer shows it -> Wednesday shows it -> backend reflects the change.

- [ ] **SC-11.** Drag-and-drop provides clear visual feedback during the drag: the item being dragged is visually lifted, the drop target is highlighted, and invalid drop zones are indicated. Verified by: start dragging an activity -> item visually lifts with shadow -> valid day slots highlight -> dropping on an invalid area snaps back.

- [ ] **SC-12.** Drag-and-drop works smoothly with 15+ activities across 5+ days. Verified by: create a trip with 18 activities across 7 days -> drag activities between days -> no jank, no dropped frames, no failed drops.

- [ ] **SC-13.** After a drag-and-drop reorder, the change syncs to the backend within 2 seconds. Verified by: drag an activity from Monday to Wednesday -> check backend data within 2 seconds -> order reflects the change -> other users see the updated order on refresh.

### Adaptive Completeness System

- [ ] **SC-14.** When a trip is created, the system generates a set of applicable milestones based on the trip type. Verified by: create a domestic road trip -> milestones include dates, destination, stay, activities, itinerary -> milestones do NOT include flights -> create an international flight trip -> milestones include flights.

- [ ] **SC-15.** The milestone set can be modified after trip creation if the trip changes (e.g., group decides to fly instead of drive). Verified by: road trip has no flights milestone -> user adds flight info -> flights milestone appears in the checklist -> completeness recalculates.

- [ ] **SC-16.** Each milestone has a clear completion condition that the system can evaluate automatically. Verified by: "dates locked" milestone completes when trip has start and end dates -> "stay picked" completes when at least one accommodation is confirmed -> no milestone requires manual check-off by the user.

- [ ] **SC-17.** The milestone system supports the full trip spectrum. A direct trip ("Aspen, March 15-18, skiing") starts with several milestones already complete. An ideated trip ("6 friends, no idea where") starts with nearly all milestones empty. Verified by: create a direct trip with dates, destination, and activity already specified -> 3+ milestones auto-complete on creation -> create an ideated trip with only participants -> 0-1 milestones complete.

- [ ] **SC-18.** When a completed milestone's data is invalidated (e.g., Airbnb falls through), the milestone shows a "needs attention" flag rather than reverting to incomplete. Verified by: trip has stay confirmed (milestone complete) -> stay is cancelled -> milestone shows "needs attention" indicator -> overall progress does not decrease.

- [ ] **SC-19.** The agent can read the current milestone state for any trip and use it to determine what to ask for next in daily check-ins. Verified by: trip has dates and destination locked, no stay -> agent's daily check-in focuses on accommodation -> stay is picked -> next check-in shifts focus to activities.

### iMessage Infographic

- [ ] **SC-20.** The agent can generate a visual infographic image of the trip overview that shows: trip name, dates, destination, participant count, and the status of each applicable section (completed/in-progress/empty). Verified by: request "what's the plan?" in iMessage -> agent sends an image -> image shows all trip sections with their current state -> image is legible on an iPhone screen.

- [ ] **SC-21.** The infographic updates reflect the latest trip data at the time of generation. Verified by: add a restaurant reservation in the app -> request infographic in iMessage -> infographic shows the new reservation.

- [ ] **SC-22.** The infographic includes a completeness indicator matching the app's progress visualization. Verified by: trip is at 60% completeness in the app -> infographic shows equivalent progress -> they match.

- [ ] **SC-23.** Tapping the infographic in iMessage opens the app to the trip overview. Verified by: receive infographic in iMessage -> tap it -> app opens -> lands on the trip overview for that specific trip.

- [ ] **SC-24.** For non-app users, tapping the infographic opens a mobile web view or app download prompt. Verified by: non-app user receives infographic -> taps it -> sees either a web version of the overview or a prompt to download with a preview of what they'd see.

- [ ] **SC-25.** The infographic is sent automatically with the agent's daily check-in message. Verified by: daily check-in fires -> message includes the infographic image alongside the text about what's needed next.

- [ ] **SC-26.** The infographic is sent on demand when a user asks about the plan. Verified by: user texts "what's the plan?" or "show me the trip" -> agent responds with the infographic + brief text summary.

- [ ] **SC-27.** The infographic renders correctly for trips at all stages: empty (just created), partially planned, and fully planned. Verified by: generate infographic for a brand-new trip (just name + dates) -> shows mostly empty sections -> generate for a fully planned trip -> shows all sections filled -> both are legible and useful.

### Infographic Visual Quality

- [ ] **SC-28.** The infographic follows Tryps brand guidelines: Plus Jakarta Sans, Tryps Red (#D9071C), warm color palette, film camera warmth. Verified by: compare infographic against brand.md tokens -> fonts, colors, and spacing match.

- [ ] **SC-29.** The infographic is optimized for iMessage display: legible at iMessage image size without zooming, appropriate contrast, no text smaller than 11px equivalent. Verified by: view infographic on iPhone 14 in iMessage -> all text readable without pinching to zoom.

- [ ] **SC-30.** The infographic has a distinct visual state for "trip ready" (all milestones complete) vs. "in progress." Verified by: compare infographic for a 60% trip vs. a 100% trip -> the complete version has a visually distinct "done" treatment.

### Celebration Moment

- [ ] **SC-31.** When a trip reaches 100% completeness (all applicable milestones done), the app shows a celebration animation (confetti or equivalent). Verified by: complete the last remaining milestone -> confetti animation plays -> animation is satisfying and on-brand (warm, not corporate).

- [ ] **SC-32.** When a trip reaches 100% completeness, the agent sends a celebration message in iMessage alongside the final infographic. Verified by: last milestone completes -> agent sends message in group chat acknowledging the trip is fully planned -> includes the "complete" version of the infographic.

- [ ] **SC-33.** The celebration happens exactly once per trip. Verified by: trip hits 100% -> confetti plays -> a "needs attention" flag appears on one milestone -> flag is resolved, back to 100% -> confetti does NOT play again.

### Post-Trip Handoff

- [ ] **SC-34.** When a trip's end date passes, the overview freezes into a read-only "trip memory" state. Verified by: trip end date was yesterday -> open overview -> all sections visible but editing and dragging are disabled -> visual treatment changes to indicate "past trip."

- [ ] **SC-35.** The frozen trip overview is accessible as the starting point for the post-trip review flow (scope 6). Verified by: open a past trip -> overview shows frozen state -> "review this trip" action is visible and leads to the post-trip review experience.

### Multi-User & Sync

- [ ] **SC-36.** Changes made by one user (inline edits, drag reorder) are visible to all trip members within 5 seconds. Verified by: User A drags an activity from Monday to Tuesday -> User B refreshes the overview within 5 seconds -> sees the updated itinerary.

- [ ] **SC-37.** The overview displays correctly for trips with 2 to 15 participants. Verified by: create trips with 2, 6, and 15 participants -> overview renders participant section correctly for all sizes -> no layout overflow or truncation that hides data.

- [ ] **SC-38.** When two users edit the same section simultaneously, the last write wins and both users see the resolved state without errors. Verified by: User A and User B both edit the stay check-in time within 1 second -> no crash, no error -> both users see the same final value.

### Edge Cases

- [ ] **SC-39.** A trip with no data beyond name and dates shows a useful empty state with clear prompts for what to do next. Verified by: create a trip with just "Vegas" and dates -> overview shows empty sections with prompts like "add flights" -> the overview is not blank or confusing.

- [ ] **SC-40.** A multi-city trip shows sections per city/leg. Verified by: create a trip with 2 cities (Barcelona -> Ibiza) -> overview shows flights, stay, and activities grouped by city -> itinerary shows the transition between cities.

- [ ] **SC-41.** A trip with no end date (open-ended) shows sections without a day-by-day itinerary until dates are locked. Verified by: create a trip with destination but no dates -> overview shows destination and applicable sections -> itinerary section shows "lock in dates to build the itinerary."

- [ ] **SC-42.** The overview handles long activity names, long destination names, and edge-case text gracefully (truncation, wrapping). Verified by: add an activity named "Traditional Balinese Cooking Class with Chef Wayan in Ubud" -> overview displays it without layout breakage.

- [ ] **SC-43.** The infographic handles trips with 0 activities, 1 activity, and 20+ activities gracefully. Verified by: generate infographics for all three cases -> all are legible -> the 20+ activity version summarizes rather than listing every item.

---

## Should NOT Happen

- [ ] **SC-44.** The overview does NOT show sections that are irrelevant to the trip (e.g., flights on a road trip) unless the user explicitly adds them. Verified by: create 3 trip types (road trip, domestic flight, international) -> each shows only applicable sections.

- [ ] **SC-45.** The infographic is NOT sent on every change. It's sent on demand and with daily check-ins only. Verified by: make 5 changes to a trip within an hour -> 0 automatic infographic sends -> request "what's the plan?" -> 1 infographic sent.

- [ ] **SC-46.** Drag-and-drop does NOT work on past/frozen trips. Verified by: open a past trip -> attempt to drag an activity -> drag does not initiate -> no error, just non-interactive.

- [ ] **SC-47.** The celebration does NOT fire for milestone states that were set on trip creation (direct trips). Only milestones completed AFTER creation count toward the celebration trigger. Verified by: create a direct trip that starts at 80% -> complete the remaining 20% -> confetti fires -> but NOT on creation.

- [ ] **SC-48.** The completeness system does NOT block any user action. Users can always add, edit, or remove trip data regardless of milestone state. Verified by: trip is at "trip ready" (100%) -> user adds another activity -> activity is added -> milestone system adjusts (may flag "needs attention" on itinerary) -> user is never prevented from acting.

---

## Out of Scope

- **Interactive elements inside iMessage** (drag-and-drop, inline editing in iMessage): iMessage version is an infographic that taps through to the app. No in-chat interaction beyond viewing.
- **Trip card redesign**: The existing trip card (scope 2) is the entry point. This scope extends it with the overview, doesn't replace it.
- **Booking through the overview**: The overview shows booking status but doesn't initiate bookings. That's scope 10 (Travel Booking).
- **Custom milestone definitions by users**: The system determines milestones. Users don't create custom ones.
- **Real-time collaborative editing** (Google Docs style): Last-write-wins is sufficient. No cursor presence or real-time co-editing.
- **Android iMessage equivalent**: Post-April 2.

## Regression Risk

| Area | Why | Risk |
|------|-----|------|
| Trip card | Overview extends the trip card entry point | Medium |
| Itinerary data model | Drag-and-drop reorder writes to itinerary tables | High |
| Activity data | Inline editing writes to same activity tables as other flows | High |
| Agent daily check-ins | Infographic generation integrates with SC-25 pipeline | Medium |
| iMessage rendering | Infographic image generation is a new pipeline via Linq | Medium |
| Post-trip review | Frozen overview becomes the post-trip artifact | Low |

## Dependencies

| Scope | What's Needed | Blocks |
|-------|--------------|--------|
| core-trip-experience (#2) | Existing trip card, itinerary, activity data model | SC-1 through SC-13 (overview + drag-and-drop build on existing data) |
| imessage-agent (#7) | Daily check-in pipeline (SC-25), on-demand query handling, Linq image sending | SC-20 through SC-27 (infographic delivery), SC-19 (agent reads milestones) |
| agent-intelligence (#8) | Recommendations and vote results populate overview sections | SC-2 (section state reflects agent-driven data) |
| post-trip-retention (#6) | Post-trip review flow accepts frozen overview as input | SC-34, SC-35 (post-trip handoff) |
| brand-design-system (#11) | Brand tokens for infographic rendering | SC-28, SC-29 (visual quality) |
| Linq platform | Image sending capability, rich link deep linking | SC-20 through SC-27 (iMessage delivery) |
