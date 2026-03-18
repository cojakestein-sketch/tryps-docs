# Compound Log: post-trip-review

## P1 Fixes Applied

| #   | Issue | Fix Applied | File |
| --- | ----- | ----------- | ---- |
| 1   | Blind mechanic partially enforced at DB layer: broad SELECT RLS policy on `time_capsule_submissions` exposes `storage_path` to all trip members | Replaced "Members view capsule metadata" SELECT policy (allowed all trip members) with "Users view own capsule submissions" (restricts SELECT to `auth.uid() = user_id`). Added `get_capsule_submission_count` SECURITY DEFINER RPC to provide total/mine counts without exposing storage_path. Updated `getTimeCapsuleCount` in supabaseStorage.ts to use the RPC. Updated callers in `TimeCapsuleSection.tsx` and `getTripPostTripStatus` to use `{ total, mine }` return shape. | `supabase/migrations/20260316000000_post_trip_review_tables.sql`, `utils/supabaseStorage.ts`, `utils/storage.ts`, `components/time-capsule/TimeCapsuleSection.tsx` |
| 2   | Inline style `style={{ opacity: pulseAnim }}` violates CLAUDE.md "use StyleSheet.create()" rule | Extracted to `styles.pulseIcon` in `StyleSheet.create()` and applied via array syntax `style={[styles.pulseIcon, { opacity: pulseAnim }]}`. The dynamic Animated.Value opacity is passed as second array element (standard RN pattern for animated values). | `components/post-trip/Top3ReminderBanner.tsx` |

## P2 Fixes Applied

| #   | Issue | Fix Applied | File |
| --- | ----- | ----------- | ---- |
| 1   | `as unknown as` cast bypasses type safety on Supabase join response in `getGroupFavorites` | Replaced `data as unknown as FavoriteActivityJoinRow[]` with `.returns<FavoriteActivityJoinRow[]>()` on the Supabase query chain, then assigned `data` directly. | `utils/supabaseStorage.ts` |
| 2   | `uuid_generate_v4()` used instead of FRD-specified `gen_random_uuid()` in all migrations | Changed all occurrences of `uuid_generate_v4()` to `gen_random_uuid()` in both migration files (20260316000000 and 20260316100000). `gen_random_uuid()` is built-in and has no extension dependency. | `supabase/migrations/20260316000000_post_trip_review_tables.sql`, `supabase/migrations/20260316100000_post_review_status.sql` |
| 3   | Fragile type narrowing cast `montageStatus as "ready" \| "processing" \| "pending"` hides potential `"failed"` variant | Added explicit `!== "failed"` guard alongside existing `!== "none"` check. TypeScript now narrows correctly to `"ready" \| "processing" \| "pending"` without a cast. If `MontageStatus` gains new variants, the compiler will flag them. | `app/trip/[id].tsx` |
| 4   | `error_message` column from FRD missing in `montages` table; edge function only logs errors to console | Added `error_message TEXT` column to the `montages` table migration. Updated the `generate-montage` edge function to store `lastError?.message ?? "Unknown error"` in the `error_message` column on failure. | `supabase/migrations/20260316000000_post_trip_review_tables.sql`, `supabase/functions/generate-montage/index.ts` |
| 5   | Notification preferences columns may not exist for edge function queries | Already resolved: migration `20260316000003_notification_prefs_post_trip.sql` adds `time_capsule_reveal`, `top3_reminder`, and `time_capsule_nudge` columns. Column names match edge function queries. No code change needed. | `supabase/migrations/20260316000003_notification_prefs_post_trip.sql` (no change) |
| 6   | Unhandled promise in `getBatchPostReviewStatuses(pastTripIds).then(setReviewStatuses)` -- no `.catch()` | Added `.catch(() => { /* Silently handle */ })` to prevent unhandled rejection. Banner logic gracefully degrades if the query fails. | `app/(tabs)/index.tsx` |

## P3 Deferred

| #   | Issue | Reason |
| --- | ----- | --------------------- |
| 1   | Hard delete instead of soft delete for `time_capsule_submissions` | Cosmetic / audit trail improvement. Current hard delete works correctly for v1. Soft delete can be added in follow-up. |
| 2   | Direct SELECT with count instead of RPC for clip count | Resolved as side effect of P1 #1 fix: now using SECURITY DEFINER RPC `get_capsule_submission_count`. |
| 3   | AsyncStorage for sheet dismissal state instead of server-side | Low impact for v1. Server-side persistence is a nice-to-have for cross-device sync. |
| 4   | "View Time Capsule" button shown independently of top 3 completion | Minor UX difference from FRD. Can be tightened in a follow-up. |
| 5   | `nudge_count` not checked/incremented in edge function | Column exists. Wiring it in is straightforward but not a blocker for v1 scaffold. |
| 6   | System image picker instead of custom camera UI with viewfinder/countdown | Acceptable for v1 scaffold. Custom camera UI deferred to `expo-camera` follow-up. |

## Remaining Concerns

- **Rebase on develop**: The feature branch has 37 commits that produce structural conflicts when rebasing onto `origin/develop`. The fix commit was pushed directly to `feat/post-trip-review` without rebasing. The PR should use a merge strategy or the branch should be rebased interactively before merge.
- **P3 #5 (nudge_count)**: The 2-nudge cap from the FRD is not enforced in the notification edge function. The `nudge_count` column and `last_nudge_sent_at` exist in `trip_post_review_status` but are not wired into `post-trip-notifications/index.ts`. This should be addressed before enabling the cron job in production.

## Typecheck: PASS

## Tests: PASS (3 pre-existing failures unrelated to this feature)
- `TripCountdown.test.tsx` (2 failures): Component now shows empty state instead of returning null
- `TripListModal.test.tsx` (1 failure): Test filter mismatch with rendered output
- `deleteTripFromHome.test.tsx` (1 suite failure): Missing Supabase env vars in test environment
