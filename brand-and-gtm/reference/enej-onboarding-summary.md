# Enej Stanovnik — GTM Infra Onboarding Summary
**Date:** April 2, 2026
**Prepared for:** Jake + Sean (noon ET call)
**Prepared by:** Enej Stanovnik (GTM Infrastructure Engineer)

---

## 1. Enej's Product Understanding

Enej grasps the core mechanics of Tryps — iMessage-native, AI agent plans group trips, faster than the Google Docs + Splitwise + group chat stack. Through the session he sharpened his understanding of two key nuances: (1) the product is specifically for **group trip planning**, not solo travel, and the core value is removing the coordination tax from the person who always ends up doing the work; (2) the target user is specific — 22-28, post-grad, iPhone, social, the friend group organizer. His initial answer was too broad ("everyone who uses the internet") but he absorbed the correction quickly. He understands his role clearly: build the pipes, don't touch the creative, make Sean's distribution machine run.

---

## 2. Scope Ownership Map

| #   | Scope                    | Owner                  | Enej's Role                                                 | Confidence |
| --- | ------------------------ | ---------------------- | ----------------------------------------------------------- | ---------- |
| 01  | Brand Book               | Sean                   | Hands-off                                                   | High       |
| 02  | Socials                  | Sean (creative)        | Infra — scheduling, analytics, auto-repost                  | High       |
| 03  | UGC Program              | Sean (relationships)   | Tools — creator CRM, Branch links, performance dashboard    | High       |
| 04  | Launch Video             | Sean                   | Hands-off                                                   | High       |
| 05  | Giveaways                | Sean                   | Build contest mechanics                                     | Medium     |
| 06  | Physical Presence        | Sean (design)          | QR codes via Branch                                         | High       |
| 07  | SEO / GEO / AEO          | Enej + TBD writer      | Schema markup, page builds — NOT content writing            | High       |
| 08  | Referrals & Viral Loops  | Enej                   | Own — Branch deep links, referral tracking                  | High       |
| 09  | App Store & Product Hunt | Enej                   | ASO tools setup, keyword tracking                           | High       |
| 10  | Paid Acquisition         | Enej + Growth Marketer | Meta pixel install + tooling (Growth Marketer runs spend)   | High       |
| 11  | Email & Lifecycle        | Enej                   | Own — Loops setup, email capture, drip sequences            | High       |
| 12  | Press & Partnerships     | Sean                   | Build /press page only                                      | High       |
| 13  | Analytics & Operations   | Enej                   | Own — n8n automations, dashboards, Slack alerts, UTM system | High       |

---

## 3. Tool Recommendations & Disagreements

### Where Enej agrees with the matrix
- Branch for deep links and attribution — no pushback
- n8n self-hosted for automations — strong agreement, this is his primary tool
- Loops for email lifecycle — agrees after understanding Supabase integration
- Looker Studio for dashboards — agrees over Notion for data visualization
- ASO.dev for App Store tracking — no objection
- Ahrefs Lite for SEO keywords — acceptable

### Where Enej pushes back
- **Recharm ($99/mo)** — questioned value at launch stage. Recommendation: skip until paid ads are actually running post-launch.
- **Buffer vs Metricool** — leans Metricool ($22/mo cheaper). Agrees trialing both is right call.
- **GHL (GoHighLevel)** — recommended as **internal GTM CRM** (not in the product). Worth trialing as a replacement for scattered Google Sheets tracking across creator pipeline, press contacts, and outreach. Flag for Jake to evaluate.

### Tools Enej adds that are missing from the matrix
| Tool                       | Purpose                                                                   | Urgency                        |
| -------------------------- | ------------------------------------------------------------------------- | ------------------------------ |
| **ManyChat**               | Auto-DM replies on Instagram/TikTok ("comment TRYPS to get early access") | High — before launch           |
| **Dub.co**                 | Link management and affiliate tracking (Wispr Flow uses this)             | High — before creators go live |
| **PostHog**                | A/B testing + product analytics (integrates with Supabase)                | Medium — week 2                |
| **Mention.com or Brand24** | Social mention monitoring → n8n → Slack                                   | Medium                         |
| **AppFollow**              | Competitor App Store monitoring                                           | Low — post-launch              |
| **Instantly.ai**           | Cold email (flagged — may not fit consumer GTM model, discuss with Jake)  | Low                            |
| **Amazon SES**             | Sending infrastructure if Loops becomes expensive at scale                | Low — post-launch              |

### What's still missing
- **A/B testing for landing page** — depends on what jointryps.com is built on. Ask Jake/Asif today.
- **Email domain warmup** — not a tool but a process. Must start week 1. SPF, DKIM, DMARC need to be configured before any sending.

---

## 4. Case Study Infrastructure Assessment

| Playbook                                       | Infra Required                                                                                                                                                  | Priority                               |
| ---------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------- |
| **Locket** (26 creators, 52 videos/day)        | Creator CRM, Branch link per creator, performance dashboard (views → 3s retention → clicks → installs → CPI), automated underperformer alerts, payment tracking | **#1 — Tryps is executing this**       |
| **Partiful** (product invite = growth loop)    | Beautiful OG image generation per trip invite, Branch deep links on every invite, viral loop tracking (invite sent → friend downloaded)                         | **#2 — core to Tryps product**         |
| **Wispr Flow** (affiliate program via Dub)     | Dub.co affiliate links, ambassador dashboard, referral tracking, monthly payout tracking                                                                        | **#3 — scope 8**                       |
| **Gas/Nikita Bier** (campus-by-campus rollout) | Private Instagram accounts per campus, coordinated launch automation, geofenced download tracking                                                               | **#4 — if college strategy confirmed** |
| **BeReal** (ambassador program)                | Referral tracking, payment per referral, campus activation tracking                                                                                             | **#5 — post-launch**                   |

---

## 5. Week 1 Workplan

| Day | Date      | Primary Deliverable                                                                                                               | Done When...                                                                                                                                    |
| --- | --------- | --------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | Wed Apr 2 | Get all access. Audit what exists. Write UTM naming convention doc.                                                               | Jake has given Enej access to: social accounts, jointryps.com, Meta Business Manager, any existing tool subscriptions. UTM doc shared in Slack. |
| 2   | Thu Apr 3 | Set up Metricool across all 8 platforms. Configure Meta pixel on jointryps.com.                                                   | Test post appears on all 8 platforms from Metricool. Meta Events Manager shows pixel firing on jointryps.com.                                   |
| 3   | Fri Apr 4 | Set up Loops + email capture form on jointryps.com. Configure SPF/DKIM/DMARC. Start domain warmup.                                | Submit email on jointryps.com → receive welcome email in inbox (not spam).                                                                      |
| 4   | Mon Apr 7 | Trial Stormy AI, Modash, HypeAuditor. Build creator CRM template (Google Sheet). Set up Branch account.                           | 1-page tool recommendation doc delivered to Sean + Jake. Creator CRM template ready for Sean to start populating.                               |
| 5   | Tue Apr 8 | Build first n8n → Slack automation (App Store review alert). Set up ManyChat on Instagram. Write UTM structure for creator links. | Test review appears in Slack automatically. ManyChat fires a test DM. Creator Branch links template ready.                                      |

**Content calendar starts April 11 — all scheduling infrastructure must be live by end of Day 2.**

---

## 6. Team Composition Recommendation

| Role                 | Status            | What They Need to Do                                                                                                                                                                                                                                                                                   |
| -------------------- | ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Enej** (GTM Infra) | Hired             | Build all systems, automations, dashboards, tracking                                                                                                                                                                                                                                                   |
| **Growth Marketer**  | HIRE NOW — urgent | Video-native, TikTok-first, fast editor. Must produce 15 posts/week across 3 platforms. Non-negotiable skills: CapCut/Premiere, short-form product demos, basic SEO writing, social calendar management. Content calendar starts April 11.                                                             |
| **Sean**             | Hired             | Creative direction, creator relationships, content approval                                                                                                                                                                                                                                            |
| **SEO/AEO Writer**   | TBD               | AI agents (Don) can draft. A human needs to edit for accuracy and brand voice. Options: (1) include in Growth Marketer scope, (2) separate part-time contractor, (3) AI agents with Enej's n8n pipeline. Recommend: include in Growth Marketer scope at launch, hire specialist post-launch if needed. |

**Enej's view:** The Growth Marketer is the most urgent hire. Without them, Sean is making all content alone on top of managing 80 creator relationships. That breaks before May 2.

---

## 7. Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| **Platform block (Meta, Apple, TikTok support blackhole)** | Medium | High | Set up ALL accounts today — Meta Business Manager, TikTok Business, App Store Connect. Don't wait until April 25. Give weeks to resolve any flags, not hours. |
| **Branch SDK dependency on Asif** | Medium | High | Raise at noon today: "When can Asif commit to Branch SDK deployment?" Branch needs to be in the app before creator attribution works. If this slips, the entire creator performance tracking system is blocked. |
| **No Growth Marketer at content calendar start (April 11)** | Medium | High | Jake needs to make a hire or interim decision before April 9. Sean cannot carry full content production alone. If no hire by April 9, reduce content volume and prioritize Marty demo posts only. |

---

## 8. Open Questions for Jake

1. **What tool subscriptions already exist?** (n8n instance, any social tools, Branch account, etc.) — need to audit before buying duplicates
2. **What is jointryps.com built on?** (Webflow, Framer, custom code?) — determines A/B testing approach and how quickly pixel + email capture can be installed
3. **When can Asif deploy Branch SDK?** — blocks creator attribution and all deep link tracking
4. **What are the referral incentives at launch?** — needed to build email lifecycle flow for referral rewards. Trip credit? Premium features? Cash?
5. **Is there an existing n8n instance on the Hetzner server?** — if yes, Enej connects to it. If no, Enej sets one up in week 1.
6. **Growth Marketer hire timeline?** — content calendar starts April 11, 9 days from now
7. **SEO/AEO — human hire or AI agents?** — Enej can build the pipeline either way but needs the decision
8. **What's the Meta Business Manager status?** — pixel installation blocked until Enej has access
9. **2FA and credential handoff process** — how are shared account credentials managed securely?
10. **What Supabase events are available to hook into?** (ask Asif) — needed for Loops behavioral triggers

---

*Generated: April 2, 2026 | Ready for noon ET call with Jake and Sean*
