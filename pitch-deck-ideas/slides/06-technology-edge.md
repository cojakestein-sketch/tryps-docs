# Technology Edge: Autoresearch

### A 5-person team shipping with the velocity of a 20-person team

We don't just use AI to write code. **We use AI to optimize our AI.**

The autoresearch pattern (Karpathy, 2025):
1. Define a **metric** you can measure automatically
2. Give an agent permission to **modify one thing** (a prompt, a recommendation, a matching algorithm)
3. Let it **run experiments overnight** — hundreds of variants, tested and scored

We wake up to a changelog of research. The best-performing variant ships.

<!-- Speaker notes:
Reference Karpathy's autoresearch framework. The insight isn't the ML — it's the pattern. Anywhere you have a thing you can modify, a metric you can measure, and a loop that takes minutes, you can run this overnight.

Example: Prompt optimization for our agent. Today we write prompts manually. With autoresearch, we define 20 real user scenarios (the "Jennifer Test"), let the agent rewrite the system prompt, score against expected outputs, keep or discard. 100 variants overnight. Wake up to the best prompt with evidence.

This is how a small team builds a defensible, continuously-improving product.
-->
