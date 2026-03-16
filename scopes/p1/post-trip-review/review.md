# Code Review: post-trip-review

**Branch:** feat/post-trip-review
**Files Changed:** 31
**Lines Added/Removed:** +3658 / -2

## P1 — Must Fix Before Merge

| #   | File | Line | Issue | Fix |
| --- | ---- | ---- | ----- | --- |
| 1   | `supabase/migrations/20260316000000_post_trip_review_tables.sql` | — | **Missing DELETE RLS policy on `favorite_activities`.** `supabaseStorage.submitFavoriteActivities()` deletes existing favorites before re-inserting (line ~6989 of supabaseStorage.ts). Without a DELETE policy, this delete silently fails under RLS, causing duplicate/stale rows on resubmission. | Add: `CREATE POLICY "Users delete own favorites" ON favorite_activities FOR DELETE USING (auth.uid() = user_id);` |
| 2   | `app/trip/[id]/montage.tsx` | 25 | **`tripName` state is initialized to "Trip" but `setTripName` is never called.** The MontagePlayer always displays "Trip" as the title and share text instead of the actual trip name. | Fetch the trip name (e.g., from the trip record or route params) and call `setTripName`. |
| 3   | `supabase/migrations/20260316000002_montages_bucket.sql` | 3-7 | **Montages bucket is public with unrestricted SELECT.** Any user (even unauthenticated) can enumerate and download all montage videos if they know the storage path. This leaks private trip content. | Either: (a) make the bucket private and use signed URLs from the edge function, or (b) add a storage SELECT policy that restricts reads to trip members (like the time-capsule bucket approach but with member-gated read). |
| 4   | `supabase/migrations/20260316000000_post_trip_review_tables.sql` | 30-35 | **`storage_path` is readable via RLS SELECT policy on `time_capsule_submissions`.** The blind mechanic (P1.S4.C27) is only enforced at the app layer (client queries omit `storage_path`), but the RLS policy grants full row SELECT to trip members. A malicious client or direct API call can read `storage_path` and download blind submissions. | Create a database view that excludes `storage_path` and grant SELECT on the view instead, or use column-level security (Supabase doesn't natively support this — a view is the standard approach). |

## P2 — Should Fix

| #   | File | Line | Issue | Fix |
| --- | ---- | ---- | ----- | --- |
| 1   | `components/post-trip/MontagePlayer.tsx` | 4 | **Unused `useRef` import.** | Remove `useRef` from the import. |
| 2   | `components/post-trip/MontagePlayer.tsx` | 32 | **`isLoading` state is set to `true` but never updated to `false`.** The loading overlay renders indefinitely on top of the video. | Listen to the video player's status events (e.g., `player.addListener('statusChange', ...)`) and set `isLoading(false)` when playback begins. |
| 3   | `components/post-trip/MontagePlayer.tsx` | 48 | **`console.error` in component** (CLAUDE.md: no console.logs in components). | Move error handling to a utility or remove. |
| 4   | `components/time-capsule/TimeCapsuleCapture.tsx` | 80, 129 | **`console.error` in component** (CLAUDE.md: no console.logs in components). | Move to utility or use an error reporting service. |
| 5   | `app/trip/[id]/montage.tsx` | 44 | **`console.error` in route component.** | Move to utility or remove. |
| 6   | `hooks/usePostTripStatus.ts` | 58 | **`console.error` in hook** (hooks are component-adjacent). | Move to error utility. |
| 7   | `utils/supabaseStorage.ts` | ~7092 | **`getMontage()` returns `storagePath` in the Montage object.** While the montages bucket is public, the storage path is an implementation detail. If the bucket is made private (per P1 #3), this leaks the internal path to the client. | Return only the public URL (or null) from `getMontageUrl`, and omit `storagePath` from the client-facing `Montage` type. |
| 8   | `utils/supabaseStorage.ts` | ~7061 | **`getGroupFavorites` uses `as unknown as Record<string, unknown>` cast.** This bypasses type safety for the joined `trip_activities` data. | Define a proper typed interface for the Supabase join result. |

## P3 — Nice to Have

| #   | Issue | Suggestion |
| --- | ----- | ---------- |
| 1   | `Top3ReminderBanner` and `MontageCard` components are built but not integrated into StackedTripCards or trip detail screen (deferred per work log). | Track as follow-up ticket. Without this, P1.S4.C06/C08/C25 are not fully wired in the production flow. |
| 2   | `generate-montage` edge function is a scaffold — no actual FFmpeg processing. | Expected per plan. Ensure the TODO is tracked. |
| 3   | Polling interval in `montage.tsx` (line 53) is hardcoded to 5000ms with no max retry. | Add a max poll count or exponential backoff to avoid indefinite polling. |
| 4   | `TimeCapsuleCapture` always converts video to `mp4` and photo to `jpg` extension regardless of actual input format. | Consider detecting actual mime type from the picker result. |
| 5   | `TripStatsBar.computeStats` uses `trip.expenses.reduce` which could throw if `trip.expenses` is undefined. | Add a null guard: `(trip.expenses ?? []).reduce(...)`. |

## Completeness vs Spec

| Success Criterion | Status | Notes |
| --- | --- | --- |
| P1.S4.C01 — Trip Complete bottom sheet appears automatically | Done | Bottom sheet wired via `usePostTripStatus` + `TripCompleteSheet` in `app/trip/[id].tsx`. |
| P1.S4.C02 — Trip stats bar shows Days, People, Places, Spent | Done | `TripStatsBar` computes all four stats from trip data. |
| P1.S4.C03 — Post-trip flow independent of expense settlement | Done | No expense settlement check in `usePostTripStatus` or `getTripPostTripStatus`. |
| P1.S4.C04 — Each user selects exactly 3 favorites | Done | `pick-favorites.tsx` with `maxSelections = Math.min(3, activities.length)`. |
| P1.S4.C05 — Selections persist per-user and feed recommendation store | Done | `submitFavoriteActivities` stores per-user ranked picks. (Blocked by P1 #1: missing DELETE policy prevents re-submission.) |
| P1.S4.C06 — Persistent blinking banner on past trip card | Partial | `Top3ReminderBanner` component built with pulse animation, but not yet integrated into `StackedTripCards`. |
| P1.S4.C07 — Push notification for top 3 reminder | Done | `post-trip-notifications` edge function handles this. |
| P1.S4.C08 — Banner disappears after top 3 submitted | Partial | Banner logic is correct (checks `hasSubmittedFavorites`), but banner not wired into trip cards yet. |
| P1.S4.C09 — Users can record/submit 6-second video clips | Done | `TimeCapsuleCapture` with camera and library picker, 6s limit. |
| P1.S4.C10 — Submitted clips are blind | Done | Blind notice in `TimeCapsuleSection`, `storage_path` excluded from client queries. (RLS gap noted in P1 #4.) |
| P1.S4.C11 — Users can delete own submissions | Done | Delete with confirmation in `TimeCapsuleSection`, RLS policy present. |
| P1.S4.C12 — Capture UI on Vibe tab | Done | `TimeCapsuleSection` rendered in `VibeTab` during active trips via `isTripActive` check. |
| P1.S4.C13 — Time capsule accepts photos and videos | Done | Both `video` and `photo` media types supported in capture UI. |
| P1.S4.C14 — Time capsule education on join | Done | `notifyTimeCapsuleEducation` function implemented in `notifications.ts`. |
| P1.S4.C15 — Mid-trip capsule nudge | Done | Edge function sends nudge 3 days before trip end. |
| P1.S4.C16 — Low-participation feedback | Done | Edge function checks submission-to-member ratio. |
| P1.S4.C17 — AI generates 60-second montage | Partial | Edge function scaffold with complete flow but video processing is stubbed (TODO). |
| P1.S4.C18 — Simultaneous reveal push notification | Done | `trigger-montage-reveal` edge function with batch push via Expo API. |
| P1.S4.C19 — Disposable camera aesthetic | Not implemented | Referenced in code comments but actual filter processing is TODO. |
| P1.S4.C20 — Montage music from Spotify or default | Partial | Music source detection implemented, but actual track extraction/overlay is TODO. |
| P1.S4.C21 — Montage permanently re-watchable | Done | `MontagePlayer` + `montage.tsx` route + `MontageCard` entry point. |
| P1.S4.C22 — Share button with native share sheet | Done | `Share.share()` in `MontagePlayer` with video URL. |
| P1.S4.C23 — Group Top 3 aggregation ranked by votes | Done | `getGroupFavorites` aggregates and sorts by vote count. |
| P1.S4.C24 — Group Favorites visible to all members | Done | `group-favorites.tsx` route with `GroupFavoritesSection`. |
| P1.S4.C25 — Home screen trip card completed state | Partial | `Top3ReminderBanner` built but not integrated into home screen cards. |
| P1.S4.C26 — Non-members cannot access time capsule | Done | RLS INSERT policy checks `trip_members` membership. Storage upload policy also checks membership. |
| P1.S4.C27 — No preview of submitted clips before reveal | Partial | App layer excludes `storage_path` from queries. However, RLS allows full row SELECT including `storage_path` (P1 #4). |
| P1.S4.C28 — Fewer than 3 activities allows picking all | Done | `maxSelections = Math.min(3, activities.length)`. |
| P1.S4.C29 — 0 submissions handled gracefully | Done | Edge function returns early, hook sets `montageStatus = "none"`, montage screen shows empty state. |
| P1.S4.C30 — Async montage processing with loading state | Done | Processing/pending states shown with loading indicator and "being created" message. Polling every 5s. |
| P1.S4.C31 — Typecheck passes | Done | `npx tsc --noEmit` passes clean. |

## Security Checklist

- [x] RLS on all new tables (`time_capsule_submissions`, `favorite_activities`, `montages` all have `ENABLE ROW LEVEL SECURITY`)
- [ ] **Missing DELETE policy on `favorite_activities`** — re-submission silently fails
- [ ] **`storage_path` readable through RLS** on `time_capsule_submissions` — blind mechanic only enforced at app layer
- [ ] **`montages` bucket is fully public** — no member-gating on montage video access
- [x] No exposed secrets or API keys
- [x] Input validation present (6s video limit, rank 1-3 constraint, media type CHECK)
- [x] No SQL injection vectors (all queries use Supabase client parameterized methods)

## Summary

Solid implementation covering 24 of 31 success criteria fully, with 6 partial and 1 not-yet-implemented (C19 disposable camera filter, which requires server-side processing). The architecture is well-structured: clean separation between hooks, components, storage layer, and edge functions. Four P1 issues need fixing before merge: (1) missing DELETE RLS policy on `favorite_activities` breaks re-submission, (2) montage screen always shows "Trip" instead of actual trip name, (3) montages bucket is publicly accessible without member gating, and (4) `storage_path` is readable via RLS despite the blind mechanic requirement. The deferred StackedTripCards integration (C06/C08/C25) is acceptable per the work log but should be tracked as a follow-up. Recommend fixing the four P1 issues and merging.
