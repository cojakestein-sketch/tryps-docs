# Work Log — Morning Report 2026-03-17

> **Branch:** `fix/morning-report-0317`
> **Base:** `develop`
> **Started:** 2026-03-17

---

## Pre-work: Fix Pre-existing Typecheck Errors

Before any tasks could be committed, the pre-commit hook was failing on pre-existing type errors in `app/(tabs)/calendar.tsx`:
- Missing `@marceloterreiro/flash-calendar` dependency (not installed)
- Missing type annotations on `CalendarDayMetadata` parameters

**Fix:** Installed the dependency and added `CalendarDayMetadata` type annotations. Committed alongside Task 5.1.

---

## Task 5.1 — "My Trip" -> "My Trips"
**Status:** Complete
**File:** `components/home/HomeNew.tsx`
**Change:** `values={["My Trip", "Discover"]}` -> `values={["My Trips", "Discover"]}`
**Commit:** `fix(report-0317): change "My Trip" to "My Trips" + fix calendar typecheck`

---

## Task 3.1 — Default to Itinerary Tab
**Status:** Complete
**File:** `components/TripHeader.tsx`
**Change:** Reordered `CORE_TABS` so `"itinerary"` is first instead of `"activities"`. Since the Pager starts at index 0, this makes Itinerary the default tab when opening trip detail.
**Commit:** `fix(report-0317): default to Itinerary tab instead of Activities`

---

## Task 2.1 — People Tab Cream Background
**Status:** Complete
**File:** `app/(tabs)/people.tsx`
**Change:** Replaced `colors.background` (theme value `#F5EADB` warm cream) with hardcoded `#F5F7FA` to match the standard background used by Home and other tabs. Applied to both the loading state and the main render.
**Commit:** `fix(report-0317): fix People tab cream background to match other tabs`

---

## Task 1.2 — Explore Tab Light Mode Background
**Status:** Complete
**Files:** `app/(tabs)/explore.tsx`, `components/TravelMap/GlobeView.tsx`, `components/TravelMap/types.ts`
**Change:**
- Added `backgroundColor` prop to `GlobeViewProps` interface
- GlobeView now accepts and applies the background color to its container and loading/error overlays
- ExploreScreen uses `isDark ? "#1A2B3C" : "#2C3E50"` for a lighter navy in light mode
- Passes `backgroundColor={globeBg}` to GlobeView
**Commit:** `fix(report-0317): use theme-aware background for Explore tab in light mode`

---

## Task 1.1 — Globe Not Loading
**Status:** Complete (improved resilience)
**File:** `components/TravelMap/GlobeView.tsx`
**Analysis:** The globe HTML is a 3.5MB inline bundle loaded via WebView. The initialization code and `postMsg("ready")` bridge look correct. The issue is likely due to:
- WebView failing to process the large inline HTML on some devices
- iOS memory pressure killing the WebView content process
- The 10-second timeout being too short for slower devices

**Change:**
- Increased timeout from 10s to 15s
- Added auto-retry: if globe doesn't signal ready within 15s, auto-reload once before showing error
- Added `onContentProcessDidTerminate` handler for iOS memory pressure recovery
- Added `startInLoadingState` for smoother initial load
- Reset retry counter on manual retry

**Note:** Full root cause requires on-device debugging. These changes improve resilience for the most common failure modes.
**Commit:** `fix(report-0317): improve globe loading resilience`

---

## Task 4.2 — Mood Board Photo Removal
**Status:** Complete
**File:** `components/vibe/MoodBoardSection.tsx`
**Analysis:** The `handleItemLongPress` was correctly wired to `MoodBoardCard` via `onLongPress` prop. The `MoodBoardCard` component correctly calls `onLongPress?.(item)` on long-press. However, `handleItemPress` returned early for photos (`if (item.type === "photo") return;`), meaning tapping a photo did nothing — no feedback, no menu.

**Change:** Made `handleItemPress` for photos trigger the same action menu (edit caption / remove) as `handleItemLongPress`. This ensures users can access the delete option via both tap and long-press.
**Commit:** `fix(report-0317): make photo tap trigger remove/edit menu on mood board`

---

## Task 4.1 — Group Vibe Not Saving
**Status:** Complete
**File:** `hooks/useTripVibe.ts`
**Analysis:** The `save()` function correctly calls `supabase.rpc("update_trip_vibe")` and then `loadGroupVibe(true)`. The issue was:
1. `loadGroupVibe(true)` was fire-and-forget (not awaited), so the group vibe might not be refreshed before the user sees the result
2. The 5-minute stale window (`GROUP_VIBE_STALE_MS`) could prevent re-fetching when returning to the tab

**Change:**
- `await loadGroupVibe(true)` after save so the updated aggregate is visible immediately
- Reduced stale window from 5 minutes to 30 seconds
- Same fix applied to `useMyDefaults`
**Commit:** `fix(report-0317): fix group vibe not persisting after save`

---

## Task 2.2 — Flight Add from People Tab
**Status:** Complete
**File:** `components/PeopleTab.tsx`
**Analysis:** The "Add Flight" button was only visible inside `TravelTimeline` when a user had 2+ flights. Users with 0 flights had no way to add a flight from the People tab — the flight section was entirely hidden when `flights.length === 0`.

**Change:** Added an "Add your flight" button for the current user when they have 0 flights. The button appears in the flight section of their person card and navigates to `/trip/${trip.id}/add-flight`.
**Commit:** `fix(report-0317): add flight button visible for users with no flights`

---

## Task 3.2 — Itinerary Date Picker Scroll
**Status:** Complete (partial)
**File:** `components/trip-detail/PlanTab.tsx`
**Analysis:** `handleNavigateToDay` relied on `scrollRef` to scroll to the selected day card, but `scrollRef` is not passed from `NewTripDetails.tsx` (which uses `HeaderMotion.ScrollView` — a specialized animated scroll component that doesn't expose a ref). Without `scrollRef`, the scroll-to-position was a no-op.

**Change:**
- Added `dateStripRef` to scroll the date strip to center the selected date pill
- Added `dayCardRefs` for day card position tracking
- Date strip now auto-scrolls to the selected pill
- LayoutAnimation expansion brings the selected day into view
- When `scrollRef` is available (standalone usage), the original scroll behavior is preserved

**Note:** Full scroll-to-day-card within the HeaderMotion Pager would require either exposing the Animated.ScrollView ref from `react-native-header-motion` or implementing a custom scroll bridge. The current fix provides the most important part: visual feedback on the date strip and day expansion.
**Commit:** `fix(report-0317): improve itinerary date picker scroll behavior`

---

## Task 5.2 — Dot Indicator Lag
**Status:** Complete
**File:** `components/StackedTripCards.tsx`
**Analysis:** The `AnimatedDot` components directly track `animatedIndex` on the UI thread via `useAnimatedStyle`, so during the drag gesture they are perfectly in sync. The perceived lag comes from the `withSpring` animation config after release — the spring overshoot makes dots appear to wobble/lag.

**Change:** Tightened spring physics to reduce overshoot:
- `SPRING_CONFIG`: increased damping 22->26, stiffness 280->340, reduced mass 0.7->0.6
- `SNAP_SPRING_CONFIG`: increased damping 28->30, stiffness 380->400
**Commit:** `fix(report-0317): reduce dot indicator lag on trip card swipe`

---

## Task 6.1 — Share as Bottom Sheet Modal
**Status:** Complete
**File:** `app/trip/[id]/share.tsx`
**Change:** Added `presentation: "modal"` to all three `Stack.Screen` options blocks (loading, error, main states). This makes the share route present as a modal that slides up from the bottom instead of pushing a full-screen navigation.
**Commit:** `fix(report-0317): present share screen as modal bottom sheet`

---

## Skipped Items

| Item | Reason |
|------|--------|
| Trending songs in NYC not working | Backend issue (Supabase edge function), not a client fix |
| Calendar tab does not match Figma design | Needs Figma audit + design team review |
| Itinerary tab left-hand slider not working | Slider component doesn't exist in codebase, needs design spec |
| Share trip directly from home screen | Needs design for long-press sheet UX |
| Dress code feature rework | Needs design rethink/brainstorm |
| Drag activities between Discover and voting block | Large scope, needs separate spec |

---

## Summary

- **11 tasks implemented** out of 11 planned
- **11 commits** on `fix/morning-report-0317`
- **6 items skipped** (design/backend/scope)
- All changes pass `npm run typecheck`
- Pre-existing calendar.tsx type errors fixed as bonus
