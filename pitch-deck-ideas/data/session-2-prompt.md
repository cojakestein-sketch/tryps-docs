# Pitch Deck: Users → Valuation Analysis (Session 2)

## Goal

Build an investor-ready HTML page that answers two questions:

1. **"At X app downloads, Tryps is worth $Y"**
2. **"At X MAU, Tryps is worth $Y"**

Show milestone projections at: **10K, 100K, 500K, 1M, 10M** for both metrics.

Use a **$/user comp table** approach (not regression). Show the range of $/download and $/MAU that real companies achieved at funding rounds, then apply that range to Tryps.

---

## Two Metrics (strictly separated — no mixing)

### Metric 1: App Downloads
Cumulative downloads from App Store + Google Play at the time of the funding round. Comparable to "total signups" or "registered users." This is the top-of-funnel number.

### Metric 2: MAU
Monthly active users at the time of the funding round. This is the engagement number.

---

## Step 1: Research (one agent per company)

Run one research agent for each company below that says "NEED DATA." Each agent should search for:
- **Valuation** at each funding round (post-money)
- **App downloads** OR **registered users** at that round
- **MAU** at that round
- **Source URL** (TechCrunch, Crunchbase, Bloomberg, SEC filings, press releases)

Only include data points where BOTH a user metric AND a valuation are confirmed. Flag anything unreliable.

### Companies with confirmed data (DO NOT re-research):

```csv
company,date,round,metric_type,user_count,valuation_usd,source
Poke,2025-09,Seed ($15M),beta_users,6000,100000000,"TechStartups — General Catalyst led"
Character.AI,2023-03,Series A ($150M),monthly_visits,100000000,1000000000,"CNBC — a16z led"
Character.AI,2024-08,Google deal,MAU,28000000,2500000000,"The Information — Google confirmed $2.7B"
BeReal,2021-06,Series A ($30M),DAU,300000,150000000,"TechCrunch — a16z + Accel"
BeReal,2022-05,Series B ($60M),DAU,7900000,600000000,"TechCrunch — DST Global"
BeReal,2024-06,Acquisition,MAU,40000000,537000000,"TechCrunch — Voodoo EUR 500M"
Perplexity,2024-01,Series B ($73.6M),MAU,10000000,520000000,"Perplexity blog — IVP led"
Perplexity,2024-06,Series B ext ($250M),MAU,15000000,3000000000,"TechCrunch — SoftBank"
Perplexity,2024-12,Series C ($500M),MAU,20000000,9000000000,"TechCrunch"
Perplexity,2025-06,Series D ($500M),MAU,30000000,14000000000,"CNBC — Accel led"
Perplexity,2025-09,Series D-2 ($200M),MAU,45000000,20000000000,"TechCrunch"
Noplace,2024-07,Series A1 ($15M),waitlist,500000,90000000,"TechCrunch — 776 + Forerunner"
Hopper,2020-05,Series E ($70M),cumulative_downloads,70000000,1000000000,"Skift"
Hopper,2021-08,Series G ($175M),cumulative_downloads,70000000,3500000000,"TechCrunch"
Hopper,2022-02,Secondary ($35M),cumulative_downloads,70000000,5000000000,"TechCrunch"
Strava,2014-10,Series D ($18.5M),registered_users,10000000,200000000,"Forge/Inc.com — Sequoia led"
Strava,2020-11,Series F ($110M),registered_users,70000000,1500000000,"TechCrunch — TCV + Sequoia"
Strava,2025-05,Series F ext ($50M),registered_users,150000000,2200000000,"Crunchbase News"
AllTrails,2018-10,Spectrum Equity,registered_users,9000000,75000000,"TechCrunch"
AllTrails,2021-11,Permira ($150M),registered_users,30000000,875000000,"TechCrunch / PRNewswire"
Instagram,2011-02,Series A ($7M),MAU,1750000,25000000,"TechCrunch — Benchmark led"
Instagram,2012-04,Series B ($50M),registered_users,30000000,500000000,"TechCrunch — Sequoia"
Instagram,2012-04,Acquisition,registered_users,30000000,1000000000,"TechCrunch — Facebook $1B"
Airbnb,2009-01,Seed (YC),registered_users,10000,2000000,"Y Combinator"
Airbnb,2009-04,Seed (Sequoia),registered_users,10000,10000000,"Sequoia Capital"
Airbnb,2012,Series B ($112M),registered_users,6000000,1300000000,"TechCrunch"
Airbnb,2014-04,Series D ($450M),registered_users,50000000,10000000000,"Inc. Magazine — TPG led"
Airbnb,2016-09,Series F ($555M),registered_users,100000000,30000000000,"DemandSage / press"
Airbnb,2019,Pre-IPO,registered_users,200000000,35000000000,"DemandSage / CNBC"
Kayak,2005-10,Series B,UMV,3000000,17000000,"S-1 filing"
Kayak,2007-12,Series D,UMV,6000000,250000000,"S-1 filing"
Kayak,2012-06,IPO,UMV,8300000,1270000000,"TechCrunch / comScore"
```

### Companies that NEED individual research agents:

Each agent should try to find valuation + user count at funding rounds. If valuation is undisclosed after thorough search, mark as "UNDISCLOSED" and we'll drop that company.

1. **Partiful** — Event invites app. Known: ~$400M valuation (Dec 2024, disputed), 500K MAU (Q1 2025). NEED: confirmed valuation + user count at same point in time.
2. **Fizz** — College social app. Raised $4.5M seed, $12M Series A, $25M Series B. All valuations undisclosed in prior research. Try harder: PitchBook summaries, investor LP letters, secondary market data.
3. **Butterflies** — AI social network. $4.8M seed (Coatue led, 2024). NEED: valuation + user count.
4. **Geneva** — Group chat. Acquired by Bumble for $17.5M (Jul 2024). NEED: user count at acquisition.
5. **Locket** — Widget photo sharing. $12.5M total seed funding. 9M DAU / 90M downloads (Aug 2025). NEED: valuation at any round.
6. **Splitwise** — Expense splitting. $20M Series A (2021), ~$30M more (2025). All valuations undisclosed. Try PitchBook, Sacra, secondary sources.
7. **Headout** — Experiences marketplace. $30M Series B ext (2022). CEO said "high hundreds of millions" valuation. NEED: specific number + user count.
8. **Layla** — AI trip planner. $3.3M seed (2023), 7-figure round (2026). NEED: valuation + user count.
9. **Mindtrip** — AI travel planning. $22.5M total across 3 rounds. NEED: valuation at any round + user count.
10. **Wanderlog** — Trip planning. $1.5M seed (2021). 2.8M downloads (2025). NEED: valuation.
11. **Beli** — Restaurant ratings. $12M total funding. 1.1M MAU (Oct 2024). NEED: valuation at any round.
12. **Venmo** — P2P payments. Use analyst standalone estimates: ARK $38B (2020), Bernstein $5B (2025). Include with "analyst estimate" flag.

---

## Step 2: Classify every data point

After research, put each data point in exactly ONE bucket:

### Bucket A: App Downloads / Registered Users / Total Signups
Only use data where the metric is "downloads," "registered users," or "total signups." These all mean "people who have the app."

### Bucket B: MAU
Only use data where the metric is "MAU" or "DAU." If DAU, note it but include (DAU is a stricter version of MAU).

If a company reported both metrics at the same round, it appears in both buckets.

DO NOT put "monthly visits," "waitlist," "queries," "bookings," or "corporate customers" in either bucket. Drop those data points.

---

## Step 3: Compute $/user for each data point

For every data point:
- `$/download = valuation / downloads`
- `$/MAU = valuation / MAU`

---

## Step 4: Determine credible ranges

### For Downloads:
- Sort all $/download values
- Find the 25th percentile (conservative) and 75th percentile (optimistic)
- Use median as mid-range

### For MAU:
- Same: P25 (conservative), median (mid), P75 (optimistic)

Note: if AI companies skew the range, show two sub-ranges:
- "Consumer social/travel" range
- "AI-native" range (includes Perplexity, Character.AI, Poke)

---

## Step 5: Build the HTML page

Save to: `pitch-deck-ideas/data/valuation-charts.html`

### Structure:

**Section 1: "At X Downloads, Tryps Is Worth..."**
Table with milestones (10K, 100K, 500K, 1M, 10M):
| Downloads | Conservative | Mid-Range | Optimistic |
Each cell shows the dollar amount. Below the table, show which companies informed each range.

**Section 2: "At X MAU, Tryps Is Worth..."**
Same format, same milestones, using $/MAU range.

**Section 3: Comp Table — $/Download**
Every data point in Bucket A, sorted by $/download descending. Columns: Company, Round, Downloads, Valuation, $/Download, Source.

**Section 4: Comp Table — $/MAU**
Every data point in Bucket B, sorted by $/MAU descending. Same columns.

**Section 5: Scatter Plot — Downloads**
Log-log scatter. X = downloads, Y = valuation. Shaded band showing the P25-P75 range. Tryps star marker at 100K.

**Section 6: Scatter Plot — MAU**
Same format for MAU. Tryps star at 30K MAU.

**Section 7: Calculator**
Two inputs: Downloads and MAU. Shows conservative/mid/optimistic for each.

### Design:
- Clean, light background (#fafafa)
- Helvetica Neue font
- Tryps red (#D9071C) for accents
- Chart.js for scatter plots
- Self-contained single HTML file (CDN for Chart.js)
- Mobile responsive

---

## Step 6: Save the master CSV

Save all data to: `pitch-deck-ideas/data/master-funding-round-comps.csv`

Columns:
```
company,date,round,metric_type,user_count,valuation_usd,dollars_per_user,bucket,source,reliability
```

Where:
- `metric_type` = downloads | registered_users | MAU | DAU
- `bucket` = A (downloads) | B (MAU) | EXCLUDED
- `reliability` = HIGH | MEDIUM | LOW | ANALYST_ESTIMATE

---

## Key Rules

1. **No regression lines.** Show ranges and bands instead.
2. **No mixing metrics.** Downloads chart uses only download data. MAU chart uses only MAU data.
3. **Every number needs a source.** This goes in front of investors.
4. **Flag AI premium.** If AI companies (Poke, Perplexity, Character.AI) skew the range, show it separately.
5. **Poke stays in.** $100M at 6K users is real and helps our story.
6. **Navan is excluded.** B2B enterprise, not consumer.
7. **Open the final HTML** with `open` command so Jake can review immediately.
8. **Open the analysis markdown** in Marked 2 so Jake can read it.
