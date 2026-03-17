# Jake's Morning Report — 2026-03-17

> **Status:** Active
> **Type:** Daily Report
> **Gantt ID:** `reports-2026-03-17`
> **Date:** 2026-03-17

## Overview

Broad testing session across all main tabs (Home, Calendar, Explore, People, Trip Detail). Multiple bugs found — globe not loading, vibe not saving, flights can't be added. Several UX mismatches with Figma designs, especially Calendar tab. App health: functional but rough around the edges.

## Success Criteria

### Bugs Found

- [ ] **Explorer globe not loading.** The globe visualization on the Explore tab fails to render. Verified by: open Explore tab → globe renders and is interactive.
- [ ] **Explore tab background too dark in light mode.** Background should be lighter to match light mode palette. Verified by: toggle to light mode → Explore tab background matches the light theme bg color (#f5f7fa or equivalent).
- [ ] **People tab has cream background.** Should match the app's standard background color, not cream. Verified by: open People tab → background color matches other tabs.
- [ ] **Group vibe not saving.** When setting a vibe on the Group Vibe tab, the selection does not persist. Verified by: open Group Vibe tab → select a vibe → navigate away → return → vibe selection is still there.
- [ ] **Trending songs in NYC not working.** The "Trending in [City]" feature for songs returns no results or errors. Verified by: open Vibe tab for a NYC trip → trending songs section loads with actual results.
- [ ] **Unable to remove photos from mood board.** No delete/remove action available for photos added to the mood board. Verified by: add a photo to mood board → long press or swipe → delete option appears → photo is removed.
- [ ] **Unable to add flights in the People tab.** The flight add flow is broken or missing from the People tab. Verified by: open People tab → tap add flight → flight entry form appears → flight saves successfully.
- [ ] **App lands on Activities tab instead of Itinerary tab.** When opening trip detail, the default tab should be Itinerary, not Activities. Verified by: open any trip → first visible tab is Itinerary.

### UX Issues

- [ ] **Trip card swipe navigation dots lag.** The little square indicators at the top lag behind when swiping between trips on the home screen. Verified by: swipe between 3+ trips → dot indicator updates in sync with the swipe gesture, no visible delay.
- [ ] **Tab name says "My Trip" instead of "My Trips".** Should be plural — "My Trips" with a y. Verified by: check home tab label → reads "My Trips" (plural).
- [ ] **Calendar tab does not match Figma design.** No year toggle, unclear green vs gray highlighting, trip dates don't display correctly. The whole tab needs a redesign pass. Verified by: compare Calendar tab side-by-side with Figma → year toggle exists, highlight colors are clear, trips render correctly.
- [ ] **Itinerary tab left-hand slider not working.** The day/time slider on the left side of the Itinerary tab doesn't function properly. Verified by: open Itinerary tab → slide the left rail → itinerary scrolls to corresponding time.
- [ ] **Itinerary date picker at top doesn't move.** When tapping dates at the top of the Itinerary tab, the view doesn't scroll to that date. Verified by: tap a date in the top date picker → itinerary view scrolls to that day's content.
- [ ] **Share action should be a bottom sheet modal.** Currently share is not presented as a bottom pop-up modal. Verified by: tap Share on a trip → a bottom sheet modal slides up with share options (not a full screen or inline action).

### External Feedback

No external feedback today.

### Ideas & Improvements

- [ ] **Share trip directly from home screen.** Add ability to long-press or swipe up on a trip card on the home screen to share it without opening the trip first. Verified by: long press on trip card → share sheet appears with trip invite link.
- [ ] **Dress code feature needs a rework.** Current dress code UI/UX is not meeting expectations — needs a design rethink. Verified by: new dress code design spec created and implemented.
- [ ] **Drag activities between Discover and voting block.** Users should be able to drag activities from Discover into the voting block, and drag them back out to remove them. Verified by: in Activities tab → drag an activity card from Discover section into voting block → card appears in voting → drag it back → card returns to Discover and is removed from voting.

### Follow-ups

- [ ] **Audit Calendar tab against Figma.** Pull up Figma Calendar screens and do a pixel-level comparison to identify all discrepancies. Assigned to: design team review.
- [ ] **Investigate dress code feature scope.** Determine what the reworked dress code should look like — needs a brainstorm or spec. Assigned to: Jake + design.

---

## Kickoff Prompt

> Copy and paste this into any Claude Code terminal to run the autonomous pipeline for this report. It will plan, implement, review, and get fixes ready for dev review.

```
/lfg Fix all bugs and UX issues from Jake's morning report 2026-03-17. Read the spec at /Users/jakestein/tryps-docs/scopes/reports/2026-03-17/spec.md — each checked criterion under "Bugs Found" and "UX Issues" is a fix to implement. Skip "Ideas & Improvements" (those need separate specs) and "Follow-ups" (those are investigations, not code). After each fix, check off the criterion. Run typecheck and tests before finishing.
```
