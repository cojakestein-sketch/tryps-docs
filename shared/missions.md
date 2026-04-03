# Missions

> Canonical source of truth for Jake's active missions.
> Marty reads this file when generating standups and nightly reports.
> Add missions here (or via `/mission` in Slack). Do NOT edit missions inside standup docs.
> Last updated: 2026-04-03

---

## Team Goal

**We need to be able to onboard customers to really USE the application ASAP and actually book a trip end to end.** What is stopping us from this reality? This matters more than anything.

---

## Today's Missions

> These are the priorities RIGHT NOW. Ordered by importance.

### Mission 1: Fix iMessage Bugs from QA
**Owner:** Asif | **Created:** Apr 3 | **Status:** In progress
QA team (Sarfraz + Amaan) found 13 new iMessage bugs today. Asif is working through all iMessage-related issues logged by QA. Priority: resolve all agent response, voting, and trip creation bugs surfaced during testing.

### Mission 2: App Bug Fixes + Real-Time Data Updates
**Owner:** Nadeem | **Created:** Apr 3 | **Status:** In progress
Nadeem is fixing open bugs in the app (5 sent back to todo by Zain today) and focusing on real-time data updates across the trip app — activities, expenses, people, and itinerary should reflect changes instantly without refresh.

### Mission 3: Flight Booking + Third-Party Integration
**Owner:** Rizwan | **Created:** Apr 3 | **Status:** In progress
Rizwan is focused on completing the Duffel flight booking flow and third-party integration for hotels, rides, and other travel services. This is the core booking pipeline that enables end-to-end trip planning.

### Mission 4: Customer Interviews — How Do We Present the Product?
**Owner:** Asif + Jake | **Created:** Apr 1 | **Status:** Pipeline live at marty.jointryps.com/interview
Automated interview pipeline is live. Jake provides name + phone, agent calls, runs interview, logs transcript. Goal: first 25 interviews.

### Mission 5: Close the Books
**Owner:** Jake | **Created:** Apr 1 | **Status:** Open
March financials, contractor payments, expenses reconciliation.

---

## Ongoing Missions

> Missions from prior days that are in progress. Each has completion criteria.

### Unified Dashboard View for Standup
**Owner:** Rizwan + Nadeem | **Created:** Apr 1 | **Status:** Live (dashboard deployed)
**How do we complete this?** Dashboard is live at cojakestein-sketch.github.io/tryps-exec-dashboard/ and auto-rebuilds on push. Complete when: (1) missions sync correctly from shared/missions.md, (2) SC/bug counts update automatically from state pipeline, (3) Jake can do his entire morning standup from this one page without opening Slack or GitHub.

### Feedback Mechanism
**Owner:** Nadeem + Asif | **Created:** Apr 1 | **Status:** Partial (shake-to-feedback shipped)
**How do we complete this?** Three channels need to work: (1) shake-to-feedback in-app (done), (2) text `feedback:` keyword to Tryps agent routes to inbox, (3) agent proactively asks beta users for feedback. Complete when: all three channels land in one triage view Jake reviews daily. Feedback is tagged by user, screen, and severity.

### QA System
**Owner:** Asif (presenting to Jake) | **Created:** Apr 1 | **Status:** Ongoing — need report from Asif
**How do we complete this?** Asif to present in today's standup: what QA (Andreas + Warda) is testing, what's the process, what's the coverage, what bugs are they finding. Complete when: Jake understands QA as a function and can track its output. Doc + HTML deck shipped at tryps-docs/QA/ — but Jake needs a live walkthrough.

### Personalized Contact CRM
**Owner:** Cameron / Brand + GTM team | **Created:** Apr 2 | **Status:** Open
**How do we complete this?** Build a system where every person Jake/team talks to has a profile — who they are, what they care about, how they connect to Tryps. Feeds into customer interviews, outreach, and investor relations. This is a brand/GTM/product-head mission.

### Founder Presence Optimization
**Owner:** Jake / Brand + GTM team | **Created:** Apr 2 | **Status:** Open
**How do we complete this?** Jake's personal brand and presence supports Tryps growth. Strategy for social, content, events, MIT network. This is a brand/GTM mission — Sean and the growth team own execution.

### Agent Context Awareness in Group Chats
**Owner:** Asif + Rizwan | **Created:** Apr 2 | **Status:** Partial — emoji voting done (Asif), participant awareness in progress
**How do we complete this?** Two fixes: (1) agent knows who's in the group chat and tailors responses — no "send them the link" when they're already here (in progress), (2) ~~native emoji polling for dates/votes~~ **done** — emoji voting via Apple iOS tapback reactions implemented by Asif. Complete when: participant awareness is fixed and tested in a real group chat ([Issue #341](https://github.com/cojakestein-sketch/tryps/issues/341)).

---

## Completed Missions

| Mission | Completed | Notes |
|---------|-----------|-------|
| Onboarding Perfection — Deep Rich Link | Mar 25 | OG tags, web landing, trip-card-image, vCard |
| Make the link work | Mar 26 | Duplicate intro fixed, first-touch flow verified |
| Travel booking reality check | Mar 26 | 3-4 week estimate for flight search + pay |
| Calling Tryps | Mar 31 | Voice agent live (ElevenLabs + Linq) |
| Hyper Care (parked post-Apr 2) | Apr 1 | Parked — Rizwan to think about agent-native CS |

---

## Ops Missions (from standup, not Jake-created)

These were identified by Marty from repo/Slack activity — not Jake's direct missions. Track separately.

- Merge PR Backlog (14 open, failing CI)
- Unblock Rizwan SC-59-61 (Asif + Rizwan design session)
- Bug Burn-Down (10 remaining of 78 — 68 fixed)
