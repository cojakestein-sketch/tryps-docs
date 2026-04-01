---
title: "Path to the Plane — Deck Improvements & Calculator"
type: feat
date: 2026-04-01
---

# Path to the Plane — Deck Improvements & Calculator

## Overview

Improve the Path to the Plane HTML presentation (`presentations/path-to-the-plane-2026-04-01.html`) with clearer math, simplified visuals, validated assumptions, and an interactive calculator. Goal: Jake walks his dad through this deck and it's immediately clear.

## Current State

- 5-slide HTML deck with scroll-snap, Plus Jakarta Sans / Space Mono, Tryps brand CSS
- Slides: Title → Assumptions → Four Tiers → Sensitivity Table → Takeaways
- Supporting analysis: `pitch-deck-ideas/data/path-to-the-plane.md`
- Problem: Sensitivity table (slide 4) is too dense, math derivation isn't shown, take rate needs validation

## Tasks

### Task 1: Add "Show Your Work" Waterfall Slide

**Insert after slide 2 (Assumptions), before slide 3 (Four Tiers).**

Visual waterfall chart showing the $0.84/user derivation step-by-step:

```
100 users → 15 book (15%) → $7,500 GMV → $600 revenue (8%) → $120 profit (20%) → $84 to Jake (70%) → $0.84/user
```

Implementation:
- CSS waterfall bars with decreasing heights, connected by arrows/lines
- Each bar labeled with the step name, the multiplier applied, and the resulting number
- Use Space Mono for numbers, muted labels above each bar
- Color: start with a neutral, each step shades toward red, final bar is Tryps Red
- Below the waterfall: one sentence — "Every assumption above changes the height of these bars."
- Keep it to ONE visual — no tables, no paragraphs

**File:** `presentations/path-to-the-plane-2026-04-01.html` — new `<section class="slide" id="s2">` (renumber existing s2→s3, s3→s4, s4→s5)

### Task 2: Simplify Sensitivity Page

**Replace current slide 4 (the dense 4×4 table + bar chart) with a cleaner visual.**

New design: Base-case tier ladder with range bands.

- Vertical ladder/staircase layout — 4 tiers stacked
- Each tier shows: icon, name, base case user count (large mono), and a horizontal range bar showing bear↔bull spread
- Range bar is a thin line with dots at bear/base/bull positions, labeled
- Remove the struck-through "Original" column entirely — it's confusing without context
- Remove the revenue bar chart at the bottom (redundant with tier cards on previous slide)
- Add a single insight line: "The range is driven by two variables: paid conversion (8–25%) and take rate (5–12%)"

**File:** `presentations/path-to-the-plane-2026-04-01.html` — replace existing sensitivity slide content

### Task 3: Validate Take Rate & Add Footnote

**Add a small "Take Rate Breakdown" detail section on slide 2 (Assumptions).**

Already-validated data from this session's research:

| Category | % of GMV | Take Rate | Source |
|----------|----------|-----------|--------|
| Flights | 60% | 3–5% | Duffel: $3 + 1% fee; $15–25 markup per booking |
| Hotels | 30% | 10–15% | New platform OTA rate |
| Activities | 10% | 5–8% | Viator/GYG affiliate rate |
| **Blended** | | **6.8%** | Weighted average |

Implementation:
- Collapsible or small-text detail block under the "Blended Take Rate" row in the assumptions table
- Shows: "On a $500 flight: Duffel takes $8, you keep ~$17 markup (3.4%). Hotels are where the margin is."
- Style: `font-size: 11px; color: var(--g400)` — visible but not distracting
- Update the base case take rate label to show "8%" with a note: "weighted; flights drag this down, hotels pull it up"

**File:** `presentations/path-to-the-plane-2026-04-01.html` — modify slide s1 (assumptions)

### Task 4: Add "Company Plane" Path on Final Slide

**Add a card/section to the takeaways slide showing the alternative path.**

Concept: If the Challenger 350 is a company asset (business travel, team offsites, partner visits), Jake doesn't need $4.8M personal take. He needs $4.8M in company operating budget.

Math:
- Company needs $4.8M operating budget for aviation
- At 20% operating margin → $24M revenue (vs $34.3M for personal take)
- At 20% margin, $24M revenue → $24M / $6.00 per user = **4.0M total users** (vs 5.71M)
- Tax advantage: company OpEx is pre-tax; personal distributions are post-tax (saves ~38%)

Implementation:
- Add as a fourth insight card (or replace one of the existing two-column insights)
- Title: "The Company Plane Path"
- Subtitle: "Tier 3 as company OpEx, not personal income"
- Show: "4.0M users / $24M revenue" vs "5.71M users / $34.3M revenue"
- Muted note: "Aircraft as business asset = pre-tax dollars. Consult your accountant."

**File:** `presentations/path-to-the-plane-2026-04-01.html` — modify final slide (takeaways)

### Task 5: Build Interactive Calculator

**New file: `presentations/plane-calculator.html`**

Standalone HTML page with the same CSS framework (Plus Jakarta Sans, Space Mono, Tryps color vars). Features:

**Input sliders (left column or top):**
- GMV per paying user: $200–$1,500 (default $500)
- Blended take rate: 2%–20% (default 8%)
- Paid conversion: 3%–40% (default 15%)
- Operating margin: 5%–45% (default 20%)
- Jake's ownership: 30%–100% (default 70%)

**Output (right column or bottom):**
- Derived stat: "Revenue per user: $X.XX" and "Jake's take per user: $X.XX"
- Four tier cards showing users needed + revenue required, updating in real-time
- Each tier card: icon, name, annual cost, users needed (large mono), revenue (smaller)
- Color-code: green if achievable (<1M users), yellow if ambitious (1–10M), red if massive (>10M)

**Behavior:**
- All updates are instant (no submit button) — `oninput` event on range sliders
- Each slider shows its current value next to the handle
- URL hash encodes current values so you can share a specific scenario (e.g., `#gmv=500&take=8&paid=15&margin=20&own=70`)
- Preset buttons: "Marty's Original" (loads his assumptions) and "Base Case" (loads pressure-tested values)

**Implementation:**
- Pure vanilla JS — no frameworks, no dependencies
- Single HTML file with inline CSS and JS
- CSS grid: 2-column layout on desktop, stacked on mobile
- Sliders use native `<input type="range">` with custom styling to match brand

## Acceptance Criteria

- [ ] Waterfall slide clearly shows 100→$0.84 derivation in one visual
- [ ] Sensitivity page uses range bands instead of dense table
- [ ] Take rate breakdown visible as detail text on assumptions slide
- [ ] Company Plane path shown as alternative on final slide
- [ ] Calculator loads, sliders work, tiers update in real-time
- [ ] Calculator URL hash preserves slider state
- [ ] Calculator has "Marty's Original" and "Base Case" presets
- [ ] All pages use same CSS framework (Plus Jakarta Sans, Space Mono, Tryps colors)
- [ ] Deck is 6 slides total (Title, Assumptions, Waterfall, Tiers, Ranges, Takeaways)
- [ ] Mobile-responsive on all pages

## File Changes

| File | Action |
|------|--------|
| `presentations/path-to-the-plane-2026-04-01.html` | Modify — add waterfall slide, simplify sensitivity, add take rate detail, add company plane path |
| `presentations/plane-calculator.html` | Create — interactive calculator |

## References

- Current deck: `~/tryps-docs/presentations/path-to-the-plane-2026-04-01.html`
- Analysis data: `~/tryps-docs/pitch-deck-ideas/data/path-to-the-plane.md`
- CSS reference deck: `~/tryps-docs/presentations/rich-ross-2026-03-31.html`
- Duffel pricing: $3 + 1% per confirmed order (from research agent, this session)
- Take rate comps: Booking 14.3%, Airbnb 13.6%, Expedia 12.3%, Hopper 9–11%
