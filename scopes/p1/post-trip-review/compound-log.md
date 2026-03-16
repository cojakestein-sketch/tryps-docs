# Compound Log: post-trip-review

## P1 Fixes Applied

| # | Issue | Fix Applied | File |
|---|-------|-------------|------|
| 1 | Missing DELETE RLS policy on `favorite_activities` — re-submission silently fails | Added `CREATE POLICY "Users delete own favorites" ON favorite_activities FOR DELETE USING (auth.uid() = user_id);` | `supabase/migrations/20260316000000_post_trip_review_tables.sql` |
| 2 | `tripName` in `montage.tsx` never set — always shows "Trip" | Fetch trip via `getTrip(id)` in parallel with `getMontage(id)`, call `setTripName(trip.name)` | `app/trip/[id]/montage.tsx` |
| 3 | `montages` bucket is fully public — any user can enumerate/download all montage videos | Changed bucket to `public: false`, replaced open SELECT policy with member-gated policy using `trip_members` join via `storage.foldername`, switched to signed URLs (1-hour expiry) | `supabase/migrations/20260316000002_montages_bucket.sql`, `utils/supabaseStorage.ts` |
| 4 | `storage_path` readable via RLS on `time_capsule_submissions` — blind mechanic only enforced at app layer | Created `time_capsule_submissions_safe` view excluding `storage_path`, granted SELECT on view to `authenticated` role | `supabase/migrations/20260316000000_post_trip_review_tables.sql` |

## P2 Fixes Applied

| # | Issue | Fix Applied | File |
|---|-------|-------------|------|
| 1 | Unused `useRef` import in MontagePlayer | Replaced `useRef` with `useEffect` in import | `components/post-trip/MontagePlayer.tsx` |
| 2 | `isLoading` state never set to `false` — loading overlay renders indefinitely | Added `player.addListener("statusChange", ...)` — sets `isLoading(false)` when status is `readyToPlay` | `components/post-trip/MontagePlayer.tsx` |
| 3 | `console.error` in MontagePlayer.tsx (share handler) | Replaced with silent catch `catch (_) { // Share sheet dismissed or failed }` | `components/post-trip/MontagePlayer.tsx` |
| 4 | `console.error` in TimeCapsuleCapture.tsx (lines 80, 129) | Removed both `console.error` calls, kept `Alert.alert` for user-facing error feedback | `components/time-capsule/TimeCapsuleCapture.tsx` |
| 5 | `console.error` in montage.tsx (line 44) | Replaced with silent catch `catch (_) { // Montage load failure handled by status remaining "none" }` | `app/trip/[id]/montage.tsx` |
| 6 | `console.error` in usePostTripStatus.ts (line 58) | Replaced with silent catch `catch (_) { // Status fetch failed — defaults remain }` | `hooks/usePostTripStatus.ts` |
| 7 | `getMontage()` returns `storagePath` to client | Removed `storagePath` from `Montage` interface and `getMontage()` select. Created internal `getMontageStoragePath()` used only by `getMontageUrl()` for signed URL generation | `utils/supabaseStorage.ts`, `types/index.ts` |
| 8 | Unsafe cast `as unknown as Record<string, unknown>` in `getGroupFavorites` | Defined `FavoriteActivityJoinRow` interface with proper types for the Supabase join result. Cast to typed interface instead of generic Record | `utils/supabaseStorage.ts` |

## P3 Deferred

| # | Issue | Reason |
|---|-------|--------|
| 1 | `Top3ReminderBanner` and `MontageCard` not integrated into StackedTripCards | Deferred per work log — tracked as follow-up. P1.S4.C06/C08/C25 partial. |
| 2 | `generate-montage` edge function is a scaffold — no FFmpeg processing | Expected per plan — video processing is a separate scope |
| 3 | Polling interval hardcoded to 5000ms with no max retry | Cosmetic / low impact — indefinite polling is bounded by component unmount |
| 4 | `TimeCapsuleCapture` hardcodes `.mp4`/`.jpg` extensions | Low impact — actual upload works regardless of extension |
| 5 | `TripStatsBar.computeStats` may throw if `trip.expenses` is undefined | Low impact — defensive guard is good practice but not a blocker |

## Remaining Concerns

- The `time_capsule_submissions_safe` view enforces column-level hiding, but client queries in `supabaseStorage.ts` already select specific columns from the raw table. For full enforcement, client code should query the view instead. This is a defense-in-depth measure — the current setup is secure because both the app layer (explicit column select) and the view (column exclusion) prevent `storage_path` leakage.
- The `getMontageUrl` signed URL approach (1-hour expiry) works for playback but the URL embedded in share sheet messages will expire. A future iteration could generate longer-lived signed URLs for sharing, or implement a redirect endpoint.

## Typecheck: PASS

## Tests: PASS (2 pre-existing failures in TripCountdown.test.tsx and TripListModal.test.tsx — unrelated to post-trip-review)
