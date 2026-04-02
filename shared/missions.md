# Missions

> Canonical source of truth for Jake's active missions.
> Marty reads this file when generating standups and nightly reports.
> Add missions here (or via `/mission` in Slack). Do NOT edit missions inside standup docs.
> Last updated: 2026-04-02

---

## Team Goal

**We need to be able to onboard customers to really USE the application ASAP and actually book a trip end to end.** What is stopping us from this reality? This matters more than anything.

---

## Today's Missions

> These are the priorities RIGHT NOW. Ordered by importance.

### Mission 1: Book All Travel — End to End
**Owner:** Rizwan + Asif | **Created:** Apr 1 | **Status:** In progress (PR #331)
A user must be able to book flights, hotels, activities, and transport — for themselves or on behalf of someone else in the group. This is the core value prop and the #1 thing blocking the team goal. Nothing matters more.

### Mission 2: Onboarding Flow with Emoji Voting — Group Facilitation Engine
**Owner:** Rizwan (lead), Asif (Linq API) | **Created:** Apr 2 | **Status:** Specced — 25 SC in `group-decision-making/spec.md`
Spec complete. 11 new SC added (SC-15–25) covering: participant awareness (agent knows who's in the chat — fixes Issue #341), emoji voting via Apple iOS tapback reactions, flexible tally with criticality-based timeout, vote prediction for built-out profiles, and immediate facilitation → booking transition. Priority: SC-15–16 first (live bug), then SC-18–20 (emoji voting core). Feeds directly into Mission 1 (Book All Travel). [Issue #341](https://github.com/cojakestein-sketch/tryps/issues/341)

### Mission 3: Customer Interviews — How Do We Present the Product?
**Owner:** Asif + Jake | **Created:** Apr 1 | **Status:** Pipeline live at marty.jointryps.com/interview
Not just running interviews — the bigger question is how do we actually present Tryps to people so they GET IT and want to use it? Automated interview pipeline is live. Jake provides name + phone, agent calls, runs interview, logs transcript. Goal: first 25 interviews. Every interview teaches us how to onboard better.

### Mission 4: Close the Books
**Owner:** Jake | **Created:** Apr 1 | **Status:** Open
March financials, contractor payments, expenses reconciliation. End of month housekeeping.

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
**Owner:** Asif + Rizwan | **Created:** Apr 2 | **Status:** Open — [Issue #341](https://github.com/cojakestein-sketch/tryps/issues/341)
**How do we complete this?** Two fixes: (1) agent knows who's in the group chat and tailors responses — no "send them the link" when they're already here, (2) native emoji polling for dates/votes. This feeds directly into Mission 2 (onboarding flow). Complete when: tested in a real group chat where agent correctly identifies participants and uses emoji reactions for voting.

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
- Bug Burn-Down (20 remaining of 78)
