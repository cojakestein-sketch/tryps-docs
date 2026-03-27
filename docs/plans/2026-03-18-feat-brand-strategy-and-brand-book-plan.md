---
title: "Brand Strategy & Brand Book"
type: feat
date: 2026-03-18
---

# Brand Strategy & Brand Book Execution Plan

## Overview

Build a complete brand system for Tryps in two deliverables: (1) a Brand Strategy Doc answering foundational identity questions, and (2) a 30-40 screen Brand Book in Figma. Strategy drives design — every visual choice traces back to a strategic decision. Weekly review cadence with Trent (branding consultant, Open Invite Studio).

## Problem Statement / Motivation

Tryps is launching mid-April 2026 with no brand system. Current state:
- Basic logo exists, red color chosen without rationale
- Landing page built in 5 minutes, doesn't match app
- Design tokens are drifting: `theme.ts` uses Plus Jakarta Sans + `#D9071C`, `.pen` file uses Space Grotesk + `#DC2626`
- No typography system, no art direction, no voice/tone guidelines
- 4 of 5 P4 (Brand/GTM) scope specs are empty stubs
- Launch video needs brand direction to produce

Without a brand system, every touchpoint (app, website, social, video, pitch deck) is an ad hoc decision. The launch video, social presence, and App Store listing all need a single coherent identity.

## Proposed Solution

**Strategy-first approach** per Trent's methodology:

```
Phase 1: Discovery (answer foundational questions)
    ↓
Phase 2: Brand Strategy Doc (position, personality, voice)
    ↓
Phase 3: Direction Deck (2-3 visual directions with moodboards)
    ↓
Phase 4: Brand Book in Figma (30-40 screens)
    ↓
Phase 5: Apply to touchpoints (app, website, social, video)
```

Parallel track: create [[brand|shared/brand.md]] as the text source of truth, `@import` into global CLAUDE.md so every dev session is brand-aware.

---

## Implementation Phases

### Phase 1: Discovery & Strategy Inputs (Mar 18-20)

**Owner:** Jake
**Deliverable:** Completed brand intake questionnaire + refined foundational answers

#### Tasks

- [ ] Review and react to the 4 draft foundational answers in `docs/brainstorms/2026-03-18-brand-book-brainstorm.md`
  - Who is the core 1% power user?
  - What pain points does the app solve?
  - Why do users return?
  - What makes Tryps feel good vs competitors?
- [ ] Answer the 56 must-answer questions from `docs/brand-intake-questionnaire.md`
  - Brand Purpose & Mission (8 questions)
  - Target Audience & User Persona (13 questions)
  - Brand Personality & Voice (10 questions)
  - Visual Direction (16 questions) — including film camera motif decision
  - Competitive Positioning (9 questions)
- [ ] Use Claude to help draft answers — dictate raw thoughts, Claude structures them
- [ ] Bring completed questionnaire to Trent at next omakase for review

**Success criteria:** All 56 [MUST] questions answered. Foundational answers sharpened and validated.

**Key files:**
- `tryps-docs/docs/brand-intake-questionnaire.md` — the 87-question template
- `tryps-docs/docs/brainstorms/2026-03-18-brand-book-brainstorm.md` — draft foundational answers
- `tryps-docs/pitch-deck-ideas/01-the-story.md` — existing brand narrative (use as input)

---

### Phase 2: Brand Strategy Doc (Mar 20-22)

**Owner:** Jake + Claude
**Deliverable:** [[brand-strategy|tryps-docs/shared/brand-strategy.md]] — the internal strategy document

#### Tasks

- [ ] Write Brand Purpose statement: "We exist to [action] + [audience] + [outcome]"
- [ ] Write Brand Positioning statement: "For [audience] who [need], Tryps is a [category] that [benefit]. Unlike [competitors], we [differentiator]."
- [ ] Define Brand Values (3-5 real principles, not buzzwords)
- [ ] Choose Brand Archetype blend (e.g., 70% Explorer + 30% Jester)
- [ ] Define Brand Personality in 3-5 adjectives
- [ ] Map Voice & Tone on spectrums:
  - Formal ↔ Casual
  - Serious ↔ Playful
  - Respectful ↔ Irreverent
  - Enthusiastic ↔ Matter-of-fact
- [ ] Create word lists: "words we use" / "words we avoid"
- [ ] Write one-sentence value prop + 3 supporting messages
- [ ] Draft 5+ tagline candidates
- [ ] Document competitive positioning (vs Splitwise, TripIt, Wanderlog, Google Docs, iMessage)

**Success criteria:** Strategy doc exists, is internally consistent, and can be handed to a designer who builds a visual identity from it without needing to ask Jake questions.

**Key decision:** Brand tone — the brainstorm recommends **cheeky/knowing** over inspirational or documentary. Confirm with Trent.

---

### Phase 3: Create brand.md + Fix Token Drift (Mar 20-21)

**Owner:** Jake + Claude
**Deliverable:** [[brand|tryps-docs/shared/brand.md]] — auto-loaded into all Claude sessions

#### Tasks

- [ ] Extract design tokens from `t4/utils/theme.ts` into readable markdown:
  - Color palette with hex values, names, and usage rules
  - Font families (Plus Jakarta Sans primary, Space Mono mono)
  - Type scale (H1 through caption)
  - Spacing scale
  - Border radii, shadows
- [ ] Add brand narrative summary (condensed from strategy doc):
  - Mission / one-liner
  - Voice & tone guidelines
  - "We are / We are not" personality
  - Key brand rules
- [ ] Add `@~/tryps-docs/shared/brand.md` to global `~/.claude/CLAUDE.md`
- [ ] Fix `.pen` file drift — reconcile colors and fonts:
  - Decision: `theme.ts` is the source of truth
  - Update `tryps.pen` to match (Plus Jakarta Sans, `#D9071C`)
  - Or explicitly document that `.pen` file uses different typography for pitch decks
- [ ] Log decision in `shared/decisions.md`: "brand.md is text source of truth; Figma is visual reference; theme.ts is code implementation"

**Success criteria:** Running `claude` in any repo auto-loads brand context. No more token drift between systems.

**Key files:**
- `t4/utils/theme.ts` — code source of truth (510 lines)
- `tryps-docs/designs/tryps.pen` — design file with drift
- `~/.claude/CLAUDE.md` — global imports

---

### Phase 4: Direction Deck (Mar 22-25)

**Owner:** Jake + adhoc Figma designers
**Deliverable:** 2-3 visual directions in Figma, each 5-8 slides

#### Tasks

- [ ] Create a Figma project/page for the brand book work
- [ ] Build Direction A: Film Camera (warm, grain, candid — the current leading motif)
  - Moodboard (5-10 images)
  - Color story with palette swatches
  - Typography pairing suggestion
  - Sample app screen mockup
  - Sample social post mockup
- [ ] Build Direction B: [Alternative — e.g., Clean/Modern/Minimal]
  - Same structure as above
- [ ] Build Direction C (optional): [Hybrid or third option]
- [ ] Review with Trent at omakase — pick a direction or hybrid
- [ ] Document chosen direction in `shared/decisions.md`

**Success criteria:** One visual direction chosen and validated by Trent. Designers can start building the brand book.

**Open question:** Who designs the direction deck? Jake doing it himself with Claude + adhoc designers? Or engage Trent for the $3K sprint?

---

### Phase 5: Brand Book in Figma (Mar 25 - Apr 4)

**Owner:** Jake + adhoc Figma designers
**Deliverable:** 30-40 screen brand book in Figma

**Existing Figma assets (already built by adhoc designers):**
- Logo: 4+ variants (light, dark bg, multiple sizes) — needs rules added
- Typography: 2 font families, 4 weights each — needs hierarchy rationale
- Color: palette grid with swatches — needs naming, hex docs, usage rules
- iOS Icon: 4 variants (Light, Dark, White, Tinted) — strong, done
- Splash Screen: 5 variations explored — pick winner, document
- Component library: Input Field, Date Picker, Alert, Badge, Shadow, Checkbox, Header, Divider, Footer — bonus, already ahead

**Phase 5a: Strategy wrapper screens (~15 NEW screens to add around existing assets):**

#### Section A: Front Matter (3 screens)
- [ ] Cover page — logo on branded background
- [ ] Table of contents
- [ ] Brand story / introduction

#### Section B: Brand Strategy (4 screens)
- [ ] Mission & vision
- [ ] Brand values
- [ ] Brand personality ("We are X, not Y")
- [ ] Target audience / persona

#### Section C: Logo — ADD to existing (2-3 new screens)
- [ ] Clear space + minimum size rules (existing variants are good)
- [ ] Logo placement on backgrounds
- [ ] Logo misuse examples (don'ts)

#### Section D: Color — ADD to existing (1-2 new screens)
- [ ] Named color roles with rationale (wrap existing palette with "why")
- [ ] Color usage rules + approved combinations

#### Section E: Typography — ADD to existing (1 new screen)
- [ ] Usage rules, hierarchy rationale, don'ts (existing weights/families are set)

#### Section G: Voice & Tone (2 screens)
- [ ] Voice characteristics + "we say / we don't say"
- [ ] Tone by context (marketing, support, social, in-app)

#### Section J: Back Matter (1 screen)
- [ ] Asset downloads / contact

**Phase 5b (post-launch, ~10-15 more screens):**

- [ ] Section F: Imagery — photography style, illustration, iconography, patterns
- [ ] Section H: Social media — platform overview, profile assets, post templates, content style
- [ ] Section I: Applications — business cards, email, presentations, merch
- [ ] Additional app-specific screens — dark mode rules, motion/animation, onboarding style, empty states

#### Brand Sync Process

After each brand book decision in Figma:
1. Describe the change to Claude in any terminal
2. Claude updates `shared/brand.md`
3. If it's a token change, Claude updates `t4/utils/theme.ts`
4. Decision gets logged in `shared/decisions.md`

**Success criteria:** 15+ screens complete before launch video production begins. Full 30-40 screens complete by end of April.

---

### Phase 6: Apply to Touchpoints (Apr 1-15, parallel with launch)

**Owner:** Jake + devs + designers
**Deliverable:** Brand-consistent touchpoints

- [ ] Update landing page (jointryps.com) to match brand book
- [ ] Update first screen after download (Trent flagged as highest-value real estate)
- [ ] Create App Store / TestFlight screenshots with brand treatment
- [ ] Create social media profile assets (avatar, cover images per platform)
- [ ] Create 3-5 social post templates
- [ ] Provide brand direction pack to Sean for launch video production
- [ ] Update pitch deck with new brand system

---

## Dependencies & Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| Questionnaire answers take too long | Blocks all design work | Jake answers 56 must-haves by Friday using Claude to help draft. Imperfect answers > no answers. |
| Trent availability | Direction deck review delayed | Weekly cadence is agreed. If one week slips, direction deck can proceed with best judgment. |
| Adhoc designers availability | Figma brand book work stalls | Jake can build initial screens himself with Claude guidance. Designers polish later. |
| Brand direction changes after user data | Rework needed | Trent's advice: launch with "good enough" brand, pivot based on stranger-market data. Design the system to be adaptable, not precious. |
| Token drift continues | Inconsistent brand across touchpoints | brand.md + Brand Sync ritual catches drift. @import ensures Claude sessions always have current state. |

## Success Metrics

1. **Strategy doc complete** — all 56 must-answer questions answered, positioning statement written
2. **brand.md live** — auto-loading in all Claude sessions via @import
3. **Token drift resolved** — theme.ts, .pen, and Figma all using same colors/fonts
4. **Brand book Phase 5a complete** — 15 must-have screens in Figma before launch video production
5. **Trent sign-off** — at least 2 omakase reviews completed with positive direction

## Timeline Summary

```
Week of Mar 18 (this week):
├── Mon-Wed: Answer foundational questions + intake questionnaire
├── Wed-Thu: Create brand.md, fix token drift
├── Thu-Fri: Start brand strategy doc
└── Fri: Jackson meeting (show brand direction thinking)

Week of Mar 22:
├── Sun-Mon: Finish brand strategy doc
├── Mon-Wed: Direction deck (2-3 visual directions)
├── Wed: Trent omakase review #1 — pick direction
└── Thu-Fri: Begin Figma brand book (front matter + logo)

Week of Mar 29:
├── Mon-Thu: Figma brand book Phase 5a (15 must-have screens)
├── Wed: Trent omakase review #2 — validate brand book progress
└── Fri: Brand direction pack to Sean for launch video

Week of Apr 1-4:
├── Apply to touchpoints (landing page, app, App Store)
└── Launch video production begins with brand direction
```

## References

### Internal
- `tryps-docs/docs/brainstorms/2026-03-18-brand-book-brainstorm.md` — brainstorm with strategy, scope, draft answers, Figma bridge plan
- `tryps-docs/docs/brand-intake-questionnaire.md` — 87-question intake template
- `tryps-docs/pitch-deck-ideas/01-the-story.md` — founder narrative
- `tryps-docs/scopes/p4/launch-video/spec.md` — launch video spec with brand direction
- `t4/utils/theme.ts` — shipped design tokens (source of truth for code)

### Meeting Notes
- Trent meeting 2026-03-18: Strategy-first approach, weekly omakase consultations, $3K sprint option, Flight app brand book as reference model, Bucket app lesson (UGC > produced content, stranger market reveals real users)
