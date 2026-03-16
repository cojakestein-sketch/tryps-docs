# Users → Valuation Analysis: Key Findings

**Generated:** March 15, 2026 (v2 — corrected Partiful, dropped Fizz, adjusted Venmo user counts)

---

## Dataset Summary

- **32 data points** from 13 companies across 4 categories (Travel, Social, AI, Fintech)
- **18 in Bucket A** (downloads/registered users) from 9 companies
- **14 in Bucket B** (MAU/DAU) from 7 companies
- **6 excluded** data points (wrong metric type or unconfirmed valuation)
- **8 companies dropped** from research (Butterflies, Geneva, Locket, Headout, Layla, Mindtrip, Wanderlog, Beli — valuation or user count undisclosed)

## Research Results (Step 1)

| Company | Result | Notes |
|---------|--------|-------|
| Partiful | 1 data point (corrected) | 500K MAU @ **$140M confirmed** (Series A1, Nov 2022). $400M was disputed by spokesperson. Temporal gap: valuation from 2022, MAU from Q1 2025. |
| Fizz | DROPPED | Dealroom algorithmic estimate ($100-150M) only — no confirmed valuation at any round. CEO declined to share. |
| Butterflies | DROPPED | Both valuation and users undisclosed. Company shut down; founder pivoted to Boba Video. |
| Geneva | DROPPED | User count undisclosed. Sold to Bumble for $17.5M (down exit from $36M raised). |
| Locket | DROPPED | No valuation despite 90M downloads, 9M DAU. Profitable on $12.5M total raised. |
| Splitwise | 1 data point | 50M users @ ~$200M estimate (LOW — Sacra/inferred) |
| Headout | DROPPED | No user counts (only "tickets sold"). Revenue $130M in 2024, EBITDA profitable. |
| Layla | DROPPED | Both metrics undisclosed. 5M+ self-reported users by 2026. |
| Mindtrip | DROPPED | Both metrics undisclosed. ~$3.6M revenue, six-figure MAU. |
| Wanderlog | DROPPED | Valuation undisclosed. ~2.8M downloads, no Series A. |
| Beli | DROPPED | Valuation undisclosed. 1.1M MAU, Forbes Cloud 100 Rising Stars. |
| Venmo | 3 data points (corrected) | ARK $38B/40M users, MS $45B/70M users, Bernstein $5B/64M MAU. User counts now match PayPal 10-K filings. |

## v2 Corrections

1. **Partiful $400M → $140M**: The $400M was claimed by anonymous Twitter account "Arfur Rock" and explicitly disputed by a Partiful spokesperson (Newcomer newsletter). Last confirmed valuation: $140M post-money (Series A1, Nov 2022, a16z led, per TechCrunch/PitchBook).
2. **Fizz dropped**: No confirmed valuation exists. Dealroom's $100-150M is an algorithmic model estimate, not a round valuation.
3. **Venmo user counts corrected**: ARK (2020): 40M active accounts per PayPal 10-K, not 60M. MS (2021): 70M per 10-K, not 80M. Bernstein (2025): 64M MAU per PayPal Investor Day, not 90M.

## Key Ranges (v2)

All ranges are now computed dynamically in the HTML. The JavaScript recalculates P25/Median/P75 from the corrected data arrays.

### Bucket A: $/Download (18 data points)

Ranges shift slightly from v1 (P25 ~$16, Median ~$42, P75 ~$200). Dropping Fizz ($125/download) lowers the median slightly.

### Bucket B: $/MAU (14 data points)

Significant shifts:
- Partiful drops from $800/MAU to $280/MAU (more realistic)
- Venmo ARK rises from $633 to $950/MAU (fewer users, same valuation)
- Venmo Bernstein rises from $56 to $78/MAU

The overall median should be more grounded with Partiful no longer as an extreme outlier.

## Investor Narrative (updated)

**The pitch:** "At 500K downloads, comparable companies were worth $8M–$100M. At 1M MAU, they were worth $78M–$475M."

**Strongest comps for Tryps:**
1. **Partiful** — Event invites, 500K MAU, $140M confirmed. Closest category match for group coordination. The actual current valuation is likely higher given 400% YoY MAU growth.
2. **BeReal** — Social, 300K DAU at Series A, $150M. Proves small but engaged user bases command premiums.
3. **AllTrails** — Travel/outdoor, 9M users, $75M. Shows travel apps can build massive user bases.
4. **Instagram Series A** — 1.75M MAU, $25M. Classic early-stage social comp.

**Warning:** The AI premium (Poke, Perplexity) and Venmo bubble-era estimates inflate the range. When presenting, use the consumer social/travel sub-range for the "grounded" case and the full range for the "with AI/fintech tailwinds" case.

## Data Quality Notes

- **HIGH reliability:** 26 of 32 data points (81%)
- **LOW reliability:** 2 points (Partiful — temporal mismatch; Splitwise — Sacra estimate)
- **ANALYST_ESTIMATE:** 3 points (Venmo — ARK, Morgan Stanley, Bernstein)
- **BeReal DAU caveat:** 2 data points use DAU (stricter than MAU). The actual $/MAU would be lower for these.

## Files

- `valuation-charts.html` — Interactive HTML page with milestone tables, comp tables, scatter plots, calculator
- `master-funding-round-comps.csv` — Raw data with all 38 rows (32 usable + 6 excluded)
- `session-2-prompt.md` — Original prompt for this analysis
