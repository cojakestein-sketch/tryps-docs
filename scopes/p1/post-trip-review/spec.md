# Scope 4: Post-Trip Review — Spec

> **Status:** Ready
> **Phase:** P1: Core App
> **Gantt ID:** `p1-post-trip-review`
> **Date:** 2026-03-15

## Intent

The post-trip experience that brings groups back to Tryps. When a trip ends, users complete two things: pick their top 3 favorite activities (critical data for the recommendation algorithm) and watch a one-time group reveal of their "time capsule" — a 60-second AI-cut montage from blind video clips submitted during the trip. The time capsule resurfaces annually as an "on this day" memory, creating a re-engagement loop that drives word-of-mouth and repeat trip creation.

## Key Areas

### 1. Trip Complete Trigger

- Activates automatically the day after the trip end date
- Bottom sheet overlay appears when any group member opens the trip
- Shows trip stats: Days, People, Places, Spent
- Independent of expense settlement — does not gate on unsettled balances

### 2. Top 3 Favorite Activities (Priority #1)

- Each person individually picks their top 3 activities from the trip
- Activity cards show photo + category badge (Culture, Food & Drink, Nightlife, etc.)
- Selection counter (1/3, 2/3, 3/3) with step indicator dots
- This is the single most important data collection in the post-trip flow — everything else serves getting users to complete this
- **Re-engagement if dismissed:**
  - Persistent blinking banner on the past trip card ("Mark your top 3 favorites")
  - Push notification reminding the user to complete it
  - Banner persists until top 3 is submitted
- Data feeds the Tryps recommendation algorithm (what people liked at which locations)

### 3. Time Capsule — "Digital Disposable Camera"

#### During the Trip (Capture Phase)
- Users record 6-second video clips and submit them to the trip's time capsule
- **Blind submission** — users cannot preview what they or anyone else submitted
- Users can delete their own clip but never view it after submission
- Capture UI lives on the Vibe tab (or another contextually appropriate location)
- Visual aesthetic: shot-on-a-disposable-camera look (grain, warm tones, slight imperfection)
- **Education/onboarding:**
  - When joining a trip: "This trip has a time capsule — add moments!"
  - Periodic nudges during the trip: "3 days left — add a moment to the time capsule"
  - Post-trip if low participation: "Submit more videos next time!"

#### After the Trip (Reveal Phase)
- AI stitches all submitted clips into a single 60-second montage
- Open-source AI video editing tools handle the cut (thesis: quality is good enough now)
- **Simultaneous group reveal** — push notification sent to all group members at the same time
- **One-time viewing** — each person gets exactly 1 chance to watch
- After viewing + closing, the montage is gone until the 1-year anniversary
- No minimum submission threshold — make the best montage possible from whatever was submitted

### 4. Montage Playback & Sharing

- After the reveal, the montage is **always re-watchable** from the completed trip
- Lives as a permanent artifact on the trip detail screen
- **Share to social media** — native share sheet with montage video file (Instagram Stories, TikTok, iMessage, etc.)
- **Montage music** — pulled from the trip's Spotify playlist (if linked on Vibe tab), otherwise ambient/default track

### 5. Group Top 3 Aggregation View

- After all (or most) participants submit their top 3, show a "Group Favorites" view
- Ranks activities by how many people picked them
- Shows vote count per activity ("4 of 6 people loved this")
- Feeds the recommendation algorithm AND gives the group a shareable "our favorites" summary

### 6. Photo + Video Time Capsule

- Time capsule accepts **both photos and 6-second video clips**
- Same blind mechanic — can't preview after submission
- Photos get the disposable camera filter treatment too (grain, warm tones, date stamp)
- Montage interleaves photos (as 2-3 second stills) with video clips

## Acceptance Criteria

- [ ] Trip Complete bottom sheet appears automatically for each member after trip end date
- [ ] Trip stats bar shows accurate Days, People, Places, Spent totals
- [ ] Each user can select exactly 3 favorite activities from the trip's activity list
- [ ] Activity selection persists per-user and feeds into the recommendation data store
- [ ] Dismissed users see a persistent blinking banner + receive push notification to complete top 3
- [ ] Banner disappears only after top 3 is submitted
- [ ] During active trips, users can record and submit 6-second video clips to the time capsule
- [ ] Submitted clips are blind — not viewable by sender or any group member
- [ ] Users can delete their own submitted clip
- [ ] Clip capture UI exists on the Vibe tab with clear affordance
- [ ] Education touchpoints: trip join notification, mid-trip nudges, low-participation feedback
- [ ] Post-trip: AI generates a 60-second montage from all submitted clips
- [ ] Simultaneous push notification triggers montage reveal for all group members
- [ ] Montage is permanently re-watchable from the completed trip detail screen
- [ ] Share button on montage player opens native share sheet (video file)
- [ ] Montage includes music from trip's Spotify playlist (if linked) or default ambient track
- [ ] Group Top 3 aggregation view shows ranked activities by vote count
- [ ] Group Favorites visible to all trip members after submissions
- [ ] Time capsule accepts both photos and 6-second video clips
- [ ] Photos displayed as 2-3 second stills in the montage with disposable camera filter
- [ ] Disposable camera visual aesthetic applied to all montage content
- [ ] Post-trip flow works independently of expense settlement status
- [ ] Trip card on home screen reflects "completed" state with re-engagement prompts

## Constraints

- 6-second max per video clip
- 60-second max montage output
- AI video editing must use open-source tooling (no expensive proprietary APIs)
- Video storage and processing costs need to be scoped before implementation
- The top 3 selection UI must work even if a trip had fewer than 3 activities (edge case: pick all)
- Push notification infrastructure required for simultaneous reveal and anniversary triggers
- Montage generation is async — may take minutes after trip ends, not instant

## Open Questions

- [ ] Exact placement of time capsule capture UI on Vibe tab — dedicated section or floating action?
- [ ] What AI/ML tooling for montage generation? (FFmpeg + open-source video editing models?)
- [ ] Video storage strategy — Supabase Storage? S3? CDN for playback?
- [ ] Should the montage have music? If so, from the trip's Vibe playlist?
- [ ] Max clips per person? Per trip? (prevents storage abuse)
- [ ] What if a trip has 0 video submissions — skip the time capsule entirely or show an empty state?
- [ ] Default ambient track for montages without a Spotify playlist — what vibe/genre?
- [ ] Photo aspect ratio handling — crop to 16:9 for montage, or letterbox?
