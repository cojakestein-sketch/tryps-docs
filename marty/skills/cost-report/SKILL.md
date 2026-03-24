---
name: cost-report
description: Generate daily API cost report from OpenClaw session logs with exact token counts
user-invocable: true
---

# Daily Cost Report

Generate a daily cost snapshot for the nightly report and Slack.

## Method: Parse OpenClaw Cron Run Logs (Automated, Exact)

OpenClaw cron run logs at `~/.openclaw/cron/runs/*.jsonl` contain exact token usage per session:

```json
{"usage": {"input_tokens": 18, "output_tokens": 15096, "total_tokens": 63366}, "model": "claude-opus-4-6"}
```

### Token → Cost Mapping (Anthropic Pricing, May 2025)

| Model | Input | Output | Context (est.) |
|-------|-------|--------|----------------|
| Opus 4.6 | $15/1M | $75/1M | $3.75/1M (cached) |
| Sonnet 4.6 | $3/1M | $15/1M | $0.75/1M (cached) |

**Note:** `total_tokens` includes context window tokens (cached prompt). Use this formula:
- `context_tokens = total_tokens - input_tokens - output_tokens`
- `cost = (input_tokens × input_rate) + (output_tokens × output_rate) + (context_tokens × cache_rate)`

### Steps

1. **Parse today's cron runs:**
```bash
today=$(date -u +%Y-%m-%d)
for f in ~/.openclaw/cron/runs/*.jsonl; do
  job=$(basename "$f" .jsonl)
  # Get today's finished runs with usage data
  grep "\"finished\"" "$f" | grep "$today" | python3 -c "
import sys, json
total_cost = 0
for line in sys.stdin:
  d = json.loads(line)
  u = d.get('usage', {})
  model = d.get('model', 'claude-opus-4-6')
  inp = u.get('input_tokens', 0)
  out = u.get('output_tokens', 0)
  tot = u.get('total_tokens', 0)
  ctx = tot - inp - out
  if 'opus' in model:
    cost = (inp * 15 + out * 75 + ctx * 3.75) / 1_000_000
  else:
    cost = (inp * 3 + out * 15 + ctx * 0.75) / 1_000_000
  total_cost += cost
print(f'{job}: \${total_cost:.2f} ({tot:,} total tokens)')
"
done
```

2. **Parse DM session costs:**
- DM sessions are logged in gateway logs or individual session files under `~/.openclaw/logs/`
- Count unique sessions initiated today
- Estimate DM cost based on session duration and model

3. **Jake's local Claude Code usage:**
- Not available via API currently
- Direct Jake to check: https://console.anthropic.com/settings/usage
- This shows organization-wide usage broken down by day
- The delta between console total and Marty's tracked cost = Jake's local usage

4. **Format for nightly report (Section 9):**
```
| Category | Cost | Tokens | Notes |
|----------|------|--------|-------|
| Nightly report | $X.XX | XX,XXX | Opus, this session |
| Standup generator | $X.XX | XX,XXX | Opus |
| Topic suggestion | $X.XX | XX,XXX | Opus |
| Cost report | $X.XX | XX,XXX | Opus |
| DM sessions (est.) | $X.XX | ~XX,XXX | Opus, N sessions |
| **Total (Marty)** | **$X.XX** | **XX,XXX** | |
| Jake local (est.) | ~$X-X | — | Check console.anthropic.com |
| **Est. daily total** | **~$X.XX** | | |
```

5. **Post to Slack daily:**
- Post to #martydev at 7pm ET
- Format: "Cost report: Marty spent $X.XX today (Crons: $X.XX across N runs, DMs: ~$X.XX across N sessions). Check console.anthropic.com for Jake's local usage."

## Alert Thresholds

- Daily total > $15: Post warning to #martydev
- Single session > $5: Flag in nightly report
- Weekly total > $50: Escalate to Jake DM

## Reference: Recent Actual Costs

From 2026-03-23 logs:
- Nightly report run 1: 58,146 total tokens → ~$1.31 (Opus)
- Nightly report run 2: 63,366 total tokens → ~$1.47 (Opus)
- Typical cron total: ~$2-4/day for all 4 jobs
- DM sessions vary: $0.50-5.00 per conversation
