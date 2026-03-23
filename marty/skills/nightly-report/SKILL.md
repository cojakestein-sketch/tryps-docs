---
name: nightly-report
description: Generate Jake's printable nightly brief with standup, tech twitter, GitHub trending, deep dive, strategy check, and cost snapshot
user-invocable: true
---

# Nightly Report Generator

Generate a printable HTML nightly brief for Jake. Runs at 8:30pm ET after the standup-generator cron.

## Report Sections

### Section 1: Tomorrow's Standup
- Read the standup doc that was just generated at 8pm (`tryps-docs/docs/standups/YYYY-MM-DD-standup.md` for tomorrow's date)
- Include all 5 questions per dev, formatted cleanly

### Section 2: Tech Twitter Digest
- Use Brave Search API to find today's most-discussed tweets from these accounts:
  - `@stakejein` (Jake's account — surface any posts with engagement)
  - `@karpathy` (AI research)
  - `@sama` (OpenAI / AI industry)
  - `@elonmusk` (tech / X platform)
  - `@pmarca` (a16z / startups)
  - `@AnthropicAI` (Claude / our stack)
  - `@OpenAI` (competitor landscape)

- Search queries to run via Brave:
  ```
  site:x.com karpathy since:today
  site:x.com "sam altman" since:today
  site:x.com pmarca since:today
  site:x.com AnthropicAI since:today
  site:x.com stakejein
  ```

- For each relevant post found: include the author, a one-liner summary of the post, and engagement if available
- No editorialization — just surface the posts with context
- Aim for 5-10 posts total across all accounts
- If Brave Search doesn't return good results, note "Twitter digest unavailable — consider setting up twit.sh x402 integration"

**Future upgrade:** When agentcash/x402 is set up on Hetzner, switch to twit.sh API:
- `GET https://twit.sh/tweets/user?username=karpathy` ($0.01/call)
- `GET https://twit.sh/tweets/search?from=karpathy&minLikes=1000&since=YYYY-MM-DD` ($0.01/call)

### Section 3: Trending GitHub Repos
- Use Brave Search or `gh` CLI to find today's trending repos
- Search: `site:github.com trending` or parse `https://github.com/trending?since=daily`
- Filter for repos relevant to: AI/agents, travel tech, React Native/Expo, Supabase, TypeScript
- Include top 3 with: repo name, star count, one-line description, why it might matter to Tryps

### Section 4: Today's Deep Dive
- Read the topic from Jake's response to the 3pm topic-suggestion DM
- If no response, use the topic Marty suggested
- If Jake said "skip", omit this section
- Write a **1-page** brief on the topic:
  - What it is (2-3 sentences)
  - Why it matters at this stage of Tryps (2-3 sentences)
  - Key takeaways or actions (3-5 bullets)
  - One resource link if relevant
- Research using Brave Search and any relevant docs in tryps-docs
- Keep it dense and actionable — this gets printed

### Section 5: Strategy Check
- Read `tryps-docs/shared/priorities.md`, `tryps-docs/shared/state.md`, and recent standup answers
- Read `marty/MEMORY.md` for accumulated context
- Write Marty's current understanding of:
  - **Where we are:** Current sprint status, what's shipping, what's stuck
  - **Top 3 risks:** Things most likely to slip or cause problems
  - **Areas Jake should focus on:** Based on what Marty sees across all inputs
  - **What Marty thinks the #1 priority is:** And why
- **Important:** This section is designed for Jake to correct. If his understanding is wrong, Jake will tell him via voice memo or text. This is how Marty's strategic memory stays calibrated.

### Section 6: Cost Snapshot
- Parse OpenClaw session logs from today (`~/.openclaw/logs/`)
- Calculate approximate API cost based on token usage × Anthropic pricing
- Break down by session initiator (Jake DM, Asif DM, cron job, etc.)
- Format: `Total: $X.XX | Jake: $X.XX | Asif: $X.XX | Crons: $X.XX`
- If log parsing fails, note "Cost tracking not yet configured — see Phase 5 of revamp plan"

## Output Format: Printable HTML

Write to `tryps-docs/marty/reports/YYYY-MM-DD-nightly.html`

The HTML must be:
- **Print-optimized:** Clean typography, no interactive elements, fits on 3-5 printed pages
- **Self-contained:** All styles inline, no external dependencies
- **Readable:** Good use of whitespace, clear section headers, professional but warm

```html
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Tryps Nightly Brief — [Date]</title>
<style>
  @page { margin: 0.75in; size: letter; }
  @media print {
    body { font-size: 11pt; }
    .no-print { display: none; }
    section { page-break-inside: avoid; }
  }
  body {
    font-family: 'Plus Jakarta Sans', -apple-system, system-ui, sans-serif;
    max-width: 7in;
    margin: 0 auto;
    padding: 40px 20px;
    color: #3D3530;
    line-height: 1.5;
  }
  h1 {
    font-size: 24pt;
    font-weight: 700;
    color: #D9071C;
    margin-bottom: 4px;
  }
  .subtitle {
    font-size: 10pt;
    color: #888;
    margin-bottom: 32px;
  }
  h2 {
    font-size: 14pt;
    font-weight: 600;
    color: #3D3530;
    border-bottom: 1px solid #EDE4D8;
    padding-bottom: 6px;
    margin-top: 28px;
  }
  h3 { font-size: 12pt; font-weight: 600; margin-top: 16px; }
  p, li { font-size: 11pt; }
  .tweet { padding: 8px 0; border-bottom: 1px solid #f0f0f0; }
  .tweet-author { font-weight: 600; }
  .tweet-text { color: #555; }
  .repo { padding: 6px 0; }
  .repo-name { font-weight: 600; font-family: 'Space Mono', monospace; }
  .cost-table { width: 100%; border-collapse: collapse; margin-top: 8px; }
  .cost-table td, .cost-table th {
    padding: 4px 8px;
    text-align: left;
    border-bottom: 1px solid #eee;
    font-family: 'Space Mono', monospace;
    font-size: 10pt;
  }
  .strategy-box {
    background: #FFFDF8;
    border: 1px solid #EDE4D8;
    border-radius: 8px;
    padding: 16px;
    margin-top: 12px;
  }
  .print-btn {
    position: fixed;
    top: 20px;
    right: 20px;
    background: #D9071C;
    color: white;
    border: none;
    padding: 12px 24px;
    border-radius: 10px;
    font-size: 14pt;
    cursor: pointer;
    font-family: inherit;
    font-weight: 600;
  }
  .print-btn:hover { background: #B00618; }
</style>
</head>
<body>
  <button class="print-btn no-print" onclick="window.print()">Print</button>
  <h1>Tryps Nightly Brief</h1>
  <div class="subtitle">
    [Full Date] — Prepared by Marty at [time] ET
  </div>

  <section>
    <h2>1. Tomorrow's Standup</h2>
    <!-- Questions per dev -->
  </section>

  <section>
    <h2>2. Tech Twitter</h2>
    <!-- Tweet summaries -->
  </section>

  <section>
    <h2>3. Trending Repos</h2>
    <!-- Top 3 repos -->
  </section>

  <section>
    <h2>4. Deep Dive: [Topic]</h2>
    <!-- 1-pager -->
  </section>

  <section>
    <h2>5. Strategy Check</h2>
    <div class="strategy-box">
      <!-- Marty's understanding -->
    </div>
  </section>

  <section>
    <h2>6. Cost Snapshot</h2>
    <!-- Cost table -->
  </section>
</body>
</html>
```

## Delivery

1. Commit and push the HTML file to tryps-docs
2. DM Jake on Slack with:
   > "Tonight's brief is ready. Open and hit Print: [GitHub raw link or local path]"
3. Include a direct link to the raw HTML on GitHub (so it renders in browser)

## Commit

```bash
cd ~/tryps-docs
git add marty/reports/YYYY-MM-DD-nightly.html
git commit -m "chore: nightly report for YYYY-MM-DD"
git push origin main
```
