# The Contrarian Case: Bootstrapping Tryps to Revenue

> Analysis prepared: April 5, 2026
> Scope: 12-month forward-looking scenario on $0 raised

---

## 1. Monthly Burn Rate Breakdown -- Minimum Viable Team

### Current Team Cost Estimate

The entire dev team (Asif, Nadeem, Rizwan) and QA are based in Pakistan (PKT timezone). Senior Pakistani contractors typically run $2,000-4,000/month full-time. QA contractors run $800-1,500/month each. GTM contractors vary widely.

| Role | Person | Est. Monthly Cost | Keep? | Notes |
|------|--------|-------------------|-------|-------|
| Lead Dev | Asif | $3,500 | YES | Critical -- iMessage agent, booking pipeline |
| Dev | Nadeem | $2,500 | MAYBE | Output-Backed Screen, Core Trip. Could reduce to part-time |
| Dev (Agent Layer) | Rizwan | $2,500 | YES | Agent intelligence, travel booking |
| QA (3 testers) | Aman, Sarfaraz, Zain | $3,000 total | CUT TO 1 | One QA at $1,000/mo is sufficient post-launch |
| QA (AI) | Warda | $1,200 | KEEP | Agent QA is cheap and essential |
| Creative Director | Sean | $2,000-4,000 | PAUSE | Deliverable-based, not retained monthly |
| UI/UX Designer | Arslan | $1,000-2,000 | CUT | Adhoc only, call in for specific work |
| Designer | Krisna | $1,000-2,000 | CUT | Adhoc only |
| Product Contractor | Cameron | $3,000-5,000 | CUT | Evaluating -- let go in bootstrap mode |
| Content/Video | Abdullah | $1,500-2,500 | CUT | Post-launch only |
| GTM Infra | Enej | $2,000-3,000 | CUT | Not needed until growth phase |
| SEO/AEO | Arun | $1,500-2,500 | CUT | Not needed pre-revenue |

### Infrastructure Costs

| Service | Monthly Cost |
|---------|-------------|
| Supabase (Pro) | $25-75 |
| Hetzner (Marty server) | $40-60 |
| Apple Developer Program | $8 ($99/yr) |
| Duffel API | Pay-per-booking only |
| Stripe | Pay-per-transaction only |
| ElevenLabs (voice) | $22-99 |
| Domain/DNS/Email | $20 |
| ClickUp | $10 |
| Claude/OpenAI API | $50-200 |
| Misc tools (Slack, etc.) | $50 |
| **Infrastructure Total** | **$275-600** |

### Skeleton Crew Scenarios

**Scenario A: Bare Minimum ($8,200/mo)**

| Item | Cost |
|------|------|
| Asif (lead dev, full-time) | $3,500 |
| Rizwan (agent/booking, full-time) | $2,500 |
| Warda (AI QA) | $1,200 |
| Infrastructure | $500 |
| Misc (tools, one-off design) | $500 |
| **Total** | **$8,200** |

This cuts Nadeem entirely. Asif and Rizwan handle everything. Jake does product, PM, QA coordination, and some GTM himself. One QA person for agent testing. No design, no GTM team.

**Scenario B: Lean but Functional ($12,500/mo)**

| Item | Cost |
|------|------|
| Asif (lead dev, full-time) | $3,500 |
| Rizwan (agent/booking, full-time) | $2,500 |
| Nadeem (part-time, 50%) | $1,250 |
| Warda (AI QA) | $1,200 |
| 1 QA tester | $1,000 |
| Sean (deliverable-based, ~$1,000/mo avg) | $1,000 |
| Infrastructure | $500 |
| Misc | $1,550 |
| **Total** | **$12,500** |

**Scenario C: Current Burn Estimate ($25,000-35,000/mo)**

This is roughly where you are now. The bootstrap question is: can you get from C to A or B?

**Answer: Yes, you can get under $10K/month.** But it requires cutting Nadeem, all GTM, all QA except Warda, and having Jake do significantly more product/PM/design work himself.

---

## 2. Twelve-Month Total Budget on $0 Raised

### Scenario A: Skeleton Crew ($8,200/mo)

| Item | 12-Month Total |
|------|----------------|
| Team + infra | $98,400 |
| One-off costs (App Store launch, legal, branding) | $5,000 |
| Buffer (10%) | $10,000 |
| **Total needed** | **$113,400** |

### Scenario B: Lean but Functional ($12,500/mo)

| Item | 12-Month Total |
|------|----------------|
| Team + infra | $150,000 |
| One-off costs | $5,000 |
| Buffer (10%) | $15,000 |
| **Total needed** | **$170,000** |

### Where Does the Money Come From?

| Source | Amount | Likelihood |
|--------|--------|------------|
| Personal savings / existing runway | $50K-100K? | Depends on Jake's position |
| MIT delta v accelerator (equity-free) | Up to $75,000 | HIGH if accepted (applications close Apr 1, 2026) |
| MIT Sandbox | Up to $25,000 | MEDIUM -- for student-initiated ideas |
| Revenue from bookings (see Section 3) | $0-30K in first 12 months | LOW-MEDIUM |
| Freelance/consulting income (Jake at MIT) | $0-20K | LOW -- time-constrained |
| **Total potential non-dilutive funding** | **$150K-250K** | |

**The math works on Scenario A if Jake has $50-75K in personal runway and gets MIT delta v ($75K equity-free).** That is $125-150K for a $113K budget. Tight but viable.

**The math works on Scenario B if Jake has $75-100K and gets MIT delta v.** That is $150-175K for a $170K budget. Very tight.

### MIT as a Cost Reducer

Jake going to MIT in Fall 2026 changes the equation:
- Housing covered by MIT or financial aid (reduces personal burn by $2-3K/month vs. NYC)
- Health insurance through MIT
- Access to delta v ($75K), Sandbox ($25K), EIRs, advisors, and the MIT network -- all free
- Reduced personal living costs in Cambridge vs. NYC
- **But**: Jake's time is split. He is a part-time founder during the school year.

---

## 3. Revenue Projections

### Revenue Model: Take Rate on Bookings

Tryps makes money when users book travel through the platform. Here are the real commission/markup rates:

| Product | Take Rate (Your Cut) | Source |
|---------|---------------------|--------|
| Flights (via Duffel) | 2-6% markup + ancillary commissions | You set the markup; Duffel charges $1-2.50/passenger segment |
| Hotels (affiliate) | 4-8% affiliate commission | Booking.com/Expedia affiliate programs |
| Activities/tours | 15-25% commission | Higher margin category |
| Premium features (subscriptions) | 100% (minus Stripe 2.9%+30c) | Future -- not built yet |

### Assumptions for Modeling

- **Average domestic trip**: $1,500-2,500 per person (flights $300-400 + hotels $600-1,200 + activities $200-400)
- **Average international trip**: $3,000-6,000 per person
- **Average group size**: 4-6 people
- **Average group trip total booking value**: $8,000-15,000 (4 people x $2,000-3,750 avg)
- **Blended take rate**: ~4% on flights, ~6% on hotels, ~20% on activities
- **Weighted blended take rate across all categories**: ~5-7% of total trip value
- **Realistic take rate for a new platform with mostly flights**: ~3-4%
- **Duffel cost per flight booking**: ~$2/passenger segment (deducted from your markup)
- **Stripe processing fee**: 2.9% + $0.30 per transaction (deducted from all revenue)

### Revenue Per Trip (Conservative)

Using a $10,000 average group trip value and 3.5% blended net take rate (after Duffel fees and Stripe):

**Revenue per completed group trip: ~$350**

### Scenario Modeling

| Active Users | Trips/Year per User | Total Trips/Year | Revenue/Trip | Annual Revenue | Monthly Revenue |
|-------------|---------------------|-------------------|-------------|----------------|-----------------|
| 100 | 1.5 | 150 | $350 | $52,500 | $4,375 |
| 500 | 1.5 | 750 | $350 | $262,500 | $21,875 |
| 1,000 | 1.5 | 1,500 | $350 | $525,000 | $43,750 |
| 5,000 | 1.5 | 7,500 | $350 | $2,625,000 | $218,750 |

**But "active users" means users who actually BOOK through Tryps, not just chat with the agent.** Conversion from user to booker is the critical funnel:

| Total Users | Booking Conversion | Active Bookers | Trips/Year | Annual Revenue |
|-------------|-------------------|----------------|------------|----------------|
| 1,000 | 10% | 100 | 150 | $52,500 |
| 5,000 | 10% | 500 | 750 | $262,500 |
| 10,000 | 10% | 1,000 | 1,500 | $525,000 |
| 50,000 | 10% | 5,000 | 7,500 | $2,625,000 |

### Breakeven Analysis

| Scenario | Monthly Burn | Monthly Revenue Needed | Bookers Needed | Total Users Needed (10% conv) |
|----------|-------------|----------------------|----------------|-------------------------------|
| Skeleton ($8.2K) | $8,200 | $8,200 | ~280 active bookers/yr | ~2,800 total users |
| Lean ($12.5K) | $12,500 | $12,500 | ~430 active bookers/yr | ~4,300 total users |

**Reality check**: Getting 2,800-4,300 total users who engage enough that 10% actually book trips through Tryps is achievable within 12-18 months if the product is good and distribution works. It is not achievable in the first 6 months. Expect $0-5K in revenue months 1-6 and $5-15K in months 7-12.

### First-Year Revenue Estimate (Realistic)

| Month | Users | Bookers | Revenue |
|-------|-------|---------|---------|
| 1-3 | 50-200 | 5-15 | $500-1,500 |
| 4-6 | 200-500 | 15-40 | $1,500-4,000 |
| 7-9 | 500-1,500 | 40-100 | $4,000-10,000 |
| 10-12 | 1,500-3,000 | 100-250 | $10,000-25,000 |
| **Year 1 Total** | | | **$16,000-40,500** |

**Year 1 revenue covers 10-25% of the lean budget.** You are funding the rest.

---

## 4. Key Team Changes

### The Minimum Viable Team (Bootstrap Mode)

**KEEP (non-negotiable):**

1. **Asif (Lead Dev)** -- He runs the dev team, owns the iMessage agent (the core product), and coordinates across scopes. Without Asif, the product stops. ~$3,500/mo.

2. **Rizwan (Agent Layer + Booking)** -- He owns the agent intelligence and travel booking pipeline, which is literally the revenue-generating code. Without Rizwan, you cannot make money. ~$2,500/mo.

3. **Warda (AI QA)** -- She tests the agent all day. At $1,200/mo, she is the highest-ROI person on the team. Agent quality is the product.

**REDUCE:**

4. **Nadeem** -- He owns Output-Backed Screen (7/48) and Core Trip Experience (15/16). Core Trip is nearly done. OBS is large and important for the app experience but is not revenue-critical. Options:
   - Cut to 50% ($1,250/mo) and focus only on the most critical app screens
   - Let go entirely and have Asif absorb the remaining app work
   - Keep full-time only until App Store submission (April 15), then reduce

**CUT:**

5. **All 3 QA testers (Aman, Sarfaraz, Zain)** -- Warda covers agent QA. For app QA, Jake + the dev team can test. Save $3,000/mo.

6. **Cameron (Product Contractor)** -- Jake does product. This is what a founder does. Save $3,000-5,000/mo.

7. **Sean (Creative Director)** -- Pause the retainer. Bring back on a per-deliverable basis (launch video, brand assets) at fixed prices. Save $2,000-4,000/mo.

8. **Abdullah, Enej, Arun (GTM)** -- None of these roles generate revenue until there are users. Cut all three. Save $5,000-8,000/mo combined.

9. **Arslan, Krisna (Designers)** -- Adhoc already. Formalize as project-based only. No monthly commitment.

### AI Coding Tools as Headcount Replacement

This is the strongest lever in the bootstrap case. In April 2026:
- Claude Code, Cursor, and Copilot can handle significant portions of frontend development
- Jake can use AI tools to do work that would otherwise require Nadeem
- Asif and Rizwan can each be 1.5-2x more productive with AI pair programming
- Agent testing can be partially automated

**Realistic estimate: AI tools replace 0.5-1.0 full-time developers in output.** This is the difference between needing 3 devs and needing 2.

### The Bootstrap Org Chart

```
Jake (Product / Founder / PM / GTM / Design)
├── Asif (Lead Dev -- iMessage, app, coordination)
├── Rizwan (Dev -- agent layer, booking pipeline, payments)
├── Warda (AI QA -- agent testing)
└── Marty (AI Agent -- PR reviews, state sync, automation)
```

Total human headcount: 4 (including Jake). Monthly team cost: ~$7,200.

---

## 5. Milestones Achievable in 12 Months (Bootstrapped)

### Phase 1: Ship and Stabilize (Months 1-3, Apr-Jun 2026)

- [x] App Store submission (April 15 deadline)
- [ ] Duffel flight booking live in production
- [ ] Stripe payments processing real transactions
- [ ] 50-100 beta users from personal network + MIT
- [ ] Core trip experience bug-free
- [ ] iMessage agent handles full trip lifecycle
- **Cost**: ~$25-35K (still running current team for first month, then cuts)

### Phase 2: First Revenue (Months 4-6, Jul-Sep 2026)

- [ ] First paid flight bookings through the platform
- [ ] Hotel affiliate integration (Booking.com or Expedia TAAP)
- [ ] MIT delta v accelerator (if accepted -- summer program)
- [ ] 200-500 users, 15-40 active bookers
- [ ] Organic growth from MIT + NYC social circles
- [ ] Voice agent (Linq) driving bookings
- **Cost**: ~$25-35K
- **Revenue**: ~$2,000-5,000

### Phase 3: MIT + Growth (Months 7-9, Oct-Dec 2026)

- [ ] Jake at MIT -- leveraging student network as distribution
- [ ] 500-1,500 users
- [ ] Group trip booking flow polished end-to-end
- [ ] Activity/experience booking added (higher margin)
- [ ] Word-of-mouth growth from completed trips
- **Cost**: ~$25-35K
- **Revenue**: ~$5,000-12,000

### Phase 4: Prove the Model (Months 10-12, Jan-Mar 2027)

- [ ] 1,500-3,000 users
- [ ] Consistent monthly revenue of $8-20K
- [ ] Unit economics proven (revenue per trip, CAC, retention)
- [ ] 3+ completed group trips with full booking revenue
- [ ] Decision point: raise from strength, or keep bootstrapping
- **Cost**: ~$25-35K
- **Revenue**: ~$10,000-25,000

### What You CAN Do Bootstrapped

- Ship to App Store (already on track)
- Get flight booking live (Duffel integration in progress)
- Build a user base organically through MIT and NYC networks
- Prove that group trip coordination via iMessage converts to bookings
- Generate real revenue
- Build a revenue model investors can underwrite

### What You CANNOT Do Bootstrapped

- Paid user acquisition at scale
- Hire a full-time growth/marketing team
- Build out all 13 scopes simultaneously
- Compete with funded competitors on feature velocity
- Move faster than organic growth allows

---

## 6. The Case AGAINST Raising

### 1. Raising Before PMF Is the Most Common Way to Die

The graveyard of consumer apps is full of companies that raised $2-5M pre-PMF, hired 15 people, burned through cash building features nobody used, and died. Raising money creates the illusion of progress. Revenue creates actual progress.

Tryps does not have PMF yet. The product works in demo. Nobody has booked a real trip through it. Until a stranger (not a friend, not a tester) plans and books a trip via iMessage and says "this is better than doing it myself," you do not have PMF.

**Raising before that moment means you are selling a vision, not a product.** You will raise at a lower valuation, give up more equity, and spend the money on things that do not matter yet.

### 2. Dilution Math Is Brutal at Pre-Revenue

Current market for pre-revenue consumer apps: $3-8M valuation cap on a SAFE. If you raise $500K at a $5M cap, you are giving up 10% of the company for money you might not need.

If you wait 12 months, prove revenue, show 1,000+ users and $20K/mo in booking revenue, you could raise at a $15-25M cap. That same $500K costs you 2-3% instead of 10%.

**The dilution difference between raising now and raising in 12 months could be 7-8% of the company.** At a $100M outcome, that is $7-8M in founder equity.

### 3. Investor Pressure Distorts Product Decisions

With VC money comes board seats, quarterly reviews, growth expectations, and the pressure to show metrics. Consumer social apps need time to find their organic shape. Instagram spent two years as Burbn before pivoting. Twitter was a side project at Odeo. Partiful grew organically for years before their Series A.

**Investors will push you to grow faster than the product can support.** For a product that lives in iMessage (where trust and word-of-mouth are everything), forced growth through paid acquisition could actually hurt the brand.

### 4. The Contractor Team Structure Does Not Justify VC

VCs invest in teams. Your team is 11 contractors, most based in Pakistan, with no full-time employees. This is not a criticism -- it is a cost advantage. But investors will see it as a risk. They will push you to hire full-time engineers in the US at $150-200K/year each.

**Raising money forces you to change the team structure to one that costs 5-10x more.** Your current team of 3 Pakistani devs at $8,500/month combined would become 2 US engineers at $25-33K/month combined. Same output, 3-4x the cost.

### 5. The MIT Timing Creates a Natural Pause

You are going to MIT in Fall 2026. Your attention will be split. Investors will not love funding a founder who is simultaneously pursuing a graduate degree. Either you defer MIT (which you should not do) or you raise and immediately become a part-time CEO spending investor money.

**The better play: bootstrap through the MIT year, use the MIT ecosystem for free resources, and raise after MIT when you have revenue, PMF, and a full-time commitment.**

### 6. Consumer Social Apps Are NOT SaaS -- Metrics Timelines Are Different

SaaS companies can show MRR growth in 3-6 months. Consumer social apps take 12-24 months to find organic growth loops. Raising on a 12-18 month runway for a consumer app means you will be raising again before you have proven anything. You end up on a treadmill of fundraising instead of building.

### 7. Travel Is a Proven Bootstrap Category

Skyscanner was bootstrapped for 6 years before taking VC money. They sold for $1.4B. The travel industry has real revenue from day one (commissions on bookings). Unlike pure social apps that need to invent a business model, Tryps has a clear revenue model from launch.

---

## 7. The Case FOR Bootstrapping

### 1. You Keep 100% of the Company

Every percentage point of equity matters. Bootstrapping for 12-18 months and then raising at a 3-5x higher valuation preserves millions of dollars in founder equity at any meaningful exit.

### 2. Revenue Proves Everything

A Tryps that generates $15K/month from booking commissions is worth infinitely more than a Tryps with a pitch deck and $500K in the bank. Revenue de-risks the business for you, for investors, and for the team.

### 3. MIT Is a Free Accelerator

Delta v offers up to $75K equity-free. Sandbox offers up to $25K. EIRs provide free mentorship. The MIT network provides free distribution to a demographic (graduate students planning trips) that is the exact target user.

**MIT provides $100K+ in non-dilutive capital, free distribution, free mentorship, and free credibility.** No VC round comes with all of those.

### 4. The Cost Structure Is Your Moat

A team of 3 Pakistani contractors at $8.5K/month that can build and maintain a full travel booking platform is a structural advantage. Most startups cannot operate at this cost. If you can prove the model works at $8-12K/month burn, you have optionality that funded competitors do not:
- You can survive indefinitely on modest revenue
- You can scale slowly and sustainably
- You are never forced to raise on bad terms

### 5. Discipline Creates Better Products

When you cannot throw money at problems, you are forced to focus. Instead of building all 13 scopes, you build the 3 that matter: iMessage agent, travel booking, and core trip experience. That focus produces a better product.

### 6. AI Tools Are a Force Multiplier

In 2023, bootstrapping a full travel app with 2 developers would have been impossible. In 2026, AI coding tools (Claude Code, Cursor, Copilot) make a 2-person dev team as productive as a 4-5 person team was 3 years ago. The bootstrapping math has changed.

### 7. Raise Later from a Position of Strength

The best time to raise is when you do not need to. If Tryps is generating $20K/month in booking commissions with 1,000+ users and growing organically, you can raise a $1-3M seed at a $15-25M valuation from a position of strength. Investors will compete for the deal instead of you competing for their attention.

---

## 8. Risks and What Kills You

### Risk 1: Running Out of Personal Funds (HIGHEST RISK)

If Jake has less than $75K in accessible savings, the bootstrap path is fragile. A single unexpected expense (legal issue, infrastructure failure, personal emergency) could force a premature shutdown or panic raise on bad terms.

**Mitigation**: Apply for MIT delta v immediately. Explore MIT Sandbox. Build a 3-month cash buffer before cutting the team.

### Risk 2: Key Developers Leave (HIGH RISK)

Asif and Rizwan are contractors, not co-founders. They can leave for better-paying work at any time. If Asif leaves, the product is in critical danger. If both leave, it is effectively dead.

**Mitigation**: Consider offering Asif and/or Rizwan a small equity stake (0.5-1.0% each with 2-year vesting) to create retention incentive. Even at a $5M valuation, 1% is worth $50K -- meaningful for a Pakistani developer.

### Risk 3: Organic Growth Is Too Slow (MEDIUM-HIGH RISK)

Consumer social apps live or die on network effects. If group trip planning via iMessage does not spread organically (each user invites their friend group, that friend group becomes a user), growth will stall at a few hundred users from Jake's personal network.

**Mitigation**: The MIT network is a growth hack. 1,000+ graduate students planning trips. But if MIT does not unlock organic growth, the bootstrap path runs out of distribution.

### Risk 4: Funded Competitor Enters the Space (MEDIUM RISK)

If Partiful ($140M valuation) adds trip planning, or a well-funded startup launches an iMessage travel agent, they can outspend and outbuild Tryps.

**Mitigation**: Speed matters less than product quality in consumer social. The best product wins, not the most-funded product. Partiful has been around since 2020 and has not added travel booking. The window exists.

### Risk 5: Booking Conversion Is Lower Than Expected (MEDIUM RISK)

The revenue model assumes 10% of users actually book through Tryps. If the real number is 2-5% (users love the planning but book directly on airline/hotel sites), revenue projections collapse by 50-80%.

**Mitigation**: Deep link integration, price matching, and making the booking flow so seamless that going direct feels like extra work. This is a product problem, not a funding problem.

### Risk 6: Jake Cannot Do Product + PM + GTM + Founder + MIT Student (MEDIUM RISK)

Bootstrapping puts enormous load on the founder. Jake is doing product, PM, design, QA coordination, GTM, and fundraising strategy simultaneously. Adding MIT coursework makes this potentially unsustainable.

**Mitigation**: Ruthless prioritization. Jake's MIT schedule should be minimized to core requirements. Marty (the AI agent) handles standup coordination, PR reviews, and state management. AI tools handle design and frontend work that would otherwise require a designer.

### What Definitively Kills the Bootstrap Path

1. Jake has less than $50K in accessible runway AND does not get MIT delta v
2. Both Asif and Rizwan leave within the same 3-month period
3. The product fails to generate any booking revenue in the first 9 months
4. A legal or regulatory issue (App Store rejection, Duffel compliance) requires expensive legal counsel

---

## 9. Hybrid Approaches

### Option A: Tiny Angel Round ($100-200K SAFE)

Raise $100-200K from 3-5 angel investors on a post-money SAFE at a $6-8M cap. This gives you:
- 12-18 months of guaranteed runway on the lean budget
- No board seats, no quarterly reviews, no investor pressure
- Dilution of only 2.5-3.3% (vs. 10%+ for a VC round)
- Validation signal without the pressure of institutional capital

**Best angels**: Travel industry operators, MIT alumni, consumer social founders. People who can also open doors.

**This is probably the smartest move.** It de-risks the cash problem without creating the pressure problem.

### Option B: MIT Delta v + Sandbox ($75K-100K, equity-free)

Apply for both. If accepted to delta v, you get $75K equity-free plus mentorship, office space, and demo day exposure. Sandbox adds another potential $25K.

**This is free money with no strings.** The only cost is time (the summer accelerator program). Given Jake is going to MIT anyway, this is the highest-ROI funding source available.

### Option C: Revenue-Based Financing

Companies like Clearco, Pipe, or Capchase provide capital based on projected revenue. For a pre-revenue company, these are generally not available. But once Tryps has 3-6 months of booking revenue, revenue-based financing could provide $50-100K at favorable terms (no dilution, repaid from revenue).

**Timeline**: Not available now. Potentially available Q1 2027 if revenue is real.

### Option D: YC (S26 Batch, July-September 2026)

YC provides $500K ($125K for 7% equity + $375K uncapped SAFE with MFN). The S26 batch applications are open.

**Pros**: $500K, YC network, credibility, demo day, alumni network.
**Cons**: 7% equity is expensive. The batch is in SF during summer 2026 -- could conflict with MIT start. The pace and pressure of YC may not suit a consumer social app that needs organic growth time.

**Consider carefully.** YC is not free money. 7% is real dilution, and the YC pressure to show growth may conflict with the organic growth strategy that consumer social apps need.

### Option E: Grants and Competitions

| Source | Amount | Notes |
|--------|--------|-------|
| MIT delta v | Up to $75K | Equity-free, summer accelerator |
| MIT Sandbox | Up to $25K | Equity-free, for student ideas |
| MIT $100K Entrepreneurship Competition | $100K | Highly competitive |
| NSF SBIR/STTR | $275K (Phase I) | AI/agent technology angle |
| Thiel Fellowship | $100K | Under-23 requirement may not apply |
| Various pitch competitions | $5-25K each | Time-intensive but free money |

### Recommended Hybrid Strategy

1. **Immediately**: Cut to Scenario B ($12.5K/mo) by end of April
2. **April-May**: Apply to MIT delta v (applications close Apr 1 -- may need next cycle)
3. **May-June**: Raise a quiet $150K angel round on a $7M cap SAFE (2.1% dilution)
4. **July-September**: MIT delta v if accepted ($75K equity-free)
5. **October-March 2027**: Bootstrap on combined runway (~$225K) while building revenue
6. **March 2027**: Decision point -- if revenue is $15K+/mo, keep bootstrapping. If not, raise a proper seed round with 12 months of data.

**Total dilution in this hybrid path: ~2%.** Compare to 10-15% for a traditional pre-revenue raise.

---

## Summary: The Contrarian Thesis

The case for bootstrapping Tryps is strong because:

1. **The cost structure is unusually efficient** -- $8-12K/month for a functional team is rare and should be preserved, not replaced with expensive US hires funded by VC
2. **Travel has real revenue from day one** -- unlike pure social apps that need to invent monetization, Tryps earns commissions on bookings
3. **MIT provides $100K+ in non-dilutive capital and free distribution** -- this is better than most angel rounds
4. **AI tools have changed the bootstrapping math** -- 2 devs in 2026 can do what 5 devs did in 2023
5. **Raising pre-PMF at pre-revenue is the worst possible time to raise** -- you maximize dilution and minimize leverage
6. **The product needs organic growth time** -- investor pressure to show metrics will distort a consumer social product that lives in iMessage

The primary risk is cash. If Jake has $50-75K in personal runway and secures MIT delta v, the 12-month bootstrap path is viable. A tiny $150K angel round at minimal dilution eliminates the cash risk entirely.

**The strongest version of this company raises money AFTER proving revenue, not before.** Twelve months of bootstrapping could be the difference between raising at a $5M cap and raising at a $20M cap -- worth $7-8M in founder equity at a $100M outcome.

---

*"The best time to raise is when you don't need to."*

---

Sources:
- [Duffel Pricing](https://duffel.com/pricing)
- [Duffel Margin and Markups](https://duffel.com/docs/guides/margin-and-markups)
- [Travel Agent Commission Rates 2025](https://dmcquote.com/agent-commission-rates)
- [OTA Commission Rates Guide 2025](https://stayfi.com/vrm-insider/2025/11/04/ota-fees/)
- [OTA Commission Rates 2026](https://www.cloudbeds.com/online-travel-agencies/commissions/)
- [Travel Agent Commission: How It Works](https://www.foratravel.com/the-journal/travel-agent-commission)
- [Supabase Pricing](https://supabase.com/pricing)
- [Stripe Pricing](https://stripe.com/pricing)
- [Average Vacation Cost 2026](https://www.emergencyassistanceplus.com/resources/average-vacation-cost/)
- [Gen Z Travel Spending 2026](https://globetrender.com/2025/10/07/gen-z-to-spend-most-on-international-travel-in-2026/)
- [88% of Millennials and Gen Z Keeping Travel Spending Strong](https://www.webintravel.com/88-of-millennials-and-gen-z-keeping-travel-spending-strong-in-2026/)
- [MIT Delta v Accelerator $6M Gift](https://news.mit.edu/2026/delta-v-accelerator-receives-gift-supercharge-student-startups-0224)
- [Y Combinator Deal Terms](https://www.ycombinator.com/)
- [Pre-Seed Valuations 2026](https://www.zeni.ai/blog/pre-seed-valuations)
- [Bootstrapped Startups Without Funding](https://eqvista.com/successful-bootstrapped-startups-without-funding/)
- [Partiful Series A](https://fortune.com/2023/05/23/partiful-founders-startup-raises-series-a/)
- [Pakistan Software Engineer Salary](https://www.salaryexpert.com/salary/job/software-engineer/pakistan)
- [SAFE Notes Guide 2025](https://www.joinarc.com/guides/safe-note-financing)
