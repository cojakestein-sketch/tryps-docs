# Multi-Agent Shared Memory Architecture Report

**Date:** 2026-03-18
**For:** Tryps team (Jake, Marty, Claude Code sessions)
**Scope:** Persistent shared memory across human + autonomous agent + ephemeral sessions

---

## Executive Summary

After researching current patterns across the Claude Code ecosystem, OpenClaw documentation, the Spine Pattern, and multi-agent memory architectures, the recommendation is:

**Use tryps-docs as a lightweight "spine" with three layers:**
1. A single `STATE.md` file (under 150 lines) that every session auto-loads via `@import`
2. Per-scope `spec.md` files with frontmatter as the canonical status source
3. A `memory/` directory in tryps-docs for shared observations, decisions, and context that loads on-demand

This avoids new infrastructure, works with git sync, respects Claude Code's 200-line memory limit, and can be implemented in an afternoon.

---

## 1. How Teams Share Context Between Autonomous Agents and Ephemeral Sessions

### The Problem (Confirmed by Research)

The "cold start" problem is the dominant challenge in multi-agent setups. Every new Claude Code session starts with zero context beyond what's in CLAUDE.md and MEMORY.md. Meanwhile, Marty accumulates context 24/7 but has no way to surface it to Jake's sessions.

### What Works in Practice

**Pattern A: Git-synced shared state file (recommended for Tryps)**

The most battle-tested approach for small teams is a single markdown state file in a shared git repo. Both the autonomous agent and ephemeral sessions read from and write to this file. The git repo acts as the synchronization layer.

How it works:
- Marty pushes state updates to tryps-docs after meaningful events (PR reviews, standup generation, bug triage)
- Jake's Claude sessions read state from tryps-docs via `@import` in CLAUDE.md
- Merge conflicts are avoided through structural conventions (see Section 2)

This is essentially what the Spine Pattern and the meta-repo pattern both converge on, just at different scales.

**Pattern B: MCP-based memory bridge**

More sophisticated teams build MCP servers that expose `load_context` and `write_observation` tools. The agent calls these tools to read/write shared state through an API rather than files. This is overkill for a 5-person team but worth noting for later.

**Pattern C: Shared SQLite with markdown exports**

Some OpenClaw setups use SQLite as the primary store and export markdown summaries on a schedule. Marty already has a 33MB SQLite DB. The problem is that Claude Code sessions cannot query SQLite at session start -- they need plain text.

### Recommendation for Tryps

Use Pattern A. tryps-docs is already git-synced between Jake's machine and Marty's server. Add a `STATE.md` file that both actors maintain. Claude Code sessions load it via `@import`. No new infrastructure required.

---

## 2. Git-Based Shared Memory: Best Practices

### Merge Conflict Prevention

The number one rule from every source: **never have two writers edit the same line.**

Practical strategies that work:

**Strategy 1: Sectioned ownership**
Divide the shared state file into sections with clear owners. Marty writes to "Agent Observations" and "Recent Activity." Jake/Claude writes to "Priorities" and "Decisions." Sections are separated by markdown headers, and each writer only touches their own section.

**Strategy 2: Append-only logs with rotation**
For observations and activity, use append-only daily log files (`memory/2026-03-18.md`). Multiple writers appending to different files never conflict. A weekly rotation archives old logs.

**Strategy 3: One file per entity (scopes)**
Each scope has its own `spec.md`. Two writers rarely edit the same scope simultaneously. Frontmatter status changes (`status: to-be-built` to `status: ready-for-testing`) are single-line edits that auto-merge cleanly when they're on different files.

**Strategy 4: Pull before write, commit immediately**
Both Marty's sync script and Claude sessions should `git pull --rebase` before any write, then commit and push immediately after. Small, atomic commits.

### Write Frequency

Research consensus:

| Actor | Frequency | Trigger |
|-------|-----------|---------|
| Marty (autonomous) | After meaningful events | PR review complete, standup generated, bug triaged, scope status change |
| Claude Code (ephemeral) | End of session only | Via `/flush` command or manual write-back |
| Developers | On status change | Moving scope from `to-be-built` to `ready-for-testing` |
| Jake | As needed | Priority changes, strategic decisions |

Marty should NOT commit after every conversation turn. Batch observations and commit 3-5 times per day maximum. The Ian Paterson memory architecture research confirms that "write-on-meaningful-event" beats "write-on-schedule" for reducing noise.

### File Structure Recommendation

```
tryps-docs/
  STATE.md                    # <150 lines, auto-loaded by all sessions
  scopes/
    tracker.md                # Summary table (auto-generated from spec frontmatter)
    p1/
      core-flows/spec.md      # Canonical. Frontmatter has status.
      notifications-voting/spec.md
      ...
    p2/...
    p3/...
    p4/...
    p5/...
  memory/                     # Shared observations and context
    decisions.md              # Recent strategic decisions with dates
    observations.md           # Marty's observations, agent insights
    team.md                   # Who's on what, availability, blockers
    2026-03-18.md             # Daily activity log (append-only)
    2026-03-17.md
    archive/                  # Rotated old daily logs
  mission-control/            # MC integration docs
  designs/
  ...
```

### Frontmatter Convention for spec.md

```yaml
---
feature: Notifications & Voting
phase: p1
scope-id: p1-notifications-voting
status: to-be-built          # to-be-built | ready-for-testing | tested-confirmed | tested-failed
owner: Nadeem
updated: 2026-03-18
updated-by: marty             # marty | jake | asif | nadeem | andreas
---
```

Machine-readable (Marty and Mission Control can parse YAML frontmatter), human-readable (devs can update status by editing one line), and git-friendly (single-line changes merge cleanly).

---

## 3. The Spine Pattern and Meta-Repo Context

### What the Spine Pattern Is

Coined by Titus Soporan, the Spine Pattern is a lightweight meta-repository that sits above your actual codebases. It is NOT a monorepo or git submodules. It is a context orchestration layer.

Core components:
- **Workspace-level CLAUDE.md** that maps how projects interconnect
- **Task files** with prefixes (`be-`, `fe-`, `x-`) for routing
- **Cross-cutting docs** for anything spanning multiple repos

A related pattern described by Seylox adds `repos.yaml` for machine-readable config, an `active-work/` directory with epic tracking, and `conventions/` for cross-repo standards.

### Does It Fit Tryps?

**Partially, but you don't need the full pattern.** The Spine Pattern is designed for 6+ repos with mixed languages and multiple agents working in parallel. Tryps has 3 repos and one autonomous agent.

What to adopt from the Spine Pattern:
- **The idea that tryps-docs IS the spine.** It already sits above t4 and mission-control as the shared context layer. Treat it explicitly as such.
- **Cross-cutting state in the spine, not in individual repos.** Scope statuses, priorities, team context -- all live in tryps-docs.
- **CLAUDE.md hierarchy.** Global (`~/.claude/CLAUDE.md`) for Jake's preferences, per-repo (`t4/CLAUDE.md`) for codebase rules, tryps-docs state loaded via `@import`.

What to skip:
- `repos.yaml` machine config (unnecessary with 3 repos)
- Task prefix routing (`be-`, `fe-`, `x-`) (your scope IDs already handle this)
- Active-work epic tracking (your spec.md files serve this purpose)

### Implementation

tryps-docs becomes the spine by adding STATE.md and memory/. No structural overhaul needed. The existing scope structure already provides the task tracking that Spine Pattern recommends.

---

## 4. Claude Code @import and Cross-Repo Context Loading

### How @import Works

From the official Claude Code documentation:

- CLAUDE.md files support `@path/to/import` syntax
- **Both relative and absolute paths are allowed**
- Relative paths resolve relative to the file containing the import, NOT the working directory
- Imported files can recursively import other files, max depth of 5 hops
- The first time external imports appear, Claude shows an approval dialog

### Cross-Repo References: Confirmed Working

The official docs explicitly show importing from the home directory:

```markdown
# Individual Preferences
- @~/.claude/my-project-instructions.md
```

This means from `t4/CLAUDE.md`, you CAN reference:
```markdown
@~/tryps-docs/STATE.md
```

This is the key mechanism. Jake's t4 CLAUDE.md can import shared state from tryps-docs without symlinks, submodules, or any other infrastructure.

### The --add-dir Alternative

Claude Code also supports `--add-dir` for multi-directory access:
```bash
CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1 claude --add-dir ~/tryps-docs
```

This loads tryps-docs CLAUDE.md alongside t4's. However, it requires remembering to pass the flag every time. The `@import` approach is more reliable since it's baked into the CLAUDE.md file.

### Recommended Setup

**In `t4/CLAUDE.md`, add:**
```markdown
# Shared Context
@~/tryps-docs/STATE.md
```

**In `~/mission-control/CLAUDE.md`, add:**
```markdown
# Shared Context
@~/tryps-docs/STATE.md
```

**In `~/.claude/CLAUDE.md` (create this for Jake's global config):**
```markdown
# Jake's Global Preferences
- Default branch is develop, not main
- Keep slash commands at global level (~/.claude/commands/)
- The app is called Tryps (not Tripful, not Vamos)

# Shared Team State
@~/tryps-docs/STATE.md
```

NOTE: Putting the import in `~/.claude/CLAUDE.md` means EVERY Claude session Jake opens, in any repo, automatically gets the shared state. This is the strongest option. The per-repo import is a fallback for cases where the global import feels too noisy.

### Limitations

1. **Absolute paths are machine-specific.** `@~/tryps-docs/STATE.md` works on Jake's Mac but not on Marty's server (different home directory). This is fine because Marty uses OpenClaw's own memory system, not Claude Code.
2. **External imports require one-time approval.** The first time Claude encounters an import outside the repo, it shows a dialog. After approval, it remembers.
3. **Max 5 hops.** STATE.md can import other files, but the chain can't exceed 5 levels deep.
4. **File changes require git pull.** If Marty updates STATE.md on the server, Jake's session won't see it until `git pull` runs on tryps-docs locally.

---

## 5. Memory Size Constraints

### Hard Limits

| File | Limit | Behavior |
|------|-------|----------|
| MEMORY.md (auto-memory) | **200 lines** | Lines beyond 200 are silently truncated at session start |
| CLAUDE.md | No hard limit, but **200 lines recommended** | Longer files consume context and reduce adherence |
| @imported files | Count toward CLAUDE.md's effective size | Each import adds to total context consumption |
| Total context window | 200K tokens, but ~30-40K consumed by system prompt/tools | Effective ~160K, degradation starts at ~147K |

### Practical Implications for STATE.md

STATE.md will be loaded into every session via @import. It needs to be concise enough that it doesn't crowd out actual work context. Based on research:

**Target: 100-150 lines for STATE.md.** This leaves plenty of room in the CLAUDE.md budget and auto-memory budget.

What fits in 150 lines:
- Team roster and current assignments (10 lines)
- Active priorities and strategic direction (15 lines)
- All 22 scope statuses in compact table format (30 lines)
- Recent decisions with dates (20 lines)
- Current blockers and open questions (10 lines)
- Marty's recent observations (15 lines)
- Cross-repo state notes (10 lines)
- Headers, spacing, frontmatter (20 lines)
- Buffer (20 lines)

### How to Keep It Lean

The Ian Paterson memory architecture (proven at scale) uses three techniques:

1. **Date-stamped entries with rotation.** Every entry gets `[YYYY-MM-DD]`. Weekly, entries older than 14 days get archived to `memory/archive/`. This prevents unbounded growth.

2. **Index + detail split.** STATE.md contains one-line summaries. Detailed context lives in `memory/decisions.md`, `memory/observations.md`, etc. Claude reads those on-demand when it needs depth.

3. **Canonical locations.** Each fact lives in exactly one place. Scope status lives in spec.md frontmatter. Team roster lives in `memory/team.md`. STATE.md references them but doesn't duplicate them.

### Recommendation

STATE.md should be a **routing index**, not an encyclopedia. Think of it as a dashboard, not a database:

```markdown
---
updated: 2026-03-18
updated-by: marty
---

# Tryps Shared State

## Team
See @memory/team.md for full roster. Key: Asif=lead, Nadeem+Arslan+Krisna=dev, Andreas=QA.

## Current Priority
P1 core flows and P2 payments. P3 blocked on hire. P4 deprioritized.

## Scope Status (22 total)
| Phase | Scope | Status | Owner |
|-------|-------|--------|-------|
| P1 | Core Flows | to-be-built | Asif |
| P1 | Notifications | to-be-built | Nadeem |
...
(compact table, one line per scope)

## Recent Decisions [last 14 days]
- [2026-03-18] Simplified lifecycle to 4 statuses. Old 10-step pipeline is dead.
- [2026-03-18] spec.md frontmatter is the canonical status source.
- [2026-03-17] P4 deprioritized until P1 core flows ship.

## Blockers
- P3 dev slot is OPEN. Cannot start agent layer until hire.
- MC API returns 403 without x-original-host header (workaround in place).

## Marty's Recent Observations
- [2026-03-18] 14 of 22 scopes still need spec or criteria.
- [2026-03-17] PR velocity: 3 PRs merged this week, all in p1-notifications.
```

This is around 60-80 lines depending on the scope table, well within budget.

---

## 6. Write-Back Patterns for Ephemeral Sessions

### The Noise Problem

If every Claude Code session writes observations back to shared state, you get:
- Frequent git commits with low-value changes
- Merge conflicts from parallel worktrees
- STATE.md bloat from unfiltered observations
- Noise that drowns out signal

### What Works: The Flush Pattern

The proven pattern (from both OpenClaw's architecture and Ian Paterson's system) is **flush-on-exit, not write-on-observation:**

1. **During the session:** Claude accumulates observations in local auto-memory (MEMORY.md) only. No shared state writes during active work.

2. **At session end:** A deliberate flush writes high-value observations to shared state. This can be:
   - Manual: Jake reviews what to share ("remember this decision for the team")
   - Semi-automatic: A `/flush-shared` command that asks Claude to identify session highlights worth sharing
   - Gated: Claude proposes what to write; Jake approves before commit

3. **Importance filter:** Only write observations that would change someone else's behavior. Good: "We discovered the invite flow breaks on Android 14 -- filed as issue #247." Bad: "Read through the auth context file."

### Recommended Write-Back Rules

| Actor | Writes To | When | Filter |
|-------|-----------|------|--------|
| Marty | STATE.md "Observations" section | After PR reviews, standups, bug triage | Only actionable insights |
| Marty | spec.md frontmatter | When scope status changes | Status changes only |
| Marty | memory/YYYY-MM-DD.md daily log | After any meaningful event | Append-only, no filter |
| Jake (Claude session) | STATE.md "Decisions" section | When strategic decisions made | Decisions that affect others |
| Jake (Claude session) | spec.md frontmatter | When scope status changes | Status changes only |
| Developers | spec.md frontmatter | When moving scope to ready-for-testing | Status changes only |
| Andreas (QA) | spec.md frontmatter | When marking tested-confirmed or tested-failed | Status changes only |

### Implementation: /flush-shared Command

Create `~/.claude/commands/flush-shared.md`:

```markdown
Review this session and identify:
1. Any DECISIONS made that would affect other team members or Marty
2. Any BLOCKERS discovered that should be tracked
3. Any SCOPE STATUS changes that should be reflected in spec.md frontmatter
4. Any OBSERVATIONS that would change how someone else works

For each item, propose the exact edit to the appropriate file in ~/tryps-docs/.
Show me the proposed changes. Do not write until I approve.

Rules:
- Write decisions to ~/tryps-docs/STATE.md under "## Recent Decisions"
- Write blockers to ~/tryps-docs/STATE.md under "## Blockers"
- Write status changes to the relevant spec.md frontmatter
- Write observations to ~/tryps-docs/memory/YYYY-MM-DD.md (today's date)
- Always git pull ~/tryps-docs before writing
- Always git commit and push after writing
- Date-stamp every entry with [YYYY-MM-DD]
- Keep entries to ONE LINE each in STATE.md
```

---

## 7. Concrete Architecture Recommendation

### The Full Picture

```
Jake's Machine                          Marty's Server (Hetzner)
--------------                          -----------------------

~/.claude/
  CLAUDE.md          (global prefs)
  commands/
    flush-shared.md  (write-back cmd)
  projects/
    .../memory/
      MEMORY.md      (personal, 200-line cap)

~/t4/                                   (Marty doesn't access t4)
  CLAUDE.md          (@imports STATE.md)
  ...app code...

~/tryps-docs/        <-- git sync -->   ~/tryps-docs/
  STATE.md                                STATE.md
  scopes/                                 scopes/
    tracker.md                              tracker.md
    p1/.../spec.md                          p1/.../spec.md
    p2/.../spec.md                          p2/.../spec.md
    ...                                     ...
  memory/                                 memory/
    decisions.md                            decisions.md
    observations.md                         observations.md
    team.md                                 team.md
    2026-03-18.md                           2026-03-18.md

~/mission-control/                      ~/mission-control/  (Docker)
  CLAUDE.md          (@imports STATE.md)  reads spec.md frontmatter
```

### Context Loading Chain

When Jake opens Claude Code in `~/t4/`:

1. Claude loads `~/.claude/CLAUDE.md` (global) -- includes `@~/tryps-docs/STATE.md`
2. Claude loads `~/t4/CLAUDE.md` (project) -- coding rules, stack info
3. Claude loads auto-memory from `~/.claude/projects/-Users-jakestein-t4/memory/MEMORY.md` (personal, first 200 lines)
4. Result: Jake's session knows team state, scope statuses, recent decisions, AND the codebase rules. Zero manual effort.

When Marty runs a task:

1. OpenClaw reads its workspace MEMORY.md (330 lines of product knowledge)
2. OpenClaw can `memory_search` its SQLite DB for deep context
3. Marty reads `~/tryps-docs/STATE.md` and relevant `spec.md` files as needed
4. Marty writes back to STATE.md and spec.md, then `git push`

### Migration Steps (In Order)

**Phase 1: Create the shared state layer (Day 1, ~2 hours)**

1. Create `~/tryps-docs/STATE.md` with the compact format shown in Section 5
2. Create `~/tryps-docs/memory/` directory with `decisions.md`, `observations.md`, `team.md`
3. Populate STATE.md from current tracker.md and Jake's existing MEMORY.md entries
4. Populate team.md from `project_team_roster.md` in Jake's auto-memory

**Phase 2: Wire up auto-loading (Day 1, ~30 minutes)**

5. Create `~/.claude/CLAUDE.md` with Jake's global preferences + `@~/tryps-docs/STATE.md`
6. Add `@~/tryps-docs/STATE.md` to `~/t4/CLAUDE.md` (belt + suspenders)
7. Add `@~/tryps-docs/STATE.md` to `~/mission-control/CLAUDE.md`
8. Test: open Claude in t4, verify it loads shared state

**Phase 3: Set up write-back (Day 1, ~30 minutes)**

9. Create `~/.claude/commands/flush-shared.md` per Section 6
10. Test: run `/flush-shared` at end of a session, verify it proposes reasonable edits

**Phase 4: Wire up Marty (Day 2, coordinate with Marty's config)**

11. Update Marty's sync script to `git pull` tryps-docs before each task cycle
12. Add instructions to Marty's workspace MEMORY.md: "Read ~/tryps-docs/STATE.md at the start of each task. Update it after PR reviews and scope status changes."
13. Configure Marty to write to `memory/YYYY-MM-DD.md` for daily observations
14. Test: have Marty review a PR, verify STATE.md updates and pushes

**Phase 5: Simplify scope files (Day 2-3)**

15. Add YAML frontmatter to all spec.md files that lack it (the `status`, `owner`, `updated`, `updated-by` fields)
16. Delete or archive the old pipeline artifacts (10 files per scope down to 1)
17. Update tracker.md to be auto-generated from spec.md frontmatter (a script Marty runs)

**Phase 6: Mission Control integration (Day 3-4)**

18. MC reads spec.md frontmatter from tryps-docs via git (Marty already syncs it)
19. The `/criteria` page parses YAML frontmatter from all spec.md files
20. Webhook on tryps-docs push triggers MC refresh (or poll on 5-minute interval)

### What NOT to Do

- **Don't build an MCP memory server.** Overkill for 5 people and 3 repos.
- **Don't use git submodules.** They add complexity and break worktree workflows.
- **Don't put shared state in SQLite.** Claude Code can't query it at session start.
- **Don't duplicate state across repos.** Canonical source is tryps-docs. Everything else imports from it.
- **Don't let STATE.md grow past 150 lines.** Rotate decisions older than 14 days to `memory/archive/`.
- **Don't auto-commit from every Claude session.** Use the gated `/flush-shared` pattern.

---

## 8. Shared vs. Personal Memory Boundaries

### What Goes Where

| Category | Location | Who Reads | Who Writes |
|----------|----------|-----------|------------|
| Scope statuses | `tryps-docs/scopes/*/spec.md` frontmatter | Everyone | Devs, QA, Marty |
| Team assignments | `tryps-docs/memory/team.md` | Everyone | Jake |
| Strategic priorities | `tryps-docs/STATE.md` | Everyone | Jake |
| Recent decisions | `tryps-docs/STATE.md` | Everyone | Jake, Claude sessions |
| Agent observations | `tryps-docs/memory/observations.md` | Everyone | Marty |
| Daily activity | `tryps-docs/memory/YYYY-MM-DD.md` | On-demand | Marty, Jake |
| Jake's preferences | `~/.claude/CLAUDE.md` | Jake's sessions only | Jake |
| Jake's session learnings | `~/.claude/projects/.../memory/MEMORY.md` | Jake's sessions only | Claude auto-memory |
| Marty's internal state | `~/.openclaw/workspace/MEMORY.md` | Marty only | Marty |
| Marty's conversation DB | `~/.openclaw/memory/marty.sqlite` | Marty only | Marty |
| Codebase rules | `t4/CLAUDE.md` | Sessions in t4 | Team via git |

The boundary is simple: **if it affects someone else's next action, it's shared. If it only affects your own workflow, it's personal.**

---

## 9. What Success Looks Like (Revisited)

Mapping the brief's success criteria to concrete mechanisms:

| Goal | Mechanism |
|------|-----------|
| Jake opens Claude anywhere, session knows scope statuses | `@~/tryps-docs/STATE.md` in global CLAUDE.md |
| Marty finishes PR review, shared state updates | Marty writes to STATE.md + git push; Jake's next `git pull` brings it in |
| Dev marks scope ready-for-testing | Edit spec.md frontmatter; Marty's sync picks it up |
| Jake deprioritizes P4 | Write to STATE.md "Priorities" section; Marty reads it next cycle |
| No cold starts | STATE.md loaded automatically in every session via @import |

---

## Sources

### Spine Pattern and Meta-Repo Approaches
- [The Spine Pattern - Titus Soporan](https://tsoporan.com/blog/spine-pattern-multi-repo-ai-development/)
- [Giving AI Agents a Map - Seylox](https://seylox.github.io/2026/03/05/blog-agents-meta-repo-pattern.html)
- [Context from Internal Git Repos - Elite AI-Assisted Coding](https://elite-ai-assisted-coding.dev/p/context-from-internal-git-repos)

### Claude Code Memory and @import
- [How Claude Remembers Your Project - Official Docs](https://code.claude.com/docs/en/memory)
- [Claude Code Memory Architecture - Ian Paterson](https://ianlpaterson.com/blog/claude-code-memory-architecture/)
- [Multi-Repo Context Loading - Black Dog Labs](https://blackdoglabs.io/blog/claude-code-decoded-multi-repo-context)
- [Referencing Files in Claude Code - Steve Kinney](https://stevekinney.com/courses/ai-development/referencing-files-in-claude-code)
- [Claude Code --add-dir Guide - ClaudeLog](https://claudelog.com/faqs/--add-dir/)
- [Polyrepo Synthesis - Rajiv Pant](https://rajiv.com/blog/2025/11/30/polyrepo-synthesis-synthesis-coding-across-multiple-repositories-with-claude-code-in-visual-studio-code/)

### Multi-Agent Memory Architectures
- [Multi-Agent Memory from Computer Architecture Perspective](https://arxiv.org/html/2603.10062)
- [Collaborative Memory: Multi-User Memory Sharing](https://arxiv.org/html/2505.18279v1)
- [Best AI Agent Memory Frameworks 2026](https://machinelearningmastery.com/the-6-best-ai-agent-memory-frameworks-you-should-try-in-2026/)

### OpenClaw Memory System
- [OpenClaw Memory Docs](https://docs.openclaw.ai/concepts/memory)
- [OpenClaw Architecture Part 3: Memory](https://openclawunboxed.com/p/openclaw-architecture-part-3-memory)
- [OpenClaw Local Memory System](https://eastondev.com/blog/en/posts/ai/20260205-openclaw-memory-system/)

### Sync and Write-Back Patterns
- [Keeping Agent Memory in Sync - Unix-Style](https://coding-with-ai.dev/posts/sync-claude-code-codex-cursor-memory/)
- [Claude-Mem: Session Memory Archive](https://github.com/thedotmack/claude-mem)
- [Symlinks with CLAUDE.md - ClaudeLog](https://claudelog.com/faqs/claude-md-agents-md-symlink/)

### Team Workflows
- [How Anthropic Teams Use Claude Code](https://www-cdn.anthropic.com/58284b19e702b49db9302d5b6f135ad8871e7658.pdf)
- [Agent Teams Workflow Guide](https://github.com/FlorianBruniaux/claude-code-ultimate-guide/blob/main/guide/workflows/agent-teams.md)
- [Claude Code Team Best Practices - SmartScope](https://smartscope.blog/en/generative-ai/claude/claude-code-creator-team-workflow-best-practices/)
