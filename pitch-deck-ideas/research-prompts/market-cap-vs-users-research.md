# Research Prompt: Market Cap vs. User Count Graph

## Objective

Build a dataset mapping **user count (MAU or total users)** to **market cap (or valuation)** at multiple points in time for companies in the travel, social utility, and consumer social space. The output is a CSV that Jake will use to build a visualization for the pitch deck.

## Instructions

Use a team of research agents to gather data in parallel. Each agent takes one company. For each company, find as many data points as possible mapping user count to valuation/market cap at that moment in time.

### Companies to Research

**Public companies (SEC filings, earnings calls, press releases):**
1. **Expedia Group** (EXPE) — quarterly MAU or unique visitors + market cap at each reporting period
2. **Booking Holdings** (BKNG) — same
3. **TripAdvisor** (TRIP) — same
4. **Airbnb** (ABNB) — guests/hosts over time + market cap/valuation (including pre-IPO funding rounds)
5. **Kayak** — pre-acquisition by Booking (IPO in 2012, acquired 2013). Users + market cap during public period.

**Private companies (Crunchbase, PitchBook, press releases, interviews):**
6. **Partiful** — valuation at each funding round + any reported user/event counts
7. **Beli** — valuation at each funding round + any reported user counts
8. **Splitwise** — valuation at Series A ($20M raise) + reported user/transaction volume
9. **Strava** — valuation at each funding round + reported user milestones
10. **Wanderlog** — any available data

### Data Points Needed Per Company

For each data point:
- **Date** (quarter or month)
- **User metric** (MAU, total users, unique visitors — note which one)
- **Valuation/Market cap** (in USD)
- **Source** (URL or document reference)

### Output Format

```csv
company,date,user_metric_type,user_count,valuation_usd,source
Expedia,2015-Q1,monthly_unique_visitors,100000000,12500000000,SEC 10-Q
...
```

Save the CSV to: `pitch-deck-ideas/data/market-cap-vs-users.csv`

### Analysis After Data Collection

Once data is gathered:
1. Identify which user metric (MAU vs total users) has the most consistent data across companies
2. Calculate a rough regression line (market cap as a function of users)
3. Answer: "To reach $200M market cap, how many users would Tryps need based on this correlation?"
4. Answer: "What is 1% of Expedia's current user base, and what market cap does the regression predict at that level?"

### Notes
- Public companies have the best data — prioritize them
- For private companies, funding round valuations are proxies for market cap (not exact, but useful)
- Flag any data points that seem unreliable
- Jake will build the actual visualization — just deliver the clean dataset and analysis
