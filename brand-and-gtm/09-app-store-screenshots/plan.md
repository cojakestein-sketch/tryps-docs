# App Store Screenshots — Process Plan

> Owner: Jake + Sean
> Status: Phase 2 complete, Phase 3 next
> Goal: Best-in-class App Store presence — video + linked screenshots that tell the Tryps story
> Output: 1 app preview video (slot 1) + 5 linked screenshot assets (slots 2-6)
> Dimensions: 1320 x 2868 px (iPhone 6.9" — Apple auto-scales for smaller devices)

---

## Phase 1: Research — DONE

Full research doc: [research.md](research.md)

### Key findings:
- 90% of users never scroll past screenshot 3
- Screenshot #1 gets 10x more views — video auto-plays on mute in search results
- 30-40% conversion lift from optimizing slot 1 alone
- 3-5 words per headline, benefit over feature ("Plan your next trip" not "AI itinerary engine")
- Dark backgrounds feel premium, make bright UI pop
- Panoramic continuity (linked images) compels scrolling
- Lead with group trip outcome, NOT the AI agent
- One message per screenshot, no feature dumping

---

## Phase 2: Competitive Inspiration — DONE

### Approved references:

| App | Verdict | What to steal |
|-----|---------|---------------|
| **Partiful** | STEAL | Video in slot 1 — shows key functionality, clean and fast |
| **Flighty** | STEAL | Panoramic link between screenshots — images flow into each other |
| **Arc Search** | STEAL | Video in slot 1, smart move |
| **BeReal** | YES | Video in slot 1, confident we can do this |
| **Venmo** | YES | Crystal clear simplicity — tells you exactly what they do |
| **Copilot** | STEAL | Compelling video |
| **Wispr Flow** | STEAL | Linked/flowing images in search results view — continuous visual narrative across frames |

### Rejected:
Airbnb (meh), Hopper (hate), Splitwise (awful), TripIt (horrible), Wanderlog (ugly colors), Things 3 (no), Raycast (too dark), Linear (no), Notion (doesn't tell you what it does), Poke AI (no app found)

### Key decisions from review:
1. **Slot 1 = APP PREVIEW VIDEO** — not a screenshot
2. **Slots 2-4 = Panoramic linked images** that flow together (Wispr Flow / Flighty style)
3. **Search results view is critical** — how the first 3 frames look as thumbnails when someone types "trip planning" matters as much as the product page

---

## Phase 3: Strategy — The 6-slot plan

### Slot 1: App Preview Video (~6 seconds)

**Concept:** The full Tryps workflow, end to end, in one take.

Storyboard (draft):
1. iMessage group chat — someone drops a Tryps link
2. Tap the link — app opens
3. Trip dashboard appears — destination photo, friends' faces
4. Quick flash of itinerary / voting / coordination
5. Settle up — money handled
6. End frame: Tryps logo + tagline

**Specs:**
- Duration: 15-30 seconds (Apple requirement), but core story in first 5 seconds
- Auto-plays on mute in search results — 47% conversion lift from autoplay alone
- Must work without sound — use text callouts, not voiceover
- Poster frame must work as a standalone static screenshot (fallback when autoplay is off)
- Format: H.264 or ProRes 422, max 500MB
- **MUST be portrait orientation** — landscape pushes video below screenshots on product page

**Conversion data:**
- 20-40% conversion lift from well-made video (new-to-market social apps = higher end)
- Bad video = -30% conversion — quality bar is high
- 10% of viewers drop off every 5 seconds — front-load everything
- Consider 2 short 15-second previews (outperform 1 long 30-second in most A/B tests)
  - Video 1: The group flow (iMessage → link → Tryps → trip dashboard)
  - Video 2: The coordination magic (voting, itinerary, settle up)

**Who makes it:**
- Jake + Sean storyboard the flow together
- Designer provides the app mockup frames / real screenshots
- Sean does motion work — timing, transitions, pacing
- Could be screen recording with polish, or fully designed frames with animation

### Slots 2-4: Panoramic Linked Images

These three screenshots share a continuous background/visual element that flows across them. When viewed in search results, they look like one connected piece.

| Slot | Theme | Headline (draft) | What it shows |
|------|-------|-------------------|---------------|
| 2 | Group planning | TBD | Creating a trip, inviting friends — the "start" moment |
| 3 | Coordination | TBD | Voting, itinerary, decisions — the "middle" |
| 4 | AI magic | TBD | Agent handling logistics — the "effortless" part |

Visual treatment:
- Continuous warm dark background (#1E1B19) or Tryps Red gradient flowing across all 3
- Device frames at slight angles, positioned to create visual flow
- Plus Jakarta Sans Bold headlines, 3-5 words each
- Elements cut off at right edge of each frame to compel scrolling

### Slots 5-6: Standalone Screens

| Slot | Theme | Headline (draft) | What it shows |
|------|-------|-------------------|---------------|
| 5 | Money | TBD | Settle Up / expense splitting — trust and clarity |
| 6 | The payoff | TBD | The trip itself — friends together, the emotional close |

---

### Strategy decisions (resolved):

| Decision | Answer | Rationale |
|----------|--------|-----------|
| Slot 1 format | Video | Partiful, Arc, BeReal, Copilot all do it — auto-plays in search |
| Slots 2-4 style | Panoramic linked | Wispr Flow / Flighty style — flows in search results |
| Background | Warm dark or Tryps Red gradient | Research says dark = premium; brand says stay warm |
| Typography | Plus Jakarta Sans Bold | Brand consistency |
| Copy voice | Punchy benefit statements | Verb + Benefit, 3-5 words, group chat energy |
| Device frames | iPhone 16 Pro, slight angles | Current device signals active development |
| Data in screenshots | Real trip data | No placeholder content — real destinations, real friend avatars |

### Open questions for Phase 3 session (Jake + Sean):
- [ ] Final headline copy for each slot
- [ ] Which specific app screens to capture
- [ ] Video: screen recording vs designed frames vs hybrid?
- [ ] Video: music/sound design or purely visual?
- [ ] Background: warm dark vs Tryps Red gradient vs something else?
- [ ] How to handle the panoramic link visually — gradient? photo? pattern?

---

## Phase 4: Execution

### Video (Slot 1):
1. Jake + Sean storyboard the 6-second flow
2. Screen record real app flows with realistic data
3. Sean adds motion, transitions, timing
4. Export: H.264, 1320x2868, 15-30 seconds
5. Set poster frame (must work as static fallback)

### Screenshots (Slots 2-6):
1. Capture real app screens with realistic trip data
2. Design in Figma — panoramic layout for slots 2-4, standalone for 5-6
3. Use Figma Make for backgrounds / treatments if helpful
4. Export: 1320 x 2868 px PNG
5. Review how they look in search results view (thumbnail size)

### After launch:
- A/B test via Apple Product Page Optimization (PPO)
- Test video vs static in slot 1
- Test different headline copy
- Refresh quarterly with new features / seasonal themes

---

## Timeline

| Phase | Who | When |
|-------|-----|------|
| Phase 1: Research | Claude | DONE |
| Phase 2: Competitive review | Jake | DONE |
| Phase 3: Strategy session | Jake + Sean | This week |
| Phase 4: Video production | Sean + Designer | Next week |
| Phase 4: Screenshot design | Designer + Sean | Next week |
| Review + upload | Jake | Before launch |

---

## Files in this folder

- `plan.md` — this file (process plan + decisions)
- `research.md` — Phase 1 deep research (conversion data, best practices, tools)
