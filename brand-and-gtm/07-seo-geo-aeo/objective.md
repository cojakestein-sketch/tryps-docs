---
id: seo-geo-aeo
parent: brand-and-gtm
title: "SEO / GEO / AEO"
owner: Digital Presence Strategist (hiring)
created: 2026-03-24
updated: 2026-04-02
---

# SEO / GEO / AEO

> Make Tryps the answer when anyone — human or AI — asks how to plan a group trip.

## Context

Two agencies (Meridian) scoped this work at $6,500/mo managed. We're doing it in-house with one person + AutoResearchClaw as a research/content multiplier. The Meridian proposals define what "good" looks like; we're replicating the output, not the cost structure.

### What Meridian Would Have Done (Reference)

**Meridian SOW ($6,500/mo, 3 months):**
- 1 Deep Research Page/mo (1,800-3,500 words, competitive gap mapping, schema, 2 revision rounds)
- 10 AEO Support Pages/mo (800-1,500 words, template-driven, 1 revision round)
- On-page AEO optimization (structured data, schema markup, site architecture)
- Product-level AEO (product detail pages optimized for AI citation)
- 10 editorial/PR pitches per month
- Authority gap mapping
- 1 AEO experiment per month
- Share-of-voice reporting across 7 AI platforms (ChatGPT, Perplexity, Gemini, Google AI Overviews, Grok, Copilot, AI Mode)
- 400 unique daily prompts tracked, 100K monthly responses analyzed
- Sentiment & error detection
- Bi-weekly live meetings, Slack support

**Meridian Slides ($6,500/mo, 6 months):**
- Week 1: Brand & competitive audit, response capture & normalization, multi-dimensional evaluation, structured data cuts
- Weeks 2-4: Citation signal analysis (what sources LLMs cite), sentiment & entity mapping (how AI describes Tryps), recommendation triggers (what prompts surface competitors)
- Weeks 3-7: Execute across owned media (blog, FAQs, landing pages), earned media (editorial placements), social optimization, marketplace listings, technical AEO (schema, crawlability), reporting
- Weeks 8-12: Measure results — AI-driven traffic spikes, visibility score growth, citation appearances

### The Wispr Flow Question

Wispr Flow cut SEO entirely: "No one is searching for voice dictation." Is anyone searching for group trip planning? **This is the first research question.** Traditional SEO may be low-ROI, but AEO (getting Tryps cited in AI answers) is a different game — the Meridian pitch is right that AI engines are becoming the first stop for travel discovery. The answer is probably: traditional SEO is medium-priority, AEO is high-priority.

---

## Three Layers

### Layer 1: AEO (AI Engine Optimization) — HIGH PRIORITY

**Goal:** When someone asks ChatGPT, Perplexity, Gemini, or Google AI "what's the best app for planning a group trip," Tryps is in the answer.

**What determines AI citations:**
- High-authority content on your own site that AI crawlers can find and parse
- Third-party mentions on editorial sites, directories, and comparison pages
- Structured data (schema.org markup) that AI systems can read
- Consistent entity information across the web (name, description, category)
- Recency and freshness of content

**Deliverables:**
- [ ] **Baseline audit:** Ask all 7 major AI platforms the top 50 group travel queries. Document who gets cited, where Tryps appears (or doesn't), what vocabulary AI uses for the category. This is the AutoResearchClaw job.
- [ ] **Prompt library:** Build and maintain a library of 200+ prompts that a Tryps customer might ask an AI. Categorize by intent: discovery ("best group trip app"), comparison ("Tryps vs Splitwise"), how-to ("how to plan a bachelorette trip"), problem ("splitting costs with friends").
- [ ] **Deep Research Pages (DRPs):** 1-2/month. Long-form (2,000+ words), authoritative, comparison/guide content. Examples: "The Complete Guide to Planning a Group Trip in 2026," "Group Trip Apps Compared: Tryps vs Splitwise vs Google Docs vs the Group Chat."
- [ ] **AEO Support Pages (ASPs):** 5-10/month. Shorter (800-1,500 words), template-driven, targeting long-tail prompts. Examples: "How to Split Costs on a Bachelorette Trip," "Best Apps for Planning Spring Break with Friends."
- [ ] **On-page AEO:** Schema markup on jointryps.com — SoftwareApplication schema, FAQ schema, HowTo schema, Review schema. Ensure AI crawlers can parse the site.
- [ ] **Share-of-voice tracking:** Monthly report showing Tryps citation rate across AI platforms for priority prompts, benchmarked against competitors.
- [ ] **AEO experiments:** 1/month. Structured test of a content or technical change, measuring impact on AI citations. Document findings, feed into next sprint.

### Layer 2: GEO (Generative Engine Optimization) — MEDIUM PRIORITY

**Goal:** Optimize specifically for AI-generated search results (Google AI Overviews, Perplexity answers) which blend traditional search signals with generative AI.

**Deliverables:**
- [ ] **Google AI Overviews tracking:** Monitor which queries trigger AI Overviews in the travel/group planning space. Identify opportunities where Tryps content could be cited.
- [ ] **Citation-optimized content structure:** All DRPs and ASPs use structures that generative engines prefer: clear headers, factual claims with sources, comparison tables, step-by-step instructions, FAQ sections.
- [ ] **Authority signal building:** 10 editorial pitches/month to travel, tech, and lifestyle publications. Goal: backlinks from high-authority sites that AI engines use as citation sources.

### Layer 3: Traditional SEO — LOWER PRIORITY (validate first)

**Goal:** Rank on Google for group trip planning keywords — but only if the search volume justifies the effort.

**Deliverables (conditional on research):**
- [ ] **Keyword research:** Use Ahrefs to map search volume for group travel queries. If total addressable search is <5,000 searches/month for core terms, deprioritize traditional SEO.
- [ ] **3-5 landing pages:** If keyword research justifies it, build targeted landing pages: "Group Trip Planner," "Best App for Planning Trips with Friends," "Split Travel Costs."
- [ ] **Technical SEO basics:** Site speed, mobile-first, XML sitemap, robots.txt, canonical tags. These also help AEO, so do them regardless.

---

## AutoResearchClaw Integration

AutoResearchClaw v0.4.0 is the research engine that powers this scope. The human strategist directs research questions, reviews outputs at checkpoints, and turns findings into action. The tool does the legwork.

### Research Loop 1: Baseline Audit (Week 1)

**Mode:** `co-pilot` (human guides at each stage)

**Seed question:** "For a consumer group travel planning app called Tryps (jointryps.com) targeting 20-somethings, establish a complete AI visibility baseline. Query all major AI platforms (ChatGPT, Perplexity, Gemini, Google AI Overviews, Grok, Copilot) with 50+ prompts covering: discovery queries ('best group trip app'), comparison queries ('Tryps vs Splitwise'), problem queries ('how to split costs on a group trip'), and intent queries ('plan a bachelorette trip with friends'). For each query, document: which brands are cited, what sources are linked, what vocabulary the AI uses, and where Tryps appears or doesn't."

**Idea Workshop:** Refine which 50 prompts matter most. Brainstorm prompt clusters the team hasn't considered.

**Pipeline Branching:** Branch into "prompts where we already appear" vs "prompts where competitors appear and we don't" — attack the gaps first.

**Output:** Baseline visibility report. Share-of-voice score. Gap map. Priority prompt list.

### Research Loop 2: Competitive Content Analysis (Week 2)

**Mode:** `checkpoint` (mostly autonomous, human reviews at gates)

**Seed question:** "Analyze the content strategies of Tryps' competitors in the AI citation landscape: Splitwise, TripIt, Wanderlog, Google Trips, Partiful. For each: what pages on their site get cited by AI? What content structures perform best? What schema markup do they use? What third-party sites mention them? Identify the gap between their authority signals and Tryps'."

**Claim Verification:** Cross-reference competitive analysis against actual AI responses — don't just assume a competitor's content is being cited, verify it.

**Output:** Competitive authority map. Content structure templates. Technical AEO checklist.

### Research Loop 3: Content Production Pipeline (Ongoing, Monthly)

**Mode:** `gate-only` (autonomous draft, human approves before publish)

**Seed question:** "Draft a Deep Research Page targeting the prompt cluster: [specific cluster from baseline audit]. The page should be 2,000+ words, include comparison tables, step-by-step instructions, FAQ section, and be structured for maximum AI citation probability. Use Tryps brand voice: casual but authoritative, group chat energy, never corporate."

**Cost Guardrails:** Cap at $X per research loop to control API spend.

**Output:** Draft DRP ready for human review and publish. Repeat monthly.

### Research Loop 4: Monthly Monitoring (Ongoing)

**Mode:** `express` (fast, mostly autonomous)

**Seed question:** "Re-run the baseline prompt library against all 7 AI platforms. Compare citation rates to last month. Flag any new competitors appearing, any Tryps citations gained or lost, any model updates that changed results. Highlight the 3 biggest opportunities and 3 biggest risks."

**Output:** Monthly share-of-voice delta report. Feeds into next month's content priorities.

---

## Founder Presence Optimization (Bundled with this role)

This person also owns making Jake Stein and Tryps look professional, legitimate, and discoverable across the internet.

### Scope

- **Jake Stein personal profiles:** LinkedIn, X, personal site/bio page, MIT directory, AngelList/Wellfound, Crunchbase
- **Tryps entity profiles:** Crunchbase, Product Hunt, App Store, Google Business Profile, directory listings (Product Hunt, AlternativeTo, G2, etc.)
- **Cross-pollination:** Jake's personal brand reinforces Tryps, Tryps press reinforces Jake's founder profile
- **Speaking/media bio:** Maintain a current, compelling founder bio and headshot package for press, events, and MIT

### Deliverables

- [ ] **Profile audit:** Review all Jake + Tryps profiles across platforms. Score each for completeness, accuracy, brand alignment, and searchability.
- [ ] **Profile optimization pass:** Update all profiles to current brand, consistent messaging, correct links. Ensure Jake's profiles mention Tryps, Tryps profiles link to Jake.
- [ ] **LinkedIn content strategy:** 1-2 posts/week from Jake's account. Founder voice, not corporate. Travel stories, building-in-public, group trip insights. This person drafts; Jake approves and posts.
- [ ] **Entity consistency:** Ensure "Tryps," "jointryps.com," "Jake Stein," and "MIT" appear consistently across all platforms. AI engines use entity consistency as a trust signal.
- [ ] **Directory submissions:** Submit Tryps to 20+ relevant directories (AlternativeTo, Product Hunt, G2, SaaSHub, etc.) to build authority signals.
- [ ] **Ongoing monitoring:** Set up alerts for brand mentions (Tryps, Jake Stein, jointryps.com). Respond to or flag any negative/incorrect information.

---

## Additional Scopes This Role Owns

### Scope 11: Email & Lifecycle (partial)

This person writes the email copy and strategy. The Infra Engineer (Enen) builds the Loops workflows and technical implementation.

- [ ] Launch announcement email
- [ ] Welcome/onboarding drip sequence (3-5 emails)
- [ ] Waitlist nurture sequence
- [ ] Monthly newsletter strategy

### Scope 12: Press & Partnerships (research + outreach)

- [ ] Build journalist target list (50 contacts covering travel, tech, consumer apps, MIT/college)
- [ ] Write press kit (one-pager, founder bio, product screenshots, brand assets)
- [ ] Draft pitch templates for launch outreach
- [ ] Execute outreach — 10 pitches/month (same as Meridian's scope)
- [ ] Track placements and build relationships for post-launch partnerships

### Scope 09: App Store & Product Hunt (copy + ASO, partial)

The research/writing side. Growth Engineer owns the visual side (screenshots, video).

- [ ] App Store copy: title, subtitle, description, keywords
- [ ] ASO keyword research and optimization
- [ ] Product Hunt listing copy and preparation
- [ ] App Store A/B test copy variants

---

## Success Metrics

### The Jake Stein Problem (Priority Zero)

**Right now, searching "Jake Stein" on AgentCash, Google, ChatGPT, and most enrichment tools returns the WRONG person** — Jake Stein the Co-founder/CEO of Common Paper (legal tech, YC, Philadelphia, ex-RJMetrics/Stitch/Talend). That Jake Stein has a decade of press, Crunchbase entries, Apollo enrichment data, and LinkedIn authority.

Our Jake Stein — Tryps founder, MIT fall 2026 — is essentially invisible. This is the single most concrete failure state for this scope: if you search "Jake Stein" and Tryps doesn't appear, we haven't done our job.

**What "fixed" looks like:**
- [ ] **Google:** Searching "Jake Stein Tryps" returns our Jake on page 1. Searching "Jake Stein" shows our Jake within the first 2 pages (harder — the other guy has 15+ years of SEO equity).
- [ ] **ChatGPT / Claude / Perplexity / Gemini:** Asking "Who is Jake Stein, founder of Tryps?" returns accurate, current information. Asking "Who is Jake Stein?" includes Tryps Jake alongside Common Paper Jake (entity disambiguation).
- [ ] **AgentCash / enrichment tools (Apollo, Clearbit, etc.):** Jake Stein + Tryps returns the correct person with correct email, role, company, and photo. This requires updating structured data sources these tools crawl.
- [ ] **LinkedIn:** Jake's profile is the top result for "Jake Stein Tryps" and competes for "Jake Stein."
- [ ] **Instagram / X:** Profiles are verified, current, and clearly associated with Tryps.

**How to fix it:**
1. **Entity signals everywhere.** Create and update Crunchbase (Tryps + Jake Stein as founder), AngelList/Wellfound, LinkedIn, Product Hunt maker profile, personal site (jakeste.in or similar) — all consistently linking Jake Stein ↔ Tryps ↔ jointryps.com ↔ MIT.
2. **Structured data on jointryps.com.** Add Person schema (founder), Organization schema (Tryps), sameAs links to all social profiles. This is how Google and AI engines disambiguate entities.
3. **Content that creates association.** Press mentions, blog posts, LinkedIn posts — every piece of content reinforces "Jake Stein, founder of Tryps." The more times this co-occurrence appears on authoritative sites, the faster AI engines learn the association.
4. **Enrichment data correction.** Manually submit corrections to Apollo, Clearbit, ZoomInfo, and similar platforms. These are the sources AgentCash and other tools crawl.
5. **Wikipedia / knowledge panel seeding.** Long-term: enough press coverage to warrant a Crunchbase-sourced Google Knowledge Panel for Tryps, which would disambiguate Jake Stein in Google results.

### Quantitative Metrics

| Metric | Baseline (Day 1) | Target (Month 3) |
|--------|-------------------|-------------------|
| "Jake Stein Tryps" → correct person (across platforms) | Fails on most | 100% correct |
| "Jake Stein" → includes Tryps Jake (Google) | Not on first 5 pages | Page 1-2 |
| "Jake Stein" → includes Tryps Jake (AI engines) | Not mentioned | Mentioned alongside other Jake Stein |
| AI share-of-voice (top 50 prompts) | TBD (baseline audit) | 15% citation rate |
| DRPs published | 0 | 3 |
| ASPs published | 0 | 20-30 |
| Editorial placements secured | 0 | 5-10 |
| Directory listings | 0 | 20+ |
| Profile completeness (Jake + Tryps) | TBD | 100% across all platforms |
| Email sequences live | 0 | 3 (welcome, nurture, launch) |
| Press pitches sent | 0 | 30 |

---

## Timeline

### Month 1: Foundation

- Week 1: AutoResearchClaw baseline audit. Profile audit (Jake + Tryps). Keyword research.
- Week 2: Competitive content analysis. First 5 ASPs drafted. All profiles updated.
- Week 3: First DRP published. Schema markup implemented. Press kit written. Journalist list started.
- Week 4: First AEO experiment. Email sequences drafted. 10 directory submissions. First monthly share-of-voice report.

### Month 2: Acceleration

- DRP #2 published. 10 more ASPs. First editorial pitches sent. LinkedIn content cadence established. Product Hunt listing prepared. Email sequences live.

### Month 3: Optimization

- DRP #3 published. 10 more ASPs. AEO experiments informing content strategy. Press outreach ongoing. Share-of-voice measurably improving. All systems running.

---

## Budget (In-House vs Agency)

| | Meridian (agency) | In-House |
|---|---|---|
| Monthly cost | $6,500/mo | ~$2,000-3,000/mo (contractor) |
| Term | 3-6 months | Ongoing |
| AutoResearchClaw | N/A | ~$50-100/mo (API costs) |
| Tools (Ahrefs, ASO.dev) | N/A (their tools) | ~$100-200/mo |
| **Total monthly** | **$6,500** | **~$2,500-3,500** |
| **3-month total** | **$19,500** | **~$7,500-10,500** |

Savings: ~$9,000-12,000 over 3 months, plus you own the person, the process, and the institutional knowledge.
