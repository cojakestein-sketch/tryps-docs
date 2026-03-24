---
title: "Marty Improvement Day"
type: feat
date: 2026-03-24
status: active
assignees: [asif, nadeem, rizwan]
---

# Marty Improvement Day

> Every dev ships a PR that makes Marty better. By end of day, Marty has 3 new capabilities.

## Background

Last night (March 23) we completed a full Marty revamp:
- Killed dead crons, fixed ClickUp token, consolidated repos
- Built standup automation (8pm cron, personalized questions, learning loop)
- Built nightly report (printable HTML, 6 sections, 8:30pm cron)
- Built topic suggestion (3pm Slack DM to Jake)
- Rewrote TOOLS.md (300+ lines with gotchas), improved session bootstrap
- Built memory distillation skill, increased session TTL to 8 hours
- Built cost reporting (7pm cron, daily Slack + nightly report)

Then we ran 6 research agents to evaluate what's next. The findings are below. Today, each dev owns one scope and ships a PR.

---

## Where Marty Lives (Read This First)

### The Repo

**Everything lives in `tryps-docs/marty/`** on the `main` branch. This is Marty's brain. A sync script on Hetzner pulls this directory every 30 minutes and copies it into Marty's OpenClaw workspace.

```
tryps-docs/
  marty/
    SOUL.md              # Personality, values
    USER.md              # Jake's profile, working style
    IDENTITY.md          # Role definition, capabilities
    TOOLS.md             # Comprehensive tool guide with gotchas
    MEMORY.md            # Long-term curated memory (22KB)
    AGENTS.md            # Boot sequence — what Marty loads on session start
    HEARTBEAT.md         # Scheduled routines
    memory/              # Daily memory files (16 files, Mar 8-23)
    skills/              # All skills (16 total) — each has a SKILL.md
      tryps-standup/     # Standup question generation
      nightly-report/    # Printable HTML brief
      topic-suggestion/  # 3pm topic DM
      cost-report/       # Daily cost estimate
      memory-distill/    # Extract learnings from standup answers
      tryps-pr-review/   # PR convention review
      tryps-bug-triage/  # Bug triage from Slack
      spec-interview/    # Three-mode spec generation
      ... (13 more)
    reports/             # Nightly reports archive
```

### How to Edit Marty

1. Clone or pull `tryps-docs` (branch: `main`)
2. Edit files in `marty/` — skills, TOOLS.md, AGENTS.md, etc.
3. Commit and push to main
4. The sync script on Hetzner picks up changes within 30 minutes
5. To force-sync immediately: `ssh -i ~/.ssh/hetzner openclaw@178.156.176.44 "~/sync-tryps-docs.sh"`
6. Some changes (cron jobs, openclaw.json) require a gateway restart: `ssh -i ~/.ssh/hetzner openclaw@178.156.176.44 "systemctl --user restart openclaw-gateway.service"`

### How to Add a New Skill

Create a directory under `marty/skills/` with a `SKILL.md`:

```
marty/skills/your-skill-name/
  SKILL.md    # Skill definition (see existing skills for format)
```

SKILL.md frontmatter:
```yaml
---
name: your-skill-name
description: What the skill does (one line)
user-invocable: true   # false if it's a subagent-only skill
---
```

### How to Add a New Cron Job

Cron jobs are managed via OpenClaw's `~/.openclaw/cron/jobs.json` on Hetzner. Currently 4 jobs:

| Job | Schedule (ET) | Purpose |
|-----|---------------|---------|
| topic-suggestion | 3:00 PM | DM Jake a deep-dive topic |
| cost-report | 7:00 PM | Post daily cost estimate to #martydev |
| standup-generator | 8:00 PM | Generate tomorrow's standup questions |
| nightly-report | 8:30 PM | Generate printable HTML brief |

To add a new cron, SSH into Hetzner and edit `~/.openclaw/cron/jobs.json` (or write a local script that SCPs the updated file).

### Marty's Server

- **Host:** 178.156.176.44
- **User:** openclaw
- **SSH:** `ssh -i ~/.ssh/hetzner openclaw@178.156.176.44`
- **OpenClaw version:** 2026.3.8
- **Model:** Claude Opus (primary), Sonnet (fallback/crons)
- **Gateway:** port 18789 (loopback only)
- **Workspace:** `~/.openclaw/workspace-marty/`

### Marty's Tools

| Tool | How it works | Key gotcha |
|------|-------------|------------|
| GitHub | `gh` CLI, account `marty-source` | Default branch is `develop` in tripful, `main` in tryps-docs |
| ClickUp | API via curl with `$CLICKUP_API_KEY` | CLI is write-only — use curl for reads |
| Google Calendar | `gog` CLI | Jake's cal: jake@jointryps.com |
| Gmail | `gog` CLI | Marty's email: marty@jointryps.com |
| Zoom | REST API with OAuth | No passcode, no waiting room ever |
| Slack | Socket mode | DM allowlist: only Jake. Channels require @mention |
| Supabase | MCP server | Read-only in most contexts |
| Brave Search | API key in secrets.env | For web research, used in nightly report |

Full details in `marty/TOOLS.md`.

---

## Assignments

### Asif — Beta Feedback Ingestion + Deployment Guardian + Dev Interaction Model

**Scope:** Build two new Marty skills that automate feedback routing and deployment safety. **Also define how Marty should interact with devs day-to-day** — especially around GitHub issue triage, code fix suggestions, and PR support. Other teams using OpenClaw-style agents are having their agents monitor GitHub issues, suggest fixes, and even open PRs. Define this process for Tryps.

**Research findings:**
- Marty already has Gmail (gog CLI), Slack (socket mode), and ClickUp (API) access — all the tools needed for feedback ingestion
- The OTA desync bug (documented in MEMORY.md: "OTA always wins. After submit, run update.") is a known footgun that a deployment guardian would eliminate
- Expo has official `expo-deployment` skills for AI agents and `npx testflight` handles the full build-sign-submit pipeline
- Only 23% of customer feedback gets analyzed without AI assistance — this is the biggest knowledge leak in early-stage companies

**Deliverable:** PR to `tryps-docs` with:
- `marty/skills/beta-feedback-triage/SKILL.md` — skill that scans Gmail + Slack for beta feedback, categorizes (bug/feature/UX friction/praise), deduplicates against ClickUp, creates tasks, weekly digest
- `marty/skills/tryps-deploy/SKILL.md` — skill with 3 modes: `staging` (auto on merge), `testflight` (approval-gated), `check` (verify OTA sync)
- A "Marty Dev Interaction Model" doc defining how Marty should interact with devs daily: GitHub issue triage → code fix suggestions → PR support. What's autonomous vs. human-gated. How Marty routes issues to the right dev. How Marty suggests lines of code to fix. This is a process definition, not just a skill.
- Any cron job definitions documented in `marty/crons/` (even if not installed yet)

---

### Rizwan — Automated QA Runner + Marty Memory System

**Scope:** Dual scope. (A) Research and build the infrastructure plan for automated mobile QA testing on Hetzner using Maestro. (B) Audit Marty's entire memory system and propose improvements.

**Research findings:**
- Maestro is Expo's recommended E2E testing framework, used by Microsoft, Meta, DoorDash
- Maestro has an MCP server with 47+ tools for simulator control (tap, swipe, assert, screenshot)
- `assertWithAI` and `assertNoDefectsWithAI` commands let AI verify visual correctness
- Android emulator works on Linux (Hetzner) — no Mac needed. iOS stays manual with Andreas.
- TestSprite is an alternative that auto-generates tests and self-heals broken selectors
- A GitHub project `senaiverse/claude-code-reactnative-expo-agent-system` packages 7 production agents for RN/Expo including dedicated testing agents

**Deliverable:** PR to `tryps-docs` with:
- `marty/skills/tryps-qa-runner/SKILL.md` — skill definition for running Maestro test flows against Android emulator
- `tryps-docs/docs/plans/2026-03-24-feat-qa-runner-infrastructure-plan.md` — detailed infrastructure plan: what needs to be installed on Hetzner, how to build APKs, how to run headless emulator, how to integrate with PR review pipeline
- At least 3 example Maestro YAML flow files for critical paths (invite flow, trip creation, voting)
- **Memory system audit:** Read the full memory system (`marty/MEMORY.md`, `marty/memory/`, `marty/AGENTS.md`, `marty/skills/memory-distill/SKILL.md`). Write an assessment: Is the architecture sound? What's missing? How should memory decay/archival work? Compare to deer-flow's memory patterns. Propose improvements.

---

### Nadeem — Design-to-Code Bridge

**Scope:** Set up the Figma MCP server integration and build a design audit skill for Marty.

**Research findings:**
- Figma's official MCP server (launched 2025, expanded March 2026) exposes design metadata as structured data — frames, components, design tokens, variables, styles
- It works with Claude Code, Cursor, VS Code, and 15+ other clients
- Supports both remote (`https://mcp.figma.com/mcp`) and desktop server modes
- Anima API (1.5M Figma installs) bridges Figma and coding AI agents for pixel-perfect code
- Known drift already documented: `.pen` file uses Space Grotesk instead of Plus Jakarta Sans, red is `#DC2626` vs correct `#D9071C`, background should be white/light gray per Figma not warm cream
- **Figma is the design source of truth** — not `theme.ts`, not `brand.md`. Nadeem's job is to reconcile all three: audit Figma, theme.ts, and brand.md, document every discrepancy, and propose a plan where Figma leads, code follows, and brand.md documents

**Deliverable:** PR to `tryps-docs` with:
- `marty/skills/design-audit/SKILL.md` — skill with two modes: (A) PR Design Check (automated on every PR, compares changed screen components against Figma design tokens), (B) Full Component Inventory (weekly, maps Figma components to RN components, flags drift)
- A plan for how to get the Figma MCP server connected (what token Jake needs to generate, where to add it in Marty's config)
- Initial component mapping if possible: which Figma frames map to which `t4/components/` files

**Note:** Jake needs to generate a Figma Dev Mode token (requires paid plan with Dev or Full seat). Nadeem should document exactly what Jake needs to do.

---

## Obsidian for Marty's Brain

**Free. Zero setup.** Download Obsidian, open `tryps-docs/marty/` as a vault, click the graph icon. You can now see all of Marty's memory files as an interactive knowledge graph — clusters, orphans, connections.

This is a human auditing tool, not an agent tool. It lets Jake (or any dev) browse Marty's brain visually and spot gaps. If we start using `[[wikilinks]]` in memory files (e.g., `[[Nadeem]]`, `[[output-backed-screen]]`), the graph gets richer for free.

**Action item for tomorrow:** Someone download Obsidian, point it at `tryps-docs/marty/`, screenshot the graph, and share in Slack. No code required.

---

## Timeline

| Time | What happens |
|------|-------------|
| Morning | Devs read this plan + the standup doc. Answer 5 questions via Wispr Flow. |
| 2:00 PM | Standup — review answers, align on approach, resolve open questions |
| 2:00-6:00 PM | Build. Each dev implements their scope. |
| 6:00 PM | PRs pushed to `tryps-docs` (branch off main, PR into main) |
| Evening | Jake reviews PRs. Marty's 8pm standup cron fires with tomorrow's questions. |

---

## Success Criteria

1. 3 PRs opened against `tryps-docs` by 6pm — one from each dev
2. Each PR contains at least one new skill SKILL.md
3. Each PR contains a research/plan document for their scope
4. All standup questions answered in the standup doc by 2pm
5. Bonus: Obsidian screenshot of Marty's brain graph shared in Slack

---

## Kickoff Prompt (for each dev)

Each dev should paste their section's prompt into Claude Code to get started. See tomorrow's standup doc for the full prompts.
