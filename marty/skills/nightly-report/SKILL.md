---
name: nightly-report
description: Generate Jake's printable nightly brief with standup, tech twitter, GitHub trending, deep dive, strategy check, mission progress, CS 101, and cost snapshot
user-invocable: true
---

# Nightly Report Generator

Generate a printable HTML nightly brief for Jake. Runs at 8:30pm ET after the standup-generator cron.

## Report Sections

### Section 1: Tomorrow's Standup
- Read the standup doc that was just generated at 8pm (`tryps-docs/docs/standups/YYYY-MM-DD-standup.md` for tomorrow's date)
- Include all 3 questions per dev, formatted cleanly

### Section 2: Tech Twitter Digest
- **Method:** Use Exa Search via AgentCash x402 (`POST https://stableenrich.dev/api/exa/search`, $0.01/call) with the `category: "tweet"` filter for reliable tweet retrieval
- **DO NOT** use `site:x.com` in the query string — this is unreliable and causes scraping failures. Use the `category` parameter instead.
- Accounts to track:
  - `@stakejein` (Jake's account — surface any posts with engagement)
  - `@karpathy` (AI research)
  - `@sama` (OpenAI / AI industry)
  - `@elonmusk` (tech / X platform)
  - `@pmarca` (a16z / startups)
  - `@AnthropicAI` (Claude / our stack)
  - `@OpenAI` (competitor landscape)

- Exa search queries (run via `mcp__agentcash__fetch`):
  ```json
  POST https://stableenrich.dev/api/exa/search
  {"query": "karpathy", "category": "tweet", "numResults": 5, "startPublishedDate": "YYYY-MM-DDT00:00:00Z"}
  ```
  Repeat for each account. ~$0.07 total for all 7 accounts.

- For each relevant post found: include the author, a one-liner summary, engagement if available, and **a direct link to the tweet**
- No editorialization — just surface the posts with context
- Aim for 5-10 posts total across all accounts

**Note:** twit.sh was deprecated March 2026. Exa `category: "tweet"` is the canonical method. Do NOT fall back to Brave Search — if Exa fails, report the failure in this section so Jake can debug.

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
- **Use exact token counts from cron logs, not estimates.** Parse `~/.openclaw/cron/runs/*.jsonl` for today's runs:
  ```bash
  today=$(date -u +%Y-%m-%d)
  for f in ~/.openclaw/cron/runs/*.jsonl; do
    job=$(basename "$f" .jsonl)
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
- **Token → Cost mapping (Anthropic, May 2025):**
  - Opus 4.6: $15/1M input, $75/1M output, $3.75/1M cached context
  - Sonnet 4.6: $3/1M input, $15/1M output, $0.75/1M cached context
- Break down by: nightly report, standup generator, topic suggestion, cost report, DM sessions
- DM sessions: estimate from `~/.openclaw/logs/` gateway logs (count unique sessions × avg cost)
- **Do NOT use placeholder estimates like "~$1.00".** If logs are unavailable for a category, say "No log data" — don't guess.
- Format as a table with Category, Cost, Tokens, Notes columns
- Alert thresholds: Daily > $15 → warning, Single session > $5 → flag, Weekly > $50 → escalate to Jake DM

### Section 10: Mission Progress
- Read Jake's Missions from today's standup doc (`tryps-docs/docs/standups/YYYY-MM-DD-standup.md`)
- For each mission, report what moved today:
  - Check GitHub for merged PRs, new commits, opened PRs related to the mission
  - Check ClickUp for task status changes
  - Check standup answers for dev commitments related to the mission
  - Check Slack #martydev for relevant updates
- Format per mission:
  - **Mission title** (from standup)
  - **What moved:** Concrete evidence (PR numbers, ClickUp task IDs, commits)
  - **What didn't:** If nothing moved, say so plainly
  - **Verdict:** PROGRESS / STALLED / NO DATA
- This section connects the daily work back to what Jake actually cares about. If devs are doing work that doesn't map to any mission, call that out too.
- **Source:** For now, missions come from the standup doc. When the team dashboard is live, switch to reading from that instead.

### Section 11: CS 101 — Jake's Daily Lesson
- One foundational computer science concept per night, explained in plain language
- **Audience:** Jake — non-CS background, runs a tech company, needs to understand what his team is building and why
- **Tone:** Like a smart friend explaining over coffee. No jargon-explaining-jargon. Use analogies to real-world things Jake knows (restaurants, travel, group chats).
- **Structure:**
  - **What it is** (2-3 sentences, dead simple)
  - **Why it matters for Tryps** (1-2 sentences connecting it to something real in the codebase or infrastructure)
  - **The "aha" moment** (one sentence that makes it click)
- **Topic rotation — bottom-up through the stack:**
  1. **Hardware layer** (weeks 1-2): Binary, CPU, RAM, storage, what happens when you turn a computer on, what a chip actually does
  2. **OS & networking** (weeks 3-4): Processes, ports, SSH, DNS, HTTP, what "the cloud" actually is, what a server does
  3. **Dev fundamentals** (weeks 5-6): What is a .env file, what is an API, what is a database, what is a migration, what is a commit, what is a branch
  4. **Your stack** (weeks 7-8): What Supabase is actually doing, what Expo does, what edge functions are, what a webhook is, what TypeScript compiles to
- **Topic selection:** Pick the next topic in the rotation. If a dev is working on something that connects to a concept (e.g., Rizwan deploying edge functions → explain what edge functions are), prioritize that.
- **Length:** 2-3 paragraphs max. This gets printed — keep it tight.
- **Examples of good topics:** "What is RAM and why does your phone get slow", "What SSH actually does when you type that command", "What happens when you open the Tryps app — every step from tap to screen", "What a .env file is and why you never commit it"

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
    <!-- Cost table with exact token counts from cron logs -->
  </section>

  <section>
    <h2>10. Mission Progress</h2>
    <!-- Per-mission: what moved, what didn't, verdict -->
  </section>

  <section>
    <h2>11. CS 101</h2>
    <div class="strategy-box">
      <!-- Today's concept: what it is, why it matters for Tryps, the aha moment -->
    </div>
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
