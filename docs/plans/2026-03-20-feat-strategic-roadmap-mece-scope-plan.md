---
title: "Tryps Strategic Roadmap: MECE Scope Plan"
type: feat
date: 2026-03-20
supersedes: 2026-03-18-feat-p2-p3-scope-consolidation-and-spec-pipeline-plan.md
---

# Tryps Strategic Roadmap & MECE Scope Plan

## Executive Summary

**What this document is:** The single strategic direction document for Tryps as of March 20, 2026. It replaces all prior plans. It is designed to be shared with Jackson (strategy advisor) as "this is where we are and where we're going."

**What we did today:**
- Completed the 38-question P2/P3 strategy intake (vision, agent philosophy, payments, connectors, sequencing — all answered)
- Ran 4 parallel research agents: tryps-docs scope inventory, t4 codebase audit, brand strategy synthesis, YC/a16z/Sequoia best practices
- Synthesized everything into this MECE scope plan

**Key finding:** The app is ~60-70% built. Most P1 core flows are shipping code — trips, expenses, settlements, itinerary, flights, stays, calendar, home, people, voting, Travel DNA. The scope tracker says "0 done" but that's because criteria haven't been formally validated, not because the code doesn't exist.

**What's actually missing for April 2:**
- Formal QA pass on all 19 core flows (Nadeem + Andreas)
- iMessage agent via Linq (Asif — the #1 strategic priority)
- Stripe payment infrastructure (Asif)
- Travel identity connectors on profile (Asif)
- Agent intelligence layer: Claude connector + vote-on-behalf (Rizwan?)
- Notifications system completion (Nadeem)
- Post-trip review finalization (Nadeem — already in testing)
- Brand/design reconciliation and new screens

**The strategic bet:** Tryps is the travel agent in your iMessage. iMessage is the acquisition channel; the app is the retention layer. The agent is a facilitator (designated driver metaphor) — it steers the group toward decisions, it doesn't make taste choices for you.

**Outputs of this plan:**
1. MECE scope list — 12 capability areas, every work item classified
2. Sequencing roadmap — dependency-aware ordering
3. Team assignments — every person's role and next-week focus
4. Redefined phases — what P1/P2/P3 actually mean now
5. Screens-to-design list — flagged for designer/brand review
6. Jackson-ready strategic narrative

---

## The 30-Second Pitch (For Jackson)

Tryps is the travel agent in your iMessage. Instead of coordinating group trips across six apps (iMessage, Google Docs, Splitwise, Kayak, Airbnb, Google Calendar), one agent handles everything — sourcing, pricing, booking, and logistics. It turns the chaotic group chat into a coordinated trip.

**The acquisition loop is free:** One person adds the Tryps agent to a group chat → everyone experiences it → some download the app for the visual layer. That's the Partiful playbook applied to travel.

**The moat is data + relationships.** As Tryps accumulates trip history and user preferences (Travel DNA, loyalty connections, group dynamics), searches through Tryps become better than Google because we know your friends, your vibe, and your home airport.

**By April 2:** Fully functional product — code shipped and tested. Not a demo. The iMessage agent works, voting works, core flows work, connectors work. Booking capability is a fast-follow if it doesn't make April 2 (ranked #5 in priority, first to cut).

---

## MECE Scope List

Everything Tryps needs, organized into 12 mutually exclusive capability areas. Each item is tagged:

- ✅ **Built** — code exists and works
- ⚠️ **Partial** — started but incomplete
- ❌ **Not started** — no code yet
- 🎨 **Needs design** — requires designer/brand input
- 🔴 **April 2 critical** — must ship
- 🟡 **April 2 stretch** — ship if possible
- ⚪ **Post-launch** — deferred

---

### 1. Core Trip Experience

The foundation. Creating, managing, and visualizing trips.

| Item | Status | Tag | Notes |
|------|--------|-----|-------|
| Trip creation wizard | ✅ Built | 🔴 | Multi-city, vibe quiz integration |
| Trip editing (owner + collaborative modes) | ✅ Built | 🔴 | Edit mode toggle works |
| Multi-city support with location ordering | ✅ Built | 🔴 | Individual start/end dates |
| Trip phases (planning → finalized) | ✅ Built | 🔴 | Phase locking works |
| Cover image customization | ✅ Built | 🔴 | Blurhash placeholders |
| Trip links (Pinterest, Spotify, etc.) | ✅ Built | 🔴 | URL sharing |
| Trip card customization (home tab) | ⚠️ Partial | 🟡 🎨 | NEW from strategy intake — needs more UI polish |
| Calendar view with trip ranges | ✅ Built | 🔴 | Recently redesigned with flash-calendar |
| Home tab (upcoming/past trips) | ✅ Built | 🔴 | Recently redesigned, GPU animations |
| Discover tab (public/cloneable trips) | ✅ Built | 🟡 | Like/clone counts working |

**QA needed:** Formal criteria validation on all items. Andreas to run through.

---

### 2. Group Decision-Making

How groups align on what to do. This is where the "facilitation engine" lives.

| Item | Status | Tag | Notes |
|------|--------|-----|-------|
| Destination voting (multi-option) | ✅ Built | 🔴 | Nomination + voting phases |
| Date voting | ✅ Built | 🔴 | Date option selection |
| Activity voting (suggest → vote → confirm) | ✅ Built | 🔴 | Three-tier system |
| Notifications for voting events | ⚠️ Partial | 🔴 | Push exists; 22 notification triggers need wiring |
| **Guided planning cadence** | ❌ Not started | 🟡 🎨 | NEW — 7-day or 3-day structured timeline. Owner picks cadence; app guides group: Day 1 vibe → Day 2 dates → Day 3 flights → etc. Visual tracker at top of trip. **Core to product identity.** |
| **Role cards (character select)** | ❌ Not started | 🟡 🎨 | NEW — Mario-style: Planner / Silent Co-Planner / Down for Whatever / Last Minute Add. Maps to vibe quiz + agent engagement level. |
| Notification triggers (22 trip lifecycle events) | ⚠️ Partial | 🔴 | Spec has 41 criteria; push infra exists, triggers need mapping |

**Design flag:** Facilitation engine and role cards both need full visual design before implementation.

---

### 3. Travel Planning

Flights, stays, activities, restaurants, transport, packing.

| Item | Status | Tag | Notes |
|------|--------|-----|-------|
| Flight add/edit with airport selection | ✅ Built | 🔴 | Amadeus API for recommendations |
| Flight cards (departure/arrival/airlines) | ✅ Built | 🔴 | |
| Accommodation search (Airbnb, VRBO, Amadeus) | ✅ Built | 🔴 | Search + voting, not booking |
| Accommodation voting + confirmation | ✅ Built | 🔴 | |
| Activity suggestions with voting | ✅ Built | 🔴 | |
| Transportation (car, bus, train, etc.) | ✅ Built | 🔴 | Multi-city support |
| Packing list with dress code | ✅ Built | 🔴 | Recently enhanced |
| Itinerary view | ✅ Built | 🔴 | |
| Restaurant sourcing (Resy, OpenTable) | ❌ Not started | 🟡 | From connector wallet sketch |

**Status:** This area is nearly complete. Major items all built.

---

### 4. Expenses & Payments

Tracking money, splitting costs, settling up, and eventually paying through Tryps.

| Item | Status | Tag | Notes |
|------|--------|-----|-------|
| Expense tracking (merchant, amount, category) | ✅ Built | 🔴 | |
| Flexible splits (even or custom) | ✅ Built | 🔴 | |
| Multi-currency support | ✅ Built | 🔴 | ISO 4217, Supabase edge function conversion |
| Receipt scanning + upload | ✅ Built | 🔴 | Document scanner integration |
| Settlement calculations + mark-as-paid | ✅ Built | 🔴 | Balance calculations, confirmation flow |
| Payment handles (Venmo, PayPal, Cash App) | ✅ Built | 🔴 | Deep links to payment apps |
| **Stripe card-on-file** | ❌ Not started | 🟡 | P2 scope — 12 criteria. Trust ramp: first payment explicit → save card → progressively autonomous |
| **Booking → auto-expense logging** | ❌ Not started | 🟡 | If Tryps facilitates payment, Tryps tracks expense automatically |
| **Group booking (one pays for all)** | ❌ Not started | ⚪ | One person pays, auto-splits to group expense |

**Strategic note:** Expense tracking is DONE. Stripe integration is the bridge to actual booking. Per strategy intake, booking is ranked #5 (first to cut). Stripe card-on-file is a stretch for April 2.

---

### 5. iMessage Agent (Linq)

**THE #1 STRATEGIC PRIORITY.** iMessage is the primary acquisition channel.

| Item | Status | Tag | Notes |
|------|--------|-----|-------|
| Linq iMessage integration | ❌ Not started | 🔴 | 41 criteria spec exists. Asif owns. |
| Agent personality (Jennifer Test) | ❌ Not started | 🔴 🎨 | Must pass: "Would grandma think this is a human travel agent named Jennifer?" |
| Agent in group chat — trip context awareness | ❌ Not started | 🔴 | Agent knows trip details, participants, decisions |
| Agent expense parsing from chat | ❌ Not started | 🔴 | "Jake paid $200 for dinner" → logs expense |
| Agent voting facilitation | ❌ Not started | 🔴 | Agent presents options, collects votes in chat |
| Agent trip queries | ❌ Not started | 🔴 | "When do we land?" → agent answers from trip data |
| Agent proactive behavior | ❌ Not started | 🟡 | Only surfaces when relevant (club at midnight example) |
| App ↔ iMessage sync | ❌ Not started | 🔴 | Same agent, same context, both channels |
| Non-app-user participation | ❌ Not started | 🔴 | People who never install the app can still go on the trip via iMessage |

**Design flag:** Agent voice & tone guide needed before implementation. Must match brand voice (warm, casual, inviting) and pass the Jennifer Test.

---

### 6. Agent Intelligence

The AI layer that makes Tryps smarter than manual planning.

| Item | Status | Tag | Notes |
|------|--------|-----|-------|
| Claude Connector (MCP remote server) | ❌ Not started | 🟡 | 36 criteria. In-app AI that helps plan. |
| Recommendations engine | ❌ Not started | 🟡 | Friend-based activity recs. Needs algo architecture. |
| **Vote-on-behalf** | ❌ Not started | 🟡 | Agent infers votes from Travel DNA + history. "Exciting — it knows me." |
| **Research & suggest** | ❌ Not started | ⚪ | Agent proactively researches options for the group |
| **Pay-on-behalf** | ❌ Not started | ⚪ | $0 default — requires explicit user opt-in. Further in roadmap. |
| Per-user memory (preferences, history) | ❌ Not started | 🟡 | Needed for agent to "know you" |
| Per-trip memory (decisions, context) | ❌ Not started | 🟡 | Needed for agent continuity across channels |

**Strategic note:** Memory architecture is the hardest technical problem here. Two layers: user-level (Travel DNA, home airport, preferences) and trip-level (decisions, votes, group context). This is infrastructure that enables everything else in this category.

---

### 7. Travel Identity

Your travel life in one place. The profile wallet.

| Item | Status | Tag | Notes |
|------|--------|-----|-------|
| Travel DNA quiz | ⚠️ Partial | 🔴 | 25 criteria. Quiz exists; integration in progress (Nadeem) |
| Travel DNA sharing card | ❌ Not started | 🟡 🎨 | Shareable visual of your travel personality |
| Home airport setting | ✅ Built | 🔴 | On user_profiles |
| Visited countries tracking | ✅ Built | 🔴 | Flags on profile |
| **Connector wallet (profile page)** | ❌ Not started | 🟡 🎨 | Jake's sketch: vertical list of categories (Airlines, Stays, Restaurants, Payment, ID). Connected = checked, unconnected = greyed out recommendation. |
| Airline connectors (Southwest, Delta, American) | ❌ Not started | 🟡 | #1 priority connector |
| Stay connectors (Airbnb, VRBO, Bonvoy) | ❌ Not started | ⚪ | |
| Restaurant connectors (Resy, OpenTable) | ❌ Not started | ⚪ | |
| Payment connectors (Stripe, Link, CC) | ❌ Not started | 🟡 | Tied to Stripe scope |
| Passport / DL storage | ❌ Not started | 🟡 | v1 requirement per strategy intake. Encrypted storage. |
| Loyalty auto-apply (visible to user) | ❌ Not started | ⚪ | Users see when AAdvantage number applied. Transparency = satisfaction. |

**Design flag:** Connector wallet is a major new profile screen. Jake has a notebook sketch — needs to be designed in Figma.

---

### 8. Onboarding & Teaching

First-run experience and ongoing guidance.

| Item | Status | Tag | Notes |
|------|--------|-----|-------|
| Tooltips & teaching moments | ❌ Not started | 🟡 🎨 | P1 scope, no spec yet. UI hints for feature discovery. |
| First 60-second experience (agent added to chat) | ❌ Not started | 🔴 🎨 | Two things must click instantly: (1) there's an app behind the agent, (2) just communicate your vibe |
| Vibe quiz in trip creation | ✅ Built | 🔴 | Separate wizard screen |
| App download CTA from iMessage | ❌ Not started | 🔴 | How non-app users discover the app from the group chat |

---

### 9. Post-Trip & Retention

What happens after the trip. Keeping people coming back.

| Item | Status | Tag | Notes |
|------|--------|-----|-------|
| Post-trip review flow | ⚠️ Partial | 🔴 | 39 criteria. In testing (Nadeem). Time capsule, top 3 favorites, group aggregation. |
| Photo gallery | ⚠️ Partial | 🔴 | Photos table exists; upload flow exists |
| Final expense settlement | ✅ Built | 🔴 | Settlement flow works |
| **Rewards program (Tryps Miles)** | ❌ Not started | ⚪ 🎨 | NEW from strategy intake. Loyalty/rewards system. Needs full scope + spec. |

---

### 10. Brand & Design System

Visual identity, design tokens, and Figma assets.

| Item | Status | Tag | Notes |
|------|--------|-----|-------|
| Brand strategy document | ✅ Done | | Locked pending Trent review |
| Color palette in theme.ts | ✅ Done | | Tryps Red #D9071C, Warm Cream, Deep Slate |
| Typography (Plus Jakarta Sans) | ✅ Done | | In code. Figma uses wrong font (Space Grotesk). |
| **Font reconciliation** | ❌ Not started | 🔴 🎨 | tryps.pen uses Space Grotesk; theme.ts uses Plus Jakarta Sans. Must align. |
| **Color reconciliation** | ❌ Not started | 🔴 🎨 | tryps.pen uses #DC2626; theme.ts uses #D9071C. Must align. |
| **Background color** | ❌ Not started | 🔴 🎨 | Figma says white/light gray; brand.md says warm cream. Figma overrides. |
| **Brand book in Figma** | ❌ Not started | ⚪ 🎨 | Target: 30-40 screens. Not started. |
| Dark mode tokens | ✅ Done | | Warm dark (#1E1B19), never cool/blue-gray |

---

### 11. Launch & GTM

Getting the word out.

| Item | Status | Tag | Notes |
|------|--------|-----|-------|
| Launch video (hero + social cuts) | ❌ Not started | ⚪ 🎨 | 15 criteria. Sean owns creative. Poke-inspired, $5-7K budget. |
| Social media strategy | ❌ Not started | ⚪ | Twitter first (launch video), then Instagram, TikTok |
| Wispr Flow playbook (UGC) | ❌ Not started | ⚪ | Not founder-led. Brand-led. |
| Referral incentives | ❌ Not started | ⚪ | Needs scope |
| Giveaways (Dream Trip) | ❌ Not started | ⚪ | Needs scope |
| Landing page update (jointryps.com) | ❌ Not started | 🟡 | |
| App Store listing | ❌ Not started | 🟡 | |

**Note:** All GTM is post-April 2 except landing page and App Store listing.

---

### 12. QA & Beta

Validation and testing.

| Item | Status | Tag | Notes |
|------|--------|-----|-------|
| QA pass on 19 core flows | ❌ Not started | 🔴 | Andreas runs through every flow, validates criteria |
| Formal criteria validation (240+ criteria) | ❌ Not started | 🔴 | Move ClickUp tasks from "needs spec" → "for testing" → "done" |
| Friends & family beta | ❌ Not started | 🟡 | TestFlight distribution |
| Strangers review | ❌ Not started | ⚪ | Post-launch |
| ClickUp status reconciliation | ❌ Not started | 🔴 | Current statuses are drifted (e.g., connectors + logistics-agent say "needs spec" but have full specs) |

---

## What's Actually April 2 Critical (The Cut)

Applying MoSCoW (YC-recommended framework) to the MECE list:

### MUST HAVE (product doesn't work without it)

| # | Item | Owner | Status |
|---|------|-------|--------|
| 1 | QA pass on 19 core flows | Andreas + Nadeem | ❌ |
| 2 | Notification triggers wired (22 events) | Nadeem | ⚠️ |
| 3 | Post-trip review finalized | Nadeem | ⚠️ (in testing) |
| 4 | Travel DNA integration complete | Nadeem | ⚠️ (in progress) |
| 5 | iMessage agent (Linq) — core functionality | Asif | ❌ |
| 6 | App ↔ iMessage sync | Asif | ❌ |
| 7 | First 60-second iMessage experience | Asif + Designer | ❌ |
| 8 | ClickUp status reconciliation | Jake | ❌ |
| 9 | Font/color/background reconciliation | Designer | ❌ |

### SHOULD HAVE (significant value, product can launch without)

| # | Item | Owner | Status |
|---|------|-------|--------|
| 10 | Connector wallet (profile page) | Asif | ❌ |
| 11 | Airline connectors | Asif | ❌ |
| 12 | Passport/DL storage | Asif | ❌ |
| 13 | Claude Connector (in-app AI) | Nadeem/Rizwan | ❌ |
| 14 | Vote-on-behalf (agent proxy voting) | Rizwan | ❌ |
| 15 | Guided planning cadence (facilitation engine) | Designer + Dev | ❌ |
| 16 | Role cards | Designer + Dev | ❌ |
| 17 | Tooltips & teaching | Jake + Designer | ❌ |
| 18 | Stripe card-on-file | Asif | ❌ |
| 19 | Per-user + per-trip memory architecture | Rizwan | ❌ |
| 20 | Landing page update | Jake/Sean | ❌ |
| 21 | App Store listing | Jake | ❌ |
| 22 | Friends & family beta (TestFlight) | Andreas | ❌ |

### COULD HAVE (nice-to-have, improves experience)

| # | Item | Owner |
|---|------|-------|
| 23 | Trip card customization (home tab) | Designer + Dev |
| 24 | Recommendations engine | Dev |
| 25 | Restaurant connectors (Resy, OpenTable) | Dev |
| 26 | Stay connectors (Bonvoy, etc.) | Dev |
| 27 | Booking → auto-expense logging | Dev |
| 28 | Travel DNA sharing card | Designer + Dev |
| 29 | Loyalty auto-apply (visible) | Dev |

### WON'T HAVE (this release — explicitly deferred)

| # | Item | Why deferred |
|---|------|-------------|
| 30 | Booking & paying for travel | Ranked #5, most dependencies, first to cut |
| 31 | Pay-on-behalf | $0 default, further in roadmap |
| 32 | Duffel APIs (flight booking) | Blocked on booking scope |
| 33 | Logistics Agent (full orchestration) | Depends on booking + agent layer |
| 34 | Research & suggest (proactive agent) | Depends on memory architecture |
| 35 | Rewards program (Tryps Miles) | Post-launch retention feature |
| 36 | Launch video | Post-April 2 (Sean schedule) |
| 37 | Social media strategy execution | Post-launch |
| 38 | Wispr playbook / UGC | Post-launch |
| 39 | Referral incentives | Post-launch |
| 40 | Giveaways | Post-launch |
| 41 | Brand book in Figma (30-40 screens) | Ongoing, not blocking launch |
| 42 | Strangers review | Post-launch |
| 43 | Group booking (one pays for all) | Depends on Stripe |

---

## Sequencing Roadmap (March 20 → April 2)

13 days. Using Seibel's 1-2 week cycle framework: this IS the final cycle.

### Dependency Chain

```
Travel DNA (in progress) ──→ Vote-on-behalf (needs DNA data)
                         ──→ Recommendations (needs DNA data)

Core flows QA ──→ Notifications wiring ──→ iMessage agent
                                           (agent triggers notifications)

Linq iMessage integration ──→ Agent personality (Jennifer Test)
                          ──→ Non-app-user participation

Connector wallet design ──→ Airline connectors ──→ Stripe card-on-file
                        ──→ Passport storage

Font/color reconciliation ──→ All new UI screens
```

### Week 1: March 20-26 (THIS WEEK)

**Theme: Lock the foundation + start Linq**

| Person | Focus | Deliverable |
|--------|-------|-------------|
| **Nadeem** | Finish Travel DNA (in progress) + Post-trip review (in testing) | Both → "done" in ClickUp |
| **Nadeem** | Start notifications wiring (22 triggers) | Push + SMS triggers mapped |
| **Asif** | Begin Linq iMessage integration | Agent responds in group chat (basic) |
| **Asif** | Spike: Stripe card-on-file setup | Stripe account + SDK integrated |
| **Rizwan** | Begin Claude Connector (MCP patterns) | Basic trip data available via MCP |
| **Andreas** | Start QA pass on 19 core flows | First 10 flows validated |
| **Jake** | Run spec sessions for: facilitation engine, role cards | Two new spec.md files |
| **Jake** | ClickUp status reconciliation | All tasks reflect real state |
| **Jake** | Brief designers on: connector wallet, facilitation engine, role cards | Design briefs sent |
| **Designer(s)** | Font/color/background reconciliation | Design tokens aligned across all systems |

### Week 2: March 27 → April 2 (SHIP WEEK)

**Theme: Ship Linq + QA everything**

| Person | Focus | Deliverable |
|--------|-------|-------------|
| **Nadeem** | Complete notifications (41 criteria) | All triggers wired + tested |
| **Nadeem** | Tooltips & teaching (if time) | First-run hints |
| **Asif** | Linq agent — full functionality | Agent handles: trip queries, expense parsing, voting, proactive behavior |
| **Asif** | Agent personality (Jennifer Test) | Voice & tone matches brand. Grandma wouldn't know. |
| **Asif** | Connector wallet (if designed) | Profile page with airline connections |
| **Rizwan** | Vote-on-behalf | Agent can proxy vote based on Travel DNA |
| **Rizwan** | Per-user + per-trip memory | Memory architecture shipped |
| **Andreas** | Complete QA on remaining 9 flows | All 19 flows validated |
| **Andreas** | Regression testing on Linq integration | iMessage ↔ app sync verified |
| **Jake** | App Store listing + landing page | Ready for beta distribution |
| **Jake** | Friends & family TestFlight | First external users |
| **Designer(s)** | Facilitation engine + role cards screens | Designs delivered to dev |

---

## Team Assignments

### Engineering

| Person | Area | Scopes | Next Week Priority |
|--------|------|--------|--------------------|
| **Nadeem** | Core App | Travel DNA, Post-trip Review, Notifications & Voting, Tooltips | Finish Travel DNA + Post-trip Review → Start notifications |
| **Asif** | iMessage + Payments | Linq, Stripe, Connectors | Start Linq integration (the #1 priority) |
| **Rizwan** | Agent Layer | Claude Connector, Vote-on-behalf, Memory | Start Claude Connector MCP patterns |
| **Andreas** | QA | All 19 core flows, criteria validation | Begin formal QA pass, first 10 flows |

### Product & Strategy

| Person | Role | Focus |
|--------|------|-------|
| **Jake** | Product / Founder | Spec sessions (facilitation engine, role cards), ClickUp reconciliation, designer briefing, App Store prep |
| **Jackson** | Strategy Advisor | Reviews this roadmap document. Provides feedback on positioning, sequencing, and investor narrative. |

### Creative & Brand

| Person | Role | Focus |
|--------|------|-------|
| **Sean** | Creative | Launch video pre-production (storyboard, shot list). Post-April 2 execution. Social content planning. |
| **Trent** | Brand Advisor | Reviews brand strategy doc. Approves tagline + typography direction. Needed ASAP. |
| **Designer(s)** | Figma / UI | Font/color reconciliation (immediate). Then: connector wallet, facilitation engine, role cards, trip card customization. |

---

## Redefined Phases

The old P1/P2/P3/P4/P5 phases were organized by "product layer" (Core App / Integrations / Agent / GTM / Beta). That doesn't match the strategic reality anymore. Here's what the phases actually mean:

### P1: Ship the Product (March 20 → April 2)
**Definition:** Everything that must be code-shipped-and-tested for the app to work as described to users.

Includes:
- All 19 core flows (QA validated)
- Notifications & voting (22 triggers wired)
- Post-trip review (in testing → done)
- Travel DNA (in progress → done)
- iMessage agent via Linq (core functionality)
- Agent personality (Jennifer Test passing)
- App ↔ iMessage sync
- Non-app-user participation
- ClickUp reconciliation

### P2: Make It Smart (April 2 → April 15)
**Definition:** The intelligence and identity layer that makes Tryps better than manual planning.

Includes:
- Claude Connector (in-app AI)
- Vote-on-behalf (agent proxy voting)
- Per-user + per-trip memory architecture
- Connector wallet (profile page)
- Airline connectors
- Passport/DL storage
- Guided planning cadence (facilitation engine)
- Role cards
- Tooltips & teaching
- Stripe card-on-file
- Recommendations engine (basic)

### P3: Make It Transact (April 15 → May 1)
**Definition:** Tryps handles real money and real bookings.

Includes:
- Booking → auto-expense logging
- Group booking (one pays for all)
- Duffel APIs (flight search + booking)
- Logistics Agent (full orchestration)
- Pay-on-behalf (with explicit opt-in)
- Restaurant/stay connectors
- Loyalty auto-apply

### P4: Make It Grow (May 1+)
**Definition:** Brand, distribution, and retention.

Includes:
- Launch video
- Social media execution
- Wispr playbook / UGC
- Referral incentives
- Giveaways
- Rewards program (Tryps Miles)
- Brand book in Figma
- Strangers review

---

## Screens to Design (Designer Workload)

Items flagged with 🎨, prioritized by urgency:

### Immediate (This Week — Blocks April 2)

| Screen | Description | Priority |
|--------|-------------|----------|
| Font/color/background reconciliation | Align tryps.pen + theme.ts. Plus Jakarta Sans, #D9071C, white/light gray bg. | 🔴 Blocking all new UI |
| Agent personality / voice guide | Not a screen — a copy doc. How does the agent speak? Jennifer Test reference. | 🔴 Blocks Linq |
| First 60-second iMessage experience | What does someone see when the agent is added to their group chat? | 🔴 Blocks Linq |

### Next (Ship Week — Blocks P2)

| Screen | Description | Priority |
|--------|-------------|----------|
| Connector wallet (profile page) | Vertical list: Airlines, Stays, Restaurants, Payment, ID. Connected = checked, unconnected = greyed out. Jake has notebook sketch. | 🟡 |
| Guided planning cadence | Visual tracker at top of trip: "7-day plan to get this trip planned" with progress. Cadence picker for owner. | 🟡 |
| Role cards (character select) | Mario-style: Planner (red), Silent Co-Planner (green), Down for Whatever (yellow), Last Minute Add (pink). Selection during trip join. | 🟡 |
| Tooltips & teaching moments | First-run hints for key features. Overlay or inline? | 🟡 |
| Travel DNA sharing card | Beautiful shareable card of your travel personality. | 🟡 |
| Trip card customization options | What can users customize on home tab trip cards? | 🟡 |

### Later (Post-launch)

| Screen | Description |
|--------|-------------|
| Rewards program UI (Tryps Miles) | Points display, earning rules, redemption |
| Brand book (30-40 Figma screens) | Full visual identity system |
| Launch video storyboard | Shot breakdown for Sean |

---

## Strategic Principles (From Strategy Intake)

These principles should guide every scope and design decision:

1. **The Jennifer Test** — If you told your grandmother the agent was a human travel agent named Jennifer, she would 100% believe it. If grandma can't tell it's AI, we win.

2. **Facilitator, not dictator** — The agent is the designated driver. It steers the group toward decisions but doesn't make taste choices. It suggests the plan and facilitates options; humans decide.

3. **iMessage first, app second** — iMessage is acquisition. The app is retention. Never force someone into the app. The trip works fully from iMessage alone.

4. **Trust ramp for money** — First payment: explicit confirmation + card entry. Second+: progressively more autonomous. Default is always "show me first."

5. **Hidden until needed** — Money, agent, connectors — all invisible until the moment they're relevant. Then they surface seamlessly.

6. **Two tiers of engagement** — Some people are Planners (vote on everything). Some are Toads (don't care, agent handles it). The product supports both equally.

7. **Booking is last, not first** — The vision is booking. The reality is: facilitation → voting → identity → recommendations → THEN booking. Don't jump to the end.

8. **One agent, one brain** — Users experience one unified travel service. Not a booking agent + a voting agent + a logistics agent. One entity across iMessage and app, same context.

---

## Risks & Mitigations

| Risk | Severity | Mitigation |
|------|----------|-----------|
| Linq integration harder than estimated | High | Asif starts immediately. Spike this week. If blocked, agent works in-app only for April 2. |
| Rizwan availability unclear | High | ClickUp lists him but P3 says "blocked on hire." Jake to clarify status ASAP. |
| 13 days is not enough for 9 Must Haves | High | Nadeem has 4 items (2 nearly done). Asif has 3 items (all Linq). Andreas has 1 item (QA). Parallel execution. |
| Designer not briefed yet | Medium | Jake briefs designers Monday. Font/color reconciliation is Day 1 priority. |
| No customer support plan for agent errors | Medium | For April 2: agent says "I'm not sure about that — let me flag it for [trip owner]." Escalation to human, not support team. |
| Memory architecture undefined | Medium | Start simple: user preferences in user_profiles table, trip context in trip-level table. Iterate after launch. |
| ClickUp is drifted from reality | Low | Jake reconciles this week. One-time cleanup. |

---

## How to Use This Document

1. **Jake shows Jackson** this document as-is, focusing on the Executive Summary and the MECE scope list
2. **Jake briefs designers** using the Screens to Design section
3. **Jake reconciles ClickUp** using the MoSCoW cut as the source of truth for what's April 2
4. **Asif, Nadeem, Rizwan** each read their Team Assignment row and start on Week 1 priorities
5. **Andreas** starts QA pass using the 19 core flows list from the tryps-docs research
6. **This document supersedes** the old P2/P3 consolidation plan and the beta launch sprint plan

---

## Appendix: Sources

- `/tryps-docs/docs/p2-p3-strategy-intake.md` — 38 questions answered (vision locked)
- `/tryps-docs/shared/brand.md` — Brand system tokens
- `/tryps-docs/shared/brand-strategy.md` — Brand strategy (pending Trent review)
- `/tryps-docs/shared/state.md` — Scope status (needs reconciliation)
- `/tryps-docs/shared/clickup.md` — ClickUp task mapping
- `/tryps-docs/scopes/` — All scope specs (P1-P5)
- `/t4/` — Codebase audit (60-70% feature complete)
- YC/a16z/Sequoia research on startup roadmapping frameworks (MoSCoW, Seibel cycle, Arc PMF)
