# OpenClaw Memory Architecture & Shared State Integration Report

**Date:** 2026-03-18
**Researcher:** Claude Opus 4.6 (1M context)
**Companion to:** `memory-research-report.md` (Claude Code ecosystem patterns)
**Audience:** Jake Stein, for implementation with Marty (OpenClaw on Hetzner)

---

## Executive Summary

OpenClaw's memory system is designed for single-agent autonomy, not multi-actor shared state. Your setup -- Jake (Claude Code, ephemeral), Marty (OpenClaw, persistent), devs (editing spec.md), Mission Control (Next.js dashboard) -- requires a deliberate bridging layer. The good news: you already have most of the pieces. tryps-docs is the right bridge. The architecture below shows how to wire it up so every actor reads from and writes to the same source of truth, using patterns that OpenClaw natively supports.

**Key recommendation:** Create a single `tryps-docs/shared/state.md` file as the "spine" that aggregates scope statuses, team context, recent decisions, and priorities. Marty generates it. Jake's Claude sessions load it. Mission Control reads spec.md frontmatter directly (it already does). The spine is the missing connector.

---

## Table of Contents

1. [OpenClaw Memory System](#1-openclaw-memory-system)
2. [Workspace Configuration for External Git Repos](#2-workspace-configuration-for-external-git-repos)
3. [OpenClaw Skill for State Management](#3-openclaw-skill-for-state-management)
4. [Mission Control Integration](#4-mission-control-integration)
5. [Bidirectional Sync Patterns](#5-bidirectional-sync-patterns)
6. [Community Patterns and Validation](#6-community-patterns-and-validation)
7. [Implementation Plan](#7-implementation-plan)
8. [File Reference and Sources](#8-file-reference-and-sources)

---

## 1. OpenClaw Memory System

### How It Actually Works

OpenClaw uses a layered memory system with distinct persistence tiers:

| Layer | File(s) | Persistence | Purpose |
|-------|---------|-------------|---------|
| **SOUL.md** | `~/.openclaw/workspace/SOUL.md` | Permanent | Agent identity, personality, core behavior rules |
| **AGENTS.md** | `~/.openclaw/workspace/AGENTS.md` | Permanent | Behavioral guidelines, operational instructions |
| **MEMORY.md** | `~/.openclaw/workspace/MEMORY.md` | Permanent (curated) | Promoted facts, persistent knowledge (Marty's: 330 lines) |
| **Daily notes** | `memory/YYYY-MM-DD.md` | Ephemeral (auto-created) | Running context, decisions, activities for the day |
| **SQLite DB** | `~/.openclaw/memory/marty.sqlite` | Permanent | Conversation history, task records (33MB) |
| **HEARTBEAT.md** | `~/.openclaw/workspace/HEARTBEAT.md` | Permanent | Checklist items the agent runs every 30-60 minutes |
| **IDENTITY.md** | `~/.openclaw/workspace/IDENTITY.md` | Permanent | Personalization details |
| **TOOLS.md** | `~/.openclaw/workspace/TOOLS.md` | Permanent | Available tool specifications |

### The Read Pattern (Bootstrap)

On session start, OpenClaw loads "bootstrap files": SOUL.md + AGENTS.md + MEMORY.md + today's daily note + yesterday's daily note. These form the agent's initial context.

**Critical constraint:** Files over 20,000 characters get truncated per file, with an aggregate cap of ~150,000 characters across all bootstrap files. This means you cannot dump the entire state of 22 scopes into MEMORY.md -- it would be truncated. Keep bootstrap files focused.

### The Write Pattern (Memory Promotion)

During a session, the daily note (`memory/YYYY-MM-DD.md`) acts as an append-only scratch pad. The intended promotion flow:

```
Conversation context (ephemeral, lost on compaction)
    --> Daily note (append-only, survives session, dropped after ~2 days)
        --> MEMORY.md (permanent, curated, loaded on every session start)
```

Facts worth keeping get "promoted" to MEMORY.md -- either by the agent (via tool call) or by the human editing the file directly.

### Context Compaction

When the conversation approaches the context window limit, OpenClaw runs a **silent pre-compaction memory flush**: it prompts the model to extract key facts from the conversation and write them to MEMORY.md before discarding raw conversation history. The agent never "forgets" important information -- it migrates it first.

### What This Means for Marty

Marty's MEMORY.md (330 lines) is his primary persistent knowledge store. The daily notes are scratch. The SQLite DB is conversation history that should not be shared. **MEMORY.md and HEARTBEAT.md are the two files where you can influence Marty's persistent behavior without touching his code.**

---

## 2. Workspace Configuration for External Git Repos

### The Security Boundary Problem

OpenClaw's workspace security (`readWorkspaceFileWithGuards()`) rejects symlinks that resolve outside the workspace root. You **cannot** symlink `~/tryps-docs` into Marty's workspace directory. This is documented in:
- Issue #40245: shared workspace directory for multi-agent setups
- nix-openclaw Issue #76: documents symlinks rejected by workspace security boundary

The check works by resolving paths segment-by-segment. When it encounters a symlink, it calls `isPathInside(rootCanonicalPath, linkCanonical)` to verify the resolved target is within the workspace root.

### Three Options for Getting tryps-docs Into Marty's Context

**Option A: Copy on sync (Recommended)**

Your existing `sync-tryps-docs.sh` cron script already does `git pull`. Extend it to copy the key shared state file into Marty's workspace after each sync:

```bash
#!/bin/bash
# /home/openclaw/sync-tryps-docs.sh
cd /home/openclaw/tryps-docs && git pull --ff-only

# Copy shared state into Marty's workspace so it enters bootstrap context
cp /home/openclaw/tryps-docs/shared/state.md \
   /home/openclaw/.openclaw/workspace/TRYPS_STATE.md
```

This file, being physically inside the workspace directory, will be available to all of Marty's tools without triggering symlink guards. It will also be picked up as a bootstrap file if named correctly.

**Option B: sharedContextFiles config (check your OpenClaw version)**

Issue #24832 proposed a `sharedContextFiles` config that injects listed files as a dedicated "Shared Context" section in the system prompt. If your version of OpenClaw supports it:

```json
{
  "agents": {
    "defaults": {
      "sharedContextFiles": [
        "/home/openclaw/tryps-docs/shared/state.md"
      ]
    }
  }
}
```

Files in this list would be injected into bootstrap context alongside workspace files, with workspace files taking precedence on name conflicts. Check `~/.openclaw/openclaw.json` for whether this key is recognized.

**Option C: Heartbeat reads tryps-docs directly via bash**

The workspace guard only applies to the bootstrap context loader, not to bash or tool calls during a running session. Marty can always read any file on the filesystem during a heartbeat:

```
cat /home/openclaw/tryps-docs/shared/state.md
```

This means even without copying files into the workspace, Marty can be instructed (via HEARTBEAT.md) to read tryps-docs directly.

**Recommendation:** Use Option A (copy on sync) for bootstrap context + Option C (heartbeat reads) for active monitoring. Marty wakes up knowing the state (bootstrap), and he checks for changes every 30 minutes (heartbeat).

---

## 3. OpenClaw Skill for State Management

### Proposed Skill: `tryps-state-sync`

This skill teaches Marty to: read all spec.md frontmatter, generate a status summary, write it to a shared state file, detect changes, and notify via Slack.

#### Directory Structure

```
/home/openclaw/.openclaw/skills/tryps-state-sync/
|-- SKILL.md
|-- scripts/
|   `-- parse-specs.sh          # Parses spec.md frontmatter, outputs JSON
`-- references/
    `-- status-schema.md        # Documents the 4-status lifecycle
```

#### SKILL.md Content

```markdown
---
name: tryps-state-sync
description: Parses tryps-docs spec.md frontmatter to generate scope status summaries, detect status changes, and notify via Slack. This skill should be used during heartbeat checks, when asked about scope statuses, or when status changes need to be communicated.
---

# Tryps State Sync

## Quick Start

To generate a fresh state summary:
1. Run `bash {baseDir}/scripts/parse-specs.sh /home/openclaw/tryps-docs/scopes`
2. Compare output against `/home/openclaw/tryps-docs/shared/state.md`
3. If changes detected, update state.md and notify #martydev on Slack

## Spec Frontmatter Schema

Each scope's `spec.md` uses YAML frontmatter with these fields:

- **feature**: Human-readable feature name
- **status**: One of: `to-be-built`, `ready-for-testing`, `tested-confirmed`, `tested-failed`
- **phase**: One of: `P1`, `P2`, `P3`, `P4`, `P5`
- **owner**: Dev name (or empty if unassigned)
- **date**: Date of last status change (YYYY-MM-DD)

## Instructions

### Reading Specs

To scan all specs, iterate through `/home/openclaw/tryps-docs/scopes/p*/*/spec.md`.
For each file, extract the YAML frontmatter between the opening and closing `---` markers.
Parse the `status`, `phase`, `owner`, and `feature` fields.

If a spec has no YAML frontmatter (some older specs use a different format), treat the
status as `to-be-built` and extract the feature name from the first H1 heading.

### Generating State Summary

Write the aggregated state to `/home/openclaw/tryps-docs/shared/state.md` using this format:

```
# Tryps Project State
**Generated:** YYYY-MM-DD HH:MM UTC
**Generated by:** Marty (heartbeat)

## Scope Statuses
| Phase | Scope | Status | Owner | Last Changed |
|-------|-------|--------|-------|-------------|
| P1 | Core Flows | to-be-built | Asif | 2026-03-18 |
...

## Summary
- X scopes total
- Y to-be-built, Z ready-for-testing, ...

## Recent Changes
- [date] scope-name: old-status -> new-status

## Current Priorities
(Read from /home/openclaw/tryps-docs/shared/priorities.md if it exists)
```

### Detecting Changes

Before writing state.md, read the existing version. Compare each scope's status against
the previous table. If any status changed:
1. Add the change to the "Recent Changes" section (keep last 20 entries)
2. Send a Slack notification to #martydev
3. Commit and push the updated state.md

### Slack Notification Format

When a status changes, post to #martydev:

> Scope status changed: **[scope-name]** is now `[new-status]`
> (was `[old-status]`, owner: [owner])
> Spec: tryps-docs/scopes/[phase]/[scope]/spec.md

### Git Operations

After updating state.md:
```bash
cd /home/openclaw/tryps-docs
git add shared/state.md
git commit -m "state: update scope statuses [auto]"
git push
```

## Guidelines

- Never overwrite spec.md files -- state.md is the only output file
- Always commit and push state.md changes to tryps-docs
- Run this check during every heartbeat cycle
- If frontmatter parse errors occur, log them but continue processing other specs
- Keep state.md under 200 lines so it fits in Claude Code's bootstrap context
```

#### scripts/parse-specs.sh

```bash
#!/bin/bash
# Parse all spec.md frontmatter in tryps-docs/scopes and output JSON
SCOPES_DIR="${1:-/home/openclaw/tryps-docs/scopes}"
echo "["
first=true
for spec in "$SCOPES_DIR"/p*/*/spec.md; do
  [ -f "$spec" ] || continue
  phase=$(echo "$spec" | grep -oP 'p\d+')
  scope=$(basename "$(dirname "$spec")")
  # Extract frontmatter (between first and second ---)
  frontmatter=$(sed -n '/^---$/,/^---$/p' "$spec" | sed '1d;$d')
  status=$(echo "$frontmatter" | grep '^status:' | sed 's/status:\s*//')
  feature=$(echo "$frontmatter" | grep '^feature:' | sed 's/feature:\s*//')
  owner=$(echo "$frontmatter" | grep '^owner:' | sed 's/owner:\s*//')
  date=$(echo "$frontmatter" | grep '^date:' | sed 's/date:\s*//')
  [ "$first" = true ] && first=false || echo ","
  printf '  {"phase":"%s","scope":"%s","feature":"%s","status":"%s","owner":"%s","date":"%s"}' \
    "$phase" "$scope" "$feature" "${status:-to-be-built}" "${owner:-unassigned}" "${date:-}"
done
echo ""
echo "]"
```

### HEARTBEAT.md Addition

Add this block to Marty's existing HEARTBEAT.md:

```markdown
## Tryps State Sync
- Pull latest tryps-docs: `cd /home/openclaw/tryps-docs && git pull --ff-only`
- Parse all spec.md frontmatter using the tryps-state-sync skill
- If any status changed since last check, update shared/state.md, commit, push, and notify #martydev
- If nothing changed, skip silently (HEARTBEAT_OK)
```

### How the Rotating Heartbeat Pattern Applies

The community pattern for heartbeats uses rotation with state tracking: each check type has a cadence and time window, tracked in `memory/heartbeat-state.json`. The tryps state sync fits naturally into this:

| Check | Cadence | Time Window |
|-------|---------|-------------|
| Email/Slack | Every 30 min | 9 AM - 9 PM |
| **Tryps State Sync** | **Every 30 min** | **Anytime** |
| Git workspace commit | Every 24 hours | 3 AM |

The process: load timestamps from heartbeat-state.json, calculate which check is most overdue (respecting time windows), run that one, update timestamp. This prevents heartbeat turns from growing too expensive.

---

## 4. Mission Control Integration

### What Already Works

Your Mission Control is well-architected for this. Key findings from the codebase:

**`src/lib/spec-parser.ts`** -- Parses all spec.md files from the scopes directory. It reads the content, finds the "## Success Criteria" or "## Acceptance Criteria" section, extracts bullet items with "Verified by:" annotations, and groups them by H3 category headers. It generates deterministic criterion keys using SHA-256 hashes.

**`src/app/api/criteria/route.ts`** -- API endpoint that calls `parseAllSpecs(config.specsDir)`, overlays QA status from a SQLite `criteria_overlay` table, combines with workstream data from the Gantt database, and returns the full criteria tree grouped by phase/scope/category with stats (pass/fail/blocked/untested counts).

**`src/app/api/criteria/sync/route.ts`** -- Reconciliation endpoint that compares spec files on disk to the workstreams table and creates missing entries. Also syncs spec content into the database for Gantt pipeline views.

**`docker-compose.yml` line 23** -- Already mounts tryps-docs scopes into the container:
```yaml
- /home/openclaw/tryps-docs/scopes:/app/tryps-docs/scopes:ro
```

### What Needs to Change for the 4-Status System

The current spec-parser reads the criteria *section* but does **not** read YAML frontmatter for scope-level status. The new 4-status system needs frontmatter parsing.

**Add to `spec-parser.ts`:**

```typescript
function extractFrontmatter(content: string): Record<string, string> {
  const match = content.match(/^---\n([\s\S]*?)\n---/)
  if (!match) return {}
  const fm: Record<string, string> = {}
  for (const line of match[1].split('\n')) {
    const [key, ...rest] = line.split(':')
    if (key && rest.length) fm[key.trim()] = rest.join(':').trim()
  }
  return fm
}
```

Then in `parseSpecFile()`, extract and return `scopeStatus`, `owner`, and `lastChanged` from the frontmatter. The `/api/criteria` response should include these fields per scope.

### Comparison of Integration Approaches

| Approach | Latency | Complexity | Recommendation |
|----------|---------|------------|----------------|
| **Filesystem read on demand (current)** | ~50ms | Low | **Keep this. It works.** |
| Git webhook triggers container rebuild | ~5s | Medium | Overkill for 22 scopes |
| API parses frontmatter on demand | ~100ms | Low | Already implemented (extend it) |
| SQLite DB populated by Marty | ~10ms read | Medium | Adds unnecessary indirection |
| Filesystem watch (inotify/fswatch) | Real-time | Medium | Fragile inside Docker containers |

**Verdict:** The current approach (filesystem read from Docker-mounted volume) is correct. No webhook or database layer needed. Just add frontmatter parsing to the existing spec-parser.ts.

For near-real-time updates when a dev pushes a status change: add a GitHub webhook on tryps-docs pushes that hits `POST /api/criteria/sync` on the MC container. This is optional -- the existing on-demand parsing already gives fresh data on every page load.

---

## 5. Bidirectional Sync Patterns

### Current Data Flow

```
Jake/Dev edits spec.md locally
  -> git push to tryps-docs (GitHub)
    -> Marty's cron: git pull every N minutes
      -> Marty sees changes on next heartbeat
        -> Marty updates shared/state.md, commits, pushes
          -> Mission Control sees changes on next /api/criteria call
```

### Is Cron Sufficient?

**For status changes: Yes, with a tighter interval.** A 5-minute cron pulling tryps-docs is fast enough. Nobody makes status decisions that need sub-minute propagation. The relevant cadence is "before the next heartbeat" (30 minutes), and a 5-minute cron comfortably beats that.

**For the reverse (Marty writes, Jake reads): Also yes.** Marty writes state.md, commits, pushes. Jake's next Claude session runs `git pull` on tryps-docs (via SessionStart hook from the companion report) and reads the updated file. The latency is "next time Jake opens a terminal" -- which is fine for strategic state.

### Upgrade Path: Webhook-Triggered Sync

If you later want faster propagation without frequent cron pulls:

**GitHub webhook on tryps-docs push -> Hetzner:**

```bash
#!/bin/bash
# /home/openclaw/webhook-handler.sh
# Triggered by GitHub push webhook on tryps-docs repo
cd /home/openclaw/tryps-docs && git pull --ff-only

# Copy state into Marty's workspace for bootstrap context
cp /home/openclaw/tryps-docs/shared/state.md \
   /home/openclaw/.openclaw/workspace/TRYPS_STATE.md

# Optionally trigger an immediate Marty heartbeat
curl -X POST http://localhost:4080/webhook/trigger?mode=now
```

OpenClaw's webhook system supports a `mode` option: `now` (immediate heartbeat) or `next-heartbeat` (wait for scheduled cycle). A GitHub push webhook hitting the Gateway with `mode=now` would give near-instant propagation of spec changes to Marty.

**Recommended setup:**
1. Keep the 5-minute cron as a safety net (handles missed webhooks, network issues)
2. Add a GitHub webhook on tryps-docs that triggers immediate sync
3. The webhook endpoint: git pull, copy state into workspace, optionally trigger heartbeat

### Conflict Avoidance by Design

The architecture partitions files by writer to prevent merge conflicts:

| File | Writer(s) | Reader(s) |
|------|-----------|-----------|
| `scopes/*/spec.md` | Jake, Devs, QA (frontmatter status + criteria) | Marty, MC |
| `shared/state.md` | Marty only (auto-generated) | Jake's Claude, MC |
| `shared/decisions.md` | Jake only (append-only) | Marty, Claude sessions |
| `shared/priorities.md` | Jake only | Marty, Claude sessions |
| Marty's MEMORY.md | Marty only | Marty only |
| Jake's MEMORY.md | Claude only | Claude only |

No file has two concurrent writers. Conflicts become structurally impossible.

### What If Marty Needs to Write to spec.md?

If Marty should ever auto-update a scope's status (e.g., marking a scope `ready-for-testing` after observing all PRs merged), have him write to an overlay file rather than the spec itself:

```
tryps-docs/shared/status-overrides.json
```

The human (Jake or the dev) then reviews and promotes the override into the actual spec.md frontmatter. This keeps humans as the authority on spec status while still letting Marty propose changes.

---

## 6. Community Patterns and Validation

### Multi-Agent Mission Control Dashboards

Several open-source OpenClaw Mission Control implementations exist (abhi1693/openclaw-mission-control, builderz-labs/mission-control, robsannaa/openclaw-mission-control, carlosazaustre/tenacitOS). Most use Next.js + React and communicate via the Gateway WebSocket API. Your custom MC with spec-parser is more tailored -- it reads directly from spec files rather than going through the Gateway, which is a better fit for file-based state.

### Shared Workspace: A Known Gap

The community has extensively documented the workspace isolation problem:

- **Issue #40245** proposes a `sharedDir` or `commonFiles` config that lets multiple agents reference the same physical directory. Files in the shared directory would be injected into bootstrap context alongside workspace files. Status: proposed, not yet merged.

- **Issue #24832** proposes `sharedContextFiles` config for cross-session, cross-channel shared context. Would inject listed files as a "Shared Context" section in the system prompt. Status: proposed.

- **Issue #21198** proposes `extraWorkspaceFiles` for plugin-contributed project context files. Status: proposed.

The community workarounds match our recommendation: copy files into the workspace (Option A) or use bash to read external paths during sessions (Option C).

### Heartbeat-Driven State Sync

The "rotating heartbeat" pattern is widely used in production deployments. MoltFounders documents a pattern with cadence tracking in `heartbeat-state.json`, time windows for different check types, and the "run the most overdue check" algorithm. The tryps-state-sync skill fits naturally into this.

### The context.md / Spine Pattern

The agent-native-architecture skill's reference on files-universal-interface describes this exact pattern: a single markdown file the agent reads at session start and updates as it learns. The "Spine Pattern" from Titus Soporan validates the same approach for multi-repo setups. tryps-docs/shared/state.md is this pattern applied to your specific architecture.

### What's Unique About Your Setup

Most OpenClaw deployments are single-user (one person, one agent). Your setup -- one persistent agent (Marty), one human with ephemeral AI sessions (Jake/Claude Code), plus a team of devs and QA -- is unusual. The tryps-docs git bridge is the right architectural choice because:

1. Git is the only transport both Marty and Jake can reliably use
2. Markdown is readable by humans, AI agents, and parsers
3. Spec.md as source of truth means devs update status without learning a new system
4. The spine file (state.md) is small enough to load in every Claude session and every OpenClaw bootstrap

---

## 7. Implementation Plan

### Phase 1: Foundation (Day 1)

**1.1. Create `tryps-docs/shared/` directory**

```bash
mkdir -p ~/tryps-docs/shared
```

Create an initial `state.md` manually (Marty will auto-generate it afterward):

```markdown
# Tryps Project State
**Generated:** 2026-03-18 (manual, pending automation)

## Scope Statuses
| Phase | Scope | Status | Owner |
|-------|-------|--------|-------|
| P1 | Core Flows | to-be-built | Asif |
| P1 | Recommendations | to-be-built | - |
| P1 | Tooltips & Teaching | to-be-built | - |
| P1 | Travel DNA | to-be-built | Arslan |
...

## Current Priorities
(Jake to fill in)

## Recent Changes
(none yet -- automation will populate this)
```

**1.2. Normalize spec.md frontmatter**

Add the standard YAML frontmatter to every spec.md that lacks it. The current state:
- `scopes/p3/logistics-agent/spec.md` -- HAS frontmatter (good template)
- `scopes/p1/core-flows/spec.md` -- NO frontmatter (needs it)

Run through all 22 scopes and add:

```yaml
---
feature: <name from H1>
status: to-be-built
phase: <from directory>
owner: <from tracker.md>
date: 2026-03-18
---
```

**1.3. Archive old artifacts**

```bash
mkdir -p ~/tryps-docs/archive
for scope_dir in ~/tryps-docs/scopes/p*/*/; do
  scope=$(basename "$scope_dir")
  phase=$(basename "$(dirname "$scope_dir")")
  for f in "$scope_dir"*.md; do
    base=$(basename "$f")
    [ "$base" = "spec.md" ] && continue  # Keep spec.md in place
    mkdir -p "~/tryps-docs/archive/$phase/$scope"
    mv "$f" "~/tryps-docs/archive/$phase/$scope/"
  done
done
```

### Phase 2: Marty Integration (Day 2)

**2.1. Create the tryps-state-sync skill**

Deploy the SKILL.md and parse-specs.sh script to `/home/openclaw/.openclaw/skills/tryps-state-sync/` on Hetzner.

**2.2. Add the state check to Marty's HEARTBEAT.md**

Add the "Tryps State Sync" section as documented in Section 3.

**2.3. Update sync-tryps-docs.sh**

Add the copy command to bring state.md into Marty's workspace:

```bash
cp /home/openclaw/tryps-docs/shared/state.md \
   /home/openclaw/.openclaw/workspace/TRYPS_STATE.md
```

**2.4. Test the loop**

Manually change a spec.md status on Jake's machine, push to GitHub, wait for the cron pull + heartbeat, verify:
- state.md updates in tryps-docs
- Slack notification fires in #martydev
- TRYPS_STATE.md updates in Marty's workspace

### Phase 3: Mission Control (Day 3)

**3.1. Add frontmatter parsing to spec-parser.ts**

Add the `extractFrontmatter()` function and include `scopeStatus`, `owner`, `lastChanged` in the `ParsedScope` type and return value.

**3.2. Update /api/criteria response**

Include the new scope-level status fields in the API response so the frontend can render them.

**3.3. Update criteria UI**

Add a status badge per scope (to-be-built / ready-for-testing / tested-confirmed / tested-failed) using the 4-status color scheme.

**3.4. Optional: GitHub webhook**

Set up a GitHub webhook on tryps-docs pushes that hits `POST https://marty.jointryps.com/api/criteria/sync` to trigger immediate reconciliation.

### Phase 4: Polish (Day 4+)

**4.1. Create shared/decisions.md** -- Append-only log of strategic decisions. Jake writes entries like:

```markdown
### 2026-03-18: Deprioritize P4
P4 scopes (Brand & GTM) are on hold until P1 core flows pass QA.
Reason: No point marketing an app that doesn't work yet.
```

**4.2. Create shared/priorities.md** -- Jake-maintained file:

```markdown
# Current Priorities (updated 2026-03-18)

1. P1 Core Flows -- get spec written with success criteria (Asif)
2. P1 Travel DNA -- spec exists, assign and start building (Arslan)
3. P2 Booking Links -- needs spec
4. Everything else waits
```

**4.3. Test the full end-to-end loop:**
Jake changes a priority -> Marty sees it on next heartbeat -> Marty's next standup reflects it -> MC dashboard shows it -> Jake's next Claude session loads it automatically.

**4.4. Consider webhook-triggered sync** to replace the 5-minute cron with near-instant propagation.

---

## 8. File Reference and Sources

### Files Read During This Research

**tryps-docs:**
- `/Users/jakestein/tryps-docs/memory-research-brief.md` -- The research brief
- `/Users/jakestein/tryps-docs/scopes/tracker.md` -- Current scope tracker
- `/Users/jakestein/tryps-docs/scopes/workflow.md` -- Dev workflow v2
- `/Users/jakestein/tryps-docs/scopes/p1/core-flows/spec.md` -- Spec without frontmatter
- `/Users/jakestein/tryps-docs/scopes/p3/logistics-agent/spec.md` -- Spec with frontmatter

**Mission Control:**
- `/Users/jakestein/mission-control/src/lib/spec-parser.ts` -- Spec parser (already reads criteria)
- `/Users/jakestein/mission-control/src/app/api/criteria/route.ts` -- Criteria API endpoint
- `/Users/jakestein/mission-control/src/app/api/criteria/sync/route.ts` -- Sync/reconciliation endpoint
- `/Users/jakestein/mission-control/docker-compose.yml` -- Docker config (mounts tryps-docs)

**Claude Code ecosystem:**
- `/Users/jakestein/.claude/projects/-Users-jakestein/memory/MEMORY.md` -- Jake's memory (21 lines)
- `/Users/jakestein/tryps-docs/memory-research-report.md` -- Companion report on Claude Code patterns

**Skills consulted:**
- `agent-native-architecture` -- Shared workspace patterns, context.md, file-as-interface
- `create-agent-skills` -- SKILL.md structure and best practices
- `orchestrating-swarms` -- Multi-agent coordination patterns
- `skill-creator` -- Skill authoring specification

### Online Sources

**OpenClaw Official:**
- [Memory - OpenClaw Docs](https://docs.openclaw.ai/concepts/memory)
- [Agent Workspace - OpenClaw Docs](https://docs.openclaw.ai/concepts/agent-workspace)
- [Heartbeat - OpenClaw Docs](https://docs.openclaw.ai/gateway/heartbeat)
- [Cron vs Heartbeat - OpenClaw Docs](https://docs.openclaw.ai/automation/cron-vs-heartbeat)
- [Webhooks - OpenClaw Docs](https://docs.openclaw.ai/automation/webhook)
- [Skills - OpenClaw Docs](https://docs.openclaw.ai/tools/skills)

**OpenClaw GitHub Issues:**
- [Issue #40245: Shared workspace directory for multi-agent setups](https://github.com/openclaw/openclaw/issues/40245)
- [Issue #24832: Cross-session shared context block](https://github.com/openclaw/openclaw/issues/24832)
- [Issue #21198: extraWorkspaceFiles config for plugin context](https://github.com/openclaw/openclaw/issues/21198)
- [Issue #31224: Allow tools to access files outside workspace](https://github.com/openclaw/openclaw/issues/31224)
- [nix-openclaw Issue #76: Symlinks rejected by workspace security](https://github.com/openclaw/nix-openclaw/issues/76)

**Community Guides:**
- [OpenClaw Memory Architecture Guide - Zen van Riel](https://zenvanriel.com/ai-engineer-blog/openclaw-memory-architecture-guide/)
- [OpenClaw Memory Masterclass - VelvetShark](https://velvetshark.com/openclaw-memory-masterclass)
- [OpenClaw Heartbeat & Task Tracking - MoltFounders](https://moltfounders.com/openclaw-runbook/heartbeat-task-tracking)
- [Heartbeats: Cheap Checks First - DEV Community](https://dev.to/damogallagher/heartbeats-in-openclaw-cheap-checks-first-models-only-when-you-need-them-4bfi)
- [OpenClaw Memory Explained - LumaDock](https://lumadock.com/tutorials/openclaw-memory-explained)
- [OpenClaw Multi-Agent Coordination - LumaDock](https://lumadock.com/tutorials/openclaw-multi-agent-coordination-governance)
- [OpenClaw Git Integration - Fast.io](https://fast.io/resources/openclaw-git-integration/)
- [Building Custom OpenClaw Skills - DataCamp](https://www.datacamp.com/tutorial/building-open-claw-skills)
- [How to build custom OpenClaw skills - LumaDock](https://lumadock.com/tutorials/build-custom-openclaw-skills)
- [Default AGENTS.md Reference - OpenClaw](https://openclawcn.com/en/docs/reference/agents.default/)
- [OpenClaw Design Patterns (Kernel Patterns) - Ken Huang](https://kenhuangus.substack.com/p/the-openclaw-design-patternspart)
