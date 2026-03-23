---
title: Marty Revamp — Full Plan
date: 2026-03-23
status: draft
assignee: jake
---

# Marty Revamp Plan

> Marty stops being a notification bot and becomes a learning teammate.

## Current State (What's Broken)

- **3 cron jobs running:** `sync-tryps-docs` (30min, useful), `dashboard-data` (2hr, for dead MC dashboard), `morning-standup` (8am, broken — wrong Slack channel)
- **HEARTBEAT.md is PAUSED** — all autonomous messaging disabled
- **ClickUp token expired** — Marty can't read task status
- **Sessions reset after 4 hours** — Marty forgets everything between conversations
- **Memory scattered:** 84MB vector DB + daily .md files + curated MEMORY.md, but no systematic distillation
- **TOOLS.md is thin** — no gotchas, no "here's how to actually do X"
- **Repos fragmented:** `marty-workspace` (8 commits), `mission-control` (discontinued), `tryps-docs` (shared state)
- **No cost visibility** — one Anthropic API key, no per-person tracking

## Target State

Marty runs **3 daily touchpoints** and has a **single, auditable brain** that any dev or agent can review.

---

## Phase 1: Clean House

### 1a. Kill Dead Crons

SSH into Hetzner. Delete `dashboard-data` (MC dashboard is dead) and `morning-standup` (being replaced) from `~/.openclaw/cron/jobs.json`. Keep `sync-tryps-docs.sh` system cron (still useful).

### 1b. Fix ClickUp Token

Rotate the expired ClickUp API token. Update `~/.openclaw/secrets.env` and `workspace-marty/clickup-token.txt`.

### 1c. Repo Consolidation

Kill `marty-workspace` as a standalone repo. Move its contents into `tryps-docs/marty/`:

```
tryps-docs/
  marty/
    SOUL.md              # Personality, values
    USER.md              # Jake's profile, working style
    IDENTITY.md          # Role definition, capabilities
    TOOLS.md             # ★ Comprehensive tool guide with gotchas (rewritten)
    MEMORY.md            # Long-term curated memory
    AGENTS.md            # Boot sequence
    HEARTBEAT.md         # Scheduled routines (rewritten for new system)
    memory/              # Daily memory files
    skills/              # All 16 skills
    crons/               # Cron job definitions (documented, auditable)
    reports/             # Nightly reports archive
    templates/
      standup-template.md
      nightly-report-template.md
```

Point Marty's OpenClaw workspace to clone from `tryps-docs/marty/` instead of `marty-workspace`. Archive `mission-control` on GitHub, remove its Docker container from Hetzner.

### 1d. Update Sync Script

Modify `sync-tryps-docs.sh` to sync `tryps-docs/marty/` into the OpenClaw workspace (in addition to existing shared state sync).

---

## Phase 2: Standup Automation

### How It Works

```
8:00 PM  →  Marty generates tomorrow's standup doc
             - 5 personalized questions per dev
             - Based on: ClickUp status, yesterday's answers, PR activity, scope progress
             - Written to tryps-docs/docs/standups/YYYY-MM-DD-standup.md
             - Committed and pushed

overnight →  Jake reviews in nightly report (see Phase 3)

morning  →  Devs open standup doc, answer 5 questions directly in the .md
             - Via Claude Code + Wispr Flow
             - Each dev edits only their section
             - Commit and push

2:00 PM  →  Standup meeting — team reviews the answered doc together

after    →  Marty reads the answered version
             - Extracts learnings into daily memory file
             - Updates MEMORY.md with key organizational knowledge
             - Uses answers to inform tomorrow's questions
```

### The Learning Loop

Marty's questions get **smarter over time** because:

1. He reads every answer and distills patterns
2. He tracks what devs say vs. what actually ships (ClickUp status changes)
3. He notices when someone says "blocked on X" and follows up the next day
4. He learns each dev's communication style and what level of specificity to ask for

### New Cron: `standup-generator`

- **Schedule:** Daily at 8:00 PM ET
- **Action:** Run enhanced `tryps-standup` skill
- **Inputs:** ClickUp tasks, GitHub PRs/commits, yesterday's standup answers, scope specs
- **Output:** `tryps-docs/docs/standups/YYYY-MM-DD-standup.md`
- **Delivery:** Commit + push, post link to #martydev

### Skill Enhancement: `tryps-standup`

Rewrite to:

1. Read yesterday's answered standup (learn from answers)
2. Pull each dev's ClickUp tasks (status, blockers, due dates)
3. Pull each dev's GitHub activity (PRs, commits, reviews)
4. Read each dev's scope spec (success criteria, progress)
5. Generate 5 **specific, probing** questions per dev that:
   - Follow up on yesterday's answers ("You said X was blocked — is it unblocked?")
   - Challenge vague claims ("You said '30 of 57 done' — which ones specifically?")
   - Surface risks early ("SC-42 depends on Rizwan's API — have you tested the interface?")
   - Ask what Marty needs to learn ("What changed about the approach since last time?")
   - Get the dev's honest assessment ("What's the one thing most likely to slip?")

---

## Phase 3: Nightly Report

### Format: Printable HTML

Marty generates a single HTML file styled for print (clean typography, no chrome, ~3-5 pages). Jake opens in browser and Cmd+P.

### Report Structure

```
┌─────────────────────────────────────────┐
│  TRYPS NIGHTLY BRIEF — March 24, 2026   │
│  Prepared by Marty                       │
├─────────────────────────────────────────┤
│                                         │
│  1. TOMORROW'S STANDUP                  │
│     [5 questions per dev, formatted]    │
│                                         │
│  2. TECH TWITTER DIGEST                 │
│     @stakejein viral posts              │
│     Karpathy / Altman / Elon / a16z     │
│     What's trending in AI/tech          │
│                                         │
│  3. TRENDING GITHUB REPOS               │
│     Top 3 repos + why they matter       │
│                                         │
│  4. TODAY'S DEEP DIVE                   │
│     [1-pager on topic Jake picked]      │
│     e.g., GEO/AEO for early startups   │
│                                         │
│  5. STRATEGY CHECK                      │
│     Marty's understanding of:           │
│     - Current sprint status             │
│     - Top risks / blockers              │
│     - Areas Jake should focus on        │
│     - What Marty thinks the priority is │
│     [Jake corrects via voice/text]      │
│                                         │
│  6. COST SNAPSHOT                       │
│     API spend today: $X.XX              │
│     By session: Jake $X, Asif $X, etc.  │
│                                         │
└─────────────────────────────────────────┘
```

### New Cron: `topic-suggestion`

- **Schedule:** Daily at 3:00 PM ET
- **Action:** DM Jake on Slack with 3 lines: suggested topic + why it's relevant right now
- **Logic:** Pull from Jake's calendar, ClickUp status, recent conversations

### New Cron: `nightly-report`

- **Schedule:** Daily at 8:30 PM ET (after standup generation)
- **Inputs:** Tomorrow's standup doc, X/Twitter data via x402 (@stakejein + curated accounts), GitHub trending, topic from Jake's 3pm response, strategy context from MEMORY.md, cost data
- **Output:** `tryps-docs/marty/reports/YYYY-MM-DD-nightly.html`
- **Delivery:** Slack DM to Jake with link + "Ready to print"

### X/Twitter Integration

Use x402 / stablesocial.dev to pull recent posts from @stakejein + trending from @karpathy, @sama, @elonmusk, @pmarca, @OpenAI, @AnthropicAI. Filter for engagement, surface with one-liner context.

### GitHub Trending

Scrape GitHub trending daily. Filter for AI/agents, travel tech, React Native/Expo, Supabase, TypeScript. Surface top 3 with star count + one-line description.

---

## Phase 4: Memory Overhaul

### 4a. Rewrite TOOLS.md

Rewrite as comprehensive operator's manual. Each tool gets three sections:

```markdown
## [Tool Name]
### What you can do
### How to do it (with examples)
### Gotchas (where things commonly fail)
```

Tools: GitHub (gh CLI), ClickUp (API via curl), Google Calendar + Gmail (gog CLI), Zoom (API), Slack (socket mode), Supabase (MCP), x402 / stablesocial.dev.

### 4b. Memory Distillation System

New skill: `memory-distill`. Runs after Marty reads standup answers. Extracts key facts, decisions, blockers, patterns. Writes to daily memory file. Periodically promotes important patterns to MEMORY.md. Prunes stale entries.

### 4c. Session Bootstrap Improvement

Update AGENTS.md to load more context on session start:
- Always load TOOLS.md (currently not loaded)
- Load last 3 days of memory files (not just MEMORY.md)
- Load current sprint context from ClickUp
- Load the most recent standup answers

### 4d. Increase Session TTL

Change DM session timeout from 240 min → 480 min (8 hours) in `openclaw.json`.

---

## Phase 5: Cost Visibility

### Approach: OpenClaw Session Tracking

OpenClaw tracks token usage per session in logs. Parse `~/.openclaw/logs/` for daily totals. Attribute to user based on session initiator (DM from Jake vs. Asif vs. cron). Sum tokens × pricing.

### New Cron: `cost-report`

- **Schedule:** Daily at 7:00 PM ET
- **Action:** Parse today's session logs, calculate costs, post to Slack
- **Output:** Also feeds into nightly report

---

## Implementation Order

| # | Task | Effort | Depends On |
|---|------|--------|------------|
| 1 | Kill dead crons + fix ClickUp token | 30 min | Nothing |
| 2 | Repo consolidation (marty → tryps-docs/marty/) | 2-3 hrs | #1 |
| 3 | Rewrite TOOLS.md with gotchas | 2-3 hrs | #2 |
| 4 | Rewrite AGENTS.md (better session bootstrap) | 1-2 hrs | #2 |
| 5 | Enhance `tryps-standup` skill for question generation | 3-4 hrs | #2, #3 |
| 6 | Build standup cron (8pm generation) | 1-2 hrs | #5 |
| 7 | Build topic-suggestion cron (3pm DM) | 1 hr | #2 |
| 8 | Build nightly report template + generation | 4-6 hrs | #5, #6, #7 |
| 9 | Wire up X/Twitter via x402 | 2-3 hrs | #8 |
| 10 | Wire up GitHub trending | 1-2 hrs | #8 |
| 11 | Build cost tracking script | 2-3 hrs | #2 |
| 12 | Wire cost into nightly report + Slack | 1 hr | #8, #11 |
| 13 | Memory distillation skill | 3-4 hrs | #5 |
| 14 | Session TTL + bootstrap tuning | 1 hr | #3, #4 |
| 15 | Archive mission-control repo | 30 min | #2 |

### Who Does What

- **Jake + Claude Code:** All phases — Jake drives implementation via Claude Code sessions
- **Asif:** Available to audit Marty's memory architecture after consolidation (Phase 1)
- **Dev review:** Anyone can audit `tryps-docs/marty/` once consolidated

---

## Success Criteria

1. Marty generates tomorrow's standup questions every night at 8pm — questions are specific, scope-aware, and build on prior answers
2. Nightly report lands in Jake's Slack DM by 8:30pm, printable, with all 6 sections
3. All dead crons killed, ClickUp token working
4. Marty's entire brain lives in `tryps-docs/marty/` — any dev can read and audit it
5. TOOLS.md is comprehensive enough that a new OpenClaw instance could bootstrap from it
6. Daily API cost posted to Slack with per-person attribution
7. After 2 weeks: Marty's questions are noticeably better than day 1 (learning loop working)

---

## Kickoff Prompt

```
Read the Marty revamp plan at ~/tryps-docs/docs/plans/2026-03-23-marty-revamp-plan.md

Execute the phases sequentially. Start with Phase 1: Clean House.

1. SSH into Marty's server (ssh -i ~/.ssh/hetzner openclaw@178.156.176.44)
2. Kill the dashboard-data and morning-standup cron jobs from ~/.openclaw/cron/jobs.json
3. Fix the ClickUp token — rotate it and update secrets.env + clickup-token.txt
4. Begin repo consolidation: create tryps-docs/marty/ directory structure, copy files from marty-workspace
5. Update sync-tryps-docs.sh to sync tryps-docs/marty/ into the OpenClaw workspace
6. Archive the mission-control Docker container on Hetzner and the GitHub repo

Then proceed through Phases 2-5 in order. Confirm with me before moving to each new phase.
```
