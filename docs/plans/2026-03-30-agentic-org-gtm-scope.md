---
title: "Agentic Org — GTM Engineer Scope"
type: scope
date: 2026-03-30
status: ready
assignee: gtm-engineer
depends-on: 2026-03-29-agentic-org-execution-prompt.md
---

# Agentic Org — GTM Engineer Scope

> Phase 0 (LangFuse observability) is DONE. This scope covers Phases 1–5.
> Hand this to the GTM engineer. It's self-contained.

## What's Already Done (Phase 0)

- LangFuse account live at cloud.langfuse.com (jake@jointryps.com)
- Project: "tryps-agents" — 2 test traces confirmed
- Keys in `~/.zshrc`: LANGFUSE_PUBLIC_KEY, LANGFUSE_SECRET_KEY, LANGFUSE_BASE_URL
- Keys in Paperclip secrets (3 encrypted secrets)
- Henry + Pablo agents wired with LangFuse env vars + OTEL_SERVICE_NAME tags
- Python SDK installed: langfuse 3.7.0, opentelemetry-instrumentation-anthropic
- SOUL.md Slack communication rules added to Henry + Pablo
- Henry Park Slack app created (app ID: A0APPDNLZHS) — NOT YET INSTALLED

## What's Already Created in Paperclip

- **Henry Park** — CEO/Project Lead (agent ID: f1b38bb7-8f1c-4e77-ba53-42db879f4093)
- **Pablo DeSouza** — Brand & UI Design (agent ID: fe06c7d7-113c-4e60-b187-735186d395ce)
- Company ID: f215543e-7ba8-4637-96f5-41cb3fbbca1c
- Paperclip running at http://127.0.0.1:3100

## Slack Workspace Context

- Workspace: tryps (T0AKPRSJJ0G)
- Existing channels: #all-tryps, #daily-updates, #martyasif, #martydev, #martydesign, #brand
- Existing bots: tryps, Claude, Marty, GitHub, ClickUp, Zoom
- No #tryps-agents channel yet
- No agent bot apps installed yet (Henry app created but not installed)

---

## Phase 1: Slack Identity Layer

**Goal:** 5 agents with individual Slack identities, indistinguishable from real contractors.

### Step 1: Create #tryps-agents channel

Create a public channel called `tryps-agents` in the Tryps Slack workspace.

### Step 2: Install Henry Park Slack App

Henry's app already exists (A0APPDNLZHS). Just needs:
1. Go to api.slack.com/apps/A0APPDNLZHS/install-on-team
2. Click "Install to tryps" and approve OAuth
3. Go to OAuth & Permissions, copy the Bot User OAuth Token (xoxb-...)
4. Upload profile photo from `~/tryps-docs/agents/profile-photos/henry-park.png`
5. Set display name: "Henry Park", title: "Project Lead", timezone: Eastern Time

### Step 3: Create 4 remaining Slack apps

For each agent, go to api.slack.com/apps > Create New App > From a manifest.

Use this JSON manifest (change name/description per agent):

```json
{
  "display_information": {
    "name": "AGENT_NAME",
    "description": "AGENT_TITLE at Tryps",
    "background_color": "#D9071C"
  },
  "features": {
    "bot_user": {
      "display_name": "AGENT_NAME",
      "always_online": false
    }
  },
  "oauth_config": {
    "scopes": {
      "bot": ["app_mentions:read", "chat:write", "channels:history", "channels:read", "users:read"]
    }
  }
}
```

| Agent | Display Name | Title | Timezone | Profile Photo |
|-------|-------------|-------|----------|---------------|
| Pablo | Pablo DeSouza | Brand & UI Design | Eastern Time | ~/tryps-docs/agents/profile-photos/pablo-desouza.png |
| Don | Don Reyes | Brand & Growth | Eastern Time | ~/tryps-docs/agents/profile-photos/don-reyes.png |
| Felix | Felix Chung | Frontend Dev | Eastern Time | ~/tryps-docs/agents/profile-photos/felix-chung.png |
| Reese | Reese Okafor | Backend Dev | Eastern Time | ~/tryps-docs/agents/profile-photos/reese-okafor.png |

For each:
1. Create app from manifest > Select tryps workspace > Create
2. Install to tryps workspace (OAuth & Permissions > Install to tryps)
3. Copy Bot User OAuth Token (xoxb-...)
4. Upload profile photo
5. Set display name, title, timezone

### Step 4: Store bot tokens in Paperclip

For each agent, store their Slack bot token as a Paperclip secret:

```bash
curl -s -X POST http://127.0.0.1:3100/api/companies/f215543e-7ba8-4637-96f5-41cb3fbbca1c/secrets \
  -H "Content-Type: application/json" \
  -d '{"name":"SLACK_BOT_TOKEN_HENRY","value":"xoxb-..."}'
```

Then update each agent's adapterConfig.env to include their token:

```bash
curl -s -X PATCH http://127.0.0.1:3100/api/agents/AGENT_ID \
  -H "Content-Type: application/json" \
  -d '{"adapterConfig":{"env":{"SLACK_BOT_TOKEN":{"type":"secret_ref","secretId":"SECRET_UUID"}}}}'
```

### Step 5: Invite all bots to #tryps-agents

Invite all 5 bot users to the channel.

### Step 6: Post Sean Test welcome messages

Each agent posts their opening message. These MUST read like real contractors:

- **Henry:** "morning all. spinning up for the day — checking on open tasks and will post the first digest shortly."
- **Pablo:** "working on the brand book cover pages, should have first drafts in figma by end of day"
- **Don:** "starting the ugc creator research, pulling travel/lifestyle creators. will share the first batch when i have 50+"

### Step 7: Add SOUL.md Slack rules to remaining agents

Don, Felix, Reese need the same Slack Communication section added to their SOUL.md. Henry and Pablo already have it. The section is:

```markdown
## Slack Communication

You are a contractor on the Tryps team. You communicate in Slack like a real person.

Rules:
- Never identify yourself as AI. Never say "as an AI" or "I'm happy to help."
- Keep messages under 2 sentences for updates. Longer only for technical explanations.
- Use lowercase unless starting a sentence with a proper noun.
- Have opinions. Push back when something seems off.
- Ask clarifying questions instead of always just executing.
- No bullet points in Slack unless sharing a specific list of items.
- No emoji reactions unless someone else does first.
- Reference real things: "just pushed to the brand-book branch" not "I have completed the task."
- When sharing work, drop a link. Don't describe what you did in detail.
```

### Phase 1 Acceptance Tests

- [ ] TEST 1.1: 5 bot tokens stored in Paperclip secrets, each bot can post to #tryps-agents
- [ ] TEST 1.2: Each bot user has a non-default profile photo in Slack
- [ ] TEST 1.3: Sean Test — Henry, Pablo, Don opening messages read like real contractors
- [ ] TEST 1.4: Tag @Pablo in #tryps-agents, verify mention routes to Paperclip agent

---

## Phase 2: Brand Book — 15 MUST Screens

**Goal:** Pablo produces 15 brand book screens. Don starts UGC creator research in parallel.

### Pablo's 15 MUST screens

1. Cover
2. Table of Contents
3. Brand Story — The Problem
4. Brand Story — The Insight
5. Mission & Vision
6. Brand Values
7. Brand Personality ("We are X, not Y")
8. Target Audience / Persona
9. How It Works (3-step visual)
10. Before / After
11. Clear Space & Minimum Size (logo rules)
12. Logo Misuse / Don'ts
13. Color — Secondary & Semantic
14. Color Usage Rules
15. Type Scale & Hierarchy

**Brand rules (mandatory):**
- Background: white or very light gray (#F9FAFB) — NOT warm cream
- Primary: Tryps Red #D9071C
- Error: #D14343 (distinct from brand red)
- Font: Plus Jakarta Sans (all weights), Space Mono (numbers)
- Text color: Deep Slate #3D3530
- Layout: 1920x1080 presentation slides
- Shadows: max 0.1 opacity

**Prompts:** Ready to use at `~/tryps-docs/brand-and-gtm/designs/brand-book-make-prompts.md` (64 slides, 75KB)

**If Figma MCP OAuth works:** Pablo creates frames directly in Figma
**Fallback:** HTML mockups via /figma-design -> /figma-capture, or generate as PNGs via StableStudio

### Don's parallel work: UGC Creator List

- Target: 50 creators by end of phase, 300 by end of week
- Use AgentCash (StableEnrich + StableSocial) for research
- Each entry: name, platform, handle, follower count, content style, fit score
- Output: `~/tryps-docs/brand-and-gtm/03-ugc-program/creator-list-draft.md`

### Phase 2 Acceptance Tests

- [ ] TEST 2.1: 15 brand book screens exist (Figma or local), 1920x1080, correct colors/fonts
- [ ] TEST 2.2: Sean Test — at least 10/15 look like real agency output
- [ ] TEST 2.3: Content accuracy — Tryps (not Tripful), correct hex values, Plus Jakarta Sans
- [ ] TEST 2.4: Creator list has 50+ entries with name, platform, handle, follower count
- [ ] TEST 2.5: Pablo posts Figma link in #tryps-agents like a real designer

---

## Phase 3: Video Editor Agent — Rio Nakamura

**Goal:** Create Rio agent, produce a 15-second teaser clip.

### Rio's config

| Field | Value |
|-------|-------|
| Name | Rio Nakamura |
| Title | Video & Content |
| Adapter | claude_local |
| Model | Opus |
| Budget | $100/month |
| Timezone | Eastern Time |

### Setup steps

1. Generate profile photo using StableStudio (prompt in execution prompt)
2. Save to `~/tryps-docs/agents/profile-photos/rio-nakamura.png`
3. Register in Paperclip with SOUL.md including video brand rules
4. Create Slack app, upload photo, invite to #tryps-agents
5. Wire LangFuse env vars + OTEL_SERVICE_NAME=rio

### Rio's first task

Produce a 15-second Tryps teaser based on Scene 01 of `~/tryps-docs/brand-and-gtm/04-launch-video/launch-video-treatment.md`:
- Neutral white world, person picks up phone, opens iMessage, texts "Marty from Tryps"
- Only color is Tryps Red on the device screen
- Use Seedance Fast for drafts ($0.04-0.12/clip)
- Produce 9:16 and 16:9 versions
- Save to `~/tryps-docs/brand-and-gtm/04-launch-video/drafts/`

### Phase 3 Acceptance Tests

- [ ] TEST 3.1: Rio registered in Paperclip with SOUL.md, Slack app with photo
- [ ] TEST 3.2: Rio posts introduction in #tryps-agents (reads like real video editor)
- [ ] TEST 3.3: At least 2 video clips exist (9:16 + 16:9), 10-15 seconds
- [ ] TEST 3.4: Content arm viability — Pablo, Don, Rio all producing output

---

## Phase 4: Investor Cost Visibility Page

**Goal:** Single-page cost breakdown for investors.

### Output

File: `~/tryps-docs/docs/pitch-deck-ideas/org-cost-structure.md`

Title format: "Total Monthly Burn: $XX,XXX — $YY,YYY Human Offshore + $ZZZ Agentic Workforce"

Contents:
- Org chart (human workforce + agent workforce + infrastructure)
- Each person/agent: name, role, monthly cost, location
- Key metrics: agent-to-human ratio, cost per function, projected cost at 10x
- LangFuse dashboard URL linked at top
- "Last updated" timestamp
- JAKE: FILL IN markers for unknown contractor rates

### Daily update mechanism

- Marty cron: `0 22 * * * update-cost-page`
- Pulls real numbers from LangFuse API: `GET /api/public/metrics/daily`
- Updates cost page alongside nightly report

### Phase 4 Acceptance Tests

- [ ] TEST 4.1: Cost page exists with actual dollar amounts
- [ ] TEST 4.2: Non-technical person can understand in 60 seconds
- [ ] TEST 4.3: Marty cron configured, page has timestamp

---

## Phase 5: Integration & Sean Handoff

**Goal:** Creative arm operational for Sean.

### Sean handoff doc

File: `~/tryps-docs/brand-and-gtm/sean-agent-guide.md`

Contents:
- How to give Pablo/Don/Rio tasks (tag in Slack or create Paperclip issue)
- How to review and give feedback (reply in thread, be specific)
- What agents CAN'T do (taste calls, relationship management, on-camera work)
- Current status of brand book, UGC list, video drafts

### Henry daily digest format

```
morning digest — [date]

pablo: [status]
don: [status]
rio: [status]

blockers: [any]
spend today: ~$X.XX (breakdown).

tagging @sean for [review item].
```

### Phase 5 Acceptance Tests

- [ ] TEST 5.1: Sean handoff doc exists, plain language
- [ ] TEST 5.2: Tag @Pablo/@Don/@Rio in Slack, each responds like a real contractor
- [ ] TEST 5.3: Henry posts daily digest with spend numbers
- [ ] TEST 5.4: At least 2 sean.md checkboxes progressed
- [ ] TEST 5.5: THE FULL SEAN TEST — screenshot #tryps-agents, would someone think these are 5 real people?

---

## Constraints

- Budget cap: $10 total across all generation APIs per session
- All Slack messages must pass the Sean Test — no AI tells
- Every phase's tests must pass before proceeding to the next
- Observability is non-negotiable — check LangFuse after every phase
- Don't skip fallbacks — if Figma MCP blocks, use HTML mockup pipeline immediately

## Kickoff Prompt

```
Read @~/tryps-docs/docs/plans/2026-03-30-agentic-org-gtm-scope.md

## Context
@~/tryps-docs/docs/plans/2026-03-28-tryps-agentic-operating-model.md
@~/tryps-docs/docs/plans/2026-03-28-feat-paperclip-hybrid-org-and-pablo-agent-plan.md
@~/tryps-docs/shared/brand.md
@~/tryps-docs/brand-and-gtm/sean.md
@~/tryps-docs/brand-and-gtm/reference/brand-book-screen-checklist.md
@~/tryps-docs/brand-and-gtm/designs/brand-book-make-prompts.md
@~/tryps-docs/brand-and-gtm/04-launch-video/launch-video-treatment.md

## Your Task
Execute Phases 1-5 of the Agentic Org GTM scope. Phase 0 is done.
Start with Phase 1 (Slack Identity Layer). Run /workflows:work on each phase.
Do NOT proceed to the next phase until all acceptance tests pass.
```
