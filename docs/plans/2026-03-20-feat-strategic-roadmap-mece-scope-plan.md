---
title: "Tryps Strategic Roadmap: MECE Scope Plan"
type: feat
date: 2026-03-20
supersedes: 2026-03-18-feat-p2-p3-scope-consolidation-and-spec-pipeline-plan.md
---

# Tryps Strategic Roadmap & MECE Scope Plan

## Executive Summary

This document is the single source of truth for what Tryps is building and how we get there by April 2, 2026. It supersedes all prior plans — the P2/P3 consolidation plan, the beta launch sprint, and any scope documents that contradict the phasing here.

The app is ~60-70% built. Most core flows are shipping code. What remains is agent quality, the iMessage channel, identity/connectors, and QA validation. We have **13 days** (March 20 → April 2) organized into **4 phases** covering **14 MECE capability areas**.

---

## 1. Strategic Bet & Pitch

### Core Thesis

There is no seamless way to plan a group trip end to end that accounts for: A) the differences in effort level people want to put into trip planning, B) easily coordinating people together, and C) facilitating the required steps to plan, go on, and review a trip.

### The Bet

Center the experience around making it as EASY as possible to communicate the VIBE you want out of a trip — then Tryps just makes it happen. The agent is a facilitator (think of it as the designated driver) — it steers the group toward decisions, it doesn't make taste choices for you. We believe that iMessage is the acquisition channel for viral growth, starting by targeting the hard side of our network (the ultra-planners) who will engage in our mobile app. We are building a social-first, agent-native solution to this problem.

### The 30-Second Pitch

Make trip planning effortless. One app where the whole group plans together, so nobody has to do it alone.

Tryps is the facilitation engine for group travel. Instead of one person doing all the work across six apps (iMessage, Google Docs, Splitwise, Kayak, Airbnb, Google Calendar), Tryps guides the entire group from "we should totally do that" to "we're booked." An agent in your iMessage steers the group toward decisions — sourcing options, running votes, locking in plans — so the trip actually happens.

**The acquisition loop is free:** One person adds the Tryps agent to a group chat → everyone experiences it → some download the app for the visual layer. That's the Partiful playbook applied to travel.

**The moat is data + relationships.** As Tryps accumulates trip history and user preferences (Travel DNA, loyalty connections, group dynamics), planning through Tryps becomes better than any alternative because we know your friends, your vibe, and your home airport.

### Strategic Principles

These principles guide every scope and design decision:

1. **The Jennifer Test** — If you told your grandmother the agent was a human travel agent named Jennifer, she would 100% believe it. If grandma can't tell it's AI, we win.

2. **Facilitator, not dictator** — The agent is the designated driver. It steers the group toward decisions but doesn't make taste choices. It suggests the plan and facilitates options; humans decide.

3. **iMessage first, app second** — iMessage is acquisition. The app is retention. Never force someone into the app. The trip works fully from iMessage alone.

4. **Spectrum of engagement** — People range from ultra-planners (vote on everything, curate every detail) to I-don't-carers (just tell me when to show up). The product supports the full spectrum equally.

5. **The funnel is: vibe → needs → facilitation → booking** — First understand the vibe, then identify needs and recommend, then facilitate voting and alignment, then booking. Don't jump to the end.

6. **One agent, one brain** — Users experience one unified travel service. Not a booking agent + a voting agent + a logistics agent. One entity across iMessage and app, same context.

7. **Trust ramp for money** — First payment: explicit confirmation + card entry. Second+: progressively more autonomous. Default is always "show me first."

---

## 2. MECE Scope List

15 mutually exclusive capability areas covering everything Tryps needs. Expense Tracking is folded into Core Trip Experience. Scopes 14-15 added 2026-03-22 after Agent Intelligence scoping interview carved out Claude Connector and Logistics Agent into their own post-April 2 scopes.

| # | Scope | One-liner | Where it lives | April 2? |
|---|-------|-----------|----------------|----------|
| 1 | **Beta & User Feedback** | TestFlight, feedback pipeline — does the experience work? | Jake's iMessages, outreach | Yes |
| 2 | **Core Trip Experience** | Creating, managing, visualizing trips + expense tracking — the foundation | Trip card (mobile app) | Yes |
| 3 | **Group Decision-Making** | How groups align — voting, facilitation engine, notifications | iMessage, trip card | Yes |
| 4 | **Travel Identity** | Travel DNA, connectors, passport, loyalty — who you are as a traveler | People + profile tab | Yes |
| 5 | **Onboarding & Teaching** | First-run experience, tooltips, guided cadence — making it instantly obvious | Mobile app (everywhere), iMessage | Yes |
| 6 | **Post-Trip & Retention** | Reviews, memories, rewards — what happens after and what brings you back | Mobile app (after trip card), iMessage | Yes |
| 7 | **iMessage Agent** | The travel agent in your group chat — Linq, Jennifer Test, primary acquisition | iMessage | Yes |
| 8 | **Agent Intelligence** | Vote-on-behalf, memory architecture, recommendations engine — the brain | Backend, mobile app | Yes |
| 9 | **Payments Infrastructure** | Stripe card-on-file, booking payments, auto-expense logging | Backend, mobile, iMessage frontend | Yes |
| 10 | **Travel Booking** | Searching, sourcing, booking flights, stays, activities, restaurants, transport | iMessage, mobile, backend | Yes |
| 11 | **Brand & Design System** | Visual identity, design tokens, Figma assets — the world | Figma | Yes |
| 12 | **Launch & GTM** | Video, socials, referrals, giveaways — getting the word out | Figma, social platforms, etc. | Yes |
| 13 | **QA & Testing** | Criteria validation, regression testing — does the code work? | ClickUp, GitHub Issues | Yes |
| 14 | **AI Platform Connectors** | MCP remote server for Claude, OpenAI, and other AI platforms — meet users where they are | External services, backend | Post-April 2 |
| 15 | **Logistics Agent** | Autonomous trip logistics — research, recommend, book on behalf of the group | Backend, iMessage, mobile | Post-April 2 |

### Scope Gap Cards

**1. Beta & User Feedback**
Built: TestFlight distribution, feedback → GitHub pipeline
Remaining: Additional distribution channels, feedback triage process

**2. Core Trip Experience**
Built: 15 of 16 items — creation, editing, multi-city, phases, covers, links, calendar, home tab, discover, all expense flows
Remaining: Trip card customization (needs design)

**3. Group Decision-Making**
Built: Destination voting, date voting, activity voting
Remaining: Wire 22 notification triggers (41 criteria), guided planning cadence, role cards
Blocker: Guided cadence + role cards need design before dev

**4. Travel Identity**
Built: Home airport, visited countries
Remaining: Finish Travel DNA quiz (in progress), connector wallet, airline connectors, passport/DL storage, stay/restaurant connectors, loyalty auto-apply
Blocker: Connector wallet needs design (Jake has sketch)

**5. Onboarding & Teaching**
Built: Vibe quiz in trip creation
Remaining: First 60-second iMessage experience, app download CTA, tooltips
Blocker: All 3 remaining items need design

**6. Post-Trip & Retention**
Built: Final expense settlement
Remaining: Finish post-trip review (in testing, 39 criteria), photo gallery, rewards program (Tryps Miles)

**7. iMessage Agent**
Built: 4 of 9 items partial (Linq basic, context, queries, sync)
Remaining: Agent personality (Jennifer Test), expense parsing, voting facilitation, proactive behavior, non-app-user participation
Blocker: Voice & tone guide needs design/copy before dev

**8. Agent Intelligence**
Built: Nothing
Remaining: Vote-on-behalf (agent proxy voting), per-user + per-trip + cross-trip memory architecture, recommendations engine (activity database + personalized ranking + feedback loop)
Blocker: Vibe quiz data must be accessible (already built). System prompt extension points (SC-34 from iMessage Agent) must exist.
Note: Claude Connector moved to scope 14, Logistics Agent moved to scope 15 (both post-April 2). Spec complete: 56 criteria.

**9. Payments Infrastructure**
Built: Nothing
Remaining: Stripe card-on-file, pay-on-behalf, auto-expense logging from bookings, group booking

**10. Travel Booking**
Built: 8 of 9 items — flights, accommodations, activities, transport, packing, itinerary
Remaining: Restaurant sourcing, Duffel flight booking

**11. Brand & Design System**
Built: Brand strategy doc, color palette, typography, dark mode tokens — aligned in the app, everyone knows it
Remaining: A few outstanding screens need polish, brand book in Figma
Note: This scope can block other scopes (new UI screens depend on brand alignment)

**12. Launch & GTM**
Built: Nothing
Remaining: Landing page update, App Store listing, launch video, socials, Wispr playbook, referral incentives, giveaways

**13. QA & Testing**
Built: QA pass started (partial, Andreas)
Remaining: Complete 19 core flows validation, 240+ criteria across all scopes, ClickUp reconciliation, regression testing on all integrations
Note: Runs in parallel — depends on other scopes finishing

**14. AI Platform Connectors** *(Post-April 2)*
Built: Nothing
Remaining: Remote MCP server (OAuth 2.1, 14+ tools, CORS, Streamable HTTP transport), multi-platform support (Claude, OpenAI, etc.), directory submission, documentation
Note: Carved from scope 8 on 2026-03-22. Original Claude Connector spec had 36 criteria — to be expanded for multi-platform. Validates the agent layer thesis: if Claude can operate Tryps, so can our own agents.

**15. Logistics Agent** *(Post-April 2)*
Built: Nothing
Remaining: Autonomous trip logistics orchestration — agent researches options, presents ranked recommendations (Citymapper-style), books after group approval, auto-recovers from failures
Note: Carved from scope 8 on 2026-03-22. Original spec had 26 criteria. Built LAST — depends on Agent Intelligence (scope 8), Payments Infrastructure (scope 9), and Travel Booking (scope 10) all being functional first.

---

### Cross-Reference: Existing Specs & ClickUp Mapping

| # | Scope | tryps-docs specs | ClickUp tickets |
|---|-------|-----------------|-----------------|
| 1 | Beta & User Feedback | `p5/friends-family`, `p5/strangers-review` | `86e0emube`, `86e0emubu` |
| 2 | Core Trip Experience | `p1/core-flows` | (existing feature tickets) |
| 3 | Group Decision-Making | `p1/notifications-voting` (41 criteria) | `86e0emu5q` |
| 4 | Travel Identity | `p1/travel-dna` (25 criteria), `p2/connectors` (25 criteria) | `86e0emu52`, `86e0emu86` |
| 5 | Onboarding & Teaching | `p4/tooltips-teaching` | `86e0emu6c` |
| 6 | Post-Trip & Retention | `p1/post-trip-review` (39 criteria) | `86e0emu4g` |
| 7 | iMessage Agent | `p2/linq-imessage` (41 criteria) | `86e0emu7g`, `86e0f948t` |
| 8 | Agent Intelligence | `p1/recommendations`, `p3/vote-on-behalf` | `86e05v28h`, `86e0ajhte` |
| 14 | AI Platform Connectors | `p1/claude-connector` (36 criteria) | `86e0emu56` |
| 15 | Logistics Agent | `p3/logistics-agent` (26 criteria) | `86e0emu8z` |
| 9 | Payments Infrastructure | `p2/stripe-payments` (12 criteria), `p3/pay-on-behalf` | `86e0emu70`, `86e0emu8e` |
| 10 | Travel Booking | `p3/duffel-apis` | `86e06y10g` |
| 11 | Brand & Design System | (in `shared/brand.md`, `shared/brand-strategy.md`) | — |
| 12 | Launch & GTM | `p4/launch-video` (15 criteria), `p4/socials-presence`, `p4/wispr-playbook`, `p4/referral-incentives`, `p4/giveaways` | `86e0emu98`, `86e0emu9w`, `86e0emu9h`, `86e0emua8`, `86e0emuar` |
| 13 | QA & Testing | (cross-cutting) | (tracked via scope tickets) |

---

## 3. Sequencing Roadmap (March 20 → April 2)

13 days. The constraint isn't scope order — it's blockers. Most scopes run in parallel across the team. Sequencing is about making sure nobody is ever idle waiting on someone else.

### Dependency Chain

```
#11 Outstanding screen polish ──→ New UI screens (#3, #4, #5, #7)
#11 Voice & tone guide   ──→ #7 Agent personality ──→ #7 Non-app-user participation
#4  Travel DNA (finish)  ──→ #8 Vote-on-behalf, Recommendations
#4  Connector wallet design ──→ #4 Airline connectors ──→ #9 Stripe
                            ──→ #4 Passport storage
#7  Linq refinement ──→ #7 Expense parsing, Voting facilitation
#13 Core flows QA ──→ #3 Notifications wiring ──→ #7 iMessage agent triggers
```

**Critical path:** Voice & tone guide → agent personality → Linq refinement → full QA → beta

### Wave 1: Fire All Blockers

TBD — to be filled after weekend prep.

### Wave 2: Parallel Dev Lanes

TBD

### Wave 3: Integration & Ship

TBD

### Sequencing Principles

1. **Unblock-first.** Anything that gates downstream work fires immediately. Design and in-progress items clear the path for dev lanes.
2. **Parallel swim lanes.** Once blockers clear, each person has independent work — no one waits on anyone else.
3. **Payments and Booking are last.** Per strategic principle (vibe → needs → facilitation → booking), these depend on agent and identity layers being functional.
4. **QA is continuous, not a wave.** Runs from Day 1 through April 2. Intensity increases as scopes finish.

---

### Jake's Weekend Prep (Mar 20-22)

The team comes back Monday. Everything they need to hit the ground running should be ready. This weekend is about setting the table.

**1. Restructure tryps-docs/scopes/**
The old phase-based folder structure (p1/, p2/, etc.) doesn't match the 13 MECE scopes. Restructure to scope-based folders so every team member and Marty can find exactly what they need per scope. *(See Section 5 — File Structure.)*

**2. Write objective.md for each scope**
Each of the 13 scope folders needs a clear objective: what success looks like, what's in/out, and the current gap (from the gap cards above). This is the first thing a dev or agent reads when they pick up a scope.

**3. Write testing.md for scopes that need QA**
Andreas needs a testing structure — not just "test 19 core flows" but: which flows, what criteria per flow, what pass/fail looks like. Pull from existing spec criteria where they exist (240+ criteria across specs).

**4. Write design.md for scopes that need design**
Consolidate what designers need into per-scope briefs: connector wallet sketch, voice & tone guide brief, onboarding screen requirements, outstanding screens that need polish.

**5. Draft wave assignments**
Using the dependency chain and gap cards, draft who owns what in each wave. Doesn't need to be perfect — needs to be clear enough that Monday morning, everyone reads their name and starts.

**6. Reconcile state.md**
The current `shared/state.md` is stale (all 21 scopes show "not-started", phase-based IDs). Update to reflect the 13 MECE scopes, actual status, and current assignees.

---

## 4. Team Assignments (TBD)

All assignments below are **TBD** — this is the wireframe. Each person has a column of scopes stacking toward the April 2 deadline.

### Assignment Map → April 2

```
                          APRIL 2
                      ─────────────────────────────────────────────
                      │             │             │               │
                      │             │             │               │
                      │             │             │               │
                      │   ┌───────┐ │  ┌────────┐ │  ┌──────────┐│
                      │   │       │ │  │        │ │  │          ││
                      │   │  TBD  │ │  │  TBD   │ │  │   TBD    ││
                      │   │       │ │  │        │ │  │          ││
                      │   ├───────┤ │  ├────────┤ │  ├──────────┤│
          ┌────────┐  │   │       │ │  │        │ │  │          ││
          │        │  │   │  TBD  │ │  │  TBD   │ │  │   TBD    ││
          │  TBD   │  │   │       │ │  │        │ │  │          ││
          │        │  │   ├───────┤ │  ├────────┤ │  ├──────────┤│
          ├────────┤  │   │       │ │  │        │ │  │          ││
          │        │  │   │  TBD  │ │  │  TBD   │ │  │   TBD    ││
          │  TBD   │  │   │       │ │  │        │ │  │          ││
          └────────┘  │   └───────┘ │  └────────┘ │  └──────────┘│
             JAKE     │    ASIF     │   RIZWAN    │  NADEEM/     │
                      │             │             │  ANDREAS     │
                      ─────────────────────────────────────────────
                                    Mar 20
```

### Per-Person Scope Slots (All TBD)

| Person | Role | Scope Slots (to be filled) |
|--------|------|---------------------------|
| **Jake** | Product / Founder | TBD, TBD |
| **Asif** | Lead Dev | TBD, TBD, TBD |
| **Rizwan** | Agent Layer Dev | TBD, TBD |
| **Nadeem** | Core App Dev | TBD, TBD, TBD |
| **Andreas** | QA | TBD, TBD |
| **Designer(s)** | Figma / UI | TBD, TBD, TBD |
| **Sean** | Creative | TBD (post-April 2) |

### Screens to Design (Designer Workload)

| Screen | Scope | Blocks | Priority |
|--------|-------|--------|----------|
| Font/color/background reconciliation | #11 | All new UI | Immediate |
| Agent personality / voice guide | #11 | iMessage Agent (#7) | Immediate |
| First 60-second iMessage experience | #5 | iMessage Agent (#7) | High |
| Connector wallet (profile page) | #4 | Connectors, Stripe | High |
| Guided planning cadence | #3 | — | Stretch |
| Role cards (character select) | #3 | — | Stretch |
| Tooltips & teaching moments | #5 | — | Stretch |
| Travel DNA sharing card | #4 | — | Stretch |
| Trip card customization | #2 | — | Stretch |
| Rewards program UI | #6 | — | Post-April 2 |
| Brand book (30-40 screens) | #11 | — | Post-April 2 |
| Launch video storyboard | #12 | — | Post-April 2 |

---

## 5. Scope File Structure

Flat folders, no phase nesting. Phase is metadata in frontmatter, not a directory.

### Folder Structure

```
scopes/
  INDEX.md                          ← auto-generated manifest, lists all 13 scopes + status

  beta-user-feedback/
    objective.md                    ← what + why + success looks like (stable, short)
    spec.md                         ← engineering spec with success criteria
    design.md                       ← what needs Figma (only created when needed)
    testing.md                      ← QA criteria + test plan + pass/fail rubric
    state.md                        ← living progress (Marty auto-generates, Jake verifies)
    refs/                           ← optional, reference material

  core-trip-experience/
  group-decision-making/
  travel-identity/
  onboarding-teaching/
  post-trip-retention/
  imessage-agent/
  agent-intelligence/
  payments-infrastructure/
  travel-booking/
  brand-design-system/
  launch-gtm/
  qa-testing/
```

### What Each File Does

**`objective.md`** — The stable north star. What this scope IS, what's in/out, what success looks like. Short (under 30 lines). First thing an agent or new team member reads.

```yaml
---
id: travel-identity
title: "Travel Identity"
scope_number: 4
owner: jake
created: 2026-03-20
---
```

**`spec.md`** — Engineering spec with numbered success criteria. Devs build from this. Already exists for many scopes — migrate from current `p1/`, `p2/`, etc. folders.

```yaml
---
id: travel-identity
status: needs-spec | specced | in-progress | review | testing | done
assignee: nadeem
dependencies: []
clickup_id: "86e0emu52"
criteria_count: 25
criteria_done: 0
last_updated: 2026-03-20
---
```

**`design.md`** — Only created when the scope has design work. Tells designers what they need to produce.

```yaml
---
id: travel-identity
needs_figma: true
designer: unassigned
design_status: not-started | in-progress | ready | n/a
screens:
  - connector-wallet
  - travel-dna-sharing-card
last_updated: 2026-03-20
---
```

**`testing.md`** — QA criteria extracted from spec.md, plus test steps and pass/fail rubrics. Andreas's working document. Auto-seeded from spec criteria, then refined by hand.

```yaml
---
id: travel-identity
qa_assignee: andreas
test_status: not-started | in-progress | passing | failing
criteria_total: 25
criteria_passing: 0
last_tested: null
---
```

**`state.md`** — The living pulse. Marty auto-generates structured fields from ClickUp. Jake verifies and adds narrative context (open questions, blockers, what's next).

```yaml
---
id: travel-identity
status: in-progress
assignee: nadeem
clickup_id: "86e0emu52"
clickup_status: in progress
criteria: 3/25
blockers: []
last_pr: null
last_updated: 2026-03-20T14:00:00Z
updated_by: marty
---

## Current State

{narrative — written by human or agent with context}

## Open Questions

{things that need answers before work can continue}

## What's Next

{immediate next steps}
```

### INDEX.md — The Machine-Readable Manifest

Auto-generated. Replaces the old phase-based README. One file, full picture. Agents read this first.

```yaml
---
generated: 2026-03-20T14:00:00Z
total_scopes: 13
---
```

| # | ID | Title | Status | Assignee | Criteria |
|---|-----|-------|--------|----------|----------|
| 1 | beta-user-feedback | Beta & User Feedback | partial | jake | — |
| 2 | core-trip-experience | Core Trip Experience | built | — | — |
| ... | ... | ... | ... | ... | ... |

### Agent Reading Order

```
INDEX.md → state.md → objective.md → spec.md
```

Progressive disclosure. Overview first, details on demand.

### Migration (Weekend)

1. Flatten: `scopes/p1/travel-dna/` → `scopes/travel-dna/`
2. Create `objective.md` for each scope (extract from spec.md What/Why sections)
3. Create `state.md` for each scope (seed from ClickUp status)
4. Create `design.md` for scopes with design work
5. Create `testing.md` for scopes with acceptance criteria
6. Generate `INDEX.md`
7. Update `shared/state.md` to read from new flat structure
8. Delete old `p1/`, `p2/`, `p3/`, `p4/`, `p5/` directories

---

## Appendix B: Sources

- `/tryps-docs/docs/p2-p3-strategy-intake.md` — 38 questions answered (vision locked)
- `/tryps-docs/shared/brand.md` — Brand system tokens
- `/tryps-docs/shared/brand-strategy.md` — Brand strategy (pending Trent review)
- `/tryps-docs/shared/state.md` — Scope status (needs reconciliation)
- `/tryps-docs/shared/clickup.md` — ClickUp task mapping
- `/tryps-docs/scopes/` — All scope specs (P1-P5)
- `/t4/` — Codebase audit (60-70% feature complete)
