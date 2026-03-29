---
title: "Upwork Job Posting — Agentic Workforce Manager"
date: 2026-03-29
status: draft
owner: jake
---

# Upwork Job Posting — Agentic Workforce Manager

---

## Job Title

**Agentic Workforce Manager — AI Agent Operations & Harness Engineering**

---

## Job Description (Post This)

We're a small startup (travel app, Expo + TypeScript + Supabase) that has gone
all-in on an agent-first operating model. We already have a working product team:
I (founder) write specs, 3 dev contractors build them, QA validates, and AI agents
(Claude Code, OpenClaw) handle PR reviews, bug triage, and state sync. When I say
something, it gets built. That team works.

Now I need to build the next team: **the brand/content team.** Then customer
success. Then finance. Each one follows the same pattern — a human director
steering a workforce of AI agents and (where needed) human specialists.

**I need someone to help me build these teams.**

You sit alongside me and help design, stand up, and optimize each org. You
figure out what needs a human vs. what can be an agent. You set up the agents,
wire the workflows, tune the prompts, and build the observability so we can
see what's working. You're not writing app code — you're building the engine
that makes the organization run.

**Your first objective: Build the brand content engine.**

Our creative director Sean is the shot caller for brand and content. The goal:
Sean has an idea for a 15-second video, says it in Slack, and agents (plus maybe
one human helper) produce a polished clip the same day. Same for brand book pages,
social posts, UGC outreach, ad creatives.

What this looks like when it's working:
- Sean says "I want a 15s clip showing the group chat booking flow"
- A video editor agent (Rio) produces 2-3 draft versions using AI video tools
- A design agent (Pablo) creates the thumbnail/social assets in Figma
- Sean reviews, gives one round of feedback, and it ships
- By May 2, we have 100+ pieces of content ready across Instagram, TikTok, X,
  YouTube Shorts — all produced through this engine

We already have the agents registered (Pablo for design, Don for marketing
research, Rio for video). We have Paperclip running locally for orchestration.
We have LangFuse for observability. What we need is someone who can take this
from "agents exist" to "agents produce content Sean can actually ship."

**After brand, you'll help build:**
- Customer success org (support agents, ticket triage, escalation workflows)
- Finance/ops org (invoice automation, cost tracking, reporting)
- Whatever else needs a team — you help me figure out the right human/agent mix

**Day-to-day you'll be doing:**

- Writing and tuning SOUL.md and HEARTBEAT.md files (agent behavior and personality)
- Setting up new agents and wiring them into Slack, Figma, ClickUp
- Building and maintaining LangFuse observability dashboards
- Helping our human engineers use Claude Code better (prompt libraries, skills, MCP configs)
- Running experiments: AI video pipelines, agent-to-agent handoffs, persistent memory
- Figuring out where we need a human (e.g., someone to film screen recordings)
  vs. where an agent can handle it end-to-end
- Helping me think strategically about workload optimization across the whole org

**What you won't do:**

- Write application code (we have 3 devs for that)
- Make product or creative decisions (I set product direction, Sean sets creative direction)
- Be the creative director (Sean is — you build the machine that executes his vision)

**You are:**

- Someone who has actually built and managed multi-agent systems (not just read
  about them). Show us. Repos, screenshots, case studies.
- Fluent in the Claude ecosystem: Claude Code, Anthropic SDK, MCP servers,
  tool use, context windows, prompt engineering
- Familiar with at least one agent orchestration framework (Paperclip, OpenClaw,
  CrewAI, AutoGen, LangGraph — we use Paperclip + OpenClaw)
- Obsessed with context engineering — you understand that the hardest problem
  isn't making agents work, it's making them work *consistently* with the right
  context
- Comfortable with LLM observability tools (LangFuse, Helicone, LangSmith, or
  equivalent)
- Able to think at the org-design level, not just the technical level — you
  understand when an agent should exist vs. when a human should do the work
- A clear communicator who can write a one-page strategy doc, not just config files

**Required skills:**

- Agent orchestration frameworks (Paperclip, OpenClaw, CrewAI, AutoGen, LangGraph)
- LLM observability (LangFuse, Helicone, OpenTelemetry instrumentation)
- Claude Code (skills, slash commands, MCP server configuration)
- Slack API and bot development (creating apps, bot tokens, app_mentions)
- Python and/or TypeScript (SDK instrumentation, webhook wiring, glue code)
- System prompt engineering and context engineering (SOUL.md, HEARTBEAT.md patterns)

**Strong bonus — AI content generation pipeline experience:**

- Programmatic video generation (Remotion, Runway, Kling, HeyGen, StableStudio, Sora)
- AI-assisted design workflows (Figma MCP write-to-canvas, html.to.design)
- Automated content pipelines: brand books, social media assets, ad creatives
  produced end-to-end by agents with human review gates
- Experience with x402/micropayment APIs (AgentCash) for agent tool access

**Nice to have:**

- Familiarity with the agentic org practitioner community (r/clawdbot, r/openclaw)
- LLM cost optimization (model selection, prompt compression, caching)
- Experience building brand/marketing automation with AI

**Engagement:**

- Full-time (40 hrs/week) for Week 1, then reassess
- Timezone: Must overlap with US Eastern Time — daily standup with the team
- Rate: $20-35/hour depending on experience (show us what you've built)
- Start: Immediately (this weekend if possible)
- Initial engagement: 1-2 week sprint, then weekly evaluation

**To apply:**

Don't send a generic cover letter. Answer these 3 questions (2-3 sentences each):

1. Describe a multi-agent system you built. How many agents, what did they do,
   what orchestration framework did you use?
2. We have a creative director (Sean) who needs to say "I want a 15-second
   video showing X" in Slack and get a polished clip back the same day — produced
   mostly by AI agents. How would you architect this? What tools would you use
   for the video generation and editing pipeline?

---

## Screening Interview Questions (15 minutes)

### Opener (2 min)

"Tell me about the most complex agent system you've built. Not what you've
read about — what you've shipped."

**What you're listening for:** Specifics. Agent count, framework, what worked,
what broke. If they can't name the orchestration framework and describe a
failure mode, they haven't built one.

### Technical Deep Dive (5 min)

**Q1: Context Engineering**
"We have 9 agents. Each one wakes up fresh every task. How do you solve the
context problem — making sure Agent B knows what Agent A just did, without
rebuilding the entire context from scratch?"

**Good answer:** Mentions shared state files, structured memory (not just
"vector databases"), session summaries, context compression, or specific
tools like ClickMem. Understands the trade-off between context size and cost.

**Red flag:** Says "just use RAG" or "vector database" without specifics.
That's 2024 thinking.

**Q2: Harness Engineering**
"What's your approach to writing a SOUL.md or system prompt for an agent that
needs to behave like a real team member in Slack? How do you prevent the agent
from sounding like an AI?"

**Good answer:** Talks about personality constraints, anti-patterns to avoid
(bullet points, "I'm happy to help", overly formal language), few-shot examples
of the desired tone, testing with real humans, iterative tuning.

**Red flag:** Focuses only on the system prompt and ignores the communication
layer (Slack formatting, response patterns, threading behavior).

**Q3: Observability**
"We just set up LangFuse. What's the first dashboard you'd build, and what
metric would you alert on?"

**Good answer:** Cost per agent per day (budget overruns), error rate by agent
(quality degradation), and latency (UX for anything user-facing). Mentions
that you should alert on error rate spikes, not absolute cost.

**Red flag:** Doesn't know what LangFuse is, or only talks about logging to files.

### Strategic Thinking (5 min)

**Q4: The Brand Team Challenge**
"Our creative director Sean needs to produce 100+ pieces of content before
May 2. We want him to say 'I want a 15-second video about X' in Slack and
get a polished clip back the same day. Walk me through how you'd build this
pipeline — what's an agent, what's a human, what tools do you use for the
video editing, and where does Sean fit?"

**Good answer:** Breaks it into steps: (1) Sean posts brief in Slack, (2)
something triages the request type (video/image/copy), (3) video agent uses
specific tools (Remotion, Runway, Kling, or programmatic editing), (4) human
review gate before publishing. Mentions that screen recordings/product demos
likely need a human to film, but editing/assembly can be automated. Names
specific video generation tools, not just "AI video."

**Red flag:** Says "just use Sora" without discussing the editing pipeline,
format variants (9:16, 16:9, 1:1), or the human review step. Or proposes
a solution that takes weeks to build — we need output this week.

**Q5: The Vision Question**
"What does an agent-first org look like in 12 months? What changes between
now (9 agents) and then?"

**Good answer:** Talks about agent specialization deepening, agent-to-agent
communication reducing human bottleneck, persistent memory making agents
smarter over time, cost curves dropping, and the human role shifting from
"directing individual agents" to "designing the system." Mentions specific
tools or patterns they'd want to implement.

**Red flag:** Just says "more agents" or gives a generic AI hype answer
without specifics.

### Closer (3 min)

**Q6: Immediate Value**
"If I hire you today, what's the first thing you'd do in the first 48 hours?"

**Good answer:** Ask to see the current agent setup (Paperclip config,
SOUL.md files, LangFuse dashboard, Slack channel), audit what's working
and what's not, identify the highest-leverage improvement (usually
observability, memory, or prompt quality), and make one concrete change
that demonstrates value.

**Red flag:** Wants to "redesign the whole system" or "evaluate all the
frameworks" before doing anything.

---

## Scoring Rubric

| Criteria | Weight | 5 = Excellent | 1 = Pass |
|----------|--------|---------------|----------|
| Has built multi-agent system | 30% | Shows repos/screenshots of 5+ agent org | Talks about it convincingly but no proof |
| Context engineering depth | 20% | Describes specific memory/state patterns they've implemented | Knows the concept but hasn't solved it |
| Harness/prompt engineering | 20% | Can describe SOUL.md tuning process with iteration examples | Writes good prompts but hasn't tuned agent behavior |
| Strategic thinking | 15% | Knows when NOT to use agents; understands human-AI balance | Defaults to "automate everything" |
| Communication clarity | 15% | Explains complex concepts in 2 sentences | Needs 5 minutes to make a point |

**Hire if:** Average score >= 3.5 AND "has built multi-agent system" >= 4

**Don't hire if:** Can't name a specific agent framework they've used, or
gives only theoretical answers.

---

## Budget Analysis

| Rate | What You Get | Risk |
|------|-------------|------|
| $20-30/hr | International talent, possibly strong technically but may not have agent org experience. Good for execution, needs strategic direction from Jake. | May say the right words in interview but struggle with novel problems. |
| $35-45/hr | Strong international or junior US talent with real agent experience. Can execute independently and suggest improvements. Sweet spot for "great Upwork hire." | Still need to screen hard — lots of prompt engineers at this rate, fewer true harness engineers. |
| $45-60/hr | Experienced US/EU talent who has shipped agent systems in production. Can think strategically AND execute. Likely has a portfolio to show. | Smaller candidate pool. May have competing offers. |
| $60-80/hr | Top-tier. Has built agent orgs for funded startups. Can write the strategy doc AND implement it. This is your "10x agent engineer." | Expensive. At 20 hrs/week = $4,800-6,400/month. But if they save you 10+ hours/week of agent management... |

**Posted rate:** $20-35/hr. Cast wide, test everyone. At full-time week 1 that's
$3,200-5,600 for the sprint. If someone exceptional shows up at $35, worth it.

---

## Interview Logistics

- **Format:** 15-minute video call (Zoom, no password, no waiting room)
- **Structure:** 2 min opener + 5 min technical + 5 min strategic + 3 min closer
- **Jake's prep:** Have the Paperclip dashboard open (127.0.0.1:3100), the
  LangFuse dashboard open, and the #tryps-agents Slack channel visible. Show
  them the real system and gauge their reaction.
- **Best signal:** When they see the org chart / Slack channel, do they light up
  with specific ideas, or do they nod politely?
