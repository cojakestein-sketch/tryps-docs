---
title: "Autonomous R&D Council: Multi-AI Business Advisory System"
type: feat
date: 2026-03-22
---

# Autonomous R&D Council

## Overview

5 AI "council members" meet twice daily (9am and 5pm ET) on Hetzner, autonomously review Tryps business state, debate ideas, and deliver an actionable memo to Jake via Slack. Each member has a distinct role and perspective. One rotates as proposer, all five debate, and a coordinator synthesizes the output into a structured memo tied to real scopes and priorities.

This is Jake's autonomous R&D department.

---

## Problem Statement

Jake is a solo founder managing product, strategy, brand, hiring, and investor prep across 13 MECE capability areas with a hard April 2 deadline. There's no bandwidth for the kind of strategic thinking that happens in an executive team meeting — stepping back, challenging assumptions, connecting dots across domains.

AI can do this. Not one model — a council of five, each with a distinct lens, forced to debate rather than agree.

---

## Architecture

### System Diagram

```
┌─────────────────────────────────────────────────────┐
│                  Hetzner (178.156.176.44)            │
│                                                      │
│  ┌──────────┐    ┌───────────────────────────────┐  │
│  │  Cron     │───▶│  council/orchestrator.py       │  │
│  │ 9am/5pm  │    │                               │  │
│  └──────────┘    │  1. Assemble briefing          │  │
│                  │  2. Pick rotating proposer      │  │
│                  │  3. Run debate (3 rounds)       │  │
│                  │  4. Synthesize memo             │  │
│                  │  5. Deliver (Slack + file)      │  │
│                  └───────────┬───────────────────┘  │
│                              │                       │
│              ┌───────────────┼───────────────┐      │
│              ▼               ▼               ▼      │
│         ┌────────┐    ┌────────┐      ┌────────┐   │
│         │Claude  │    │GPT-4o  │ ...  │Gemini  │   │
│         │(API)   │    │(API)   │      │(API)   │   │
│         └────────┘    └────────┘      └────────┘   │
│                              │                       │
│                              ▼                       │
│                  ┌───────────────────┐               │
│                  │ council/memos/    │               │
│                  │ YYYY-MM-DD-am.md  │               │
│                  └─────────┬─────────┘               │
│                            │                         │
└────────────────────────────┼─────────────────────────┘
                             │
                ┌────────────┼────────────┐
                ▼            ▼            ▼
           ┌────────┐  ┌────────┐  ┌──────────┐
           │ Slack   │  │tryps-  │  │ Kindle   │
           │ #council│  │docs git│  │ (opt)    │
           └────────┘  └────────┘  └──────────┘
```

### Where It Lives

```
/home/openclaw/council/
├── orchestrator.py          # Main script — cron calls this
├── config.yaml              # Meeting times, model config, roles
├── briefing/
│   ├── assemble.py          # Pulls state from ClickUp, GitHub, tryps-docs
│   └── templates/
│       └── briefing.md.j2   # Jinja template for briefing doc
├── members/
│   ├── growth.md            # System prompt: Growth Strategist
│   ├── product.md           # System prompt: Product Lead
│   ├── engineering.md       # System prompt: Technical Architect
│   ├── design.md            # System prompt: Design Thinker
│   └── strategy.md          # System prompt: Strategy Advisor
├── debate/
│   ├── protocol.py          # Manages 3-round debate flow
│   └── anti_groupthink.py   # Dissent injection, devil's advocate rotation
├── output/
│   ├── synthesizer.py       # Debate → structured memo
│   ├── deliver.py           # Slack + git + optional Kindle
│   └── templates/
│       └── memo.md.j2       # Jinja template for final memo
├── state/
│   ├── rotation.json        # Tracks who proposed last, adoption rates
│   ├── cost_log.json        # API costs per meeting
│   └── feedback.json        # Jake's thumbs up/down on past recommendations
├── memos/                   # Output archive
│   └── 2026-03-22-am.md
└── requirements.txt         # Python deps
```

---

## Council Members

| # | Role | Lens | Model (Phase 1) | Model (Phase 2) |
|---|------|------|-----------------|-----------------|
| 1 | **Growth Strategist** | Acquisition, virality, market positioning, competitive landscape | Claude Sonnet | GPT-4o |
| 2 | **Product Lead** | Feature prioritization, UX, user value, scope trade-offs | Claude Sonnet | Claude Opus |
| 3 | **Technical Architect** | Engineering feasibility, tech debt, performance, architecture | Claude Sonnet | Gemini 2.5 Pro |
| 4 | **Design Thinker** | Brand coherence, aesthetics, user experience, emotional design | Claude Sonnet | Claude Sonnet |
| 5 | **Strategy Advisor** | Business model, fundraising narrative, long-term positioning | Claude Sonnet | GPT-4o |

### Persona Design Principles

Each member's system prompt includes:

1. **Identity** — Name, role, what they care about most
2. **Perspective bias** — What they're optimizing for (growth optimizes for users, engineering optimizes for reliability, etc.)
3. **Disagreement mandate** — "You MUST identify at least one risk or flaw in every proposal. Agreement without critique is failure."
4. **Tryps context** — Core thesis, current stage, team constraints, April 2 deadline
5. **Anti-fluff rule** — "Every recommendation must name a specific scope, feature, or action. No generic advice."

---

## Meeting Protocol

### Briefing Assembly (Step 0)

Before any debate, `assemble.py` pulls:

| Source | What | How |
|--------|------|-----|
| ClickUp | Task status, blockers, overdue items | `curl` ClickUp API (workspace 9017984360) |
| GitHub | Recent PRs, commits, CI status | `gh` CLI |
| tryps-docs | `shared/state.md`, `priorities.md`, `decisions.md`, `observations.md` | `git pull` + file read |
| Cost log | Running API spend for the week | Local JSON read |
| Previous memo | Last session's action items + adoption status | Local file read |
| Feedback | Jake's ratings on past recommendations | `state/feedback.json` |

Output: A single `briefing.md` document (~2-3K tokens) that every council member reads as context.

### Debate Flow (Steps 1-3)

```
Round 1: PROPOSE
  └─ Rotating member reads briefing + gets "propose one new idea or initiative" prompt
  └─ Output: 300-500 word proposal with rationale

Round 2: RESPOND
  └─ Other 4 members each read briefing + proposal
  └─ Each responds: support/challenge/refine (200-400 words each)
  └─ Parallel API calls — no dependency between responses
  └─ Each MUST include at least one critique or risk

Round 3: CROSS-RESPOND
  └─ All 5 read everything so far
  └─ Each gives final position: endorse / endorse-with-caveats / oppose
  └─ 100-200 words each, focused on action items
  └─ Parallel API calls

Synthesis:
  └─ Coordinator (orchestrator.py) assembles all outputs
  └─ Extracts: consensus points, dissenting views, action items
  └─ Generates structured memo from template
```

### Rotation Schedule

- Proposer rotates through all 5 members in order
- Tracked in `state/rotation.json`
- Each member proposes roughly once every 2.5 days (5 members ÷ 2 meetings/day)

### Anti-Groupthink Mechanisms

1. **Mandatory critique** — Every response must include at least one risk/flaw
2. **Devil's advocate rotation** — One member per meeting is assigned to argue against the proposal regardless of their actual opinion
3. **Dissent bonus** — Memo highlights dissenting views prominently (not buried)
4. **Temperature variation** — Proposer runs at temp 0.9 (creative), responders at 0.5 (analytical)
5. **Previous feedback** — If Jake thumbs-downed a topic, it's flagged: "Jake previously rejected this direction — propose something different unless you have new evidence"

---

## Memo Format

```markdown
# R&D Council Memo — Mar 22, 2026 (AM)

## TL;DR
[2-3 sentences: what was proposed, what the council thinks, top action]

## Business State Snapshot
- **Scopes:** X done / Y in-progress / Z blocked (of 13)
- **Deadline:** N days to April 2
- **Blockers:** [any from ClickUp]
- **Recent wins:** [from GitHub/observations]

## Today's Proposal
**Proposer:** [Role Name]
**Title:** [Proposal title]
[Proposal summary — 3-4 sentences]

## Council Debate

### Support
- [Member]: [Key supporting argument]

### Challenges
- [Member]: [Key critique or risk]

### Refinements
- [Member]: [Suggested modification]

## Final Positions
| Member | Position | Key Reason |
|--------|----------|------------|
| Growth | Endorse with caveats | [reason] |
| Product | Endorse | [reason] |
| Engineering | Oppose | [reason] |
| Design | Endorse with caveats | [reason] |
| Strategy | Endorse | [reason] |

## Action Items
- [ ] **[P1]** [Action] — Owner: [suggested assignee] — Scope: [scope-id]
- [ ] **[P2]** [Action] — Owner: [suggested assignee]
- [ ] **[P3]** [Action] — Owner: [suggested assignee]

## Dissenting View
[The strongest counter-argument from the debate, given prominence]

## Cost
- This session: $X.XX (N API calls across M models)
- Weekly running total: $Y.YY
```

---

## Delivery

1. **Slack** — Full memo posted to `#council` channel (new channel). TL;DR + action items also posted to `#martydev`.
2. **tryps-docs** — Memo saved to `tryps-docs/docs/council/YYYY-MM-DD-{am|pm}.md` and committed/pushed.
3. **Kindle (optional)** — PDF via existing `md-to-pdf` + `send-to-kindle.py` pipeline. Morning memo arrives on Kindle for coffee reading.

### Feedback Loop

Jake reacts to the Slack post:
- 👍 = useful, keep exploring this direction
- 👎 = not useful, stop suggesting this
- 🔥 = exceptionally useful, prioritize implementation
- 💤 = stale/repetitive, need fresh thinking

Reactions are scraped by the next meeting's briefing assembly and stored in `state/feedback.json`. The council adapts.

---

## Implementation Phases

### Phase 1: Single-Model MVP (1-2 days)

**Goal:** Validate the concept. All 5 council members use Claude Sonnet via Anthropic API. The debate is simulated through sequential API calls with different system prompts.

**Build:**
- [ ] `council/` directory on Hetzner
- [ ] `orchestrator.py` — main script, sequential execution
- [ ] 5 system prompt files (`members/*.md`)
- [ ] `briefing/assemble.py` — pulls ClickUp + GitHub + tryps-docs state
- [ ] `output/synthesizer.py` — debate outputs → memo
- [ ] `output/deliver.py` — post to Slack via bot token
- [ ] `config.yaml` — meeting times, API keys, model config
- [ ] Cron entries: `0 13 * * *` and `0 22 * * *` (9am/5pm ET = 1pm/10pm UTC)
- [ ] `state/rotation.json` — proposer rotation tracking

**Dependencies:**
- Anthropic API key on Hetzner (already exists for Marty)
- Slack bot token (already exists — reuse Marty's)
- `#council` Slack channel (create)
- Python 3.10+ on Hetzner (verify)
- `pip install anthropic requests pyyaml jinja2`

**Acceptance criteria:**
- [ ] Cron fires at 9am and 5pm ET
- [ ] Briefing includes real ClickUp + GitHub + tryps-docs state
- [ ] 5 distinct council responses generated (not copy-paste sameness)
- [ ] Memo posted to `#council` Slack channel
- [ ] Memo saved to tryps-docs and committed
- [ ] Rotation tracked — different proposer each meeting
- [ ] Total meeting duration < 5 minutes
- [ ] Cost per meeting < $1.00

### Phase 2: Multi-Model Diversity (Week 2)

**Goal:** Different models genuinely think differently. Replace some Claude instances with GPT-4o, Gemini, etc.

**Build:**
- [ ] Add OpenAI API key to Hetzner env vars
- [ ] Add Google AI API key to Hetzner env vars
- [ ] Abstract model calls behind a `ModelClient` interface in orchestrator
- [ ] Assign models to roles per the table above
- [ ] Parallel API calls for Round 2 and Round 3 (asyncio)
- [ ] Cost tracking per model provider in `state/cost_log.json`
- [ ] Graceful degradation: if one API is down, substitute Claude for that member and note in memo

**Acceptance criteria:**
- [ ] At least 3 different model providers used per meeting
- [ ] Debate quality noticeably improves (Jake's subjective assessment)
- [ ] API failure for one model doesn't kill the meeting
- [ ] Cost per meeting tracked and logged

### Phase 3: Local Models + Always-On (Week 3+)

**Goal:** Run council for free using local models on Hetzner. Meetings can happen more frequently.

**Build:**
- [ ] Install Ollama on Hetzner
- [ ] Pull models: `llama3.1:70b`, `mistral-large`, `qwen2.5:72b`, `deepseek-r1:70b`
- [ ] Benchmark: can Hetzner VPS handle 70B inference? (may need GPU upgrade or smaller models)
- [ ] Update `config.yaml` to route some/all members to local models
- [ ] Increase meeting frequency (4x/day or continuous)
- [ ] Add web search capability for competitor monitoring (Brave API — already on Hetzner)

**Acceptance criteria:**
- [ ] At least 3 members running on local models
- [ ] Cost per meeting < $0.10 (mostly free)
- [ ] Meeting quality acceptable (Jake's assessment)
- [ ] Can run 4+ meetings/day without cost concern

---

## Edge Cases & Error Handling

| Scenario | Handling |
|----------|----------|
| API rate limit hit | Retry with exponential backoff (3 attempts, 30s/60s/120s). If still failing, substitute Claude for that member. |
| Model API down entirely | Substitute Claude (always-available fallback). Note substitution in memo. |
| ClickUp API down | Use cached state from last successful pull. Note staleness in briefing. |
| GitHub API down | Skip GitHub section of briefing. Note in memo. |
| Git conflict on tryps-docs push | `git pull --rebase` then retry. If still conflicting, save memo locally and alert in Slack. |
| Slack down | Save memo to file, send via email (Resend API). Retry Slack on next meeting. |
| Cron missed (server reboot) | Log to `state/missed_meetings.log`. Next meeting runs normally — no makeup sessions. |
| Repetitive proposals | Track last 10 proposals in `state/rotation.json`. Proposer prompt includes: "Do NOT re-propose these recent topics: [list]" |
| Cost spike | Alert in Slack if single meeting > $5 or weekly total > $50. Auto-pause meetings if weekly > $100. |
| All recommendations thumbs-downed | Switch to "blue sky" mode — proposer ignores current scopes and explores adjacent opportunities |

---

## Cost Estimates

### Phase 1 (Claude Sonnet only)

| Step | Tokens (est.) | Cost |
|------|---------------|------|
| Briefing assembly | — | $0.00 (API calls, not LLM) |
| Proposer (1 call) | ~2K in / ~500 out | $0.01 |
| Responders (4 calls) | ~3K in / ~400 out each | $0.04 |
| Cross-response (5 calls) | ~5K in / ~200 out each | $0.05 |
| Synthesis | ~4K in / ~800 out | $0.02 |
| **Total per meeting** | | **~$0.12** |
| **Daily (2 meetings)** | | **~$0.24** |
| **Monthly** | | **~$7.20** |

### Phase 2 (Multi-model)

Varies by model mix. Estimate $0.30-0.80 per meeting, $18-48/month.

### Phase 3 (Local)

Near-zero marginal cost. Electricity only.

---

## Configuration

```yaml
# config.yaml
council:
  name: "Tryps R&D Council"
  meetings:
    - cron: "0 13 * * *"  # 9am ET (UTC-4)
    - cron: "0 22 * * *"  # 5pm ET (UTC-4)

  members:
    - id: growth
      name: "Growth Strategist"
      model: "claude-sonnet-4-6"
      provider: "anthropic"
      prompt_file: "members/growth.md"
      temperature: 0.6
    - id: product
      name: "Product Lead"
      model: "claude-sonnet-4-6"
      provider: "anthropic"
      prompt_file: "members/product.md"
      temperature: 0.5
    - id: engineering
      name: "Technical Architect"
      model: "claude-sonnet-4-6"
      provider: "anthropic"
      prompt_file: "members/engineering.md"
      temperature: 0.4
    - id: design
      name: "Design Thinker"
      model: "claude-sonnet-4-6"
      provider: "anthropic"
      prompt_file: "members/design.md"
      temperature: 0.6
    - id: strategy
      name: "Strategy Advisor"
      model: "claude-sonnet-4-6"
      provider: "anthropic"
      prompt_file: "members/strategy.md"
      temperature: 0.5

  debate:
    rounds: 3
    proposer_temperature: 0.9
    max_proposal_tokens: 600
    max_response_tokens: 500
    max_cross_response_tokens: 300
    anti_groupthink:
      mandatory_critique: true
      devils_advocate: true
      dissent_prominence: "high"

  delivery:
    slack_channel: "#council"
    slack_summary_channel: "#martydev"
    save_to_git: true
    git_repo: "tryps-docs"
    git_path: "docs/council/"
    kindle: false  # Enable after validation

  cost:
    alert_per_meeting: 5.00
    alert_weekly: 50.00
    pause_weekly: 100.00

  briefing:
    sources:
      - type: clickup
        workspace_id: "9017984360"
        lists: ["901711582339", "901711582341"]
      - type: github
        repo: "t4"
        lookback_hours: 12
      - type: tryps_docs
        files:
          - "shared/state.md"
          - "shared/priorities.md"
          - "shared/decisions.md"
          - "shared/observations.md"
      - type: previous_memo
        lookback: 1
      - type: feedback
        file: "state/feedback.json"
```

---

## Key Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Orchestrator language | Python | Multi-provider API calls, async support, Jinja templates, JSON parsing — bash can't do this cleanly |
| Phase 1 single-model | Claude Sonnet | Already have API key on Hetzner, cheapest capable model, validates concept before adding complexity |
| Sequential not parallel (Phase 1) | Sequential | Simpler, debuggable, no asyncio needed. Parallel in Phase 2. |
| Debate rounds = 3 | 3 (propose → respond → cross-respond) | Enough depth for real debate without running up costs. The tweet author likely does similar. |
| Memo in Slack not email | Slack first | Jake lives in Slack. Email is secondary. Kindle is luxury. |
| Feedback via emoji reactions | Slack reactions | Zero-friction for Jake. No separate UI needed. |
| Proposer rotation not random | Strict rotation | Ensures every perspective gets to set the agenda equally |
| Host on Hetzner not locally | Hetzner | Already runs 24/7, has cron, has API keys, has Slack token. Jake's laptop sleeps. |

---

## What This Is NOT

- **Not a replacement for Jake's judgment.** The council proposes — Jake decides.
- **Not a coding agent.** The council doesn't write code. It thinks about the business.
- **Not a competitor to Marty.** Marty does operational work (PR review, state sync, triage). The council does strategic thinking. They're complementary.
- **Not expensive.** Phase 1 costs ~$7/month. Phase 3 is near-free.

---

## Success Metrics

| Metric | Target | How Measured |
|--------|--------|-------------|
| Meeting completion rate | >95% | Cron logs |
| Memo delivery within 5 min | >90% | Timestamp diff (cron fire → Slack post) |
| Jake reads memo | >80% of memos | Slack "seen" or reaction rate |
| Actionable recommendations | >2 per memo | Count of action items that reference real scopes |
| Recommendations adopted | >1 per week | Jake's 🔥 reactions tracked in feedback.json |
| Cost per month (Phase 1) | <$15 | cost_log.json |
| Distinct perspectives | Qualitative | Jake's subjective: "are they actually disagreeing?" |

---

## Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|-----------|
| Council produces generic/useless advice | Medium | High | Strong persona prompts, real data in briefing, feedback loop, anti-fluff rules |
| Groupthink (models agree on everything) | High | Medium | Mandatory critique, devil's advocate, temperature variation, multi-model in Phase 2 |
| Jake ignores memos | Medium | High | Keep memos short (TL;DR first), Slack delivery, track engagement, adapt based on feedback |
| API costs escalate | Low | Low | Cost tracking, alerts, auto-pause, Phase 3 local models |
| Hetzner VPS can't handle local models | Medium | Medium | Benchmark first, use smaller models (7B-13B), or add GPU |
| Stale data in briefing | Low | Medium | Pull fresh state every meeting, note staleness when APIs fail |
| Memo format gets stale/boring | Medium | Low | Rotate memo styles quarterly, add "wild card" section |

---

## Future Extensions

- **Async council** — Members can "respond" to Jake's Slack messages with their perspective on-demand (not just scheduled)
- **Meeting minutes history** — Searchable archive of all council memos for pattern recognition
- **Council self-improvement** — Track which recommendations led to measurable outcomes, feed back into prompts
- **Guest members** — Temporarily add a "Legal Advisor" or "Investor Lens" member for specific meetings
- **Voice memos** — Generate audio summary via TTS for commute listening
- **Jake can attend** — Slash command to inject Jake's response into the debate before Round 3

---

## Implementation Kickoff Prompt

Copy-paste this into a Claude Code session on Hetzner to start Phase 1:

```
SSH into Hetzner (178.156.176.44 as openclaw). Build the R&D Council system.

Plan: ~/tryps-docs/docs/plans/2026-03-22-feat-rd-council-autonomous-meetings-plan.md

Phase 1 only — single model (Claude Sonnet), sequential execution.

1. Create /home/openclaw/council/ with the directory structure from the plan
2. Write orchestrator.py — main script that runs the full meeting flow
3. Write 5 system prompts (members/*.md) with Tryps-specific context
4. Write briefing/assemble.py — pulls from ClickUp API, GitHub, tryps-docs
5. Write output/synthesizer.py — debate → memo using Jinja template
6. Write output/deliver.py — posts to Slack #council channel
7. Write config.yaml with real API keys from env vars (never hardcode)
8. Add cron entries: 0 13 * * * and 0 22 * * * (9am/5pm ET)
9. Test with a dry run: python orchestrator.py --dry-run
10. Verify memo appears in Slack

Use ANTHROPIC_API_KEY and SLACK_BOT_TOKEN from environment.
ClickUp API key is in $CLICKUP_API_KEY.
Cron timeout must be >= 300s.
```
