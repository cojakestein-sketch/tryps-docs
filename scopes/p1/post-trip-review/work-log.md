# Work Log: post-trip-review

**Branch:** feat/post-trip-review
**Commits:** 10

## Changes Made

### Files Created

| File | Purpose | Lines |
| ---- | ------- | ----- |
| `supabase/migrations/20260316000000_post_trip_review_tables.sql` | DB tables: time_capsule_submissions, favorite_activities, montages + RLS | 88 |
| `supabase/migrations/20260316000001_time_capsule_bucket.sql` | Private storage bucket for blind media submissions | 27 |
| `supabase/migrations/20260316000002_montages_bucket.sql` | Public storage bucket for generated montage videos | 9 |
| `supabase/migrations/20260316000003_notification_prefs_post_trip.sql` | Notification preference columns for post-trip features | 5 |
| `hooks/usePostTripStatus.ts` | Hook: trip completion detection + post-trip status aggregation | 82 |
| `components/post-trip/TripCompleteSheet.tsx` | Bottom sheet overlay for completed trip entry point | 170 |
| `components/post-trip/TripStatsBar.tsx` | Horizontal stat badges (Days, People, Places, Spent) | 100 |
| `components/post-trip/FavoriteActivityCard.tsx` | Selectable activity card for top 3 picker | 145 |
| `components/post-trip/StepIndicator.tsx` | Dot indicator + counter (1/3, 2/3, 3/3) | 60 |
| `components/post-trip/GroupFavoritesSection.tsx` | Ranked group favorites with vote counts | 150 |
| `components/post-trip/MontagePlayer.tsx` | Full-screen video player with share button | 140 |
| `components/post-trip/MontageCard.tsx` | Thumbnail card entry point for re-watching montage | 110 |
| `components/post-trip/Top3ReminderBanner.tsx` | Pulsing banner for un-submitted users on home screen | 80 |
| `components/time-capsule/TimeCapsuleCapture.tsx` | Camera/picker UI for 6-second clips + photos | 200 |
| `components/time-capsule/TimeCapsuleSection.tsx` | Vibe tab section: capture button + submission count | 190 |
| `utils/timeCapsule.ts` | Upload, compress, and manage time capsule media | 42 |
| `app/trip/[id]/pick-favorites.tsx` | Full-screen top 3 favorites selection flow | 170 |
| `app/trip/[id]/montage.tsx` | Montage reveal + playback screen | 130 |
| `app/trip/[id]/group-favorites.tsx` | Group favorites aggregation screen | 120 |
| `supabase/functions/generate-montage/index.ts` | Edge function: stitch clips into montage (scaffold) | 150 |
| `supabase/functions/trigger-montage-reveal/index.ts` | Edge function: simultaneous reveal push notification | 110 |
| `supabase/functions/post-trip-notifications/index.ts` | Edge function: scheduled nudges (top 3, capsule, low participation) | 220 |

### Files Modified

| File | Changes | Lines Changed |
| ---- | ------- | ------------- |
| `types/index.ts` | Added TimeCapsuleSubmission, FavoriteActivity, Montage, PostTripStatus, ActivityCategoryBadge, GroupFavoriteResult types | +80 |
| `utils/supabaseStorage.ts` | Added 11 new functions for time capsule CRUD, favorites CRUD, montage read, group aggregation, composite post-trip status | +280 |
| `utils/storage.ts` | Exposed new supabaseStorage functions through abstraction layer with offline stubs | +130 |
| `utils/notifications.ts` | Added post-trip notification types, preferences, deep link routing, education notification | +50 |
| `components/VibeTab.tsx` | Import/render TimeCapsuleSection during active trips | +10 |
| `app/trip/[id].tsx` | Integrated TripCompleteSheet overlay with usePostTripStatus hook | +15 |
| `__tests__/smoke/allRoutesRender.test.tsx` | Added 3 new routes to ROUTES_UNDER_TEST | +5 |
| `package.json` | Added expo-video dependency | +1 |

## Deviations from Plan

1. **Phase 8 (StackedTripCards integration) deferred** — The StackedTripCards component is highly complex with gesture-driven animations. Integrating the Top3ReminderBanner and completed state directly into it requires careful coordination with the existing card rendering pipeline. The Top3ReminderBanner component is fully built and ready to integrate; the actual integration into StackedTripCards should be done as a follow-up when Figma designs clarify the exact placement.

2. **Phase 11 (trip detail post-trip section) partially deferred** — MontageCard and GroupFavoritesSection components are fully built. Integrating them as a permanent section on the trip detail screen requires design decisions about placement relative to tabs. The TripCompleteSheet already provides navigation to montage and favorites.

3. **generate-montage edge function is a scaffold** — The actual video processing pipeline (FFmpeg stitching, disposable camera filter, music overlay) is marked with a TODO. The function handles the full Supabase flow (submissions fetch, status updates, reveal trigger) but delegates actual video generation to a future Hetzner worker integration. This was noted as a risk area in the plan.

4. **expo-video installed instead of expo-av** — expo-video is the modern Expo SDK 54 approach (uses native players). The MontagePlayer uses `useVideoPlayer` and `VideoView` from expo-video.

## Known Issues

1. **Montage video processing not implemented** — The `generate-montage` edge function has the complete flow but stubs out the actual FFmpeg video stitching. Needs Hetzner worker or external processing service.

2. **Disposable camera filter (P1.S4.C19)** — The grain/warm-tone filter is referenced in the montage generation function but not yet applied. This requires server-side image/video processing.

3. **Spotify music integration (P1.S4.C20)** — Music source is detected (spotify vs default) but actual track extraction from Spotify requires API access. Default ambient track not yet bundled.

4. **Pre-existing test failures** — TripListModal tests fail independently of this branch (3 tests in TripListModal.test.tsx). Not introduced by this work.

5. **StackedTripCards completed state + banner integration** — Components are built but not yet wired into the carousel. Needs Figma design guidance for exact placement.

## Typecheck: PASS

## Tests: PASS (no new regressions; pre-existing TripListModal failures unrelated)
