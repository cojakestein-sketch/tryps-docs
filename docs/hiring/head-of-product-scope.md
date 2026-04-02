---
title: "Head of Product — Role Scope"
type: role-scope
date: 2026-04-02
status: draft
owner: jake
---

# Head of Product

## 1. The Role in One Paragraph

You'd be the person who makes sure Tryps actually works for real people. Right now, Jake holds the vision and writes the specs, the devs build, and QA catches bugs — but nobody is sitting in the middle asking "is this product actually good? Would I book a trip with this? Does the iMessage experience feel the same as the app?" That's the job. You own the product experience end-to-end: reviewing specs, onboarding real users, watching them struggle, turning that friction into prioritized work, and sitting with the devs 2-3 times a week to make sure what's getting built actually matches the product we want to ship. You're not managing the team — you're the person who cares about the product as much as Jake does but has the bandwidth to be in the details every day.

---

## 2. What You Own

### 2.1 Spec & Success Criteria Management (~2 hrs/week)

**What it is:** You're the quality bar for specs. You review every `spec.md` across all 9 active scopes. You check that success criteria are testable, complete, and ordered by what matters for real users. When something's wrong or missing, you fix it or flag it.

**First 2 weeks:**
- Read all 9 scope specs end-to-end (they live at `/Users/jakestein/tryps-docs/scopes/{scope-id}/spec.md`)
- Flag any SC that's vague, untestable, or missing ("booking confirmation should feel right" -> rewrite to "booking confirmation shows flight details, price, PNR, and a share button within 2 seconds")
- Prioritize which unstarted SC actually matter for the first 50 users vs. which can wait
- Sit with Jake for a 1-hour spec review session to align on priorities

**Success looks like:** Every SC has a clear pass/fail definition. Devs never have to guess what "done" means.

### 2.2 User Onboarding & Product Validation (~4 hrs/week) — BIGGEST PRIORITY

**What it is:** You personally get people to book trips using Tryps. Screen share, watch them, log every moment of friction. The Wispr Flow model: you're in the room (virtually) watching real humans interact with the product. Between the product lead and Jake, the goal is 50-100 real users who have booked a trip within 30 days.

**First 2 weeks:**
- Week 1: Onboard yourself. Book a real trip end-to-end through iMessage + app. Log every friction point as a real user would experience it.
- Week 2: Start running onboarding sessions with 2-3 people/day from your + Jake's networks. 20-minute screen shares. Log structured notes per session (see Section 5).

**Success looks like:** 50+ people have booked a trip. You have a ranked list of the top 10 product friction points with data (how many people hit it, how bad it was, what the fix is).

### 2.3 Dev Team Working Sessions (~2-3 hrs/week)

**What it is:** 2-3 sessions per week, ~1 hour each, with the dev team. You spec out what needs to be done next, review what was built, and course-correct when something doesn't match the product intent. This is not a standup — it's a working session where you're looking at builds and making calls.

**First 2 weeks:**
- Join existing team rhythm (devs are in different time zones — Asif and Nadeem are in Pakistan, Rizwan is remote)
- Run your first session: pull up the latest TestFlight build, walk through the trip creation -> booking -> expense flow, and identify 3 things that need to change
- Establish a cadence: 2 sessions/week to start, bump to 3 if needed

**Success looks like:** Devs have clear, prioritized work coming out of every session. No ambiguity about what "good" looks like.

### 2.4 Experience QA & QA Missions (~2 hrs/week)

**What it is:** This is distinct from bug QA. Bug QA asks "does it crash?" Experience QA asks "is this a product I'd recommend to a friend?" You're the person who tests the emotional quality of the experience, the coherence across channels (iMessage vs. app), and whether the product matches the vision (the "Jennifer Test" — if your grandmother couldn't tell it's AI, we win).

More importantly, you set the QA team's weekly missions. Each week, based on what you're hearing from user onboarding sessions and feedback, you define what QA should focus on:

- **Week N:** "We heard from 4 users that the expense splitting flow is confusing. QA team — this week I need you to test every expense scenario: split by amount, split by percentage, uneven splits, adding expenses from iMessage, adding from app. Log every flow that doesn't feel intuitive, not just ones that crash."
- **Week N+1:** "Flight booking is live. QA team — book 10 flights across different routes. Test round-trip, one-way, multi-city. Try booking for a group. Does the confirmation make sense? Does it show up in the itinerary?"

This is the bridge between "what users are telling us" and "what QA tests for." Without it, QA just runs the same regression suite every week. With it, QA is laser-focused on the flows that real people are struggling with.

**First 2 weeks:**
- Do a full product walkthrough: create a trip via iMessage, open in app, add people, search flights, book, split expenses. Score each flow 1-10 on "would I actually use this?"
- Write your honest "new eyes" assessment — what's good, what's broken, what's embarrassing
- Write your first QA mission brief for the QA team based on what you found
- Share with Jake and the team

**Success looks like:** QA is testing what matters (driven by real user friction), not just what's on a static checklist. You have a living doc of experience quality scores per flow.

### 2.5 Feedback Pipeline (~1 hr/week)

**What it is:** All user feedback flows to you. Three channels: shake-to-feedback (shipped), text keyword `feedback:` to the agent, and agent-prompted collection. You triage it: what's a bug (goes to QA team in ClickUp), what's a product gap (goes to spec backlog), what's noise.

**First 2 weeks:**
- Get access to the feedback inbox (needs input from Jake — where does shake-to-feedback land today?)
- Set up your triage process: read feedback daily, categorize, turn high-signal items into ClickUp tickets or spec updates
- Review the first batch of onboarding session feedback and prioritize

**Success looks like:** No feedback sits unprocessed for more than 24 hours. High-signal feedback becomes work within the week.

### 2.6 Cross-Scope Coherence (~1 hr/week)

**What it is:** The "nobody is looking holistically" problem. You're the person who notices that the iMessage agent says one thing but the app shows another. That the booking flow in iMessage doesn't match the booking flow in the app. That the onboarding experience makes promises the product can't keep yet.

**First 2 weeks:**
- Map the full user journey across channels: iMessage -> app -> booking -> expenses -> post-trip
- Identify the 3 biggest coherence gaps (where the experience feels like different products)
- Bring these to the dev working session with concrete "make these match" asks

**Success looks like:** A user who starts in iMessage and moves to the app never feels like they switched products.

---

## 3. What You Don't Own (Jake Retains)

- **Vision and product thesis** — the "travel agent in your group chat" positioning, the four strategic bets, the Jennifer Test bar. You execute against this vision; Jake sets it.
- **Brand and voice** — Tryps brand system, voice & tone, visual identity. Sean (Creative Director) owns brand/GTM. Jake has final say on brand.
- **Investor relations** — pitch, fundraising conversations, Martin Trust Center prep.
- **GTM strategy** — launch plan, socials, UGC, giveaways. Sean's domain with Jake's oversight.
- **Agent architecture decisions** — system prompt design, memory architecture, how the AI layer works technically. Rizwan and Jake own this.
- **Hiring final calls** — you can recommend, Jake decides.

**The line:** You own "is this product good for users?" Jake owns "is this the right product to build?" When those questions intersect, you meet and hash it out.

---

## 4. The Team

### Org Chart

```
JAKE (Founder)
├── Head of Product (this role)
│   Owns: product experience, specs, user onboarding, QA missions, feedback
│
├── ENGINEERING
│   ├── Asif — Team Lead + iMessage Agent + Travel Booking
│   ├── Nadeem — Core App + Output-Backed Screen
│   └── Rizwan — Agent Intelligence + Travel Booking
│
├── QA (reports through Asif)
│   ├── Sarfaraz Ahmed — QA Tester (1-week trial)
│   ├── Zain Waheed — QA Tester (1-week trial)
│   └── Aman Khan — QA Tester (1-week trial)
│
├── GTM (Sean's domain)
│   ├── Sean DeFaria — Creative Director
│   ├── Enej Stanovnik — GTM Infra Engineer
│   └── Growth Engineer — (hiring)
│
├── Marty — AI Agent (automated ops, PR review, state sync)
└── Jackson — Strategy Advisor
```

### Who You Work With

**Asif (Team Lead)** — Owns the iMessage agent and backend infrastructure. Your primary partner for anything iMessage-related: the agent's behavior, Linq integration, group chat experience. He also manages the QA testers. Asif is sharp and opinionated — he'll push back on specs that don't make technical sense, which is exactly what you want. Your relationship: weekly 1:1 on iMessage experience quality + ad hoc when user feedback surfaces iMessage-specific issues.

**Nadeem (Core App Dev)** — Builds the mobile app: trip screens, overview, itinerary, expenses, the visual layer. He's working on the Output-Backed Screen (the visual trip overview) and has multiple specced scopes queued behind it. Your relationship: working sessions focused on prioritizing his backlog — which SC matter most for the first 50 users, and which can wait. He needs a product person helping him triage, not just more specs.

**Rizwan (Agent Layer Dev)** — Owns agent intelligence: memory architecture, vote-on-behalf, recommendations engine. Also co-owns travel booking with Asif. He's the brain behind what makes the agent smart. Your relationship: review what the agent does from a user perspective — does vote-on-behalf actually feel helpful? Do recommendations make sense? You're his user-quality gut check.

**QA Team (3 testers, 1-week trial)** — Sarfaraz Ahmed, Zain Waheed, and Aman Khan are on a 1-week trial. They handle bug QA: test cases, bug reports, regression testing. They report through Asif, but the product lead sets the experience bar — weekly QA missions tell them what to focus on. This role is the bridge between "what users are struggling with" and "what QA tests for." After the trial, the product lead and Jake decide who stays.

**Sean (Creative Director)** — Owns brand and GTM. You don't work directly together on product, but you should be aware of what he's shipping so the product experience matches the brand promise. Light coordination only.

---

## 5. 30-Day User Onboarding Plan

**Goal:** 50-100 real people book a trip using Tryps within 30 days.

**Sourcing:** Product lead's personal network + Jake's network + McKinsey alumni network (Jake to source a batch). All contacts tracked in Jake's personal CRM across scopes so scheduling and follow-up are seamless.

### Week 1: Product Lead Onboards Themselves (Days 1-7)

| Day | Activity | Output |
|-----|----------|--------|
| 1-2 | Download TestFlight build. Create a real trip via iMessage (+1 917 745 3624). Explore every screen in the app. | "New eyes" assessment doc: first impressions, friction log, 10 best/worst moments |
| 3-4 | Book a flight end-to-end through the agent. Add friends to a trip. Try expenses. Test the group chat experience. | End-to-end flow map with pain points scored 1-5 |
| 5 | Read all scope specs (`/Users/jakestein/tryps-docs/scopes/*/spec.md`). Understand what's built vs. planned. | Annotated spec notes: "this SC matters for onboarding" vs. "this can wait" |
| 6-7 | Sync with Jake: share assessment, align on what to fix before onboarding others. | Prioritized punch list for dev team |

### Week 2: First Cohort — Personal Networks (Days 8-14)

**Target: 10-15 people onboarded**

- Product lead + Jake each source 5-8 people (friends who travel, friends planning trips, McKinsey contacts)
- All contacts logged in CRM with status: contacted -> scheduled -> session complete -> follow-up
- Onboarding session format (20 min each):
  1. Send TestFlight link + add them to an iMessage group with the Tryps agent
  2. Screen share (FaceTime, Zoom, or in person)
  3. Give them ONE task: "Plan a weekend trip with 2 friends using Tryps"
  4. Watch silently for 10 min. Note every hesitation, tap, confused look.
  5. 5-min debrief: "What was confusing? What was cool? Would you use this for a real trip?"
  6. Log in structured markdown (see template below)
- End of week: synthesize top 5 friction points, share with team, create ClickUp tickets
- Write first QA mission brief based on findings

### Week 3: Second Cohort + Iterate (Days 15-21)

**Target: 15-25 more people (cumulative: 25-40)**

- Source from: extended networks, McKinsey batch, MIT connections, friends-of-friends
- Use the automated interview pipeline at `marty.jointryps.com/interview` for pre-screening and initial outreach
- Same onboarding format, but now testing whether Week 2 fixes actually helped
- Start tracking: conversion rate (% who complete a booking), time-to-first-booking, NPS score

### Week 4: Scale + Synthesize (Days 22-30)

**Target: 50-100 total**

- By now you have a playbook. Run 3-5 sessions/day, 20 min each.
- Source broader: social posts, Jake's MIT network, McKinsey second-degree connections
- Synthesize findings into a "State of the Product" report:
  - Top 10 friction points (ranked by frequency and severity)
  - User quotes that tell the story
  - Recommended product changes for next sprint
  - NPS trend line

### Session Log Template

```markdown
## Onboarding Session: {Name}

**Date:** {YYYY-MM-DD}
**Source:** {How we found them: friend, McKinsey, MIT, referral}
**Device:** {iPhone model}
**Trip type:** {Weekend getaway / group trip / solo / etc.}
**Completed booking:** {Yes / No — if no, where did they stop?}
**CRM status:** {session complete}

### Observations (what I saw)
- {Timestamp} — {What they did, what happened, their reaction}
- ...

### Friction Points (scored 1-5, 5 = worst)
1. {Description} — {Score}
2. ...

### Quotes
> "{Verbatim thing they said}"

### Would they use Tryps for a real trip?
{Yes / Maybe / No — and why}

### Top 3 product fixes this suggests
1. ...

### QA Mission Input
{What should QA test based on this session?}
```

### Onboarding Metrics

| Metric | Week 1 | Week 2 | Week 3 | Week 4 |
|--------|--------|--------|--------|--------|
| People onboarded | 1 (self) | 10-15 | 25-40 | 50-100 |
| Completed a booking | -- | Track | Track | Track |
| Avg time to first booking | -- | Track | Track | Track |
| Top friction point | Identify | Fix | Re-test | Resolve |
| NPS (1-10) | -- | Track | Track | Track |

---

## 6. Sample Weekly Cadence

This is a starting template at ~10 hours. Adjust based on what you learn.

| Day | Time | Activity | Duration |
|-----|------|----------|----------|
| **Monday** | Morning | Review scope state on [exec dashboard](https://cojakestein-sketch.github.io/tryps-exec-dashboard/), process weekend feedback, plan the week | 1 hr |
| **Tuesday** | Afternoon | Dev working session #1: review latest builds, demo new features, course-correct | 1 hr |
| **Tuesday** | Flexible | User onboarding sessions (2-3 people) | 1.5 hrs |
| **Wednesday** | Morning | Spec & SC review: read specs, check criteria, write improvements | 1.5 hrs |
| **Thursday** | Afternoon | Dev working session #2: prioritize next sprint, unblock decisions | 1 hr |
| **Thursday** | Flexible | User onboarding sessions (2-3 people) | 1.5 hrs |
| **Friday** | Morning | QA mission brief: write next week's QA focus based on user feedback | 30 min |
| **Friday** | Afternoon | Jake sync: share weekly findings, align on priorities, flag decisions needed | 30 min |
| **Ongoing** | Daily, 15 min | Feedback triage: scan inbox, categorize, escalate urgent items | 1 hr total |

**Total: ~9.5 hours/week**

That leaves headroom for ad hoc — a user calls confused, a dev needs a quick product decision, Jake wants to brainstorm something.

---

## 7. Current Product State

Live dashboard: [cojakestein-sketch.github.io/tryps-exec-dashboard](https://cojakestein-sketch.github.io/tryps-exec-dashboard/)

### Overall (from dashboard, April 2)

| Metric | Value |
|--------|-------|
| Product SC | **98/325** (30% complete) |
| Open Bugs | **20** (down from 78 on Mar 27) |
| SC velocity | ~6 SC/day over last week |

### Scope Progress (as of April 2, 2026)

| Scope | Status | SC Progress | What's Happening |
|-------|--------|-------------|-----------------|
| Core Trip Experience | Testing | 15/16 | Nearly complete. Bug testing in progress. |
| iMessage Agent | Done | 51/57 | 6 remaining SC blocked on Agent Intelligence. |
| Agent Intelligence | In Progress | 27/61 | Memory architecture + vote-on-behalf built. Recommendations engine is biggest gap. |
| Travel Booking | In Progress | 5/70 | Duffel flight search integrated. Stays, restaurants, transport still open. |
| Output-Backed Screen | In Progress | 7/48 | Trip overview being built. Blocked on design for some screens. |
| Beta & User Feedback | In Progress | -- | This IS the product lead's onboarding program. |
| Group Decision-Making | Specced | 0/14 | Voting flows, notifications, facilitation engine. Spec exists, not started. |
| Post-Trip & Retention | Specced | 0/31 | Review flow, photo gallery, rewards. Spec exists, not started. |
| Travel Identity | Specced | 0/50 | DNA quiz, connector wallet, airline integrations. Spec exists, not started. |
| Onboarding & Teaching | Specced | 0/14 | First 60-second experience, tooltips. Spec exists, not started. |

### What Each Person Is Working On

| Person | Current Focus | Key Scope |
|--------|--------------|-----------|
| **Asif** | iMessage agent refinements + travel booking (Duffel integration) | iMessage Agent, Travel Booking |
| **Nadeem** | Output-Backed Screen (trip overview) + bug fixes | Output-Backed Screen, Core Trip |
| **Rizwan** | Agent intelligence (memory, vote-on-behalf, recommendations) + cross-scope interfaces with Asif | Agent Intelligence, Travel Booking |
| **QA Team** (3, trial) | Bug testing across all active scopes | Cross-cutting |

### Deferred (Post-Launch)

| Scope | Notes |
|-------|-------|
| Voice Calls | Done — live, 14/14 SC |
| Customer Service & Triaging | Needs spec. Manual pre-launch. |
| Payments Infrastructure | Absorbed into Travel Booking |

---

## 8. Success Metrics

### 30 Days

- [ ] 50-100 people have been onboarded and attempted to book a trip (between product lead and Jake)
- [ ] "State of the Product" report written with ranked friction points and user quotes
- [ ] All 9 scope specs reviewed with product lead's annotations
- [ ] Dev working session cadence established and running (2-3/week)
- [ ] Feedback pipeline operational: <24hr triage time
- [ ] Experience QA baseline: every major flow scored 1-10
- [ ] First 4 weekly QA mission briefs written and executed

### 60 Days

- [ ] Top 5 friction points from early onboarding are resolved in the product
- [ ] NPS trend is positive (improving week over week)
- [ ] Product lead is the primary spec reviewer (Jake writes, product lead sharpens)
- [ ] QA team is trained on experience-quality criteria, not just bug detection
- [ ] Cross-scope coherence gaps identified and 50% resolved
- [ ] Referral loop starting: onboarded users adding friends to group chats

### 90 Days

- [ ] Users are booking trips without a screen-share chaperone
- [ ] Product lead can articulate "here's what's working, here's what's not, here's what to build next" without Jake in the room
- [ ] Product decisions are faster because the product lead is in the details daily
- [ ] QA missions are fully driven by user feedback data, not guesswork

---

## 9. How to Get Started

**Before Day 1 (Jake's setup tasks):**
- Add product lead to Slack (`#tryps-agents`, `#martydev`)
- Add product lead to TestFlight
- Add product lead to GitHub (cojakestein-sketch/tryps — read access)
- Add product lead to ClickUp (workspace `9017984360`)
- Share exec dashboard link: [cojakestein-sketch.github.io/tryps-exec-dashboard](https://cojakestein-sketch.github.io/tryps-exec-dashboard/)
- Share CRM tracker for onboarding contact scheduling

**Day 1:**
- Read this doc
- Read the strategic roadmap: `/Users/jakestein/tryps-docs/docs/plans/2026-03-20-feat-strategic-roadmap-mece-scope-plan.md`
- Download the latest TestFlight build
- Text the Tryps number (+1 917 745 3624) and try to plan a trip

**Day 2:**
- Read all 9 scope `objective.md` files (15 min total — they're short)
- Do a full product walkthrough: create trip -> add people -> search flights -> book -> expenses
- Write your "new eyes" doc

**Day 3:**
- First working session with Jake: share your assessment, align on priorities
- Start reading specs

The fastest way to be useful is to be a user first and a product person second. Use the product. Break it. Then fix the experience.
