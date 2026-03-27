# Autoresearch: How Tryps Uses Cutting-Edge AI Optimization

> Pitch deck idea — technology edge / how we build

---

## The One-Liner

Autoresearch is Karpathy's framework for letting an AI agent run experiments autonomously while you sleep. It modifies code, tests if the change helped, keeps winners, discards losers, and repeats — hundreds of times overnight.

## How It Actually Works

The system has three pieces:

1. **The code** (train.py) — the thing being optimized. Right now it's a small language model.
2. **The instructions** (program.md) — a markdown file that tells the AI agent what to try, what to measure, and what counts as success. This is the only thing the human writes.
3. **The loop** — the agent reads the instructions, makes a change, runs the experiment (~5 min), checks the metric, keeps or reverts, commits, repeats. Forever. No human in the loop.

The key insight isn't the ML part — it's the pattern: you define a metric, give an agent permission to modify one file, and let it hill-climb autonomously. The agent does hundreds of experiments overnight that would take a human researcher weeks.

> Karpathy's framing: "You're not programming Python anymore. You're programming the markdown file that programs the AI agent."

## What It Produces

A git branch full of atomic commits — each one a self-contained experiment with a result. Plus a results.tsv log showing every experiment tried, whether it worked, and why. You wake up to a changelog of research.

---

## What This Means for Tryps

The raw repo optimizes a language model — not directly useful to us. But the pattern is extremely applicable. Anywhere you have:

- A thing you can modify
- A metric you can measure automatically
- A loop that takes minutes, not hours

...you can run this pattern overnight.

## How Tryps Uses This

### 1. Prompt Optimization for Linq / Claude Connector

Linq already has system prompts that drive how it responds to trip planning queries. Today, prompt tuning is manual — someone writes a prompt, tests it, tweaks it. With the autoresearch pattern: define a test suite of 20 real user scenarios (the "Jennifer Test"), let the agent rewrite the system prompt, score it against expected outputs, keep or discard. Run 100 prompt variants overnight. Wake up to the best-performing system prompt with evidence.

**Result:** _To be added pending the running code._

---

## The Investor Pitch

A 5-person team shipping with the velocity of a 20-person team — because we don't just use AI to write code, we use AI to optimize our AI. The autoresearch pattern lets us run hundreds of experiments overnight on our core product intelligence (prompts, recommendations, matching) while the team sleeps. This is how a small team builds a defensible, continuously-improving product.
