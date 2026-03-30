---
id: post-trip-retention
title: "Post-Trip & Retention"
status: specced
assignee: nadeem
wave: 3
dependencies: [core-trip-experience]
clickup_ids: ["86e0emu4g"]
criteria_count: 31
criteria_done: 0
last_updated: 2026-03-30
links:
  objective: ./objective.md
  state: ./state.md
---

> Parent: [[post-trip-retention/objective|Post-Trip & Retention Objective]]

# Post-Trip & Retention — Spec

## What

The post-trip experience that brings groups back to Tryps. When a trip ends: pick top 3 favorite activities (feeds recommendation algorithm), watch the group time capsule reveal (AI-cut montage from blind video clips), and see group favorites aggregation.

## Why

Post-trip is the retention loop. Top 3 favorites feed the recommendation engine. Time capsule creates shareable content that drives word-of-mouth. The montage is permanently re-watchable, creating a re-engagement loop.

## Intent

> "The montage is the 'holy shit' moment after the trip. You submitted blind clips during the trip, and then you all watch the AI-cut montage together. It's digital disposable camera energy."

## Key Concepts

- **Trip Complete Trigger:** automatic activation day after trip end date
- **Top 3 Favorites:** each person picks their 3 favorite activities — priority #1 data collection
- **Time Capsule:** blind 6-second video clip + photo submission during trip
- **Montage:** AI-stitched 60-second video with disposable camera aesthetic
- **Simultaneous Reveal:** all group members notified at same time
- **Group Favorites:** aggregated ranking of activities by vote count

---

## Success Criteria

### Trip Complete Trigger

- [ ] **SC-1.** Trip Complete bottom sheet appears automatically for each member after trip end date. Verified by: trip end date passes → member opens app → bottom sheet overlay appears on the trip detail screen.
- [ ] **SC-2.** Trip stats bar shows accurate Days, People, Places, Spent totals. Verified by: trip with 5 days, 4 people, 3 places, $1200 spent → bottom sheet shows "5 Days · 4 People · 3 Places · $1,200 Spent".
- [ ] **SC-3.** Post-trip flow works independently of expense settlement status. Verified by: trip with unsettled expenses ends → bottom sheet still appears → top 3 and time capsule flows are not blocked.

### Top 3 Favorite Activities

- [ ] **SC-4.** Each user can select exactly 3 favorite activities from the trip's activity list. Verified by: trip with 6 activities → user taps 3 activity cards → counter shows 3/3 → submit button enables.
- [ ] **SC-5.** Activity selection persists per-user and feeds into the recommendation data store. Verified by: Alice picks activities A, B, C → Bob picks B, D, E → each user's selections are stored independently → recommendation data updated.
- [ ] **SC-6.** Dismissed users see a persistent blinking banner on the past trip card prompting them to complete top 3. Verified by: user dismisses bottom sheet without selecting → trip card on home screen shows blinking "Mark your top 3 favorites" banner.
- [ ] **SC-7.** Dismissed users receive a push notification reminding them to complete top 3. Verified by: user dismisses bottom sheet → push notification arrives within 24 hours → tapping it opens the top 3 selection screen.
- [ ] **SC-8.** Banner disappears only after top 3 is submitted. Verified by: user submits 3 favorites → navigate to home → trip card no longer shows the blinking banner.

### Time Capsule — Capture Phase

- [ ] **SC-9.** During active trips, users can record and submit 6-second video clips to the time capsule. Verified by: active trip → open Vibe tab → tap capture → record 6-second clip → submit → confirmation shown.
- [ ] **SC-10.** Submitted clips are blind — not viewable by sender or any group member. Verified by: Alice submits a clip → Alice navigates time capsule section → no playback option for any clip → Bob checks → same result.
- [ ] **SC-11.** Users can delete their own submitted clip. Verified by: user submits clip → sees "You submitted 1 clip" with delete option → taps delete → confirmation → clip count decrements.
- [ ] **SC-12.** Clip capture UI exists on the Vibe tab with clear affordance. Verified by: open trip during active dates → navigate to Vibe tab → capture button/section is visible without scrolling.
- [ ] **SC-13.** Time capsule accepts both photos and 6-second video clips. Verified by: user submits a photo → user submits a video → both count toward time capsule total.

### Time Capsule — Education & Nudges

- [ ] **SC-14.** When joining a trip, user sees a message about the time capsule. Verified by: new member joins trip → notification or onboarding message includes "This trip has a time capsule — add moments!"
- [ ] **SC-15.** Mid-trip nudge reminds users to add clips. Verified by: 3 days before trip end → push notification: "3 days left — add a moment to the time capsule. Send a push notification on the very last day fo the trip to remind members to add their memories."
- [ ] **SC-16.** Low-participation feedback shown post-trip. Verified by: trip with only 1 clip submitted by group → post-trip screen shows "Submit more videos next time!"

### Time Capsule — Reveal Phase

- [ ] **SC-17.** AI generates a 60-second montage from all submitted clips and photos. Verified by: trip ends with 8 clips + 4 photos → montage generated → duration is 60 seconds or less → photos appear as 2-3 second stills with disposable camera filter.
- [ ] **SC-18.** Simultaneous push notification triggers montage reveal for all group members. Verified by: montage ready → all 4 trip members receive push notification at the same time → tapping opens montage player.
- [ ] **SC-19.** Disposable camera visual aesthetic applied to all montage content. Verified by: watch montage → video clips and photos show grain, warm tones, and slight imperfection.
- [ ] **SC-20.** Montage includes music from trip's Spotify playlist (if linked) or default ambient track. Verified by: trip with linked Spotify playlist → montage plays with playlist track. Trip without playlist → montage plays with ambient default.

### Montage Playback & Sharing

- [ ] **SC-21.** Montage is permanently re-watchable and downloadable from the completed trip detail screen. Verified by: after initial reveal → navigate to completed trip → montage player is accessible → plays the full montage.
- [ ] **SC-22.** Share button on montage player opens native share sheet with the video file. Verified by: open montage player → tap Share → iOS share sheet appears with video file → shareable to iMessage, Instagram Stories, TikTok.

### Group Top 3 Aggregation

- [ ] **SC-23.** Group Top 3 aggregation view shows ranked activities by vote count. Verified by: 4 of 6 members submit top 3 → Group Favorites view shows activities ranked by number of picks → "4 of 6 people loved this" label on top activity.
- [ ] **SC-24.** Group Favorites visible to all trip members after submissions. Verified by: majority submits → any member opens the completed trip → Group Favorites section is visible.

### Home Screen

- [ ] **SC-25.** Trip card on home screen reflects "completed" state with re-engagement prompts. Verified by: trip ends → home screen trip card shows completed visual state → if top 3 not submitted, shows blinking prompt.

### Should NOT Happen

- [ ] **SC-26.** Non-trip members cannot access or submit to the time capsule. Verified by: user not in the trip → no capture UI visible → API rejects clip submission.
- [ ] **SC-27.** Users cannot view submitted clips before the reveal — no preview, no gallery, no thumbnails. Verified by: during active trip → no UI path shows any submitted clip content.

### Edge Cases

- [ ] **SC-28.** Trip with fewer than 3 activities allows user to pick all available. Verified by: trip with 2 activities → user picks both → submit enables at 2/2 instead of requiring 3.
- [ ] **SC-29.** Trip with 0 time capsule submissions handles post-trip gracefully. Verified by: trip ends with no clips → no montage generated → post-trip flow skips reveal and shows top 3 only.
- [ ] **SC-30.** Montage generation handles async processing. Verified by: trip ends → user sees "Your time capsule is being created" loading state → montage appears when ready (minutes, not instant).

- [ ] **SC-31.** Typecheck passes.

### Out of Scope

- Rewards program (Tryps Miles) — post-launch
- Photo gallery outside of time capsule — post-launch
- Anniversary notifications — post-launch

### Regression Risk

| Area | Why | Risk |
|------|-----|------|
| Trip detail screen | Bottom sheet overlay on existing trip view | Medium |
| Home screen | Trip card completed state changes | Low |
| Push notifications | New notification types for reveal and reminders | Medium |
| Video storage | 6-second clips need storage infrastructure | High |
| AI montage | Open-source video editing pipeline | High |

---

## Kickoff Prompt

**Scope:** Post-Trip & Retention
**Spec:** `scopes/post-trip-retention/spec.md` (31 SC)
**What:** Post-trip flow with three parts: (1) Top 3 favorites selection (SC-1 to SC-8) — priority #1 data for recommendations. (2) Time capsule capture + reveal (SC-9 to SC-20) — blind clip submission, AI montage, simultaneous reveal. (3) Group aggregation + sharing (SC-21 to SC-25). Start with the trip complete trigger and top 3 selection. Time capsule is the most complex subsystem — scope video storage and AI tooling early.
