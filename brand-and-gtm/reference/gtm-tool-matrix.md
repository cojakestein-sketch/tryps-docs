---
title: "Brand & GTM — MECE Tool Matrix"
date: 2026-03-30
status: draft
owner: jake
purpose: "Master list of all needs across brand & GTM scopes, with tool options for team evaluation"
---

# Brand & GTM — MECE Tool Matrix

## Executive Summary

Tryps launches May 2, 2026. This document maps every capability the brand and go-to-market team needs to execute across 13 scopes, from brand book design to paid acquisition to press.

**The model:** Sean DeFaria is the creative director. He calls the shots on what gets made, reviews everything before it goes live, and manages key relationships (creators, press, partners). Behind Sean is a team — a mix of human contractors and AI agents — that produces what Sean directs, builds the infrastructure that powers distribution, and tracks what's working.

**What this document is for:** Before hiring or buying anything, Jake and Sean should walk through every need below and decide: do we buy a tool, build it ourselves, use an AI agent workflow, or skip it? This matrix gives you the options and a starting recommendation for each.

**The 13 scopes cover three layers:**

| Layer | Scopes | What it is |
|-------|--------|------------|
| **Creative** | 1-6 | What we make: brand book, social content, UGC, launch video, giveaways, physical assets |
| **Distribution** | 7-11 | How we get it out: search, referrals, app stores, paid ads, email |
| **Operations** | 12-13 | What powers everything: press/partnerships, analytics/automation |

**Monthly software budget:** $330-630/mo depending on creator tool. Plus ~$5.4-7.1K one-time for launch video, physical presence, and legal.

---

## How to Read the Tables

- **Need** — the specific capability required
- **Description** — what this means in plain English
- **Best in Class** — the top tool for this job, regardless of price
- **Alternative(s)** — cheaper or simpler options worth evaluating
- **Homegrow / Agent?** — could this be built internally or handled by an AI agent workflow?
- **Recommendation** — Claude's starting opinion (team should override)
- **Est. Cost** — monthly unless noted as one-time

---

## CREATIVE LAYER

---

### Scope 1: Brand Book

> The visual and strategic identity of Tryps, designed in Figma. 56 screens covering logo, color, typography, brand story, personality, and product glimmers. Sean owns design; 13 MUST screens due by April 2 (M1), remainder post-launch. The brand book is the internal source of truth for "how should Tryps look and feel?"

| # | Need | Description | Best in Class | Alt 1 | Alt 2 | Homegrow / Agent? | Rec | Est. Cost |
|---|------|-------------|--------------|-------|-------|-------------------|-----|-----------|
| 1.1 | Design production | Create 56 brand book screens (layouts, graphics, text) in presentation format | **Figma** (existing) | Canva | — | Pablo agent drafts screens; human polishes in Figma | Figma + agent drafts | $0 (existing) |
| 1.2 | Brand guidelines hosting | Share finalized brand rules with team, partners, and future hires in a browsable format | **Frontify** ($79/mo) | Notion page | Figma file as-is | Figma file works for now; Notion if you want something browsable | Stay in Figma | $0 |

---

### Scope 2: Socials

> All organic social media content across 8 platforms (TikTok, Instagram, X, YouTube Shorts, Facebook, LinkedIn, Snapchat, Pinterest). Sean directs what gets made; team produces assets; scheduling tool publishes. Content pillars: product demos ("Text Marty"), relatable group chat memes, trip inspiration, founder story, social proof/UGC. Target: 5 posts/week on 3 primary platforms (TikTok, IG, X), auto-repost to secondary platforms.

| # | Need | Description | Best in Class | Alt 1 | Alt 2 | Homegrow / Agent? | Rec | Est. Cost |
|---|------|-------------|--------------|-------|-------|-------------------|-----|-----------|
| 2.1 | Multi-platform scheduling | Queue and auto-publish posts across all 8 platforms from one dashboard | **Buffer** ($42/mo, 7 channels) | Metricool ($22/mo) | Later ($50/mo) | No — use a tool | Buffer or Metricool (trial both) | $22-42/mo |
| 2.2 | Short-form video editing | Cut screen recordings and footage into 15-60s social clips with transitions, text, music | **CapCut Pro** ($8/mo) | Descript ($24/mo) | DaVinci Resolve (free) | Rio agent for drafts; human polish in CapCut | CapCut Pro | $8/mo |
| 2.3 | Graphic/carousel creation | Design static images and multi-slide carousels for Instagram and X | **Canva Pro** ($13/mo/seat) | Figma | Adobe Express ($10/mo) | Pablo agent for drafts; Canva for fast production | Canva Pro (2 seats) | $26/mo |
| 2.4 | Auto-clip long video into shorts | Take a 60s video and automatically generate multiple 15s clips with different hooks | **Opus Clip** ($19/mo) | Vizard ($20/mo) | Descript clips | Tools are cheap enough; don't build this | Opus Clip | $19/mo |
| 2.5 | Brand asset storage | Central place for templates, logos, screen recordings, and finished assets so the team can find everything | **Google Drive** (free) | Air ($15/user/mo) | Notion | Don't buy a DAM tool at this stage | Google Drive | $0 |
| 2.6 | Social analytics | See engagement, reach, and follower growth across all platforms in one view | **Buffer analytics** (included) | Metricool (included) | Sprout Social ($199/mo, skip) | n8n can pull API data into a dashboard later | Start with scheduling tool's built-in analytics | $0 (included) |
| 2.7 | Hashtag/trend research | Find trending sounds, hashtags, and content formats on TikTok and Instagram | **TikTok Creative Center** (free) | Metricool trends | RiteTag ($49/yr) | Manual research is fine at this scale | TikTok Creative Center (free) | $0 |
| 2.8 | AI caption/copy generation | Generate platform-specific captions, hashtags, and copy variations in Tryps brand voice | **Claude** (existing) | Jasper ($49/mo) | Copy.ai | Agent workflow — Claude + brand voice prompt | Claude with brand SOUL.md | $0 (existing) |
| 2.9 | Product demo clips | Screen record app features and produce polished 15-sec clips with brand transitions and text callouts (Claude @claudeai style) | **CapCut templates** (manual) | Remotion (programmatic, open source) | After Effects | Remotion if GTM Engineer is technical; CapCut if not | Evaluate both — Remotion for scale, CapCut for speed | $0 |
| 2.10 | AI video generation | Generate teaser clips, ad variants, and motion graphics using AI video models | **Seedance Fast** ($0.04-0.12/clip) | Veo 3.1 ($1.60-3.20/clip) | Grok Video ($0.15-0.75/clip) | Rio agent uses these APIs via StableStudio | Seedance for drafts, Veo for finals | Variable |

---

### Scope 3: UGC Program

> Recruit, manage, and pay creators to post about Tryps at launch. Two tiers: 50 creators tested, top 25 retained (Locket playbook). Micro creators ($50-150 flat fee for Story shares), mid-tier creators ($200-500 for original content). 4-6 brand ambassadors hand-picked by Sean get affiliate links with per-text/per-trip payouts. Sean manages all relationships and DM outreach. Total creator budget: ~$8K separate from contractor costs.

| # | Need | Description | Best in Class | Alt 1 | Alt 2 | Homegrow / Agent? | Rec | Est. Cost |
|---|------|-------------|--------------|-------|-------|-------------------|-----|-----------|
| 3.1 | Creator discovery | Search for and identify creators matching Tryps criteria (10K-500K followers, lifestyle/travel/GRWM, real engagement) across TikTok and Instagram | **Stormy AI** (YC, AI-native) | Modash ($199/mo) | HypeAuditor ($299/mo) | Don agent + AgentCash APIs for research | Trial all: Stormy, Modash, HypeAuditor, Influencer Hero | TBD (trial) |
| 3.2 | Creator verification | Check that a creator's followers are real, engagement isn't bought, and audience demographics match Tryps' target (22-28, US, iPhone) | **HypeAuditor** ($299/mo) | Modash (included) | SocialiQ Chrome ext (free) | No — need real data for this | Include in 3.1 trial | Included |
| 3.3 | Creator pricing estimation | Calculate fair market rate for a creator based on follower count, engagement rate, platform, and content type | **HypeAuditor** (included) | Impulze.ai calculator (free) | MicroRate.site (free) | Free calculators + agent research | Include in 3.1 trial; free tools as backup | $0 |
| 3.4 | Outreach automation & CRM | Track who's been contacted, their response status, content deliverables, and payment status across 50+ creators | **Stormy AI** (automated negotiation, -43% fees) | Influencer Hero ($249/mo) | Notion/Airtable database | Sean manages relationships; tool handles tracking | Include in 3.1 trial | TBD |
| 3.5 | Creator payment | Pay 25-50 creators in batches of $50-500 each, track who's been paid | **PayPal Business** (batch, $0.25/payment) | Venmo (free) | Lumanu (enterprise) | PayPal or Venmo at this scale | PayPal Business for batch | ~$20/mo |
| 3.6 | Content rights management | Ensure Tryps can repost creator content and potentially use in paid ads, with FTC-compliant disclosure | **Influencer Hero** (included) | Manual contracts (Google Docs) | — | Google Doc template is fine for 50 creators | Manual contracts | $0 |
| 3.7 | Creator performance tracking | Know which creators drove the most engagement, clicks, and installs so you can cut underperformers and double down on winners | **Stormy AI** (included) | Manual spreadsheet + platform analytics | n8n pulling social APIs | Part of 3.1 trial; n8n as backup | Include in 3.1 trial | Included |
| 3.8 | Ambassador affiliate links | Give 4-6 brand ambassadors unique `jointryps.com/go/{name}` links that open iMessage pre-filled, track clicks and conversions per ambassador | **Branch** (free tier) | Homegrow redirect pages + Supabase | — | Homegrow the redirect pages; Branch for attribution | Branch + homegrow redirect pages | $0 |
| 3.9 | Ambassador dashboard | Let ambassadors see how many people clicked their link, texted, and created trips | — | — | — | Homegrow: simple web page pulling from Supabase | Homegrow | $0 |

---

### Scope 4: Launch Video

> A 60-second hero launch film ("However You Get To Us") directed by Sean. Desaturated white world, only color is Tryps Red on device screens. Five scenes showing different people texting Marty. Shot in NYC over 1 day. Cut into 4 versions: 60s (hero), 45s (X), 30s (TikTok/Reels), 15s (pre-roll). Budget: $2.5-4K. This is a human production — agents assist with teasers and drafts only.

| # | Need | Description | Best in Class | Alt 1 | Alt 2 | Homegrow / Agent? | Rec | Est. Cost |
|---|------|-------------|--------------|-------|-------|-------------------|-----|-----------|
| 4.1 | Video production | Film 5 scenes across 3-4 NYC locations in one day with a DP, grip, and 5 talent | **Sean + DP + crew** | — | — | Rio agent for teaser/draft cuts; real shoot for hero | Human production | $2,500-4,000 one-time |
| 4.2 | Color grading | Desaturate entire world to neutral white, preserve only Tryps Red (#D9071C) on device screens, restore full color for final plane shot | **DaVinci Resolve** (free) | Adobe Premiere ($23/mo) | Final Cut Pro ($300) | — | DaVinci Resolve (free, best color tools) | $0 |
| 4.3 | Music/SFX licensing | License a sparse piano track + iMessage sounds + room tone for a cinematic feel (Nils Frahm / Olafur Arnalds style) | **Artlist** ($10/mo) | Epidemic Sound ($13/mo) | Fiverr composition ($150-300) | — | Artlist or Epidemic Sound | $10-13/mo |
| 4.4 | Platform cuts | Edit the hero 60s into 45s, 30s, and 15s versions optimized for each platform's aspect ratio and pacing | CapCut or DaVinci | — | — | — | Same editor as hero cut | $0 (included) |

---

### Scope 5: Giveaways

> Contest campaigns designed to drive app downloads and Marty conversations at launch. Lead concept: "Marty Plans Your Dream Trip" — groups add Marty to their group chat, text a trip idea, screenshot and post to enter. Prize: $5K dream trip for winning group. Every entry is a product demo disguised as a giveaway post. Secondary concepts: Group Chat Race (competitive), Mystery Trip (chaotic). Budget: $5-8K for prizes + $300-500 legal.

| # | Need | Description | Best in Class | Alt 1 | Alt 2 | Homegrow / Agent? | Rec | Est. Cost |
|---|------|-------------|--------------|-------|-------|-------------------|-----|-----------|
| 5.1 | Contest platform | Host giveaway entry collection, enforce rules, track entries, and select winners — must support your iMessage-first entry mechanic (text Marty + post screenshot) | **Gleam** ($97/mo) | KingSumo (free tier) | Viral Loops ($49/mo) | Homegrow if mechanic is "text Marty + post screenshot" — standard tools may not fit | Evaluate if standard tool fits; may need custom | $0-97/mo |
| 5.2 | Legal review | Get official contest rules written by a lawyer to comply with state sweepstakes laws and avoid liability | **Lawyer** (one-time) | DIY with template | — | — | Get a lawyer | $300-500 one-time |
| 5.3 | Entry tracking | Monitor incoming entries (screenshots tagged #MartyPlanMyTrip), verify eligibility, count bonus entries from group members | Gleam (included) | Google Form + manual | Airtable | n8n workflow to track hashtag posts + DMs | Depends on 5.1 decision | Included or $0 |

---

### Scope 6: Physical Presence

> NYC street marketing campaign to create real-world brand awareness before and during launch. Wheat-paste posters on Bedford Ave and surrounding neighborhoods, die-cut stickers distributed at coffee shops and coworking spaces, Tryps-branded disposable film cameras gifted to creators and distributed at launch events. Total budget: ~$2,575. All materials ordered by April 7, deployed starting April 21, fully up by launch day May 2.

| # | Need | Description | Best in Class | Alt 1 | Alt 2 | Homegrow / Agent? | Rec | Est. Cost |
|---|------|-------------|--------------|-------|-------|-------------------|-----|-----------|
| 6.1 | Design files | Create print-ready poster designs, sticker artwork, and camera wrap graphics in Tryps brand (Red #D9071C, Plus Jakarta Sans, bold and minimal) | Figma or Canva | — | — | Pablo agent drafts; Sean approves | Canva (already in stack) | $0 (included) |
| 6.2 | Print production | Print 150 posters (24x36), 1,300 stickers (4 designs), and 40 camera vinyl wraps | **StickerMule** (stickers) | Vistaprint (posters) | Local NYC print shop | — | StickerMule + local print | $600-825 one-time |
| 6.3 | QR codes with tracking | Generate QR codes for posters and stickers that link to Tryps with attribution so you know how many scans came from street marketing | **Branch** (already in stack) | Bitly ($8/mo) | Free QR generators | Branch deep links with QR overlay — already in stack for referrals | Branch | $0 (included) |

---

## DISTRIBUTION LAYER

---

### Scope 7: SEO / GEO / AEO

> Make Tryps discoverable through search engines and AI assistants. SEO = rank on Google for "group trip planner app" and similar queries. GEO = optimize for AI-generated search results (Google AI Overviews, Perplexity). AEO = ensure AI assistants (ChatGPT, Claude, Perplexity) recommend Tryps when asked about group travel planning. AEO is the highest-leverage play for a 2026 launch — if someone asks an AI "what's the best app for planning a group trip?" you want Tryps in the answer. Pre-launch: basic site structure + 3-5 landing pages + schema markup. Post-launch: full program.

| # | Need | Description | Best in Class | Alt 1 | Alt 2 | Homegrow / Agent? | Rec | Est. Cost |
|---|------|-------------|--------------|-------|-------|-------------------|-----|-----------|
| 7.1 | AEO baseline & monitoring | Check how AI engines currently describe Tryps, then track whether your content efforts are improving AI recommendations over time | **AIclicks** ($49/mo) | HubSpot AEO Grader (free) | Peec AI ($99/mo) | Run HubSpot free grader first; upgrade if needed | HubSpot AEO Grader (free) then AIclicks | $0-49/mo |
| 7.2 | SEO keyword research | Find the exact search terms people use when looking for group travel planning tools, and track your ranking over time | **Ahrefs Lite** ($29/mo) | Ubersuggest ($29/mo) | Semrush ($130/mo, overkill) | — | Ahrefs Lite or Ubersuggest | $29/mo |
| 7.3 | Structured data / schema markup | Add machine-readable metadata to jointryps.com so search engines and AI assistants can parse what Tryps is, what it does, and how it's rated | **Schema.org manual implementation** | Yoast (WordPress only) | — | GTM Engineer implements directly in code | Homegrow | $0 |
| 7.4 | Landing pages | Build 3-5 SEO-optimized pages targeting high-intent keywords ("group trip planner app", "plan trip with friends", "travel group chat") | **Webflow** ($14/mo) | Framer ($5/mo) | Code directly on jointryps.com | GTM Engineer builds pages | Depends on current site stack | $0-14/mo |
| 7.5 | Content for AI citation | Write blog posts, comparison articles, and FAQs that AI engines will cite when recommending travel planning tools | **Write on jointryps.com/blog** | Get listed on Product Hunt, TechCrunch | Wikipedia travel apps list | Agent drafts; human edits for accuracy and voice | Agent + human workflow | $0 |
| 7.6 | Landing page redesign | Fix and redesign jointryps.com to properly convert visitors — clear value prop, Marty demo, download CTA, email capture, mobile-optimized. This is the front door for every paid ad, press mention, and organic search result. | **Webflow** ($14/mo) | Framer ($5/mo) | Code directly | GTM Engineer builds; Sean approves design direction | Depends on current site stack | $0-14/mo |

---

### Scope 8: Referrals & Viral Loops

> Make the product spread itself. Three sub-initiatives: (1) Trip invite optimization — make the iMessage rich link card so beautiful people screenshot and share it (the Partiful play). (2) Referral program — incentivize existing users to invite friends. (3) Dense network seeding — manually get 5-10 real friend groups actively using Tryps before launch so organic word-of-mouth starts from real usage, not marketing (the Nikita Bier / Gas app play).

| # | Need | Description | Best in Class | Alt 1 | Alt 2 | Homegrow / Agent? | Rec | Est. Cost |
|---|------|-------------|--------------|-------|-------|-------------------|-----|-----------|
| 8.1 | Trip invite link card design | Design beautiful OG image templates for trip invite links so they look stunning in iMessage, WhatsApp, and social shares — every invite should make people want to tap | **Custom design** (product team builds, brand team designs templates) | Cloudinary dynamic OG ($0-89/mo) | Vercel OG generation (free) | Coordinate: Asif/Nadeem build the system, Sean/designer creates the visual templates | Product + brand collab | $0 |
| 8.2 | Link preview testing | Verify that trip invite links render correctly across iMessage, WhatsApp, X, Instagram DMs, and Slack before launch | **metatags.io** (free) | Social Share Preview (free) | — | — | Free online tools | $0 |
| 8.3 | Deep linking | When someone taps a trip invite or referral link, route them to the right place — open the app if installed, App Store if not, preserving context through the install | **Branch** (free tier) | Adjust deep links | — | — | Branch | $0 |
| 8.4 | Referral program management | Track who referred whom, count successful referrals, and trigger rewards (trip credit, cash, or features) | **Viral Loops** ($49/mo) | ReferralCandy ($59/mo) | — | Homegrow if mechanic is simple (link → track → reward) | Evaluate Viral Loops; may be simpler to homegrow | $0-49/mo |
| 8.5 | Dense network seeding | Personally recruit 5-10 real friend groups to plan actual trips on Tryps before launch, creating organic word-of-mouth from genuine usage | **Manual** (Jake/Sean personal networks) | Ambassador outreach | Beta tester list | Not a tool problem — this is personal outreach | Personal outreach | $0 |
| 8.6 | Seed group incentives | Decide how to reward early friend groups for being first users (cash per referral like BeReal's $30-50, trip credit, or free features) | Cash referral (BeReal model) | Trip credit | Free premium features | — | Decide: cash vs. trip credit vs. features | Variable |
| 8.7 | Share tracking | Know how many times trip links are shared, by whom, and which shares convert to installs | **Branch** (included) | Supabase analytics | — | Already built into referral system | Branch | $0 |

---

### Scope 9: App Store & Product Hunt

> Optimize the two "storefronts" where people decide whether to download Tryps. App Store: video (slot 1) + 5 screenshots (slots 2-6) + keywords + description + ongoing A/B testing via Apple PPO. Product Hunt: launch day listing on May 2 coordinated with upvote rally from your network. Both are one-time setup with ongoing optimization.

| # | Need | Description | Best in Class | Alt 1 | Alt 2 | Homegrow / Agent? | Rec | Est. Cost |
|---|------|-------------|--------------|-------|-------|-------------------|-----|-----------|
| 9.1 | ASO keyword research | Find the search terms people type in the App Store when looking for travel planning apps, and optimize your metadata to rank for them | **AppTweak** ($69/mo) | ASO.dev ($20/mo) | Sensor Tower ($79/mo, overkill) | — | ASO.dev to start; AppTweak later | $20/mo |
| 9.2 | Screenshot/video A/B testing | Test different screenshot headlines, ordering, and video poster frames to maximize install conversion rate | **Apple PPO** (free, native) | — | — | — | Apple PPO — no third-party tool needed | $0 |
| 9.3 | Screenshot & video design | Create the App Store video (15s, per existing treatment) and 5 screenshot assets (1320x2868) with headlines and device frames | Figma + Canva | — | — | Pablo agent drafts; Sean approves | Canva (already in stack) | $0 (included) |
| 9.4 | Review monitoring | Get notified when users leave App Store reviews so you can respond quickly and track sentiment | **AppFollow** ($111/mo) | App Store Connect alerts (free) | — | n8n webhook for new reviews → Slack | Start with App Store Connect; add tool if volume grows | $0 |
| 9.5 | Install conversion tracking | Know how many people see your App Store page vs. actually download, broken down by source (search, referral, ad) | **AppsFlyer Zero** (free, 12K installs) | App Store Connect analytics (free) | — | — | AppsFlyer Zero + App Store Connect | $0 |
| 9.6 | Product Hunt listing | Prepare thumbnail, tagline, description, gallery images, first comment, and maker profile for a May 2 launch on Product Hunt | **Product Hunt** (free) | — | — | GTM Engineer preps assets; reuse App Store creative | Prep in advance, launch May 2 | $0 |
| 9.7 | PH launch day coordination | Rally your network to upvote in the first 4 hours of launch day (this determines your ranking) via email, Slack, DMs, and social posts | **Manual** — DM network, email blast, social posts | — | — | — | Manual coordination + email blast launch morning | $0 |

---

### Scope 10: Paid Acquisition

> Spend money to amplify what's already working organically. Primary channel: Meta (Instagram + Facebook) ads at $5K/month. Secondary: TikTok Spark Ads boosting top-performing UGC. Only start paid AFTER you have organic content that's proven to perform — take the best UGC clips, cut them into 50+ ad variants, test aggressively, scale winners. The Austin Lau model: build Claude Code workflows to generate ad copy and Figma variants in seconds, not hours.

| # | Need | Description | Best in Class | Alt 1 | Alt 2 | Homegrow / Agent? | Rec | Est. Cost |
|---|------|-------------|--------------|-------|-------|-------------------|-----|-----------|
| 10.1 | Ad account & pixel setup | Create Meta Business Manager account, install tracking pixel on jointryps.com, configure conversion events (install, trip created) | **Meta Business Manager** (free) | — | — | — | Meta Business Manager | $0 |
| 10.2 | Creative research | See what ads competitors and similar apps are running, save winning formats as inspiration for your own creative | **Foreplay** ($49/mo) | Meta Ad Library (free) | Atria (free tier) | — | Foreplay | $49/mo |
| 10.3 | Ad variant automation | Take raw UGC clips from creators and automatically generate dozens of testable ad variants with different hooks, lengths, and CTAs | **Recharm** ($99/mo) | Sovran (custom pricing) | Manual editing in CapCut | — | Recharm | $99/mo |
| 10.4 | Creative analytics | Know which ad creative elements (hook type, creator, format, CTA) are driving performance so you can make more of what works | **Motion** ($250/mo) | Meta native reporting (free) | — | — | Meta native at $5K/mo; Motion when you hit $20K+ | $0 (start native) |
| 10.5 | Attribution | Know which ad, creator, or channel drove each install so you can calculate ROI per dollar spent | **AppsFlyer Zero** (free) + **Branch** | Adjust | — | — | AppsFlyer + Branch (already in stack) | $0 |
| 10.6 | TikTok Spark Ads | Boost the best-performing organic UGC directly from creators' accounts (appears as their post, not your ad) — highest-converting ad format on TikTok | **TikTok Ads Manager** (free tool) | — | — | — | TikTok Ads Manager | $0 (tool) + ad spend |
| 10.7 | Ad copy generation | Generate dozens of headline and description variants for Meta and TikTok ads in Tryps brand voice, optimized for character limits and platform conventions | **Claude Code slash command** (build /rsa equivalent for Meta) | Jasper ($49/mo) | — | Agent workflow — Austin Lau built exactly this at Anthropic | Homegrow — Claude Code + brand voice prompt | $0 |
| 10.8 | Figma → ad variant pipeline | Paste headline copy into Figma, click one button, get dozens of ad images across multiple aspect ratios (Austin Lau built this in 45 min) | **Custom Figma plugin** (built with Claude Code) | Manual Figma workflow | Canva bulk resize | GTM Engineer builds this with Claude Code | Homegrow — replicate Austin's Figma plugin | $0 |

---

### Scope 11: Email & Lifecycle

> Email as a channel for launch announcements, onboarding sequences, and retention. Pre-launch: capture emails on jointryps.com waitlist. Launch day: blast announcement with download link. Post-install: onboarding drip (welcome → first trip → invite friends → explore features). Not a huge scope for launch, but needs to be wired up before May 2.

| # | Need | Description | Best in Class | Alt 1 | Alt 2 | Homegrow / Agent? | Rec | Est. Cost |
|---|------|-------------|--------------|-------|-------|-------------------|-----|-----------|
| 11.1 | Email platform | Send launch announcements and automated onboarding drip sequences triggered by user actions (signup, first trip, etc.) | **Loops** ($49/mo, built for product-led apps) | Resend ($20/mo) | Mailchimp (free tier) | — | Loops — designed for app onboarding | $49/mo |
| 11.2 | Email template design | Create on-brand email templates that match Tryps visual identity (Plus Jakarta Sans, warm tone, minimal, Tryps Red accents) | **Loops** (included) | Canva email templates | — | Agent drafts copy; human designs layout | Loops built-in templates | $0 (included) |
| 11.3 | Email list building | Capture emails from people who visit jointryps.com before launch so you can blast them on May 2 | **Waitlist on jointryps.com** | Tally form (free) | Carrd landing page ($19/yr) | Homegrow on existing site | Add email capture to jointryps.com | $0 |
| 11.4 | Transactional email | Send trip confirmations, invite notifications, and payment receipts — likely a product team concern, not GTM | **Resend** ($20/mo) | Supabase + SMTP | SendGrid (free tier) | Coordinate with Asif — may already exist in the app | Check with product team first | $0-20/mo |

---

## OPERATIONS LAYER

---

### Scope 12: Press & Partnerships

> Get Tryps covered by tech and travel press at launch, and build co-marketing relationships with travel brands post-launch. Press: target TechCrunch, The Verge, travel blogs, and App Store editorial. Prep a press kit, build a journalist list, pitch personally. Partnerships: post-launch — co-marketing with airlines, Airbnb, festival organizers. Cold start; no existing relationships.

| # | Need | Description | Best in Class | Alt 1 | Alt 2 | Homegrow / Agent? | Rec | Est. Cost |
|---|------|-------------|--------------|-------|-------|-------------------|-----|-----------|
| 12.1 | Press outreach | Find and pitch journalists who cover consumer apps, travel tech, and startup launches | **DIY with journalist list** | Pressfarm ($90/mo, journalist database) | PR agency ($3-10K/mo, skip for now) | Agent can research journalists; human sends pitches | DIY first — Pressfarm if needed | $0-90/mo |
| 12.2 | Press kit | Create a downloadable page with Tryps logo, screenshots, founder bio, one-pager, and brand assets so journalists can write about you without asking for materials | **Dedicated /press page on jointryps.com** | Notion page (public) | Google Drive folder | — | Build /press page on jointryps.com | $0 |
| 12.3 | Journalist database | Build a list of 50-100 relevant journalists with contact info, beat, and recent coverage for targeted outreach | **Pressfarm** ($90/mo) | Muck Rack ($250/mo, overkill) | Manual research | Agent + Exa/AgentCash to research travel tech journalists | Trial Pressfarm; agent research as backup | $0-90/mo |
| 12.4 | Partner research (post-launch) | Identify travel brands, airlines, Airbnb hosts, and festival organizers who could co-market with Tryps | **Apollo** (via AgentCash) | LinkedIn Sales Navigator ($80/mo) | Manual research | Don agent + AgentCash APIs to build prospect list | Agent research | Variable |
| 12.5 | Partnership outreach (post-launch) | Reach out to potential partners with co-marketing proposals once Tryps has post-launch traction and credibility | **Manual email** | — | — | — | Cold email + warm intros | $0 |

---

### Scope 13: Analytics & Operations

> The infrastructure that powers everything else. Marketing automation (n8n/Make workflows that move data between tools), performance dashboards (cross-platform view of what's working), agent observability (LangFuse tracking agent costs and quality), cost tracking (investor-ready burn breakdown), and Slack integrations (automated alerts when something pops or breaks).

| # | Need | Description | Best in Class | Alt 1 | Alt 2 | Homegrow / Agent? | Rec | Est. Cost |
|---|------|-------------|--------------|-------|-------|-------------------|-----|-----------|
| 13.1 | Marketing automation | Connect tools together: "when UGC posts → pull metrics → log to sheet" or "when affiliate link clicked → log → notify Sean" | **n8n self-hosted** on Hetzner ($0, unlimited) | Make ($11/mo, 10K ops) | Zapier ($30/mo, expensive at scale) | n8n on Marty's Hetzner server is free and unlimited | n8n self-hosted or Make | $0-11/mo |
| 13.2 | Cross-platform dashboard | See performance across all social platforms, ad campaigns, and creator content in a single view updated daily | **Google Looker Studio** (free) + API connections | Metricool ($22/mo, included analytics) | Databox ($72/mo) | n8n pulls data → Google Sheet → Looker Studio | Start with scheduling tool analytics; build Looker Studio when ready | $0-22/mo |
| 13.3 | Agent observability | Track every AI agent call (input, output, tokens, cost, success/fail) in a dashboard so you know what agents are spending and where they're failing | **LangFuse Cloud** ($0 free, $29/mo Core) | — | — | — | LangFuse Cloud — already in agentic org plan | $0-29/mo |
| 13.4 | Cost tracking | Maintain an investor-ready breakdown of total monthly burn: human contractors + agent costs + SaaS tools + ad spend, updated daily | **LangFuse + manual spreadsheet** | — | — | Marty cron updates daily from LangFuse actuals | LangFuse actuals + manual contractor costs | $0 |
| 13.5 | UTM link management | Maintain consistent UTM naming conventions across all links so you can trace any traffic back to the exact campaign, platform, and content piece | **Google Sheet template** | UTM.io ($25/mo) | — | Spreadsheet template with naming convention | Google Sheet | $0 |
| 13.6 | Slack notifications | Auto-post daily performance summaries, high-performer alerts, payment reminders, and review notifications to team Slack channels | **n8n → Slack webhook** | Make → Slack | — | Homegrow with n8n | n8n workflow | $0 |

---

## Budget Summary

### Monthly Software (Recommended Stack)

| Tool | Serves Scope(s) | Monthly Cost |
|------|-----------------|-------------|
| Buffer or Metricool | 2 (Socials) | $22-42 |
| CapCut Pro | 2 (Socials), 4 (Video) | $8 |
| Canva Pro (2 seats) | 2, 6, 9 (Graphics across scopes) | $26 |
| Opus Clip | 2 (Socials) | $19 |
| Foreplay | 10 (Paid Acquisition) | $49 |
| Recharm | 10 (Paid Acquisition) | $99 |
| Branch + AppsFlyer Zero | 3, 8, 9, 10 (Attribution across scopes) | $0 |
| Creator tool (TBD from trial) | 3 (UGC) | $0-299 |
| ASO.dev | 9 (App Store) | $20 |
| Ahrefs Lite or Ubersuggest | 7 (SEO) | $29 |
| Loops | 11 (Email) | $49 |
| Artlist or Epidemic Sound | 4 (Video) | $10-13 |
| n8n self-hosted or Make | 13 (Operations) | $0-11 |
| LangFuse Cloud | 13 (Operations) | $0-29 |
| **Total (low end)** | | **~$330/mo** |
| **Total (high end)** | | **~$690/mo** |

### One-Time Costs

| Item | Scope | Cost |
|------|-------|------|
| Launch video production | 4 | $2,500-4,000 |
| Physical presence (print + cameras) | 6 | $2,575 |
| Giveaway legal review | 5 | $300-500 |
| **Total one-time** | | **$5,400-7,100** |

### Ongoing Variable Costs

| Item | Scope | Monthly Cost |
|------|-------|-------------|
| Meta ad spend | 10 | $5,000 |
| TikTok ad spend | 10 | TBD |
| Creator payments | 3 | ~$2,000-4,000 (spread over 2 months) |
| AI video generation (Seedance/Veo) | 2 | ~$10-50 |
| Press database (if needed) | 12 | $0-90 |

---

## Evaluation Checklist for Team

For each need above, the GTM team + Sean should answer:

- [ ] Do we actually need this for launch, or is it post-launch?
- [ ] Should we buy the best-in-class tool?
- [ ] Should we use a cheaper alternative?
- [ ] Can an agent/AI workflow handle this instead?
- [ ] Should we homegrow this?
- [ ] Who owns this? (Sean / GTM Engineer / Workflow Engineer / Product team)

---

## Tool Trial Priority (Week 1 for GTM Engineer)

| Priority | What to trial | Tools | Decision by |
|----------|--------------|-------|-------------|
| 1 | Creator discovery + pricing + verification | Stormy AI, Modash, HypeAuditor, Influencer Hero, free tools | End of week 1 |
| 2 | Scheduling + publishing | Buffer vs Metricool | End of week 1 |
| 3 | Ad variant automation | Recharm free trial | End of week 1 |
| 4 | Email platform | Loops vs Resend | End of week 2 |
| 5 | Remotion vs CapCut templates | Build one product demo in each | End of week 2 |
