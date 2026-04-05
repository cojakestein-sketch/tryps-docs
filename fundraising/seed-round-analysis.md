# Tryps Seed Round Analysis: The Case for $3M

**Date:** April 5, 2026
**Author:** Jake Stein (via Claude)
**Status:** Draft — internal strategic document, not investor-facing

---

## Executive Summary

Tryps is raising $3M in a Seed round to transition from a working demo to a launched, growing consumer product. This document breaks down how $3M is spent, what it buys, what milestones it enables, and whether it positions Tryps for a strong Series A in 12-18 months.

**The thesis in one sentence:** $3M buys Tryps a real team, a real launch, and 12-18 months to prove the viral loop works before going back to market for a Series A at $25-50M.

---

## 1. Monthly Burn Rate Breakdown

### Target Monthly Burn: $175K-$200K

This gives 15-17 months of runway at $3M, which is the minimum investors expect at Seed.

| Category | Monthly Cost | % of Burn | Notes |
|----------|-------------|-----------|-------|
| **Engineering (Full-Time)** | $85,000 | 44% | 3 US-based engineers + 1-2 offshore |
| **GTM / Marketing** | $35,000 | 18% | Creator programs, campus, ASO, content |
| **Operations / Founder** | $20,000 | 10% | Jake's salary (modest) |
| **Design** | $12,000 | 6% | 1 full-time product designer |
| **Infrastructure** | $15,000 | 8% | Supabase, Hetzner, Duffel, LLM APIs, Linq, Stripe |
| **Legal / Admin / Insurance** | $8,000 | 4% | Corporate counsel, D&O, IP, employment law |
| **Community / Support** | $8,000 | 4% | Community manager / CS (part-time to start) |
| **Office / Travel** | $5,000 | 3% | Coworking, travel for events/partnerships |
| **Miscellaneous / Buffer** | $7,000 | 4% | Unexpected costs, tools, subscriptions |
| **Total** | **$195,000** | **100%** | |

### Engineering Breakdown (the $85K/mo line)

| Role | Location | Monthly Cost | Notes |
|------|----------|-------------|-------|
| Senior Full-Stack Engineer #1 | US (NYC/remote) | $18,000 | $215K/yr all-in (salary + benefits + taxes) |
| Senior Full-Stack Engineer #2 | US (NYC/remote) | $18,000 | $215K/yr all-in |
| Mobile Engineer (React Native/Expo) | US (remote OK) | $16,000 | $190K/yr all-in |
| Asif (Lead Dev, retained) | Pakistan (contractor) | $8,000 | Current lead, knows the codebase |
| Nadeem or Rizwan (retained) | Pakistan (contractor) | $5,000 | Keep at least one current dev |
| Agent/AI Engineer | US or senior offshore | $14,000 | $165K/yr or $14K/mo contract |
| Engineering tools & services | -- | $6,000 | CI/CD, monitoring, testing, dev tools |
| **Total Engineering** | | **$85,000** | |

**Why 2-3 US engineers at these rates?**
- 2025-2026 NYC market rate for senior full-stack: $180-250K base salary. All-in (salary + benefits + payroll tax + equity) is $200-280K. $215K all-in is competitive but not top-of-market -- you attract people who want early-stage equity upside.
- Remote US engineers are 10-15% cheaper than NYC-based. $190K for a strong mobile engineer is market rate.
- Keeping Asif at $8K/mo is a bargain for someone who knows the entire codebase and manages QA. He's worth 3x that in a US market.

### Infrastructure Breakdown (the $15K/mo line)

| Service | Monthly Cost | Notes |
|---------|-------------|-------|
| Supabase (Pro/Team) | $2,500 | Database, auth, storage, edge functions |
| Hetzner (Marty + agent infra) | $500 | Current server + scaling |
| LLM API costs (Claude/GPT) | $5,000 | Critical: every trip facilitation = $0.50-$3.00 in API calls |
| Duffel (flight search + booking) | $2,000 | $3 + 1% per order, plus search API costs |
| Linq (iMessage infrastructure) | $1,500 | iMessage agent delivery |
| Stripe (payment processing) | Variable | 2.9% + $0.30 per transaction (comes out of revenue) |
| Monitoring / Sentry / Analytics | $1,500 | Error tracking, analytics, performance monitoring |
| Apple Developer + misc | $500 | App Store, domain, email, misc SaaS |
| Scaling buffer | $1,500 | LLM costs scale with users; this absorbs growth |
| **Total** | **$15,000** | |

**LLM API costs are the wildcard.** At 10K MAU with 3-5 agent interactions per user per month, you're looking at 30-50K API calls. At $0.05-$0.10 per call (Claude Haiku/Sonnet mix), that's $1,500-$5,000/mo. At 50K MAU, this could hit $10-25K/mo. This needs to be modeled carefully and is a key cost to optimize.

### Marketing Breakdown (the $35K/mo line)

| Channel | Monthly Budget | Notes |
|---------|---------------|-------|
| TikTok nano/micro creator program | $12,000 | 15-20 creators at $50-75/video, 2-3 videos/week |
| Campus ambassador program | $6,000 | 10-15 campuses, $400/mo/ambassador + event budget |
| Paid social (Meta + TikTok ads) | $5,000 | Retargeting proven audiences, testing creative |
| ASO + App Store optimization | $2,000 | Keyword optimization, screenshot A/B testing |
| Content / SEO | $3,000 | Programmatic travel guides, blog content |
| PR / earned media | $2,000 | Freelance PR consultant, press kit maintenance |
| Events / partnerships | $3,000 | Bridal expos, travel events, university partnerships |
| Referral program credits | $2,000 | $10 flight credit per successful referral (post 5K users) |
| **Total** | **$35,000** | |

**Key marketing insight from the path-to-100K analysis:** The #1 "marketing" investment is actually engineering -- making the invite flow so good that K-factor > 0.5. Every dollar spent on acquisition is multiplied by the viral loop. At K=0.4, every 60K direct downloads becomes 100K total. At K=0.6, every 40K direct becomes 100K. The marketing budget is supplementary to the product-led growth loop, not a replacement for it.

---

## 2. 12-Month Total Budget

### How $3M Allocates Over 15 Months

| Quarter | Monthly Burn | Quarterly Spend | Cumulative | Notes |
|---------|-------------|-----------------|-----------|-------|
| Q1 (Mo 1-3) | $155K | $465K | $465K | Hiring phase, lower burn. Team building + launch prep |
| Q2 (Mo 4-6) | $190K | $570K | $1,035K | Full team ramped, App Store launch, initial marketing |
| Q3 (Mo 7-9) | $205K | $615K | $1,650K | Growth phase, scaling marketing spend on proven channels |
| Q4 (Mo 10-12) | $215K | $645K | $2,295K | Peak growth, preparing Series A metrics |
| Q5 (Mo 13-15) | $215K | $645K | $2,940K | Runway buffer -- either raising Series A or optimizing |

**Total runway: ~15 months at average $196K/mo burn**

### Budget Allocation Summary (12-Month View)

| Category | 12-Month Total | % |
|----------|---------------|---|
| Team (engineering + design + ops) | $1,404,000 | 60% |
| Marketing / Growth | $420,000 | 18% |
| Infrastructure | $180,000 | 8% |
| Legal / Admin | $96,000 | 4% |
| Community / Support | $96,000 | 4% |
| Office / Travel | $60,000 | 3% |
| Buffer / Contingency | $84,000 | 4% |
| **Total** | **$2,340,000** | **100%** |

**Remaining $660K** is the 3-month runway buffer (months 13-15). This is critical -- you never want to raise from a position of zero runway. The Series A process takes 3-6 months; having 3+ months of buffer when you start fundraising is table stakes.

### Burn Ramp Rationale

Burn starts at $155K/mo and ramps to $215K/mo because:
- **Month 1-3:** You're hiring, not spending on marketing. Engineering salaries start staggering in as offers close. Marketing is $10K/mo (launch prep, not acquisition).
- **Month 4-6:** Full team is onboard. App Store launch happens. Marketing ramps to $30K/mo.
- **Month 7-12:** You know which channels work. Double down on what's working. Marketing hits $40K/mo. LLM costs scale with users.

---

## 3. Key Hires / Team Changes

### The Org Chart at $3M

```
Jake Stein (CEO / Product)
|
|-- Engineering (5-6 people)
|   |-- [NEW] Senior Full-Stack #1 (US, full-time)
|   |-- [NEW] Senior Full-Stack #2 (US, full-time)  
|   |-- [NEW] Mobile Engineer (US, full-time or strong contract)
|   |-- Asif (Lead Dev, Pakistan, contract -> consider FTE conversion)
|   |-- Nadeem or Rizwan (Dev, Pakistan, contract)
|   |-- [NEW] Agent/AI Engineer (US or senior offshore, FTE or contract)
|
|-- Design (1 person)
|   |-- [NEW] Product Designer (US, full-time)
|
|-- Growth / Marketing (1-2 people)
|   |-- [NEW] Growth Lead / Head of Marketing (US, full-time)
|   |-- Creator program managed by Growth Lead (outsourced execution)
|
|-- Community (1 person)  
|   |-- [NEW] Community Manager (part-time -> full-time)
|
|-- GTM Contractors (retained, project-based)
|   |-- Sean DeFaria (creative direction)
|   |-- Abdullah Malik (content/video)
|   |-- Enej Stanovnik (GTM infra)
|   |-- Arun (SEO/GEO)
|
|-- QA (retained from current team, offshore)
|   |-- 1-2 QA testers (Aman/Sarfaraz/Zain, part-time contract)
```

**Total headcount: 10-12 people (6 FTE + 4-6 contractors)**

### Hire Priority Order

| Priority | Role | When | Salary Range (all-in) | Why |
|----------|------|------|----------------------|-----|
| 1 | Senior Full-Stack Engineer | Month 1 | $200-230K | Core product velocity. Someone who can own features end-to-end. |
| 2 | Growth Lead | Month 1-2 | $130-160K | You need someone running user acquisition from day one. Not a VP Marketing -- a hands-on growth operator. |
| 3 | Product Designer | Month 2-3 | $140-170K | The app needs to look so good people screenshot it. Trip cards, invite flow, App Store screenshots -- design is marketing. |
| 4 | Senior Full-Stack Engineer #2 | Month 3-4 | $200-230K | Second eng to parallelize. Now you have enough people to ship multiple workstreams simultaneously. |
| 5 | Agent/AI Engineer | Month 3-5 | $165-200K | Someone who lives in the LLM/agent space. Owns the intelligence layer that makes Martin feel human. |
| 6 | Mobile Engineer | Month 4-6 | $175-210K | Dedicated Expo/React Native person. Nadeem can't do everything. |
| 7 | Community Manager | Month 4-6 | $60-80K | Manages beta community, creator relationships, user feedback pipeline. Can start part-time. |

### What Happens to Current Contractors

| Person | Recommendation | Rationale |
|--------|---------------|-----------|
| **Asif** | RETAIN. Raise rate to $8-10K/mo. Discuss equity grant. | He knows the entire codebase. At $8K/mo he's 4x cheaper than a US equivalent. He manages QA. Irreplaceable in the near term. |
| **Nadeem** | RETAIN at current rate. | Solid builder. Knows the app inside out. Keep him until a US mobile engineer is fully ramped. |
| **Rizwan** | EVALUATE. Retain if agent/AI engineer hire takes time. | Strong technically, but agent layer may be better owned by a US-based AI engineer with deeper LLM experience. Keep him until that person is hired and ramped. |
| **Sean** | RETAIN as creative director (project-based). | Sean is creative talent, not a growth operator. Keep him for brand, launch video, social direction. Don't try to make him the growth lead. |
| **Cameron** | EVALUATE after 90 days. | Head of Product contractor -- currently evaluating. If strong, convert to advisor or part-time role. At $3M, Jake IS the product person. |
| **QA (Aman/Sarfaraz/Zain)** | KEEP 1-2, reduce to part-time. | QA is important but you don't need 3 testers pre-scale. Keep the best one full-time, one part-time. |
| **Abdullah, Enej, Arun** | RETAIN as needed, project-based. | These are specialist contractors. Use them when you need them (content shoots, SEO sprints, infra projects). |

### The Hard Truth About Team

At $3M, you cannot afford a full US-based team of 10+ people. The strategy is:

1. **US full-time for high-leverage roles:** Senior engineers who can own features, a growth lead who runs acquisition, a designer who makes the product beautiful.
2. **Offshore for cost efficiency:** Asif and Nadeem at $5-10K/mo are performing at a level that would cost $15-25K/mo in the US. Keep them.
3. **Contractors for flexibility:** GTM specialists (Sean, Abdullah, Enej, Arun) are project-based. You only pay when you need them.

This hybrid model is actually how most $3M seed companies operate. Pure US teams at this burn rate max out at 4-5 people and can't cover engineering + growth + design.

---

## 4. Milestones Achievable in 12 Months

### The Milestone Map

| Month | Milestone | Metric |
|-------|-----------|--------|
| 1-2 | App Store submission + approval | Live on App Store |
| 2-3 | First 500 organic users (friends, network, MIT) | 500 downloads |
| 3-4 | Creator program launches (15 creators) | 1K-3K downloads |
| 4-6 | Campus ambassador pilot (10 schools) | 5K-10K downloads |
| 6-8 | Viral loop measurement: K-factor validated | K > 0.4 target |
| 8-10 | Flight booking live end-to-end through Duffel | First revenue |
| 10-12 | Hotel booking integration (Booking.com affiliate or direct) | Expanded GMV |
| 12 | **Target: 25K-50K downloads, 8K-15K MAU** | Series A ready |

### User Acquisition: What's Realistic

**Can you get to 100K users in 12 months?** Unlikely with $420K in marketing budget. The path-to-100K analysis shows that requires $150-250K in marketing spend AND a working viral loop (K > 0.4). At $35K/mo average marketing spend over 12 months, the realistic range is:

| Scenario | Direct Downloads | K-Factor | Total Downloads | MAU (25% of downloads) |
|----------|-----------------|----------|-----------------|----------------------|
| Conservative | 15K | 0.2 | 19K | 5K |
| Base | 30K | 0.4 | 50K | 12.5K |
| Optimistic | 50K | 0.6 | 125K | 31K |

**Base case: 50K downloads, 12.5K MAU at month 12.** This is the realistic target.

**What does 50K downloads / 12.5K MAU mean for Series A?**

Using the comp data from the valuation analysis:

| Comp | Users at Fundraise | Valuation | $/User |
|------|-------------------|-----------|--------|
| Instagram Series A | 1.75M MAU | $25M | $14/MAU |
| BeReal Series A | 300K DAU | $150M | $500/DAU |
| Partiful Series A1 | 500K MAU | $140M | $280/MAU |
| Airbnb Seed | 10K users | $2-10M | $200-1000/user |

At 12.5K MAU, the Airbnb Seed comp is most relevant. At $200-$500/MAU (consumer social premium), that implies a **$2.5M-$6.25M valuation** -- too low for a compelling Series A. This is why the **optimistic case (31K MAU)** matters: at $200/MAU, that's $6.2M; at $500/MAU (with AI premium), that's $15.5M.

**The honest version:** 12.5K MAU is a respectable Seed outcome but doesn't guarantee a Series A at a great price. To raise a Series A at $25-50M, you likely need:

- **25K+ MAU** with strong engagement metrics (DAU/MAU > 30%)
- **Demonstrated viral loop** (K-factor > 0.4, measurable and growing)
- **Early revenue signal** ($5K-20K MRR from flight/hotel bookings)
- **Retention proof** (Month 3 retention > 30%)

### Revenue Milestones

Revenue comes from bookings. With Duffel live for flights:

| Month | Paying Users | Avg Booking GMV | Take Rate | Monthly Revenue |
|-------|-------------|-----------------|-----------|-----------------|
| 8 | 50 | $400 | 4% | $800 |
| 10 | 200 | $450 | 5% | $4,500 |
| 12 | 500 | $500 | 6% | $15,000 |

**Annualized MRR at month 12: ~$15K/mo = $180K ARR.** This is not meaningful revenue -- it's a signal. Investors at Series A care about the trajectory and unit economics, not the absolute number at $180K ARR.

### The Series A Story

At month 12-15, the Series A pitch is:

> "We raised $3M, built the product, launched on the App Store, and grew to 50K downloads / 12.5K MAU with a K-factor of 0.4+. We're generating $15K/mo in booking revenue with 500 paying users. Our invite-to-download conversion is 35%, proving the viral loop works. We're raising $8-15M to scale user acquisition, add hotel and activity booking, and reach 500K MAU in 18 months."

**This is a fundable Series A story IF:**
1. K-factor is genuinely > 0.4 and measurable
2. DAU/MAU ratio is > 25% (people actually use it, not just download)
3. Booking conversion shows improvement quarter-over-quarter
4. The product experience is genuinely differentiated (iMessage agent feels magical)

---

## 5. Valuation / Terms Expectations

### Valuation Range

| Scenario | Pre-Money | Post-Money | Investor Ownership |
|----------|-----------|------------|-------------------|
| Conservative | $9M | $12M | 25% |
| Target | $12M | $15M | 20% |
| Aggressive | $17M | $20M | 15% |

**Recommended target: $12-15M post-money valuation for a $3M raise.**

### Why $12-15M Post-Money

**Arguments for $12-15M:**
- Partiful raised at $140M post-money with 500K MAU. Tryps is pre-launch, so a 10x discount puts you at $14M -- aligned.
- Poke raised $15M Seed at $100M valuation, but that was an extreme outlier (General Catalyst, AI hype). Not a realistic comp for most founders.
- Median 2025-2026 Seed round valuations in consumer social are $8-15M post-money for pre-launch companies with a working demo. (Pre-demo is $4-8M.)
- The AI premium is real but waning. In 2024, "AI" added 2-3x to valuation. In 2026, investors want to see AI that does something specific and useful, not just "AI-powered."

**Arguments against going higher ($20M+):**
- Pre-revenue, pre-launch. No traction data to justify $20M+.
- $20M+ post-money means you need to demonstrate $100M+ potential very quickly -- that's 500K+ MAU at Series A. Risky to set that expectation.
- Higher valuation = higher bar for Series A markup. If you raise at $20M and only get to 25K MAU, your Series A is a flat or down round.

**Arguments against going lower ($8-10M):**
- Too much dilution. At $3M on $8M post-money, Jake gives up 37.5%. Combined with future rounds, ownership drops below 50% too fast.
- The demo is real and impressive. iMessage agent + mobile app + voice calls + flight booking pipeline -- this is more built than most $8M seed companies.

### Structure: SAFE vs. Priced Round

| Factor | SAFE | Priced Round |
|--------|------|-------------|
| Speed | Faster (no board negotiation) | Slower (term sheet, board formation) |
| Cost | $5-10K legal | $25-50K legal |
| Governance | No board seat, no formal governance | Board seat, voting rights, information rights |
| Investor preference (2025-2026) | Most seed investors prefer SAFEs | Some larger seed funds prefer priced rounds |
| Founder preference | Less overhead, more flexibility | More structure, clearer cap table |

**Recommendation: SAFE with a $12-15M valuation cap and no discount, or a priced round at $12M pre-money.**

- If raising from angels + small funds ($250K-$500K checks): **SAFE**. It's faster, cheaper, and standard.
- If raising from a single lead fund writing $1.5-2M: **Priced round**. They'll want a board seat and formal governance anyway. Get it done cleanly.
- **MFN (Most Favored Nation) clause** on early SAFEs if you're raising in tranches -- standard practice.
- **Pro-rata rights** for lead investor -- standard and reasonable.

### Board Composition at Seed

If priced round:
- 3-person board: Jake, lead investor, independent (or just Jake + investor)
- Jake retains board control at Seed. No co-equal governance yet.

If SAFE:
- No formal board. Jake maintains full control.
- Investor gets information rights (monthly updates, quarterly financials).

---

## 6. Investor Profile

### Who Funds $3M Seeds in Consumer Social/Travel

#### Tier 1: Ideal Leads ($1.5-2.5M checks)

**Fund profile:** $100-300M AUM, Seed/Series A focused, consumer thesis, 10-20 investments per fund.

| Fund Type | Examples of Thesis | What They Need to See |
|-----------|-------------------|----------------------|
| Consumer social specialists | "Social coordination is undermonetized" | Partiful comp resonates. iMessage distribution is novel. Viral loop mechanics. |
| Travel-tech focused | "AI will restructure travel booking" | Duffel integration, booking pipeline, take rate model. Not another planning app. |
| AI-native consumer | "AI agents will replace apps" | The iMessage agent IS the product. Agent-first, not app-first. Technical differentiation. |
| NYC Seed funds | "Local founder, strong network, MIT connection" | Founder-market fit, personal brand, hustle metrics. |

**What they need to see from a pre-launch company to write a $3M check:**

1. **A demo that creates a genuine reaction.** The iMessage agent needs to feel magical in a live demo. If an investor adds Martin to a group chat and gets a trip planned in 5 minutes, that's the "holy shit" moment.

2. **A believable path to viral growth.** The Partiful playbook (invite = distribution) applied to trips. K-factor modeling. Trip card as viral unit.

3. **Founder-market fit.** Jake's personal story (Chile trip with Quinn), MIT connection, NYC network. Young founder building something his friends actually want.

4. **Technical moat.** Three-layer architecture (iMessage + app + agent) that nobody else has combined. Linq partnership for iMessage polling (first mover). X402 for agentic booking.

5. **Market timing narrative.** AI agents are now good enough to be useful. iMessage is an untapped distribution channel. Post-COVID travel boom continues. Partiful proved social coordination is a massive market.

6. **Not just an idea.** Working product: iMessage agent responds to texts, mobile app shows trip details, voice calls work, flight booking is in progress. This is more built than 90% of seed pitches.

#### Tier 2: Participating Investors ($100-500K checks)

| Investor Type | Why They Invest | Typical Check |
|---------------|----------------|--------------|
| Angel investors (travel industry) | Strategic value, connections to airlines/hotels | $25-100K |
| Angel investors (consumer tech operators) | Pattern recognition, advisory value | $50-250K |
| Micro-VCs ($10-50M AUM) | Portfolio diversification, early access | $100-500K |
| MIT-affiliated investors / MIT E-Fund | MIT network, founder development | $25-100K |
| Accelerator/fellowship programs | Validation, network, mentorship | $100-500K (non-dilutive or small equity) |

#### Is $3M Realistic for Pre-Revenue?

**Yes, but it's at the top of what pre-launch consumer apps raise.** Here's the landscape:

| Stage | Typical Seed Size | What You Need |
|-------|------------------|---------------|
| Idea + team, no product | $500K-$1.5M | Exceptional founder(s), hot market |
| Working prototype/demo | $1.5M-$3M | Demo that wows, clear distribution insight |
| Launched, early traction (1-5K users) | $2M-$5M | Growth metrics, retention data |
| Launched, strong traction (10K+ users) | $3M-$8M | Revenue signal, clear path to Series A |

Tryps sits in the "working prototype/demo" bucket. $3M is achievable but requires:
- A lead investor who believes in the consumer social thesis
- A demo that genuinely impresses
- Confidence that the viral loop will work (from the Partiful comp and trip invitation mechanics)

**The MIT connection matters.** The Martin Trust Center, MIT E-Fund, and the broader MIT entrepreneurship ecosystem provide:
- Warm intros to top-tier VCs
- Credibility signal (MIT accept = smart founder)
- Access to MIT alumni angels
- Potential non-dilutive funding ($50-100K from MIT programs)
- Campus as a beachhead for user acquisition (MIT + Boston schools)

**Timing consideration:** Jake enters MIT in Fall 2026. Ideally, the Seed is closed before MIT starts (by August 2026), so Jake arrives with capital and can use the MIT network for growth, not fundraising.

---

## 7. Risks and What Kills You

### Risk Matrix

| Risk | Severity | Probability | Mitigation |
|------|----------|-------------|------------|
| **Viral loop doesn't work (K < 0.2)** | FATAL | Medium | Instrument K-factor from day 1. If K < 0.2 at 5K users, pivot the acquisition strategy before burning marketing budget. |
| **iMessage platform risk (Apple restricts Linq)** | HIGH | Low-Medium | Diversify to WhatsApp, SMS. But iMessage IS the differentiation -- losing it is a major setback. |
| **Planning-to-booking gap (users plan but don't book through Tryps)** | HIGH | High | This is the existential risk. Agent must seamlessly push toward booking. "Greece it is -- let me pull flights" must feel natural, not salesy. |
| **LLM costs don't scale** | MEDIUM | Medium | Every trip = $0.50-$3.00 in API calls. At 50K MAU, LLM costs could be $25K-75K/mo. Optimize prompts, cache responses, use cheaper models for routine tasks. |
| **Hiring takes too long** | MEDIUM | High | NYC is competitive. Budget 2-3 months to fill senior eng roles. Start recruiting immediately upon close. Use contractor bridge. |
| **Founder distraction (MIT + fundraising + product)** | MEDIUM | Medium | Jake will be at MIT starting Fall 2026. Must hire a Growth Lead and strong engineers who can operate autonomously. Jake becomes strategic, not tactical. |
| **Competitor launches (Partiful adds trips, Google adds group planning)** | MEDIUM | Low-Medium | Speed matters. Being in-market first with the three-layer architecture is the moat. If Partiful adds trips, they validate the category -- which helps fundraising. |
| **Raising too much too early** | MEDIUM | Low | $3M is not "too much" -- it's right-sized for 15-17 months of runway. The risk is more about valuation: raising at $20M+ creates Series A pressure you can't meet. |
| **Team doesn't gel (US + offshore hybrid)** | LOW-MEDIUM | Medium | The current offshore team works well. New US hires need to integrate. Asif as lead dev is the bridge. Standup cadence already handles timezone gap. |
| **Regulatory risk (payments, travel agent licensing)** | LOW | Low | Travel agent licensing varies by state. Need legal review but unlikely to be a blocker for an AI-native product. |

### What Actually Kills Consumer Social Startups

Based on post-mortems of failed consumer social companies:

1. **No distribution insight.** The #1 killer. If you can't acquire users cheaply and they don't invite friends, you burn through the raise and die. Tryps' invite-per-trip mechanic is the distribution insight -- but it needs to be PROVEN, not assumed.

2. **Engagement cliff.** Users download, try once, never return. Travel is seasonal (2-4 trips/year), so the engagement floor is structurally lower than daily-use apps. Tryps needs to find reasons to bring users back between trips (travel identity, social features, trip browsing).

3. **Monetization never works.** The planning-to-booking gap killed TripAdvisor's app business, Wanderlog's revenue ambitions, and dozens of others. Tryps' agent-driven booking push is the answer -- but it's unproven.

4. **Founder burnout / distraction.** Solo founder + MIT + fundraising + building is a lot. The hire plan must create enough leverage that Jake can focus on strategy and product vision, not day-to-day bug fixing.

### Is $3M Too Much Too Early?

**No.** $3M is actually the minimum to execute this plan properly. Here's why:

- $1M gives you 6-8 months of runway with a skeleton team. Not enough time to hire, launch, grow, AND have metrics for a Series A. You'd be fundraising again in 4-5 months.
- $1.5-2M gives you 10-12 months but forces trade-offs: either hire US engineers OR spend on marketing, not both. You need both.
- $3M gives you 15-17 months: enough to hire (3 months), launch (3 months), grow (6 months), and have buffer for Series A fundraising (3 months).

**The danger of $3M is not the amount -- it's the expectations.** At $3M Seed, investors expect a Series A-ready company in 12-18 months. That means measurable growth, retention, and early revenue. Failing to meet those expectations makes the Series A very hard.

---

## 8. The Pitch for Why $3M is Right

### What $3M Unlocks That Smaller Rounds Don't

#### 1. A Real Engineering Team

At $1M, you keep the current contractor team and add maybe one US engineer. You ship incrementally but you don't level up. At $3M, you add 2-3 senior US engineers who bring experience from companies that have scaled consumer products. They've seen what works at 100K users, 1M users. They architect for scale, not just for shipping. They also bring networks that help recruiting for the Series A team.

#### 2. A Growth Function That Exists

At $1M, Jake IS the growth team. He's also the product team, the CEO, and the customer support team. At $3M, you hire a Growth Lead in month 1-2 who owns user acquisition from day one. By month 6, you have data on what channels work, what creative converts, and what the K-factor actually is. This data is what makes the Series A pitch believable.

#### 3. Design Quality That Drives Virality

Trip cards, invite links, the App Store page, social content -- all of this needs to look so good people screenshot it. At $1M, you're using Figma templates and the designer you can afford. At $3M, you hire a full-time product designer who makes Tryps feel like Partiful-level quality. This is not vanity -- design IS distribution in consumer social.

#### 4. Marketing Budget to Prove the Viral Loop

You can't measure K-factor with 200 users. You need 5K-10K users to get statistically significant data on invite-to-download conversion, trip creation rates, and referral loops. Getting to 5K-10K users requires $50-100K in acquisition spend. At $1M, that's 10-20% of your runway. At $3M, it's 3-5%. The difference between reckless and reasonable.

#### 5. Enough Runway to Not Be Desperate

Series A fundraising takes 3-6 months. If you raise $1M and burn $100K/mo, you have 10 months of runway. You start fundraising at month 4-5 with 5 months of runway. Investors smell desperation. At $3M with 15+ months of runway, you start Series A fundraising at month 10-12 with 3-5 months of buffer. You negotiate from strength.

### The Affirmative Case

> Tryps has a working product that nobody else has built: a travel agent that lives in your iMessage group chat. The iMessage agent, mobile app, voice calls, and flight booking pipeline are all functional. The brand positioning (Partiful for trips) is validated by Partiful's own $140M raise proving that social coordination is a massive market. The distribution insight (every trip invite = user acquisition) mirrors the exact growth loop that made Partiful, Venmo, and Splitwise household names.
>
> What's missing is a team that can execute at the speed this market window demands, a growth function that can prove the viral loop, and enough runway to reach Series A metrics without desperation. $3M buys all three.
>
> At $12-15M post-money, this is a bet on:
> - **The market:** Group travel is a $1.5T global market with no dominant digital-native coordinator
> - **The wedge:** iMessage distribution + agent-driven booking is a combination nobody else has
> - **The founder:** NYC-based, MIT-bound, with a working product and a team already shipping
> - **The timing:** AI agents just crossed the usefulness threshold, and iMessage is an untapped platform
>
> $3M gives Tryps 15 months to get to 50K downloads, 12.5K MAU, a K-factor > 0.4, and early booking revenue. That's a Series A at $25-50M. The return profile from $3M at $15M post-money to a $50M Series A is a clean 3.3x markup in 15 months -- exactly what seed investors underwrite.

### What $3M Does NOT Buy

Be honest about what $3M doesn't accomplish:

- **It does not get you to 100K users.** That's a Tier 2 ($250K marketing budget) outcome. $3M gets you to 25-50K users with $420K in marketing.
- **It does not make you profitable.** Revenue at month 12 is $15K/mo. You're still burning $200K/mo. Profitability requires 500K+ users.
- **It does not eliminate platform risk.** Apple could restrict Linq or change iMessage APIs. This risk exists regardless of how much you raise.
- **It does not guarantee a Series A.** If K-factor is < 0.2 and retention is poor, no amount of seed capital saves you. The product has to work.

But $3M gives you the best possible shot at proving the thesis. And if the thesis is right, the Series A is inevitable.

---

## Appendix A: Comparable Seed Rounds (2024-2026)

| Company | Round | Amount | Valuation | Stage at Raise | Category |
|---------|-------|--------|-----------|---------------|----------|
| Poke | Seed | $15M | $100M | Pre-launch, beta | AI social |
| BeReal | Seed | $30M Series A (effectively seed) | $150M | 300K DAU | Social |
| Partiful | Seed/A1 | $20M | $140M | 500K MAU | Social coordination |
| Wanderlog | Seed | ~$1.5M | Undisclosed | Early traction | Travel planning |
| Fizz | Seed | ~$4M | Undisclosed | College campuses | Social |
| Geneva | Seed | $2M | Undisclosed | Pre-launch | Community |
| **Tryps (target)** | **Seed** | **$3M** | **$12-15M** | **Pre-launch, working demo** | **Travel + AI + social** |

## Appendix B: Use of Funds Summary (Investor-Facing Version)

| Category | Allocation | Purpose |
|----------|-----------|---------|
| **Product & Engineering** | 60% ($1.8M) | Hire 3 US engineers, retain offshore team, ship flight/hotel booking, optimize invite flow |
| **Growth & Marketing** | 18% ($540K) | TikTok creators, campus ambassadors, ASO, PR, referral program |
| **Design** | 6% ($180K) | Full-time product designer, brand refinement |
| **Infrastructure** | 8% ($240K) | LLM APIs, Duffel, Linq, Supabase, scaling costs |
| **Operations** | 8% ($240K) | Legal, admin, founder salary, office, contingency |
| **Total** | **100% ($3M)** | **15-17 months of runway** |

## Appendix C: Key Assumptions to Validate

These are the assumptions that determine whether the $3M investment thesis works. Each should have a measurement plan from day one.

| Assumption | Baseline Estimate | Must-Hit Threshold | Measurement |
|------------|------------------|-------------------|-------------|
| Invite-to-download conversion | 35% | > 25% | Analytics on invite link clicks vs. downloads |
| K-factor (viral coefficient) | 0.4 | > 0.3 | Monthly cohort analysis of invites sent / new users generated |
| Day 30 retention | 25% | > 15% | Mixpanel/Amplitude cohort retention curves |
| DAU/MAU ratio | 20% | > 15% | Daily active / monthly active users |
| Planning-to-booking conversion | 12% | > 8% | Users who complete a booking / total active users |
| Trip creation rate (by invitees) | 20% | > 10% | Invitees who later create their own trip |
| LLM cost per trip facilitation | $1.50 | < $3.00 | Total LLM spend / trips facilitated |
| TikTok view-to-download rate | 0.12% | > 0.06% | Creator video views / attributed downloads |

---

*This analysis is a starting point for the fundraising process, not a finished pitch deck. The next steps are: (1) validate assumptions with the first 500 users, (2) build the pitch deck with these numbers as backbone, (3) identify and warm-intro 20-30 target investors, (4) close the round before MIT starts in Fall 2026.*
