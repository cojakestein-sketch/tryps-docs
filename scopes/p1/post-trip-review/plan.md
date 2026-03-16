# post-trip-review — Implementation Plan

**Spec:** /Users/jakestein/tryps-docs/scopes/p1/post-trip-review/spec.md
**Branch:** feat/post-trip-review

> **Note:** Figma screens are not yet designed. All UI is placeholder/best-guess. Developers should expect UI adjustments when Figma designs arrive with the new skin and layout.

---

## Task Breakdown

### Phase 1: Foundation (Database + Types + Storage Bucket)

| #   | Task | Files | Est. Lines | Dependencies |
| --- | ---- | ----- | ---------- | ------------ |
| 1.1 | Create migration: `time_capsule_submissions` table (stores blind video/photo submissions per trip), `favorite_activities` table (stores each user's top 3 picks per trip), `montages` table (stores generated montage metadata per trip). Enable RLS on all three. | `supabase/migrations/20260316000000_post_trip_review_tables.sql` | ~120 | None |
| 1.2 | Create migration: `time-capsule` storage bucket (private — no public read, uploads scoped to trip members, no SELECT until reveal). | `supabase/migrations/20260316000001_time_capsule_bucket.sql` | ~40 | None |
| 1.3 | Create migration: `montages` storage bucket (public read — generated montage videos accessible to all trip members for playback and sharing). | `supabase/migrations/20260316000002_montages_bucket.sql` | ~30 | None |
| 1.4 | Add new types: `TimeCapsuleSubmission`, `FavoriteActivity`, `Montage`, `PostTripStatus`. Extend `Trip` interface with optional `postTripStatus` and `montage` fields. Add `ActivityCategory` badge display type. | `types/index.ts` | ~80 | None |
| 1.5 | Add notification preference fields: `time_capsule_reveal`, `top3_reminder`. Migration to extend `notification_preferences` table. | `supabase/migrations/20260316000003_notification_prefs_post_trip.sql`, `types/index.ts` (update `NotificationPreferences`) | ~30 | 1.1 |

### Phase 2: Data Layer (Storage + Supabase CRUD)

| #   | Task | Files | Est. Lines | Dependencies |
| --- | ---- | ----- | ---------- | ------------ |
| 2.1 | Add supabaseStorage functions: `submitTimeCapsuleItem()`, `deleteTimeCapsuleItem()`, `getTimeCapsuleCount()`, `getMyTimeCapsuleSubmissions()` (returns count + IDs only, no media URLs — blind mechanic). Upload to `time-capsule` bucket, insert into `time_capsule_submissions`. | `utils/supabaseStorage.ts` | ~90 | 1.1, 1.2 |
| 2.2 | Add supabaseStorage functions: `submitFavoriteActivities()`, `getFavoriteActivities()`, `hasSubmittedFavorites()`, `getGroupFavorites()` (aggregated view with vote counts). | `utils/supabaseStorage.ts` | ~80 | 1.1 |
| 2.3 | Add supabaseStorage functions: `getMontage()`, `setMontageStatus()`. Read from `montages` table, return signed URL from `montages` bucket. | `utils/supabaseStorage.ts` | ~50 | 1.1, 1.3 |
| 2.4 | Add supabaseStorage function: `getTripPostTripStatus()` — returns composite status: has user submitted top 3, time capsule count, montage status (pending/processing/ready/none), group favorites available. | `utils/supabaseStorage.ts` | ~60 | 2.1, 2.2, 2.3 |
| 2.5 | Expose all new functions through the storage abstraction layer. Add corresponding stubs for local/offline mode that return empty state. | `utils/storage.ts` | ~70 | 2.1, 2.2, 2.3, 2.4 |

### Phase 3: Trip Completion Detection + Bottom Sheet

| #   | Task | Files | Est. Lines | Dependencies |
| --- | ---- | ----- | ---------- | ------------ |
| 3.1 | Create `usePostTripStatus` hook — determines if a trip is "completed" (day after end date), fetches post-trip status data (favorites submitted, montage state), memoizes to avoid re-fetching. `P1.S4.C01`, `P1.S4.C03` | `hooks/usePostTripStatus.ts` | ~70 | 2.4 |
| 3.2 | Create `TripCompleteSheet` component — bottom sheet overlay that appears when trip is completed and user hasn't dismissed it. Shows trip stats bar (Days, People, Places, Spent). Uses existing `DraggableBottomSheet` pattern. CTA buttons: "Pick Your Top 3" and "Watch Time Capsule" (if montage ready). `P1.S4.C01`, `P1.S4.C02`, `P1.S4.C03` | `components/post-trip/TripCompleteSheet.tsx` | ~95 | 3.1, 1.4 |
| 3.3 | Create `TripStatsBar` component — horizontal stat badges: Days, People, Places, Spent. Reusable across the sheet and completed trip view. Calculates stats from trip data. `P1.S4.C02` | `components/post-trip/TripStatsBar.tsx` | ~70 | 1.4 |
| 3.4 | Integrate `TripCompleteSheet` into trip detail screen. Show as overlay when `usePostTripStatus` returns `shouldShowSheet: true`. Dismiss persists to AsyncStorage per-user per-trip. `P1.S4.C01`, `P1.S4.C03` | `app/trip/[id].tsx` | ~30 | 3.2, 3.3 |

### Phase 4: Top 3 Favorite Activities Selection

| #   | Task | Files | Est. Lines | Dependencies |
| --- | ---- | ----- | ---------- | ------------ |
| 4.1 | Create `FavoritePickerScreen` — full-screen modal showing trip's activity list as tappable cards with photo + category badge. Step indicator dots (1/3, 2/3, 3/3). Submit button enables at 3/3 (or N/N if fewer than 3 activities). `P1.S4.C04`, `P1.S4.C28` | `app/trip/[id]/pick-favorites.tsx` | ~95 | 2.2, 1.4 |
| 4.2 | Create `FavoriteActivityCard` component — activity card with photo thumbnail, category badge (Culture, Food & Drink, Nightlife, etc.), selected state with checkmark overlay. `P1.S4.C04` | `components/post-trip/FavoriteActivityCard.tsx` | ~75 | 1.4 |
| 4.3 | Create `StepIndicator` component — reusable dot indicator (1/3, 2/3, 3/3) with counter text. `P1.S4.C04` | `components/post-trip/StepIndicator.tsx` | ~40 | None |
| 4.4 | Wire up submit flow: on submit, call `submitFavoriteActivities()`, dismiss sheet, update post-trip status. Show success toast. `P1.S4.C05`, `P1.S4.C08` | `app/trip/[id]/pick-favorites.tsx` (update) | ~30 | 4.1, 2.2 |

### Phase 5: Time Capsule — Capture Phase (During Trip)

| #   | Task | Files | Est. Lines | Dependencies |
| --- | ---- | ----- | ---------- | ------------ |
| 5.1 | Create `TimeCapsuleCapture` component — camera/picker UI for recording 6-second video clips or selecting photos. Uses `expo-image-picker` for both photo and video (max 6s duration). Disposable camera aesthetic styling (grain overlay, warm tint, date stamp). `P1.S4.C09`, `P1.S4.C13` | `components/time-capsule/TimeCapsuleCapture.tsx` | ~95 | 1.4, 2.1 |
| 5.2 | Create `TimeCapsuleSection` component — section on the Vibe tab showing capture button, submission count ("You've added 2 moments"), delete own clip option. No previews of submitted content (blind mechanic). `P1.S4.C10`, `P1.S4.C11`, `P1.S4.C12` | `components/time-capsule/TimeCapsuleSection.tsx` | ~80 | 5.1, 2.1 |
| 5.3 | Integrate `TimeCapsuleSection` into `VibeTab`. Show only during active trips (between start and end dates). `P1.S4.C12` | `components/VibeTab.tsx` | ~20 | 5.2 |
| 5.4 | Add upload logic: compress video to max 6s, upload to `time-capsule` bucket under `{tripId}/{submissionId}`, insert record. Show confirmation toast. `P1.S4.C09`, `P1.S4.C13` | `utils/timeCapsule.ts` | ~70 | 1.2, 2.1 |

### Phase 6: Time Capsule — Reveal + Montage Playback

| #   | Task | Files | Est. Lines | Dependencies |
| --- | ---- | ----- | ---------- | ------------ |
| 6.1 | Create edge function `generate-montage` — triggered after trip ends. Fetches all submissions from `time-capsule` bucket, uses FFmpeg (or open-source video tooling) to stitch clips + photos into 60s montage. Applies disposable camera filter. Uploads result to `montages` bucket. Updates `montages` table status. `P1.S4.C17`, `P1.S4.C19` | `supabase/functions/generate-montage/index.ts` | ~95 | 1.1, 1.2, 1.3 |
| 6.2 | Create edge function `trigger-montage-reveal` — sends simultaneous push notification to all trip members when montage is ready. Called by `generate-montage` on completion. `P1.S4.C18` | `supabase/functions/trigger-montage-reveal/index.ts` | ~60 | 6.1 |
| 6.3 | Create `MontagePlayer` component — full-screen video player for the generated montage. Share button triggers native share sheet with video file. Uses `expo-av` or `expo-video` for playback. `P1.S4.C21`, `P1.S4.C22` | `components/post-trip/MontagePlayer.tsx` | ~85 | 2.3 |
| 6.4 | Create `MontageRevealScreen` — the "reveal" experience. Loading state ("Your time capsule is being created...") while processing, then auto-plays montage when ready. `P1.S4.C30` | `app/trip/[id]/montage.tsx` | ~70 | 6.3, 2.3 |
| 6.5 | Add montage music logic: if trip has `spotifyPlaylistUrl`, extract track reference; otherwise use bundled ambient default track. Pass audio source to montage generation. `P1.S4.C20` | `supabase/functions/generate-montage/index.ts` (update), `utils/timeCapsule.ts` (update) | ~40 | 6.1 |

### Phase 7: Group Top 3 Aggregation

| #   | Task | Files | Est. Lines | Dependencies |
| --- | ---- | ----- | ---------- | ------------ |
| 7.1 | Create `GroupFavoritesSection` component — ranked list of activities by vote count. Shows "4 of 6 people loved this" label. Visible once majority has submitted. `P1.S4.C23`, `P1.S4.C24` | `components/post-trip/GroupFavoritesSection.tsx` | ~80 | 2.2 |
| 7.2 | Create `GroupFavoritesScreen` — full-screen view of group top 3 with share capability. Accessible from completed trip detail. `P1.S4.C23`, `P1.S4.C24` | `app/trip/[id]/group-favorites.tsx` | ~60 | 7.1 |

### Phase 8: Home Screen + Re-engagement

| #   | Task | Files | Est. Lines | Dependencies |
| --- | ---- | ----- | ---------- | ------------ |
| 8.1 | Add "completed" visual state to trip cards on home screen. Completed trips show different styling (muted, with "Completed" badge). `P1.S4.C25` | `components/StackedTripCards.tsx` | ~30 | 3.1 |
| 8.2 | Add blinking "Mark your top 3 favorites" banner to past trip cards when user hasn't submitted. Banner persists until submission. Animated pulsing indicator. `P1.S4.C06`, `P1.S4.C08`, `P1.S4.C25` | `components/post-trip/Top3ReminderBanner.tsx` | ~55 | 3.1, 2.2 |
| 8.3 | Integrate `Top3ReminderBanner` into `StackedTripCards` for past trips. Check `hasSubmittedFavorites()` to conditionally show. `P1.S4.C06`, `P1.S4.C25` | `components/StackedTripCards.tsx` | ~20 | 8.2 |

### Phase 9: Push Notifications + Nudges

| #   | Task | Files | Est. Lines | Dependencies |
| --- | ---- | ----- | ---------- | ------------ |
| 9.1 | Create edge function `post-trip-notifications` — scheduled function that checks for recently ended trips and sends: (a) top 3 reminder if dismissed, (b) mid-trip time capsule nudge, (c) low-participation feedback. `P1.S4.C07`, `P1.S4.C14`, `P1.S4.C15`, `P1.S4.C16` | `supabase/functions/post-trip-notifications/index.ts` | ~90 | 1.1, 6.2 |
| 9.2 | Add push notification handling for montage reveal — deep link from notification opens `MontageRevealScreen`. Handle time capsule education message on trip join. `P1.S4.C14`, `P1.S4.C18` | `utils/notifications.ts` (update) | ~30 | 6.2 |

### Phase 10: Security + Edge Cases

| #   | Task | Files | Est. Lines | Dependencies |
| --- | ---- | ----- | ---------- | ------------ |
| 10.1 | RLS policy hardening: non-members cannot access `time_capsule_submissions`, `favorite_activities`, or `montages` for trips they're not in. Verify via test queries. `P1.S4.C26` | `supabase/migrations/20260316000000_post_trip_review_tables.sql` (included in 1.1) | ~0 (covered in 1.1) | 1.1 |
| 10.2 | Add blind mechanic enforcement: `time_capsule_submissions` SELECT policy returns only `id`, `user_id`, `media_type`, `created_at` — never the `storage_path` or signed URL until montage is generated. `P1.S4.C27` | `supabase/migrations/20260316000000_post_trip_review_tables.sql` (included in 1.1) | ~0 (covered in 1.1) | 1.1 |
| 10.3 | Handle edge case: trip with fewer than 3 activities. `FavoritePickerScreen` adjusts max selection to `Math.min(3, activityCount)`. `P1.S4.C28` | `app/trip/[id]/pick-favorites.tsx` (included in 4.1) | ~0 (covered in 4.1) | 4.1 |
| 10.4 | Handle edge case: trip with 0 time capsule submissions. Skip montage generation, hide time capsule section in post-trip flow, show top 3 only. `P1.S4.C29` | `hooks/usePostTripStatus.ts` (update), `components/post-trip/TripCompleteSheet.tsx` (update) | ~15 | 3.1, 3.2 |
| 10.5 | Typecheck pass. Run `npm run typecheck` and fix all errors. `P1.S4.C31` | All files | ~0 | All |

### Phase 11: Completed Trip Detail Integration

| #   | Task | Files | Est. Lines | Dependencies |
| --- | ---- | ----- | ---------- | ------------ |
| 11.1 | Add "Post-Trip" section to completed trip detail screen. Shows: montage player (if ready), group favorites (if available), user's own picks. Permanent artifact on the trip. `P1.S4.C21`, `P1.S4.C24` | `app/trip/[id].tsx` (update) | ~40 | 6.3, 7.1, 3.1 |
| 11.2 | Add re-watchable montage entry point on completed trip detail. Always accessible after initial reveal. `P1.S4.C21` | `components/post-trip/MontageCard.tsx` | ~50 | 6.3 |

---

## Files to Create

| File | Purpose |
| ---- | ------- |
| `supabase/migrations/20260316000000_post_trip_review_tables.sql` | DB tables: `time_capsule_submissions`, `favorite_activities`, `montages` + RLS |
| `supabase/migrations/20260316000001_time_capsule_bucket.sql` | Private storage bucket for blind media submissions |
| `supabase/migrations/20260316000002_montages_bucket.sql` | Public storage bucket for generated montage videos |
| `supabase/migrations/20260316000003_notification_prefs_post_trip.sql` | Notification preference columns for post-trip features |
| `hooks/usePostTripStatus.ts` | Hook: trip completion detection + post-trip status aggregation |
| `components/post-trip/TripCompleteSheet.tsx` | Bottom sheet overlay for completed trip entry point |
| `components/post-trip/TripStatsBar.tsx` | Horizontal stat badges (Days, People, Places, Spent) |
| `components/post-trip/FavoriteActivityCard.tsx` | Selectable activity card for top 3 picker |
| `components/post-trip/StepIndicator.tsx` | Dot indicator + counter (1/3, 2/3, 3/3) |
| `components/post-trip/GroupFavoritesSection.tsx` | Ranked group favorites with vote counts |
| `components/post-trip/MontagePlayer.tsx` | Full-screen video player with share button |
| `components/post-trip/MontageCard.tsx` | Thumbnail card entry point for re-watching montage |
| `components/post-trip/Top3ReminderBanner.tsx` | Blinking banner for un-submitted users on home screen |
| `components/time-capsule/TimeCapsuleCapture.tsx` | Camera/picker UI for 6-second clips + photos |
| `components/time-capsule/TimeCapsuleSection.tsx` | Vibe tab section: capture button + submission count |
| `utils/timeCapsule.ts` | Upload, compress, and manage time capsule media |
| `app/trip/[id]/pick-favorites.tsx` | Full-screen top 3 favorites selection flow |
| `app/trip/[id]/montage.tsx` | Montage reveal + playback screen |
| `app/trip/[id]/group-favorites.tsx` | Group favorites aggregation screen |
| `supabase/functions/generate-montage/index.ts` | Edge function: stitch clips into 60s montage |
| `supabase/functions/trigger-montage-reveal/index.ts` | Edge function: simultaneous reveal push notification |
| `supabase/functions/post-trip-notifications/index.ts` | Edge function: scheduled nudges (top 3 reminder, capsule nudge) |

## Files to Modify

| File | Changes |
| ---- | ------- |
| `types/index.ts` | Add `TimeCapsuleSubmission`, `FavoriteActivity`, `Montage`, `PostTripStatus` types. Extend `Trip` with optional `postTripStatus`. Update `NotificationPreferences`. Add `ActivityCategoryBadge` display type. |
| `utils/supabaseStorage.ts` | Add ~8 new functions for time capsule CRUD, favorites CRUD, montage read, and post-trip status aggregation. |
| `utils/storage.ts` | Expose new supabaseStorage functions through abstraction layer. Add local-mode stubs. |
| `utils/notifications.ts` | Add deep link handling for montage reveal notification and time capsule education message. Update `NotificationPreferences` interface. |
| `components/VibeTab.tsx` | Import and render `TimeCapsuleSection` during active trips. |
| `components/StackedTripCards.tsx` | Add completed trip visual state. Integrate `Top3ReminderBanner` for past trips with pending favorites. |
| `app/trip/[id].tsx` | Integrate `TripCompleteSheet` overlay. Add post-trip section to completed trip view. Import `usePostTripStatus`. |
| `components/TripHeader.tsx` | No changes needed — existing tab structure is sufficient. |

## Migration Plan

### Migration 1: `20260316000000_post_trip_review_tables.sql`

```sql
-- Time capsule submissions (blind media — no public read on storage_path)
CREATE TABLE time_capsule_submissions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    trip_id UUID NOT NULL REFERENCES trips(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    media_type TEXT NOT NULL CHECK (media_type IN ('video', 'photo')),
    storage_path TEXT NOT NULL,        -- path in time-capsule bucket
    duration_seconds NUMERIC(4,1),     -- video duration (null for photos)
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_capsule_trip ON time_capsule_submissions(trip_id);
CREATE INDEX idx_capsule_user ON time_capsule_submissions(user_id);

ALTER TABLE time_capsule_submissions ENABLE ROW LEVEL SECURITY;

-- Users can insert submissions for trips they're members of
CREATE POLICY "Members submit to time capsule" ON time_capsule_submissions
    FOR INSERT WITH CHECK (
        auth.uid() = user_id
        AND EXISTS (
            SELECT 1 FROM trip_members WHERE trip_id = time_capsule_submissions.trip_id AND user_id = auth.uid()
        )
    );

-- Users can see metadata of submissions (id, user_id, media_type, created_at) but NOT storage_path
-- Enforced at query level — storage_path never returned to client until montage phase
CREATE POLICY "Members view capsule metadata" ON time_capsule_submissions
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM trip_members WHERE trip_id = time_capsule_submissions.trip_id AND user_id = auth.uid()
        )
    );

-- Users can delete their own submissions
CREATE POLICY "Users delete own submissions" ON time_capsule_submissions
    FOR DELETE USING (auth.uid() = user_id);

-- Favorite activities (user's top 3 picks per trip)
CREATE TABLE favorite_activities (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    trip_id UUID NOT NULL REFERENCES trips(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    activity_id UUID NOT NULL REFERENCES trip_activities(id) ON DELETE CASCADE,
    rank INTEGER NOT NULL CHECK (rank BETWEEN 1 AND 3),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(trip_id, user_id, activity_id),
    UNIQUE(trip_id, user_id, rank)
);

CREATE INDEX idx_favorites_trip ON favorite_activities(trip_id);
CREATE INDEX idx_favorites_user ON favorite_activities(user_id);

ALTER TABLE favorite_activities ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Members submit favorites" ON favorite_activities
    FOR INSERT WITH CHECK (
        auth.uid() = user_id
        AND EXISTS (
            SELECT 1 FROM trip_members WHERE trip_id = favorite_activities.trip_id AND user_id = auth.uid()
        )
    );

CREATE POLICY "Members view favorites" ON favorite_activities
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM trip_members WHERE trip_id = favorite_activities.trip_id AND user_id = auth.uid()
        )
    );

-- Montages (generated video per trip)
CREATE TABLE montages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    trip_id UUID NOT NULL REFERENCES trips(id) ON DELETE CASCADE UNIQUE,
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'processing', 'ready', 'failed')),
    storage_path TEXT,                  -- path in montages bucket (null until ready)
    duration_seconds NUMERIC(5,1),     -- montage duration
    music_source TEXT,                  -- 'spotify' or 'default'
    submission_count INTEGER DEFAULT 0, -- how many clips/photos were included
    created_at TIMESTAMPTZ DEFAULT NOW(),
    completed_at TIMESTAMPTZ
);

CREATE INDEX idx_montages_trip ON montages(trip_id);

ALTER TABLE montages ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Members view montage" ON montages
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM trip_members WHERE trip_id = montages.trip_id AND user_id = auth.uid()
        )
    );
```

### Migration 2: `20260316000001_time_capsule_bucket.sql`

```sql
-- Private bucket — no public read. RLS controls access.
INSERT INTO storage.buckets (id, name, public)
VALUES ('time-capsule', 'time-capsule', false)
ON CONFLICT (id) DO NOTHING;

-- Trip members can upload to their trip's folder
CREATE POLICY "Members upload capsule media" ON storage.objects FOR INSERT
    WITH CHECK (
        bucket_id = 'time-capsule'
        AND auth.role() = 'authenticated'
        AND EXISTS (
            SELECT 1 FROM trip_members
            WHERE trip_id = (storage.foldername(name))[1]::uuid
            AND user_id = auth.uid()
        )
    );

-- Users can delete their own uploads
CREATE POLICY "Users delete own capsule media" ON storage.objects FOR DELETE
    USING (
        bucket_id = 'time-capsule'
        AND auth.role() = 'authenticated'
        AND (storage.foldername(name))[2] = auth.uid()::text
    );

-- No SELECT policy for regular users — only service role can read for montage generation
```

### Migration 3: `20260316000002_montages_bucket.sql`

```sql
-- Public bucket for generated montage playback
INSERT INTO storage.buckets (id, name, public)
VALUES ('montages', 'montages', true)
ON CONFLICT (id) DO NOTHING;

CREATE POLICY "Public montage read access" ON storage.objects FOR SELECT
    USING (bucket_id = 'montages');

-- Only service role uploads montages (edge function) — no user INSERT policy needed
```

### Migration 4: `20260316000003_notification_prefs_post_trip.sql`

```sql
ALTER TABLE notification_preferences
    ADD COLUMN IF NOT EXISTS time_capsule_reveal BOOLEAN DEFAULT TRUE,
    ADD COLUMN IF NOT EXISTS top3_reminder BOOLEAN DEFAULT TRUE,
    ADD COLUMN IF NOT EXISTS time_capsule_nudge BOOLEAN DEFAULT TRUE;
```

## Risk Areas

| Risk | Impact | Mitigation |
| ---- | ------ | ---------- |
| Video processing on edge functions is heavy / may timeout | Montage generation fails or is too slow | Use Deno FFmpeg bindings with aggressive time limits. Fall back to simpler "slideshow" if full montage fails. Consider offloading to a background worker (Hetzner server) if edge function limits are hit. |
| 6-second video uploads could be large (~5-10MB each) | Storage costs, slow uploads on bad connections | Compress on-device before upload (720p max, H.264). Set per-trip submission limit (e.g., 20 clips max). |
| Blind mechanic requires careful RLS — leaking `storage_path` breaks the feature | Users could see clips before reveal | Never return `storage_path` in client queries. Use column-level query restriction in `supabaseStorage.ts`. Storage bucket has no user SELECT policy. |
| `expo-image-picker` video recording may not enforce exact 6-second limit | Clips longer than 6s get submitted | Validate duration client-side before upload. Trim to 6s server-side in `generate-montage` as safety net. |
| Simultaneous push notification delivery is "best effort" | Not all users see reveal at the exact same moment | Acceptable — push is inherently async. The "simultaneous" experience is the notification, not the generation. |
| Montage music from Spotify requires API access / licensing | Can't use actual Spotify tracks in montage | Use a royalty-free default ambient track. Spotify integration is aspirational — note this as an open question in the spec. |
| `expo-av` or `expo-video` package may not be in current dependencies | Build fails if not installed | Check `package.json` and install `expo-av` if missing (task 6.3). |
| New tables reference `trip_activities` — FK could fail if activity is deleted after being favorited | Orphaned favorites | `ON DELETE CASCADE` on the FK handles this. UI should gracefully handle missing activity data. |

## Implementation Order

Critical path (must be sequential):

1. **1.1** → Database tables (everything depends on this)
2. **1.2, 1.3** → Storage buckets (parallel with each other, after 1.1)
3. **1.4** → Types (parallel with 1.2/1.3)
4. **1.5** → Notification prefs migration
5. **2.1, 2.2, 2.3** → Supabase CRUD functions (parallel with each other, after 1.x)
6. **2.4** → Post-trip status aggregation (after 2.1-2.3)
7. **2.5** → Storage abstraction (after 2.4)
8. **3.1** → `usePostTripStatus` hook (after 2.5)
9. **3.2, 3.3** → Trip complete sheet + stats bar (parallel, after 3.1)
10. **3.4** → Integrate sheet into trip detail (after 3.2, 3.3)
11. **4.1, 4.2, 4.3** → Top 3 picker screen + components (parallel, after 2.2)
12. **4.4** → Wire up submit flow (after 4.1)
13. **5.1, 5.4** → Time capsule capture + upload logic (parallel, after 2.1)
14. **5.2** → Time capsule section component (after 5.1, 5.4)
15. **5.3** → Integrate into Vibe tab (after 5.2)
16. **6.1** → Generate montage edge function (after 1.x)
17. **6.2** → Trigger reveal edge function (after 6.1)
18. **6.3** → Montage player component (after 2.3)
19. **6.4** → Montage reveal screen (after 6.3)
20. **6.5** → Montage music (after 6.1)
21. **7.1** → Group favorites section (after 2.2)
22. **7.2** → Group favorites screen (after 7.1)
23. **8.1, 8.2** → Home screen completed state + banner (parallel, after 3.1)
24. **8.3** → Integrate banner (after 8.2)
25. **9.1** → Push notification edge function (after 6.2)
26. **9.2** → Notification handling (after 9.1)
27. **11.1, 11.2** → Completed trip detail integration (after 6.3, 7.1)
28. **10.4, 10.5** → Edge cases + typecheck (last)

## Verification Checkpoints

| After Task(s) | Verification |
| -------------- | ------------ |
| 1.1 – 1.5 | `npm run typecheck` — types compile, no errors from new type additions |
| 2.5 | `npm run typecheck` — storage layer compiles with all new functions |
| 3.4 | `npm run typecheck` + manual test: open a past trip → bottom sheet appears with stats |
| 4.4 | `npm run typecheck` + manual test: pick 3 activities → submit → success toast → sheet dismissed |
| 5.3 | `npm run typecheck` + manual test: active trip → Vibe tab → capture section visible → submit clip → count increments |
| 6.4 | `npm run typecheck` + manual test: completed trip with submissions → montage loading state → playback works |
| 8.3 | `npm run typecheck` + manual test: home screen → past trip without favorites → blinking banner visible |
| 10.5 | `npm run typecheck` — full pass, zero errors. `npm test` — existing tests still pass. |
