# Scope 4: Post-Trip Review — FRD

> **Status:** Ready for Review
> **Phase:** P1: Core App
> **Gantt ID:** `p1-post-trip-review`
> **Date:** 2026-03-15
> **Spec:** `scopes/p1/post-trip-review/spec.md`

---

## 1. Overview

Three features, two phases:

**During Trip** — Time Capsule capture (blind photo + 6-sec video clips on Vibe tab)
**After Trip** — Trip Complete flow (top 3 favorites + time capsule reveal + group favorites)
**Ongoing** — Montage always re-watchable + shareable from completed trip

Priority order: Top 3 Favorites (#1) → Time Capsule Reveal (#2) → Group Favorites Aggregation (#3) → Capture UI (#4) → Share/Music (#5)

---

## 2. Screens

### Screen 13.1 — Time Capsule Capture (During Trip, Vibe Tab)

**Where:** New section at the top of `VibeTab.tsx`, above Group Vibe Card.

**Layout:**
- Section header: "Time Capsule" with disposable camera icon (📸 or custom)
- Subtitle: "Add blind moments. No one sees them until the trip ends."
- Two CTA buttons side by side: "Take a Photo" (camera icon) + "Record a Moment" (video icon)
- Below CTAs: submission count badge — "4 moments captured" (no names, no previews)
- If user has submitted: "You've added 2 moments" + "Delete last" link
- Visual style: slightly warm/sepia tinted section background to evoke disposable camera aesthetic

**Interactions:**
- Tap "Record a Moment" → opens camera (Screen 13.2)
- Tap "Delete last" → confirmation dialog → deletes user's most recent clip
- No preview thumbnails. No list of submissions. The section is intentionally opaque.

**States:**
| State | What shows |
|-------|-----------|
| No submissions yet | CTA + "Be the first to add a moment!" |
| Has submissions (not from user) | CTA + "X moments captured" |
| User has submitted | CTA + personal count + "Delete last" |
| Trip ended | Section hidden (replaced by reveal flow) |

---

### Screen 13.2 — Camera Capture Sheet

**Where:** Full-screen bottom sheet, opened from Screen 13.1.

**Two modes:** Photo and Video (determined by which CTA was tapped, or toggle at bottom of viewfinder).

**Layout:**
- Camera viewfinder (full width, 16:9 aspect)
- Mode toggle: Photo | Video (pill switcher at bottom of viewfinder)
- **Video mode:**
  - 6-second countdown timer (circular progress ring around record button)
  - Record button: large red circle (tap to start, auto-stops at 6s)
  - Bottom text: "6 seconds. Make it count." (before recording)
  - During recording: pulsing red border on viewfinder, countdown "4... 3... 2... 1..."
- **Photo mode:**
  - Standard shutter button (white circle)
  - Bottom text: "Capture a moment."
  - Tap → instant capture with disposable camera flash + shutter sound
- Flash toggle (top-left)
- Flip camera (top-right)
- Close (X) button (top-left, above flash)

**Post-capture (NOT a preview — this is critical):**
- Screen shows: disposable camera flash animation (white flash + shutter sound)
- Then: "Moment saved" confirmation text with checkmark
- Text: "You won't see this again until the time capsule opens."
- Single button: "Done" → returns to Vibe tab
- NO replay button. NO preview. The blind mechanic is sacred.

**Edge Cases:**
- Camera permission denied → system settings prompt
- Less than 1 second recorded (accidental tap on video) → discard, show "Hold to record for at least 1 second"
- Storage full on device → "Not enough storage" error
- No network → record locally, upload when connection returns (background upload)

---

### Screen 13.3 — Trip Complete Bottom Sheet

**Where:** Bottom sheet overlay on trip detail screen. Appears automatically the first time a user opens the trip after the end date.

**Trigger:** `trip.endDate < today && user has not dismissed/completed this flow`

**Layout (matches existing Figma Screen 1.5):**
- Header: ✅ "Trip Complete"
- Trip avatar + trip name ("Japan Trip")
- Date range + destination ("Mar 9 - Mar 23 · Kyoto")
- **Stats bar** (4 columns):
  - Days: count of days between start and end date
  - People: count of trip participants
  - Places: count of confirmed activities
  - Spent: total expenses formatted ($2.4k)
- Red accent divider line
- **Top 3 Favorites section** (Screen 13.4, inline)
- Bottom CTA: "View Time Capsule" (disabled until top 3 complete, or enabled if 0 video submissions)

**States:**
| State | Behavior |
|-------|----------|
| First open post-trip | Sheet auto-presents |
| Top 3 not yet selected | "View Time Capsule" button disabled OR dimmed with "Pick your favorites first" |
| Top 3 selected | "View Time Capsule" button enabled |
| No video submissions exist | Skip time capsule entirely — bottom CTA says "Done" instead |
| User has already completed flow | Sheet does not re-appear; trip shows in "Past" with completed state |
| User dismisses (swipe down / X) | Re-engagement kicks in (Screen 13.7) |

---

### Screen 13.4 — Top 3 Favorites Picker (Inline in 13.3)

**Where:** Embedded within the Trip Complete bottom sheet.

**Layout:**
- Section header: "Your top 3 favorites?"
- Subtitle: "Tap the activities that made this trip unforgettable."
- Step indicator: 3 dots (●○○ → ●●○ → ●●●) + counter "1/3"
- **Activity grid** (2-column, scrollable within sheet):
  - Each card: activity photo (background), name overlay, category badge (bottom-left)
  - Tap to select → green checkmark overlay + subtle scale animation
  - Tap again to deselect
  - Max 3 selections enforced (4th tap shows toast: "You've picked 3! Tap one to change it.")
- If trip has < 3 activities: show all, require selecting all of them ("Pick your favorites")
- If trip has 0 activities: skip this section entirely — show "No activities to rate" message

**Data source:** `trip_activities` where `tripId = trip.id` — show ALL activities (confirmed + unconfirmed), sorted by `scheduledDate` then `created_at`.

**On complete (3 selected):**
- Dots fill to ●●●
- Brief celebration micro-animation (confetti burst or sparkle)
- "View Time Capsule" button activates

---

### Screen 13.5 — Time Capsule Reveal (Montage Player)

**Where:** Full-screen modal, presented after "View Time Capsule" tap.

**Layout (matches existing Figma Screen 1.6):**
- Trip name header
- Date range + destination
- Stats bar (same 4 columns as 13.3)
- Red accent divider
- Label: "Your time capsule is ready"
- Subtitle: "We cut your 60-sec trip montage. Watch it now."
- **Video player** (16:9, rounded corners):
  - Auto-plays on appear
  - Disposable camera visual filter applied (grain, warm tones, slight vignette, date stamp overlay)
  - **Background music** from trip's Spotify playlist (if linked on Vibe tab), otherwise ambient default track
  - Progress bar: current time / total time
  - Pause/play toggle (bottom-left)
  - Fullscreen toggle (bottom-right)
  - Scrubbing enabled (no artificial restrictions)
  - **Share button** (top-right or below player): opens native share sheet with montage video file
    - Share targets: Instagram Stories, TikTok, iMessage, Save to Camera Roll, etc.
    - Shared video includes "Made with Tryps" watermark (subtle, bottom-right corner)
- Bottom button: "Close"

**Always re-watchable:**
- Montage is a permanent artifact on the completed trip
- Accessible from the trip detail screen anytime (dedicated "Time Capsule" section or button)
- First viewing is the "reveal" moment (simultaneous push notification)
- All subsequent viewings are casual re-watches — no restrictions

**Edge Cases:**
- Montage not yet generated (still processing) → show "Your time capsule is being prepared..." with estimated time + push notification when ready
- Only 1 clip/photo submitted → montage is just that content with disposable camera filter + title card
- Network error during playback → retry button
- No Spotify playlist linked → use default ambient track (warm, nostalgic vibe)

---

### Screen 13.6 — Time Capsule Empty State

**Where:** Replaces Screen 13.5 when 0 video clips were submitted.

**Layout:**
- Same header as 13.5
- Illustration: empty disposable camera (or film roll with no photos)
- Text: "No moments were captured this trip"
- Subtitle: "Next trip, add blind moments to the time capsule on the Vibe tab!"
- Button: "Got it" → closes flow

---

### Screen 13.7 — Re-engagement Banner (Home Screen)

**Where:** Overlaid on the trip card in the "Past" trips section on home screen.

**Trigger:** User dismissed Trip Complete sheet without selecting top 3.

**Layout:**
- Blinking/pulsing banner strip across the trip card
- Text: "Mark your top 3 favorites ⭐"
- Tap → opens Trip Complete bottom sheet (Screen 13.3) directly

**Push notification (parallel):**
- Title: "How was [Trip Name]?"
- Body: "Pick your 3 favorite moments from your trip to [Destination]"
- Deep link: `tripful://trip/{tripId}?action=post-trip-review`
- Timing: 24 hours after first dismissal, then 72 hours if still incomplete
- Max 2 push reminders, then just the banner persists

---

### Screen 13.8 — Group Favorites View

**Where:** Accessible from the completed trip detail screen, after participants have submitted their top 3.

**Trigger:** Appears once 2+ participants have submitted favorites (show progress before that).

**Layout:**
- Header: "Group Favorites" with trip name
- Subtitle: "What your group loved most"
- Progress bar: "4 of 6 people voted" (if not everyone has submitted yet)
- **Ranked activity list** (sorted by vote count, descending):
  - Each row: activity photo (thumbnail) + name + category badge + vote count
  - Vote count shown as: "4 of 6 loved this" with filled heart icons
  - Gold/silver/bronze badges for top 3
  - Activities not picked by anyone are hidden
- If < 2 people have voted: "Waiting for more votes..." state with nudge to share
- Bottom: "Share Group Favorites" button → generates shareable card image (trip name, top 3 activities with photos, "Our [Destination] favorites" heading)

**Data:**
- Aggregated from `trip_favorite_activities` table
- Query: count per activity_id grouped across all users for this trip
- Ranked by count desc, then by earliest submission as tiebreaker

### Screen 13.9 — Completed Trip Detail (Persistent State)

**Where:** Trip detail screen for any trip where `endDate < today`.

**Changes to existing trip detail:**
- **Time Capsule section** at top of trip (above tabs or as a banner):
  - If montage exists: thumbnail + "Watch Time Capsule" button + "Share" icon
  - If no montage: hidden
- **Group Favorites** card/section:
  - Shows top 3 activities as a horizontal scroll of photo cards with vote badges
  - "See all" link → Screen 13.8
- Trip tabs remain functional (read-only feel but not locked — users might still settle expenses)
- Trip card on home screen shows "Completed" badge + time capsule thumbnail if available

---

## 3. Education Touchpoints

| When | What | Where |
|------|------|-------|
| User joins a trip | "This trip has a Time Capsule! Add blind video moments during your trip." | In-app notification / welcome card |
| Day 1 of trip | "Your trip to [Destination] starts today! Capture a moment for the time capsule." | Push notification |
| 3 days before trip ends | "[N] moments captured so far. Add yours before the trip ends!" | Push notification |
| 1 day before trip ends | "Last chance! The time capsule closes tomorrow." | Push notification + in-app badge on Vibe tab |
| Trip ends, <3 clips total | "Only [N] moments were captured. Next trip, add more!" | Inline message in reveal flow |

---

## 4. Data Model

### New Table: `trip_time_capsule_clips`

```sql
CREATE TABLE trip_time_capsule_clips (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  trip_id UUID NOT NULL REFERENCES trips(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  media_type TEXT NOT NULL CHECK (media_type IN ('photo', 'video')),
  storage_path TEXT NOT NULL,          -- Supabase Storage path
  duration_ms INTEGER,                 -- video duration (max 6000), NULL for photos
  created_at TIMESTAMPTZ DEFAULT now(),
  deleted_at TIMESTAMPTZ              -- soft delete (user can "delete" but we keep for audit)
);

-- RLS: users can INSERT their own, DELETE (soft) their own, never SELECT (blind mechanic)
ALTER TABLE trip_time_capsule_clips ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can submit clips to their trips"
  ON trip_time_capsule_clips FOR INSERT
  WITH CHECK (
    auth.uid() = user_id
    AND trip_id IN (SELECT trip_id FROM trip_participants WHERE user_id = auth.uid())
  );

CREATE POLICY "Users can soft-delete their own clips"
  ON trip_time_capsule_clips FOR UPDATE
  USING (auth.uid() = user_id AND deleted_at IS NULL)
  WITH CHECK (deleted_at IS NOT NULL);

-- NO SELECT policy for regular users. Only service role can read (for montage generation).
-- Count-only RPC for the UI:
CREATE FUNCTION get_capsule_clip_count(p_trip_id UUID)
RETURNS JSON AS $$
  SELECT json_build_object(
    'total', COUNT(*) FILTER (WHERE deleted_at IS NULL),
    'mine', COUNT(*) FILTER (WHERE deleted_at IS NULL AND user_id = auth.uid())
  )
  FROM trip_time_capsule_clips
  WHERE trip_id = p_trip_id;
$$ LANGUAGE sql SECURITY INVOKER;
```

### New Table: `trip_time_capsule_montages`

```sql
CREATE TABLE trip_time_capsule_montages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  trip_id UUID NOT NULL REFERENCES trips(id) ON DELETE CASCADE,
  storage_path TEXT,                   -- final montage video path (null while processing)
  status TEXT NOT NULL DEFAULT 'pending', -- pending | processing | ready | failed
  clip_count INTEGER NOT NULL DEFAULT 0,
  duration_ms INTEGER,                 -- final montage length
  generated_at TIMESTAMPTZ,
  error_message TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- RLS: read-only for trip participants, only when status = 'ready'
```

### New Table: `trip_favorite_activities`

```sql
CREATE TABLE trip_favorite_activities (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  trip_id UUID NOT NULL REFERENCES trips(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  activity_id UUID NOT NULL REFERENCES trip_activities(id) ON DELETE CASCADE,
  rank INTEGER NOT NULL CHECK (rank BETWEEN 1 AND 3),
  created_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE (trip_id, user_id, rank),
  UNIQUE (trip_id, user_id, activity_id)
);

-- RLS: users can insert/read their own, read others in same trip (for algorithm aggregation)
ALTER TABLE trip_favorite_activities ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can submit favorites for their trips"
  ON trip_favorite_activities FOR INSERT
  WITH CHECK (
    auth.uid() = user_id
    AND trip_id IN (SELECT trip_id FROM trip_participants WHERE user_id = auth.uid())
  );

CREATE POLICY "Users can read favorites in their trips"
  ON trip_favorite_activities FOR SELECT
  USING (
    trip_id IN (SELECT trip_id FROM trip_participants WHERE user_id = auth.uid())
  );
```

### New Table: `trip_post_review_status`

```sql
CREATE TABLE trip_post_review_status (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  trip_id UUID NOT NULL REFERENCES trips(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  favorites_completed BOOLEAN DEFAULT FALSE,
  capsule_viewed BOOLEAN DEFAULT FALSE,
  capsule_viewed_at TIMESTAMPTZ,
  last_nudge_sent_at TIMESTAMPTZ,
  nudge_count INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE (trip_id, user_id)
);
```

---

## 5. API Contracts

### Submit Clip

```
POST /rest/v1/trip_time_capsule_clips
Body: { trip_id, user_id, storage_path, duration_ms }
Auth: Bearer token (trip participant)
```

Storage upload happens first via Supabase Storage (`time-capsules/{trip_id}/{user_id}/{timestamp}.mp4`), then row is inserted.

### Delete Clip (Soft)

```
PATCH /rest/v1/trip_time_capsule_clips?id=eq.{id}&user_id=eq.{uid}
Body: { deleted_at: "now()" }
```

### Get Clip Count (RPC)

```
POST /rest/v1/rpc/get_capsule_clip_count
Body: { p_trip_id: "..." }
Returns: { total: 4, mine: 2 }
```

### Submit Favorites

```
POST /rest/v1/trip_favorite_activities
Body: [
  { trip_id, user_id, activity_id, rank: 1 },
  { trip_id, user_id, activity_id, rank: 2 },
  { trip_id, user_id, activity_id, rank: 3 }
]
```

Atomic: all 3 or none (use RPC wrapper for transactional insert).

### Get Montage Status

```
GET /rest/v1/trip_time_capsule_montages?trip_id=eq.{id}
Returns: { status, storage_path, duration_ms, clip_count }
```

### Trigger Montage Generation (Edge Function)

```
POST /functions/v1/generate-montage
Body: { trip_id }
Auth: Service role only (triggered by cron or trip-end webhook)
```

---

## 6. Notification Types (New)

Add to existing `NotificationPreferences`:

```typescript
timeCapsuleReminder: boolean   // mid-trip capture nudges
postTripReview: boolean        // top 3 favorites reminders
```

New notification types:

| Type | Trigger | Channel |
|------|---------|---------|
| `capsule_reminder` | 3 days before trip ends | `trips` |
| `capsule_last_chance` | 1 day before trip ends | `trips` |
| `trip_complete` | Day after trip ends | `trips` |
| `favorites_reminder` | 24h after dismissal | `trips` |
| `capsule_ready` | Montage generation complete | `default` (MAX) |
| `capsule_reveal` | Simultaneous group reveal | `default` (MAX) |

---

## 7. Montage Generation Pipeline

**Trigger:** Cron job checks daily for trips where `endDate = yesterday` and `montage.status = null`.

**Steps:**
1. Fetch all non-deleted clips (photos + videos) from `trip_time_capsule_clips` for the trip
2. Download media files from Supabase Storage
3. Apply disposable camera filter to all media (FFmpeg: grain overlay, warm color grade, vignette, date stamp)
4. Convert photos to 2-3 second video stills (Ken Burns-style slow zoom/pan)
5. Intelligent cut: arrange clips chronologically by `created_at`, trim to fit 60 seconds (if total > 60s, select best variety; if < 60s, use all with transitions)
6. **Add music track:** fetch trip's Spotify playlist link from Vibe tab → extract a 60-sec clip of a popular track. If no playlist: use default ambient track (warm, nostalgic)
7. Add title card: "[Trip Name] — [Destination] — [Date Range]"
8. Add closing card: "A Tryps Time Capsule" + subtle Tryps watermark
9. Encode final video (H.264, 1080p, 30fps, AAC audio)
10. Upload to Supabase Storage (`montages/{trip_id}/montage.mp4`)
11. Update `trip_time_capsule_montages` status → `ready`
12. Send simultaneous `capsule_reveal` push to all participants

**Tooling (open-source):**
- FFmpeg for video processing, filters, concatenation
- Possible: Remotion (React-based video) for title cards and transitions
- Future: open-source AI models for intelligent clip selection/ordering

**Fallback if generation fails:**
- Retry 3 times with exponential backoff
- If still fails: set status = `failed`, show Screen 13.6 variant ("We couldn't create your time capsule. We'll try again soon.")

---

## 8. Edge Cases

| Case | Handling |
|------|----------|
| Trip has 0 activities | Skip top 3 section entirely, show "No activities to rate" |
| Trip has 1-2 activities | Show all, require selecting all ("Pick your favorite") |
| Trip has 0 video clips | Skip time capsule, show empty state (Screen 13.6) |
| Trip has 1 clip | Generate montage from single clip + filter + title cards |
| User force-quits during montage | No issue — montage is always re-watchable |
| Network drops during playback | Pause + retry button |
| Montage still processing when user opens | "Your time capsule is being prepared..." + push when ready |
| User never opens app post-trip | Push notifications at +1 day, +4 days (max 2), then stop |
| Trip has no end date set | Post-trip flow never triggers (require end date) |
| Trip end date changed after clips submitted | Clips persist, generation trigger uses latest end date |
| User leaves trip before it ends | Their clips remain in the capsule, they don't get the reveal |
| User joins trip after it ends | No post-trip flow (they weren't part of the experience) |
| Spotify playlist has no tracks / is private | Fall back to default ambient track |
| Photo-only capsule (0 videos) | Montage is a slideshow of photos with music + transitions |
| Mixed media (photos + videos) | Interleave chronologically, photos as 2-3s stills |
| Share on platform without video support | Share as link to in-app player instead |

---

## 9. Existing Code Touchpoints

| File | Change |
|------|--------|
| `components/VibeTab.tsx` | Add Time Capsule section at top |
| `hooks/usePostTripPrompt.ts` | Extend to trigger Trip Complete flow (currently only does "add besties") |
| `app/trip/[id].tsx` | Present Trip Complete bottom sheet on mount if post-trip |
| `utils/notifications.ts` | Add new notification types + helpers |
| `types/index.ts` | Add `TripTimeCapsuleClip`, `TripMontage`, `TripFavoriteActivity`, `TripPostReviewStatus` types |
| `app/(tabs)/index.tsx` | Add blinking re-engagement banner on past trip cards |
| `components/TripHeader.tsx` | Badge on Vibe tab during active trip showing capsule clip count |

---

## 10. Out of Scope (Deferred)

- Anniversary "On This Day" push notifications (annual re-engagement layer — add later)
- AI-powered "best moment" selection for montage (v1 uses chronological ordering)
- Collaborative montage editing (letting the group reorder/trim clips)
- Montage templates/themes beyond disposable camera aesthetic
- Apple Music integration (Spotify only for v1)
