---
title: "Tryps Agentic Operating Model"
type: strategy
date: 2026-03-28
status: active
owner: jake
reviewers: [jackson]
supersedes: []
---

# Tryps Agentic Operating Model

> This is the operating charter for Tryps as an agent-first organization.
> It defines who does what — humans and agents — how they interact, what they cost,
> and how we close the gaps between where we are and where we need to be.
>
> Share with: Jackson (strategy advisor), all Claude sessions, Marty.
> Last updated: 2026-03-28

---

## 1. Operating Model Declaration

### The Model

Tryps runs the **Agent Director** model. Jake is the director. The workforce is a hybrid of human contractors and AI agents, orchestrated through Paperclip (agent org), ClickUp (human tasks), and Slack (communication layer).

**Core principle:** Agents execute. Humans review, decide, and taste-check. No agent ships to production or publishes externally without a human approval gate.

**Identity statement:** Tryps is not a 7-person startup with some AI tools. It is a 3-person leadership team (Jake + 2 senior humans) directing a workforce of 10+ specialized agents and 5 human contractors. The primary job of every human on this team is to direct agent output, not to do the work themselves.

### Org Chart

```
JAKE STEIN — Agent Director / Product
"The Board"
│
├─── AGENT WORKFORCE (Paperclip @ 127.0.0.1:3100)
│    │
│    ├── Henry ········· CEO Agent (orchestration, delegation, escalation)
│    │   ├── Pablo ····· UI & Brand Designer (Figma MCP, brand book, screens)
│    │   ├── Don ······· CMO (brand/GTM research, content drafts, UGC sourcing)
│    │   ├── Felix ····· Frontend Bug Engineer (React Native, Expo, UI bugs)
│    │   ├── Reese ····· Backend Bug Engineer (Supabase, Edge Functions, API bugs)
│    │   └── Scout ····· Competitive Intel Agent (HN/Reddit/PH/competitor monitoring)
│    │
│    ├── Marty ·········· Staff Engineer / DevOps (OpenClaw @ Hetzner, 24/7)
│    │                    PR reviews, state sync, standup automation, nightly reports
│    │
│    └── Watcher ········ QA Agent (continuous test runner, visual regression, smoke tests)
│
├─── HUMAN WORKFORCE
│    │
│    ├── Asif ··········· Head of Dev — PR review authority, architecture decisions
│    ├── Nadeem ········· Dev — Output-Backed Screen, Core Trip, bug validation
│    ├── Rizwan ········· Dev — Agent Intelligence, P3 agent layer, potential agent ops
│    ├── Warda ·········· Agent QA — validates agent output against success criteria
│    ├── Andreas ········ QA — exploratory testing, edge cases, human judgment layer
│    ├── Sean ··········· Creative Director — brand taste, content review, GTM execution
│    │
│    └── Jackson ········ Strategy Advisor (external, human-only role)
│
└─── HUMAN-ONLY DECISIONS (never delegated to agents)
     ├── Product vision and prioritization
     ├── Brand taste calls ("is this slop or real?")
     ├── Hiring and firing
     ├── Legal, financial, investor commitments
     ├── Architecture decisions that affect >3 scopes
     ├── Anything user-facing that touches payments
     └── Crisis response
```

### Decision Flow

| Decision Type | Who Decides | Agent Role |
|--------------|-------------|------------|
| What to build | Jake | Henry proposes, Jake approves |
| How to build it | Asif + dev team | Bug agents draft PRs, humans review |
| What it looks like | Sean + Jake | Pablo drafts, Sean reviews, Jake approves |
| What to say publicly | Sean + Jake | Don drafts, Sean reviews, Jake approves |
| Is it done? | Andreas + Warda | Watcher runs automated checks, humans validate |
| Is it good enough? | Jake | No agent has this authority |

---

## 2. Agent Roster

### Existing Agents

#### Marty — Staff Engineer / DevOps
| Field | Value |
|-------|-------|
| **Status** | Running (OpenClaw @ Hetzner 178.156.176.44) |
| **Adapter** | `openclaw_gateway` (to be wired into Paperclip) |
| **Heartbeat** | 24/7 — cron-scheduled (standups 7am, state sync 6h, nightly report 10pm) + wake on PR |
| **Budget** | Existing Hetzner + Anthropic API costs (~$80/month est.) |
| **Replaces** | Nobody — Marty is additive infrastructure |
| **Augments** | Asif (PR reviews), Jake (state awareness), Andreas (bug triage) |
| **Success metric** | 90%+ of PRs get first review within 2 hours; state.md always current |
| **First task** | Already running. Next: wire into Paperclip for unified task management |

#### Henry — CEO Agent
| Field | Value |
|-------|-------|
| **Status** | Running (Paperclip, claude_local, Opus) |
| **Adapter** | `claude_local` |
| **Heartbeat** | Every 4 hours — checks for stalled tasks, redistributes work, posts digest |
| **Budget** | $20/month |
| **Replaces** | Nobody — Henry is a coordination layer |
| **Augments** | Jake (reduces need to manually check on every agent) |
| **Success metric** | Zero tasks stalled >24h without escalation; daily digest posted by 9am |
| **First task** | Assign Pablo's brand book brief, configure routing for all agent output |

#### Pablo — UI & Brand Designer
| Field | Value |
|-------|-------|
| **Status** | Registered (first task assigned: TRY-3, 5 brand book pages) |
| **Adapter** | `claude_local` + Figma MCP |
| **Heartbeat** | Wake on assignment |
| **Budget** | $50/month |
| **Replaces** | Portion of Sean's design execution (not his taste/direction) |
| **Augments** | Sean (drafts screens he reviews, not starts from scratch) |
| **Success metric** | Sean rates 70%+ of drafts as "usable with minor edits" (not "redo from scratch") |
| **First task** | TRY-3: 5 brand book cover pages in Figma |

### Planned Agents (Deploy by March 30)

#### Don — CMO / Brand & GTM
| Field | Value |
|-------|-------|
| **Status** | Planned (Day 1-2) |
| **Adapter** | `claude_local` + AgentCash (StableEnrich, StableSocial) |
| **Heartbeat** | Every 8 hours (3x/day) |
| **Budget** | $30/month + ~$50/month AgentCash API calls |
| **Replaces** | Manual research Jake/Sean currently do (competitor scanning, creator sourcing) |
| **Augments** | Sean (delivers raw material: creator lists, competitive intel, content drafts) |
| **Success metric** | UGC master list of 300 creators compiled by April 5; 3 sean.md checkboxes progressed |
| **First task** | Compile 300-creator UGC target list using Sean's criteria doc |

#### Felix — Frontend Bug Engineer
| Field | Value |
|-------|-------|
| **Status** | Planned (Day 2) |
| **Adapter** | `claude_local`, cwd: ~/t4 |
| **Heartbeat** | Wake on assignment from Henry's bug triage |
| **Budget** | $30/month |
| **Replaces** | Nadeem's bug-fix time (he has 78 open bugs competing with 48 SC for Output-Backed Screen) |
| **Augments** | Nadeem (writes fix PRs that Nadeem reviews instead of writes) |
| **Success metric** | 5+ bug-fix PRs/week with >60% approval rate on first review |
| **First task** | Pick top 3 UI bugs from GitHub issues, draft fix PRs |

#### Reese — Backend Bug Engineer
| Field | Value |
|-------|-------|
| **Status** | Planned (Day 2) |
| **Adapter** | `claude_local`, cwd: ~/t4 |
| **Heartbeat** | Wake on assignment from Henry's bug triage |
| **Budget** | $30/month |
| **Replaces** | Rizwan's bug-fix time (he's at 55/61 on Agent Intelligence) |
| **Augments** | Rizwan + Asif (writes fix PRs they review) |
| **Success metric** | 5+ bug-fix PRs/week with >60% approval rate on first review |
| **First task** | Pick top 3 backend/API bugs from GitHub issues, draft fix PRs |

#### Scout — Competitive Intelligence Agent
| Field | Value |
|-------|-------|
| **Status** | Planned (post-April 2) |
| **Adapter** | `claude_local` + web search + AgentCash |
| **Heartbeat** | Daily at 6am — crawl HN, Reddit, Product Hunt, competitor apps |
| **Budget** | $20/month + ~$30/month API calls |
| **Replaces** | Jake's manual competitive scanning (currently ad hoc) |
| **Augments** | Jake (daily briefing), Sean (content ideas), Don (market context) |
| **Success metric** | Daily competitive digest posted to #tryps-agents by 7am; 2+ actionable insights/week |
| **First task** | Set up monitoring for: Partiful, TripIt, Wanderlog, Lemon8 Travel, Beli |

#### Watcher — QA Agent
| Field | Value |
|-------|-------|
| **Status** | Planned (post-April 2) |
| **Adapter** | `claude_local`, cwd: ~/t4 |
| **Heartbeat** | Wake on PR merge + nightly full suite |
| **Budget** | $25/month |
| **Replaces** | Manual test suite runs; tier-1 QA |
| **Augments** | Andreas (automated regression + smoke tests free him for exploratory testing), Warda (automated SC validation) |
| **Success metric** | Zero regressions ship to staging undetected; test suite runs on every PR |
| **First task** | Run full test suite on develop, file bugs for any failures |

#### Rio — Video Editor & Content Creator
| Field | Value |
|-------|-------|
| **Status** | Planned (Day 1) |
| **Adapter** | `claude_local` + StableStudio (video gen via AgentCash) |
| **Heartbeat** | Wake on assignment |
| **Budget** | $100/month (video generation is token + API heavy) |
| **Replaces** | Manual video drafting; reduces Sean's production iteration cycles |
| **Augments** | Sean (produces draft video content for Sean to direct and refine) |
| **Success metric** | Sean rates 60%+ of draft clips as "usable direction" (not "start over") |
| **First task** | 15-second teaser clip based on "However You Get To Us" treatment — 9:16 + 16:9 |
| **Slack** | Display: Rio Nakamura, Title: Video & Content, Photo: rio-nakamura.png |

### Slack Identity Layer

Each agent has its own Slack app, profile photo, and bot token. All agents post
as themselves — indistinguishable from human contractors (the "Sean Test").

| Agent | Slack Display Name | Title | Profile Photo | Bot Token Secret |
|-------|-------------------|-------|---------------|-----------------|
| Henry | Henry Park | Project Lead | henry-park.png | `SLACK_BOT_HENRY` |
| Pablo | Pablo DeSouza | Brand & UI Design | pablo-desouza.png | `SLACK_BOT_PABLO` |
| Don | Don Reyes | Brand & Growth | don-reyes.png | `SLACK_BOT_DON` |
| Felix | Felix Chung | Frontend Dev | felix-chung.png | `SLACK_BOT_FELIX` |
| Reese | Reese Okafor | Backend Dev | reese-okafor.png | `SLACK_BOT_REESE` |
| Rio | Rio Nakamura | Video & Content | rio-nakamura.png | `SLACK_BOT_RIO` |

Profile photos: `~/tryps-docs/agents/profile-photos/`
All timezones: Eastern Time (US & Canada)
Channel: #tryps-agents (all agents + Jake)

### Agent Summary Table

| Agent | Role | Status | Heartbeat | Monthly Budget | Reports To |
|-------|------|--------|-----------|---------------|------------|
| Henry | CEO | Running | 4h | $20 | Jake |
| Pablo | Designer | Running | On assignment | $50 | Henry |
| Marty | Staff Eng | Running | 24/7 cron | ~$80 (existing) | Henry |
| Don | CMO | Planned (Day 1-2) | 8h | $80 | Henry |
| Felix | Frontend Eng | Planned (Day 2) | On assignment | $30 | Henry |
| Reese | Backend Eng | Planned (Day 2) | On assignment | $30 | Henry |
| Rio | Video & Content | Planned (Day 1) | On assignment | $100 | Henry |
| Scout | Comp Intel | Planned (post-Apr 2) | Daily 6am | $50 | Henry |
| Watcher | QA | Planned (post-Apr 2) | On PR + nightly | $25 | Henry |
| **Total** | | | | **~$465/month** | |

---

## 3. Gap Closure Plan

The research identified 6 gaps between Tryps and the leading practitioner orgs. Here's where each stands and how we close it.

### Gap 1: Agent Observability
**Severity:** Medium

| | Detail |
|---|--------|
| **What we have** | Marty's Slack messages (output only). Paperclip's built-in task log for local agents. |
| **What's missing** | No centralized trace of every LLM call — cost per call, failure modes, latency, token usage. Can't answer "what did Marty do at 3am and why did it fail?" |
| **Action** | **Option A (recommended):** Deploy LangFuse (open source, self-hosted on Hetzner). Instrument Marty's Anthropic SDK calls. ~2 hours to add. **Option B:** Structured JSON logging to Supabase table + simple dashboard. |
| **Owner** | Jake (initial setup) -> Rizwan (maintenance) |
| **Timeline** | Post-April 2. Not blocking anything right now, but becomes critical as agent count grows past 5. |

### Gap 2: Persistent Memory Infrastructure
**Severity:** Medium-High

| | Detail |
|---|--------|
| **What we have** | `tryps-docs/shared/` (state.md, priorities.md, brand.md, clickup.md) — auto-generated, read by all sessions. Claude Code's `.claude/` memory system. Marty's session transcripts. |
| **What's missing** | Context loss between Claude Code sessions. Marty rebuilds context from scratch each task. No "team changelog" of architectural decisions, abandoned approaches, or "why we did X." Agents can't learn from each other's failures. |
| **Action** | **Phase 1 (this week):** Create `tryps-docs/shared/context.md` — architectural decisions, abandoned approaches, cross-scope gotchas. Jake writes initial version, Marty auto-appends from PR review learnings. **Phase 2 (next 2 weeks):** Evaluate ClickMem or structured memory format for agents. **Phase 3 (post-April 2):** Shared memory bus — all agents write to a common log that any agent can query. |
| **Owner** | Jake (Phase 1), Rizwan (Phase 2-3) |
| **Timeline** | Phase 1: March 29. Phase 2: April 5-12. Phase 3: April 15+. |

### Gap 3: Formalized Agent Roles
**Severity:** High -> **CLOSING**

| | Detail |
|---|--------|
| **What we have** | Marty (generalist), Claude Code (interactive), Linq (user-facing). All informal. |
| **What's missing** | Named agents with defined responsibilities, budgets, and success metrics. |
| **Action** | **This is what Paperclip solves.** The agent roster above (Section 2) formalizes 8 named agents across design, engineering, marketing, QA, and competitive intel. Each has a defined role, heartbeat, budget, and success metric. |
| **Owner** | Jake |
| **Timeline** | In progress. Henry + Pablo running. Don + Felix + Reese by March 30. Scout + Watcher post-April 2. |

### Gap 4: Agent-to-Agent Communication
**Severity:** Low-Medium

| | Detail |
|---|--------|
| **What we have** | Agents are siloed. Marty on Hetzner. Pablo in Paperclip. Claude Code sessions are ephemeral. They communicate through Jake. |
| **What's missing** | Agents can't message each other directly. No "SSH for AI" system. No PM agent coordinating handoffs. |
| **Action** | **Phase 1 (now):** Henry acts as the coordination hub — this is his primary job. When Pablo finishes a design, Henry assigns the next task and notifies relevant agents. This is hub-and-spoke, not mesh, and that's fine at our scale. **Phase 2 (post-April 2):** Evaluate Paperclip's inter-agent messaging for direct handoffs (e.g., Felix finishes a fix -> Watcher auto-runs tests -> Marty reviews PR). |
| **Owner** | Henry (Phase 1), Rizwan (Phase 2) |
| **Timeline** | Phase 1: Now (Henry's default behavior). Phase 2: April 15+. |

### Gap 5: Cost Structure Visibility
**Severity:** Medium -> **CLOSING**

| | Detail |
|---|--------|
| **What we have** | Individual Anthropic/OpenAI invoices. Hetzner invoice. Contractor invoices. No unified view. |
| **What's missing** | Can't answer "what does the content function cost per month — agents vs. humans?" or "is Felix cheaper than Nadeem for bug fixes?" |
| **Action** | **Phase 1 (this week):** Paperclip tracks per-agent token spend with budget caps. This gives us agent-side visibility. **Phase 2 (next 2 weeks):** Build a simple cost dashboard — `tryps-docs/shared/costs.md` updated weekly by Marty. Categories: agent API costs, agent infra (Hetzner), contractor payments, SaaS tools. **Phase 3 (post-April 2):** Track cost-per-function: what does "bug fixing" cost as agent labor vs. contractor time? |
| **Owner** | Jake (Phase 1), Marty (Phase 2-3) |
| **Timeline** | Phase 1: Now (Paperclip budgets). Phase 2: April 5. Phase 3: April 15+. |

### Gap 6: Intentional "Agent Director" Identity
**Severity:** High -> **CLOSED**

| | Detail |
|---|--------|
| **What we have** | This document. |
| **What's missing** | Nothing, after this document exists. The gap was "we haven't been intentional about it — it evolved organically." This document makes it intentional. |
| **Action** | **Done.** Share this document with Jackson. Reference it in every future session. Update it as the model evolves. The operating model is now declared, not implicit. |
| **Owner** | Jake |
| **Timeline** | Today. |

### Gap Closure Summary

| Gap | Severity | Status | When |
|-----|----------|--------|------|
| Agent Observability | Medium | Open | Post-April 2 |
| Persistent Memory | Medium-High | Phase 1 this week | Ongoing |
| Formalized Roles | High | Closing (Paperclip) | Now |
| Agent-to-Agent Comms | Low-Medium | Adequate (Henry as hub) | Post-April 2 |
| Cost Visibility | Medium | Closing (Paperclip budgets) | Now |
| Intentional Identity | High | **Closed** | Today |

---

## 4. Human Role Evolution

### Jake Stein — Founder

| | Before (implicit) | After (declared) |
|---|---|---|
| **Title** | Founder / Product / Everything | Agent Director / Product |
| **Primary job** | Write specs, manage contractors, review PRs, do brand work, answer Slack | Orchestrate agents, set vision, taste-check output, make judgment calls |
| **Stops doing** | Manual competitive research. Writing first drafts of GTM content. Running test suites. Triaging bugs into categories. Compiling UGC creator lists. |
| **Starts doing** | Reviewing agent output daily (9am digest). Tuning agent SOUL.md files when output quality drifts. Writing design briefs for Pablo instead of designing. Writing strategic briefs for Don instead of researching. |
| **Stays the same** | Spec sessions. Product vision. Brand taste calls. Investor/partner meetings. Final approval on everything user-facing. |
| **Risk** | Over-managing agents instead of trusting the system. Budget: <2 hours/day on agent management or escalate to Rizwan. |

### Asif — Head of Dev

| | Before | After |
|---|---|---|
| **Primary job** | Write code, review PRs, architect features | Review agent PRs + human PRs, architecture decisions, unblock devs |
| **Stops doing** | Writing routine bug fixes. Running deploys manually. |
| **Starts doing** | Reviewing Felix and Reese's PR output (bug-fix agents). Setting "human-only" and "architecture" tags on issues that agents should skip. Training agents by rejecting bad PRs with clear feedback. |
| **Stays the same** | Architecture authority. Final say on code quality. Reviewing Nadeem/Rizwan PRs. Leading cross-scope coordination. |
| **New metric** | PR review throughput (human + agent PRs reviewed per week). |

### Nadeem — Dev (P1 — Core App)

| | Before | After |
|---|---|---|
| **Primary job** | Ship Output-Backed Screen (48 SC) + fix bugs (78 open) | Ship Output-Backed Screen. Period. |
| **Stops doing** | Fixing routine UI bugs (Felix handles those). Running through the bug backlog. |
| **Starts doing** | Reviewing Felix's frontend bug PRs (quick pass/fail). Flagging complex bugs as "human-only" for himself. Focusing 90% of time on the 48 SC for Output-Backed Screen. |
| **Stays the same** | Owns Output-Backed Screen end-to-end. Core Trip Experience validation. |
| **Impact** | If Felix handles even 5 bugs/week, Nadeem recovers ~5-8 hours/week for SC work. At 7/48 with 5 days to April 2, every hour matters. |

### Rizwan — Dev (P3 — Agent Layer)

| | Before | After |
|---|---|---|
| **Primary job** | Agent Intelligence scope (55/61 SC) + cross-scope interfaces | Finish Agent Intelligence. Then: potential Agent Ops role. |
| **Stops doing** | Backend bug fixes (Reese handles routine ones). |
| **Starts doing** | Reviewing Reese's backend PRs. After April 2: potentially managing Paperclip agent health, tuning SOUL/HEARTBEAT files, wiring Marty deeper. |
| **Stays the same** | Agent Intelligence scope owner. P3 backend expertise. Cross-scope interface work with Asif. |
| **Decision point** | Post-April 2, if agent management takes >5 hours/week, Rizwan becomes the Agent Ops lead. His P3/agent-layer expertise makes him the natural fit. |

### Warda — Agent QA

| | Before | After |
|---|---|---|
| **Primary job** | QA tester | Agent output validator |
| **Stops doing** | Running automated test suites manually (Watcher does this post-April 2). |
| **Starts doing** | Validating agent-written PRs against success criteria. Checking Pablo's Figma output for design consistency. Spot-checking Don's research for accuracy. Becoming the "trust layer" between agent output and production. |
| **Stays the same** | Testing features against SC. Filing bugs in ClickUp. |
| **Key insight** | Warda's role becomes MORE important, not less. As agents produce more output, human QA becomes the bottleneck that prevents slop from shipping. |

### Andreas — QA

| | Before | After |
|---|---|---|
| **Primary job** | Manual QA against success criteria | Exploratory testing + judgment-heavy QA |
| **Stops doing** | Running the same regression tests manually every sprint (Watcher handles). Basic smoke testing post-deploy. |
| **Starts doing** | Focused exploratory testing — the weird edge cases agents can't imagine. Reviewing Watcher's bug reports for false positives. Testing agent-generated UI for "feels wrong" issues that automated tests miss. |
| **Stays the same** | Final human QA gate before `done` status in ClickUp. |
| **Augmented by** | Watcher (automated regression + smoke tests). Felix/Reese (bugs get fixed faster, so Andreas re-tests faster). |

### Sean — Creative Director

| | Before | After |
|---|---|---|
| **Primary job** | Brand book, socials, UGC program, launch video, giveaways, physical presence | Creative direction and taste. Review agent output. Execute on-camera work. |
| **Stops doing** | Compiling UGC creator lists manually (Don + AgentCash). Researching competitive launches from scratch (Don). Starting brand book pages from a blank canvas (Pablo drafts). |
| **Starts doing** | Writing creative briefs for Pablo (what should this page feel like, not what should it look like). Reviewing and refining Don's content drafts. Reviewing Pablo's Figma output with markup. Focusing on the 20% taste layer that makes output not-slop. |
| **Stays the same** | On-camera work. DM correspondence with UGC creators. Final creative decisions. Filming/editing for launch video. |
| **Contract impact** | Sean's $10K stays the same. Agents accelerate his deliverables, not replace his contract. If agents handle 50% of research/drafting, Sean spends that time on higher-value execution. |

### Jackson — Strategy Advisor

| | Before | After |
|---|---|---|
| **Primary job** | VC-style strategic advice | Same + reviewing the operating model |
| **Change** | Jackson now also reviews agent org decisions. Is the model working? Are we over-investing in agents where humans are needed? Is the cost structure rational? |
| **Agent interaction** | None. Jackson is fully outside the agent system. He reviews output, not process. |

---

## 5. Cost Model

### Current Monthly Costs (Pre-Agent Org)

| Category | Item | Monthly Cost | Notes |
|----------|------|-------------|-------|
| **Contractors** | Asif | ~$X,XXX | Head of dev (rate TBD — Jake to fill) |
| | Nadeem | ~$X,XXX | Dev |
| | Rizwan | ~$X,XXX | Dev |
| | Andreas | ~$X,XXX | QA |
| | Warda | ~$X,XXX | QA (new, rate TBD) |
| | Sean | $5,000 | $10K / 2 milestones (April + May) |
| **Subtotal contractors** | | **$XX,XXX** | |
| **Infra** | Hetzner (Marty) | ~$30 | Dedicated VPS |
| | Anthropic API (Marty) | ~$50 | Claude calls |
| | Supabase | ~$25 | Database |
| | Vercel | ~$20 | Hosting |
| | Other SaaS | ~$100 | ClickUp, Slack, GitHub, etc. |
| **Subtotal infra** | | **~$225** | |
| **Total pre-agents** | | **$XX,XXX + $225** | |

> **Jake: fill in contractor rates.** The model doesn't work without real numbers.

### Projected Monthly Costs (With Agent Org)

| Category | Item | Monthly Cost | Notes |
|----------|------|-------------|-------|
| **Agent workforce** | Henry (CEO) | $20 | Coordination, low token usage |
| | Pablo (Designer) | $50 | Token-heavy design work |
| | Don (CMO) | $80 | $30 tokens + $50 AgentCash APIs |
| | Felix (Frontend Eng) | $30 | Code reading + PR creation |
| | Reese (Backend Eng) | $30 | Code reading + PR creation |
| | Scout (Comp Intel) | $50 | $20 tokens + $30 APIs |
| | Watcher (QA) | $25 | Test execution |
| | Marty (Staff Eng) | $80 | Existing (Hetzner + API) |
| **Subtotal agents** | | **$365** | |
| **Contractors** | Same as above | $XX,XXX | No one gets fired |
| **Infra** | Same + Paperclip | ~$250 | Marginal increase |
| **Total with agents** | | **$XX,XXX + $615** | |

### Cost Analysis by Function

| Function | Current Cost (Human) | Agent Cost | Savings | Quality Trade-off |
|----------|---------------------|------------|---------|-------------------|
| Bug fixing | ~40% of Nadeem + Rizwan time | $60/mo (Felix + Reese) | Frees dev hours for SC work | Agents handle routine; humans handle complex |
| Design drafting | Sean's time + Jake's time | $50/mo (Pablo) | Frees Sean for taste/execution | Agent drafts, human refines |
| GTM research | Sean's time + Jake's time | $80/mo (Don) | Frees both for strategy | Agent compiles, human decides |
| Competitive intel | Jake's ad hoc scanning | $50/mo (Scout) | Systematic vs. sporadic | Agent is more thorough |
| Automated QA | Andreas's regression time | $25/mo (Watcher) | Frees Andreas for exploratory | Agent catches regressions, human finds edge cases |
| Code review | Asif's review time | $0 (Marty, existing) | First pass automated | Marty pre-reviews, human approves |

### Key Insight

Agent labor costs ~$365/month. One contractor-month probably costs $3,000-$8,000+. But this isn't about replacement — it's about **leverage**. The question is: does $365/month of agent labor free up enough human hours to justify the management overhead?

**Break-even:** If agents save each dev even 5 hours/week, that's 60+ hours/month of recaptured capacity across the team. At any contractor rate, $365/month for 60 hours of freed capacity is a no-brainer.

---

## 6. 48-Hour Milestones

By **Sunday March 30, 11:59pm ET**, the following must be true:

### Milestone 1: Pablo Ships Usable Figma Output
**Measure:** 5 brand book pages exist in Figma. Sean reviews them and rates at least 3/5 as "usable with edits" (not "redo from scratch").
**Why it matters:** If Pablo can't produce usable design output, the entire agent-first design thesis fails. This is the highest-risk, highest-value test.

### Milestone 2: Bug Engineers Ship PRs
**Measure:** Felix and Reese have each opened at least 2 PRs against real bugs from the GitHub backlog. At least 1 PR from each has been approved by Asif/Nadeem/Rizwan.
**Why it matters:** Proves agents can navigate the t4 codebase and produce mergeable code. If the approval rate is 0%, we need to invest in better agent context (better SOUL.md, more codebase documentation).

### Milestone 3: Don Delivers UGC Raw Material
**Measure:** Don has compiled a list of at least 50 potential UGC creators (name, platform, follower count, content style) matching Sean's criteria. Sean confirms the list is "useful starting material."
**Why it matters:** This is the most straightforward agent task (research + compile). If Don can't do this, the CMO agent concept needs rethinking.

### Milestone 4: Henry Posts Daily Digests
**Measure:** Henry has posted 2 daily digests (Saturday + Sunday) to #tryps-agents. Each includes: tasks completed, active agents, blockers, budget spend.
**Why it matters:** Proves the orchestration layer works. Jake should be able to glance at one Slack message and know the state of the entire agent workforce.

### Milestone 5: Agent Management Takes <2 Hours/Day
**Measure:** Jake logs time spent on agent management (assigning tasks, reviewing output, debugging issues). If it exceeds 2 hours either day, flag it.
**Why it matters:** If the overhead is too high, the model isn't working. The whole point is leverage, not a new full-time job.

### 48-Hour Decision Gate

| Result | Next Move |
|--------|-----------|
| 4-5 milestones hit | Scale up. Deploy Scout + Watcher. Move Marty into Paperclip. |
| 2-3 milestones hit | Iterate. Tune SOUL.md files for failing agents. Don't add more agents yet. |
| 0-1 milestones hit | Pause. The tooling isn't ready. Go back to human-first until Paperclip/Figma MCP matures. |

---

## 7. Risks & Guardrails

### Risk Matrix

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| **Pablo produces AI slop** — Figma output that looks generated, not designed | Medium | High | Start with 5 simple pages. Iterate SOUL.md. If still slop after 3 rounds of feedback, fall back to `/figma-capture` pipeline or have Sean design from scratch. |
| **Bug agents introduce regressions** — Fix one bug, create two | Medium | High | All PRs require human review. No auto-merge, ever. Run full test suite before and after merge. |
| **Agent management becomes a full-time job** — Jake spends 4+ hours/day managing agents | Medium | High | 2-hour/day cap. If exceeded, shift management to Rizwan (post-April 2) or hire Upwork agent ops person. |
| **Team confusion** — Devs don't know which PRs are from humans vs. agents | Low | Medium | Agent PRs use `[agent]` prefix in title. Separate #tryps-agents channel. Announce the model to the team. |
| **Marty destabilized by Paperclip migration** | Medium | High | Run Paperclip in parallel for 48h. Don't cut over Marty's crons until both systems prove stable. |
| **Figma MCP beta breaks** | Low | Medium | `/figma-capture` pipeline is proven. Keep it as fallback. |
| **Agent costs spike unexpectedly** | Low | Low | Paperclip auto-pauses at budget cap. Start conservative ($365/mo total). |
| **Sean feels replaced** | Low | High | Frame explicitly: agents accelerate his work, not replace his contract. Don does research; Pablo does drafts; Sean directs and refines. His taste and creative judgment are the bottleneck, not his execution speed. |
| **April 2 deadline distraction** — Agent setup pulls focus from shipping | Medium | High | Bug agents help the deadline by fixing bugs. Pablo helps by accelerating brand book. Don helps by accelerating GTM research. If setup takes >4 hours total, stop and ship. |

### Non-Negotiable Human-Only Decisions

These decisions are **never** delegated to agents, regardless of how capable they become:

1. **Product vision** — What to build, what to kill, what to prioritize
2. **Brand taste** — "Does this look/feel/sound like Tryps?"
3. **Architecture** — System design decisions that affect >3 scopes or create irreversible technical debt
4. **Hiring and team changes** — Who joins, who leaves, who gets promoted
5. **Legal and financial** — Contracts, payments, investor commitments, terms of service
6. **User communication** — App Store listing, push notifications, support responses (until explicitly tested and approved)
7. **Security** — Auth changes, API key management, data access patterns
8. **Crisis response** — Anything that requires human judgment under time pressure

### Henry's Escalation Rules

Henry (CEO agent) must escalate to Jake when:

| Trigger | Action |
|---------|--------|
| Any agent exceeds 80% of monthly budget | DM Jake with cost breakdown |
| Any task stalled >24 hours | Post in #tryps-agents with blocker |
| Agent output rejected twice for same task | Escalate — the SOUL.md needs tuning, not more retries |
| Any PR touches auth, payments, or user data | Flag for mandatory Asif review |
| Any agent-to-agent conflict (both modifying same file) | Pause both, escalate |
| Sean or any human contractor raises a concern | Escalate immediately — human concerns are top priority |
| Anything that feels like a brand/taste decision | Escalate — Henry doesn't have taste authority |

### Kill Switch

If agents are causing more problems than they solve:

1. **Soft stop:** Pause all Paperclip agents. Marty continues independently on Hetzner (proven stable).
2. **Hard stop:** Shut down Paperclip entirely. Return to pre-March-28 operating model. All human workflows still work — agents were additive, not load-bearing.
3. **Nothing is irreversible.** No human has been fired. No process depends solely on an agent. The worst case is wasted API costs and a weekend of Jake's time.

---

## Appendix A: Implementation Sequence

| Priority | Action | Time | Owner | Depends On |
|----------|--------|------|-------|------------|
| P0 | Share this doc with Jackson | 5 min | Jake | — |
| P0 | Finish Pablo's first task (5 brand book pages) | In progress | Pablo | Figma MCP OAuth |
| P1 | Deploy Don (CMO agent) | 1 hour | Jake | Company Wizard plugin |
| P1 | Deploy Felix + Reese (bug engineers) | 30 min | Jake | — |
| P1 | Install Slack plugin, create #tryps-agents | 1 hour | Jake | Slack admin |
| P1 | Create `tryps-docs/shared/context.md` (memory gap Phase 1) | 30 min | Jake | — |
| P2 | Wire Marty into Paperclip | 1-2 hours | Jake | SSH to Hetzner |
| P2 | Set up Paperclip budget tracking | 30 min | Jake | — |
| P3 | Deploy Scout (comp intel) | 1 hour | Jake | Post-April 2 |
| P3 | Deploy Watcher (QA agent) | 1 hour | Jake | Post-April 2 |
| P3 | LangFuse observability on Hetzner | 2 hours | Rizwan | Post-April 2 |

## Appendix B: Key Metrics to Track Weekly

| Metric | Source | Target |
|--------|--------|--------|
| Agent PRs opened/week | GitHub | 10+ |
| Agent PR approval rate (first review) | GitHub | >60% |
| Agent-filed bugs resolved | ClickUp | Trending up |
| Daily digest posted on time | Slack | 100% |
| Jake's agent management hours/day | Self-reported | <2 hours |
| Agent monthly spend | Paperclip | <$400 |
| Human time freed (estimated) | Self-reported | >20 hours/week across team |
| Pablo design acceptance rate | Sean's review | >70% usable |
| Don research quality | Sean + Jake review | "Useful starting material" |
| SC completion velocity | state.md | Accelerating week over week |

## Appendix C: References

- [Agentic Orgs Landscape Scan + Gap Analysis](/docs/plans/agentic-orgs-report.md) — March 28, 2026
- [Paperclip Hybrid Org + Pablo Agent Plan](/docs/plans/2026-03-28-feat-paperclip-hybrid-org-and-pablo-agent-plan.md) — March 28, 2026
- [Tryps State](/shared/state.md) — auto-updated
- [Current Priorities](/shared/priorities.md) — updated weekly
- [Sean's GTM Contract](/brand-and-gtm/sean.md) — active
- [ClickUp Source of Truth](/shared/clickup.md) — team IDs, workflow, April 2 deadline
- McKinsey: "The Agentic Organization" (Sept 2025)
- Berkeley CMR: "Governing the Agentic Enterprise: AOM" (Mar 2026)
- FourWeekMBA: "AI-Native Organizations: Three Radical Archetypes" (Feb 2026)

---

*This document is the source of truth for how Tryps operates as an agent-first organization. Update it as the model evolves. Review with Jackson monthly.*
