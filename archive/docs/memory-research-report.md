# Claude Code Ecosystem: Team Memory & Cross-Repo Context

## Research Report for Tryps

**Date:** 2026-03-18
**Scope:** How teams configure persistent, shared memory across human operators, autonomous AI agents, and ephemeral Claude Code sessions -- with a focus on patterns applicable to the Tryps setup (t4 app repo, tryps-docs shared bridge, Marty/OpenClaw on Hetzner).

---

## Table of Contents

1. [How Teams Configure CLAUDE.md for Multi-Repo Awareness](#1-multi-repo-claudemd-patterns)
2. [Auto-Memory Best Practices (MEMORY.md)](#2-auto-memory-best-practices)
3. [Hooks for Auto-Context Loading](#3-hooks-for-auto-context)
4. [Team settings.json Configurations](#4-team-settingsjson-configurations)
5. [Worktree Memory Isolation Problem](#5-worktree-memory-isolation)
6. [Global vs. Project CLAUDE.md Split](#6-global-vs-project-claudemd-split)
7. [Real Examples from the Community](#7-real-examples)
8. [Actionable Recommendations for Tryps](#8-recommendations-for-tryps)

---

## 1. Multi-Repo CLAUDE.md Patterns

### The Core Problem

Claude Code loads CLAUDE.md from the current working directory and walks up the tree. When you open Claude in `~/t4/`, it has no idea that `~/tryps-docs/` exists. This is by design -- repos are isolated contexts.

### Pattern A: The `--add-dir` Flag with Environment Variable

The most officially supported approach. Claude Code's `--add-dir` flag grants read access to additional directories. Combined with `CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1`, Claude also loads CLAUDE.md files from those directories.

```bash
# Launch Claude in t4 with tryps-docs context
CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1 claude --add-dir ~/tryps-docs
```

**Source:** [Official Claude Code docs](https://code.claude.com/docs/en/memory), confirmed by [Leonardo's microservices guide](https://dev.to/leonardobybyte/beyond-the-single-repo-how-i-use-claude-code-across-microservices-hl5)

**Pros:** Officially supported, loads CLAUDE.md from both repos, Claude can read files in both directories.
**Cons:** Must be passed every invocation. Requires a shell alias or wrapper to be practical.

### Pattern B: The `@import` Directive

CLAUDE.md files can import external files using `@path/to/file` syntax. Relative and absolute paths work. Max depth: 5 hops.

```markdown
# In ~/t4/CLAUDE.md

## Cross-Repo Context
@~/tryps-docs/shared-context.md
@~/tryps-docs/scopes/STATUS.md
```

**Source:** [Official docs](https://code.claude.com/docs/en/memory)

**Pros:** Declarative, always loads, no CLI flag needed, works for every team member if paths are consistent.
**Cons:** Absolute paths are machine-specific (team members need same directory structure or use `~` paths). First use triggers an approval dialog.

### Pattern C: The "Spine" Meta-Repository

Described by Titus Soporan. A separate git repo that sits above your project repos and provides layered CLAUDE.md files plus a task tracking system.

```
spine/                          # Meta-repo (separate git)
  CLAUDE.md                     # Master navigation + global context
  _tasks/active/                # Active work tracking
  project-a/CLAUDE.md           # Project-specific context
  project-b/CLAUDE.md           # Project-specific context
```

**Source:** [The Spine Pattern](https://tsoporan.com/blog/spine-pattern-multi-repo-ai-development/)

**Applicability to Tryps:** tryps-docs already IS your spine. It is the shared context repo that both Jake and Marty can access. The pattern validates what you have already decided.

### Pattern D: Ecosystem Table in Every CLAUDE.md

Rajiv Pant's "Polyrepo Synthesis" approach: every CLAUDE.md across all repos contains an identical ecosystem table so Claude immediately understands the full system.

```markdown
## Repository Ecosystem

| Repository | Purpose | Location |
|-----------|---------|----------|
| **t4** | Tryps app (Expo/TS/Supabase) | `~/t4/` |
| **tryps-docs** | Scope specs, shared state, reports | `~/tryps-docs/` |
| **mission-control** | Marty visualization dashboard | `~/mission-control/` |
```

**Source:** [Rajiv Pant's Polyrepo Synthesis](https://rajiv.com/blog/2025/11/30/polyrepo-synthesis-synthesis-coding-across-multiple-repositories-with-claude-code-in-visual-studio-code/)

**Recommendation for Tryps:** Add this table to every CLAUDE.md and to `~/.claude/CLAUDE.md`. It costs 5 lines and prevents Claude from ever being confused about your ecosystem.

### Pattern E: Symlinks in `.claude/rules/`

The `.claude/rules/` directory supports symlinks. You can maintain a shared set of rules in tryps-docs and symlink them into project repos.

```bash
# In ~/t4/
ln -s ~/tryps-docs/shared-context.md .claude/rules/shared-context.md
```

**Source:** [Official docs](https://code.claude.com/docs/en/memory)

**Pros:** Always loads, no CLI flag, survives across sessions.
**Cons:** Symlinks are local to each machine (not git-portable unless target path is stable).

---

## 2. Auto-Memory Best Practices

### How It Works

Auto-memory is stored at `~/.claude/projects/<project>/memory/`. The `<project>` path is derived from the **git repository root**, so all worktrees and subdirectories within the same repo share one auto memory directory.

Key facts:
- Only the first **200 lines** of MEMORY.md load at session start
- Content beyond line 200 is silently truncated -- no error, no warning
- Claude moves detailed notes into topic files (e.g., `debugging.md`, `api-conventions.md`)
- MEMORY.md acts as an **index** pointing to those topic files
- Topic files are NOT loaded at startup -- Claude reads them on demand

**Source:** [Official docs](https://code.claude.com/docs/en/memory), [Claude Code memory explained](https://joseparreogarcia.substack.com/p/claude-code-memory-explained)

### Your Current Structure (Assessment)

Your MEMORY.md at `~/.claude/projects/-Users-jakestein/memory/MEMORY.md` is well-structured at 21 lines with 13 topic files. This is a good pattern -- concise index with categorized entries (Feedback, Project, Reference). You are well under the 200-line limit.

**What works well:**
- Categorized entries (Feedback, Project, Reference)
- One-line summaries with links to topic files
- Mix of corrections ("FRD step removed") and persistent facts ("app is called Tryps")

**What could be improved:**
- No "Current Priorities" section -- every session starts without knowing what matters now
- No link to tryps-docs shared state
- No cross-repo awareness (Claude in t4 has separate memory from Claude at ~/)
- Team roster is stale (MEMORY.md says "Jake, Asif, Nadim, Muneeb, Andreas. Ken is gone" but the topic file says different)

### Best Practices from the Community

1. **Keep MEMORY.md as a concise index** (under 200 lines, ideally under 50). Move details to topic files.
2. **Review periodically.** Run `/memory` to audit. Delete stale entries. MEMORY.md is a living document.
3. **Put rules in CLAUDE.md, not memory.** If something is important enough to be enforced every session, it belongs in CLAUDE.md. Memory is for learned patterns.
4. **Use explicit saves for critical knowledge.** Tell Claude "remember that..." for important architectural decisions rather than hoping auto-memory catches it.
5. **Monitor for bloat.** A pre-session hook or periodic review prevents silent truncation.

**Source:** [SFEIR Institute optimization guide](https://institute.sfeir.com/en/claude-code/claude-code-memory-system-claude-md/optimization/), [shanraisshan/claude-code-best-practice](https://github.com/shanraisshan/claude-code-best-practice/blob/main/best-practice/claude-memory.md)

### The `autoMemoryDirectory` Setting

You can redirect where auto-memory is stored:

```json
// In ~/.claude/settings.json or ~/.claude/settings.local.json
{
  "autoMemoryDirectory": "~/tryps-docs/shared-memory/"
}
```

This would make ALL your Claude sessions (regardless of which repo you are in) write to tryps-docs. Marty could then read that same file via git sync.

**Critical caveat:** This setting is accepted from user/local/policy settings but NOT from project settings (.claude/settings.json) -- security measure to prevent repos from redirecting memory writes.

**Source:** [Official docs](https://code.claude.com/docs/en/memory)

---

## 3. Hooks for Auto-Context

### SessionStart Hook

The `SessionStart` event fires when Claude Code starts a new session or resumes one. It can inject context via stdout and set environment variables via `$CLAUDE_ENV_FILE`.

```json
// In ~/.claude/settings.json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/scripts/load-shared-context.sh",
            "timeout": 10
          }
        ]
      }
    ]
  }
}
```

Example `load-shared-context.sh`:
```bash
#!/bin/bash
# Pull latest tryps-docs state
cd ~/tryps-docs && git pull --quiet 2>/dev/null

# Output current state (stdout becomes Claude's context)
echo "=== CURRENT SCOPE STATUSES ==="
for spec in ~/tryps-docs/scopes/*/spec.md; do
  scope=$(basename $(dirname "$spec"))
  status=$(grep -m1 '^status:' "$spec" 2>/dev/null | sed 's/status: *//')
  [ -n "$status" ] && echo "- $scope: $status"
done

echo ""
echo "=== RECENT DECISIONS ==="
cat ~/tryps-docs/shared-memory/decisions.md 2>/dev/null | head -20
```

**Source:** [Official hooks reference](https://code.claude.com/docs/en/hooks), [hook-development skill](file:///Users/jakestein/.claude/plugins/marketplaces/claude-plugins-official/plugins/plugin-dev/skills/hook-development/SKILL.md)

**Known limitation (2026):** SessionStart hook stdout is injected as context but may not be processed on the very first conversation in a fresh session (works on `/clear`, `/compact`, and resume). This is a known issue tracked on GitHub.

### SessionEnd Hook for Write-Back

```json
{
  "hooks": {
    "SessionEnd": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/scripts/sync-shared-state.sh",
            "timeout": 15
          }
        ]
      }
    ]
  }
}
```

Example `sync-shared-state.sh`:
```bash
#!/bin/bash
cd ~/tryps-docs
git add -A
git diff --cached --quiet || git commit -m "auto: sync shared state from Claude session"
git push --quiet 2>/dev/null
```

### PreCompact Hook for Context Preservation

The `PreCompact` event fires before context compaction. Use it to re-inject critical state that must survive compaction.

```json
{
  "hooks": {
    "PreCompact": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'IMPORTANT: Scope statuses live in ~/tryps-docs/scopes/*/spec.md frontmatter. Check before making scope-related decisions.'"
          }
        ]
      }
    ]
  }
}
```

**Source:** [hook-development skill](file:///Users/jakestein/.claude/plugins/marketplaces/claude-plugins-official/plugins/plugin-dev/skills/hook-development/SKILL.md)

---

## 4. Team settings.json Configurations

### Trail of Bits Configuration (Reference Standard)

The most widely-referenced production config. Key patterns:

```json
{
  "env": {
    "DISABLE_TELEMETRY": "1",
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  },
  "alwaysThinkingEnabled": true,
  "permissions": {
    "deny": [
      "Bash(rm -rf *)",
      "Bash(sudo *)",
      "Bash(git push --force*)",
      "Bash(git reset --hard*)",
      "Edit(~/.bashrc)",
      "Edit(~/.ssh/**)",
      "Read(~/.ssh/**)",
      "Read(~/.aws/**)",
      "Read(~/.gnupg/**)"
    ]
  },
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "...block rm -rf and direct push to main..."
          }
        ]
      }
    ]
  }
}
```

**Source:** [trailofbits/claude-code-config](https://github.com/trailofbits/claude-code-config)

**Key differences from your config:** Trail of Bits uses explicit `deny` lists rather than prompt-based PermissionRequest hooks. Both approaches work; deny lists are deterministic (faster, no LLM call), prompt-based hooks are more flexible but add latency.

### Your Current Config (Assessment)

Your `~/.claude/settings.json` already has:
- Agent teams enabled
- Prompt-based PermissionRequest hooks (permissive for dev work)
- Stop hook to warn about unpushed worktree commits
- Status line
- MCP servers (Google Calendar, Exa search, code-search)
- Compound Engineering plugin enabled

**What is missing:**
- No SessionStart hook (no auto-loading of shared context)
- No SessionEnd hook (no auto-sync back to tryps-docs)
- No global CLAUDE.md (`~/.claude/CLAUDE.md` does not exist)
- No `autoMemoryDirectory` setting

### Recommended MCP Server Addition

For cross-repo context, the community recommends a "shared context" MCP server or using Context7 for documentation lookup:

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@anthropic/context7-mcp"]
    }
  }
}
```

---

## 5. Worktree Memory Isolation

### The Problem (Your Specific Case)

You have 17 project memory directories in `~/.claude/projects/`:

```
-Users-jakestein-t4
-Users-jakestein-t4--claude-worktrees-branch-b
-Users-jakestein-t4--claude-worktrees-wt-2
-Users-jakestein-t4--claude-worktrees-wt-3
-Users-jakestein-t4--claude-worktrees-wt-4
-Users-jakestein-t4--claude-worktrees-wt-5
-Users-jakestein-t4--claude-worktrees-wt-6
-Users-jakestein-t4--claude-worktrees-wt-8
-Users-jakestein-t4-wt-2
... (and more)
```

Each worktree creates a separate memory directory because the project path is derived from the filesystem path, not the git repo.

### What Claude Code Does Now (2026)

As of early 2026, Claude Code derives the project path from the **git repository** rather than the filesystem path, meaning all worktrees of the same repo now share one auto memory directory. However, your existing fragmented directories from before this change are still there.

**Source:** [Official docs](https://code.claude.com/docs/en/memory) -- "The `<project>` path is derived from the git repository, so all worktrees and subdirectories within the same repo share one auto memory directory."

### Solutions

**Solution 1: Clean up old directories (immediate)**

The old worktree-specific directories are orphaned. Review them for anything valuable, then delete them.

```bash
# Review what is in each
for d in ~/.claude/projects/-Users-jakestein-t4-*; do
  echo "=== $(basename $d) ==="
  cat "$d/memory/MEMORY.md" 2>/dev/null | head -5
  echo ""
done

# After review, remove the orphaned ones
rm -rf ~/.claude/projects/-Users-jakestein-t4--claude-worktrees-*
rm -rf ~/.claude/projects/-Users-jakestein-t4-wt-*
```

**Solution 2: `autoMemoryDirectory` for cross-repo sharing**

Point all Claude sessions to a shared memory location:

```json
// ~/.claude/settings.json
{
  "autoMemoryDirectory": "~/tryps-docs/claude-shared-memory/"
}
```

This means:
- Claude sessions in t4, tryps-docs, and mission-control all read/write the same memory
- Marty can read this directory via git sync
- No worktree fragmentation possible

**Solution 3: Symlinks (legacy approach, no longer needed)**

Before the git-derived path fix, teams used symlinks:

```bash
ln -sf ~/.claude/projects/-Users-jakestein-t4/memory \
       ~/.claude/projects/-Users-jakestein-t4-wt-2/memory
```

This is no longer necessary for new worktrees but may be needed if you have old directories still being used.

---

## 6. Global vs. Project CLAUDE.md Split

### The Rule

**If it is about you, it goes in global. If it is about the project, it goes in the project.**

### What Goes Where

| Location | Content | Shared With |
|----------|---------|-------------|
| `~/.claude/CLAUDE.md` | Your identity, preferences, ecosystem map, cross-repo instructions | Just you, all projects |
| `~/t4/CLAUDE.md` | App architecture, build commands, coding standards, branch conventions | Team via git |
| `~/t4/.claude.local.md` | Your personal overrides for t4 (gitignored) | Just you |
| `~/tryps-docs/CLAUDE.md` | Scope structure, spec format, pipeline conventions | Team via git |
| `~/.claude/rules/*.md` | Personal rules applied to all projects | Just you |
| `~/t4/.claude/rules/*.md` | Project-specific path-scoped rules | Team via git |

**Source:** [Official docs](https://code.claude.com/docs/en/memory), [Builder.io guide](https://www.builder.io/blog/claude-md-guide), [Ray Thanni's comparison](https://raythanni.substack.com/p/claude-code-memory-files-global-vs)

### Recommended Global CLAUDE.md for Jake

You currently have NO `~/.claude/CLAUDE.md`. This is a significant gap. Every Claude session starts without knowing your ecosystem, your role, or how repos connect.

Recommended content:

```markdown
# Jake Stein -- Global Claude Context

## Identity
I am the founder/product lead of Tryps, a travel app.

## Repository Ecosystem

| Repo | Location | Purpose |
|------|----------|---------|
| **t4** | ~/t4 | Tryps app (Expo SDK 55, TypeScript, Supabase, Expo Router) |
| **tryps-docs** | ~/tryps-docs | Scope specs, shared state, pipeline docs, reports |
| **mission-control** | ~/mission-control | Marty visualization dashboard |

## Cross-Repo Context
@~/tryps-docs/shared-context.md

## Team
- Jake (founder/product), Asif (lead dev), Nadim & Muneeb (devs), Andreas (QA)
- Marty = autonomous AI agent (OpenClaw on Hetzner), communicates via Slack

## Git Conventions
- Default branch: develop (NOT main)
- Always branch from develop
- PR review requests go in #martydev with spec link

## Preferences
- Keep things simple -- we are a small team shipping fast
- Prefer actionable over theoretical
- When in doubt, check tryps-docs for the spec
```

### Recommended Project CLAUDE.md for t4

The t4 repo CLAUDE.md should focus on build/test commands, architecture, and code patterns:

```markdown
# Tryps App (t4)

## Quick Start
npm install && npx expo start

## Architecture
Expo SDK 55 / TypeScript / Supabase / Expo Router
...

## Cross-Repo
Scope specs live in ~/tryps-docs/scopes/
@~/tryps-docs/shared-context.md
```

---

## 7. Real Examples

### Example 1: Trail of Bits -- Security-First Team Config

**What:** Opinionated defaults for security audit teams. Deny-list approach to permissions, PreToolUse hooks blocking dangerous commands, audit logging via PostToolUse hooks.

**Key pattern:** Deterministic command hooks for security (not prompt-based). Every Bash command is checked against regex patterns before execution.

**Repo:** [trailofbits/claude-code-config](https://github.com/trailofbits/claude-code-config)

### Example 2: Rajiv Pant -- Polyrepo Synthesis

**What:** Multi-repo AI development across ragbot (CLI), ragenie (platform), and ragbot-data (shared data). Each repo has an identical ecosystem table in CLAUDE.md. Hub-and-spoke architecture with data repo as source of truth.

**Key pattern:** Identical ecosystem table in every CLAUDE.md. Git operations warning ("verify your directory before running git commands"). Consumer repos document their relationship to the data hub.

**Blog:** [Polyrepo Synthesis](https://rajiv.com/blog/2025/11/30/polyrepo-synthesis-synthesis-coding-across-multiple-repositories-with-claude-code-in-visual-studio-code/)

### Example 3: Titus Soporan -- The Spine Pattern

**What:** A meta-repository that orchestrates context across independent projects. Three-level hierarchy (global, workspace, project). Task files with status, context, key decisions, and phased checklists. Prefixed task routing for multi-repo work.

**Key pattern:** The spine repo IS the shared context. Task files persist decisions across sessions. `x-` prefix on tasks indicates cross-cutting work spanning all repos.

**Relevance to Tryps:** tryps-docs IS your spine. The spec.md files with frontmatter status ARE your task files. This validates your existing architecture.

**Blog:** [The Spine Pattern](https://tsoporan.com/blog/spine-pattern-multi-repo-ai-development/)

### Example 4: Black Dog Labs -- MCP-Based Cross-Repo Context

**What:** An MCP server that uses tree-sitter to extract specific symbols from other repos without loading entire codebases. Token-efficient (300 tokens vs 35,000 for full-repo loading).

**Key pattern:** `load_symbol` and `trace_dependency` tools. Registry of repos with paths and package names. Configurable depth and token budget.

**Relevance to Tryps:** Overkill for your setup (you have 3 repos, not 30 microservices), but the principle is sound -- load what you need, not everything.

**Blog:** [Claude Code Decoded: Multi-Repo Context](https://blackdoglabs.io/blog/claude-code-decoded-multi-repo-context)

### Example 5: LaunchDarkly -- SessionStart Hook for Dynamic Context

**What:** Uses LaunchDarkly AI Agent Configs to dynamically inject context at session start. The hook fetches configuration from a remote service and injects it into Claude's context.

**Key pattern:** SessionStart hook that pulls dynamic state from an external source, demonstrating that hooks can bridge the gap between ephemeral sessions and persistent state.

**Repo:** [launchdarkly-labs/claude-code-session-start-hook](https://github.com/launchdarkly-labs/claude-code-session-start-hook)

---

## 8. Recommendations for Tryps

### Priority 1: Create `~/.claude/CLAUDE.md` (Immediate, 10 minutes)

You have no global CLAUDE.md. Every Claude session starts without ecosystem awareness. Create it with:
- Repository ecosystem table
- Team roster
- Git conventions (develop branch, not main)
- `@import` to tryps-docs shared context file
- Your role and preferences

**File:** `~/.claude/CLAUDE.md`

### Priority 2: Create `~/tryps-docs/shared-context.md` (Immediate, 15 minutes)

A single file in tryps-docs that serves as the shared bridge. This is what both Jake's `@import` and Marty's file reads will point to. Keep it under 100 lines.

Contents:
- Current phase and priorities (what to work on now)
- Scope status summary (auto-generated from spec.md frontmatter)
- Recent decisions and their reasoning
- Team availability and current assignments
- Blockers

**File:** `~/tryps-docs/shared-context.md`

### Priority 3: Add SessionStart Hook (30 minutes)

Add to `~/.claude/settings.json` a SessionStart hook that:
1. Runs `git pull` on tryps-docs (quiet, timeout 5s)
2. Outputs current scope statuses from spec.md frontmatter
3. Outputs the shared-context.md contents

This gives every Claude session an automatic "morning briefing."

### Priority 4: Add `@import` to t4/CLAUDE.md (5 minutes)

Add a single line to the t4 repo CLAUDE.md:

```markdown
@~/tryps-docs/shared-context.md
```

Now when Jake opens Claude in t4, it automatically knows scope statuses and priorities.

### Priority 5: Set `autoMemoryDirectory` (5 minutes)

Point auto-memory to tryps-docs so it becomes shared state:

```json
// ~/.claude/settings.json
{
  "autoMemoryDirectory": "~/tryps-docs/claude-shared-memory/"
}
```

Or, if you prefer to keep Claude's auto-memory separate from Marty's context, keep the default location but ensure the global CLAUDE.md imports the shared context file.

### Priority 6: Clean Up Orphaned Worktree Memory (15 minutes)

Review and remove the 10+ orphaned worktree memory directories in `~/.claude/projects/`. They are from before the git-repo-derived path fix and are now dead weight.

### Priority 7: Standardize CLAUDE.md Across All Repos (30 minutes)

Add the ecosystem table to every repo's CLAUDE.md. Add `@~/tryps-docs/shared-context.md` import to each.

### Priority 8: SessionEnd Hook for Auto-Sync (20 minutes)

Add a SessionEnd hook that auto-commits and pushes changes to tryps-docs. This ensures decisions made in Claude sessions are immediately visible to Marty.

---

## Architecture Summary

```
~/.claude/CLAUDE.md                    # Jake's global context (ecosystem, team, prefs)
  @~/tryps-docs/shared-context.md      # imports shared state

~/.claude/settings.json                # Hooks, permissions, MCP servers
  SessionStart hook --> git pull tryps-docs, output scope statuses
  SessionEnd hook --> git commit/push tryps-docs changes
  PermissionRequest hooks (existing, keep)
  Stop hook (existing, keep)

~/t4/CLAUDE.md                         # App-specific (build, arch, patterns)
  @~/tryps-docs/shared-context.md      # imports shared state

~/tryps-docs/
  shared-context.md                    # THE bridge file (priorities, statuses, decisions)
  claude-shared-memory/                # Optional: redirected auto-memory
  scopes/*/spec.md                     # Source of truth (4-status frontmatter)

Marty (Hetzner):
  git pull tryps-docs                  # Reads shared-context.md
  git push tryps-docs                  # Writes observations back
```

### Write Pattern (Who Writes What)

| Writer | What | Where | When |
|--------|------|-------|------|
| Jake (manual) | Strategic decisions, priorities | `tryps-docs/shared-context.md` | When priorities change |
| Claude (auto) | Session learnings | `tryps-docs/claude-shared-memory/` or default auto-memory | During sessions |
| Claude (SessionEnd hook) | Auto-commit tryps-docs changes | tryps-docs git | End of each session |
| Marty | PR review observations, scope updates | `tryps-docs/scopes/*/spec.md` frontmatter | After each PR review |
| Devs | Scope status changes | `tryps-docs/scopes/*/spec.md` frontmatter | When work completes |
| SessionStart hook | Scope status summary | Claude's context (ephemeral) | Each session start |

### Read Pattern (Who Reads What)

| Reader | What | From | When |
|--------|------|------|------|
| Claude sessions | Shared context | `@import ~/tryps-docs/shared-context.md` | Session start (via CLAUDE.md) |
| Claude sessions | Scope statuses | SessionStart hook output | Session start |
| Claude sessions | Project memory | Auto-memory MEMORY.md | Session start |
| Marty | Shared context | `~/tryps-docs/shared-context.md` (git synced) | Before each task |
| Marty | Scope statuses | `~/tryps-docs/scopes/*/spec.md` | Before each task |
| Mission Control | Scope statuses | tryps-docs API or git read | On page load |

### Merge Conflict Avoidance

- `shared-context.md`: Single writer at a time (Jake or Claude, not simultaneous). Marty reads but does not write to this file.
- `spec.md` frontmatter: Different people update different scopes. Conflicts only if two people update the same scope simultaneously (rare, easily resolved).
- `claude-shared-memory/`: Only Claude writes. One-writer-at-a-time by nature of sequential sessions.

---

## Sources

- [Official Claude Code Memory Docs](https://code.claude.com/docs/en/memory)
- [Official Claude Code Best Practices](https://code.claude.com/docs/en/best-practices)
- [Official Claude Code Hooks Reference](https://code.claude.com/docs/en/hooks)
- [Trail of Bits claude-code-config](https://github.com/trailofbits/claude-code-config)
- [The Spine Pattern -- Titus Soporan](https://tsoporan.com/blog/spine-pattern-multi-repo-ai-development/)
- [Polyrepo Synthesis -- Rajiv Pant](https://rajiv.com/blog/2025/11/30/polyrepo-synthesis-synthesis-coding-across-multiple-repositories-with-claude-code-in-visual-studio-code/)
- [Multi-Repo Context Loading -- Black Dog Labs](https://blackdoglabs.io/blog/claude-code-decoded-multi-repo-context)
- [Beyond Single Repo -- Leonardo (DEV Community)](https://dev.to/leonardobybyte/beyond-the-single-repo-how-i-use-claude-code-across-microservices-hl5)
- [Claude Code Memory Explained -- Jose Parreo Garcia](https://joseparreogarcia.substack.com/p/claude-code-memory-explained)
- [SFEIR Institute Optimization Guide](https://institute.sfeir.com/en/claude-code/claude-code-memory-system-claude-md/optimization/)
- [LaunchDarkly SessionStart Hook](https://github.com/launchdarkly-labs/claude-code-session-start-hook)
- [Claude Code Session Hooks](https://claudefa.st/blog/tools/hooks/session-lifecycle-hooks)
- [Global vs Project CLAUDE.md](https://raythanni.substack.com/p/claude-code-memory-files-global-vs)
- [Claude Code Worktrees Guide](https://claudefa.st/blog/guide/development/worktree-guide)
- [Git Worktree Isolation (Rick Hightower)](https://medium.com/@richardhightower/git-worktree-isolation-in-claude-code-parallel-development-without-the-chaos-262e12b85cc5)
- agent-native-architecture skill (shared-workspace-architecture, dynamic-context-injection, files-universal-interface references)
- hook-development skill
- claude-md-improver skill
- claude-automation-recommender skill
