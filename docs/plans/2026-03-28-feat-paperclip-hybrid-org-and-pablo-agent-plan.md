---
title: "Paperclip Hybrid Org + Pablo Design Agent"
type: feat
date: 2026-03-28
status: draft
owner: jake
---

# Paperclip Hybrid Org + Pablo Design Agent

## Overview

Stand up a Paperclip AI org that augments the existing Tryps human team with specialized AI agents. The headline agent is **Pablo** — a design specialist that creates brand book pages, app screens, and UI components directly in Figma. The broader org includes a CMO for brand/GTM, two bug-fixing engineers, and Marty integrated as an existing employee.

## Why Now

- Sean's brand book (M1 deadline April 2) needs 56+ screens designed in Figma — Pablo can draft these overnight
- 78 open bugs with Nadeem at 7/48 SC — bug-fixing agents can open PRs for human review
- Brand/GTM has 9 workstreams, many AI-automatable (UGC creator list, launch video research, SEO)
- Figma's official MCP server launched March 24 with **write-to-canvas** — the Figma gap no longer exists
- Paperclip is already running locally at `http://127.0.0.1:3100`

---

## Phase 1: Pablo — The Design Agent (Day 1)

### 1.1 Install Figma MCP Server

The official Figma MCP server (launched 2026-03-24) gives Claude Code native Plugin API access — create frames, text, components, auto layout, variables directly on the Figma canvas.

**Steps:**
- [ ] Run `claude plugin install figma@claude-plugins-official`
- [ ] Authorize via OAuth with `jake@jointryps.com` (Pro plan = full write access)
- [ ] Verify write access: create a test frame in the Tryps file (`CMhozPKkLjWk4pcKHsbTJF`)
- [ ] Confirm the `use_figma` tool appears in Claude Code's tool list

**Fallback:** The existing `/figma-design` + `/figma-capture` pipeline (HTML mockup -> local serve -> html.to.design capture) is proven and remains available if the MCP server has issues.

### 1.2 Create Pablo's Figma Skill

Figma MCP uses "Skills" — markdown files that teach agents your design conventions. Pablo needs a Tryps-specific skill.

**Create:** `~/.paperclip/instances/default/companies/<id>/agents/pablo/skills/tryps-design-system/SKILL.md`

**Skill contents (derived from existing sources):**

| Source | What Pablo Learns |
|--------|------------------|
| `~/tryps-docs/shared/brand.md` | Colors, typography, spacing, border radius, shadows, voice |
| `~/t4/utils/theme.ts` | Exact token values (source of truth for code) |
| `~/tryps-docs/marty/skills/design-audit/figma-component-map.json` | 35 code-to-Figma mappings |
| `~/tryps-docs/brand-and-gtm/reference/brand-book-screen-checklist.md` | 56-screen target list |
| `~/tryps-docs/brand-and-gtm/designs/brand-book-make-prompts.md` | 64 screen prompts (75KB, copy-paste ready) |
| Flite brand book PDF | Quality bar / structural reference (NOT design tokens) |

**Key brand rules to encode:**
- Font: Plus Jakarta Sans (all weights), Space Mono (numbers/dates)
- Primary: Tryps Red `#D9071C` (warm, NOT aggressive, never for errors)
- Background: White/light gray per Figma (`#F9FAFB`), NOT warm cream (brand.md drift)
- Error red: `#D14343` (distinct from brand red)
- Dark mode: `#1E1B19` background (warm, never cool gray or pure black)
- Shadows: max 0.1 opacity, barely there
- Aesthetic: Film camera texture, grain, warmth, disposable camera energy
- Personality: Anthony Bourdain — warm, no pretense, curious

### 1.3 Register Pablo in Paperclip

**Agent config:**

| Field | Value |
|-------|-------|
| Name | Pablo |
| Role | UI & Brand Designer |
| Adapter | `claude_local` |
| Model | Claude Opus 4.6 (design quality matters) |
| Working directory | `~/tryps-docs` (brand assets) + read access to `~/t4` (code tokens) |
| Reports to | CEO agent (or direct to Jake as board) |
| Heartbeat | Wake on assignment only (no timer — Pablo works when given a brief) |
| Budget | $50/month to start (monitor and adjust) |
| Skills | `tryps-design-system`, `figma-mcp` |

**Pablo's SOUL.md — key traits:**
- Thinks like a senior brand designer, not a developer
- Presents 2-3 options per brief, never just one
- Uses the Flite brand book structure as a layout reference
- Understands the difference between brand book pages (editorial, polished) and app screens (functional, systematic)
- Always creates in the "Building the World" section of the Tryps Figma file
- Never uses Space Grotesk or `#DC2626` — those are legacy drift

**Pablo's HEARTBEAT.md — execution loop:**
1. Check for assigned design briefs (Paperclip issues)
2. Read the brief — understand what screen/component/page is needed
3. Read current Figma state via MCP (what exists already)
4. Design the element using `use_figma` tool — native Figma frames, not images
5. Comment on the issue with a link to the Figma frame
6. Move issue to "review" status

### 1.4 First Task for Pablo

**Task: Draft 5 brand book cover pages**

Using the Flite PDF as structural reference and the Tryps brand tokens:
1. Cover page (Brand Guidelines title + Tryps logo)
2. Brand Platform section divider
3. Core Idea page (equivalent to Flite's "Your Way")
4. Vision page
5. Mission page

Success criteria: Jake reviews in Figma and says "this looks like a real brand book, not AI slop."

---

## Phase 2: GTM Org via Company Wizard (Day 1-2)

### 2.1 Install Company Wizard Plugin

```bash
cd ~/.paperclip
npm install @yesterday-ai/paperclip-plugin-company-wizard
```

### 2.2 Run GTM Preset

The `gtm` preset includes:
- **Modules:** competitive-intel, brand-identity, github-repo, backlog, auto-assign, stall-detection
- **Roles:** CEO, CMO (auto-created)

**Customization for Tryps:**
- Company mission: "Launch Tryps to market — ship the app by April 2, execute brand & GTM by May 2"
- Point at `~/tryps-docs` as the project root
- CMO goal: "Progress all 6 brand/GTM scopes in sean.md through agent automation"

### 2.3 CMO Agent — What It Does

The CMO agent works alongside Sean to accelerate his $10K contract deliverables:

| Sean's Deliverable | CMO Agent Task | How |
|-------------------|---------------|-----|
| 300-creator UGC list | Compile master list using AgentCash (StableEnrich + StableSocial) | Search travel/lifestyle creators matching Sean's criteria doc |
| Launch video research | Competitive analysis of 2026 consumer tech launches | Web search + summarize successful launch videos |
| Brand book strategy pages | Draft positioning, messaging, personality copy | Write brand platform text for Pablo to design in Figma |
| Social content calendar | Draft 3-week content plan (4-5 posts/platform/week) | Research trending formats, draft copy, suggest visual direction |
| Giveaway mechanics | Research successful consumer app giveaways | Compile examples, draft mechanics doc |
| Physical presence planning | Research NYC wallpaper vendors, sticker printers, film cameras | Price out options, compile vendor list |
| SEO/GEO/AEO | Keyword research, competitor analysis | Use AgentCash search APIs |
| App Store screenshots | Draft screenshot copy and layout strategy | Research top travel app listings |

**CMO heartbeat:** Every 8 hours (3x/day). Checks for new assignments, progresses existing work, posts updates to Slack.

---

## Phase 3: Bug-Fixing Engineers (Day 2)

### 3.1 Frontend Bug Engineer

| Field | Value |
|-------|-------|
| Name | Frontend Engineer |
| Adapter | `claude_local` |
| Working directory | `~/t4` |
| Scope | React Native components, navigation, UI bugs, Expo config |
| Heartbeat | Wake on assignment |
| Workflow | Read bug -> reproduce -> write fix -> open PR -> assign to Nadeem/Asif for review |
| Budget | $30/month |

### 3.2 Backend Bug Engineer

| Field | Value |
|-------|-------|
| Name | Backend Engineer |
| Adapter | `claude_local` |
| Working directory | `~/t4` |
| Scope | Supabase Edge Functions, database queries, API bugs, auth |
| Heartbeat | Wake on assignment |
| Workflow | Read bug -> diagnose -> write fix -> open PR -> assign to Rizwan/Asif for review |
| Budget | $30/month |

### 3.3 Bug Triage Routine

Create a Paperclip routine that runs daily:
- Scan open GitHub issues in t4
- Categorize as frontend or backend
- Auto-assign to the appropriate bug engineer
- Skip issues tagged `human-only` or `architecture`

---

## Phase 4: Marty Integration (Day 2-3)

### 4.1 Connect Marty via OpenClaw Gateway Adapter

**Config:**
```
adapterType: openclaw_gateway
websocketUrl: ws://178.156.176.44:<gateway-port>
auth: <token from openclaw.json on Hetzner>
sessionKeyStrategy: issue (each task gets its own context)
autoPairOnFirstConnect: true
```

**Steps:**
- [ ] SSH to Hetzner, find OpenClaw gateway port and auth token
- [ ] Create Marty agent in Paperclip with `openclaw_gateway` adapter
- [ ] Test heartbeat: assign a simple task, verify execution on Hetzner
- [ ] Migrate Marty's crons to Paperclip routines:

| Current Cron | Paperclip Routine | Schedule |
|-------------|-------------------|----------|
| Morning standup | `standup-automation` | `0 7 * * 1-5` (7am weekdays) |
| Nightly report | `nightly-report` | `0 22 * * *` (10pm daily) |
| State pipeline sync | `state-sync` | `0 */6 * * *` (every 6h) |
| PR review | `pr-review` | Wake on assignment (webhook from GitHub) |

### 4.2 Marty's Role in the Org

- **Title:** Staff Engineer / DevOps
- **Reports to:** CEO agent
- **Existing capabilities preserved:** PR review, state sync, Slack comms, bug triage
- **New via Paperclip:** Budget tracking, task checkout (no double-work), audit trail

---

## Phase 5: Slack Integration (Day 2)

### 5.1 Install Slack Plugin

```bash
npm install paperclip-plugin-slack
```

### 5.2 Configuration

- [ ] Create Slack app with `chat:write`, `commands` scopes
- [ ] Enable Interactivity pointed at Paperclip host (need Tailscale or ngrok for local)
- [ ] Store Bot OAuth Token as Paperclip secret
- [ ] Create `#tryps-agents` channel (separate from `#martydev`)

### 5.3 Channel Routing

| Event Type | Channel |
|-----------|---------|
| Design briefs & Pablo output | `#tryps-agents` |
| Bug fix PRs | `#tryps-agents` |
| CMO/GTM updates | `#tryps-agents` |
| Approval requests | `#tryps-agents` |
| Errors / budget alerts | DM to Jake |
| Marty PR reviews | `#martydev` (unchanged) |

### 5.4 Daily Digest

Configure 9am daily digest to `#tryps-agents`:
- Tasks completed overnight
- Active agents and what they're working on
- Budget spend summary
- Top blocker / escalation

---

## Phase 6: Evaluate & Decide (Day 3-4)

### 6.1 48-Hour Review

After 48 hours of operation, assess:

| Question | How to Evaluate |
|----------|----------------|
| Is Pablo producing usable Figma output? | Review 5 brand book pages — are they real or slop? |
| Are bug engineers shipping valid PRs? | Check PR approval rate with Asif/Nadeem |
| Is the CMO progressing sean.md checkboxes? | Diff sean.md before/after |
| Is Marty stable inside Paperclip? | Compare to his independent Hetzner performance |
| Is the Slack integration useful or noisy? | Ask yourself: am I muting `#tryps-agents`? |

### 6.2 Workforce Management Decision

Based on 48-hour results, decide:

**(a) Rizwan manages the agentic workforce**
- Pro: Already on the team, understands the codebase, assigned to P3/agent layer
- Con: Takes cycles from agent-intelligence scope (55/61 SC)
- Best if: The agents mostly work and just need tuning

**(b) Hire Upwork dev for agent ops**
- Pro: Dedicated focus, doesn't pull from existing dev bandwidth
- Con: Onboarding time, needs to learn Paperclip + Tryps architecture
- Best if: Agent management is a real ongoing job (5+ hours/week)
- Job description: "AI Agent Operations Engineer — manage Paperclip org, write SOUL.md/HEARTBEAT.md files, tune agent skills, monitor output quality, build custom Figma/Slack skills"

**(c) Jake manages directly**
- Pro: Fastest feedback loop, you know the brand best
- Con: Takes time from spec sessions and strategy
- Best if: You enjoy it and it's < 2 hours/day

**Recommendation:** Start with (c) for 48 hours. If it takes more than 2 hours/day of management, move to (a) with Rizwan for the engineering agents and keep Pablo/CMO under Jake's direct oversight (brand taste can't be delegated to Rizwan).

---

## Full Org Chart (Target State)

```
JAKE (Board of Directors)
│
├── Henry — CEO (claude_local)
│   "If I would have asked people what they wanted, they would have said faster horses."
│   ├── Pablo — UI & Brand Designer (claude_local + Figma MCP)
│   ├── Don — CMO / Brand & GTM (claude_local + AgentCash)
│   ├── Frontend Bug Engineer (claude_local, cwd: ~/t4)
│   ├── Backend Bug Engineer (claude_local, cwd: ~/t4)
│   └── Marty — Staff Engineer (openclaw_gateway @ Hetzner)
│
├── HUMAN TEAM (outside Paperclip, interacts via GitHub/ClickUp/Slack)
│   ├── Asif — Head of Dev (reviews bug-fix PRs)
│   ├── Nadeem — Dev (reviews frontend PRs, ships SC)
│   ├── Rizwan — Dev (reviews backend PRs, potential agent ops)
│   ├── Warda — Agent QA (validates criteria)
│   └── Sean — Creative (reviews Pablo's Figma output, executes GTM)
```

---

## Risk Analysis

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Pablo produces unusable Figma output | Medium | High | Start with 5 simple pages, iterate SOUL.md based on results |
| Figma MCP server beta breaks | Low | Medium | Fall back to `/figma-capture` pipeline (already working) |
| Bug engineers introduce regressions | Medium | High | All PRs require human review, no auto-merge |
| Marty destabilized by Paperclip migration | Medium | High | Run parallel for 48h before cutting over crons |
| Agent costs exceed budget | Low | Low | Paperclip auto-pauses at 100% budget, start conservative |
| Team confused by new agent messages | Medium | Medium | Separate `#tryps-agents` channel, announce to team |
| Figma MCP free beta ends | Medium | Medium | `dannote/figma-use` (CDP-based) or existing capture pipeline as alternatives |

---

## Budget

| Agent | Monthly Budget | Rationale |
|-------|---------------|-----------|
| Pablo | $50 | Design work is token-heavy (long prompts, Figma API calls) |
| CMO | $30 | Research + writing, moderate token usage |
| Frontend Engineer | $30 | Code reading + PR creation |
| Backend Engineer | $30 | Code reading + PR creation |
| Marty | $0 (existing sub) | Uses OpenClaw on Hetzner (existing cost) |
| CEO | $20 | Coordination only, low token usage |
| **Total** | **$160/month** | Plus existing Hetzner + API costs |

---

## Implementation Order

| Step | What | Time | Dependency |
|------|------|------|-----------|
| 1 | Install Figma MCP server, verify write access | 30 min | Figma Pro account |
| 2 | Write Pablo's Tryps design skill (SKILL.md) | 1 hour | Brand.md + theme.ts |
| 3 | Register Pablo in Paperclip, configure SOUL/HEARTBEAT | 30 min | Step 2 |
| 4 | Assign first task: 5 brand book pages | 15 min | Step 3 |
| 5 | Install Company Wizard, run `gtm` preset | 30 min | None |
| 6 | Configure CMO agent with sean.md context | 30 min | Step 5 |
| 7 | Install Slack plugin, create `#tryps-agents` | 1 hour | Slack admin access |
| 8 | Create bug engineer agents | 30 min | None |
| 9 | SSH to Hetzner, get Marty gateway details | 30 min | SSH access |
| 10 | Wire Marty into Paperclip | 1 hour | Step 9 |
| 11 | 48-hour evaluation | — | All above |
| 12 | Decide: Rizwan, Upwork, or Jake manages | — | Step 11 |

---

## References

### Internal
- Brand system: `/Users/jakestein/tryps-docs/shared/brand.md`
- Code tokens: `/Users/jakestein/t4/utils/theme.ts`
- Sean contract: `/Users/jakestein/tryps-docs/brand-and-gtm/sean.md`
- Brand book checklist: `/Users/jakestein/tryps-docs/brand-and-gtm/reference/brand-book-screen-checklist.md`
- Brand book prompts: `/Users/jakestein/tryps-docs/brand-and-gtm/designs/brand-book-make-prompts.md`
- Figma component map: `/Users/jakestein/tryps-docs/marty/skills/design-audit/figma-component-map.json`
- Existing Figma commands: `/Users/jakestein/.claude/commands/figma-design.md`, `/Users/jakestein/.claude/commands/figma-capture.md`
- Paperclip config: `/Users/jakestein/.paperclip/instances/default/config.json`
- Flite brand book: `/Users/jakestein/Library/Messages/Attachments/cd/13/521591F4-6330-488D-A3ED-74592BEE0AB9/FliteBrandSystem.pdf`

### External
- [Figma MCP Server (official)](https://developers.figma.com/docs/figma-mcp-server/)
- [Figma MCP Write to Canvas](https://developers.figma.com/docs/figma-mcp-server/write-to-canvas/)
- [Figma MCP Skills](https://developers.figma.com/docs/figma-mcp-server/create-skills/)
- [Paperclip GitHub](https://github.com/paperclipai/paperclip)
- [Company Wizard Plugin](https://github.com/Yesterday-AI/paperclip-plugin-company-wizard)
- [Paperclip Slack Plugin](https://github.com/mvanhorn/paperclip-plugin-slack)
- [dannote/figma-use (CDP alternative)](https://github.com/dannote/figma-use)
- [Greg Isenberg Paperclip thread](https://x.com/gregisenberg/status/2037262467684864075)
- [Figma Blog: Agents Meet the Canvas](https://www.figma.com/blog/the-figma-canvas-is-now-open-to-agents/)
