---
id: output-backed-screen
qa_assignee: andreas
test_status: not-started
criteria_total: 48
criteria_passing: 0
last_tested: null
last_updated: 2026-03-22
---

> Parent: [[output-backed-screen/objective|Output-Backed Screen Objective]]

# Output-Backed Screen — Testing Plan

## How to Test

Most tests require the Tryps app (TestFlight build) and a trip with varying amounts of data. iMessage tests require the Linq-connected Tryps number and at least 2 iPhones. Drag-and-drop tests require physical device testing (simulator drag behavior differs from real devices).

## Trip Overview — App (SC-1 to SC-5)

- [ ] **SC-1.** Open a trip with data in all sections -> one screen shows everything (flights, stay, activities, transport, reservations, itinerary) -> no section requires separate page navigation
- [ ] **SC-2.** Trip with flights booked but no stay -> flights show details -> stay shows empty state with prompt -> visual distinction between completed, in-progress, and empty is immediately obvious
- [ ] **SC-3.** Trip has 5 of 8 applicable milestones completed -> progress indicator reflects ~62% -> add a milestone -> indicator visibly advances
- [ ] **SC-4.** Create road trip (no flights) -> flights section does not appear -> completeness calculated on applicable sections only
- [ ] **SC-5.** Open fully planned trip (flights, stay, 10+ activities, itinerary) -> overview renders within 2 seconds

## Inline Editing (SC-6 to SC-8)

- [ ] **SC-6.** Tap stay section -> edit check-in date inline -> change saves -> overview reflects update without page navigation
- [ ] **SC-7.** Edit activity time inline -> save -> request infographic in iMessage ("what's the plan?") -> infographic shows updated time
- [ ] **SC-8.** Edit at least one field in each section type (activity, stay, flight, transport, reservation) -> all save correctly

## Draggable Itinerary (SC-9 to SC-13)

- [ ] **SC-9.** Day has 3 activities (beach, lunch, dinner) -> drag lunch above beach -> order: lunch, beach, dinner -> persists after close/reopen
- [ ] **SC-10.** Tuesday has "dinner at Nobu" -> drag to Wednesday -> Tuesday no longer shows it -> Wednesday shows it -> backend reflects change
- [ ] **SC-11.** Start drag -> item lifts with shadow -> valid day slots highlight -> drop on invalid area snaps back
- [ ] **SC-12.** Trip with 18 activities across 7 days -> drag between days -> no jank, no dropped frames, no failed drops
- [ ] **SC-13.** Drag activity Monday to Wednesday -> check backend within 2 sec -> order reflects change -> other users see updated order on refresh

## Adaptive Completeness System (SC-14 to SC-19)

- [ ] **SC-14.** Create domestic road trip -> milestones: dates, destination, stay, activities, itinerary -> NO flights milestone -> create international flight trip -> flights milestone present
- [ ] **SC-15.** Road trip has no flights milestone -> add flight info -> flights milestone appears -> completeness recalculates
- [ ] **SC-16.** "Dates locked" completes when trip has start + end dates -> "stay picked" completes when accommodation confirmed -> no manual check-off needed
- [ ] **SC-17.** Create direct trip (dates + destination + activity specified) -> 3+ milestones auto-complete -> create ideated trip (only participants) -> 0-1 milestones complete
- [ ] **SC-18.** Stay confirmed (milestone complete) -> cancel stay -> milestone shows "needs attention" -> overall progress does NOT decrease
- [ ] **SC-19.** Trip has dates + destination, no stay -> agent daily check-in focuses on accommodation -> stay picked -> next check-in shifts to activities

## iMessage Infographic (SC-20 to SC-27)

- [ ] **SC-20.** Text "what's the plan?" in iMessage -> agent sends image -> shows all sections with current state -> legible on iPhone
- [ ] **SC-21.** Add restaurant reservation in app -> request infographic -> shows new reservation
- [ ] **SC-22.** Trip at 60% in app -> infographic shows equivalent progress -> they match
- [ ] **SC-23.** Receive infographic -> tap -> app opens to trip overview for that specific trip
- [ ] **SC-24.** Non-app user taps infographic -> sees web view or app download prompt with preview
- [ ] **SC-25.** Daily check-in fires -> message includes infographic alongside text
- [ ] **SC-26.** Text "what's the plan?" or "show me the trip" -> agent responds with infographic + brief text
- [ ] **SC-27.** Generate infographic for: brand-new trip (just name + dates), partially planned, fully planned -> all legible and useful

## Infographic Visual Quality (SC-28 to SC-30)

- [ ] **SC-28.** Compare infographic against brand.md -> Plus Jakarta Sans, Tryps Red (#D9071C), warm palette -> fonts/colors/spacing match
- [ ] **SC-29.** View infographic on iPhone 14 in iMessage -> all text readable without pinch-to-zoom
- [ ] **SC-30.** Compare infographic for 60% trip vs 100% trip -> complete version has distinct "done" treatment

## Celebration Moment (SC-31 to SC-33)

- [ ] **SC-31.** Complete last remaining milestone -> confetti animation plays -> warm and on-brand
- [ ] **SC-32.** Last milestone completes -> agent sends celebration message + "complete" infographic in iMessage
- [ ] **SC-33.** Trip hits 100% -> confetti -> "needs attention" flag appears -> resolved -> back to 100% -> confetti does NOT play again

## Post-Trip Handoff (SC-34 to SC-35)

- [ ] **SC-34.** Trip end date was yesterday -> open overview -> all visible but editing + dragging disabled -> visual treatment indicates "past trip"
- [ ] **SC-35.** Open past trip -> frozen overview -> "review this trip" action visible -> leads to post-trip review

## Multi-User & Sync (SC-36 to SC-38)

- [ ] **SC-36.** User A drags activity Monday to Tuesday -> User B refreshes within 5 sec -> sees updated itinerary
- [ ] **SC-37.** Create trips with 2, 6, and 15 participants -> overview renders participant section correctly -> no overflow/truncation
- [ ] **SC-38.** User A and User B edit stay check-in time within 1 sec -> no crash -> both see same final value

## Edge Cases (SC-39 to SC-43)

- [ ] **SC-39.** Create trip with just "Vegas" + dates -> empty sections with prompts -> not blank/confusing
- [ ] **SC-40.** Multi-city trip (Barcelona -> Ibiza) -> sections grouped by city -> itinerary shows transition
- [ ] **SC-41.** Trip with destination but no dates -> applicable sections show -> itinerary says "lock in dates to build the itinerary"
- [ ] **SC-42.** Activity named "Traditional Balinese Cooking Class with Chef Wayan in Ubud" -> displays without layout breakage
- [ ] **SC-43.** Infographics for: 0 activities, 1 activity, 20+ activities -> all legible -> 20+ summarizes

## Should NOT Happen (SC-44 to SC-48)

- [ ] **SC-44.** 3 trip types (road trip, domestic flight, international) -> each shows only applicable sections
- [ ] **SC-45.** Make 5 changes within an hour -> 0 automatic infographic sends -> request "what's the plan?" -> 1 infographic
- [ ] **SC-46.** Past trip -> attempt drag -> does not initiate -> no error
- [ ] **SC-47.** Direct trip starts at 80% -> complete remaining 20% -> confetti -> but NOT on creation
- [ ] **SC-48.** Trip at 100% -> add another activity -> activity added -> milestone system adjusts -> user never blocked

## Regression Tests

| Area | Test | Priority |
|------|------|----------|
| Trip itinerary data | Drag in overview -> verify in standard itinerary view -> edit in standard view -> verify in overview | High |
| Activity data | Inline edit in overview -> verify in activity detail -> edit in detail -> verify in overview | High |
| iMessage sync | Edit in app -> request infographic -> verify data matches | High |
| Milestone state | Complete milestone -> verify agent check-in changes focus | Medium |
| Post-trip freeze | Trip ends -> verify no edits possible -> verify review handoff works | Medium |
| Multi-user | Simultaneous edits from 2 users -> verify sync and no data loss | High |

## Device Matrix

| Device | Why |
|--------|-----|
| iPhone SE (375px) | Smallest supported width — layout must not break |
| iPhone 14 (390px) | Standard test device |
| iPhone 14 Pro Max (430px) | Largest width — verify layout uses space well |
| iPad (if supported) | Verify overview doesn't break on tablet widths |

## Test Data Requirements

- **Empty trip:** Name + dates only
- **Partial trip:** Flights + stay, no activities
- **Full trip:** All sections filled, 10+ activities across 5 days
- **Road trip:** No flights, 3-day weekend
- **International multi-city:** 2+ cities, flights between legs
- **Large group:** 15 participants
- **Past trip:** End date in the past
