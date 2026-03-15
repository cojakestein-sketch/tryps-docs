# Path to 100K Downloads

**Date:** March 15, 2026
**Author:** Jake Stein (via Claude)
**Status:** Draft brainstorm — assumptions called out, directional not precise

---

## Why 100K?

From our valuation comp analysis (`analysis.md`), at 100K downloads Tryps is worth:

| Scenario | $/Download | Valuation |
|----------|-----------|-----------|
| Conservative (P25) | ~$17 | **$1.7M** |
| Mid-Range (Median) | ~$42 | **$4.2M** |
| Optimistic (P75) | ~$200 | **$20M** |

This is the fundraising milestone. At 100K real downloads with strong retention, we have a fundable company. The question is: what combination of channels gets us there, and what does each cost?

---

## The Core Insight: You Need Two Engines

No single channel gets to 100K alone at Tryps' budget. The math only works when you combine:

1. **Direct acquisition channels** — push new users into the top of the funnel (creators, campus, PR, ASO)
2. **The viral multiplier** — every user you acquire pulls in more users through trip invites

The equation is: **Total downloads = Direct acquisition × Viral multiplier**

If the viral multiplier is 2x, you only need 50K direct. If it's 3x, you need 33K. If it's 4x, you need 25K.

**The #1 strategic priority is maximizing the viral multiplier** — because it makes every dollar of acquisition spend 2-4x more efficient.

---

## The Viral Multiplier (applies to ALL channels)

### How It Works

Every Tryps user who creates a trip invites ~6 people. Some are new to Tryps. Those new users download, and some eventually create their own trips — which invites more people.

### The Math

| Variable | Conservative | Mid | Optimistic |
|----------|-------------|-----|------------|
| New invitees per trip | 3 | 4 | 5 |
| Invite → download conversion | 30% | 40% | 50% |
| % of new users who create own trip (within 6 mo) | 15% | 25% | 35% |
| **K-factor** | **0.14** | **0.40** | **0.88** |
| **Viral multiplier** (1/(1-K)) | **1.16x** | **1.67x** | **8.3x** |

**Assumptions & benchmarks:**
- Partiful's invite conversion is reportedly ~50%+ (theirs is lower friction — no download needed to RSVP). 30-40% for Tryps is realistic since it requires an app download.
- "Create own trip" rate is the key unknown. Partiful: high repeat because events are frequent. Trips are seasonal — people plan 2-4 trips/year. 25% of invitees creating their own trip within 6 months is our target.
- K < 1 means growth decelerates (converges). K > 1 means exponential growth. **Getting K above 0.5 is the product team's #1 job.**

### What This Means

| Direct acquisition needed | K = 0.14 (bad) | K = 0.40 (target) | K = 0.88 (great) |
|--------------------------|-----------------|-------------------|-------------------|
| To reach 100K total | 86K direct | 60K direct | 12K direct |

**Bottom line:** With a working viral loop (K ≈ 0.4), we need ~60K direct downloads. With a great one (K ≈ 0.8+), we need far fewer. Without a viral loop (K < 0.2), we need nearly 100K direct — extremely expensive.

---

## Channel A: Social Media / Creators

### A1: TikTok Nano Creator Program (Locket Model)

**Case study:** Locket Widget — 26 creators posting 2-3x daily = ~52 videos/day. Result: 298M views, 1.5M shares, 2.3M bookmarks. Locket has 80M+ total downloads.

**The equation:**

```
Creators × Videos/day × Days × Avg views/video × View-to-download rate = Downloads
```

**Three scenarios over 6 months (180 days):**

| Variable | Conservative | Mid | Aggressive |
|----------|-------------|-----|------------|
| Creators | 15 | 25 | 40 |
| Videos/day/creator | 2 | 2.5 | 3 |
| Total videos (6 mo) | 5,400 | 11,250 | 21,600 |
| Avg views/video (incl. breakouts) | 3,000 | 5,500 | 8,000 |
| Total views | 16.2M | 61.9M | 172.8M |
| View → download rate | 0.08% | 0.12% | 0.18% |
| **Downloads** | **13K** | **74K** | **311K** |

**Key assumptions:**
- **Average views/video:** Locket's pool averaged ~5,500 views including breakouts. Nano creator TikToks typically get 1,000-3,000 base, but 10% hit 10x (breakout) and 3% hit 50x (viral). The average is pulled up by fat-tail hits.
- **View → download conversion:** This is the hardest number. Industry data says TikTok view → app install runs 0.05-0.5% depending on content quality, product complexity, and how good the App Store page is. Locket's product is dead simple (photo widget), so their rate was likely on the high end. Trip planning is higher friction. **0.08-0.18% is our range.**
- **Creator costs at nano tier:** $25-$75/video. At 25 creators doing 2.5 videos/day: 25 × 2.5 × 30 × $50 = **$93,750/month**. Over 6 months: **$562K.** This is a Tier 2 (post-investment) play, not Tier 1.

**What it takes to hit 100K from this channel alone:**

At mid assumptions (5,500 views/video, 0.12% conversion):
- Need 100K / 0.66 per video = ~151,500 videos
- At 2.5/day/creator over 6 months: 151,500 / 450 = **337 creators**

That's unrealistic as a solo channel. **TikTok creators are a 30K-70K channel at Tier 2 budget, not a 100K channel.**

**Recommended format (from Locket/Wispr playbook):**
- 3-5 second video, person looking at camera, emotional reaction, text overlay
- Hooks to test: "POV: Your chaotic friend group just planned an entire trip in 5 minutes" / "Life after my friend group got Tryps" / "The group chat reaction when I sent the Tryps link"
- Post 2-3x/day per creator. Rotate underperformers every 2 weeks.

**Cost to produce 25K-50K downloads:** $200K-$500K over 6 months.

---

### A2: Creator/Influencer Program (Wispr Flow Model)

**Case study:** Wispr Flow hired ~80 creators at "the most competitive rates in the market." Result: 500M+ views in 3 months. Tobin Tang built the program; later replicated it at Polymarket.

**The equation:**

```
Creators × Posts/week × Weeks × Avg reach/post × Reach-to-download rate = Downloads
```

**Tryps version — 80 creators, tiered:**

| Tier | Count | Followers | Posts/week | Avg reach/post | Cost/post |
|------|-------|-----------|------------|----------------|-----------|
| Nano (1K-10K) | 40 | 5K avg | 3 | 3,000 | $50 |
| Micro (10K-100K) | 30 | 40K avg | 2 | 15,000 | $400 |
| Mid-tier (100K-500K) | 10 | 200K avg | 1 | 60,000 | $2,000 |

**Monthly reach:**
- Nano: 40 × 3 × 4 weeks × 3,000 = 1.44M
- Micro: 30 × 2 × 4 × 15,000 = 3.6M
- Mid-tier: 10 × 1 × 4 × 60,000 = 2.4M
- **Total: 7.44M views/month → 44.6M over 6 months**

**Monthly cost:**
- Nano: 40 × 3 × 4 × $50 = $24,000
- Micro: 30 × 2 × 4 × $400 = $96,000
- Mid-tier: 10 × 1 × 4 × $2,000 = $80,000
- **Total: $200K/month → $1.2M over 6 months**

**Downloads at 0.12% conversion: 44.6M × 0.0012 = 53,500**

**With viral multiplier (K=0.4): 53,500 × 1.67 = ~89K total**

**Key assumptions:**
- Reach estimates assume a mix of TikTok, Instagram Reels, and YouTube Shorts.
- 0.12% conversion assumes strong emotional hooks, good App Store page, and clear CTA.
- Wispr Flow's 500M views in 3 months implies ~21M views/day across 80 creators = 260K views/day/creator. That's MUCH higher than our model, suggesting they used bigger creators or had exceptional viral moments. Our model is more conservative.
- **Follower overlap:** With 80 creators in the same niche, expect 10-30% audience overlap, reducing effective unique reach. Baked into the lower view estimates.

**Wispr Flow vs. Tryps comparison:**

| Factor | Wispr Flow | Tryps |
|--------|-----------|-------|
| Product complexity | Low (voice typing) | Higher (group coordination) |
| "Whoa" moment | Instant (dictate → text appears) | Requires context (trip comes together) |
| Target demo | Professionals + students | 20s-30s group travelers |
| Content format | Screen recording + reaction | Trip planning montage + reaction |
| Conversion friction | Download app, try it | Download app, create/join trip, invite friends |

**Verdict:** Tryps will likely see lower per-view conversion than Wispr Flow. Compensate with higher emotional resonance (travel > productivity for social content) and stronger viral loop (Wispr has no invite mechanic).

**Cost to produce 50K downloads: ~$600K-$1.2M over 6 months. This is a Series A play, not seed.**

---

### A3: Launch Video

**The equation:**

```
1 video × Platform distribution × View-to-download rate = Downloads
```

| Platform | Views (realistic) | Views (if it hits) | Conversion |
|----------|-------------------|-------------------|------------|
| TikTok/Reels | 50K-500K | 2M-10M | 0.3-1% |
| YouTube | 20K-200K | 500K-2M | 0.5-2% |
| Twitter/X | 30K-300K | 1M-5M | 0.1-0.5% |
| **Total range** | **100K-1M** | **3.5M-17M** | **Blended 0.3-1%** |

**Downloads:**
- Base case: 500K views × 0.5% = **2,500 downloads**
- Good case: 3M views × 0.5% = **15,000 downloads**
- Viral case: 10M+ views × 0.7% = **70,000+ downloads**

**Key assumptions:**
- One launch video cannot be planned to go viral. It's a lottery ticket, not a channel.
- The "Everybody Needs to Be on the Same Page" mockumentary concept is strong for shareability.
- Even if the video doesn't go mega-viral, it serves as the App Store preview, the pitch deck opener, and the social proof anchor. It has value beyond direct downloads.
- **Budget: $3K-$6K** (per marketing launch plan).

**Verdict:** Plan for 2,500-15K downloads. Don't bank on virality. Worth doing for its secondary benefits regardless.

---

## Channel B: Referral Programs

### B1: Product-Led Invite Loop (Partiful Model) — Already Modeled Above

This IS the viral multiplier. It's not a separate channel — it's the amplifier on everything else.

**The product work that maximizes this:**
- Invite link preview must be beautiful and informative (the trip card IS the pitch)
- One-tap join flow (phone number only)
- Push notifications that pull invitees back in ("Sarah added flights to your Cancun trip!")
- Seasonal triggers (spring break, summer, holidays)

**Cost: $0 in marketing. The investment is engineering time on the invite flow.**

---

### B2: Incentivized Referral Program

**The equation:**

```
Existing users × Referral rate × Friends referred × Conversion rate = New downloads
```

**"Invite 3 friends to join a trip, get $10 flight credit":**

| Variable | Without incentive | With incentive |
|----------|------------------|----------------|
| % of users who actively refer | 10% | 30% |
| Friends referred per referrer | 3 | 6 |
| Invite → download conversion | 40% | 45% |
| **New downloads per 1,000 users** | **120** | **810** |

**At scale (10,000 existing users):**
- Without incentive: 1,200 new downloads
- With incentive: 8,100 new downloads

**The viral coefficient with incentives:**
- K = 0.30 × 6 × 0.45 × 0.25 (create own trip rate) = **0.20**
- Compare to organic K of 0.40 — the incentive ADDS to organic, it doesn't replace it
- Combined K: ~0.55-0.60

**Cost model:**

| Users who redeem | Credit given | Total cost |
|-----------------|-------------|-----------|
| 810 per 1K users | $10 each | $8,100 per 1K users |
| 8,100 per 10K users | $10 each | $81,000 per 10K users |

**CAC with referral program: $10 per download** (if credit costs are the only cost). That's within the acceptable range for consumer apps ($5-15 CAC at seed).

**Alternative: "Plan a trip, enter to win $500 toward your actual trip"**

Lower cost per user (lottery structure), but lower motivation. Estimate 2-3x less effective than guaranteed credit.

**Verdict:** A referral program is high-ROI once you have 5K+ users. Before that, the absolute numbers are too small to matter. Launch it at the 5K user mark.

---

### B3: K-Factor Sensitivity — What Gets Us to 100K

| Scenario | K-factor | Direct acquisition needed | Direct acquisition cost (est.) |
|----------|----------|--------------------------|-------------------------------|
| No viral loop | 0 | 100,000 | $500K-$1.5M |
| Weak loop | 0.2 | 83,000 | $400K-$1.2M |
| Working loop | 0.4 | 60,000 | $300K-$900K |
| Strong loop | 0.6 | 40,000 | $200K-$600K |
| Near-viral | 0.8 | 20,000 | $100K-$300K |
| Viral | 1.0+ | 10,000 | $50K-$150K |

**This is the most important table in this document.** The difference between K=0.2 and K=0.8 is $300K-$1M in marketing spend.

---

## Channel C: Other Channels

### C1: App Store Organic Discovery + Featuring

**The equation:**

```
Monthly search impressions × Tap-through rate × Download rate = Monthly downloads
```

| Variable | Conservative | Mid | Optimistic |
|----------|-------------|-----|------------|
| Monthly search impressions (travel/planning keywords) | 50K | 150K | 500K |
| Tap-through rate | 3% | 5% | 8% |
| App Store page → download | 25% | 35% | 45% |
| **Monthly downloads** | **375** | **2,625** | **18,000** |
| **12-month total** | **4,500** | **31,500** | **216,000** |

**Key assumptions:**
- Search impressions depend heavily on keyword competition. "Trip planner" and "group travel" are moderately competitive.
- Tap-through rate depends on icon, screenshots, rating, and title. Well-optimized = 5%+. Generic = 2-3%.
- Download rate depends on screenshots, preview video, ratings, and reviews. 4.5+ star rating is critical.
- **Apple featuring can 10-50x impressions for 1-2 weeks.** If Tryps gets featured (e.g., "Apps We Love" or seasonal travel feature), it could generate 10K-50K downloads in a single week.

**Featuring probability:** Low but not zero. Apple features apps with great design, accessibility, and cultural relevance. Tryps' design quality (Krisna's Figma work) helps. Seasonal timing (pre-summer, pre-holidays) helps. Submitting through Apple's self-service featuring form is free.

**Verdict: 5K-30K downloads over 12 months organically. Potential 10K-50K bonus from featuring.** This is a background channel, not a primary driver — but it's free.

**Cost: $1,500-$3,000** (ASO optimization, screenshot design, keyword research).

---

### C2: Campus Ambassador Program (BeReal Model)

**Case study:** BeReal paid campus ambassadors $30/referral + bonuses. Pizza giveaways. University of Florida "BeReal Takeover" at football game (90K attendees, jumbotron). Result: dominant on US college campuses.

**The equation:**

```
Campuses × Ambassadors/campus × Downloads/ambassador/semester = Downloads
```

| Variable | Conservative | Mid | Aggressive |
|----------|-------------|-----|------------|
| Campuses | 10 | 25 | 50 |
| Ambassadors per campus | 1 | 2 | 3 |
| Downloads per ambassador/semester | 100 | 200 | 400 |
| **Total downloads** | **1,000** | **10,000** | **60,000** |

**Assumptions:**
- BeReal ambassadors earned $30-$50/download + $100-$300 monthly bonuses. That's $30-50 CAC — expensive.
- For Tryps, the model is different: target trip-planning moments (spring break, study abroad, graduation). One ambassador who gets 5 friend groups of 8 people to plan their spring break trip = 40 downloads from a single activation.
- **Lower CAC because the trip invite does the work.** Ambassador's job is to get ONE person in the group to create a trip. The invite flow handles the rest.
- Effective CAC: $10-20/download (ambassador stipend + pizza/swag divided by downloads).
- **Best beachhead campuses:** Large state schools with spring break culture, study abroad programs, Greek life. Not elite schools (too small).

**Cost model:**

| Scale | Ambassador cost | Events/swag | Total | Downloads | CAC |
|-------|----------------|-------------|-------|-----------|-----|
| 10 campuses | $15K/semester | $5K | $20K | 1K-4K | $5-20 |
| 25 campuses | $37K/semester | $12K | $49K | 5K-10K | $5-10 |
| 50 campuses | $75K/semester | $25K | $100K | 10K-30K | $3-10 |

**Tryps advantage over BeReal campus model:**
- BeReal needed EACH person to download separately. Tryps only needs one person per friend group — the invite flow handles the rest (3-5 additional downloads per seed).
- A campus ambassador who activates 20 trip-planning friend groups (avg 6 people each) = 120 downloads from 20 conversations. That's 6x leverage.

**Verdict: 5K-30K downloads with $50K-$100K investment. Best channel for high-quality users** (real friend groups planning real trips, not drive-by TikTok installs that churn).

---

### C3: PR / Earned Media

**The equation:**

```
Articles × Avg readers × Click-through to App Store × Download rate = Downloads
```

| Outlet tier | Avg readers | CTR | Download rate | Downloads/article |
|-------------|------------|-----|---------------|-------------------|
| TechCrunch / The Verge | 200K-500K | 2-4% | 20-30% | 800-6,000 |
| Travel blogs (Nomadic Matt, etc.) | 50K-200K | 3-5% | 25-35% | 375-3,500 |
| Product Hunt (launch day) | 30K-100K visitors | 5-10% | 15-25% | 225-2,500 |
| Local press / niche | 10K-50K | 1-3% | 15-25% | 15-375 |

**Realistic scenario over 12 months:**
- 1 TechCrunch mention: ~3K downloads
- 2-3 travel blog features: ~3K downloads
- Product Hunt launch: ~1K downloads
- 5-10 smaller mentions: ~2K downloads
- **Total: ~9K downloads**

**If a major outlet does a feature story (NYT, WSJ tech section, CNBC):**
- Add 10K-30K downloads from a single feature

**Assumptions:**
- Getting press without traction is hard. Most articles happen AFTER you have a story to tell (user growth, cultural moment, founder story).
- Partiful's press came from organic cultural moments (Timothee Chalamet lookalike contest, HBO's The Pitt mention). You can't manufacture this — but you can be ready for it.
- PR is a "lumpy" channel — nothing for weeks, then a burst.

**Cost: $3K-$5K** (press kit, freelance PR consultant, HARO subscription). Most PR spend at seed is founder time, not money.

**Verdict: 5K-15K downloads. Mostly free but unpredictable.** The real value is credibility for fundraising, not volume for growth.

---

### C4: SEO / Programmatic Content (Wanderlog Model)

**Case study:** Wanderlog generates 7.3M monthly website visits through programmatic travel guides ("things to do in [city]", "best restaurants in [destination]"). Each guide includes a CTA to plan the trip on Wanderlog.

**The equation:**

```
Pages published × Avg monthly organic traffic/page × Page-to-download conversion = Monthly downloads
```

| Variable | Month 1-3 | Month 4-6 | Month 7-12 |
|----------|-----------|-----------|------------|
| Pages published | 50 | 200 | 500 |
| Avg traffic/page/month | 10 | 50 | 200 |
| Conversion to download | 0.5% | 0.8% | 1.2% |
| **Monthly downloads** | **3** | **80** | **1,200** |

**12-month total: ~8,000 downloads** (backloaded — most come in months 9-12 as pages rank)

**Key assumptions:**
- SEO takes 6+ months to compound. This is a long game.
- Wanderlog's 7.3M monthly visits took years to build. We won't get there in year 1.
- Programmatic pages (city guides, "plan a trip to X") are feasible to generate at scale with AI.
- Conversion from web visitor → app download is low (0.5-1.5%) because the intent is informational, not transactional.

**Cost: $5K-$15K** (content infrastructure, hosting, maybe a freelance SEO consultant). Most "spend" is engineering time to build the programmatic content system.

**Verdict: <10K downloads in year 1. But 50K-100K/year by year 2-3 if invested early.** Best long-term channel, worst short-term channel.

---

### C5: Events & Partnerships

**Potential plays:**
- **Wedding expos:** Bach/bachelorette trip planning is a killer wedge. One booth at a bridal expo = hundreds of trip-planning groups.
- **Travel expos:** Wanderlog got 1,200 signups from one International Travel Expo.
- **Festival/concert partnerships:** "Plan your Coachella/Bonnaroo trip on Tryps" — partner with ticket platforms.
- **University study abroad offices:** Institutional distribution. One partnership = hundreds of student groups.
- **Corporate offsites:** Higher LTV, but different product positioning.

**Estimate: 2K-10K downloads from events over 12 months.** Highly dependent on which partnerships materialize.

---

## Summary: The Path to 100K

### Scenario 1: Tier 1 Budget ($25K, 12 months, no investment)

| Channel | Estimated Downloads | Cost | Notes |
|---------|-------------------|------|-------|
| Product-led invite loop | Multiplier (1.67x) | $0 | Engineering investment only |
| TikTok nano creators (10-15) | 8K-15K | $8K | Locket lite — fewer creators, lower budget |
| App Store organic + ASO | 5K-15K | $3K | Depends on reviews and featuring |
| PR / Product Hunt | 3K-10K | $3K | DIY press outreach |
| Campus ambassadors (5 campuses) | 1K-5K | $5K | Small pilot |
| Direct seeding (Jake's network) | 500-1K | $0 | Personal outreach to friend groups |
| Launch video | 1K-5K | $6K | Best case |
| **Direct subtotal** | **18.5K-51K** | **$25K** | |
| **After viral multiplier (1.67x)** | **31K-85K** | | |

**Honest assessment: Tier 1 gets us to 30K-85K downloads.** 100K is possible with strong viral mechanics and a bit of luck (App Store featuring or a viral moment). But it's not guaranteed.

**To reliably hit 100K on $25K, we need K > 0.6** — meaning the invite flow has to be exceptional and trip-creation rates have to be high.

---

### Scenario 2: Tier 2 Budget ($250K, 12 months, post-investment)

| Channel | Estimated Downloads | Cost | Notes |
|---------|-------------------|------|-------|
| Product-led invite loop | Multiplier (1.67x-2.5x) | $30K | Engineer dedicated to invite optimization |
| TikTok creator program (25 creators) | 30K-60K | $80K | 6-month program at nano/micro tier |
| Campus ambassadors (25 campuses) | 5K-15K | $50K | Full semester program |
| App Store organic + ASO | 10K-25K | $5K | Professional ASO, featuring submission |
| PR / earned media | 5K-15K | $10K | Freelance PR support, launch coordination |
| Referral program ($10 credit) | 5K-15K | $25K | Launches at 5K user mark |
| SEO / content | 3K-8K | $15K | Programmatic travel guides |
| Launch video | 2K-15K | $6K | Professional production |
| Events & partnerships | 2K-10K | $15K | 3-5 events + 2-3 partnerships |
| Contingency/doubling down | — | $14K | Reinvest in best-performing channel |
| **Direct subtotal** | **62K-178K** | **$250K** | |
| **After viral multiplier (1.67x)** | **103K-297K** | | |

**Honest assessment: Tier 2 reliably hits 100K downloads** even with conservative assumptions. Mid-case is ~170K. Optimistic case approaches 300K.

---

### Scenario 3: Blitz Mode ($500K+, if the viral loop is working)

If Tier 2 proves K > 0.6, double down:

| Channel | Investment | Expected downloads |
|---------|-----------|-------------------|
| Scale TikTok to 50 creators | +$200K | +60K-120K direct |
| Scale campus to 50 schools | +$100K | +15K-40K direct |
| Add paid social (retargeting proven audiences) | +$100K | +20K-40K direct |
| After viral multiplier (2.5x) | — | **237K-500K total** |

This is the "hit the gas" scenario once unit economics prove out.

---

## Channel Ranking: Where to Bet

| Rank | Channel | ROI | Confidence | Timeline | Investment |
|------|---------|-----|-----------|----------|------------|
| **#1** | **Invite loop optimization** | Infinite (free users) | High | Now | Engineering time |
| **#2** | **TikTok nano creators** | 3-8x (at 0.12% conv.) | Medium | Month 2-3 | $8K-$80K |
| **#3** | **Campus ambassadors** | 5-10x | Medium-High | Month 3-4 | $5K-$50K |
| **#4** | **App Store / ASO** | 10-30x (mostly free) | Medium | Now | $3K-$5K |
| **#5** | **PR / earned media** | High but unpredictable | Low | Month 2+ | $3K-$10K |
| **#6** | **Referral program** | 3-5x | Medium | After 5K users | $10K-$25K |
| **#7** | **SEO / content** | 20x+ (long-term) | High (but slow) | Month 6+ | $5K-$15K |
| **#8** | **Creator program (80 creators)** | 2-4x | Medium | Post-investment | $200K+ |
| **#9** | **Events / partnerships** | Variable | Low | Opportunistic | $5K-$15K |

---

## The Honest Version

Here's what I believe after running the numbers:

**1. There is no $25K path to 100K downloads.** Not without exceptional viral mechanics (K > 0.7) or a genuinely viral moment. The math doesn't work at that budget for reliable, plannable growth.

**2. There IS a $150K-$250K path to 100K downloads** — but it requires the viral loop to be working (K > 0.4). Without it, even $250K only gets you 60-80K direct downloads.

**3. The most important thing Jake can do right now is NOT marketing.** It's making the invite flow so good that K > 0.5. That means:
- The trip card must be so beautiful people screenshot and share it
- The invite link must open instantly and explain the trip in one glance
- Joining must be one tap (phone number only)
- The first contribution must happen in the first session (add your flight, vote on an activity)
- Push notifications must pull people back when the trip evolves

**4. The channel that matters most is the one you already have: the trip invite.** Every other channel is just feeding users into the top of the invite funnel. The invite funnel is where the real compounding happens.

**5. The $25K pre-investment plan should be treated as an experiment** — not "how do we get to 100K?" but "can we prove K > 0.4 with 500-1,000 real users?" If yes, raise money and execute Tier 2. If no, fix the product before spending more on marketing.

---

## Key Benchmarks to Watch

| Metric | 🔴 Bad | 🟡 OK | 🟢 Great |
|--------|--------|--------|----------|
| Invite → download conversion | <25% | 30-40% | >45% |
| % of invitees who contribute to trip | <20% | 30-40% | >50% |
| % of users who create own trip (6 mo) | <10% | 20-30% | >35% |
| K-factor | <0.2 | 0.3-0.5 | >0.6 |
| TikTok view → download | <0.05% | 0.08-0.15% | >0.2% |
| Campus ambassador downloads/semester | <50 | 100-200 | >300 |
| App Store conversion (impression → download) | <25% | 30-40% | >45% |

---

## Next Steps

1. **Finalize the invite flow** — this is the foundation everything else sits on
2. **Instrument K-factor tracking** — measure invites sent, conversion at each step, trip creation rates
3. **Run the $25K Tier 1 plan** — treat it as a K-factor experiment, not a growth campaign
4. **At 1K real users, measure K** — if K > 0.4, raise and execute Tier 2. If K < 0.2, diagnose and fix.
5. **At 5K users, launch referral program** — juice the viral loop
6. **At 10K users, scale TikTok creators to 25+** — pour gasoline
7. **At 25K users, add campus ambassadors at scale** — diversify acquisition
8. **At 50K users, consider paid social** — only with proven LTV and retention data

---

## Appendix: Source Benchmarks

| Benchmark | Source | Data Point |
|-----------|--------|------------|
| Locket TikTok creator program | Social Growth Engineers | 26 creators, 298M views, 80M+ downloads |
| Wispr Flow creator program | Tobin Tang (X thread) | ~80 creators, 500M+ views in 3 months |
| BeReal campus ambassadors | GrowthGirls / Contrary Research | $30/referral, 31.5M peak quarterly downloads |
| Partiful product-led growth | NoGood / Marketing Brew | 400% YoY MAU, 500K MAU, 3-person marketing team |
| TikTok view → install rates | Industry (FindMeCreators, Shortimize) | 0.05-0.5% range |
| App Store conversion benchmarks | AppTweak ASO reports | Impression → download: 25-45% |
| Referral program K-factors | Andrew Chen (a16z) | Dropbox: 35% of signups from referrals |
| Wanderlog SEO | CanvasBusinessModel | 7.3M monthly visits from programmatic content |
| Consumer app CAC | Industry benchmarks (2025-2026) | $5-15/install on Meta/TikTok |

---

*This model will be refined as we collect real data from Tier 1. Every assumption marked above should be replaced with actual measurements once available.*
