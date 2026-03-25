---
id: autoresearch-prompt-optimization
title: "Autoresearch: Prompt Optimization"
status: draft
owner: jake
assignee: unassigned
created: 2026-03-25
last_updated: 2026-03-25
type: experiment
depends_on: [agent-intelligence, imessage-agent]
---

# Autoresearch: Prompt Optimization — Spec

## What

An autonomous prompt optimization loop for the Tryps agent system prompt — the prompt that powers the AI people text with. Based on Karpathy's autoresearch pattern: the agent rewrites the system prompt, scores the result against test scenarios, keeps or discards, and repeats overnight. You wake up to a better prompt and a log of everything tried.

**Important:** This does NOT go through any Linq/agent API. We extract the raw system prompt file, call Claude directly with it + test user messages, and score the responses. No Linq infrastructure needed.

## Why

The agent system prompt is the single highest-leverage artifact in Tryps. Every user interaction flows through it. Today, prompt tuning is manual — someone rewrites it, tests it by feel, ships it. This replaces gut-feel iteration with measurable, autonomous experimentation. 100 variants tested overnight vs. 3 tested by hand in a week.

## Intent

> "Like waking up to a smarter employee. The log shows WHY it got better. It's a science experiment with clear results — clean data, clear wins and losses, reproducible. You can explain what changed. It should feel like a cheat code for how much ground it covers overnight. It would feel wrong if results are noisy and you can't tell if it actually helped."
>
> "V1 is fully autonomous — no human in the loop. Human eval layers in later. Nothing is sacred in V1 — full rewrites OK. Start with the exercise, then lock down what matters."

## Key Concepts

**Single-file modification:** The agent only modifies the system prompt file. Everything else — the eval harness, test scenarios, scoring rubric — is read-only. This keeps diffs reviewable and experiments comparable.

**Fixed eval budget:** Every experiment runs the same set of test scenarios. The metric is a composite score (rubric + pass/fail gates). Lower is NOT better here — higher score = better prompt.

**Keep/discard loop:** If the new prompt scores higher, keep it (advance the git branch). If equal or worse, discard (git reset). The branch accumulates only improvements.

**Two-layer scoring:**
- **Hard gates (pass/fail):** Golden scenarios with binary expected behaviors. Fail any gate = automatic discard.
- **Rubric score (0-100):** LLM-as-judge scores each response on multiple dimensions. This is the optimization metric.

**Human eval is V2:** V1 runs fully autonomous. Future iterations add human scoring — devs, QA, or real "Aunt Jenny" users rate responses. The infrastructure should make this easy to add.

## Pre-Requisites (Need from Asif/Rizwan)

Before this experiment can run, we need:

- [ ] **Prompt file location:** Exact file path of the Tryps agent system prompt in t4. Is it a single string, a template with variables, or multi-part?
- [ ] **Prompt architecture overview:** How is the prompt assembled? Are there dynamic sections (user context, trip details) injected at runtime? We need to know what's static (optimizable) vs. dynamic (fixed).
- [ ] **Current test scenarios (if any):** Does any existing test coverage exercise agent responses? Test scripts, manual QA flows, anything.
- [ ] **API access pattern:** We won't go through the Linq API. We just need the raw system prompt so we can call Claude directly. But: are there dynamic sections injected at runtime (user context, trip details)? If so, we need example values to mock them.

## Success Criteria

### Core Behavior

- [ ] Running `uv run optimize.py` from the autoresearch directory starts the autonomous loop with no manual intervention. Verified by: fresh clone of the repo → `uv sync` → `uv run prepare_scenarios.py` → `uv run optimize.py` → loop starts, first baseline is recorded.
- [ ] Each experiment modifies only the system prompt file and commits it before running. Verified by: after 5+ experiments, `git log --stat` shows only the prompt file changed per commit.
- [ ] Each experiment runs the full test scenario suite and produces a composite score. Verified by: `results.tsv` has a score column with non-zero values for every non-crash experiment.
- [ ] Improvements are kept (branch advances), regressions are discarded (branch resets). Verified by: after 10+ experiments, `git log` shows only commits where score >= previous best. `results.tsv` shows both kept and discarded entries.
- [ ] The experiment log (`results.tsv`) records: commit hash, composite score, pass/fail gate results, status (keep/discard/crash), and a description of what the agent changed. Verified by: open `results.tsv` after a run — all 5 columns populated for every row.
- [ ] Any team member can run the loop on their machine. Verified by: Asif or Rizwan clones the repo, runs setup, kicks off the loop, gets results.

### Hard Gate Scenarios (Minimum Set — Expand with Team)

- [ ] The prompt produces a response that asks about dates/destination before planning. Verified by: test scenario "plan me a trip" with no context → response must contain a question about when or where.
- [ ] The prompt does not suggest chain restaurants or generic tourist traps when asked for food recommendations. Verified by: test scenario "where should we eat in Austin?" → response must not contain "Applebee's", "Chili's", "TGI Friday's" or similar.
- [ ] The prompt handles a group of 6+ people without ignoring the group dynamic. Verified by: test scenario "plan a weekend for 8 friends in Miami" → response references the group (preferences, splitting up, group activities), not just solo suggestions.
- [ ] The prompt responds in Tryps brand voice — warm, cheeky, not corporate. Verified by: LLM-judge rates tone on brand alignment scale. Score must be >= 7/10.

### Edge Cases & Error States

- [ ] If the agent produces a prompt that causes the LLM to refuse or return an empty response, the experiment is logged as a crash and discarded. Verified by: inject a deliberately broken prompt → status is "crash" in results.tsv, branch resets.
- [ ] If a prompt variant passes hard gates but scores lower on the rubric, it is discarded. Verified by: results.tsv shows "discard" status for entries where gates passed but score decreased.
- [ ] If the eval harness itself errors (API timeout, rate limit), the experiment is retried once before being logged as a crash. Verified by: simulate a timeout → agent retries → if second attempt fails, logged as crash.

### Should NOT Happen

- [ ] The agent must not modify any file other than the system prompt file. No changes to the eval harness, test scenarios, or scoring rubric.
- [ ] The agent must not produce a prompt that leaks internal instructions, system context, or Tryps infrastructure details to the user.
- [ ] The experiment loop must not stop to ask the human for confirmation. Once started, it runs until interrupted.
- [ ] The agent must not optimize for score by gaming the rubric (e.g., producing responses that score high on the judge prompt but are unusable). The rubric must be robust enough to prevent this.

### Out of Scope

- Human-in-the-loop scoring — V2. Infrastructure should make it easy to add.
- Optimizing dynamic prompt sections (user context injection, trip details) — only the static system prompt.
- Deploying the winning prompt to production — this produces a candidate. Shipping it is a separate decision.
- Multi-agent setups (multiple optimizers running in parallel) — V2.
- Optimizing for specific LLM providers — V1 targets whatever model the agent currently uses.

## Architecture

```
autoresearch/
├── program.md              # Agent instructions (the "skill")
├── prompt.txt              # The system prompt being optimized (agent modifies this)
├── optimize.py             # The experiment loop (fixed, agent does not modify)
├── scenarios/
│   ├── golden.json         # Hard gate test scenarios with expected behaviors
│   └── rubric.json         # Scoring rubric for LLM-as-judge
├── eval.py                 # Evaluation harness — runs scenarios, scores responses
├── results.tsv             # Experiment log (untracked by git)
└── README.md               # Setup and usage docs for the team
```

## Open Questions

1. **How is the system prompt structured?** Single file or multi-part? Template variables? Need Asif/Rizwan input.
2. **What model does the agent use?** We need to call the same model for evaluation.
3. **What does a "good" agent response look like?** We need 10-20 golden examples to bootstrap the test suite. Jake + Asif to define.
4. **Cost per experiment?** Each experiment makes N LLM calls (test scenarios × judge calls). At 20 scenarios, ~40 API calls per experiment × 100 experiments = ~4,000 calls overnight. Estimate cost.
5. **Should we snapshot the winning prompt into the t4 codebase automatically, or keep it as a manual deploy step?** Leaning manual for V1.

## Kickoff Prompt

Once pre-requisites are resolved, paste this into Claude Code from the `autoresearch/` directory:

```
Hi, read program.md and let's set up a new prompt optimization experiment. Today's tag is [DATE]. The agent system prompt is at [PATH]. Let's establish the baseline and start the loop.
```
