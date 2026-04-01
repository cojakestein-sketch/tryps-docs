# The Path to the Plane — Pressure Test

**Date:** April 1, 2026
**Author:** Jake (via Claude), pressure-testing Marty's March 31 analysis
**Status:** v1 — assumptions challenged, three scenarios modeled

---

## What Marty Said (Original Model)

| Assumption | Marty's Number |
|-----------|---------------|
| GMV per paying user | $500/year |
| Blended take rate | 12% |
| Revenue per paying user | $60/year |
| Paid conversion (% of total users who transact) | 25% |
| Revenue per total user | $15/year |
| Net operating margin | 35% |
| Jake's ownership | 85% |
| **Jake's take per total user** | **$4.46/year** |

### Marty's Tiers

| Tier | Lifestyle | Users Needed | Revenue | Jake's Take |
|------|-----------|-------------|---------|-------------|
| 1 | First Class Everywhere | 34K | $510K | $150K |
| 2 | NetJets Card | 112K | $1.68M | $500K |
| 3 | Own a Plane + 6 Friends | 1.08M | $16.2M | $4.8M |
| 4 | The Fleet | 5.8M | $87M | $26M |

---

## THE PRESSURE TEST

### Assumption 1: $500 GMV Per Paying User

**Verdict: FAIR — actually conservative if anything.**

| Benchmark | GMV/User |
|-----------|----------|
| Booking.com (mature) | $550–$1,230/user |
| Airbnb | ~$295/user |
| Hopper | ~$214/user |

Group trips skew higher in AOV — a single trip involves flights ($400–$1,200) + hotel ($500–$2,000) + activities ($100–$300). One trip through Tryps could easily be $1,000–$3,000 in bookable GMV.

**But:** Early on, Tryps only books flights (via Duffel). Hotels and activities come later. Flight-only GMV per booking user might be $350–$700/year.

| Scenario | GMV/Paying User |
|----------|----------------|
| Bear | $400 (flights only, 1 trip/year) |
| Base | $500 (flights + some hotels) |
| Bull | $700 (full trip: flights + hotels + activities) |

**Score: Marty gets a pass here.** $500 is defensible at maturity. But it's $300–$400 in year 1 when you only have flights.

---

### Assumption 2: 12% Blended Take Rate

**Verdict: OVERSTATED. This is the biggest hole in the model.**

Here's what Tryps actually earns on each category:

**Flights via Duffel:**
- Duffel charges you $3 + 1% per confirmed order
- Airlines pay zero commission to OTAs now (the 7–10% era is over)
- Your margin = whatever service fee/markup you add on top
- Realistic margin: $15–$25 per flight booking = **3–5% effective take rate on a $500 flight**
- Marty said 5–8%. The reality is closer to 3–5% unless you're adding aggressive markups that hurt conversion.

**Hotels (future):**
- New platforms get 10–15% commission (Booking.com gets 15–18% because of scale)
- Affiliate model (reselling Booking/Expedia inventory): 4–8%
- Direct supplier deals: 10–15%
- **Realistic for Tryps: 10–15%**

**Activities (future):**
- Affiliate (Viator, GetYourGuide): 5–8%
- Direct supplier deals: 15–25%
- **Realistic for Tryps: 5–10% via affiliate, 15–20% if direct**

**Blended take rate depends on GMV mix:**

| Category | % of GMV | Take Rate | Weighted |
|----------|----------|-----------|----------|
| Flights | 60% | 4% | 2.4% |
| Hotels | 30% | 12% | 3.6% |
| Activities | 10% | 8% | 0.8% |
| **Blended** | | | **6.8%** |

For comparison, actual public companies:

| Company | Blended Take Rate |
|---------|------------------|
| Booking Holdings | 14.3% (dominated by hotels at 15–18%) |
| Airbnb | 13.6% (accommodation-only, guest + host fees) |
| Expedia | 12.3% (merchant model + ads) |
| Hopper | 9–11% (flights + fintech products) |

**Booking Holdings and Airbnb are 80%+ accommodation.** Their take rates don't apply to a flight-heavy platform. Hopper (which is flight-heavy like Tryps) is 9–11%, and a chunk of that comes from fintech products (price freeze, cancel-for-any-reason), not pure booking commission.

| Scenario | Blended Take Rate |
|----------|------------------|
| Bear | 5% (flight-heavy, affiliate model) |
| Base | 8% (balanced mix, some direct hotel deals) |
| Bull | 12% (Marty's number — requires hotel-heavy GMV and direct supplier deals) |

**Score: Marty is too optimistic.** 12% is achievable only if Tryps becomes accommodation-heavy with direct supplier relationships. For the next 2–3 years, 6–9% is more realistic.

---

### Assumption 3: 25% Paid Conversion (Users Who Book Through Tryps)

**Verdict: SIGNIFICANTLY OVERSTATED. This is the existential risk.**

**The planning-to-booking gap is the graveyard of travel startups.**

| Platform | Planning-to-Booking Conversion |
|----------|-------------------------------|
| TripAdvisor | ~2–5% (most users research, then book elsewhere) |
| Wanderlog | Very low (planning tool, minimal booking) |
| Google Travel | Near 0% (planning only) |
| Hopper (booking-first) | ~42% first-month transaction rate |
| General travel website | 2.6% mobile, 7.6% desktop |

The difference: **Hopper is booking-first with planning layered on.** Tryps is planning-first (group chat coordination) with booking coming later in the flow. That's the TripAdvisor pattern, not the Hopper pattern.

**Tryps' advantage:** The iMessage agent can actively push users toward booking IN the conversation. "Greece it is — I'll pull flights." That's higher-intent than TripAdvisor's passive model. But the friction is real: the user still has to enter payment info, agree on dates, etc.

| Scenario | % of Total Users Who Book Through Tryps |
|----------|-----------------------------------------|
| Bear | 8% (planning-first, most book elsewhere) |
| Base | 15% (agent-driven conversion, moderate success) |
| Bull | 25% (Marty's number — best-in-class for a planning tool) |

**Score: Marty's 25% is the absolute ceiling, not the expected case.** 10–15% is more realistic. This 2–3x difference cascades through the entire model.

---

### Assumption 4: 35% Net Operating Margin

**Verdict: OVERSTATED at these revenue scales.**

| Company | Revenue | Operating Margin |
|---------|---------|-----------------|
| Booking Holdings | $23.7B | ~32% |
| Airbnb | $11.1B | 22–23% |
| Expedia | $13.6B | ~13% |
| Hopper | ~$700–$850M | **Negative** |

Booking Holdings crossed 30% margins at **$15B+ revenue**. Airbnb is approaching 25% at $11B. At the scales Tryps is modeling ($1M–$100M), margins look very different:

**Costs Marty didn't account for:**
- **LLM API costs:** Every trip involves multiple Claude/GPT calls. At $0.50–$3.00 per trip facilitation, this is a significant COGS line item.
- **Customer acquisition:** Even with viral loops, you need some paid acquisition. Travel CAC is $5–$25/install.
- **Engineering team:** 4+ devs at $100K–$200K = $400K–$800K/year minimum.
- **Duffel platform fees:** $3 + 1% per order + search costs.
- **Payment processing:** 2.9% + $0.30 per transaction (Stripe).

**Realistic margins by revenue scale:**

| Revenue | Operating Margin |
|---------|-----------------|
| <$1M | Negative (burning cash) |
| $1M–$5M | -20% to 5% |
| $5M–$20M | 5% to 15% |
| $20M–$50M | 15% to 25% |
| $50M+ | 20% to 30% |
| $500M+ | 25% to 35% |

| Scenario | Operating Margin |
|----------|-----------------|
| Bear | 12% (heavy LLM + acquisition costs, sub-$20M revenue) |
| Base | 20% (moderate scale, some operating leverage) |
| Bull | 30% (significant scale, direct traffic, optimized costs) |

**Score: 35% is a destination, not a starting point.** For the revenue scales in Tiers 1–3, 15–25% is more realistic.

---

### Assumption 5: 85% Ownership

**Verdict: ONLY VALID IF BOOTSTRAPPED.**

Standard VC dilution:

| Round | Dilution | Jake's Ownership After |
|-------|----------|----------------------|
| Start | 0% | 100% |
| Seed ($1–$3M) | 15–25% | 75–85% |
| Series A ($5–$15M) | 15–25% | 56–72% |
| Series B ($15–$40M) | 10–20% | 45–65% |
| Series C+ | 10–15% | 38–58% |

**The paradox:** To reach Tier 3–4 user counts (1M–6M), you almost certainly need to raise multiple rounds. But raising dilutes ownership, which increases the users needed.

| Scenario | Ownership | Funding Context |
|----------|-----------|-----------------|
| Bear | 55% (post-Series A, brought on cofounder) |
| Base | 70% (post-Seed, lean operation) |
| Bull | 85% (bootstrapped or minimal angel round) |

**Score: 85% is only realistic for Tiers 1–2. By Tier 3–4, Jake likely owns 50–70%.**

---

### Assumption 6: The Aviation Costs

**Verdict: Roughly correct. Minor adjustments.**

| Item | Marty's Estimate | Actual Range | Verdict |
|------|-----------------|-------------|---------|
| First Class int'l RT | $12K | $8K–$15K | Fair |
| NetJets 25-hr Phenom 300 | $280K | $215K–$280K | Slightly high (depends on blackout flexibility) |
| NetJets Citation XLS 25-hr | $350K | ~$225K–$300K | High |
| Challenger 350 purchase | $27M | $17M–$27M (new $26–27M, used $17–23M) | Correct for new |
| Challenger 350 annual ops | $1.5M + $600K | $1.25M–$1.95M + $600K | Fair |
| G650ER purchase | $70M | $40M–$78M (new production ended Feb 2025) | Correct for new |
| G650ER annual ops | ~$5M/plane | $3.6M–$5M | Fair |
| Citation Latitude | $20M | $17.5M–$20M | Slightly high |

**One thing Marty missed: TAXES.**

Jake's "take" is pre-tax. At these income levels:

| Jake's Pre-Tax Take | Effective Tax Rate | After-Tax |
|---------------------|-------------------|-----------|
| $150K | ~30% | $105K |
| $500K | ~35% | $325K |
| $4.8M | ~38% | $2.98M |
| $26M | ~40% | $15.6M |

**This means the user counts need to be ~1.5–1.7x higher to fund the same lifestyle after tax.** Or Jake structures compensation through the company (the plane is a company asset, flights are business expenses). That changes the math significantly — but requires the revenue to justify it.

---

## THE THREE SCENARIOS

### Revenue Per Total User (the core multiplier)

| Variable | Bear | Base | Bull | Marty |
|----------|------|------|------|-------|
| GMV/paying user | $400 | $500 | $700 | $500 |
| Blended take rate | 5% | 8% | 12% | 12% |
| Rev/paying user | $20 | $40 | $84 | $60 |
| Paid conversion | 8% | 15% | 25% | 25% |
| Rev/total user | $1.60 | $6.00 | $21.00 | $15.00 |
| Operating margin | 12% | 20% | 30% | 35% |
| Profit/total user | $0.19 | $1.20 | $6.30 | $5.25 |
| Jake's ownership | 55% | 70% | 85% | 85% |
| **Jake's take/user** | **$0.11** | **$0.84** | **$5.36** | **$4.46** |

---

## RECALCULATED TIERS

### Tier 1: First Class Everywhere ($150K/year to Jake)

| Scenario | Total Users | Paying Users | Annual Revenue |
|----------|-------------|-------------|---------------|
| **Bear** | **1.36M** | 109K | $2.18M |
| **Base** | **179K** | 27K | $1.07M |
| **Bull** | **28K** | 7K | $588K |
| Marty | 34K | 8.5K | $510K |

Bear case: You need Wanderlog-scale to fly first class. That's a real company.
Bull case: 28K users, very achievable — Marty was close here.

### Tier 2: NetJets Card Life ($500K/year to Jake)

| Scenario | Total Users | Paying Users | Annual Revenue |
|----------|-------------|-------------|---------------|
| **Bear** | **4.55M** | 364K | $7.27M |
| **Base** | **595K** | 89K | $3.57M |
| **Bull** | **93K** | 23K | $1.96M |
| Marty | 112K | 28K | $1.68M |

Bear case: You need Airbnb-scale user count. Unlikely without massive fundraising (which dilutes ownership further).
Base case: 595K users — achievable for a successful consumer app but not trivial.

### Tier 3: Own a Plane + 6 Friends ($4.8M/year to Jake)

| Scenario | Total Users | Paying Users | Annual Revenue |
|----------|-------------|-------------|---------------|
| **Bear** | **43.6M** | 3.49M | $69.8M |
| **Base** | **5.71M** | 857K | $34.3M |
| **Bull** | **896K** | 224K | $18.8M |
| Marty | 1.08M | 270K | $16.2M |

Bear case: Basically impossible at 85% ownership. You'd need to raise heavily, diluting to 40–50%, which pushes the number even higher. Circular trap.
Base case: 5.7M users — this is Partiful-level scale with monetization. Ambitious but not impossible.
Bull case: Under 1M users — Marty's model was close because his assumptions ARE the bull case.

### Tier 4: The Fleet — Go Anywhere, Send Anyone ($26M/year to Jake)

| Scenario | Total Users | Paying Users | Annual Revenue |
|----------|-------------|-------------|---------------|
| **Bear** | **236M** | 18.9M | $378M |
| **Base** | **30.9M** | 4.64M | $186M |
| **Bull** | **4.85M** | 1.21M | $102M |
| Marty | 5.8M | 1.45M | $87M |

Bear case: More users than Booking.com. Not happening at 55% ownership.
Base case: 31M users — this is a top-10 travel app globally. Possible but generational.
Bull case: ~5M users — Marty's ballpark. Requires everything going right.

---

## THE FULL MAP (Revised)

### Bear Case (Realistic Floor)
| Tier | Users | Revenue | Jake's Take |
|------|-------|---------|-------------|
| First Class | 1.36M | $2.18M | $150K |
| NetJets | 4.55M | $7.27M | $500K |
| Own Plane | 43.6M | $69.8M | $4.8M |
| The Fleet | 236M | $378M | $26M |

### Base Case (Realistic Middle)
| Tier | Users | Revenue | Jake's Take |
|------|-------|---------|-------------|
| First Class | 179K | $1.07M | $150K |
| NetJets | 595K | $3.57M | $500K |
| Own Plane | 5.71M | $34.3M | $4.8M |
| The Fleet | 30.9M | $186M | $26M |

### Bull Case (Everything Goes Right)
| Tier | Users | Revenue | Jake's Take |
|------|-------|---------|-------------|
| First Class | 28K | $588K | $150K |
| NetJets | 93K | $1.96M | $500K |
| Own Plane | 896K | $18.8M | $4.8M |
| The Fleet | 4.85M | $102M | $26M |

### Marty's Original (For Comparison)
| Tier | Users | Revenue | Jake's Take |
|------|-------|---------|-------------|
| First Class | 34K | $510K | $150K |
| NetJets | 112K | $1.68M | $500K |
| Own Plane | 1.08M | $16.2M | $4.8M |
| The Fleet | 5.8M | $87M | $26M |

---

## WHAT MARTY GOT WRONG

1. **Take rate (12%):** The biggest error. Flights earn 3–5%, not 5–8%. Blended rate for a flight-heavy platform is 6–9%, not 12%. This alone doubles the required user count.

2. **Paid conversion (25%):** Planning-first apps convert 2–8% of users to bookings. 25% is world-class. Realistic: 10–15%. Combined with the take rate error, this 2x multiplies into a 4–6x undercount of required users.

3. **Operating margin (35%):** This is Booking.com at $23B revenue, not Tryps at $1–$50M. At realistic revenue scales, 15–25% is the range.

4. **Ownership (85%):** Valid only if bootstrapped. Reaching Tier 3–4 almost certainly requires fundraising, which drops ownership to 50–70%.

5. **Taxes:** Not modeled. Jake needs 1.5–1.7x the stated numbers to fund post-tax lifestyle spend. (Unless the plane is a company asset — then different math.)

## WHAT MARTY GOT RIGHT

1. **$500 GMV per paying user:** Actually conservative for group trips. Good number.

2. **Aviation cost estimates:** Within 10–20% on most items. Close enough.

3. **The narrative:** The viral loop (trip invite = user acquisition) IS the key to making the economics work. Near-zero CAC is what makes 20–35% margins possible at scale.

4. **Partiful comp:** Partiful at 5M+ users with monetization WOULD put Tryps into Tier 3–4 territory in the bull case. That comparison is valid.

---

## THE HONEST TAKE

**Tier 1 (First Class) is very achievable.** Even in the base case, 179K users gets you there. That's a successful niche app. In the bull case, 28K users — that's achievable pre-fundraise.

**Tier 2 (NetJets) requires a real company.** Base case needs 595K users. That's Partiful-level engagement with monetization turned on. Achievable but requires significant execution.

**Tier 3 (Own Plane) is "we won" territory.** Base case needs 5.7M users at $34M revenue. That's a top-tier consumer travel company. The bear case (43.6M users) shows this is unreachable with bad unit economics.

**Tier 4 (The Fleet) is generational.** Even the bull case needs 4.85M users. The base case needs 30.9M. This is a publicly traded company. Not impossible — but not a 5-year plan.

**The single most important lever:** Paid conversion rate. Moving from 8% (bear) to 15% (base) to 25% (bull) is the difference between needing 1.36M users and 28K users for first class. The iMessage agent's ability to seamlessly convert group chat planning into actual bookings IS the entire business model.

**Second most important lever:** Hotel and activity booking. Flights are a low-margin loss leader. Hotels at 12–15% commission are where the real take rate comes from. The faster Tryps adds hotel and activity booking, the faster the unit economics improve.

---

## WHAT JAKE SHOULD DO WITH THIS

1. **Don't show Marty's original numbers to investors.** They'll pressure test the same assumptions and find the same holes. Use the base case instead — it's still a compelling story.

2. **Track paid conversion obsessively.** This is the number that determines which scenario you're living in. Instrument it from day one.

3. **Add hotel booking ASAP.** Flights are a 3–5% margin business. Hotels are 12–18%. Your blended take rate (and therefore your entire lifestyle model) depends on becoming accommodation-heavy.

4. **Consider the "company plane" path.** At Tier 3, if the Challenger is a company asset for business travel (visiting partners, team offsites), the tax math is very different. You don't need $4.8M personal take — you need $4.8M in company budget allocated to executive travel. That's achievable at lower revenue.

5. **The bear case is not the plan — it's the warning.** If paid conversion stays at 8% and take rate stays at 5%, you need 1.36M users just to fly first class. The product has to solve the planning-to-booking gap or none of this works.

---

*Next step: Build an interactive calculator (like the valuation-charts.html) where Jake can drag sliders on each assumption and see the tiers update in real time.*
