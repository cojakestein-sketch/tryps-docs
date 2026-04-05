---
title: "Brain 2.0 Hardening: Validate Every Operation"
type: fix
date: 2026-04-05
status: active
owner: jake
parent: 2026-04-04-feat-brain-2-self-compounding-knowledge-architecture-plan
---

# Brain 2.0 Hardening: Validate Every Operation

## Overview

Brain 2.0 shipped all 4 phases in one session. An independent audit scored it **6.0/10** — architecture is sound, but zero operations have been validated. The compounding loop has one working link out of five (query). This plan turns the blueprint into a working system.

**Goal:** Every operation (ingest, query, lint) proven end-to-end. Audit score from 6/10 → 8+/10.

## Problem Statement

The audit identified five categories of issues:

1. **Commands never run** — `/brain-lint`, `/compound`, `/brain-compile` all exist as prompt specs but have zero proof of life
2. **Hetzner cron unverified** — `claude --print` may be wrong syntax; `sync-tryps-docs.sh` wiki sync unverified
3. **Obsidian plugins missing** — Templater + Marp not installed, 6 files are non-functional
4. **Skipped deliverable** — `shared/brain.md` was supposed to get a Brain 2.0 section
5. **Stale data** — INDEX.md Quick Reference hardcoded, weekly-retro.md hardcoded, `brand-strategy.md` at 479 lines violates 200-line cap

## Proposed Solution

Five sequential tasks, each independently valuable. Each task proves one part of the system and fixes issues it surfaces.

---

## Technical Approach

### Task 1: Run /brain-lint — First Health Score (~10 min)

**What:** Execute `/brain-lint` in report-only mode. Get the first real health score. Then run with `auto-fix` to resolve what it can.

**Steps:**
1. Run `/brain-lint` (report only)
2. Record the health score in `/Users/jakestein/tryps-docs/marty/wiki/brain-health-history.md`
3. Review findings — expect to surface:
   - `brand-strategy.md` at 479 lines (200-line cap violation)
   - Potential orphan memory files not in MEMORY.md
   - Stale files (>7 days: brand.md, brain.md, observations.md, team.md)
   - INDEX.md Quick Reference stats may mismatch state.md
4. Run `/brain-lint auto-fix` to resolve auto-fixable issues
5. Record the post-fix score
6. Commit results

**Success criteria:**
- [x] Health score recorded (62/100) in brain-health-history.md
- [x] Auto-fix resolved 3 orphans + INDEX.md line count
- [x] brand-strategy.md flagged as >200 lines (reclassified as Layer 1 raw source)
- [x] log.md has a lint entry appended

**Proves:** The lint operation works end-to-end.

### Task 2: Verify and Fix Hetzner Cron (~10 min)

**What:** SSH to Hetzner, verify the cron exists, fix the `claude` invocation syntax, verify wiki sync.

**Steps:**
1. SSH to Hetzner: `ssh -i ~/.ssh/hetzner openclaw@178.156.176.44`
2. Verify cron: `crontab -l` — confirm `0 18 * * 5` entry exists
3. Read `brain-lint-cron.sh` — check the `claude` invocation:
   - `claude --print` is likely wrong. Test: `claude --help | grep print`
   - Correct form is probably `claude -p "..."` or `echo "..." | claude --no-input`
   - Fix the script if needed
4. Dry-run the script: `bash ~/brain-lint-cron.sh` (or the relevant portion)
5. Verify wiki sync: `cat ~/sync-tryps-docs.sh | grep wiki` — confirm the wiki block is correct
6. Manually trigger a sync: `bash ~/sync-tryps-docs.sh`
7. Verify: `ls ~/path/to/workspace/wiki/` — confirm wiki files propagated

**Success criteria:**
- [x] Cron entry verified on Hetzner
- [x] `claude` invocation syntax confirmed working — needed ANTHROPIC_API_KEY from secrets.env (fixed)
- [x] `sync-tryps-docs.sh` correctly syncs `marty/wiki/` to workspace
- [x] Manual sync test passes — 7 wiki files confirmed in workspace

**Proves:** The automated Friday lint cron will actually fire and succeed.

### Task 3: Test /brain-compile on Real Standup (~15 min)

**What:** Run `/brain-compile` against the most recent standup transcript. Verify it extracts SC counts, proposes state updates, appends to wiki articles, and logs to log.md.

**Steps:**
1. Find the latest standup: `ls -t ~/tryps-docs/standups/*.md | head -1`
2. Run `/brain-compile <path-to-latest-standup>`
3. Verify it:
   - Classifies as "standup" content type
   - Extracts SC counts per scope
   - Proposes `scopes/*/state.md` frontmatter updates
   - Proposes wiki article appends (team-patterns, bug-taxonomy, etc.)
   - Shows diffs for each proposed change
4. Accept or modify the proposed filings
5. Verify log.md gets an ingest entry
6. Commit the results

**If no recent standup exists:** Use the missions.md or priorities.md as test input — `/brain-compile` should handle any raw text.

**Success criteria:**
- [x] /brain-compile processes a real document (standup 2026-03-27)
- [x] SC counts extracted but skipped (stale — state has advanced since Mar 27)
- [x] 2 wiki article appends: decisions-log (2 decisions), scope-intelligence (5 technical challenges)
- [x] log.md entry appended: `## [2026-04-05] ingest | Compiled standup 2026-03-27`
- [x] Changes committed (via Obsidian auto-sync)

**Proves:** The ingest operation works end-to-end. Combined with Task 1 (lint), this means 3/3 operations are validated.

### Task 4: Install Obsidian Plugins + Validate Visuals (~5 min)

**What:** Install Templater and Marp community plugins in Obsidian. Verify the base dashboard, canvases, and templates render.

**Steps:**
1. Install Templater:
   - Obsidian → Settings → Community plugins → Browse → search "Templater"
   - Install + Enable
   - Settings → Templater → Template folder: `templates`
2. Install Marp Slides:
   - Obsidian → Settings → Community plugins → Browse → search "Marp"
   - Install + Enable
3. Test Templater: Create a new note from template (Cmd+N → select template)
4. Test Marp: Open `decks/weekly-retro.md` → verify slide preview renders
5. Test Canvas: Open `canvases/team-org.canvas` → verify org chart displays
6. Test Canvas: Open `canvases/brain-architecture.canvas` → verify architecture diagram
7. Test Bases: Open `dashboards/scope-tracker.base` → verify scope table renders from frontmatter
8. Open `dashboards/sc-velocity.html` in browser → verify Chart.js renders

**Note:** Steps 1-2 require Jake's manual action in Obsidian GUI. Claude can't install plugins. The rest is visual verification.

**Success criteria:**
- [ ] Templater installed and templates folder set to `templates/`
- [ ] Marp installed and weekly-retro.md renders as slides
- [ ] team-org.canvas renders with all team members
- [ ] brain-architecture.canvas renders 3-layer diagram
- [ ] scope-tracker.base shows scope data (or we document if bases plugin can't query subfolder frontmatter and switch to Dataview)
- [ ] sc-velocity.html renders charts in browser

**Proves:** The Obsidian visualization layer is functional, not just syntactically correct files.

### Task 5: Fix Skipped Deliverables (~10 min)

**What:** Update `shared/brain.md` with Brain 2.0 section. Fix any stale hardcoded data found during Tasks 1-4.

**Steps:**
1. Read `shared/brain.md` — add a "Brain 2.0" section referencing the plan, three-layer model, three operations, compounding loop
2. Fix INDEX.md Quick Reference if brain-lint found it stale (Task 1 output)
3. Fix `decks/weekly-retro.md` — make it a proper template that reads from state.md rather than hardcoded data (or convert to Templater template)
4. Address `brand-strategy.md` 479-line violation — either split into sub-articles or mark as "raw source" (Layer 1, exempt from 200-line wiki cap)
5. Update plan status and acceptance criteria to reflect honest state
6. Commit all fixes

**Success criteria:**
- [x] `shared/brain.md` has Brain 2.0 section with link to plan
- [ ] INDEX.md Quick Reference — needs manual check (stale bug/scope counts possible)
- [x] brand-strategy.md explicitly exempted as Layer 1 raw source in INDEX.md
- [ ] Plan Phase 3a acceptance criteria — update needed
- [x] Changes committed (via Obsidian auto-sync)

---

## Acceptance Criteria

### Functional

- [x] `/brain-lint` produces a real health score (62/100)
- [x] `/brain-lint auto-fix` resolves at least one issue (3 orphans + line count)
- [x] `/brain-compile` processes a real document end-to-end (standup 2026-03-27)
- [x] Hetzner cron verified working (fixed: added ANTHROPIC_API_KEY sourcing)
- [x] Hetzner wiki sync verified (7 files in Marty workspace)
- [ ] Templater + Marp installed in Obsidian (Jake manual action needed)
- [ ] At least 3 of 6 Obsidian artifacts verified rendering correctly (Jake manual action needed)
- [x] `shared/brain.md` updated with Brain 2.0 section

### Quality Gates

- [ ] Audit score improvement: 6/10 → 8+/10 (re-audit after all tasks)
- [x] Compounding loop: 3/3 operations proven (lint: 62/100, ingest: standup filed, query: INDEX routing works)
- [x] log.md has real lint + ingest entries (not just init entries)
- [x] brain-health-history.md has a real score entry (62/100)

---

## Dependencies

| Dependency | Status | Blocks |
|-----------|--------|--------|
| SSH access to Hetzner | Available | Task 2 |
| Obsidian running locally | Available | Task 4 |
| Recent standup in standups/ | Check first | Task 3 |
| Obsidian community plugin access | Available | Task 4 |

## Risk Analysis

| Risk | Likelihood | Mitigation |
|------|-----------|-----------|
| /brain-lint prompt spec fails on edge cases | Medium | Fix issues live, update command spec |
| Hetzner `claude` CLI version is outdated | Low | `claude --version` first, upgrade if needed |
| No recent standup to test brain-compile | Medium | Use missions.md or priorities.md as fallback |
| bases plugin can't query subfolder frontmatter | Medium | Switch to Dataview if bases fails |
| brain-lint surfaces many issues that spiral scope | High | Fix only auto-fixable + top 3 manual issues. Don't rewrite anything. |

---

## Execution Order

```
Task 1: /brain-lint        → proves LINT operation
Task 2: Hetzner cron       → proves AUTOMATED lint
Task 3: /brain-compile     → proves INGEST operation  
Task 4: Obsidian plugins   → proves VISUALIZATION layer
Task 5: Fix deliverables   → closes GAPS from audit
```

Tasks 1-3 are sequential (each informs the next). Task 4 requires Jake's manual action in Obsidian. Task 5 depends on findings from Tasks 1-4.

---

## References

- [Brain 2.0 Plan](/Users/jakestein/tryps-docs/docs/plans/2026-04-04-feat-brain-2-self-compounding-knowledge-architecture-plan.md)
- [Audit Report](/Users/jakestein/tryps-docs/docs/plans/2026-04-05-fix-brain-2-hardening-validation-plan.md) (this file, audit pasted above)
- [brain-lint command](/Users/jakestein/.claude/commands/brain-lint.md)
- [compound command](/Users/jakestein/.claude/commands/compound.md)
- [brain-compile command](/Users/jakestein/.claude/commands/brain-compile.md)
