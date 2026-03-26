---
title: "Autoresearch: Prompt Optimization Findings"
date: 2026-03-26
status: in-progress
owner: jake
for: rizwan
baseline_score: 85.7
current_best: 87.5
experiments_run: 6
---

# Prompt Optimization Findings

## Summary

We ran Karpathy's autoresearch pattern against the Tryps agent system prompt. An AI agent made targeted modifications to the prompt, tested each change against 16 scenarios using GPT-5.4, scored the responses with an LLM judge, and kept improvements.

**Baseline: 85.7/100 → Current best: 87.5/100** after 6 experiments (3 kept, 3 discarded).

The prompt is already strong. The wins are about concrete examples over abstract rules. GPT-5.4 follows "got it, $45, split 4 ways" better than "be concise."

## What We're Scoring

Each scenario is scored 0-100 across 5 dimensions:
- **Routing correctness (25%):** Did it respond when it should, stay silent when it should?
- **Brand voice (25%):** Does it sound like a real person texting? The Jennifer Test.
- **Helpfulness (20%):** Did it actually help? Right tool, right answer?
- **Conciseness (15%):** Appropriately brief for a text message?
- **Formatting (15%):** Lowercase, no emojis, no em dashes, message length.

Plus hard gates (pass/fail): must call the right tool, must not use banned words, must stay lowercase.

## Changes That Worked

### 1. Tighten message length: 6 lines → 4 lines (+1.6 points)

**The biggest single win.** The model was generating wordy confirmations. Dropping the max to 4 lines and adding a concrete brevity example forced tighter output.

**What to change in `persona.ts`:**
```diff
- Every message MUST be 6 lines or fewer
+ Every message MUST be 4 lines or fewer. Aim for 1-2 lines per message
```

**Add this line to the formatting rules:**
```
If you can say it in fewer words, do. "got it, $45, split 4 ways" beats "got it, I've logged $45 for the airport taxi and split it equally among all 4 trip members"
```

**Before:** `got it, I've logged your $45.00 expense for the airport taxi and split it equally among all 4 trip members`
**After:** `got it, $45, split 4 ways`

### 2. Multi-message recommendation examples (+0.2 points)

The prompt had one example for presenting options but it was a single wall-of-text message. Adding a concrete `send_multiple_messages` example improved how the model structures restaurant/hotel suggestions.

**Replace the Options pattern in `persona.ts`:**
```
Options — max 2-3, always with a recommendation. Use send_multiple_messages to break them into separate texts:
- Message 1: "ok found a few spots near the villa"
- Message 2: "Ibu Oka, famous roast pig, been around forever, 12 min walk"
- Message 3: "Naughty Nuri's, bbq ribs and margs, 5 min walk. I'd go here for the group"

When presenting options, each option gets its own short message. Name, what it's known for, one practical detail (distance, price, vibe). No numbered lists. No bullet points. The recommendation goes in the last message, casually: "I'd go X" or "X is the move for your group"
```

### 3. Casual lead-in for multi-message responses (+0.2 points)

Without this, the model was opening multi-message responses with formal intros like "Here are some recommendations."

**Add as texting rule #9 in `persona.ts`:**
```
When giving multiple options via send_multiple_messages, the first message should be casual and short: "ok couple options" or "found some spots" — NOT "Here are some recommendations for you". Then each following message covers one option in 1-2 lines max.
```

## Changes That Did NOT Work (Don't Bother)

| Change | Score impact | Why it failed |
|--------|-------------|---------------|
| Remove duplicate rules from BOUNDARIES | -0.1 | The redundancy actually helps GPT-5.4 follow rules. Don't simplify. |
| Make capitalize rule more aggressive ("never start a sentence with capital") | -0.3 + gate failure | Caused false positives on proper nouns (restaurant names). Too strict. |
| Change actionable intent routing to "offer help" instead of querying | -0.5 | Improved that one scenario but hurt voice scores on 3 others. |

## Key Insight

**Concrete examples > abstract rules.** Every win came from adding a specific before/after example in the exact register we want. Every loss came from adding or tightening abstract rules. The model already understands "be concise" — what it needs is "here is exactly what concise looks like in this context."

If Rizwan wants to keep improving the prompt, the playbook is:
1. Find a scenario where the agent's response feels off
2. Write the exact response you WANT to see
3. Add it as a BAD/GOOD example in the relevant section
4. Test it

## Per-Scenario Scores (Current Best)

| Scenario | Score | What the agent does |
|----------|-------|---|
| Stay silent on "lol" | 100 | Calls stay_silent. Perfect. |
| Stay silent on casual chat | 100 | Calls stay_silent. Perfect. |
| Stay silent on emoji | 100 | Calls stay_silent. Perfect. |
| Stay silent on friend-to-friend | 100 | Calls stay_silent. Perfect. |
| Add activity (formatting test) | 89.5 | `added, warung babi guling, wednesday at 7pm` |
| Jennifer test ("we just landed") | 87.0 | Uses send_multiple_messages, natural suggestions |
| Log expense ($45 taxi) | 85.9 | `got it, $45 for airport taxi, split 4 ways` |
| No AI tells (transportation Q) | 85.0 | Uses ai_suggest, no banned phrases |
| No banned words (plan first day) | 84.5 | Uses ai_suggest, clean vocabulary |
| Query balance ("what do I owe") | 84.0 | `you're owed $84.75` + breakdown |
| Direct question (Saturday plan) | 83.0 | `saturday is rice terrace hike, 8am on april 18` |
| Cast vote ("2") | 83.5 | `vote's in, you're on beach house in seminyak` |
| Restaurant suggestions | 82.5 | Uses ai_suggest + send_multiple_messages |
| Actionable intent (hotel situation) | 81.5 | Queries trip details, offers to help |
| Message length (hotel options) | 79.0 | Uses send_multiple_messages, keeps it short |
| No emoji (fun things in Ubud) | 77.5 | Uses ai_suggest, no emojis but brand voice dips |

## Weakest Areas (Optimization Targets)

1. **No emoji scenario (77.5):** Model passes the hard gate but brand voice scores low in multi-message flows. The judge can't see the text inside `send_multiple_messages` tool calls well.
2. **Message length (79.0):** When presenting multiple options, individual messages are short but the overall flow is still slightly verbose.
3. **Actionable intent (81.5):** When someone says "we need to figure out the hotel situation," the model queries trip details rather than proactively offering to search. Hard to fix without hurting other scores.

## How to Reproduce

```bash
cd ~/autoresearch
# Set your OpenAI key
echo "OPENAI_API_KEY=sk-..." > .env
# Install openai
pip3 install openai
# Run the eval
python3 eval.py
# Run the optimization loop
./optimize.sh
```

## Experiment Log

See `~/autoresearch/results.tsv` for the full log. See `git log` on the `autoresearch/mar25` branch for the actual diffs.

## Next Steps

- [ ] Run 20+ more experiments targeting the weak scenarios
- [ ] Add more test scenarios (currently 16 — want 30+)
- [ ] Add scenarios for edge cases: currency detection, undo, flight parsing
- [ ] Test with dynamic context variations (different trip sizes, stages)
- [ ] Compare prompt performance on Claude vs GPT-5.4
- [ ] Rizwan to review findings and apply changes to production prompt files
