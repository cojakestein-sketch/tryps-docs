# Tryps $500K Friends & Family / Angel Round: Complete Analysis

**Date:** April 5, 2026
**Author:** Jake Stein (via Claude)
**Status:** Draft -- for internal decision-making, not investor-facing

---

## Executive Summary

$500K buys Tryps 12 months of runway to go from working demo to live product with real users and initial revenue signal. The raise is sized to get to App Store launch, prove the viral loop (K-factor), hit 5K-10K real users, and generate enough traction to raise a proper Seed round of $1.5-3M. This is a bridge to proof, not a bridge to scale.

---

## 1. Monthly Burn Rate Breakdown

### Team: $27,500/month

The current team of 11 is too large for a $500K round. At this funding level, you need to cut to the core and pay market rates for offshore contractors.

| Role | Person | Keep/Cut | Monthly Rate | Notes |
|------|--------|----------|-------------|-------|
| Lead Dev | Asif | KEEP | $5,000 | Senior offshore dev rate (PKT). Manages team, ships iMessage agent. Critical. |
| Dev (Core App) | Nadeem | KEEP | $4,000 | Offshore mid-level rate. Owns Output-Backed Screen, core app. |
| Dev (Agent Layer) | Rizwan | KEEP | $4,000 | Offshore mid-level rate. Owns agent intelligence, booking pipeline. |
| QA | Aman Khan | KEEP (1 of 3) | $1,500 | One QA is enough at this stage. Part-time. |
| QA | Sarfaraz Ahmed | CUT | -- | Consolidate to one QA. |
| QA | Zain Waheed | CUT | -- | Consolidate to one QA. |
| Product | Cameron Carlson | CUT | -- | Can't afford a product contractor at $500K. Jake is product. |
| Creative Director | Sean DeFaria | REDUCE | $3,000 | Reduce to part-time/deliverable-based. Owns launch video + social setup. |
| Content/Design | Abdullah Malik | REDUCE | $2,000 | Part-time. Logo, landing page, App Store assets. Deliverable-based. |
| GTM Infra | Enej Stanovnik | PAUSE | -- | GTM infra is a Tier 2 spend. Resume after Seed. |
| SEO/GEO | Arun | PAUSE | -- | SEO takes 6+ months to compound. Can't afford the lag at this budget. |
| Designer (adhoc) | Arslan/Krisna | ON-CALL | $1,000 | Average. Only for critical design work. Per-project. |
| Founder | Jake | STIPEND | $5,000 | Below market, but keeps lights on in NYC. Supplemented by MIT stipend starting fall 2026. |
| AI Agent (Marty) | -- | KEEP | $0 | Already running on Hetzner. Infra cost, not people cost. |
| Warda (AI QA) | Warda | CUT | -- | Consolidate QA to Aman only. |
| **Subtotal** | | | **$25,500** | |
| Buffer (adhoc needs) | | | $2,000 | Specialist work, one-off design, legal review |
| **Total Team** | | | **$27,500** | |

**Key decisions:**
- Three devs stay. This is the minimum viable team to ship the 13 scopes.
- One QA stays instead of three. At pre-launch, the dev team can self-QA most things. One dedicated tester catches the critical stuff.
- Cameron is cut. At $500K, the founder IS the product person. This is a hard cut because having a product contractor is valuable, but it's a luxury at this funding level.
- Sean shifts to deliverable-based. Not monthly retainer -- pay for the launch video, pay for social setup, pay for specific assets. $3K/month average, some months $0, some months $6K.
- GTM contractors (Enej, Arun) are paused. SEO and GTM infrastructure are Seed-round investments. At $500K, growth comes from product-led virality and founder hustle, not paid infrastructure.

### Infrastructure: $2,800/month

| Service | Monthly Cost | Notes |
|---------|-------------|-------|
| Hetzner (Marty + backend) | $80 | Current server. Cheap. |
| Supabase | $25 | Pro plan. |
| Apple Developer Account | $8 | $99/year amortized. |
| Duffel (flight APIs) | $200 | Per-transaction costs. Estimate for early volume. |
| Stripe | $0 | Only charges on transactions. No monthly fee. |
| Vercel / hosting | $20 | Landing page, web client. |
| Claude/OpenAI API | $500 | Agent intelligence, trip facilitation. Scales with usage. Starts lower. |
| Linq (iMessage) | $500 | iMessage infrastructure. Estimate -- depends on contract. |
| ElevenLabs (voice) | $100 | Voice agent. Starter plan. |
| Domain/DNS | $15 | jointryps.com |
| GitHub | $50 | Team plan. |
| ClickUp | $50 | Project management. |
| Monitoring/logging | $50 | Basic observability. |
| Misc SaaS | $200 | Slack, email, etc. |
| Contingency | $1,000 | Unexpected API costs, scaling spikes. |
| **Total Infra** | **$2,800** | |

### Marketing: $3,500/month

| Item | Monthly Cost | Notes |
|------|-------------|-------|
| TikTok nano creators (5-10) | $2,000 | $50/video, 40 videos/month. Lean Locket model. |
| App Store ASO | $250 | Keywords, screenshot optimization. |
| PR/earned media | $250 | Press kit, HARO, Product Hunt prep. |
| Campus ambassador pilot (3 schools) | $500 | Stipends + pizza money. Start fall 2026 when Jake is at MIT. |
| Content production | $500 | Social media assets, trip card templates. |
| **Total Marketing** | **$3,500** | |

### Legal / Admin: $1,200/month

| Item | Monthly Cost | Notes |
|------|-------------|-------|
| Legal (amortized) | $500 | SAFE docs, terms of service, privacy policy. Heavier upfront, lighter later. |
| Accounting/bookkeeping | $300 | Monthly books. Mercury handles banking. |
| Insurance | $200 | General liability. Required for App Store in some categories. |
| Misc admin | $200 | Filing fees, registered agent, etc. |
| **Total Legal/Admin** | **$1,200** | |

### Monthly Burn Summary

| Category | Monthly |
|----------|---------|
| Team | $27,500 |
| Infrastructure | $2,800 |
| Marketing | $3,500 |
| Legal/Admin | $1,200 |
| **Total Monthly Burn** | **$35,000** |

---

## 2. 12-Month Total Budget

| Category | Monthly | Annual |
|----------|---------|--------|
| Team | $27,500 | $330,000 |
| Infrastructure | $2,800 | $33,600 |
| Marketing | $3,500 | $42,000 |
| Legal/Admin | $1,200 | $14,400 |
| **Total Operating** | **$35,000** | **$420,000** |
| **Contingency/Buffer** | | **$30,000** |
| **One-Time Costs** | | **$50,000** |
| **Grand Total** | | **$500,000** |

### One-Time Costs ($50,000)

| Item | Cost | Notes |
|------|------|-------|
| Launch video production | $5,000 | Sean directs. Professional shoot + edit. |
| Legal setup (SAFE docs, corp cleanup) | $8,000 | Lawyer review of SAFE, terms, privacy. |
| App Store launch prep | $3,000 | Screenshots, preview video, localization. |
| Disposable camera brand play (100 cameras) | $2,000 | First 100 trips get a Tryps-branded disposable. "Do things that don't scale." |
| Security audit (pre-launch) | $5,000 | Basic pen test before handling payment data. |
| Brand asset finalization | $5,000 | Final logo, brand book production, design system. |
| Referral program credits | $10,000 | $10 flight credits. Launches at 5K users. |
| Equipment/tools | $2,000 | Any dev tooling, test devices. |
| Travel (investor meetings, MIT) | $5,000 | NYC to Boston, pitch meetings. |
| Unallocated contingency | $5,000 | Unknown unknowns. |
| **Total One-Time** | **$50,000** | |

### Runway Buffer: $30,000

This is ~1 month of emergency runway. If everything goes wrong in month 11, you have one month to close a bridge or cut costs. It's thin, but at $500K you can't afford more buffer without cutting something critical.

### Runway Math

- **Monthly burn:** $35,000
- **Usable capital after one-time costs:** $420,000
- **Months of runway:** 12.0 months
- **With $30K buffer:** 11.1 months of operating runway + 1 month emergency

**Realistic scenario:** Some months will be higher (launch month, events), some lower (quiet development months). The budget assumes a steady burn, but actual spend will be lumpy. The $30K buffer and the contingency line items absorb variance.

### MIT Factor (Fall 2026 onward)

Starting September 2026 (month 5-6 of the raise), Jake moves to MIT. This creates:

**Cost reductions:**
- Jake's stipend could drop to $3,000/month if MIT provides housing/stipend through the Martin Trust Center or Sloan ecosystem
- Access to free office space, meeting rooms, MIT resources
- Free access to MIT legal clinics, startup resources

**Cost increases:**
- Boston rent (if not covered by MIT): $1,500-2,500/month (offset by NYC savings)
- Travel between NYC and Boston: $200-400/month

**Net effect:** Roughly neutral. MIT provides non-cash benefits (network, credibility, resources) that are worth far more than any cost delta.

---

## 3. Key Hires / Team Changes

### Who Stays and Why

| Person | Role | Why They Stay |
|--------|------|--------------|
| **Asif** | Lead Dev | The linchpin. Built the iMessage agent (51/57 SC done). Manages Nadeem and Rizwan. Coordinates with Linq. Losing Asif would set the project back months. |
| **Nadeem** | Dev (Core App) | Owns the mobile app experience. 15/16 on Core Trip Experience, working through Output-Backed Screen (7/48). The app IS the product for non-iMessage users. |
| **Rizwan** | Dev (Agent Layer) | Owns agent intelligence (29/61) and travel booking (5/70). The booking pipeline is the revenue engine. Rizwan's agent work is what makes Tryps more than a planning tool. |
| **Aman Khan** | QA (1 of 3) | One QA tester is essential. Pick the best of the three. If Aman is strongest, keep Aman. |
| **Sean** | Creative (part-time) | Deliverable-based. Launch video is critical for App Store, pitch deck, and social proof. Sean's creative direction gives Tryps a brand that punches above its weight. |
| **Abdullah** | Content/Design (part-time) | Logo, landing page, App Store assets. Deliverable-based, not retainer. |

### Who Gets Cut and Why

| Person | Role | Why They're Cut |
|--------|------|----------------|
| **Cameron Carlson** | Head of Product | Hard cut. Cameron brings real product thinking, but at $500K the founder must be the product person. Re-engage after Seed. |
| **Sarfaraz Ahmed** | QA | Three QA testers is a luxury. Consolidate to one. |
| **Zain Waheed** | QA | Same as above. |
| **Warda** | AI QA | Consolidate QA function. |
| **Enej Stanovnik** | GTM Infra | GTM infrastructure is a Seed investment. Pause until you have users to optimize for. |
| **Arun** | SEO/GEO/AEO | SEO is a 6-12 month payoff. Can't afford the lag time at $500K. Restart post-Seed. |

### New Hires: None

At $500K, you do not hire new people. The team of 6 (3 devs + 1 QA + 2 part-time creative) plus Jake is sufficient to reach the milestones that matter. Any new hire at this stage means cutting runway, and runway is life.

**The one exception:** If Asif, Nadeem, or Rizwan leaves, you must replace them immediately. Budget the contingency fund for a 2-4 week recruiting sprint. Offshore dev rates at their level ($4-5K/month) mean you can find replacements, but the ramp-up time is the real cost.

### The Full-Time Question

Nobody converts to full-time in this round. The math doesn't work:
- A full-time senior dev in NYC: $150-200K/year = $12,500-16,700/month
- Current offshore contractor: $4,000-5,000/month
- The 3x cost difference means converting even one person to US full-time eats 25-30% of your team budget

**At $500K, you stay lean and offshore.** Full-time US hires happen at Seed ($1.5-3M) when you can afford $150K+ salaries and need people in the room for product decisions.

---

## 4. Milestones Achievable in 12 Months

### Milestone 1: App Store Launch (Month 1-2, by May 2026)

**Already nearly there.** April 15 target for App Store submission. By the time the raise closes, the app should be live or in review.

- Core Trip Experience: 15/16 SC done (testing)
- iMessage Agent: 51/57 SC done
- Voice Calls: Done
- Output-Backed Screen: 7/48 (needs significant work)

**What "launched" means:** Users can download the app, create a trip, add Tryps to their iMessage group chat, and the agent helps plan the trip. Flight booking may be partially live via Duffel.

### Milestone 2: End-to-End Booking Live (Month 3-4, by July/August 2026)

- Duffel flight booking fully functional (Rizwan, currently 5/70 on Travel Booking)
- Stripe payment processing live (already connected)
- First real transaction: a user books a flight through Tryps and pays

**This is the moment Tryps becomes a business, not a demo.** Revenue starts here, even if it's $50.

### Milestone 3: 1,000 Real Users (Month 4-6, by September 2026)

- Organic growth from founder's network, MIT network, beta testers
- Product Hunt launch
- Initial TikTok nano creator program (5-10 creators)
- K-factor measurement begins

**What matters here is not the number but the quality.** 1,000 users who have planned real trips and 100 who have booked through Tryps is more valuable than 10,000 downloads with 50 DAU.

### Milestone 4: K-Factor Validated (Month 5-7)

- Measure invite flow: how many people does each trip creator invite?
- Measure conversion: what % of invitees download?
- Measure repeat: what % of invitees create their own trip?
- **Target: K > 0.4** (per the path-to-100K analysis)

**This is the single most important milestone.** If K > 0.4, the business model works and you can raise a Seed confidently. If K < 0.2, you need to fix the product before spending on growth.

### Milestone 5: 5,000-10,000 Users (Month 8-12, by March 2027)

- Campus ambassador pilot at MIT (Jake is physically there)
- Scaled TikTok creator program (15-20 creators)
- Referral program launched ($10 flight credit)
- Word of mouth from early users

**Realistic range:** 5,000-10,000 total downloads, 1,500-3,000 MAU, 200-500 users who have booked through Tryps.

### Milestone 6: Revenue Signal (Month 6-12)

- First $10K in GMV processed through Tryps
- First $500-1,000 in actual revenue (take rate on bookings)
- Revenue per paying user measured and tracked

**This is not about hitting revenue targets.** It's about proving the unit economics work: people will book through Tryps, the take rate is sustainable, and LTV > CAC.

### Milestone 7: Seed-Ready Metrics (Month 10-12)

By month 12, the goal is to have a compelling Seed pitch:
- 5K-10K users with demonstrated retention
- K-factor measured and ideally > 0.4
- Revenue: $5K-20K total (proof of concept, not material)
- 50-100 completed trips with real bookings
- Clear product roadmap for hotel/activity booking (the margin play)
- MIT network activated (advisors, potential investors, social proof)

### What You Cannot Achieve at $500K

- **100K downloads.** The path-to-100K analysis shows this requires $150-250K in marketing alone with a working viral loop. At $500K total budget, you can't allocate that much to marketing.
- **Material revenue.** $500K is not enough to build the full booking stack (flights + hotels + activities) and scale users. Expect $5K-30K in total revenue over 12 months.
- **Full-time US team.** One US engineer's salary would consume 30-40% of the total raise.
- **Paid social advertising.** No budget for Meta/TikTok ads. Growth is organic + earned + small creator program.
- **Hotel or activity booking integration.** Rizwan will be focused on completing flight booking and agent intelligence. Hotel aggregator integration (Booking.com affiliate, etc.) is a Seed-round build.

---

## 5. Valuation / Terms Expectations

### Recommended Structure: Post-Money SAFE

**Instrument:** Y Combinator Post-Money SAFE (Simple Agreement for Future Equity)

**Why Post-Money SAFE:**
- Industry standard for pre-seed / Friends & Family rounds
- Simple: 4-page document, no negotiation of terms
- No board seats, no governance rights, no liquidation preferences to negotiate
- Post-money means dilution is clear and calculable (investors know exactly what % they're buying)
- Converts at the next priced round (Seed)

### Valuation Cap: $4-6M Post-Money

| Valuation Cap | Dilution at $500K | Reasoning |
|---------------|------------------|-----------|
| $4M | 12.5% | Floor. Below this, you're giving away too much for too little validation. |
| **$5M** | **10%** | **Sweet spot. Standard for pre-revenue consumer app with working demo, small team, strong founder narrative.** |
| $6M | 8.3% | Ceiling. Justifiable if you have strong investor interest or a hot demo. |
| $8M+ | <6.3% | Too high for F&F/Angel with no users and no revenue. Investors will push back or pass. |

**Why $5M is right:**

1. **Comparable pre-seed caps (2025-2026):** Consumer social/travel apps with working demos and no revenue typically raise at $3-6M caps. The market has cooled from 2021-2022 when $8-15M pre-seed caps were common.

2. **What you have going for you:**
   - Working product (not a mockup -- real iMessage agent, real app, real voice calls)
   - Linq partnership (exclusive beta access to native iMessage polling)
   - Three-layer architecture (iMessage + app + agent) that no competitor has
   - Strong brand strategy and positioning
   - Founder going to MIT (credibility signal)

3. **What works against you:**
   - No users (pre-launch)
   - No revenue
   - No full-time employees
   - Contractor team in Pakistan (some investors see risk here)
   - Sole founder (no co-founder)

### No Discount (or Small Discount)

Post-money SAFEs typically do NOT have a discount. The valuation cap IS the price signal. If you must offer a discount to close specific investors, keep it at 10-15% max. Do not offer a 20%+ discount -- it signals desperation and creates messy cap table math.

### Pro-Rata Rights

**Offer pro-rata rights to investors putting in $25K+.** This gives them the right (not obligation) to invest their proportional share in the next round. Angels love this because it protects against dilution. It costs you nothing because it only triggers at the next priced round, and more investor interest at that point is usually a good thing.

### Side Letter / MFN

Consider a Most Favored Nation (MFN) clause: if you offer better terms to a later investor in this round, earlier investors automatically get the better terms. This lets you start raising at $5M and adjust if the market tells you different.

### What NOT to Do

- **Do not do a priced round.** Equity rounds at $500K require board formation, shareholder agreements, and $10-20K in legal fees. SAFEs avoid all of this.
- **Do not give board seats.** No investor putting in $25-100K should get a board seat. Advisory capacity only.
- **Do not create multiple share classes.** Keep the cap table clean for the Seed round.
- **Do not offer revenue share or convertible notes with interest.** SAFEs are cleaner. Notes with 5-8% interest and maturity dates create unnecessary complexity and legal exposure.

---

## 6. Investor Profile

### Who Invests at This Level

**Tier 1: Friends & Family ($5K-$50K checks)**

These are the first calls. They invest in Jake, not Tryps.

- Parents, siblings, extended family
- Close friends with disposable income
- College friends who now work in finance, tech, or consulting
- McKinsey network (former colleagues, if applicable)

**What they care about:** They trust you. They want to support you. They need to understand the product in 2 minutes. Show them the iMessage demo. "You text it, and it plans your trip." Done.

**How to find them:** You already know them. Make a list of 30 people. Text them.

**Typical check:** $5K-$25K

**Tier 2: Angel Investors ($25K-$100K checks)**

Individual investors who write checks from personal funds.

- **Travel industry operators:** Former Expedia, Booking, Airbnb employees who understand the space
- **Consumer social investors:** People who backed Partiful, BeReal, Locket, or similar
- **NYC angel community:** Fundraise from the NYC tech community. Events: Fundraise, Angel Summit NYC, NYC Founders Network
- **MIT network (starting fall 2026):** MIT alumni angels, Martin Trust Center mentors, Sloan Fellows
- **AngelList syndicates:** Syndicates focused on consumer, travel, or AI

**What they care about:** Market size, founder-market fit, product differentiation, path to the next round. They want to see the demo, understand the wedge (iMessage), and believe in the team.

**How to find them:**
- AngelList: Create a deal page. Join travel and consumer syndicates.
- LinkedIn outreach: Search for "angel investor" + "travel" or "consumer."
- Intro requests: Ask every person you pitch to introduce you to two more investors.
- MIT: The Martin Trust Center has a formal angel network. Start engaging immediately when you arrive.

**Typical check:** $25K-$50K

**Tier 3: Pre-Seed Funds ($50K-$200K checks)**

Micro-VCs that specialize in pre-seed.

- **Precursor Ventures** -- consumer focus, NYC
- **Hustle Fund** -- pre-seed generalist, founder-friendly
- **Afore Capital** -- pre-seed, consumer + marketplace
- **Chapter One** -- NYC-based pre-seed
- **Weekend Fund** -- Ryan Hoover (Product Hunt founder). Travel + consumer.
- **Not Boring Capital** (Packy McCormick) -- if you can get the intro

**What they care about:** Everything in Tier 2 plus team, market timing, and competitive moat. They invest in 50-100+ companies per year. They need to believe this is a $100M+ outcome.

**How to find them:** Apply directly on their websites. Many have open application forms. Cold email the partner who covers consumer/travel.

**Warning:** Pre-seed funds typically want a lead investor. If you're raising $500K, having one fund write $100-200K as a "lead" makes closing the rest much easier. This is the hardest part of the raise.

### Accelerators

Not recommended for this specific raise, but worth noting:

- **Y Combinator:** $500K for 7% (post-money SAFE at ~$7M). Would solve the entire raise in one shot, but YC acceptance rate is <2%. Apply anyway. Deadline: typically 4-6 months before batch starts.
- **Techstars NYC:** $120K for 6%. Smaller check but strong network.
- **MIT delta v:** MIT's accelerator. Jake will have access starting fall 2026.

**If you get into YC:** Don't raise the F&F round. YC's $500K at $7M is better terms and better signal.

---

## 7. Risks and What Kills You

### Risk 1: The Viral Loop Doesn't Work (EXISTENTIAL)

**What it looks like:** K-factor < 0.2. Every user you acquire is a dead end. Trip invites don't convert to downloads. Downloads don't convert to trip creators.

**Why it kills you:** Without a working viral loop, Tryps is just another travel app that needs paid acquisition. At $500K, you can't afford meaningful paid acquisition. You're stuck at 1,000-3,000 users with no path to 100K.

**Mitigation:** Instrument K-factor tracking from day one. If K is bad by month 4, stop everything else and fix the invite flow. The trip card, the deep link, the onboarding -- these are more important than any feature.

### Risk 2: Solo Founder Burnout

**What it looks like:** Jake is CEO, product person, head of marketing, investor relations, customer support, and content creator. At MIT starting fall 2026, add coursework. The 9-10 hour timezone gap with the dev team means early morning and late night standups.

**Why it kills you:** Founder burnout is the #1 killer of pre-seed startups. Not running out of money -- running out of energy.

**Mitigation:**
- Find a co-founder or a near-co-founder (someone who takes 30-40% of the operational load in exchange for meaningful equity). MIT is the best recruiting ground for this.
- Delegate more to Asif. He's already managing the dev team. Give him more product authority.
- Use Marty effectively. The AI agent handles standups, PR reviews, state syncing. Lean on it harder.

### Risk 3: The Planning-to-Booking Gap

**What it looks like:** Users love planning trips on Tryps but book flights on Google Flights, hotels on Airbnb, and activities on Viator. Tryps becomes a planning tool with no revenue.

**Why it kills you:** This is the graveyard of travel startups. TripAdvisor, Wanderlog, and dozens of others have great planning tools but struggle to capture booking revenue. Without booking revenue, the take-rate model doesn't work.

**Mitigation:** The iMessage agent is the wedge. "Greece it is -- let me pull flights. Want me to book?" is higher-conversion than any search-and-compare interface. But it has to actually work end-to-end. Flight booking via Duffel must be seamless.

### Risk 4: iMessage Platform Risk

**What it looks like:** Apple restricts third-party iMessage integrations, Linq shuts down or changes pricing, or Apple launches its own group planning feature.

**Why it kills you:** The entire differentiation (Layer 1: iMessage) depends on a platform you don't control.

**Mitigation:**
- Diversify to WhatsApp (international), RCS (Android), and native app as fallbacks
- The mobile app (Layer 2) works independently of iMessage
- Deep Linq partnership (being their first beta tester gives you relationship equity)
- Apple is more likely to partner (MCP integrations) than compete in group trip planning

### Risk 5: Running Out of Money at Month 10 with No Traction

**What it looks like:** Month 10, 2,000 users, K-factor is 0.15, $3K in total revenue, can't raise a Seed.

**Why it kills you:** Two months of runway left, no signal to raise on. The company dies or Jake has to bridge with personal funds.

**Mitigation:**
- Set a "kill threshold" at month 6: if < 500 users AND K < 0.2 AND no booking revenue, pivot or wind down
- Have the Seed fundraise conversation starting at month 7-8, not month 11
- MIT provides a safety net: Jake can work on Tryps as a "student project" with near-zero burn while figuring out next steps
- Keep burn at $35K/month. Do not let it creep up.

### Risk 6: Key Person Risk (Asif)

**What it looks like:** Asif leaves. He built the iMessage agent, manages the dev team, and holds the most institutional knowledge.

**Why it kills you:** 3-6 month setback minimum. The remaining devs (Nadeem, Rizwan) are strong but Asif is the coordinator.

**Mitigation:**
- Pay Asif fairly (or slightly above market). $5K/month for a lead dev in Pakistan is competitive but not generous.
- Give Asif equity or a meaningful success bonus tied to Seed round
- Document everything. Asif's knowledge shouldn't be in his head alone.
- Have a backup plan: identify potential replacement before you need one

### What You CAN'T Do That Might Be Fatal

1. **You can't do paid social advertising.** If organic + creator + viral doesn't work, you have no fallback growth channel.
2. **You can't hire a growth person.** Growth is Jake's job, plus the small creator program.
3. **You can't pivot.** $500K gives you one shot at one strategy. If the iMessage wedge doesn't work, you don't have enough runway to try a completely different approach.
4. **You can't build hotel booking.** Flight-only take rates (3-5%) are thin. Hotels (12-15%) are where the real margin is. But building a hotel aggregator integration is a 3-6 month project that competes for dev time with core product work.

---

## 8. The Pitch for Why $500K is Right

### The Argument

**$500K is the minimum viable raise to get from working demo to fundable company.** Here's why this amount is correct:

**1. It's enough to launch and prove the loop.**

The product is 80% built. Two of 13 scopes are done, five are in progress, one is in testing. The $500K doesn't fund a build from scratch -- it funds the last 20% of the build, the launch, and the first 6-9 months of learning. That's efficient.

**2. It's small enough to raise from angels and F&F without institutional friction.**

$500K from 10-20 investors at $25-50K each is achievable in 4-8 weeks from a strong personal network. No need to spend 4 months courting VCs. No board seats. No complex governance. Jake can spend 80% of his time on the product and 20% on fundraising, instead of the inverse.

**3. It maps to real milestones, not vanity metrics.**

$500K buys exactly 12 months at $35K/month burn. In those 12 months:
- App Store launch (month 1-2)
- First real booking (month 3-4)
- K-factor validated (month 5-7)
- 5K-10K users (month 8-12)
- Seed-ready metrics (month 10-12)

Each milestone is measurable, honest, and achievable with the team in place.

**4. The MIT timing makes it perfect.**

Jake arrives at MIT in September 2026. The Martin Trust Center, the Sloan network, MIT delta v, and the broader Boston/Cambridge startup ecosystem become available. Raising a Seed from MIT with 5K-10K users and a working product is a fundamentally different conversation than raising from NYC with a demo.

MIT also provides: free workspace, legal clinics, mentorship, and -- critically -- a co-founder recruiting ground. The #1 thing this company needs before the Seed is a co-founder or senior operator who can share the load.

**5. It preserves equity for the Seed.**

At a $5M cap, $500K is 10% dilution. Jake retains 90% ownership entering the Seed. Even after a Seed at $15-20M (20% dilution), Jake still owns 70%+. Compare this to raising $1.5M pre-seed at $6M (25% dilution) -- that's 2.5x more dilution for money you don't need yet.

**The principle:** Raise the minimum amount that gets you to the next inflection point. The next inflection point is "product live, users real, viral loop measured." $500K gets you there. $250K doesn't (not enough runway). $1M is more than you need (and costs more equity than necessary).

**6. The team is already cheap.**

Three offshore devs at $4-5K/month is $13K/month for your entire engineering team. A US startup with three engineers would burn $40-50K/month on engineering alone. The contractor model means $500K goes 3x further than it would for a typical NYC startup.

**7. The product has a structural advantage worth betting on.**

No other company has all three layers: iMessage agent + mobile app + agentic booking. Partiful has the viral social layer but doesn't plan or book trips. Expedia has booking but no social layer. ChatGPT can research trips but can't live in your group chat or execute bookings. Tryps is the only product that can say: "add me to your group chat, and I'll plan and book the whole trip."

That's not a feature -- it's a category. $500K is a bet that this category exists and Tryps can own it.

---

## Appendix A: Comparable Raises

| Company | Stage | Amount | Valuation/Cap | What they had | Year |
|---------|-------|--------|---------------|---------------|------|
| Partiful | Pre-seed | $500K | ~$5M | Working product, small user base | 2020 |
| BeReal | Pre-seed | $600K (est.) | ~$5M | Working app, <1K users | 2020 |
| Locket | Pre-seed | $1.2M | ~$8M | Concept + team | 2021 |
| AllTrails | Seed | $1.5M | ~$10M | Working app, early traction | 2013 |
| Hopper | Seed | $750K | ~$5M | Price prediction algo, no app | 2012 |

**Note:** All comps are approximations based on public data and industry estimates. Pre-seed terms are rarely disclosed publicly.

## Appendix B: 12-Month Financial Forecast

| Month | Burn | Cumulative Spend | Cash Remaining | Key Milestone |
|-------|------|-----------------|---------------|---------------|
| 1 (May) | $45K | $45K | $455K | App Store launch + one-time legal/brand costs |
| 2 (Jun) | $38K | $83K | $417K | Launch video production, Product Hunt |
| 3 (Jul) | $35K | $118K | $382K | Duffel flight booking live |
| 4 (Aug) | $35K | $153K | $347K | First real booking, 500 users |
| 5 (Sep) | $35K | $188K | $312K | Jake starts MIT, campus pilot begins |
| 6 (Oct) | $35K | $223K | $277K | 1,000 users, K-factor first measurement |
| 7 (Nov) | $35K | $258K | $242K | K-factor validated, referral program design |
| 8 (Dec) | $33K | $291K | $209K | Holiday travel season, 2,000 users |
| 9 (Jan) | $35K | $326K | $174K | New year travel planning surge |
| 10 (Feb) | $35K | $361K | $139K | 5,000 users, begin Seed conversations |
| 11 (Mar) | $38K | $399K | $101K | Spring break surge, Seed deck finalized |
| 12 (Apr) | $35K | $434K | $66K | Seed round close target, 8K-10K users |

**Note:** $66K remaining at month 12 provides ~2 months of bridge if the Seed isn't closed by April 2027. This is tight. Seed fundraising MUST start by month 9-10 at the latest.

## Appendix C: What the Seed Round Looks Like

If the $500K round succeeds and milestones are hit:

| Parameter | Target |
|-----------|--------|
| Raise amount | $1.5-3M |
| Valuation cap | $12-20M (post-money SAFE or priced) |
| Timeline | Q1-Q2 2027 |
| What you'll have | 5K-10K users, K-factor data, first revenue, MIT network, polished brand |
| What you'll build | Hotel/activity booking, campus expansion, creator program at scale, first US hire |
| Dilution | 15-20% |

The $500K round exists to make this Seed round possible, achievable, and well-priced.

---

*This analysis is for internal use. It should inform the fundraise strategy but should NOT be shared with investors as-is. The investor-facing materials (pitch deck, one-pager) should present the same facts with appropriate framing and confidence.*
