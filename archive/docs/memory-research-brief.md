# Memory System Research Brief

## Who We Are

**Tryps** is a travel app (Expo SDK 55 + TypeScript + Supabase + Expo Router) built by a team of 5: Jake (product/founder), Asif (lead dev), Nadim & Muneeb (devs), Andreas (QA). The app lives in the `t4` repo with `develop` as the default branch.

**Marty** is our AI agent — an OpenClaw (Claude-based agentic framework) instance running 24/7 on a Hetzner server (Ubuntu 24.04, 15GB RAM). Marty has his own workspace, skills, memory (SQLite + markdown), and communicates via Slack. He runs autonomously — reviewing PRs, triaging bugs, generating standups, reviewing specs.

**Claude Code** is used by Jake (and sometimes devs) in local terminal sessions, often with multiple worktrees running in parallel. These sessions are ephemeral — each starts with whatever context is in `~/.claude/projects/.../memory/MEMORY.md` (currently 21 lines) plus whatever's in the repo's `CLAUDE.md`.

## Our Repositories

| Repo | Location (local) | Location (Marty) | Purpose |
|------|------------------|-------------------|---------|
| **t4** | ~/t4 | — | The Tryps app codebase |
| **tryps-docs** | ~/tryps-docs | ~/tryps-docs (git-synced) | Scope specs, pipeline docs, reports |
| **mission-control** | ~/mission-control | Docker on Hetzner | Web dashboard for visualizing Marty's work |

**tryps-docs is the only repo that both Jake's local machine and Marty's server share via git sync.** This makes it the natural bridge.

## The Current Memory Problem

Memory is fragmented across 5 silos that don't talk to each other:

1. **Jake's local Claude memory** (`~/.claude/projects/-Users-jakestein/memory/MEMORY.md`) — 21 lines of curated feedback, project context, references. Only readable by Jake's Claude sessions.

2. **Marty's workspace MEMORY.md** (`/home/openclaw/.openclaw/workspace/MEMORY.md` on Hetzner) — 330 lines of product knowledge, architecture, stack, patterns. Only readable by Marty.

3. **Marty's SQLite DB** (`/home/openclaw/.openclaw/memory/marty.sqlite`) — 33MB of conversation/task history. Only readable by Marty.

4. **tryps-docs/scopes/** — Up to 10 pipeline artifact files per scope × 21 scopes across 5 phases. Shared via git but bloated with transient artifacts nobody references after creation.

5. **Per-worktree MEMORY.md copies** — Each of Jake's parallel Claude worktrees has its own memory that drifts from the others.

**The result:** Every session starts partially blind. Jake has to re-explain context. Marty doesn't know what Jake decided in a Claude session. Claude sessions don't know what Marty observed overnight. Nobody has a single view of "where everything stands."

## What We've Already Decided (This Session)

### 1. Simplify scope lifecycle to 4 statuses
The 10-step pipeline with 10 artifact files per scope is dead. Each scope now has:
- **One file:** `spec.md` (with success criteria)
- **Status in frontmatter** with 4 values:
  - `to-be-built`
  - `ready-for-testing`
  - `tested-confirmed`
  - `tested-failed` (goes back to build)

### 2. Status lives in spec.md frontmatter
Not in a separate database or index file. The spec IS the source of truth. Devs, QA, Jake, and Marty all update it directly. Mission control reads from it.

### 3. tryps-docs is the shared bridge
It's the only repo both local and Marty can read/write via git. Any shared state should flow through here.

## What We Need the Research to Answer

### Primary Question
**What is the best architecture for persistent, shared memory across a human (Jake), an autonomous AI agent (Marty/OpenClaw on a server), and ephemeral Claude Code terminal sessions — given that tryps-docs (a git repo) is the shared bridge?**

### Specific Sub-Questions

1. **Shared vs. personal memory boundaries:** What should be shared (visible to all: Jake, Marty, Claude sessions) vs. personal (Jake's preferences, Marty's internal state)? Where does the line go?

2. **Memory format and structure:** Should shared memory be a single markdown file? A directory of files with frontmatter? A JSON/YAML index? What format optimizes for both human readability AND AI consumption?

3. **Memory categories:** What categories of shared knowledge matter? Examples:
   - Scope statuses (solved: spec.md frontmatter)
   - Team context (who's on what, availability, blockers)
   - Recent decisions and their reasoning
   - Observations (patterns Marty notices, recurring issues)
   - Strategic priorities (what to build next and why)
   - Cross-repo state (what's happening in t4 that affects scopes)

4. **Write patterns:** Who writes what, and when? Should Marty auto-update a shared state file after every PR review? Should Claude sessions write back observations? How do we avoid merge conflicts on shared files?

5. **Read patterns / auto-loading:** How do we ensure every Claude session automatically loads shared context without manual effort? Options include:
   - CLAUDE.md `@import` directives pointing to tryps-docs
   - A "context loader" that runs at session start
   - Keeping shared memory small enough to always load (like MEMORY.md)
   - Symlinks from local memory to tryps-docs files

6. **tryps-docs cleanup:** We're going from 10 files per scope to 1 (spec.md). What do we do with the existing artifacts? Delete them? Archive them? And what should the new tryps-docs structure look like?

7. **Mission Control integration:** The `/criteria` page at marty.jointryps.com should reflect the new 4-status system. How should MC read from tryps-docs? Direct git read? API that parses spec frontmatter? Webhook on push?

8. **Cross-repo context for Claude sessions:** When Jake opens Claude in `t4` (the app repo), how does that session know about scope statuses and priorities that live in tryps-docs? The repos are separate. Options:
   - Symlink tryps-docs state files into t4
   - CLAUDE.md in t4 references tryps-docs paths
   - A "spine" meta-context that sits above both repos
   - Jake's global `~/.claude/CLAUDE.md` loads shared state

9. **Ecosystem best practices:** What are teams with similar setups (multiple repos, AI agents, shared context) actually doing? What patterns from the Claude Code community, OpenClaw ecosystem, or multi-agent architectures are proven?

10. **Migration plan:** How do we get from the current fragmented state to the new system without breaking anything? What's the order of operations?

## Constraints

- **tryps-docs syncs via git** — any shared state must be git-friendly (no binary blobs, merge-conflict-safe)
- **Marty runs on Hetzner** — he can read/write local files and push to git, but can't access Jake's local filesystem directly
- **Claude Code sessions are ephemeral** — they load MEMORY.md and CLAUDE.md at start, that's it. No persistent daemon.
- **Team of 5** — solution must be simple enough that devs and QA can update status without understanding the whole system
- **Keep it simple** — we're a small team shipping fast. The memory system should be lightweight, not enterprise infrastructure.

## Current File Locations (for reference)

**Local (Jake's Mac):**
- App code: `~/t4/`
- Docs: `~/tryps-docs/`
- Mission Control: `~/mission-control/`
- Claude memory: `~/.claude/projects/-Users-jakestein/memory/`
- Claude commands: `~/.claude/commands/`
- Global Claude config: `~/.claude/CLAUDE.md` and `~/.claude/settings.json`

**Marty (Hetzner 178.156.176.44):**
- Docs (synced): `/home/openclaw/tryps-docs/`
- OpenClaw state: `/home/openclaw/.openclaw/`
- Workspace: `/home/openclaw/.openclaw/workspace/`
- Memory DB: `/home/openclaw/.openclaw/memory/marty.sqlite`
- Skills: `/home/openclaw/.openclaw/skills/`
- Sync script: `/home/openclaw/sync-tryps-docs.sh` (git pull/push on cron)

## What "Success" Looks Like

1. Jake opens a Claude terminal anywhere → session already knows all scope statuses, current priorities, recent decisions, and team context
2. Marty finishes a PR review → shared state updates automatically, Jake's next session sees it
3. A dev marks a scope as `ready-for-testing` in spec.md → Marty knows, Jake knows, mission control shows it
4. Jake makes a strategic decision ("we're deprioritizing p4") → Marty respects it in his next planning cycle without being told again
5. No searching, no re-explaining, no cold starts. The system remembers.
