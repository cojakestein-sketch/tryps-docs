---
id: output-backed-screen
needs_figma: true
designer: unassigned
design_status: not-started
copy_doc_needed: false
screens:
  - trip-overview-app
  - trip-overview-infographic
  - draggable-itinerary
  - milestone-visualization
  - celebration-moment
  - empty-states
last_updated: 2026-03-22
---

# Output-Backed Screen — Design Needs

This scope is heavily design-driven. The output-backed screen is the most visual deliverable in Tryps — it's the thing users look at to understand their entire trip. Design quality here directly impacts whether this feels like a premium travel experience or a todo app.

---

## Screens to Design (Priority Order)

### 1. Trip Overview — App (BLOCKS ALL DEV WORK)

**What:** The single screen that shows everything about a trip. This is the core deliverable.

**Must include:**
- Trip header (name, dates, destination, participant avatars)
- Completeness indicator (progress bar, checklist, or combo — see below)
- Section summaries for each applicable planning domain:
  - Flights (airline, times, arrival/departure)
  - Stay (property name, dates, address)
  - Activities (list with dates/times)
  - Transport (rental car, transfers)
  - Reservations (restaurants, tickets)
  - Day-by-day itinerary (the drag zone)
- Empty state treatment for unfilled sections
- "Needs attention" flag treatment

**States to design:**
1. **Nearly empty** — Just created, only name + dates. Mostly empty sections with prompts.
2. **In progress** — ~50% complete. Mix of filled and empty sections. This is the most common state.
3. **Almost done** — ~90% complete. Most sections filled, 1-2 remaining.
4. **Trip ready** — 100% complete. All sections filled. Celebration treatment.
5. **Past trip** — Frozen/read-only. Memory state. Muted visual treatment.

**Design questions:**
- How do sections collapse/expand? Always visible, or accordion-style?
- How much detail per section on the overview vs. tapping to expand?
- How does the overview handle multi-city trips (Barcelona → Ibiza)?
- Where does the completeness indicator live — top of screen, floating, inline with sections?

**Constraints from brand docs:**
- Background: white/light gray (gray/50), NOT warm cream (per Jake's Figma override of brand.md)
- Font: Plus Jakarta Sans for all text, Space Mono for numbers/dates/prices
- Colors: Tryps Red (#D9071C) for primary actions, Tropical Green (#2D6B4F) for completed states, Sunset Gold (#E8913A) for "needs attention" flags
- Border radius: 14px for cards
- Shadows: very subtle, max 0.1 opacity
- Dark mode: warm dark (#1E1B19), not pure black

**Blocks:** SC-1 through SC-5 (overview structure), SC-6 through SC-8 (inline editing), SC-39 (empty states)

---

### 2. Draggable Itinerary (BLOCKS INTERACTION DEV)

**What:** The day-by-day itinerary section with drag-and-drop reordering. This is the part users physically interact with.

**Must include:**
- Day headers (Monday March 15, Tuesday March 16, etc.)
- Activity cards within each day (name, time, location, type icon)
- Drag handle / affordance (how does the user know they can drag?)
- Visual feedback during drag: lifted card, drop target highlight, invalid zone indication
- Multi-city transition indicator (if applicable)

**States to design:**
1. **Resting** — Normal itinerary view, activities in order
2. **Dragging** — Card lifted, shadow, drop targets highlighted
3. **Dropping** — Card settling into new position
4. **Empty day** — A day with no activities yet ("add something to Monday")

**Design questions:**
- Is the drag handle explicit (grip icon) or implicit (long-press anywhere on the card)?
- How does the drop target between days look? Especially when moving an activity from a full day to an empty day.
- How compact can activity cards be while remaining informative? (Trip with 20+ activities needs to fit)

**Constraints:**
- Activity cards need to show: name, time, type icon at minimum. Location if space allows.
- Must work on phones as small as iPhone SE (375px wide)
- Drag interaction must feel like iOS native (spring animation, haptic feedback)

**Blocks:** SC-9 through SC-13 (drag-and-drop)

---

### 3. iMessage Infographic (BLOCKS iMESSAGE DELIVERY)

**What:** A dynamically generated image that the agent sends in iMessage showing the trip overview. This is what non-app users see.

**Must include:**
- Trip name, dates, destination
- Participant count or avatar row
- Completeness indicator
- Section status indicators (completed/in-progress/empty for each applicable section)
- Key details for completed sections (flight times, stay name, activity highlights)
- Tryps branding (subtle — logo or wordmark)

**States to design:**
1. **Nearly empty** — New trip, mostly empty
2. **In progress** — Mix of filled and empty
3. **Trip ready** — Everything complete, celebratory treatment
4. **Daily check-in variant** — Sent with the agent's daily message, may highlight "what's needed next"

**Constraints:**
- Must be legible at iMessage image size (no zoom required)
- No text smaller than 11px equivalent
- Must look good on both light and dark iMessage backgrounds
- Image dimensions: optimize for iMessage preview (likely 2:3 or 3:4 aspect ratio)
- Must render server-side (generated as a PNG/JPEG, not a live view)
- Brand tokens apply: Plus Jakarta Sans, Tryps Red, warm palette
- For trips with 20+ activities, summarize ("12 activities planned") rather than listing all

**Design questions:**
- Does the infographic look like a miniature version of the app overview, or is it its own visual language?
- How much detail is useful vs. overwhelming in the iMessage context?
- Should there be a "tap to open in app" call-to-action on the image itself?

**Blocks:** SC-20 through SC-30 (infographic generation and delivery)

---

### 4. Milestone/Completeness Visualization (BLOCKS PROGRESS DISPLAY)

**What:** The visual representation of trip completeness. This appears on the app overview AND in the infographic. Could be a progress bar, a checklist, a ring, or a combination.

**Must include:**
- Overall completeness percentage/state
- Individual milestone states (incomplete, complete, needs attention)
- Visual distinction between the three states that works at a glance
- "Needs attention" flag that's distinct from "incomplete" (yellow/amber, not just gray)

**Options to explore:**
- **Progress bar:** Simple, familiar. Shows overall % but not individual milestones.
- **Checklist:** Shows each milestone by name with checkmark/empty/flag. More informative but takes more space.
- **Ring/circle:** Compact, works in both app and infographic.
- **Combination:** Ring for overall + expandable checklist for detail.

**Design questions:**
- Does the user need to see individual milestone names, or just overall progress?
- How does this look with 4 milestones (simple trip) vs. 12 milestones (complex trip)?
- Where does this live on the overview screen — top, side rail, floating?

**Blocks:** SC-3 (progress visualization), SC-14 through SC-18 (adaptive system), SC-22 (infographic progress)

---

### 5. Celebration Moment (NICE TO HAVE FOR V1)

**What:** The confetti / celebration animation when a trip hits 100% completeness. Happens in both app and iMessage.

**Must include:**
- App: Full-screen confetti or equivalent animation
- iMessage: Agent sends a celebratory message + the "complete" version of the infographic
- The animation should feel warm, satisfying, and on-brand (not corporate, not childish)

**References:**
- Partiful's RSVP confirmation animation (warm, celebratory)
- Duolingo's streak celebration (satisfying, motivating)
- Venmo's payment confirmation (brief, delightful)

**Constraints:**
- Animation: 1-2 seconds max, doesn't block interaction
- Uses brand colors (Tryps Red, warm palette)
- Fires once per trip (not on every subsequent visit)

**Blocks:** SC-31 through SC-33 (celebration)

---

### 6. Empty State Treatments (PART OF OVERVIEW DESIGN)

**What:** What each section looks like when it has no data yet. These empty states ARE the "to-do list" that tells the group what's left.

**Must include per section:**
- Flights empty: "add flights" or similar prompt
- Stay empty: "pick a stay" prompt
- Activities empty: "add activities" or "want suggestions?"
- Itinerary empty: "lock in dates to build the itinerary"
- General empty state for the overview when nearly everything is unfilled

**Design questions:**
- Illustrated placeholders (small icons/illustrations) or text-only?
- Do empty sections have a tap target that starts the relevant flow?
- How do empty sections look in the infographic version?

**Blocks:** SC-2 (section states), SC-27 (empty infographic), SC-39 (empty overview)

---

## What Blocks Dev Work (Summary)

| Design Deliverable | Blocks | Priority |
|---|---|---|
| Trip Overview — App | All app development (SC-1 through SC-8, SC-39) | **Immediate** |
| Draggable Itinerary | Drag-and-drop development (SC-9 through SC-13) | **Immediate** |
| iMessage Infographic | All iMessage delivery (SC-20 through SC-30) | **High** |
| Milestone Visualization | Progress display (SC-3, SC-14 through SC-18, SC-22) | **High** |
| Celebration Moment | Celebration feature (SC-31 through SC-33) | **Can follow** |
| Empty States | Part of overview design | **Part of #1** |

**For the design handoff tomorrow:** Screens 1 and 2 (Trip Overview + Draggable Itinerary) are the critical blockers. If the designer can start there, dev can begin building the data layer and infrastructure in parallel. Screen 3 (Infographic) should follow immediately after because it's the iMessage deliverable.

---

## Reference

- Jake's sketch: `sketch-card-stack.png` (early thinking — final form is an overview, not a card stack)
- Completeness levels: `completeness-levels.md` (full milestone system)
- Brand tokens: `~/tryps-docs/shared/brand.md`
- Existing trip card: scope 2 (Core Trip Experience) — this overview extends it
- iMessage Agent voice guide: `scopes - refined 3-20/imessage-agent/voice-guide.md` (for celebration message tone)
