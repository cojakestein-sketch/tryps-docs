# Brain 2.0 — Executive Summary

**Date:** April 5, 2026
**Status:** Live

---

## What We Built

A self-compounding knowledge system for Tryps. Based on Karpathy's LLM Wiki pattern — instead of rediscovering context from scratch every session, the LLM incrementally builds and maintains a structured wiki. Knowledge is compiled once and kept current.

**Before:** Sessions loaded ~1,500 lines of static context. 90% of learnings evaporated between sessions. No self-healing. No history.

**After:** Sessions load ~160 lines via a routing index. Three operations keep the brain alive: ingest (new knowledge in), query (sessions read + file back), lint (self-diagnose + auto-fix). Every session can contribute back. Marty auto-maintains it weekly.

---

## What's Running

| Component | What It Does | Where |
|-----------|-------------|-------|
| `/brain-lint` | Health check — staleness, orphans, drift, consistency. Score 0-100. | Any Claude session |
| `/compound` | Session-end filing — decisions, learnings, state changes → brain | Any Claude session |
| `/brain-compile` | Raw input (standups, notes, research) → structured wiki entries | Any Claude session |
| `shared/INDEX.md` | Routing index — tells sessions what to load and when | Auto-loaded every session |
| `shared/gotchas.md` | 20 behavioral rules compiled from memory files | Auto-available to all agents |
| `shared/log.md` | Append-only timeline of every brain operation | Append-only |
| `marty/wiki/` | 6 wiki articles Marty compounds after standups | Hetzner, auto-synced |
| Friday cron | Marty runs brain-lint auto-fix every Friday 2 PM ET | Hetzner (`0 18 * * 5`) |
| Obsidian dashboards | Scope tracker, org chart, architecture diagram, SC velocity | Open Obsidian |

**First health score:** 62/100 (3 orphans fixed, brand drift flagged, 6 stale files identified)

---

## What You Need To Do

### Daily (takes 10 seconds)
- Nothing changes. Work normally. The brain loads itself.

### End of meaningful sessions
- Run `/compound` before closing. It scans the conversation, proposes what to file, you confirm or skip. Takes 30 seconds.

### Weekly (Friday, before brainscan)
- Marty runs brain-lint automatically. Check `#martydev` for the health score.
- If score < 80, Marty flags what needs attention.

### When you learn something new
- If it's a behavioral rule ("don't do X"): it gets filed to `gotchas.md` via `/compound`
- If it's a decision or state change: it gets filed to the wiki via `/compound`
- If you have raw content to process (standup, meeting notes, research): run `/brain-compile`

### Obsidian quick reference
- `Cmd+O` → quick open any file by name
- `team-org` → org chart canvas
- `brain-arch` → architecture diagram
- `scope-tracker` → live scope dashboard from frontmatter
- `weekly-retro` → slide deck (Marp)
- Open `dashboards/sc-velocity.html` in browser for charts

---

## Architecture (One Diagram)

```
Raw Sources (standups, specs, interviews)
    ↓ /brain-compile, /compound
The Wiki (shared/*.md, marty/wiki/*.md, memory/*.md)
    ↓ Normal sessions read INDEX.md → drill in
Query (good answers filed back via /compound)
    ↓ /brain-lint (manual + Friday cron)
Lint → health score → auto-fix → the wiki gets healthier
    ↓
Repeat. Every cycle, the brain gets richer.
```

---

## Key Numbers

- **Context reduction:** 1,500 → 160 lines loaded per session
- **Operations validated:** 3/3 (ingest, query, lint)
- **Wiki articles:** 6 (team-patterns, bug-taxonomy, decisions-log, scope-intelligence, process-learnings, brain-health-history)
- **Behavioral rules compiled:** 20 (from 20 feedback memory files)
- **Obsidian artifacts:** 2 canvases, 1 base dashboard, 5 templates, 1 Marp deck, 1 HTML dashboard
- **Commits:** 7 across Phases 1-4 + hardening
