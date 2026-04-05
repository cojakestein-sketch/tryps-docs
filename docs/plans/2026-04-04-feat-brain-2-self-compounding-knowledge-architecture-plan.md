---
title: "Brain 2.0: Self-Compounding Knowledge Architecture"
type: feat
date: 2026-04-04
status: active
owner: jake
---

# Brain 2.0: Self-Compounding Knowledge Architecture

## Overview

Transform the Tryps brain from a read-only reference system into a **persistent, compounding artifact** — a self-improving knowledge base where the wiki gets richer with every source added and every question asked.

Based directly on [Karpathy's LLM Wiki pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f): instead of rediscovering knowledge from scratch on every session (like RAG), the LLM incrementally builds and maintains a structured wiki. The knowledge is compiled once and kept current, not re-derived on every query.

**The core insight:** "The tedious part of maintaining a knowledge base is not the reading or the thinking — it's the bookkeeping." LLMs handle maintenance cost near-zero. Humans curate sources, direct analysis, and ask the right questions. The LLM does everything else.

**Applied to Tryps:** Obsidian is the IDE. Claude/Marty are the programmers. The wiki is the codebase. Jake curates and directs; the LLM maintains.

**Evolves from:** [[2026-03-18-memory-architecture-brainstorm|Memory Architecture Brainstorm]] (approved), [[shared/brain|Brain 1.0 Philosophy]], [[2026-03-26-feat-company-brain-state-pipeline-plan|State Pipeline Plan]] (Move 2 outstanding).

## Problem Statement

The brain today is a read-only encyclopedia. Sessions load ~1500 lines of shared state, do work, and the knowledge evaporates. Three structural gaps:

1. **No compounding loop.** Knowledge only enters the brain when Jake explicitly says "remember this." 90% of session learnings are lost.
2. **No self-healing.** Team roster exists in 3 places. Brand tokens drift between code and docs. 5 files are 5-17 days stale. Nobody catches it.
3. **No selective loading.** Every session loads everything. A brand task loads ClickUp IDs. A bug fix loads the brand guide. At 12+ shared files this becomes noise.

## Proposed Solution

Four phases, each independently valuable. Each phase ships something usable before the next starts.

```
Phase 1 (this week)     → Foundation: lint + compound + gotchas
Phase 2 (next week)     → Intelligence: INDEX + Marty wiki + compile
Phase 3 (before launch) → Agent layers: per-user KB + gotchas in agent + auto-lint
Phase 4 (parallel)      → Obsidian: Dataview + Canvas + Templater + Marp + HTML
```

---

## Technical Approach

### Karpathy's Three Layers (Applied to Tryps)

```
LAYER 1: RAW SOURCES (immutable — LLM reads, never modifies)
├── standups/           — daily standup transcripts
├── scopes/*/spec.md    — product specifications
├── marty/memory/*.md   — daily logs from Marty
├── docs/plans/         — strategic plans
├── Slack threads, meeting notes, customer interviews
└── Any new source: articles, research, voice memos

LAYER 2: THE WIKI (LLM-maintained — Jake reads, LLM writes)
├── shared/
│   ├── index.md        — content-oriented catalog of everything
│   ├── log.md          — append-only chronological record
│   ├── state.md        — auto-generated scope progress (existing)
│   ├── gotchas.md      — compiled behavioral rules by topic
│   ├── missions.md     — daily focus (Jake writes this one)
│   └── [topic pages]   — entity pages, concept pages, synthesis
├── marty/wiki/
│   ├── index.md        — Marty's wiki catalog
│   ├── team-patterns.md
│   ├── bug-taxonomy.md
│   ├── decisions-log.md
│   └── scope-intelligence.md
└── ~/.claude/projects/-Users-jakestein/memory/
    └── [individual memory files — the per-session knowledge layer]

LAYER 3: THE SCHEMA (co-evolved — tells LLM how to maintain the wiki)
├── ~/.claude/CLAUDE.md           — global schema: @imports, conventions, rules
├── ~/tryps-docs/shared/brain.md  — brain philosophy + operations guide
├── ~/tryps-docs/marty/AGENTS.md  — Marty's schema
└── ~/.claude/commands/           — operation commands (ingest, lint, query)
```

### Three Core Operations (from Karpathy)

| Operation | What it does | Tryps implementation |
|-----------|-------------|---------------------|
| **Ingest** | New source → LLM reads → writes summary → updates index → updates relevant pages → appends to log | `/brain compile` (external sources) + `/compound` (session learnings) + Marty post-standup sync |
| **Query** | Ask questions → LLM reads index → finds relevant pages → synthesizes answer → **files valuable answers back as new pages** | Normal Claude sessions. The key: good answers don't disappear into chat history — they compound. |
| **Lint** | Health-check → contradictions, stale claims, orphan pages, missing cross-refs, data gaps | `/brain-lint` (manual) + Marty weekly cron (automated) |

**The compounding loop:** Ingest makes the wiki richer. Query makes the wiki smarter (answers filed back). Lint makes the wiki healthier. Every interaction adds value.

### Two Special Files (from Karpathy)

**index.md** — content-oriented catalog. Every page listed with link, one-line summary, metadata. Organized by category. LLM reads index first to find relevant pages, then drills in. "This works surprisingly well at moderate scale (~100 sources, ~hundreds of pages) and avoids the need for embedding-based RAG infrastructure."

**log.md** — append-only chronological record. Each entry starts with parseable prefix: `## [2026-04-05] ingest | Source Title`. Gives timeline of wiki evolution. Enables `grep "^## \[" log.md | tail -5` for last 5 entries.

### Key Design Decisions

1. **Git-synced markdown stays.** No databases, no MCP memory servers. tryps-docs is the spine. "The wiki is just a git repo of markdown files. You get version history, branching, and collaboration for free." (Per [[memory-architecture-report|Memory Architecture Report]] Pattern A.)
2. **200-line caps.** MEMORY.md stays under 200 lines. INDEX.md under 50 lines. Individual wiki articles under 100 lines. (Per architecture report limits.)
3. **Write-back is gated.** Sessions propose writes via `/compound`, Jake confirms. No auto-commit from sessions. (Per architecture report: reduces noise.)
4. **One file per concern.** Karpathy: "just a collection of .md files in a directory structure." gotchas.md organized by topic sections. Wiki articles per concept/entity.
5. **LLM maintains the wiki, human rarely touches it.** "You never (or rarely) write the wiki yourself — the LLM writes and maintains all of it. You're in charge of sourcing, exploration, and asking the right questions." (Per brain.md: Friday brainscan calibration loop.)
6. **Obsidian is the IDE.** "I have the LLM agent open on one side and Obsidian open on the other. The LLM makes edits based on our conversation, and I browse the results in real time." Use `bases` core plugin first for structured views; install Dataview only if insufficient.
7. **log.md is sacred.** Append-only. Never edited, only appended. Every ingest, query, and lint pass gets logged. This is the wiki's history.

---

### Implementation Phases

#### Phase 1: Foundation (This Week)

**Goal:** Close the compounding loop. Every session can contribute back. Brain can self-diagnose.

##### 1a. `/brain-lint` slash command

**File:** `~/.claude/commands/brain-lint.md`

**What it does:**
- Reads all memory files (`~/.claude/projects/-Users-jakestein/memory/*.md`)
- Reads all shared state (`~/tryps-docs/shared/*.md`)
- Reads Marty's memory (`~/tryps-docs/marty/MEMORY.md`, `marty/memory/*.md`)
- Runs 7 health checks:

| Check | What it detects | Auto-fixable? |
|-------|----------------|---------------|
| **Staleness** | Files not updated in >7 days | No (report only) |
| **Redundancy** | Same fact in multiple files (team roster x3) | Yes (designate canonical, update others) |
| **Consistency** | CLAUDE.md team != memory/project_team_roster.md != shared/team.md | Yes (sync from canonical source) |
| **Orphans** | Memory files not in MEMORY.md index | Yes (add to index) |
| **Brand drift** | theme.ts hex values != brand.md hex values | No (report only) |
| **Feedback validity** | Feedback memories referencing patterns no longer in codebase | No (flag for review) |
| **Index freshness** | INDEX.md (Phase 2) out of date vs actual files | Yes (regenerate) |

**Output:** Structured report with health score (0-100), auto-fix suggestions, and manual review items.

**Auto-fix mode:** When run with `auto-fix` argument, applies all auto-fixable changes and commits.

**Convention:** Follows slash command pattern: YAML frontmatter, `$ARGUMENTS` for input, phases with gates, `## Rules` section. No AskUserQuestion for batch operation — report and fix.

##### 1b. `/compound` slash command (session-end compounding)

**File:** `~/.claude/commands/compound.md`

**What it does:**
- Scans the current conversation for:
  - Decisions made ("we decided X", "the approach is Y")
  - State changes ("updated team roster", "deadline changed to April 15")
  - New learnings ("discovered that Z causes issues")
  - Feedback patterns ("Jake corrected: don't do X")
- For each finding, proposes where it should be filed:
  - Decision → `shared/decisions.md` (append)
  - State change → relevant `shared/*.md` file (edit)
  - Learning → `~/.claude/projects/-Users-jakestein/memory/` (new or update)
  - Feedback → `~/.claude/projects/-Users-jakestein/memory/feedback_*.md` (new or update)
  - Gotcha → `shared/gotchas.md` (append to relevant section)
- Shows the proposed changes as a diff
- Jake confirms or skips each one
- Commits accepted changes
- Updates MEMORY.md index if new memory files created

**Not a hook.** This is a manual slash command, not an auto-trigger. Reason: the architecture report recommends gated write-back ("use gated `/flush-shared` command at session end, not write-on-observation"). Auto-hooks risk noisy commits on trivial sessions.

**Convention:** The existing `/winddown` command already has a session-end pattern. `/compound` complements it — run `/compound` then `/winddown`.

##### 1c. Compiled `shared/gotchas.md`

**File:** `~/tryps-docs/shared/gotchas.md`

**What it is:** A single compiled file replacing 23 scattered feedback memory files. Organized by topic. The canonical source of behavioral rules for all agents.

**Structure:**
```markdown
# Gotchas

> Compiled behavioral rules for all agents and sessions.
> Auto-maintained by /brain-lint. Manual edits will be overwritten.
> Source: ~/.claude/projects/-Users-jakestein/memory/feedback_*.md
> Last compiled: 2026-04-04

## Naming & Language
- Never use "crew" — Jake hates it
- App is Tryps (not Tripful, not Vamos)
- Don't lead with "Martin" character in pitches — just say "Tryps"
- "Your friends" or "your people" — never "crew"

## Workflow & Process
- Default branch is develop, not main; always branch from develop
- Every spec.md must end with a copy/paste kickoff prompt
- FRD step removed; everything lives in spec.md only
- Devs pursue API partnerships organically first; only escalate to Jake if blocked
- Stop asking for ClickUp API key — it's in ~/.zshrc

## Communication & Tone
- Standup questions should be firm but not mean
- Send PR review requests in #martydev (not DM), always include spec link
- Handoff prompts: @file refs, ## headers, explicit ## Your Task section

## Technical
- Always use absolute file paths so Jake can command-click to open
- Background is white/light gray (gray/50), NOT warm cream
- When debugging config, check ALL settings and present full diagnosis at once

## Agent-Specific
- If Marty says "no exec access" in DM, nuke session transcript and restart gateway
- Don't reveal expected answers in verification questions for Marty
- Always add Zoom link (no password, no waiting room) to every calendar event

## Tools & Environment
- Upwork: import cookies first, then browse; Cloudflare always blocks headless
- Auto-peek deliverable docs in cmux split pane after writing them
- All slash commands at global level (~/.claude/commands/)
```

**Compilation process:** `/brain-lint` reads all `feedback_*.md` files, deduplicates, categorizes by topic, and regenerates gotchas.md. Individual feedback files remain as the source of truth (with `**Why:**` context) — gotchas.md is the compiled view.

##### 1d. `shared/log.md` — append-only chronological record

**File:** `~/tryps-docs/shared/log.md`

The wiki's history. Every ingest, query-filed-back, lint pass, and significant event gets a single-line entry. Never edited, only appended. Parseable with grep.

**Format:**
```markdown
# Brain Log

> Append-only. Never edit existing entries. Parse: grep "^## \[" log.md | tail -10

## [2026-04-05] init | Brain 2.0 initialized
## [2026-04-05] ingest | Compiled 23 feedback memories into gotchas.md
## [2026-04-05] lint | Health score: 72/100 — 3 stale files, 2 redundancies
## [2026-04-05] compound | Session: brain infra — filed 4 decisions, 2 state changes
## [2026-04-06] ingest | Standup 2026-04-06 — SC: agent-intelligence 31/61
## [2026-04-07] query | "App Store blockers?" — filed as wiki/app-store-blockers.md
```

**Entry types:** `init`, `ingest`, `lint`, `compound`, `query`, `sync`, `fix`

**Who appends:** `/compound`, `/brain compile`, `/brain-lint`, Marty post-standup. Every operation logs itself.

**Why (Karpathy):** "The log gives you a timeline of the wiki's evolution and helps the LLM understand what's been done recently."

**Phase 1 acceptance criteria:**
- [x] `/brain-lint` runs and produces a health report with score
- [x] `/brain-lint auto-fix` syncs redundant copies and adds orphans to index
- [x] `/compound` proposes filing session learnings with diffs
- [x] `/compound` updates MEMORY.md when new files are created
- [x] `/compound` appends to `shared/log.md` after filing
- [x] `shared/gotchas.md` exists, compiled from all 20 feedback files
- [x] Gotchas organized by topic, deduplicated, with last-compiled timestamp
- [x] `shared/log.md` exists with parseable prefix format
- [x] `/brain-lint` can regenerate gotchas.md from source feedback files
- [x] `/brain-lint` appends to log.md after running

---

#### Phase 2: Intelligence Layer (Next Week)

**Goal:** Selective loading (smaller context), Marty institutional memory (compounds daily), raw-to-wiki compilation pipeline.

##### 2a. Auto-maintained `shared/INDEX.md`

**File:** `~/tryps-docs/shared/INDEX.md`

**What it is:** A ~40-line routing index. CLAUDE.md @imports INDEX.md instead of 5 full files. Sessions read the index, then pull only what they need.

**Structure:**
```markdown
# Brain Index

> Auto-maintained. Do not edit manually.
> Last updated: 2026-04-04 15:00 UTC

## Shared State Files

| File | Purpose | Updated | Lines |
|------|---------|---------|-------|
| [[state|state.md]] | Scope progress (13 scopes, SC counts) | 2026-04-04 | 28 |
| [[priorities|priorities.md]] | This week's focus by person | 2026-04-03 | 25 |
| [[missions|missions.md]] | Jake's daily missions + ongoing | 2026-04-04 | 90 |
| [[clickup|clickup.md]] | ClickUp workspace, IDs, workflow | 2026-04-04 | 128 |
| [[brand|brand.md]] | Brand tokens, typography, voice | 2026-03-25 | 154 |
| [[team|team.md]] | Team roster + contacts | 2026-04-04 | 131 |
| [[gotchas|gotchas.md]] | Behavioral rules for all agents | 2026-04-04 | 45 |
| [[brain|brain.md]] | Brain philosophy + strategy model | 2026-03-26 | 180 |

## Quick Reference

- **Team:** 11 people (3 dev + 3 QA + 1 product + 3 GTM + 1 creative director)
- **Scopes:** 13 total, 2 done, 5 in-progress, 1 testing, 3 specced
- **Deadlines:** Apr 15 (App Store), Apr 30 (launch ready)
- **Bugs:** 78 total, 68 fixed, 10 remaining

## What to Load When

| Task Type | Load These Files |
|-----------|-----------------|
| Dev work / bug fix | state.md, priorities.md |
| Spec writing | state.md, missions.md, brain.md |
| Brand / GTM | brand.md, team.md |
| Standup / planning | missions.md, priorities.md, state.md |
| Agent config | gotchas.md, brain.md |
| ClickUp / task mgmt | clickup.md, state.md |
```

**CLAUDE.md change:** Replace the 5 `@import` lines with:
```
@~/tryps-docs/shared/INDEX.md
@~/tryps-docs/shared/state.md
@~/tryps-docs/shared/missions.md
```

Keep state.md and missions.md as always-loaded (small, always relevant). Everything else loaded on demand via INDEX routing. This reduces default context from ~1500 lines to ~200 lines.

**Auto-maintenance:** `/brain-lint` regenerates INDEX.md by scanning all files in shared/ and reading their line counts + last-modified dates. The "Quick Reference" section is populated from state.md data.

##### 2b. Marty's compiled wiki (`marty/wiki/`)

**Directory:** `~/tryps-docs/marty/wiki/`

**What it is:** Marty's institutional memory that compounds. Unlike daily log files (point-in-time), wiki articles are living documents that get refined over time.

**Initial articles:**

| File | Purpose | Updated By |
|------|---------|-----------|
| `INDEX.md` | Auto-maintained index of all wiki articles | Marty (auto) |
| `team-patterns.md` | Observations about team velocity, work patterns, who performs best on what | Marty (after standups) |
| `bug-taxonomy.md` | Categorized bug patterns by scope, root cause, frequency | Marty (after QA) |
| `decisions-log.md` | Significant decisions with context, rationale, outcome | Marty + /compound |
| `scope-intelligence.md` | Cross-scope observations, dependency risks, integration notes | Marty (weekly) |
| `process-learnings.md` | What's working/not in the workflow — standup format, PR review, QA process | Marty (weekly) |

**How it compounds:**
1. After every standup sync, Marty appends raw observations to the relevant article
2. Weekly (Friday, before brainscan), Marty "compiles" — reads all articles, deduplicates, synthesizes, removes stale entries
3. The wiki gets tighter and more useful over time, not longer
4. Article line counts are tracked in INDEX.md — if any article exceeds 100 lines, split it

**Relationship to existing Marty memory:**
- `marty/memory/YYYY-MM-DD.md` (daily logs) = raw input, rotated every 14 days
- `marty/MEMORY.md` (curated) = promoted facts from daily logs
- `marty/wiki/` (compiled) = synthesized intelligence from patterns across many days

The daily files feed the wiki. The wiki feeds the brainscan. The brainscan feeds Jake's calibration. Jake's calibration feeds next week's questions. **This is the full compounding loop.**

##### 2c. `/brain compile` slash command

**File:** `~/.claude/commands/brain-compile.md`

**What it does:** Takes raw unstructured input and files it into the brain's wiki structure.

**Input types:**
- Standup transcript: extract SC counts, blockers, commitments → update scope state + wiki
- Meeting notes: extract decisions, action items → decisions-log + missions.md
- Voice memo transcript: extract ideas, feedback, priorities → appropriate shared files
- Research dump: summarize, categorize → new wiki article or append to existing
- Session output: same as /compound but for external text

**Process:**
1. Read the input (from `$ARGUMENTS` path or clipboard)
2. Classify content type (standup, meeting, research, feedback, mixed)
3. Extract structured data (decisions, facts, state changes, action items)
4. Propose filing locations with diffs
5. Jake confirms
6. Update indexes (shared/INDEX.md, marty/wiki/INDEX.md, MEMORY.md as needed)
7. Commit

**Convention:** Follows the same gated write-back pattern as `/compound`. Never auto-commits.

**Phase 2 acceptance criteria:**
- [x] `shared/INDEX.md` exists with file listing, quick reference, and "what to load when" routing
- [x] CLAUDE.md updated to @import INDEX.md + state.md + missions.md (instead of 5 files)
- [x] Default session context reduced from ~1500 to ~200 lines
- [x] `marty/wiki/` directory exists with 5 initial articles + INDEX.md
- [x] Marty's HEARTBEAT.md updated with post-standup wiki compilation step + Friday brain health check
- [x] `/brain compile` command exists and can process standup transcripts, meeting notes, research dumps
- [x] `/brain compile` proposes filing locations with diffs, requires confirmation
- [x] All indexes auto-update when new content is filed

---

#### Phase 3: Agent Knowledge Layers (Before Launch — April 15)

**Goal:** Agents maintain their own knowledge bases. The recommendation engine, iMessage agent, and Marty all benefit from compiled, persistent knowledge.

##### 3a. Per-user knowledge base for recommendations

**Location:** `~/t4/agent/knowledge/users/{user-id}.md` (in the app codebase, not tryps-docs)

**What it is:** A compiled profile for each Tryps user that the recommendation agent reads. Built from:
- Travel preferences stated in conversations
- Past trip history (destinations, dates, group size)
- Voting patterns (what they vote for/against)
- Friend dynamics (who they travel with, group roles)
- Price sensitivity signals

**Format:** Structured markdown with YAML frontmatter. Agent reads the index first, pulls relevant user profiles.

**How it compounds:** Every agent interaction that reveals a preference gets filed back. "I hate early flights" → added to preferences. "Always votes for the cheapest option" → added to patterns.

**Privacy:** User KBs live in the app repo (not tryps-docs) and are not synced to the docs brain. They're scoped to the agent's runtime.

##### 3b. iMessage agent gotchas integration

**What it is:** The iMessage agent's system prompt includes a `{{gotchas}}` template variable that injects the relevant section of `shared/gotchas.md`.

**How it works:**
1. At agent startup, read `shared/gotchas.md`
2. Extract the "Agent-Specific" + "Naming & Language" + "Communication & Tone" sections
3. Inject into the system prompt as behavioral rules
4. When a new gotcha is discovered (via /compound or /brain-lint), it's automatically available to the agent on next restart

**Benefit:** No more manually editing system prompts when you learn a new behavioral rule. File it once, it propagates everywhere.

##### 3c. Weekly automated brain-lint via Marty cron

**What it is:** Marty runs `/brain-lint` every Friday at 2 PM ET (before the brainscan) as part of the weekly routine.

**Added to HEARTBEAT.md:**
```
### Friday Brain Health Check (14:00 ET, before brainscan)

1. Run brain-lint with auto-fix
2. Regenerate shared/INDEX.md
3. Recompile shared/gotchas.md from feedback sources
4. Compile marty/wiki/ articles (deduplicate, synthesize, trim)
5. Generate health report
6. Post health score + key findings to #martydev
7. If health score < 80: flag specific issues for Jake review
```

**Health score tracking:** Marty appends the weekly score to `marty/wiki/brain-health-history.md` — a simple date + score + findings log. Over time, this shows whether the brain is getting healthier or degrading.

**Phase 3 acceptance criteria:**
- [ ] Per-user knowledge base structure defined in t4 agent directory
- [ ] At least one user KB compiled from real conversation data
- [ ] iMessage agent system prompt reads from gotchas.md (not hardcoded rules)
- [ ] New gotcha filed via /compound is available to agent on next restart
- [ ] Marty runs brain-lint every Friday automatically
- [ ] Brain health score tracked weekly in marty/wiki/brain-health-history.md
- [ ] Health score posted to #martydev with key findings

---

#### Phase 4: Obsidian Visualization Layer (Parallel — Any Time)

**Goal:** Jake opens Obsidian and sees live, queryable dashboards instead of manually-maintained tables. Following Karpathy (Obsidian as IDE) and Lex (interactive HTML outputs).

##### 4a. Obsidian `bases` dashboards (use core plugin first)

The `bases` core plugin is already enabled. It provides structured database views from YAML frontmatter without installing any community plugins.

**Dashboards to create:**

| Dashboard | Source | View Type |
|-----------|--------|-----------|
| Scope Tracker | `scopes/*/state.md` frontmatter | Table: scope, status, assignee, criteria, last_updated |
| Team Workload | `shared/team.md` + scope assignments | Table: person, scopes owned, SC progress |
| Brain Health | `marty/wiki/brain-health-history.md` | Table: date, score, top issue |
| Memory Index | `~/.claude/projects/*/memory/*.md` frontmatter | Table: name, type, description, freshness |

**If `bases` is insufficient:** Install Dataview community plugin. Dataview provides:
```dataview
TABLE status, assignee, criteria as "SC Progress"
FROM "scopes"
WHERE file.name = "state"
SORT status ASC
```

**Decision:** Try `bases` first for one dashboard (Scope Tracker). If it can't filter/sort on frontmatter fields, install Dataview. Don't install both.

##### 4b. Canvas boards

Obsidian Canvas is a core plugin (already enabled). Create:

| Canvas | Purpose | File |
|--------|---------|------|
| Team Org Chart | Visual org: who reports to whom, who owns what | `canvases/team-org.canvas` |
| Brain Architecture | Data flow diagram (raw → compile → wiki → query → lint) | `canvases/brain-architecture.canvas` |
| Sprint Board | Drag-and-drop scope cards with status colors | `canvases/sprint-board.canvas` |
| Dependency Map | Cross-scope dependency visualization | `canvases/dependency-map.canvas` |

**Convention:** Canvas files reference existing .md files as embedded cards. They don't duplicate content — they visualize relationships between existing documents.

##### 4c. Templater templates

**Install:** Templater community plugin (not yet installed).

**Templates directory:** `~/tryps-docs/templates/`

| Template | Trigger | Auto-fills |
|----------|---------|-----------|
| `scope-state.md` | New scope state file | Frontmatter with id, status, assignee, criteria, dates |
| `memory-entry.md` | New memory file | Frontmatter with name, description, type |
| `standup.md` | Daily standup | Date, team members, scope status table from state.md |
| `session-log.md` | Session start | Date, topic, decisions placeholder, learnings placeholder |
| `wiki-article.md` | New wiki article | Frontmatter, header format, parent backlink |

**Convention:** Templates use Templater's `tp.date.now()` and `tp.file.title` for dynamic content. Keep templates minimal — just the skeleton, not pre-filled content.

##### 4d. Marp slides for strategic reviews

**Install:** Marp community plugin (not yet installed).

**Slide decks to create:**

| Deck | Source | When Used |
|------|--------|-----------|
| Weekly Retro | state.md + priorities.md + missions.md | Friday brainscan |
| Strategic Roadmap | scope INDEX + state pipeline data | Investor meetings, team planning |
| State of Product | scope progress + bug counts + user feedback | Cameron's working sessions |
| Brain Health | brain-health-history + lint findings | Monthly brain review |

**Format:** Marp decks are just markdown with `---` slide separators and a YAML frontmatter `marp: true` flag. They live in `~/tryps-docs/decks/` and auto-render in Obsidian.

**Auto-generation:** `/brain compile` can output a Marp deck as a format option. "Compile this week's state into a retro deck."

##### 4e. Interactive HTML outputs (Lex-style)

Following Lex's approach: generate dynamic HTML with JS for sortable/filterable data exploration.

**Files:** Live in `~/tryps-docs/dashboards/` (already partially exists with exec dashboard).

| Output | What It Shows | Tech |
|--------|-------------|------|
| SC Velocity Chart | SC completion rate over time per scope | Chart.js or D3 |
| Bug Burn-Down | Open vs fixed bugs over time | Chart.js |
| Team Heatmap | Who's active on which scope (from git commits) | HTML table with color coding |
| Brain Health Timeline | Weekly health scores with trend line | Chart.js |

**Convention:** These are static HTML files generated by scripts or `/brain compile`. They can be viewed in a browser or embedded in Obsidian via iframe. The exec dashboard (`cojakestein-sketch.github.io/tryps-exec-dashboard/`) already follows this pattern — extend it.

**Phase 4 acceptance criteria:**
- [ ] At least one `bases` dashboard working (Scope Tracker from frontmatter)
- [ ] If `bases` insufficient, Dataview installed and one query dashboard working
- [ ] Team Org Chart canvas created with embedded team.md cards
- [ ] Brain Architecture canvas created showing data flow
- [ ] Templater installed with 5 templates in templates/ directory
- [ ] At least one Marp slide deck rendering (Weekly Retro)
- [ ] At least one interactive HTML output (SC Velocity or Bug Burn-Down)
- [ ] Jake can open Obsidian and see: org chart, scope progress, brain health — all from live data

---

## Alternative Approaches Considered

| Approach | Why Rejected |
|----------|-------------|
| **MCP memory server** | Overkill for 5-person team. Git-synced markdown is right-sized. (Per architecture report.) |
| **Vector database / RAG** | Karpathy explicitly notes "I thought I had to reach for fancy RAG, but the LLM has been pretty good about auto-maintaining index files." Our brain is ~400 files, not millions — indexes are sufficient. |
| **Auto-commit hook on session end** | Too noisy. Most sessions don't produce brain-worthy content. Gated `/compound` is better. |
| **Dataview over `bases`** | `bases` is a core plugin, already enabled, lower friction. Try it first. |
| **Separate knowledge base repo** | Defeats the purpose. tryps-docs IS the brain. Don't fragment. |
| **Database-backed dashboard** | The exec dashboard already uses static HTML rebuilt on push. Stay consistent. |

---

## Acceptance Criteria

### Functional Requirements

- [ ] `/brain-lint` produces health report with numeric score (0-100)
- [ ] `/brain-lint auto-fix` resolves redundancy, syncs copies, adds orphans to indexes
- [ ] `/compound` detects decisions, state changes, learnings from session context
- [ ] `/compound` proposes where to file each finding with diff preview
- [ ] `/brain compile` accepts raw text (standup, notes, research) and files into wiki
- [ ] `shared/gotchas.md` compiled from all feedback sources, organized by topic
- [ ] `shared/INDEX.md` auto-maintained with file listing and routing table
- [ ] `marty/wiki/` contains 6+ articles that compound after each standup sync
- [ ] CLAUDE.md context reduced from ~1500 to ~200 lines via INDEX routing
- [ ] Obsidian shows at least one live dashboard and one canvas board

### Non-Functional Requirements

- [ ] No shared file exceeds 200 lines (per architecture report cap)
- [ ] No wiki article exceeds 100 lines (split if larger)
- [ ] Write-back is always gated (human confirms before commit)
- [ ] No merge conflicts from concurrent writes (sectioned ownership maintained)
- [ ] Brain-lint runs in <30 seconds for full audit
- [ ] All auto-generated files marked "Do not edit manually" in header

### Quality Gates

- [ ] Brain health score consistently >80 after Phase 1
- [ ] Session context load time not perceptibly slower with INDEX routing
- [ ] Marty's weekly wiki compilation produces actionable insights (not just summaries)
- [ ] At least 5 sessions use /compound and successfully file learnings back

---

## Dependencies & Prerequisites

| Dependency | Status | Blocks |
|-----------|--------|--------|
| State pipeline working (state.md auto-generates) | Done | Phase 1 |
| CLAUDE.md @import pattern | Done | Phase 2 |
| Obsidian Git sync | Done | Phase 4 |
| Marty heartbeat running on Hetzner | Partial (implementation unclear) | Phase 3 |
| Obsidian `bases` plugin enabled | Done | Phase 4a |
| Templater plugin installation | Not done | Phase 4c |
| Marp plugin installation | Not done | Phase 4d |
| Per-user KB schema in t4 | Not done | Phase 3a |

---

## Risk Analysis & Mitigation

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|-----------|
| Over-engineering the compilation step | High | Wastes time before launch | Phase 1 is manual commands only. No automation until proven useful. |
| Merge conflicts from multiple writers | Medium | Blocks Marty or devs | Sectioned ownership. Wiki articles assigned to single writer. Pull-before-write. |
| MEMORY.md grows past 200 lines | Medium | Degrades session quality | /brain-lint enforces cap. Excess entries archived or compiled into wiki articles. |
| gotchas.md becomes a dumping ground | Low | Noise in agent prompts | Topic sections with max 5 items each. Linter removes stale entries. |
| Obsidian plugins break vault sync | Low | Jake can't view brain | Only install one plugin at a time. Test sync after each. Canvas and bases are core (no risk). |
| Marty wiki doesn't compound (just grows) | Medium | Defeats the purpose | Weekly compilation step explicitly deduplicates and synthesizes. Line count tracking in INDEX. |

---

## Resource Requirements

| Who | Phase 1 | Phase 2 | Phase 3 | Phase 4 |
|-----|---------|---------|---------|---------|
| **Jake + Claude** | Build 3 commands + gotchas | Build INDEX + /brain compile | Define agent KB schema | Install plugins, create canvases |
| **Marty** | — | Wiki setup + heartbeat update | Weekly auto-lint | — |
| **Devs** | — | — | Integrate gotchas into agent prompt | — |

**Estimated effort:**
- Phase 1: 2-3 hours (one session)
- Phase 2: 3-4 hours (one session)
- Phase 3: 4-6 hours (spread across sessions, some dev work)
- Phase 4: 2-3 hours per sub-item (can be done incrementally)

---

## Future Considerations

- **qmd for wiki search:** [qmd](https://github.com/tobi/qmd) is a local search engine for markdown with hybrid BM25/vector search and LLM re-ranking. Has both CLI (LLM shells out) and MCP server. Karpathy recommends it. At current scale (~100 files) index.md is sufficient, but as wiki grows past 200 pages, install qmd.
- **Synthetic data + finetuning:** Karpathy's natural extrapolation — as the wiki grows, consider finetuning a model on it so it "knows" Tryps in its weights. Post-launch territory.
- **Ephemeral wiki for deep research:** Lex's pattern — generate a focused mini-KB for a specific topic, load into voice mode for a run. Useful for investor prep or strategic thinking sessions.
- **Multi-agent wiki compilation:** Karpathy: "every question to a frontier grade LLM spawns a team of LLMs to automate the whole thing: iteratively construct an entire ephemeral wiki, lint it, loop a few times, then write a full report. Way beyond a .decode()." This is the brainscan endgame.
- **Cross-team brain:** When Tryps grows beyond 10 people, the brain needs access control. Who can read/write which wiki sections?
- **Obsidian Web Clipper:** Browser extension for quickly converting web articles to markdown sources. Karpathy recommends for ingesting articles into raw/ collection.

---

## Files to Create

| File | Phase | Type |
|------|-------|------|
| `~/.claude/commands/brain-lint.md` | 1 | Slash command |
| `~/.claude/commands/compound.md` | 1 | Slash command |
| `~/tryps-docs/shared/gotchas.md` | 1 | Compiled reference |
| `~/tryps-docs/shared/log.md` | 1 | Append-only chronological record |
| `~/tryps-docs/shared/INDEX.md` | 2 | Auto-maintained index |
| `~/.claude/commands/brain-compile.md` | 2 | Slash command |
| `~/tryps-docs/marty/wiki/INDEX.md` | 2 | Auto-maintained index |
| `~/tryps-docs/marty/wiki/team-patterns.md` | 2 | Wiki article |
| `~/tryps-docs/marty/wiki/bug-taxonomy.md` | 2 | Wiki article |
| `~/tryps-docs/marty/wiki/decisions-log.md` | 2 | Wiki article |
| `~/tryps-docs/marty/wiki/scope-intelligence.md` | 2 | Wiki article |
| `~/tryps-docs/marty/wiki/process-learnings.md` | 2 | Wiki article |
| `~/tryps-docs/marty/wiki/brain-health-history.md` | 3 | Tracking log |
| `~/tryps-docs/templates/scope-state.md` | 4 | Template |
| `~/tryps-docs/templates/memory-entry.md` | 4 | Template |
| `~/tryps-docs/templates/standup.md` | 4 | Template |
| `~/tryps-docs/templates/session-log.md` | 4 | Template |
| `~/tryps-docs/templates/wiki-article.md` | 4 | Template |
| `~/tryps-docs/canvases/team-org.canvas` | 4 | Canvas board |
| `~/tryps-docs/canvases/brain-architecture.canvas` | 4 | Canvas board |
| `~/tryps-docs/decks/weekly-retro.md` | 4 | Marp deck |

## Files to Modify

| File | Phase | Change |
|------|-------|--------|
| `~/.claude/CLAUDE.md` | 2 | Replace 5 @imports with INDEX.md + state.md + missions.md |
| `~/tryps-docs/marty/HEARTBEAT.md` | 2, 3 | Add post-standup wiki step + Friday brain-lint |
| `~/tryps-docs/shared/brain.md` | 1 | Add "Brain 2.0" section referencing this plan |
| `~/tryps-docs/.obsidian/community-plugins.json` | 4 | Add templater, marp |

---

## References

### Internal
- [[2026-03-18-memory-architecture-brainstorm|Memory Architecture Brainstorm]] — approved foundation
- [[shared/brain|Brain 1.0 Philosophy]] — strategic intelligence model
- [[2026-03-26-feat-company-brain-state-pipeline-plan|State Pipeline Plan]] — Move 2 outstanding
- [[archive/docs/memory-architecture-report|Memory Architecture Report]] — Pattern A, 200-line caps, write-back gating

### External
- [Karpathy's LLM Wiki gist](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) — the canonical pattern this plan implements (three layers, three operations, index + log)
- Karpathy's LLM Knowledge Bases post (X, April 2 2026) — the original tweet thread
- Lex Fridman's response — interactive HTML outputs, mini-KB for voice mode, dynamic data visualization
- jumperz thread — "agents that own their own knowledge layer do not need infinite context windows"
- [qmd](https://github.com/tobi/qmd) — local markdown search engine (BM25/vector hybrid) recommended by Karpathy for larger wikis

### Related Work
- State pipeline (shared/state.md auto-generation): implemented, running
- Obsidian wiki links (150+ links across 47 files): implemented
- Marty memory-distill skill: implemented, available for extension
- Executive dashboard (GitHub Pages): implemented, auto-rebuilds on push
