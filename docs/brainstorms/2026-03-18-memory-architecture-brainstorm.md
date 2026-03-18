# Memory Architecture Brainstorm

**Date:** 2026-03-18
**Status:** Approved — moving to implementation

## What We're Building

A unified memory system where tryps-docs becomes the shared brain across Jake's Claude sessions, Marty (OpenClaw on Hetzner), and the dev team. Every session starts informed. No cold starts, no re-explaining.

## Key Decisions

1. **Spec-only model.** Kill the 10-step pipeline artifacts. Each scope = one `spec.md` with frontmatter status. 216 files → 31.

2. **4 statuses** (aligned with workflow.md): `not-started`, `in-progress`, `ready-qa`, `failing`, `done`

3. **Status lives in spec.md frontmatter.** Devs, QA, Jake, and Marty all update it directly. Machine-parseable + human-readable.

4. **Global `~/.claude/CLAUDE.md` with `@import`** auto-loads shared state into every Claude session, any repo.

5. **`tryps-docs/shared/`** directory = shared brain. Files partitioned by writer to prevent merge conflicts.

6. **Unified tracker (STATUS.md)** — auto-generated, shows every scope with success criteria + status + assignee. Used in daily standup.

7. **Marty's `tryps-state-sync` skill** — parses spec frontmatter, generates state.md, detects changes, posts to Slack.

## Why This Approach

- tryps-docs is already synced between local and Hetzner via git — it's the natural bridge
- `@import` supports absolute paths (`@~/tryps-docs/...`) — zero friction cross-repo loading
- File-per-writer partitioning eliminates merge conflicts without infrastructure
- Frontmatter is both human-editable and machine-parseable
- 5-person team doesn't need a database — git + markdown is right-sized

## Architecture

```
tryps-docs/
  STATUS.md                    # Auto-generated: all scopes + criteria + status (standup view)
  scopes/
    p1-p5/{scope}/spec.md      # One file per scope, frontmatter has status
  shared/
    state.md                   # Compact index for @import (Marty generates)
    decisions.md               # Strategic decisions (Jake writes)
    priorities.md              # Sprint focus (Jake writes)
    team.md                    # Roster + assignments (Jake writes)
    observations.md            # Patterns + issues (Marty appends)

~/.claude/CLAUDE.md            # Global config with @import to shared/state.md + priorities.md
```

## Frontmatter Schema

```yaml
---
id: p1-scope-name
title: Human Readable Name
phase: p1
status: not-started
assignee: firstname
priority: 1
dependencies: []
blocked: false
---
```

## Who Writes What

| File | Writer | When |
|------|--------|------|
| spec.md (content) | Jake | At spec creation |
| spec.md (status field) | Devs / QA | On status change |
| shared/state.md | Marty (auto) | Every 30 min |
| shared/decisions.md | Jake (via Claude) | On decisions |
| shared/priorities.md | Jake (via Claude) | Weekly / on shift |
| shared/team.md | Jake (via Claude) | On roster changes |
| shared/observations.md | Marty (auto) | After PR reviews, standups |
| STATUS.md | Marty (auto) | After spec changes detected |

## Implementation Order

| # | Step | Time |
|---|------|------|
| 1 | Create `~/.claude/CLAUDE.md` with @import | 10 min |
| 2 | Create `tryps-docs/shared/` with initial state files | 30 min |
| 3 | Add frontmatter to all 22 spec.md files | 1 hr |
| 4 | Delete 164 empty placeholders + archive real artifacts | 30 min |
| 5 | Build `generate-status.sh` for STATUS.md (with criteria) | 30 min |
| 6 | Build Marty's `tryps-state-sync` skill | 2 hr |
| 7 | Update MC spec-parser.ts for frontmatter | 1 hr |
| 8 | Clean up orphaned worktree memory dirs | 15 min |

## Open Questions

- How should the unified tracker render? Markdown table in STATUS.md, or an HTML page like tracker/index.html?
- Should observations.md be date-sectioned (one file) or date-filed (one file per day)?
- Exact criteria_total/criteria_done: auto-counted by script, or manual in frontmatter?

## Next Step

Implement steps 1-5 now. Spec Marty's skill (step 6) and MC update (step 7) as separate scopes.
