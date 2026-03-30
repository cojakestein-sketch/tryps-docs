# Pickup Prompt: Tryps Pitch Deck V5 Fixes

## Context

Working on the Tryps pitch deck at `~/tryps-docs/presentations/martin-trust-center-2026-03-30.html`. This is an HTML slide deck (arrow keys to navigate). Images are in the same directory (`logo.png`, `detail.png`, etc.). Open with `open ~/tryps-docs/presentations/martin-trust-center-2026-03-30.html` to preview.

Current slide order (10 slides):
1. Title
2. What is Tryps (group chat demo with iMessage polls)
3. Problem / Solution (side by side)
4. Business Model + Right to Win (combined)
5. Architecture (three-layer: iMessage / App / Agent)
6. What We're Building (9 scopes)
7. Distribution Strategy (Sean's 6 GTM scopes)
8. Team org chart
9. Where We're Headed + Questions for Ben (half and half on red slide)
10. Close

## Fixes Needed

### 1. Problem / Solution slide (slide 3) — Make truly parallel
The problem side has 3 tall cards, the solution side has 3 short numbered steps. They don't visually balance. Make both sides match height — either give the solution side 3 matching cards with the same padding/structure, or compress the problem side. Both columns should feel equal weight, same vertical rhythm.

### 2. Business Model slide (slide 4) — Reframe around three pillars
Current layout has 1% box + 4 right-to-win cards that overflow. Redesign this slide:
- **Headline:** "In exchange for being where you are, facilitating your trip, and booking on your behalf — we earn a 1% booking fee."
- **Three cards below the 1% box, not four.** The three pillars are:
  1. **Product** — the app and iMessage integration
  2. **Agents** — AI that executes on your behalf
  3. **Facilitator for group travelers** — steering the group toward decisions
- Move "Data Moat", "Three Layers One Product" content to the architecture/product slides instead. They don't belong on the business model slide.

### 3. Architecture slide (slide 5) — Add real app screenshot
The middle column ("Tryps App") currently has a placeholder. Get a fresh screenshot from the running app or the latest Figma export. Check `~/t4/` for any recent screenshots. If none available, at minimum use the `.pen` file exports. The screenshot should show the trip detail or itinerary view.

### 4. Scopes slide (slide 6) — Number the scopes
Add visible numbers (01-09) to each scope card so it's clear there are exactly 9 things being built. Use Space Mono for the numbers in Tryps Red.

### 5. Distribution Strategy slide (slide 7) — Remove "The System" (scope 06)
Currently shows 6 cards. Remove card #06 ("The System" — the one about everything feeding the next). Keep only the 5 concrete deliverables: Launch Video, Giveaway, UGC + Ambassador, Social, Physical Presence.

### 6. Team org chart (slide 8) — Partners beside leaders, not underneath
Current layout puts Linq under Product column and Defaria LLC under GTM column as if they report to the team. Instead:
- **Linq** should appear to the RIGHT of Asif Raza (the product lead), as a partner badge/tag — not in the reporting chain
- **Defaria LLC** should appear to the RIGHT of the GTM Engineer box, as a partner badge — not below it
- Think of it as: `[Asif Raza] + [Linq partner]` on the same row, and `[GTM Engineer] + [Defaria LLC partner]` on the same row. Use the red partner border style but position them as peers, not reports.

### 7. Where We're Headed slide (slide 9) — Already half-and-half, verify it renders
Left: "Where We're Headed" (4 numbered items). Right: "Questions for You" (3 numbered items). Both should use the same numbered style (Space Mono numbers, matching typography). Verify both columns render side by side on desktop.

## Style Guide
- Font: Plus Jakarta Sans (body), Space Mono (numbers/data)
- Colors: Tryps Red #D9071C, Gold #E8913A, Blue #3478F6, Agent Green #2D8B5E
- Backgrounds: WHITE only. No brown, no cream, no dark. The only exception is the red "Where We're Headed" slide.
- Logo: `logo.png` in same directory, referenced via CSS class `.logo` (32px rounded square, top-left of every slide)

## How to Test
```bash
open ~/tryps-docs/presentations/martin-trust-center-2026-03-30.html
```
Arrow keys navigate. Check each slide renders properly at full browser width.
