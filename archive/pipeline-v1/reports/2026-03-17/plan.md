# Plan — Morning Report 2026-03-17

> **Branch:** `fix/morning-report-0317`
> **Base:** `develop`
> **Spec:** `/Users/jakestein/tryps-docs/scopes/reports/2026-03-17/spec.md`

---

## Summary

17 total items from spec (8 bugs, 6 UX issues, 3 ideas/improvements).
- **In-scope:** 11 tasks (implementable without design work)
- **Skipped:** 6 tasks (require design, Figma audit, or full rework)

---

## Skipped Items

| # | Item | Reason |
|---|------|--------|
| S1 | Calendar tab does not match Figma design (UX) | Requires Figma audit + design team review. Follow-up assigned to design team. |
| S2 | Dress code feature needs a rework (Idea) | Requires design rethink/brainstorm. Follow-up assigned to Jake + design. |
| S3 | Drag activities between Discover and voting block (Idea) | Requires drag-and-drop gesture architecture across bottom sheets (DiscoverSheet + VotingBlockSheet). Large scope, needs spec. |
| S4 | Share trip directly from home screen (Idea) | Already partially implemented (swipe-up-to-share on StackedTripCards). Needs design for long-press sheet UX. |
| S5 | Itinerary tab left-hand slider not working (UX) | No slider/rail component exists in the codebase. Likely a design intent that was never built. Needs spec for what the left-hand slider should do. |
| S6 | Trending songs in NYC not working (Bug) | Backend issue (Supabase edge function `fetch-apple-music-charts` / `fetch-regional-music`). The client code is correct; the `getShazamLocation` util correctly maps "New York" to city charts. This needs backend debugging of the edge function responses, not a client fix. Flag for backend investigation. |

---

## Task List (Grouped by Component)

### Group 1: Explore Tab — Globe Not Loading + Dark Background
**Files:**
- `/Users/jakestein/t4/components/TravelMap/GlobeView.tsx`
- `/Users/jakestein/t4/assets/globe/globeHtmlSource.ts`
- `/Users/jakestein/t4/app/(tabs)/explore.tsx`

**Task 1.1** — Fix globe not rendering on Explore tab
- **Spec:** "Explorer globe not loading"
- **Complexity:** Medium
- **Analysis:** GlobeView uses a WebView with a 10-second timeout. If the globe doesn't send a "ready" message within 10s, it shows a retry button. The globe HTML (`globeHtmlSource.ts`) bundles globe.gl inline. Investigate: (a) WebView fails to load the inline HTML (check `GLOBE_HTML` is valid), (b) the `ready` message is never posted, or (c) the `onMessage` handler doesn't fire. Add error logging and verify the WebView `source` prop. Check if a recent Expo SDK / react-native-webview update broke inline HTML loading.

**Task 1.2** — Fix Explore tab background too dark in light mode
- **Spec:** "Explore tab background too dark in light mode"
- **Complexity:** Small
- **Analysis:** The globe HTML has `background: #1A2B3C` hardcoded (line 22 of globeHtmlSource.ts), and the ExploreScreen's outer container also has `backgroundColor: "#1A2B3C"` (line 329 of explore.tsx styles). In light mode this should be lighter (e.g., `#f5f7fa`). Fix: use `useTheme()` colors for the container background, and optionally inject a theme-aware background into the WebView.

---

### Group 2: People Tab — Background Color + Flight Adding
**Files:**
- `/Users/jakestein/t4/app/(tabs)/people.tsx`
- `/Users/jakestein/t4/components/PeopleTab.tsx`

**Task 2.1** — Fix People tab cream background
- **Spec:** "People tab has cream background"
- **Complexity:** Small
- **Analysis:** The People screen at `app/(tabs)/people.tsx` uses `colors.background` from the theme context (line 214, 219, 521). The cream color likely comes from the theme's `background` value not matching other tabs. Verify the `colors.background` value and ensure it matches the standard `#F5F7FA` used by other tabs (e.g., HomeNew uses `bg-[#F5F7FA]`). May need to hardcode or override the background to match.

**Task 2.2** — Fix unable to add flights in People tab
- **Spec:** "Unable to add flights in the People tab"
- **Complexity:** Medium
- **Analysis:** `PeopleTab.tsx` has `handleAddFlightForParticipant` (line 209) that navigates to `/trip/${trip.id}/add-flight`. The `add-flight.tsx` route exists at `/Users/jakestein/t4/app/trip/[id]/add-flight.tsx`. Investigate: (a) is the "add flight" button actually rendered and visible in the PeopleTab UI, (b) does the navigation work, (c) does the add-flight form save correctly. Check if the button is behind a condition that's not met (e.g., `canEdit` being false, or the flight section not rendering).

---

### Group 3: Trip Detail — Default Tab + Itinerary Date Picker
**Files:**
- `/Users/jakestein/t4/components/TripHeader.tsx`
- `/Users/jakestein/t4/components/trip-detail/NewTripDetails.tsx`
- `/Users/jakestein/t4/components/trip-detail/PlanTab.tsx`

**Task 3.1** — Make Itinerary the default tab instead of Activities
- **Spec:** "App lands on Activities tab instead of Itinerary tab"
- **Complexity:** Small
- **Analysis:** In `TripHeader.tsx`, `CORE_TABS` array has `"activities"` as index 0 and `"itinerary"` as index 1 (lines 16-23). The `TRIP_TABS = CORE_TABS` export (line 82) is used in `NewTripDetails.tsx` as the default tab order. The `Pager` starts at index 0 by default. Fix: reorder `CORE_TABS` so `"itinerary"` is first, OR set `initialPage={1}` on the Pager (the index of itinerary in the current order).

**Task 3.2** — Fix itinerary date picker not scrolling to selected date
- **Spec:** "Itinerary date picker at top doesn't move"
- **Complexity:** Medium
- **Analysis:** In `PlanTab.tsx`, the date strip (lines 362-425) calls `handleNavigateToDay(day.dateStr)` on press. `handleNavigateToDay` (lines 287-317) uses `scrollRef` + `measureLayout` to scroll. The issue is likely that `scrollRef` is not properly connected when PlanTab is rendered inside the HeaderMotion `Pager` (NewTripDetails). The Pager may provide its own ScrollView that doesn't match the `scrollRef`. Investigate the scroll ref chain and ensure `handleNavigateToDay` can actually scroll to the target.

---

### Group 4: Vibe Tab — Group Vibe Not Saving + Mood Board Delete
**Files:**
- `/Users/jakestein/t4/hooks/useTripVibe.ts`
- `/Users/jakestein/t4/components/vibe/MoodBoardSection.tsx`
- `/Users/jakestein/t4/apis/vibetab/useVibeTabMutations.ts`

**Task 4.1** — Fix group vibe not saving
- **Spec:** "Group vibe not saving"
- **Complexity:** Medium
- **Analysis:** `useTripVibe.ts` has a `save()` function that writes the user's individual vibe to Supabase via RPC. The `groupVibe` is loaded via `loadGroupVibe()` and cached with a 5-minute staleness window. Investigate: (a) does `save()` actually call the Supabase RPC successfully, (b) after saving, does `loadGroupVibe()` re-fetch and show the updated aggregate, (c) is there a race condition where the stale cache (`GROUP_VIBE_STALE_MS`) prevents seeing the update on return. Likely fix: force-refresh group vibe after save, or reduce/bypass the staleness window after a save.

**Task 4.2** — Fix unable to remove photos from mood board
- **Spec:** "Unable to remove photos from mood board"
- **Complexity:** Small
- **Analysis:** `MoodBoardSection.tsx` already has delete functionality in `handleItemLongPress` (lines 67-94) — it shows an Alert with "Remove" option that calls `mutations.delete.mutate(item.id)`. However, the spec says "no delete/remove action available." Check: (a) is `handleItemLongPress` actually connected to the rendered MoodBoardCard components, (b) is the `canEdit` prop preventing the alert from showing. The `canEdit` guard on line 69 only blocks if `!canEdit && item.userId !== user?.id` — so if `canEdit` is false and the item belongs to someone else, the long-press does nothing. But for the photo type (line 62), `handleItemPress` returns early without any action. The issue may be that photos aren't getting the long-press handler wired up on the MoodBoardCard component.

---

### Group 5: Home Screen — Tab Label + Dot Indicator Lag
**Files:**
- `/Users/jakestein/t4/components/home/HomeNew.tsx`
- `/Users/jakestein/t4/components/StackedTripCards.tsx`

**Task 5.1** — Fix "My Trip" to "My Trips" (plural)
- **Spec:** "Tab name says 'My Trip' instead of 'My Trips'"
- **Complexity:** Small
- **Analysis:** `HomeNew.tsx` line 61 has `values={["My Trip", "Discover"]}`. Change to `values={["My Trips", "Discover"]}`.

**Task 5.2** — Fix trip card swipe navigation dots lag
- **Spec:** "Trip card swipe navigation dots lag"
- **Complexity:** Medium
- **Analysis:** `StackedTripCards.tsx` uses `AnimatedDot` components (lines 169-192) driven by `animatedIndex` SharedValue. The dots use `useAnimatedStyle` with `interpolate` on the distance from `animatedIndex.value`. This should be smooth since it's all on the UI thread via Reanimated. Investigate: (a) is the `animatedIndex` SharedValue being updated smoothly during the gesture (check `onUpdate` in the pan gesture), (b) is there a JS-thread round-trip causing delay (check if `runOnJS(completeTransition)` fires too late), (c) check if the `withSpring` animation config causes the dots to lag behind the card position. May need to ensure the dots track `animatedIndex` directly without spring delay, or adjust the spring config.

---

### Group 6: Share — Bottom Sheet Modal
**Files:**
- `/Users/jakestein/t4/app/trip/[id]/share.tsx`
- `/Users/jakestein/t4/components/trip-detail/NewTripDetails.tsx`

**Task 6.1** — Convert share action to bottom sheet modal
- **Spec:** "Share action should be a bottom sheet modal"
- **Complexity:** Medium
- **Analysis:** Currently `share.tsx` is a full-screen route (`app/trip/[id]/share.tsx`) rendered via Expo Router stack navigation. To make it a bottom sheet: either (a) convert the route to use `presentation: "modal"` or `presentation: "transparentModal"` in the Stack.Screen options, or (b) extract the share UI into a reusable `ShareTripSheet` component using `@gorhom/bottom-sheet` (already used elsewhere in the app) and render it inline in `NewTripDetails.tsx`. Option (a) is simpler — add modal presentation to the existing route's Stack.Screen options.

---

## Implementation Order

1. **Task 5.1** — "My Trip" -> "My Trips" (trivial string change, instant win)
2. **Task 3.1** — Default to Itinerary tab (reorder array or set initialPage)
3. **Task 2.1** — People tab background color fix
4. **Task 1.2** — Explore tab light mode background
5. **Task 1.1** — Globe not loading (deeper investigation needed)
6. **Task 4.2** — Mood board photo removal
7. **Task 4.1** — Group vibe not saving
8. **Task 2.2** — Flight add from People tab
9. **Task 3.2** — Itinerary date picker scroll
10. **Task 5.2** — Dot indicator lag
11. **Task 6.1** — Share as bottom sheet

---

## Verification Checklist

Each task must:
1. Pass `npm run typecheck`
2. Match the "Verified by" test from the spec
3. Be committed with format: `fix(report-0317): short description`
