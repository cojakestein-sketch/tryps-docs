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
- **Primary:** Use Exa Search via AgentCash x402 (`POST https://stableenrich.dev/api/exa/search`, $0.01/call) for neural search of today's tweets
- **Fallback:** Use Brave Search API if Exa is unavailable
- Accounts to track:
  - `@stakejein` (Jake's account — surface any posts with engagement)
  - `@karpathy` (AI research)
  - `@sama` (OpenAI / AI industry)
  - `@elonmusk` (tech / X platform)
  - `@pmarca` (a16z / startups)
  - `@AnthropicAI` (Claude / our stack)
  - `@OpenAI` (competitor landscape)

- Exa search queries (run via AgentCash fetch):
  ```json
  POST https://stableenrich.dev/api/exa/search
  {"query": "karpathy site:x.com", "numResults": 5, "startPublishedDate": "YYYY-MM-DDT00:00:00Z", "type": "neural"}
  ```
  Repeat for each account. ~$0.07 total for all 7 accounts.

- For each relevant post found: include the author, a one-liner summary, engagement if available, and **a direct link to the tweet**
- No editorialization — just surface the posts with context
- Aim for 5-10 posts total across all accounts

**Note:** twit.sh (previously planned) was deprecated as of March 2026. Exa neural search provides comparable coverage with direct links.

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
- **Timing:** This section should reference the correct week. Week boundaries: Week 1 = Mar 2-8, Week 2 = Mar 9-15, Week 3 = Mar 16-22, Week 4 = Mar 23-29, Week 5 = Mar 30 - Apr 5. Use "Beginning of week X" on Mon/Tue, "Mid-week X" on Wed/Thu, "End of week X" on Fri/Sat/Sun.
- **Important:** This section is designed for Jake to correct. If his understanding is wrong, Jake will tell him via voice memo or text. This is how Marty's strategic memory stays calibrated.

### Section 6: Culture & Conversation
- Surface 2-3 substantive topics that a founder/tech person in Jake's circle would likely discuss
- **This is NOT TMZ or pop culture gossip.** Think: things people at a dinner with other founders, VCs, or tech professionals would talk about
- Sources: Use Exa Search or Brave for today's top stories in tech, business, science, geopolitics, or cultural trends
- Good examples: A new Supreme Court ruling on tech, a major IPO, a viral essay on startup culture, a notable acquisition, a scientific breakthrough, a thoughtful piece on AI ethics
- Bad examples: Celebrity gossip, sports scores, reality TV, memes
- Format: 2-3 items, each with a one-liner summary and a link. Add a brief "why this matters" or "conversation angle" note
- Goal: Jake walks into any meeting or dinner and has something smart to say that isn't just AI/startup news

### Section 7: AI Model Releases & Patch Notes
- Synthesized daily release notes from the major model providers:
  - **Anthropic** (Claude models, Claude Code, API changes)
  - **OpenAI** (GPT models, ChatGPT, API updates)
  - **Google DeepMind** (Gemini models, AI Studio)
  - **xAI** (Grok models, platform updates)
- Also include major product launches from the broader AI/tech ecosystem (e.g., Coinbase x402, new developer tools, significant open-source releases)
- Sources: Company blogs, X/Twitter accounts, Hacker News, TechCrunch, The Verge
- Use Exa Search (`POST https://stableenrich.dev/api/exa/search`) with queries like:
  ```json
  {"query": "Anthropic Claude release announcement", "numResults": 3, "startPublishedDate": "YYYY-MM-DDT00:00:00Z"}
  {"query": "OpenAI GPT release update", "numResults": 3, "startPublishedDate": "YYYY-MM-DDT00:00:00Z"}
  {"query": "Google Gemini update release", "numResults": 3, "startPublishedDate": "YYYY-MM-DDT00:00:00Z"}
  {"query": "xAI Grok update", "numResults": 3, "startPublishedDate": "YYYY-MM-DDT00:00:00Z"}
  ```
- Format: Table or list with provider, what changed, and a one-liner on relevance
- If nothing notable was released today, say "No major releases today" (don't pad with old news)

### Section 8: Tools Highlight
- Discover and surface 1-2 tools that could be useful for Jake or the team
- Jake's current stack: ClickUp, Granola, Slack, Zoom, Wispr Flow, Figma, Markdown, WhatsApp, GitHub, Claude Code, Expo
- For each tool surfaced, write a mini one-pager:
  - **What it is** (one sentence)
  - **How Jake would use it** (2-3 sentences, specific to Tryps workflow)
  - **Pricing** (free tier? cost?)
  - **Link**
- Good candidates: productivity tools, design tools, developer tools, collaboration tools, AI-powered tools, analytics, user research tools
- Do NOT recommend tools that overlap with existing stack unless they're meaningfully better
- Sources: Product Hunt (today's top launches), Hacker News, Brave Search for "[category] tools 2026"
- Rotate categories: Mon=productivity, Tue=design, Wed=developer, Thu=analytics, Fri=AI/automation, Weekend=wildcard

### Section 9: Cost Snapshot
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
    <h2>6. Culture & Conversation</h2>
    <!-- 2-3 substantive topics for dinner/meeting conversation -->
  </section>

  <section>
    <h2>7. AI Releases & Patch Notes</h2>
    <!-- Synthesized daily releases from Anthropic, OpenAI, Google, xAI + major launches -->
  </section>

  <section>
    <h2>8. Tools Highlight</h2>
    <!-- 1-2 tools with mini one-pager: what it is, how Jake would use it, pricing, link -->
  </section>

  <section>
    <h2>9. Cost Snapshot</h2>
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
