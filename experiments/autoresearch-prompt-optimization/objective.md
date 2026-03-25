---
id: autoresearch-prompt-optimization
title: "Autoresearch: Prompt Optimization"
type: experiment
owner: jake
created: 2026-03-25
last_updated: 2026-03-25
---

## What

Autonomous overnight prompt optimization for the Tryps agent system prompt — the prompt that powers the AI people text with. Based on Karpathy's autoresearch pattern — an AI agent rewrites the prompt, scores it against test scenarios, keeps winners, discards losers, and repeats hundreds of times while you sleep.

## Why

The system prompt is the single highest-leverage artifact in Tryps. Every user interaction flows through it. Manual prompt tuning is slow (3 variants/week) and subjective. This makes it measurable and fast (100 variants/night). The pattern is general — once it works for the system prompt, it works for notification copy, onboarding flows, anything with a scoreable output.

## Success Looks Like

- You kick off the loop before bed, wake up to a measurably better system prompt with a log of every experiment tried
- The winning prompt handles the Jennifer Test scenarios better than the current one
- The experiment log is clean enough that you can explain to the team exactly what changed and why
- Any dev on the team can run the loop independently
- The pattern is reusable for future optimization targets (notification copy, ranking weights, etc.)

## Blockers

- Need Asif/Rizwan to identify the agent system prompt file in t4 and explain how it's structured (we call Claude directly with it — no Linq API needed)
- Need 10-20 golden test scenarios defined (Jake + team)
- If the prompt has dynamic sections (user context, trip details injected at runtime), need example values to mock

## Next Steps

1. Share spec with Asif and Rizwan for prompt architecture input
2. Define golden test scenarios (Jennifer Test formalized)
3. Build the eval harness and scoring rubric
4. Run first autonomous experiment
