---
title: "Brand & GTM Workspace Setup"
type: feat
date: 2026-03-24
---

# Brand & GTM Workspace Setup

## Overview

Consolidate all brand and go-to-market work into a single `brand-and-gtm/` folder in tryps-docs. This replaces the two separate scope folders (`brand-design-system` and `launch-gtm` in `scopes/`) with a unified workspace that supports today's strategy session with Sean and the ongoing brand/launch workstream through May 2.

## Problem Statement

Brand and GTM materials are scattered across 10+ locations in tryps-docs:
- `shared/brand.md` and `shared/brand-strategy.md`
- `docs/brand-intake-questionnaire.md` and `docs/brand-book-screen-checklist.md`
- `docs/brainstorms/2026-03-18-brand-book-brainstorm.md`
- `docs/research/2026-03-19-brand-book-research.md`
- `docs/handoffs/2026-03-19-brand-world-figma-session.md`
- `docs/plans/2026-03-18-feat-brand-strategy-and-brand-book-plan.md`
- `designs/brand-book-make-prompts.md`, `designs/brand-book-grid.html`, `designs/glimmers-research.md`
- Two scope folders with only objective.md + state.md each

Sean needs a clean workspace to drop his files into and reference strategy docs. Jake needs a printable checklist structure to drive execution through May 2.

## Proposed Solution

### New Folder Structure

```
tryps-docs/
└── brand-and-gtm/
    ├── README.md                    # How this folder works, for Sean + anyone
    ├── objective.md                 # Umbrella objective (what we're doing & why)
    ├── scope.md                     # The printable checklist — all sub-scopes
    ├── spec.md                      # Strategy spec (filled during today's session)
    │
    ├── reference/
    │   └── INDEX.md                 # Pointers to all existing materials (not copies)
    │
    ├── sean-files/                  # Sean's direct contributions
    │   └── .gitkeep
    │
    └── sub-scopes/
        ├── brand-world/
        │   └── scope.md             # Visual identity, brand book, design system
        ├── launch-gtm/
        │   └── scope.md             # Launch strategy, landing page, App Store
        ├── ugc-program/
        │   └── scope.md             # Wispr Flow playbook, UGC strategy
        ├── referral-program/
        │   └── scope.md             # Referral incentives, giveaways
        └── geo-aeo-seo/
            └── scope.md             # Search presence, AI discoverability
```

### What Each File Does

| File | Purpose | When it gets filled |
|------|---------|-------------------|
| `objective.md` | What + why for the whole brand & GTM effort | Today |
| `scope.md` | Printable checklist of all sub-scopes with deliverables | Today |
| `spec.md` | Strategy spec — the crisp doc Jake can print | Today (iteratively) |
| `reference/INDEX.md` | Links to every existing brand doc (no file moves) | Now (setup) |
| `sean-files/` | Drop zone for Sean's creative assets + docs | Sean drops files today |
| `sub-scopes/*/scope.md` | Per-subscope breakdown: deliverables, owner, timeline | Today |

### The Sequencing Framework (baked into scope.md)

The master `scope.md` follows Jake's principle:

1. **Strategy & Scoping** — What are we doing? (today's session)
2. **Operating Model** — How do we work together? Cadence, tools, handoffs
3. **Org Design** — What roles do we need? What types of people?
4. **Talent Selection** — Who specifically? Pick designer, creative lead, etc.
5. **Timeline** — When does each piece land? Map to May 2 deadline

## Implementation Phases

### Phase 1: Immediate Setup (Do Now)

- [ ] Create `brand-and-gtm/` folder structure (all dirs + placeholder files)
- [ ] Create `reference/INDEX.md` with links to all 10 existing reference docs
- [ ] Create `README.md` explaining the folder for Sean
- [ ] Add Sean (`seadefaria@gmail.com`) as collaborator on tryps-docs repo
- [ ] Mark old scope folders as superseded (add note to their state.md files)
- [ ] Update `scopes/INDEX.md` to point scopes 11 + 12 → `brand-and-gtm/`

### Phase 2: Remove Brand from ClickUp

- [ ] Delete ClickUp task `86e0emu98` (p4-brand-strategy)
- [ ] Delete ClickUp task `86e0emu9h` (p4-wispr-playbook)
- [ ] Delete ClickUp task `86e0emu9w` (p4-launch-video)
- [ ] Delete ClickUp task `86e0emua8` (p4-referral-incentives)
- [ ] Delete ClickUp task `86e0emuar` (p4-giveaways)
- [ ] Update `shared/clickup.md` to remove P4 brand rows

### Phase 3: Today's Session Outputs (Jake + Sean Fill In)

These files get written during the strategy conversation — just stubs for now:

- [ ] `objective.md` — umbrella objective
- [ ] `spec.md` — the crisp strategy doc
- [ ] `scope.md` — the printable checklist with all sub-scopes
- [ ] Each `sub-scopes/*/scope.md` — per-subscope detail

## Reference Materials Index (for `reference/INDEX.md`)

| Document | Location | What it contains |
|----------|----------|-----------------|
| Brand System | `shared/brand.md` | Colors, typography, spacing, voice & tone |
| Brand Strategy | `shared/brand-strategy.md` | Strategic brand direction (20KB) |
| Brand Intake Questionnaire | `docs/brand-intake-questionnaire.md` | Foundational brand questions (42KB) |
| Brand Book Screen Checklist | `docs/brand-book-screen-checklist.md` | Required screens for Figma brand book |
| Brand Book Brainstorm | `docs/brainstorms/2026-03-18-brand-book-brainstorm.md` | Initial brainstorm notes |
| Brand Book Research | `docs/research/2026-03-19-brand-book-research.md` | Competitive research (38KB) |
| Figma Session Handoff | `docs/handoffs/2026-03-19-brand-world-figma-session.md` | Figma session notes |
| Brand Strategy Plan | `docs/plans/2026-03-18-feat-brand-strategy-and-brand-book-plan.md` | Original planning doc |
| Brand Book Make Prompts | `designs/brand-book-make-prompts.md` | AI generation prompts for brand book |
| Brand Book Grid | `designs/brand-book-grid.html` | Grid layout for brand book |
| Glimmers Research | `designs/glimmers-research.md` | Visual inspiration research |

**Not included:** `designs/tryps.pen` (removing per Jake's instruction)

## Out of Scope

- Moving or copying existing reference files (INDEX.md links to them in place)
- ClickUp replacement for brand tracking (brand lives in this folder now, not ClickUp)
- Actually filling in the strategy docs (that's today's session work)
- Figma work

## Dependencies

- Sean needs to accept the GitHub invitation before he can push to `sean-files/`
- Sean's Claude instance needs the repo cloned to drop files in

## Success Criteria

- [ ] `brand-and-gtm/` folder exists with full structure
- [ ] Sean has collaborator access to tryps-docs
- [ ] All existing brand reference materials are indexed (not moved)
- [ ] Old scope folders marked as superseded
- [ ] Brand tasks removed from ClickUp
- [ ] Folder is ready for today's strategy session — Sean can drop files, Jake can start writing scope.md
