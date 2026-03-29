---
title: "Agentic Org Execution Prompt"
type: execution
date: 2026-03-29
status: ready
owner: jake
---

# Agentic Org Execution — Handoff Prompt

> Copy-paste this into a new Claude Code terminal to execute.
> This prompt is self-contained. It references all files needed via @file refs.

---

You are executing the Tryps Agentic Operating Model. Your job is to stand up the
creative/brand arm of the agent workforce TODAY, prove it works, and create investor-
ready cost visibility.

## Context Files (read all before starting)

1. @~/tryps-docs/docs/plans/2026-03-28-tryps-agentic-operating-model.md — The operating model
2. @~/tryps-docs/docs/plans/2026-03-28-feat-paperclip-hybrid-org-and-pablo-agent-plan.md — Paperclip plan
3. @~/tryps-docs/shared/brand.md — Brand system (colors, typography, voice)
4. @~/tryps-docs/brand-and-gtm/sean.md — Sean's contract and deliverables
5. @~/tryps-docs/brand-and-gtm/reference/brand-book-screen-checklist.md — 48-screen brand book target
6. @~/tryps-docs/brand-and-gtm/designs/brand-book-make-prompts.md — 64 ready-to-use slide prompts
7. @~/tryps-docs/brand-and-gtm/04-launch-video/launch-video-treatment.md — Video treatment
8. @~/tryps-docs/brand-and-gtm/README.md — Brand & GTM folder structure

## What Already Exists

- Paperclip running locally at http://127.0.0.1:3100
- Henry (CEO agent) registered and running
- Pablo (Designer agent) registered, first task assigned (TRY-3: 5 brand book pages)
- Profile photos generated and saved at ~/tryps-docs/agents/profile-photos/:
  - pablo-desouza.png, don-reyes.png, felix-chung.png, reese-okafor.png, henry-park.png, rio-nakamura.png
- Brand book prompts ready (64 slides, 75KB of copy-paste-ready Figma Make prompts)
- Launch video treatment written ("However You Get To Us" — 60s film)
- Figma MCP plugin installed (needs OAuth)

## Your Task

Execute in 6 phases. Each phase has acceptance tests. Do NOT proceed to the next
phase until tests pass. Run tests using Claude Code tools (file checks, API calls,
screenshots, Slack messages).

**Critical rule from the research:** Observability BEFORE agents. Every practitioner
who scaled past 2-3 agents says the same thing — you need to see what agents are
doing, where they're failing, and what they're spending. Phase 0 exists because of
this. Do not skip it.

**Second critical rule:** Henry (CEO agent) is a ROUTER, not a decision-maker.
"AI scales the hands, not the vision." Henry routes tasks to agents. Jake decides
what tasks exist. No agent has authority to decide what to build, what to prioritize,
or what's "good enough." Those are human-only calls.

---

## PHASE 0: Observability Infrastructure (15 min)

### What is LangFuse

LangFuse is an open-source dashboard that shows every LLM call every agent makes.
Input, output, tokens, cost, latency, success/fail — all in a web UI. Think Datadog
for AI agents. YC W23, acquired by ClickHouse Jan 2026. Free tier: 50K observations/month.

We use LangFuse Cloud (not self-hosted) because it takes 5 minutes to set up vs.
hours for Docker on Hetzner. We can migrate to self-hosted later if needed.

### What to do

**Step 1: Sign up (5 min)**
1. Go to cloud.langfuse.com
2. Create account with jake@jointryps.com
3. Create a project called "tryps-agents"
4. Go to project Settings > API Keys
5. Copy `LANGFUSE_PUBLIC_KEY` (pk-lf-...) and `LANGFUSE_SECRET_KEY` (sk-lf-...)

**Step 2: Store keys (2 min)**
Add to ~/.zshrc alongside existing env vars:
```bash
export LANGFUSE_PUBLIC_KEY="pk-lf-..."
export LANGFUSE_SECRET_KEY="sk-lf-..."
export LANGFUSE_BASE_URL="https://cloud.langfuse.com"
```
Source it: `source ~/.zshrc`

Also store in Paperclip secrets so all agents inherit these env vars.

**Step 3: Instrument Paperclip agents (10 min)**

For every agent that uses the Anthropic SDK (Henry, Pablo, Don, Felix, Reese, Rio),
add OpenTelemetry instrumentation. This is 3 lines of code added once to the agent
initialization:

```python
# Add to each agent's startup / HEARTBEAT initialization
from opentelemetry.instrumentation.anthropic import AnthropicInstrumentor
AnthropicInstrumentor().instrument()
```

Install the dependency in the Paperclip environment:
```bash
pip install langfuse opentelemetry-instrumentation-anthropic
```

This auto-traces every Anthropic API call. No other code changes needed.

**Step 4: Tag traces by agent (5 min)**

Each agent should tag its traces with its name so you can filter in the dashboard:
```python
import os
os.environ["OTEL_SERVICE_NAME"] = "pablo"  # or "henry", "don", etc.
```

Add this to each agent's HEARTBEAT.md or startup config in Paperclip.

**Step 5: Instrument Marty on Hetzner (separate — can do after other phases)**

Marty runs on Hetzner via OpenClaw. Two options:
- If Marty routes through OpenRouter: use OpenRouter Broadcast (zero-code, just config)
- If direct Anthropic SDK: SSH to Hetzner, add the same 3 lines + pip install

This can happen in parallel with other phases. Marty's existing cron keeps running.

**Step 6: Verify the dashboard**

Open cloud.langfuse.com. You should see:
- A "tryps-agents" project
- Traces appearing as agents make calls
- Each trace tagged with the agent name
- Cost per trace visible

Bookmark this URL. Check it every morning alongside the Henry digest.

### Phase 0 Tests

```
TEST 0.1: LangFuse account exists
- [ ] cloud.langfuse.com login works for jake@jointryps.com
- [ ] Project "tryps-agents" exists
- [ ] API keys are generated and stored in ~/.zshrc

TEST 0.2: Keys are accessible
- [ ] Run: source ~/.zshrc && echo $LANGFUSE_PUBLIC_KEY
- [ ] Output: starts with "pk-lf-"
- [ ] Keys also stored in Paperclip secrets

TEST 0.3: Instrumentation installed
- [ ] pip install langfuse opentelemetry-instrumentation-anthropic succeeds
- [ ] No import errors when running the instrumentation code

TEST 0.4: First trace appears
- [ ] Trigger any agent to make one LLM call (e.g., Henry's heartbeat)
- [ ] Open cloud.langfuse.com > Traces
- [ ] PASS CONDITION: At least one trace visible with: model name, input, output,
      token count, cost estimate, agent name tag
- [ ] If no trace appears within 60 seconds, check env vars and re-instrument

TEST 0.5: Cost visibility works
- [ ] Open LangFuse dashboard > Analytics
- [ ] Can see: total cost today, cost by agent, cost by model
- [ ] PASS CONDITION: You can answer "how much did Pablo spend today?" from the dashboard
```

**If Phase 0 fails:** Do NOT proceed. Fix instrumentation first. The entire point of
the agent org is visibility into what's happening. Flying blind with 6+ agents is how
you burn money and ship slop without knowing it.

**Budget note:** LangFuse free tier = 50K observations/month. At ~9 agents making
~50 calls/day each, that's ~54K/month — right at the limit. Plan to upgrade to
Core ($29/month) within the first week. Apply for their startup discount (50% off
first year) at langfuse.com/pricing.

---

## PHASE 1: Slack Identity Layer (30 min)

### What to do

Create 5 Slack apps — one per agent. Each must be indistinguishable from a real
human contractor (the "Sean Test": if Sean can't tell it's an agent, we win).

**For each agent, create a Slack app:**

| Agent | Display Name | Title | Timezone |
|-------|-------------|-------|----------|
| Pablo | Pablo DeSouza | Brand & UI Design | Eastern Time |
| Don | Don Reyes | Brand & Growth | Eastern Time |
| Felix | Felix Chung | Frontend Dev | Eastern Time |
| Reese | Reese Okafor | Backend Dev | Eastern Time |
| Henry | Henry Park | Project Lead | Eastern Time |

**For each app:**
1. Go to api.slack.com/apps -> Create New App -> From scratch
2. Name: agent's first name (e.g., "Pablo")
3. Scopes: `app_mentions:read`, `chat:write`, `channels:history`, `channels:read`, `users:read`
4. Install to Tryps workspace
5. Upload profile photo from ~/tryps-docs/agents/profile-photos/
6. Set display name, title, timezone as above
7. Save Bot User OAuth Token

**Channel setup:**
- Create #tryps-agents channel (public)
- Invite all 5 bot users to #tryps-agents
- Post a welcome message from Henry: "morning all. spinning up for the day — checking on open tasks and will post the first digest shortly."

**Wire into Paperclip:**
- Store each bot token as a Paperclip secret
- Configure the Slack plugin to route each agent's messages through their own bot token
- Each agent posts AS THEMSELVES, not through a shared bot

**SOUL.md communication rules (add to every agent):**

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

### Phase 1 Tests

```
TEST 1.1: Slack apps exist
- [ ] Run: check that 5 bot tokens are stored in Paperclip secrets
- [ ] Verify: each bot can post to #tryps-agents (send a test message from each)

TEST 1.2: Profile photos uploaded
- [ ] Verify: each bot user in Slack has a non-default profile photo

TEST 1.3: Sean Test — first impression
- [ ] Henry posts: "morning all. spinning up for the day — checking on open tasks and will post the first digest shortly."
- [ ] Pablo posts: "working on the brand book cover pages, should have first drafts in figma by end of day"
- [ ] Don posts: "starting the ugc creator research, pulling travel/lifestyle creators. will share the first batch when i have 50+"
- [ ] PASS CONDITION: Read the messages. Do they read like real contractors? No AI tells? No overly formal language?

TEST 1.4: Channel routing works
- [ ] Tag @Pablo in #tryps-agents with "hey pablo can you share the figma link when you're done with the cover?"
- [ ] Verify: the mention routes to Pablo's agent in Paperclip (check Paperclip logs)
```

---

## PHASE 2: Brand Book — Produce 15 MUST Screens Today (2-3 hours)

### What to do

Pablo's job: produce the 15 MUST-priority brand book screens in Figma. Use the
prompts from brand-book-make-prompts.md as the starting point.

**If Figma MCP OAuth is working:**
- Pablo uses `use_figma` tool to create frames directly in the Tryps Figma file
- Target: "Building the World" page, section by section

**If Figma MCP OAuth is NOT working (fallback):**
- Use /figma-design skill to generate HTML mockups for each screen
- Use /figma-capture to push them into Figma
- OR: Generate all 15 as high-quality PNGs using StableStudio (gpt-image-1.5)
  with the exact brand prompts from brand-book-make-prompts.md, then manually
  import to Figma

**The 15 MUST screens (from brand-book-screen-checklist.md):**

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

**Brand rules Pablo must follow (from brand.md):**
- Background: white or very light gray (#F9FAFB) — NOT warm cream
- Primary: Tryps Red #D9071C (warm, never for errors)
- Error: #D14343 (distinct from brand red)
- Font: Plus Jakarta Sans (all weights), Space Mono (numbers)
- Text color: Deep Slate #3D3530
- Film camera warmth as visual motif, not anchor
- Shadows: max 0.1 opacity, barely there
- Layout: 1920x1080 presentation slides

**Parallel work for Don:**
- While Pablo designs, Don compiles the UGC creator master list
- Don uses AgentCash (StableEnrich + StableSocial) to search for travel/lifestyle creators
- Target: 50 creators by end of phase, 300 by end of week
- Each entry: name, platform, handle, follower count, content style, fit score

### Phase 2 Tests

```
TEST 2.1: Brand book screens exist
- [ ] Check Figma (or local files) for 15 brand book screens
- [ ] Each screen is 1920x1080
- [ ] Each uses correct colors (#D9071C, #F9FAFB or white, #3D3530)
- [ ] Each uses Plus Jakarta Sans (not Space Grotesk, not any other font)
- [ ] No warm cream backgrounds (the brand.md drift)

TEST 2.2: Brand book quality — the Sean Test
- [ ] Open the 15 screens side by side
- [ ] PASS CONDITION: At least 10/15 look like a real brand book from a real agency.
  Not AI slop. Not generic. Could you show this to Trent at the next omakase?
- [ ] If <10 pass, iterate on SOUL.md and regenerate the worst ones

TEST 2.3: Content accuracy
- [ ] Cover says "Tryps" (not "Tripful" or "Vamos")
- [ ] Mission/Vision match the brand.md content
- [ ] Color screens show actual hex values from theme.ts
- [ ] Typography screens reference Plus Jakarta Sans and Space Mono
- [ ] "How It Works" references Martin and iMessage (not a generic app flow)
- [ ] "Before / After" shows real competitor chaos vs. Tryps simplicity

TEST 2.4: Don's UGC list
- [ ] File exists: ~/tryps-docs/brand-and-gtm/03-ugc-program/creator-list-draft.md
- [ ] Contains at least 50 entries
- [ ] Each entry has: name, platform, handle, follower count, content style
- [ ] Mix of platforms (not all Instagram)
- [ ] Matches Sean's criteria (travel/lifestyle, creator sizes per sean.md)

TEST 2.5: Pablo posts update to Slack
- [ ] Pablo posts in #tryps-agents: link to Figma frames or folder with outputs
- [ ] Message reads like a real designer sharing work (not "I have completed 15 screens")
```

---

## PHASE 3: Video Editor Agent — "Rio" (1-2 hours)

### What to do

Create a new agent: **Rio** — Video Editor & Content Creator. Rio's job is to
produce Tryps-style video content: product demos, meta ads, social clips, launch
teasers. This is the most ambitious agent — it proves the content generation arm works.

**Agent config:**

| Field | Value |
|-------|-------|
| Name | Rio Nakamura |
| Display Name | Rio Nakamura |
| Title | Video & Content |
| Role | Video Editor & Content Creator |
| Adapter | claude_local |
| Model | Opus |
| Heartbeat | Wake on assignment |
| Budget | $100/month (video generation is expensive) |
| Reports to | Henry |
| Timezone | Eastern Time |

**Generate Rio's profile photo** using StableStudio (gpt-image-1.5):
- Prompt: "Casual headshot photo of Rio Nakamura, a 28-year-old Japanese-American male video editor and content creator. Medium length dark hair pushed back, creative stubble, warm expression. Wearing a vintage band tee. Natural indoor lighting, slightly off-center like a real Slack profile photo. Photorealistic."
- Save to ~/tryps-docs/agents/profile-photos/rio-nakamura.png
- Create Slack app, upload photo, invite to #tryps-agents

**Rio's skills (install from skills.sh or configure manually):**

1. **StableStudio video generation** — Rio can generate video clips using:
   - Veo 3.1 (highest quality, $1.60-3.20/clip)
   - Seedance Fast (cheaper, $0.04-0.12/clip, good for drafts)
   - Grok Video ($0.15-0.75/clip)

2. **Brand-aware video prompting** — Rio knows the Tryps visual language:
   - Launch video treatment: neutral white world, only color is Tryps Red on device screens
   - Film camera warmth, grain texture
   - Apple keynote energy: locked off camera, slow push-ins
   - Anthony Bourdain personality: warm, no pretense, curious

3. **Content formats Rio can produce:**
   - 15s/30s/60s social clips (Instagram Reels, TikTok, X)
   - Product demo walkthroughs (screen recording + AI narration)
   - Meta/Instagram ad creatives (multiple variants for A/B testing)
   - Launch teaser clips (based on launch-video-treatment.md)

**Rio's SOUL.md additions:**
```markdown
## Video & Content Creation

You are a video editor and content creator for Tryps. You produce brand-aligned
video content using AI generation tools.

Brand rules for all video:
- Tryps Red (#D9071C) is the only accent color in most shots
- Neutral, warm backgrounds — not clinical, not cold
- Plus Jakarta Sans for any text overlays
- Film camera grain/warmth when appropriate
- Apple keynote energy: composed, still, confident
- No stock footage energy. No generic "friends laughing" montages.
- Every video should make someone think "I want to be on that trip"

Formats:
- Always produce 3 aspect ratios: 9:16 (Stories/Reels), 16:9 (YouTube/ads), 1:1 (feed)
- Keep videos short: 15s for ads, 30s for social, 60s max for launch content
- First 3 seconds must hook — no logo intros, no slow fades

When sharing work in Slack:
- "just rendered a few versions of the teaser — 9:16 and 16:9. lmk which direction feels right"
- Drop the video links directly, no long explanations
```

**Rio's first task: Produce a 15-second Tryps teaser clip**

Using the launch video treatment as creative direction:
- Seedance Fast for the draft (cheap, fast iteration)
- Prompt based on Scene 01 of the treatment: neutral white world, person picks up
  phone, opens iMessage, texts "Marty from Tryps", only color is Tryps Red on the screen
- Produce 9:16 and 16:9 versions
- Post to #tryps-agents for Jake/Sean review

### Phase 3 Tests

```
TEST 3.1: Rio exists in Paperclip
- [ ] Agent registered with correct config
- [ ] SOUL.md includes video brand rules
- [ ] Slack app created with profile photo

TEST 3.2: Rio posts introduction
- [ ] Rio posts in #tryps-agents: "hey all, just got set up. working on a 15s teaser
      based on the launch video treatment. will have drafts up soon"
- [ ] PASS CONDITION: message reads like a real video editor joining a team

TEST 3.3: Video content generated
- [ ] At least 2 video clips exist (9:16 and 16:9 versions)
- [ ] Videos are 10-15 seconds long
- [ ] Videos reference Tryps visual language (neutral world, red accent)
- [ ] Videos are saved to ~/tryps-docs/brand-and-gtm/04-launch-video/drafts/

TEST 3.4: Content arm viability
- [ ] Pablo has produced brand book screens
- [ ] Don has produced UGC creator research
- [ ] Rio has produced video content
- [ ] PASS CONDITION: Sean could review all three outputs and give directional
      feedback without knowing any of them are AI-generated
```

---

## PHASE 4: Investor Cost Visibility Page (30 min)

### What to do

Create a single-page cost breakdown that Jake can show investors. This goes in
a new folder: ~/tryps-docs/docs/pitch-deck-ideas/

**File: ~/tryps-docs/docs/pitch-deck-ideas/org-cost-structure.md**

**Title format:** "Total Monthly Burn: $XX,XXX — $YY,YYY Human Offshore + $ZZZ Agentic Workforce"

**Content:**

```
Full Org Chart (visual — use ASCII or mermaid diagram)
├── HUMAN WORKFORCE
│   ├── Each person: name, role, monthly cost, location
│   └── Subtotal: $XX,XXX/month
├── AGENT WORKFORCE
│   ├── Each agent: name, role, monthly cost (tokens + APIs), adapter
│   └── Subtotal: $XXX/month
├── INFRASTRUCTURE
│   ├── Hetzner, Supabase, Vercel, SaaS tools
│   └── Subtotal: $XXX/month
└── TOTAL: $XX,XXX/month
```

**Key metrics for investors:**
- Revenue per employee (once revenue exists)
- Agent-to-human ratio (currently ~8 agents : 7 humans)
- Cost per function (content creation: $X human vs. $Y agent)
- Projected cost at 10x scale (how much does headcount grow vs. agent count?)

**Daily update mechanism:**
- Agent costs: Pull REAL numbers from LangFuse API daily (not estimates)
  - LangFuse tracks actual token usage + cost per agent per day
  - Use LangFuse public API: `GET /api/public/metrics/daily` filtered by tags
- Marty runs a cron that reads LangFuse actuals + Paperclip budget + known contractor costs
- Updates the cost page daily at 10pm alongside the nightly report
- Add to Marty's HEARTBEAT: `0 22 * * * update-cost-page`
- The LangFuse dashboard URL should be linked at the top of the cost page

**Important:** Jake needs to fill in contractor rates for this to be accurate.
Create the template with placeholders and a clear "JAKE: FILL IN" marker for
each unknown cost. Use the agent costs from the operating model (they're known).

### Phase 4 Tests

```
TEST 4.1: Cost page exists
- [ ] File exists: ~/tryps-docs/docs/pitch-deck-ideas/org-cost-structure.md
- [ ] Title includes actual dollar amounts (even if some are estimates)
- [ ] Org chart includes all 8 agents and all 7 humans
- [ ] Agent costs match the operating model ($365/month + Rio's $100 = $465)

TEST 4.2: Investor readability
- [ ] A non-technical person can understand the page in 60 seconds
- [ ] The "total monthly burn" number is prominently displayed
- [ ] The human vs. agent cost split is immediately clear
- [ ] There's a "what this means" section explaining the leverage

TEST 4.3: Daily update mechanism
- [ ] Marty cron configured (or documented for configuration)
- [ ] Cost page has a "Last updated" timestamp
- [ ] Known costs are filled in, unknown costs are clearly marked
```

---

## PHASE 5: Integration & Sean Handoff (30 min)

### What to do

Make the creative arm operational for Sean. He needs to be able to:

1. **Tag @Pablo in Slack** with a design brief and get Figma output
2. **Tag @Don in Slack** with a research request and get a compiled doc
3. **Tag @Rio in Slack** with a content brief and get video drafts
4. **See daily digests from Henry** summarizing what the creative team produced

**Create a handoff doc for Sean:**

File: ~/tryps-docs/brand-and-gtm/sean-agent-guide.md

Contents:
- How to give Pablo a design task (tag in Slack or create a Paperclip issue)
- How to give Don a research task
- How to give Rio a content task
- How to review and give feedback (reply in thread, be specific)
- What agents CAN'T do (taste calls, relationship management, on-camera work)
- Current status of brand book, UGC list, video drafts

**Update sean.md checkboxes** — mark any that have been progressed by agents today.

**Post in #tryps-agents from Henry:**
Daily digest format:
```
morning digest — march 29

pablo: 15 brand book screens drafted in figma. sean to review.
don: ugc creator list at 53 entries, targeting 300 by tuesday.
rio: first teaser draft rendered — 9:16 and 16:9 versions ready for review.

blockers: figma mcp oauth still pending, using fallback pipeline.
spend today: ~$2.40 (video gen + image gen + research apis).

tagging @sean for brand book review when you get a chance.
```

### Phase 5 Tests

```
TEST 5.1: Sean handoff doc exists
- [ ] File exists: ~/tryps-docs/brand-and-gtm/sean-agent-guide.md
- [ ] Explains how to interact with each agent
- [ ] Written in plain language (Sean is non-technical)

TEST 5.2: Slack workflow works end-to-end
- [ ] Sean (or Jake simulating Sean) can tag @Pablo and get a response
- [ ] Sean can tag @Don and get a response
- [ ] Sean can tag @Rio and get a response
- [ ] All responses read like real contractors

TEST 5.3: Henry daily digest
- [ ] Henry has posted at least one digest to #tryps-agents
- [ ] Digest includes status of all creative agents
- [ ] Digest includes daily spend
- [ ] Digest tags relevant humans for review

TEST 5.4: sean.md progress
- [ ] At least 2 checkboxes in sean.md have been progressed
- [ ] Brand book has draft screens (even if not finalized)
- [ ] UGC program has a creator list started

TEST 5.5: The full Sean Test
- [ ] Look at #tryps-agents channel history from today
- [ ] Read all messages from Pablo, Don, Rio, Henry
- [ ] FINAL PASS CONDITION: Could you screenshot this channel and show it to
      someone who doesn't know about the agent org? Would they think these are
      5 real people working on your brand launch?
```

---

## Success Criteria — End of Day March 29

By tonight, these things should be true:

0. **LangFuse is live** — every agent call is traced, cost is visible in real-time
1. **6 agents are live in Slack** (Pablo, Don, Rio, Felix, Reese, Henry) with real profiles
2. **15 brand book screens exist** — ready for Sean to review and give feedback
3. **A video editor agent (Rio) has produced a teaser clip** — proves the content arm works
4. **An investor-ready cost page exists** — shows the full org with costs, updated daily from LangFuse
5. **Sean has a guide** for directing his agent team starting Monday
6. **Henry is posting daily digests** — includes real spend numbers from LangFuse

If all 7 are true, the creative arm of the agentic org is operational and testable.
The Sean Test is the ultimate bar: indistinguishable from human contractors.

**The observability test:** Open cloud.langfuse.com right now. Can you see:
- Every agent's calls from today?
- Total spend by agent?
- Which calls failed and why?
If yes, you have something most agent-first companies don't have on day 1.

---

## Execution Notes

- Use /workflows:plan to structure each phase before executing
- Use subagents in parallel where possible (Pablo designing while Don researches)
- If Figma MCP OAuth blocks Pablo, fall back immediately to HTML mockup -> capture pipeline
- For video generation, start with Seedance Fast ($0.04-0.12) for drafts, only use Veo 3.1 for finals
- Budget cap for today: $10 total across all generation APIs
- All agent Slack messages must pass the Sean Test — no AI tells, no formal language
- Every test must pass before moving to the next phase. If a test fails, fix and retest.
