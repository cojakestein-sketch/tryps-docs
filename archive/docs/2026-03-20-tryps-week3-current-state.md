# Tryps Week 3: Current State

---

## 1. Current State

~70% built. Core loop works — create trip, invite via link, they join. Live on TestFlight.
5/25 beta users onboarded. Target 25 by Sunday.
Demo: live app on phone — create trip, invite someone, they download and join.

---

## 2. Scopes — What We're Building

| # | Scope | What It Is | Where It Lives | April 2? |
|---|-------|------------|----------------|----------|
| 1 | Beta & User Feedback | TestFlight, feedback pipeline — does the experience work? | Jake's iMessages, outreach | Yes |
| 2 | Core Trip Experience | Creating, managing, visualizing trips + expense tracking — the foundation | Trip card (mobile app) | Yes |
| 3 | Group Decision-Making | How groups align — voting, facilitation engine, notifications | iMessage, trip card | Yes |
| 4 | Travel Identity | Travel DNA, connectors, passport, loyalty — who you are as a traveler | People + profile tab | Yes |
| 5 | Onboarding & Teaching | First-run experience, tooltips, guided cadence — making it instantly obvious | Mobile app, iMessage | Yes |
| 6 | Post-Trip & Retention | Reviews, memories, rewards — what happens after and what brings you back | Mobile app, iMessage | Yes |
| 7 | iMessage Agent | The travel agent in your group chat — Linq, Jennifer Test, primary acquisition | iMessage | Yes |
| 8 | Agent Intelligence | Vote-on-behalf, memory architecture, recommendations engine — the brain | Backend, mobile app | Yes |
| 9 | Payments Infrastructure | Stripe card-on-file, booking payments, auto-expense logging | Backend, mobile, iMessage | Yes |
| 10 | Travel Booking | Searching, sourcing, booking flights, stays, activities, restaurants, transport | iMessage, mobile, backend | Yes |
| 11 | Brand & Design System | Visual identity, design tokens, Figma assets — the world | Figma | Yes |
| 12 | Launch & GTM | Video, socials, referrals, giveaways — getting the word out | Social platforms | Yes |
| 13 | QA & Testing | Criteria validation, regression testing — does the code work? | ClickUp, GitHub | Yes |
| 14 | AI Platform Connectors | MCP server for Claude, OpenAI, etc. — meet users in their AI tools | External services, backend | Post-April 2 |
| 15 | Logistics Agent | Autonomous trip logistics — research, recommend, book on behalf of the group | Backend, iMessage, mobile | Post-April 2 |
| 16 | Output-Backed Screen | The tangible trip deliverable — card-stack with draggable itinerary, works in iMessage | iMessage, mobile app | Yes |

```
MAR 20            MAR 24            MAR 28            APR 2       POST-LAUNCH
  |                 |                 |                 |              |
  | Beta & Feedback ◆━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━▶ |              |
  | Core Trip       ◆━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━▶ |              |
  | Group Decisions ◆━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━▶ |              |
  | Travel Identity ◆━━━━━━━━━━━━━━━━━━━━━▶            |              |
  | Onboarding                      ◆━━━━━━━━━━━━━━━━▶ |              |
  | Post-Trip       ◆━━━━━━━━━━━━━━━━━━━━━━━━▶         |              |
  | iMessage Agent  ◆━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━▶ |              |
  | Agent Intel             ◆━━━━━━━━━━━━━━━━━━━━━━━━▶ |              |
  | Payments                        ◆━━━━━━━━━━━━━━━━▶ |              |
  | Travel Booking                          ◆━━━━━━━━▶ |              |
  | Brand & Design  ◆━━━━━━━━━━━━━▶                    |              |
  | Launch & GTM                    ◆━━━━━━━━━━━━━━━━▶ |              |
  | QA & Testing    ◆━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━▶ |              |
  | AI Connectors                                      |  ◆━━━━━━━━━▶ |
  | Logistics Agent                                    |  ◆━━━━━━━━━▶ |
  | Output Screen           ◆━━━━━━━━━━━━━━━━━━━━━━━━▶ |              |
  |                 |                 |                 |              |
```

[Full scope breakdown](plans/2026-03-20-feat-strategic-roadmap-mece-scope-plan.md)

---

## 3. Budget & Burn

Team: 4 devs, 1 QA, 1 creative, 2 ad-hoc designers, Jake full-time.

---

## 4. Brand World & GTM

Will walk through Figma live.

**Brand & Design System**
- Font/color/background reconciliation across app + Figma
- Agent personality & voice guide (Jennifer Test)
- Outstanding screen polish (blocks new UI)
- Brand book in Figma (30-40 screens)

**Launch & GTM**
- Landing page update (jointryps.com)
- App Store listing
- Launch video (Sean)
- Social presence (Instagram, TikTok, Twitter)
- UGC creator program: Wispr Flow playbook
- Referral incentives
- Giveaways

[Brand Strategy](../shared/brand-strategy.md) | [Brand System](../shared/brand.md)

---

## 5. Network Strategy

1. McKinsey
2. MIT
3. Personal (dad, inner circle)
4. Rich Ross
5. Cold outreach (from warm intros)

---

| Doc | What It Covers |
|-----|---------------|
| [Strategic Roadmap](plans/2026-03-20-feat-strategic-roadmap-mece-scope-plan.md) | Scopes, sequencing, assignments |
| [Brand Strategy](../shared/brand-strategy.md) | Purpose, positioning, values |
| [P2/P3 Vision](p2-p3-strategy-intake.md) | Strategic vision in Jake's words |
| [ClickUp](../shared/clickup.md) | Task tracking, statuses |
