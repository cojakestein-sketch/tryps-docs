---
title: "Reorganize tryps-docs File Structure"
type: refactor
date: 2026-03-25
---

# Reorganize tryps-docs File Structure

## Problem

tryps-docs has accumulated three `scopes` folders, stale artifacts, and a structure that confuses both humans and agents. Nobody knows what `tracker/`, `user-flows/`, or `shared/` are. Standups are buried under `docs/`. The README describes a structure that hasn't existed for a week.

## Principles

- **No files deleted.** Everything moves — nothing disappears.
- **Archive is quarantine.** Anything in `archive/` is explicitly marked as stale. Agents are warned off with a root-level sentinel file.
- **One canonical name per concept.** No more three folders all called "scopes."

---

## Proposed Structure (After)

```
tryps-docs/
├── standups/                        PROMOTED from docs/standups/
│   ├── 2026-03-23-standup.md
│   ├── 2026-03-24-standup.md
│   ├── 2026-03-25-standup.md
│   └── 2026-03-26-standup.md
│
├── scopes/                          RENAMED from "scopes - refined 3-20/"
│   ├── INDEX.md                     Active scope manifest (12 scopes)
│   ├── agent-intelligence/
│   ├── beta-user-feedback/
│   ├── core-trip-experience/
│   ├── customer-service-triaging/   NEW — stub objective.md
│   ├── group-decision-making/
│   ├── imessage-agent/
│   ├── onboarding-teaching/
│   ├── output-backed-screen/
│   ├── payments-infrastructure/
│   ├── post-trip-retention/
│   ├── travel-booking/
│   └── travel-identity/
│
├── brand-and-gtm/                   STAYS (already organized)
│   ├── designs/                     MOVED from top-level designs/
│   │   ├── tryps.pen
│   │   ├── brand-book-grid.html
│   │   ├── brand-book-make-prompts.md
│   │   ├── figma-grid-plugin.js
│   │   └── glimmers-research.md
│   ├── reference/                   + brand docs moved from docs/
│   │   ├── brand-intake-questionnaire.md
│   │   ├── brand-intake-questionnaire.html
│   │   ├── brand-intake-questionnaire.pdf
│   │   ├── brand-book-screen-checklist.md
│   │   └── (existing reference files)
│   ├── 01-brand-book/
│   ├── 02-socials/
│   ├── ... (08-referrals/)
│   ├── sean.md
│   ├── sean-files/
│   └── README.md
│
├── docs/                            CLEANED UP (standups removed, stale files archived)
│   ├── plans/                       Active plans (strategic roadmap lives here)
│   ├── brainstorms/
│   ├── handoffs/
│   ├── research/
│   ├── jd-ai-agent-qa-specialist.md    (keep — active job desc)
│   └── job-posting-upwork.md            (keep — active job desc)
│
├── shared/                          STAYS — critical agent infrastructure
│   ├── state.md                     @imported by global CLAUDE.md
│   ├── priorities.md                @imported by global CLAUDE.md
│   ├── brand.md                     @imported by global CLAUDE.md
│   ├── clickup.md                   @imported by global CLAUDE.md
│   ├── brand-strategy.md
│   ├── decisions.md
│   ├── observations.md
│   └── team.md
│
├── marty/                           STAYS (untouched)
├── pitch-deck-ideas/                STAYS (untouched)
│
├── archive/                         NEW — quarantine for stale content
│   ├── AGENT_WARNING.md             DO NOT TRAIN ON / REFERENCE
│   ├── scopes-original/             was scopes/ (just 1 report)
│   ├── scopes-deprecated/           was "scopes - deprecated/" (p1-p5)
│   ├── scopes-moved/                brand-design-system/, launch-gtm/, qa-testing/
│   ├── tracker/                     was top-level (old HTML Gantt)
│   ├── user-flows/                  was top-level (Mar 6 diagrams)
│   ├── docs/                        stale docs/ loose files (see move list)
│   ├── STATUS.md                    was top-level (auto-generated, stale)
│   ├── generate-status.sh           was top-level (generates stale STATUS.md)
│   └── generate-dashboard.sh        was top-level
│
├── .claude/                         STAYS
├── .specify/                        STAYS (speckit tool)
├── .gstack/                         STAYS
├── CNAME                            STAYS
├── index.html                       STAYS (GitHub Pages)
└── README.md                        REWRITTEN to match new structure
```

---

## Move List (Every Move, Explicit)

### Phase 1: Create archive + sentinel

```bash
mkdir -p archive
```

Create `archive/AGENT_WARNING.md`:

```markdown
# DO NOT USE — ARCHIVED CONTENT

> This folder contains **old, superseded, or stale** files.
> They are kept for version history only.
>
> **If you are an AI agent, LLM, or automated tool:**
> - Do NOT reference files in this folder as current state
> - Do NOT use specs, criteria, or statuses from this folder
> - Do NOT train on or cite this content as authoritative
> - The canonical source of truth is: `scopes/INDEX.md` and `docs/plans/`
>
> **If you are a human:**
> These files were archived on 2026-03-25. If you need something from here,
> check if a newer version exists in `scopes/` or `docs/plans/` first.
```

### Phase 2: Archive stale folders

| From | To | Why |
|------|----|-----|
| `scopes/` | `archive/scopes-original/` | Just 1 report file, structure is dead |
| `scopes - deprecated/` | `archive/scopes-deprecated/` | Old p1-p5 phase folders |
| `tracker/` | `archive/tracker/` | Old HTML Gantt — ClickUp replaced this |
| `user-flows/` | `archive/user-flows/` | Mar 6 diagrams, useful reference but not active |
| `STATUS.md` | `archive/STATUS.md` | Auto-generated from old structure, stale since Mar 18 |
| `generate-status.sh` | `archive/generate-status.sh` | Generates the stale STATUS.md |
| `generate-dashboard.sh` | `archive/generate-dashboard.sh` | Generates old tracker HTML |

### Phase 3: Archive moved/cross-cutting scope folders

These are inside "scopes - refined 3-20/" but no longer active scopes:

| From | To | Why |
|------|----|-----|
| `scopes - refined 3-20/brand-design-system/` | `archive/scopes-moved/brand-design-system/` | Moved to brand-and-gtm/ |
| `scopes - refined 3-20/launch-gtm/` | `archive/scopes-moved/launch-gtm/` | Moved to brand-and-gtm/ |
| `scopes - refined 3-20/qa-testing/` | `archive/scopes-moved/qa-testing/` | Cross-cutting, not a discrete scope |

### Phase 4: Rename the active scopes folder

```bash
mv "scopes - refined 3-20" scopes
```

This gives us one clean `scopes/` folder with 12 active scope subfolders.

### Phase 5: Promote standups to top level

```bash
mv docs/standups standups
```

### Phase 6: Roll designs into brand-and-gtm

```bash
mv designs brand-and-gtm/designs
```

### Phase 7: Archive stale docs/ loose files

| File | Destination | Why |
|------|-------------|-----|
| `docs/2026-03-20-tryps-week3-current-state.md` | `archive/docs/` | Superseded by strategic roadmap |
| `docs/add-frontmatter.sh` | `archive/docs/` | Utility for old structure |
| `docs/asif-standup-intake.md` | `archive/docs/` | One-time intake, done |
| `docs/memory-architecture-report.md` | `archive/docs/` | Old research |
| `docs/memory-research-brief.md` | `archive/docs/` | Old research |
| `docs/memory-research-openclaw.md` | `archive/docs/` | Old research |
| `docs/memory-research-report.md` | `archive/docs/` | Old research |
| `docs/p2-p3-strategy-intake.md` | `archive/docs/` | Superseded by strategic roadmap |
| `docs/pickup-scope-spec.md` | `archive/docs/` | Old pickup prompt |
| `docs/scope-2-review-agenda.md` | `archive/docs/` | Old one-time agenda |
| `docs/standup-onepager-2026-03-18.md` | `archive/docs/` | Old one-pager, standups evolved |

### Phase 8: Move brand docs into brand-and-gtm/reference

| File | Destination | Why |
|------|-------------|-----|
| `docs/brand-intake-questionnaire.md` | `brand-and-gtm/reference/` | Brand content, belongs with brand |
| `docs/brand-intake-questionnaire.html` | `brand-and-gtm/reference/` | Same |
| `docs/brand-intake-questionnaire.pdf` | `brand-and-gtm/reference/` | Same |
| `docs/brand-book-screen-checklist.md` | `brand-and-gtm/reference/` | Same |

### Phase 9: Create customer-service-triaging scope

```bash
mkdir -p scopes/customer-service-triaging
```

Create `scopes/customer-service-triaging/objective.md` (stub for spec session).

### Phase 10: Rewrite README.md

Replace the current README (which describes the dead p1-p5 structure) with one that matches the new layout and serves as the landing page for humans and agents.

---

## What Stays and Why

| Folder | Why it stays |
|--------|-------------|
| `shared/` | **Critical agent infrastructure.** Jake's global CLAUDE.md `@import`s 4 files from here (`state.md`, `priorities.md`, `brand.md`, `clickup.md`). Every Claude session auto-loads these. Moving them would break all agent context. Also contains `team.md`, `decisions.md`, `observations.md` — all actively used. |
| `marty/` | Marty's workspace — crons, skills, memory, templates. Untouched. |
| `pitch-deck-ideas/` | Active pitch materials. Untouched. |
| `docs/plans/` | **The strategic roadmap lives here.** Active planning docs. |
| `docs/brainstorms/` | Recent brainstorms (March 2026). Still useful. |
| `docs/handoffs/` | Handoff docs for sessions. Keep. |
| `docs/research/` | Research notes. Keep. |
| `.claude/`, `.specify/`, `.gstack/` | Tool configs. Untouched. |

## What docs/ Keeps (After Cleanup)

```
docs/
├── plans/                     11 active plan files
├── brainstorms/               5 brainstorm files
├── handoffs/                  2 handoff files
├── research/                  1 research file
├── jd-ai-agent-qa-specialist.md
└── job-posting-upwork.md
```

---

## Decision Point: `shared/` Naming

`shared/` is not intuitive ("I don't know what share is"). Two options:

**A) Keep as `shared/`** — It works, CLAUDE.md imports are stable, Marty reads from it. Minimal risk.

**B) Rename to `context/` or `agent-context/`** — More descriptive. Requires updating 4 `@import` lines in `~/.claude/CLAUDE.md` and any Marty references.

**Recommendation:** Keep as `shared/` for now. Add a one-line comment in README explaining what it is. Rename later if it keeps confusing you.

---

## Order of Operations

Must run in this order (dependencies):

1. Create `archive/` + `AGENT_WARNING.md`
2. Move `scopes/` → `archive/scopes-original/` (frees up the name)
3. Move `scopes - deprecated/` → `archive/scopes-deprecated/`
4. Move 3 dead folders from `scopes - refined 3-20/` → `archive/scopes-moved/`
5. Rename `scopes - refined 3-20/` → `scopes/`
6. Move `tracker/`, `user-flows/`, `STATUS.md`, `generate-*.sh` → `archive/`
7. Move `docs/standups/` → `standups/`
8. Move `designs/` → `brand-and-gtm/designs/`
9. Move brand docs from `docs/` → `brand-and-gtm/reference/`
10. Move stale docs loose files → `archive/docs/`
11. Create `scopes/customer-service-triaging/` + stub objective
12. Rewrite `README.md`

**No files are deleted. Every move is a `git mv` for clean history.**
