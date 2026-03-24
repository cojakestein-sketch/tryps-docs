---
name: cost-report
description: Generate daily API cost report from Anthropic console and session tracking
user-invocable: true
---

# Daily Cost Report

Generate a daily cost snapshot for the nightly report and Slack.

## Approach

There's no per-key usage API from Anthropic. We use two methods:

### Method 1: Anthropic Console (Manual Check)
- Go to https://console.anthropic.com/settings/usage
- Read today's total usage for the organization
- This is the authoritative number but can't be automated yet

### Method 2: Session-Based Estimation (Automated)
- Count today's cron job runs and their durations from `~/.openclaw/cron/runs/`
- Count DM sessions by parsing gateway logs
- Estimate cost based on:
  - Opus: ~$15/1M input tokens, ~$75/1M output tokens
  - Sonnet: ~$3/1M input tokens, ~$15/1M output tokens
  - Average cron job (Sonnet, 5min): ~$0.05-0.15
  - Average DM session (Opus, 10min): ~$0.50-2.00
  - Average standup generation: ~$0.20-0.50

### Steps

1. **Count today's cron runs:**
```bash
# Count runs from today in each job's run log
for f in ~/.openclaw/cron/runs/*.jsonl; do
  today=$(date -u +%Y-%m-%d)
  count=$(grep "$today" "$f" 2>/dev/null | grep -c '"finished"')
  echo "$f: $count runs today"
done
```

2. **Estimate session costs:**
- 3 cron jobs × ~$0.15 avg = ~$0.45/day for crons
- DM sessions: count from Slack message history
- Attribute: cron = "Marty (auto)", DM from Jake = "Jake", DM triggered by Asif in #martyasif = "Asif"

3. **Format for nightly report:**
```
API Spend (estimated):
  Total today: ~$X.XX
  Crons (auto): ~$X.XX (3 runs: standup, topic, nightly)
  Jake (DM): ~$X.XX (N sessions)
  Asif (channel): ~$X.XX (N sessions)
  Note: Estimates based on session count × avg cost. Check console.anthropic.com for exact billing.
```

4. **Post to Slack daily:**
- Post to #martydev at 7pm ET
- One-liner format: "Today's estimated API cost: ~$X.XX (Crons: $X, Jake: $X, Asif: $X)"

## Future Improvements

When Anthropic adds a usage API or OpenClaw adds token tracking:
- Switch to exact token counts per session
- Break down by model (Opus vs Sonnet)
- Track cost trends over time (daily/weekly chart)
- Alert if daily cost exceeds threshold (e.g., $10)
