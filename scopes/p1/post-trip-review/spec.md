# Scope 4: Post-Trip Review — Spec

> **Status:** Ready
> **Phase:** P1: Core App
> **Gantt ID:** `p1-post-trip-review`
> **Date:** 2026-03-15

## Intent

The post-trip experience that brings groups back to Tryps. When a trip ends, users complete two things: pick their top 3 favorite activities (critical data for the recommendation algorithm) and watch the group reveal of their "time capsule" — a 60-second AI-cut montage from blind video clips submitted during the trip. The montage is permanently re-watchable from the completed trip, creating a re-engagement loop that drives word-of-mouth and repeat trip creation.

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
- After the initial reveal, the montage is permanently re-watchable from the completed trip
- No minimum submission threshold — make the best montage possible from whatever was submitted

### 4. Montage Playback & Sharing

- After the reveal, the montage is **always re-watchable and Downloadable** from the completed trip
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

## Success Criteria

### Trip Complete Trigger

- [ ] `P1.S4.C01` — Trip Complete bottom sheet appears automatically for each member after trip end date. Verified by: trip end date passes → member opens app → bottom sheet overlay appears on the trip detail screen.
- [ ] `P1.S4.C02` — Trip stats bar shows accurate Days, People, Places, Spent totals. Verified by: trip with 5 days, 4 people, 3 places, $1200 spent → bottom sheet shows "5 Days · 4 People · 3 Places · $1,200 Spent".
- [ ] `P1.S4.C03` — Post-trip flow works independently of expense settlement status. Verified by: trip with unsettled expenses ends → bottom sheet still appears → top 3 and time capsule flows are not blocked.

### Top 3 Favorite Activities

- [ ] `P1.S4.C04` — Each user can select exactly 3 favorite activities from the trip's activity list. Verified by: trip with 6 activities → user taps 3 activity cards → counter shows 3/3 → submit button enables.
- [ ] `P1.S4.C05` — Activity selection persists per-user and feeds into the recommendation data store. Verified by: Alice picks activities A, B, C → Bob picks B, D, E → each user's selections are stored independently → recommendation data updated.
- [ ] `P1.S4.C06` — Dismissed users see a persistent blinking banner on the past trip card prompting them to complete top 3. Verified by: user dismisses bottom sheet without selecting → trip card on home screen shows blinking "Mark your top 3 favorites" banner.
- [ ] `P1.S4.C07` — Dismissed users receive a push notification reminding them to complete top 3. Verified by: user dismisses bottom sheet → push notification arrives within 24 hours → tapping it opens the top 3 selection screen.
- [ ] `P1.S4.C08` — Banner disappears only after top 3 is submitted. Verified by: user submits 3 favorites → navigate to home → trip card no longer shows the blinking banner.

### Time Capsule — Capture Phase (During Trip)

- [ ] `P1.S4.C09` — During active trips, users can record and submit 6-second video clips to the time capsule. Verified by: active trip → open Vibe tab → tap capture → record 6-second clip → submit → confirmation shown.
- [ ] `P1.S4.C10` — Submitted clips are blind — not viewable by sender or any group member. Verified by: Alice submits a clip → Alice navigates time capsule section → no playback option for any clip → Bob checks → same result.
- [ ] `P1.S4.C11` — Users can delete their own submitted clip. Verified by: user submits clip → sees "You submitted 1 clip" with delete option → taps delete → confirmation → clip count decrements.
- [ ] `P1.S4.C12` — Clip capture UI exists on the Vibe tab with clear affordance. Verified by: open trip during active dates → navigate to Vibe tab → capture button/section is visible without scrolling.
- [ ] `P1.S4.C13` — Time capsule accepts both photos and 6-second video clips. Verified by: user submits a photo → user submits a video → both count toward time capsule total.

### Time Capsule — Education & Nudges

- [ ] `P1.S4.C14` — When joining a trip, user sees a message about the time capsule. Verified by: new member joins trip → notification or onboarding message includes "This trip has a time capsule — add moments!"
- [ ] `P1.S4.C15` — Mid-trip nudge reminds users to add clips. Verified by: 3 days before trip end → push notification: "3 days left — add a moment to the time capsule. Send a push notification on the very last day fo the trip to remind members to add their memories."
- [ ] `P1.S4.C16` — Low-participation feedback shown post-trip. Verified by: trip with only 1 clip submitted by group → post-trip screen shows "Submit more videos next time!"

### Time Capsule — Reveal Phase (After Trip)

- [ ] `P1.S4.C17` — AI generates a 60-second montage from all submitted clips and photos. Verified by: trip ends with 8 clips + 4 photos → montage generated → duration is 60 seconds or less → photos appear as 2-3 second stills with disposable camera filter.
- [ ] `P1.S4.C18` — Simultaneous push notification triggers montage reveal for all group members. Verified by: montage ready → all 4 trip members receive push notification at the same time → tapping opens montage player.
- [ ] `P1.S4.C19` — Disposable camera visual aesthetic applied to all montage content. Verified by: watch montage → video clips and photos show grain, warm tones, and slight imperfection.
- [ ] `P1.S4.C20` — Montage includes music from trip's Spotify playlist (if linked) or default ambient track. Verified by: trip with linked Spotify playlist → montage plays with playlist track. Trip without playlist → montage plays with ambient default.

### Montage Playback & Sharing

- [ ] `P1.S4.C21` — Montage is permanently re-watchable and downloadable from the completed trip detail screen. Verified by: after initial reveal → navigate to completed trip → montage player is accessible → plays the full montage.
- [ ] `P1.S4.C22` — Share button on montage player opens native share sheet with the video file. Verified by: open montage player → tap Share → iOS share sheet appears with video file → shareable to iMessage, Instagram Stories, TikTok.

### Group Top 3 Aggregation

- [ ] `P1.S4.C23` — Group Top 3 aggregation view shows ranked activities by vote count. Verified by: 4 of 6 members submit top 3 → Group Favorites view shows activities ranked by number of picks → "4 of 6 people loved this" label on top activity.
- [ ] `P1.S4.C24` — Group Favorites visible to all trip members after submissions. Verified by: majority submits → any member opens the completed trip → Group Favorites section is visible.

### Home Screen

- [ ] `P1.S4.C25` — Trip card on home screen reflects "completed" state with re-engagement prompts. Verified by: trip ends → home screen trip card shows completed visual state → if top 3 not submitted, shows blinking prompt.

### Should NOT Happen

- [ ] `P1.S4.C26` — Non-trip members cannot access or submit to the time capsule. Verified by: user not in the trip → no capture UI visible → API rejects clip submission.
- [ ] `P1.S4.C27` — Users cannot view submitted clips before the reveal — no preview, no gallery, no thumbnails. Verified by: during active trip → no UI path shows any submitted clip content.

### Edge Cases

- [ ] `P1.S4.C28` — Trip with fewer than 3 activities allows user to pick all available. Verified by: trip with 2 activities → user picks both → submit enables at 2/2 instead of requiring 3.
- [ ] `P1.S4.C29` — Trip with 0 time capsule submissions handles post-trip gracefully. Verified by: trip ends with no clips → no montage generated → post-trip flow skips reveal and shows top 3 only.
- [ ] `P1.S4.C30` — Montage generation handles async processing. Verified by: trip ends → user sees "Your time capsule is being created" loading state → montage appears when ready (minutes, not instant).

- [ ] `P1.S4.C31` — Typecheck passes

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
