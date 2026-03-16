# post-trip-review — Implementation Plan

**FRD:** /Users/jakestein/tryps-docs/scopes/p1/post-trip-review/frd.md
**Branch:** feat/post-trip-review (branches from `develop`, PR targets `develop`)

---

## Current State Assessment

Significant implementation already exists on `feat/post-trip-review` (11 commits). The plan below reflects the **actual file structure** on the branch and identifies remaining gaps, fixes, and polish needed to meet all success criteria.

### Already Built

- Database migrations: 4 SQL files (tables, buckets, notification prefs)
- Types: `TimeCapsuleSubmission`, `FavoriteActivity`, `Montage`, `PostTripStatus`, `MontageStatus`, `GroupFavoriteResult`, `TripPostReviewStatus`
- Data layer: `utils/supabaseStorage.ts` CRUD for all 4 tables + `utils/timeCapsule.ts` upload helper + `utils/storage.ts` delegation
- Hook: `hooks/usePostTripStatus.ts` (trip completion detection, sheet dismiss tracking)
- Components: 8 post-trip components, 2 time-capsule components
- Routes: `app/trip/[id]/pick-favorites.tsx`, `app/trip/[id]/montage.tsx`, `app/trip/[id]/group-favorites.tsx`
- Edge Functions: `generate-montage`, `post-trip-notifications`, `trigger-montage-reveal`
- Notifications: types added, deep linking, education helpers
- Integrations: `app/trip/[id].tsx` presents `TripCompleteSheet`, `components/VibeTab.tsx` shows `TimeCapsuleSection`
- Tests: smoke test inventory updated

### Gaps Identified (vs. FRD + Success Criteria)

| Gap | Criteria | Description |
|-----|----------|-------------|
| Re-engagement banner on home screen | P1.S4.C06, P1.S4.C08, P1.S4.C25 | `Top3ReminderBanner` component exists but is NOT integrated into `app/(tabs)/index.tsx` trip cards |
| MontageCard on completed trips | P1.S4.C21 | `MontageCard` component exists but integration into trip detail `Screen 13.9` not confirmed |
| GroupFavoritesSection on completed trips | P1.S4.C23, P1.S4.C24 | Component exists but not wired into trip detail screen |
| `trip_post_review_status` migration unstaged | P1.S4.C06-C08 | File exists at `supabase/migrations/20260316100000_post_review_status.sql` but is untracked |
| Camera permission handling | P1.S4.C09 | `TimeCapsuleCapture` needs camera/microphone permission flow |
| Offline upload queue | FRD 13.2 | "No network -> record locally, upload when connection returns" not implemented |
| Photo capture mode | P1.S4.C13 | Photo + video dual-mode in capture UI needs verification |
| Notification preference UI | -- | New prefs (`timeCapsuleReveal`, `top3Reminder`, `timeCapsuleNudge`) need UI in settings screen |
| `app.json` camera permissions | P1.S4.C09 | `NSCameraUsageDescription` and `NSMicrophoneUsageDescription` may need addition |
| Deep link handling | P1.S4.C07 | `tripful://trip/{tripId}?action=post-trip-review` deep link routing not wired in root layout |
| Typecheck verification | P1.S4.C31 | Must pass `npm run typecheck` |

---

## Task Breakdown

### Phase 1: Foundation (Database + Types + Data Layer)

| # | Task | Files | Est. Lines | Dependencies | Criteria |
|---|------|-------|------------|--------------|----------|
| 1.1 | Stage the untracked `trip_post_review_status` migration | `supabase/migrations/20260316100000_post_review_status.sql` | 0 (already written) | None | P1.S4.C06, P1.S4.C07, P1.S4.C08 |
| 1.2 | Verify all 4 migration files are syntactically valid and deploy-ready | `supabase/migrations/20260316000000_post_trip_review_tables.sql`, `20260316000001_time_capsule_bucket.sql`, `20260316000002_montages_bucket.sql`, `20260316000003_notification_prefs_post_trip.sql`, `20260316100000_post_review_status.sql` | ~5 (review/fix) | None | P1.S4.C26 |
| 1.3 | Verify types in `types/index.ts` match migration columns exactly | `types/index.ts` | ~10 | 1.2 | P1.S4.C31 |
| 1.4 | Add `NSCameraUsageDescription` and `NSMicrophoneUsageDescription` to `app.json` if missing | `app.json` | ~4 | None | P1.S4.C09 |

### Phase 2: Core Feature — Time Capsule Capture (During Trip)

| # | Task | Files | Est. Lines | Dependencies | Criteria |
|---|------|-------|------------|--------------|----------|
| 2.1 | Verify `TimeCapsuleSection` shows on Vibe tab during active trips with correct states | `components/time-capsule/TimeCapsuleSection.tsx`, `components/VibeTab.tsx` | ~20 (review/fix) | 1.3 | P1.S4.C12, P1.S4.C10, P1.S4.C27 |
| 2.2 | Verify `TimeCapsuleCapture` handles photo + video dual mode with 6s limit | `components/time-capsule/TimeCapsuleCapture.tsx` | ~30 (review/fix) | 2.1 | P1.S4.C09, P1.S4.C13 |
| 2.3 | Add camera/microphone permission request flow to `TimeCapsuleCapture` | `components/time-capsule/TimeCapsuleCapture.tsx` | ~40 | 2.2, 1.4 | P1.S4.C09 |
| 2.4 | Verify delete-own-submission flow works (soft delete via storage layer) | `utils/timeCapsule.ts`, `utils/supabaseStorage.ts` | ~10 (review) | 2.1 | P1.S4.C11 |
| 2.5 | Verify blind mechanic — `time_capsule_submissions_safe` view excludes `storage_path` in all client queries | `utils/supabaseStorage.ts` | ~5 (review/fix) | 2.1 | P1.S4.C10, P1.S4.C27 |

### Phase 3: Core Feature — Trip Complete + Top 3 Favorites

| # | Task | Files | Est. Lines | Dependencies | Criteria |
|---|------|-------|------------|--------------|----------|
| 3.1 | Verify `TripCompleteSheet` auto-presents and shows correct stats | `components/post-trip/TripCompleteSheet.tsx`, `components/post-trip/TripStatsBar.tsx` | ~15 (review/fix) | 1.3 | P1.S4.C01, P1.S4.C02, P1.S4.C03 |
| 3.2 | Verify `pick-favorites` route: activity grid, 3-selection limit, step indicator | `app/trip/[id]/pick-favorites.tsx`, `components/post-trip/FavoriteActivityCard.tsx`, `components/post-trip/StepIndicator.tsx` | ~20 (review/fix) | 3.1 | P1.S4.C04, P1.S4.C05 |
| 3.3 | Handle edge case: trip with < 3 activities (pick all available) | `app/trip/[id]/pick-favorites.tsx` | ~15 | 3.2 | P1.S4.C28 |
| 3.4 | Handle edge case: trip with 0 activities (skip favorites section) | `app/trip/[id]/pick-favorites.tsx`, `components/post-trip/TripCompleteSheet.tsx` | ~15 | 3.2 | P1.S4.C28 |
| 3.5 | Wire atomic favorites submission (all 3 in one transaction via RPC or batch insert) | `utils/supabaseStorage.ts` | ~20 (review/fix) | 3.2 | P1.S4.C05 |
| 3.6 | Mark `favorites_completed = true` in `trip_post_review_status` after submission | `utils/supabaseStorage.ts` | ~5 (verify) | 3.5, 1.1 | P1.S4.C08 |

### Phase 4: Core Feature — Montage Reveal + Playback

| # | Task | Files | Est. Lines | Dependencies | Criteria |
|---|------|-------|------------|--------------|----------|
| 4.1 | Verify `montage` route renders MontagePlayer when montage status is `ready` | `app/trip/[id]/montage.tsx`, `components/post-trip/MontagePlayer.tsx` | ~15 (review/fix) | 1.3 | P1.S4.C21 |
| 4.2 | Verify montage player share button uses native Share API with video file | `components/post-trip/MontagePlayer.tsx` | ~10 (review) | 4.1 | P1.S4.C22 |
| 4.3 | Handle montage processing state: "Your time capsule is being prepared..." | `app/trip/[id]/montage.tsx` | ~20 | 4.1 | P1.S4.C30 |
| 4.4 | Handle 0-submission empty state (Screen 13.6) | `app/trip/[id]/montage.tsx` or `components/post-trip/TripCompleteSheet.tsx` | ~25 | 4.1 | P1.S4.C29 |
| 4.5 | Mark `capsule_viewed = true` in `trip_post_review_status` after first viewing | `app/trip/[id]/montage.tsx`, `utils/supabaseStorage.ts` | ~10 | 4.1, 1.1 | -- |

### Phase 5: Group Favorites Aggregation

| # | Task | Files | Est. Lines | Dependencies | Criteria |
|---|------|-------|------------|--------------|----------|
| 5.1 | Verify `group-favorites` route renders ranked activity list with vote counts | `app/trip/[id]/group-favorites.tsx`, `components/post-trip/GroupFavoritesSection.tsx` | ~15 (review/fix) | 3.5 | P1.S4.C23 |
| 5.2 | Show progress bar "X of Y people voted" when < 100% participation | `app/trip/[id]/group-favorites.tsx` | ~10 | 5.1 | P1.S4.C23 |
| 5.3 | Wire `GroupFavoritesSection` into completed trip detail screen | `app/trip/[id].tsx` | ~20 | 5.1 | P1.S4.C24 |

### Phase 6: Home Screen Re-engagement

| # | Task | Files | Est. Lines | Dependencies | Criteria |
|---|------|-------|------------|--------------|----------|
| 6.1 | Integrate `Top3ReminderBanner` into home screen past trip cards | `app/(tabs)/index.tsx`, `components/post-trip/Top3ReminderBanner.tsx` | ~40 | 3.6, 1.1 | P1.S4.C06, P1.S4.C25 |
| 6.2 | Add batch fetch of `trip_post_review_status` for all past trips on home screen | `app/(tabs)/index.tsx`, `utils/supabaseStorage.ts` | ~30 | 6.1 | P1.S4.C06 |
| 6.3 | Banner disappears after favorites submitted (re-check status on return) | `app/(tabs)/index.tsx` | ~10 | 6.1, 3.6 | P1.S4.C08 |
| 6.4 | Integrate `MontageCard` into completed trip detail screen (persistent re-watch) | `app/trip/[id].tsx`, `components/post-trip/MontageCard.tsx` | ~25 | 4.1 | P1.S4.C21 |

### Phase 7: Notifications + Push + Deep Links

| # | Task | Files | Est. Lines | Dependencies | Criteria |
|---|------|-------|------------|--------------|----------|
| 7.1 | Verify notification deep link handler routes correctly for all post-trip types | `utils/notifications.ts`, root layout or navigation handler | ~20 (review/fix) | 4.1, 3.1 | P1.S4.C07 |
| 7.2 | Wire `tripful://trip/{tripId}?action=post-trip-review` deep link in Expo Router | `app/_layout.tsx` or `app/trip/[id].tsx` | ~25 | 7.1 | P1.S4.C07 |
| 7.3 | Verify `post-trip-notifications` edge function sends correct nudges on schedule | `supabase/functions/post-trip-notifications/index.ts` | ~15 (review) | 1.1 | P1.S4.C07, P1.S4.C15 |
| 7.4 | Verify `trigger-montage-reveal` sends simultaneous push to all members | `supabase/functions/trigger-montage-reveal/index.ts` | ~10 (review) | 4.1 | P1.S4.C18 |
| 7.5 | Add time capsule education push on trip join | Integration point in join flow | ~15 | -- | P1.S4.C14 |
| 7.6 | Add notification preference toggles to settings UI | Settings screen component | ~40 | -- | -- |

### Phase 8: Edge Function — Montage Generation

| # | Task | Files | Est. Lines | Dependencies | Criteria |
|---|------|-------|------------|--------------|----------|
| 8.1 | Verify `generate-montage` edge function scaffold handles all statuses | `supabase/functions/generate-montage/index.ts` | ~20 (review) | -- | P1.S4.C17 |
| 8.2 | Add retry logic with exponential backoff (3 retries on failure) | `supabase/functions/generate-montage/index.ts` | ~30 | 8.1 | P1.S4.C30 |
| 8.3 | Document video processing infrastructure decision (FFmpeg on Hetzner vs. external service) | Inline code comments + plan doc | ~10 | 8.1 | P1.S4.C17, P1.S4.C19, P1.S4.C20 |

### Phase 9: Polish + Edge Cases

| # | Task | Files | Est. Lines | Dependencies | Criteria |
|---|------|-------|------------|--------------|----------|
| 9.1 | Handle trip with no end date (post-trip flow never triggers) | `hooks/usePostTripStatus.ts` | ~5 (verify) | -- | FRD Edge Case |
| 9.2 | Handle user who joins trip after it ends (no post-trip flow) | `hooks/usePostTripStatus.ts` | ~10 | -- | FRD Edge Case |
| 9.3 | Low-participation feedback: "Submit more videos next time!" when < 3 clips | `components/post-trip/TripCompleteSheet.tsx` or montage route | ~15 | 4.4 | P1.S4.C16 |
| 9.4 | Add placeholder note to all UI components: "Figma designs pending, UI may adjust" | All `components/post-trip/*.tsx`, `components/time-capsule/*.tsx` | ~0 (already present) | -- | -- |
| 9.5 | Run `npm run typecheck` and fix all type errors | Multiple files | Variable | All above | P1.S4.C31 |
| 9.6 | Run `npm test` and fix any broken tests | `__tests__/` | Variable | 9.5 | P1.S4.C31 |

---

## Files to Create

| File | Purpose |
|------|---------|
| (None — all files already exist on branch) | -- |

## Files to Modify

| File | Changes |
|------|---------|
| `app/(tabs)/index.tsx` | Integrate `Top3ReminderBanner` on past trip cards; batch-fetch post-review statuses |
| `app/trip/[id].tsx` | Wire `GroupFavoritesSection` and `MontageCard` into completed trip detail view |
| `app/trip/[id]/pick-favorites.tsx` | Edge cases: < 3 activities, 0 activities |
| `app/trip/[id]/montage.tsx` | Processing state, empty state, mark capsule viewed |
| `app/trip/[id]/group-favorites.tsx` | Progress bar, vote count display verification |
| `app/_layout.tsx` | Deep link handler for `tripful://trip/{tripId}?action=post-trip-review` |
| `app.json` | Add `NSCameraUsageDescription`, `NSMicrophoneUsageDescription` if missing |
| `components/time-capsule/TimeCapsuleCapture.tsx` | Camera permission flow |
| `components/post-trip/TripCompleteSheet.tsx` | Edge cases: 0 activities, low participation |
| `utils/supabaseStorage.ts` | Verify atomic favorites insert, blind mechanic on safe view |
| `utils/notifications.ts` | Verify deep link targets, education push helper |
| `hooks/usePostTripStatus.ts` | Edge cases: no end date, post-join timing |
| `supabase/functions/generate-montage/index.ts` | Retry logic, infrastructure notes |
| `supabase/functions/post-trip-notifications/index.ts` | Nudge scheduling verification |

## Migration Plan

### Migrations (5 files, deploy in order)

| Order | File | Purpose |
|-------|------|---------|
| 1 | `supabase/migrations/20260316000000_post_trip_review_tables.sql` | Core tables: `time_capsule_submissions`, `favorite_activities`, `montages` + RLS + safe view |
| 2 | `supabase/migrations/20260316000001_time_capsule_bucket.sql` | Storage bucket `time-capsule` |
| 3 | `supabase/migrations/20260316000002_montages_bucket.sql` | Storage bucket `montages` |
| 4 | `supabase/migrations/20260316000003_notification_prefs_post_trip.sql` | Notification preference columns |
| 5 | `supabase/migrations/20260316100000_post_review_status.sql` | Per-user review tracking table `trip_post_review_status` |

### RLS Summary

| Table | INSERT | SELECT | UPDATE | DELETE |
|-------|--------|--------|--------|--------|
| `time_capsule_submissions` | Own + trip member | Trip members (metadata only via safe view) | -- | Own only |
| `favorite_activities` | Own + trip member | Trip members | -- | Own only |
| `montages` | -- (service role only) | Trip members | -- (service role only) | -- |
| `trip_post_review_status` | Own only | Own only | Own only | -- |

### Key Security Decisions

- `time_capsule_submissions_safe` VIEW excludes `storage_path` — enforces blind mechanic at DB layer (P1.S4.C27)
- Montage INSERT/UPDATE restricted to service role — only edge functions create/update montages
- `SECURITY INVOKER` for any RPCs (per Supabase best practices)

---

## Risk Areas

| Risk | Impact | Mitigation |
|------|--------|------------|
| FFmpeg not available on Deno edge runtime | Montage generation fails entirely (P1.S4.C17) | `generate-montage` is scaffolded only. Actual video processing requires Hetzner worker or external service. Document this clearly. Ship client-side first, montage generation as a follow-up. |
| Camera permissions denied on iOS | Users cannot capture time capsule content (P1.S4.C09) | Graceful fallback: show settings deep link. Test on physical device. |
| Large video uploads on slow connections | Upload fails silently, poor UX | Client-side: show upload progress indicator. Future: background upload queue (out of scope for v1). |
| `time_capsule_submissions_safe` view performance | Slow queries on large trips | Index on `trip_id` already present. Monitor query plans post-deploy. |
| `trip_post_review_status` not deployed (untracked file) | Re-engagement banner queries fail | Stage and commit immediately (Task 1.1). |
| Spotify playlist integration for montage music | Spotify API requires OAuth, adds complexity (P1.S4.C20) | Default to ambient track for v1. Spotify integration is scaffolded but deferred to post-v1. |
| Concurrent favorites submission from same user | Race condition could create > 3 favorites | UNIQUE constraints on `(trip_id, user_id, rank)` and `(trip_id, user_id, activity_id)` prevent duplicates at DB level. |

---

## Implementation Order (Critical Path)

1. **1.1** — Stage untracked migration
2. **1.2** — Verify all migrations
3. **1.3** — Verify types match migrations
4. **1.4** — Add camera permissions to `app.json`
5. **2.1 → 2.5** — Time capsule capture verification
6. **3.1 → 3.6** — Trip complete + favorites flow
7. **4.1 → 4.5** — Montage reveal + playback
8. **5.1 → 5.3** — Group favorites aggregation
9. **6.1 → 6.4** — Home screen re-engagement (major integration gap)
10. **7.1 → 7.6** — Notifications + deep links
11. **8.1 → 8.3** — Montage generation edge function polish
12. **9.1 → 9.6** — Edge cases + typecheck + tests

---

## Verification Checkpoints

| After Task(s) | Verification |
|---------------|-------------|
| 1.3 | `npm run typecheck` — types compile cleanly |
| 2.5 | Manual: open Vibe tab on active trip → capsule section visible, no storage_path leakage |
| 3.6 | `npm run typecheck` + manual: complete top 3 flow end-to-end |
| 4.5 | Manual: open montage route → handles all 3 states (ready, processing, empty) |
| 5.3 | Manual: completed trip shows group favorites section |
| 6.4 | `npm run typecheck` + manual: home screen shows banner on past trip without favorites |
| 7.2 | Manual: tap push notification → navigates to correct screen |
| 9.5 | `npm run typecheck` — zero errors |
| 9.6 | `npm test` — all tests pass |

---

## Criteria Coverage Matrix

| Criterion | Phase.Task | Status |
|-----------|-----------|--------|
| P1.S4.C01 — Trip Complete sheet auto-appears | 3.1 | Built, needs verification |
| P1.S4.C02 — Stats bar accuracy | 3.1 | Built, needs verification |
| P1.S4.C03 — Independent of expense settlement | 3.1 | Built, needs verification |
| P1.S4.C04 — Select exactly 3 favorites | 3.2 | Built, needs verification |
| P1.S4.C05 — Favorites persist per-user | 3.5 | Built, needs verification |
| P1.S4.C06 — Blinking banner on past trip card | **6.1** | **NOT INTEGRATED — gap** |
| P1.S4.C07 — Push notification reminder | 7.1, 7.2, 7.3 | Built (edge function), deep link needs wiring |
| P1.S4.C08 — Banner disappears after submit | **6.3** | **NOT INTEGRATED — gap** |
| P1.S4.C09 — Record/submit 6-sec clips | 2.2, 2.3 | Built, needs permission flow |
| P1.S4.C10 — Blind mechanic enforced | 2.5 | Built via safe view, needs verification |
| P1.S4.C11 — Delete own submission | 2.4 | Built, needs verification |
| P1.S4.C12 — Capture UI on Vibe tab | 2.1 | Built, needs verification |
| P1.S4.C13 — Photos + videos accepted | 2.2 | Built, needs verification |
| P1.S4.C14 — Education on trip join | 7.5 | Helper exists, integration point needed |
| P1.S4.C15 — Mid-trip nudge | 7.3 | Built in edge function, needs verification |
| P1.S4.C16 — Low-participation feedback | 9.3 | Needs implementation |
| P1.S4.C17 — 60-sec montage generated | 8.1 | Scaffolded only (no real FFmpeg) |
| P1.S4.C18 — Simultaneous reveal push | 7.4 | Built, needs verification |
| P1.S4.C19 — Disposable camera aesthetic | 8.3 | Deferred (requires video processing infra) |
| P1.S4.C20 — Montage music from Spotify/default | 8.3 | Scaffolded, Spotify deferred |
| P1.S4.C21 — Montage re-watchable from trip detail | **6.4** | **NOT INTEGRATED — gap** |
| P1.S4.C22 — Share button with native share sheet | 4.2 | Built, needs verification |
| P1.S4.C23 — Group favorites ranked by votes | 5.1 | Built, needs verification |
| P1.S4.C24 — Group favorites visible to all members | **5.3** | **NOT INTEGRATED — gap** |
| P1.S4.C25 — Home screen completed state | **6.1** | **NOT INTEGRATED — gap** |
| P1.S4.C26 — Non-members cannot access | 1.2 | Built via RLS, needs verification |
| P1.S4.C27 — No preview/gallery of submitted clips | 2.5 | Built via safe view, needs verification |
| P1.S4.C28 — < 3 activities edge case | 3.3 | Needs implementation |
| P1.S4.C29 — 0 submissions graceful handling | 4.4 | Partially built, needs verification |
| P1.S4.C30 — Async montage processing state | 4.3 | Needs implementation |
| P1.S4.C31 — Typecheck passes | 9.5 | Run after all changes |

**Bold** = primary remaining gaps that require new code.

---

## Dev Notes

- All placeholder components include `// NOTE: UI is placeholder. Expect adjustments when Figma designs arrive with new skin/layout.` — Figma screens are not yet designed.
- Montage generation (P1.S4.C17, C19, C20) is scaffolded as an edge function but **actual video processing requires server-side infrastructure** (Hetzner worker with FFmpeg). The client-side flow (player, share, states) should ship first; montage generation is a separate deployment task.
- Use `@/` path aliases throughout. Follow `StyleSheet.create()` pattern. No inline styles.
- The `trip_post_review_status` migration must be staged and committed — it is currently untracked.
