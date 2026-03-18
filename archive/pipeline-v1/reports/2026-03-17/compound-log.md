# Compound Log — Morning Report 2026-03-17

> Patterns, gotchas, and reusable solutions discovered during this scope.

---

## 1. Theme / Color Patterns

### 1a. `colors.background` is NOT a neutral gray

**What:** The theme's `background` value is `#F5EADB` (warm cream) in light mode and `#1E1B19` in dark mode. Most screens in the app actually want `#F5F7FA` (cool neutral gray), which is NOT in the theme at all.

**Where:**
- Theme definition: `/Users/jakestein/t4/utils/theme.ts` lines 47-50 (light) and 167-170 (dark)
- People tab hardcoded to `#F5F7FA`: `/Users/jakestein/t4/app/(tabs)/people.tsx` lines 214, 219, 521, 526
- Friends tab still uses `colors.background` (warm cream): `/Users/jakestein/t4/app/(tabs)/friends.tsx` lines 55, 60, 117, 123
- HomeNew uses Tailwind `bg-[#F5F7FA]` class

**Why it matters:** Any new screen using `colors.background` will get the warm cream, not the neutral gray that Home/People use. The inconsistency is invisible in dark mode (both are dark) but obvious in light mode. The People tab fix hardcoded `#F5F7FA` in 4 places, which works for light mode but will show a light background in dark mode too.

**How to apply:**
- **Short term:** When creating a new tab screen, check what color Home uses and match it manually. Do NOT blindly use `colors.background`.
- **Long term:** Add a `colors.screenBackground` value to the theme that maps to `#F5F7FA` (light) / `#1E1B19` (dark) and migrate all tab screens to use it. Also fix the People tab hardcodes to use this new theme value. Track the `friends.tsx` warm cream as a follow-up.
- The theme also has `backgroundNeutral: "#F3F4F6"` (light, line 88) which is close to `#F5F7FA` but not identical. Consider standardizing on one.

---

### 1b. Explore tab background is special — globe visualization needs dark

**What:** The Explore tab uses a dark navy background (`#1A2B3C` dark / `#2C3E50` light) because the 3D globe is an ocean visualization where a white or cream background would look broken. You cannot apply the same "neutral gray" approach here.

**Where:**
- `/Users/jakestein/t4/app/(tabs)/explore.tsx` line 227: `const globeBg = isDark ? "#1A2B3C" : "#2C3E50";`
- `/Users/jakestein/t4/components/TravelMap/GlobeView.tsx` line 36: `backgroundColor` prop with default `"#1A2B3C"`
- GlobeView's StyleSheet also has hardcoded `#1A2B3C` in `container` (line 277) and `loadingOverlay` (line 287) — these are overridden at runtime by the prop, but the static defaults remain as fallbacks.

**Why it matters:** Spec said "use #F5F7FA or equivalent" but the implementation correctly chose a lighter navy instead. Future specs should note that full-screen visualization screens (globe, maps) need domain-appropriate backgrounds, not generic screen backgrounds.

**How to apply:** When a spec calls for "match other tabs' background," evaluate whether the screen content requires a different approach. Document the exception in the commit message.

---

## 2. Navigation Patterns

### 2a. Tab order is controlled by array position in `CORE_TABS`

**What:** The default landing tab in trip detail is determined by the first element of `CORE_TABS` in `TripHeader.tsx`. The `Pager` component (from `react-native-header-motion`) starts at index 0 by default, so whatever is first in the array is what the user sees.

**Where:**
- `/Users/jakestein/t4/components/TripHeader.tsx` lines 17-25: `CORE_TABS` array definition
- `/Users/jakestein/t4/components/trip-detail/NewTripDetails.tsx` line 517: `<HeaderMotion>` renders pages in `TRIP_TABS` order
- `TRIP_TABS` is exported from `TripHeader.tsx` line 84 as an alias for `CORE_TABS`

**Why it matters:** There is no `initialPage` prop being used — just array order. Moving items in `CORE_TABS` changes both the tab bar order AND which tab is default. If you only want to change the default without changing visual order, you'd need to add `initialPage={n}` to the Pager.

**How to apply:** To change the default tab, reorder the `CORE_TABS` array. To change just the default without reordering the tab bar, add `initialPage` to the `HeaderMotion` component in `NewTripDetails.tsx`. The reorder approach was used here because the team also wanted Itinerary to appear first in the tab bar.

---

### 2b. Modal presentation via Expo Router `Stack.Screen`

**What:** Adding `presentation: "modal"` to `Stack.Screen` options in Expo Router produces an iOS page-sheet modal (slides up from bottom, swipe-down to dismiss). This is the simplest way to get a bottom-sheet-style UI for a full route.

**Where:** `/Users/jakestein/t4/app/trip/[id]/share.tsx` — `presentation: "modal"` added to all three `Stack.Screen` option blocks (loading state, error state, main render).

**Why it matters:** On iOS this looks native and works great. On Android, `presentation: "modal"` may render as a full-screen push transition rather than a bottom sheet. If true bottom-sheet behavior is needed on Android, use `@gorhom/bottom-sheet` (already a dependency in the app) instead.

**How to apply:**
- For routes that need bottom-sheet feel: use `presentation: "modal"` for quick wins on iOS.
- If the route has multiple render states (loading/error/main), you must add `presentation: "modal"` to ALL `Stack.Screen` option blocks, not just one. Otherwise the presentation style will change when the component re-renders into a different state.
- For cross-platform bottom sheets, extract the UI into a `@gorhom/bottom-sheet` component and render it inline rather than as a separate route.

---

## 3. State Persistence Patterns

### 3a. Fire-and-forget async calls after mutations cause stale UI

**What:** `useTripVibe.ts` had a `save()` function that called `loadGroupVibe(true)` without `await`. This meant the save returned and the UI navigated away before the group vibe aggregate was updated, so returning to the tab showed stale data.

**Where:**
- `/Users/jakestein/t4/hooks/useTripVibe.ts` line 251: `await loadGroupVibe(true)` (was previously just `loadGroupVibe(true)` without await)
- Same pattern in `useMyDefaults` at line 285

**Why it matters:** This is a common React pattern bug. After a mutation that changes server state, if you fire-and-forget the refetch, the UI will show stale data if the user navigates away and back before the refetch completes.

**How to apply:**
- After any Supabase RPC mutation, **always `await`** the subsequent refetch call before returning success.
- Audit other hooks for the same pattern: search for `.rpc(` followed by a refetch call that is not awaited.

---

### 3b. Cache staleness windows need to account for user flows

**What:** The group vibe had a 5-minute stale window (`GROUP_VIBE_STALE_MS = 300_000`). A user would save their vibe, navigate away, come back within 5 minutes, and the cache would serve the old aggregate. Reduced to 30 seconds.

**Where:** `/Users/jakestein/t4/hooks/useTripVibe.ts` line 30: `const GROUP_VIBE_STALE_MS = 30_000;`

**Why it matters:** Aggressive caching (5 min) was appropriate for read-heavy data, but after a write the user expects to see their change. The `force` parameter on `loadGroupVibe(true)` bypasses the stale check, but the stale window also matters for the navigation-back-to-tab case where `force` is not used.

**How to apply:**
- For data that users write and then immediately read back: use a short stale window (30s or less) OR invalidate the cache timestamp after a successful write.
- The `groupVibeFetchedAt` ref pattern (line 137) is reusable: `useRef<number>(0)` as the timestamp, check `Date.now() - ref.current < STALE_MS` before refetching, set `ref.current = Date.now()` after successful fetch.

---

## 4. WebView Patterns

### 4a. Large inline HTML bundles need resilience layers

**What:** The globe is a 3.5MB inline HTML bundle loaded via `react-native-webview`. It can fail silently due to WebView init failures, iOS memory pressure killing the content process, or slow devices exceeding the timeout.

**Where:** `/Users/jakestein/t4/components/TravelMap/GlobeView.tsx`

**Why it matters:** WebViews with large inline HTML are inherently fragile on mobile. The original implementation had a single 10s timeout with no recovery path except a manual retry button.

**How to apply — resilience checklist for WebView components:**

1. **Auto-retry on timeout** (lines 48-56): If the WebView doesn't signal "ready" within the timeout, auto-reload once before showing the error UI. Use a `retryCount` ref to limit retries.
   ```
   if (retryCount.current < 1) {
     retryCount.current += 1;
     webViewRef.current?.reload();
   } else {
     setLoadError(true);
   }
   ```

2. **`onContentProcessDidTerminate`** (line 204): iOS can kill the WebView's content process under memory pressure. Handle this callback to auto-reload:
   ```
   const handleContentProcessTerminated = useCallback(() => {
     setIsReady(false);
     setLoadError(false);
     retryCount.current = 0;
     webViewRef.current?.reload();
   }, []);
   ```

3. **`startInLoadingState`** (line 201): Shows the WebView's built-in loading indicator before content renders. Prevents flash of empty content.

4. **Reset retry counter on manual retry** (line 159): When the user taps "Retry", reset `retryCount.current = 0` so the auto-retry logic gets another chance.

5. **Generous timeouts** (line 23): 15s is better than 10s for large inline HTML on slower devices. Consider the bundle size when choosing timeout values.

---

## 5. Reanimated Patterns

### 5a. Spring physics tuning for dot indicators

**What:** The trip card swipe dots tracked the `animatedIndex` SharedValue perfectly during the drag (UI thread, no delay), but after release the `withSpring` animation caused visible overshoot that felt like "lag."

**Where:** `/Users/jakestein/t4/components/StackedTripCards.tsx` lines 51-62

**Why it matters:** When the spring config has low damping or low stiffness, the animation overshoots the target and oscillates. For small UI elements like dots, this overshoot is perceived as lag or wobble rather than a pleasing bounce.

**How to apply — spring config guidelines for small indicators:**

| Parameter | Cards (large elements) | Dots/indicators (small) |
|-----------|----------------------|------------------------|
| Damping   | 20-24 (some bounce)  | 26-30 (minimal overshoot) |
| Stiffness | 260-300 (smooth)     | 340-400 (snappy) |
| Mass      | 0.7-0.8              | 0.5-0.6 (lighter = faster settle) |

Key insight: The dots use `useAnimatedStyle` with `interpolate` on the SharedValue, so they are perfectly in sync during the gesture. The perceived lag is ONLY from the spring animation after release. Fix the spring, fix the lag.

Final values used:
- `SPRING_CONFIG`: `{ damping: 26, stiffness: 340, mass: 0.6 }`
- `SNAP_SPRING_CONFIG`: `{ damping: 30, stiffness: 400, mass: 0.5 }`

---

## 6. Gotchas

### 6a. `handleItemPress` early return hid functionality

**What:** In `MoodBoardSection.tsx`, `handleItemPress` had `if (item.type === "photo") return;` which silently swallowed taps on photos. Users had no way to access the delete/edit menu via tap — only long-press worked, and that wasn't discoverable.

**Where:** `/Users/jakestein/t4/components/vibe/MoodBoardSection.tsx` lines 90-101

**Why it matters:** Early returns that silently do nothing are a UX dead-end. The user taps a photo, nothing happens, they assume the feature is broken. The fix was to delegate photo taps to the same action menu as long-press.

**How to apply:** When adding a `return` guard in a press handler, ask: "what does the user see when they tap this?" If the answer is "nothing," either add visual feedback (toast, animation) or delegate to an alternative action. Silent `return` in press handlers is almost always a bug.

---

### 6b. HeaderMotion Pager does not expose scroll refs

**What:** `react-native-header-motion`'s `HeaderMotion.ScrollView` does not expose a ref that child components can use for `scrollTo`. This means components rendered inside the Pager (like `PlanTab`) cannot scroll the parent to a specific position.

**Where:**
- `/Users/jakestein/t4/components/trip-detail/NewTripDetails.tsx` line 541: `<HeaderMotion.ScrollView>` wraps each tab
- `/Users/jakestein/t4/components/trip-detail/PlanTab.tsx` lines 305-334: `handleNavigateToDay` tries to use `scrollRef` but it is null inside the Pager

**Why it matters:** The itinerary date picker scroll-to-day feature could not scroll the parent Pager to the selected day card. The workaround was: (a) scroll the horizontal date strip to center the selected pill (this works because `dateStripRef` is owned by PlanTab), (b) use `LayoutAnimation` to expand the selected day card so it shifts into view, and (c) preserve the full scroll behavior when `scrollRef` IS available (standalone usage outside the Pager).

**How to apply:**
- Assume `scrollRef` will be null when your component is inside a HeaderMotion Pager.
- Use `dateStripRef` / local ScrollView refs for horizontal scrolling within your component (these always work).
- For vertical scroll-to-position: either (a) expose the `Animated.ScrollView` ref from `react-native-header-motion` via a fork/PR, or (b) use `LayoutAnimation` expansion as a substitute that brings content into the viewport.
- Always null-check `scrollRef?.current` before calling `.scrollTo()`.

---

### 6c. Pre-existing typecheck errors block all commits

**What:** The pre-commit hook runs `npm run typecheck`. If ANY file in the project has a type error — even one unrelated to your changes — you cannot commit. The `calendar.tsx` file had broken types from a missing `@marceloterreiro/flash-calendar` dependency and missing `CalendarDayMetadata` annotations.

**Where:** `/Users/jakestein/t4/app/(tabs)/calendar.tsx` — missing dependency and type annotations

**Why it matters:** This blocked ALL commits on the branch until the pre-existing error was fixed. If you see typecheck failures from files you didn't touch, fix them first and include in your first commit.

**How to apply:** Run `npm run typecheck` BEFORE starting work to identify pre-existing issues. Fix them in your first commit with a clear message that it's a pre-existing fix. This prevents wasted time debugging why your clean changes won't commit.

---

### 6d. Conditional button visibility based on empty data

**What:** The "Add Flight" button in PeopleTab was inside `TravelTimeline`, which only renders when `flights.length >= 2`. Users with 0 flights had NO way to add a flight from the People tab because the entire flight section (including the add button) was hidden.

**Where:** `/Users/jakestein/t4/components/PeopleTab.tsx` — the fix added a standalone "Add your flight" button for `isCurrentUser && flights.length === 0`.

**Why it matters:** Putting an "add" action inside a container that only renders when data exists is a common pattern bug. The empty state IS the state where the add button is most needed.

**How to apply:** When implementing "add X" buttons, always ask: "what does the user see when they have zero X?" If the answer is "nothing," add an empty-state CTA outside the data-dependent container. Check the `flights.length === 0 && isCurrentUser` pattern as a template.
