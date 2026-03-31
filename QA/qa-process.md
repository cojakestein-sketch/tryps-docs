---
title: "QA Process at Tryps"
date: 2026-04-01
author: Asif Raza
type: process-doc
---

# QA Process at Tryps

---

## Team Structure

| Role | Who | Responsibility |
|---|---|---|
| QA Tester | New hire (starting week of April 7) | Test app + iMessage, file bugs in ClickUp, write test cases, verify fixes |
| Dev Lead / QA Owner | Asif | Owns QA process, reviews QA output, triages P1s, hires QA team |
| Bug Fixer | Nadeem (app), Asif (iMessage/backend), Rizwan (agent) | Picks bugs from ClickUp, fixes, moves to "Ready for Testing" |

**Hiring plan:** Start with 1 QA tester. Train for 1 week on the full app + iMessage flows. After 1 week, evaluate adding a 2nd tester if needed.

**Rate:** $20-25/hr via Upwork | **Hours:** 3-4 hrs/day, 5 days/week | **Device:** Must own iPhone 12+ with iMessage

---

## Bug Tracking — Single Source of Truth

**All bugs live in ClickUp** (list: "01 - This Week").

| Source | Where it goes |
|---|---|
| QA tester finds bug | ClickUp — sub-ticket under the module's main ticket |
| User reports via "Give us Feedback" | GitHub Issue (auto-created) → triaged into ClickUp |
| Dev finds bug during work | ClickUp directly |

**Structure:** One main ticket per module (Expenses, Packing, People, etc.) with all related bugs as sub-tickets underneath. Total count = main tickets only.

---

## Daily Workflow

### Dev Team (daytime)
1. Pick bug from ClickUp ("To Do") → fix → PR → merge to develop
2. End of day: Asif creates TestFlight build from develop

### QA Tester (same working hours as devs)
1. **Morning:** Update TestFlight to yesterday's build
2. **Test (2-3 hrs):** Run test cases for the day's module. Before testing any module, QA creates a test case file listing every scenario to verify. Test against that list and mark pass/fail.
3. **Bugs found:** File in ClickUp as sub-ticket under the module's main ticket. Include: severity (P1/P2/P3), steps to reproduce, expected vs actual, screen recording.
4. **Verify fixes:** Re-test bugs moved to "Ready for Testing" by devs. If fixed → move to "Ready for Production". If not → move back to "To Do" with note.
5. **End of day:** Update test case file with results. Report status in standup.

### Why same hours as devs?
- QA tests yesterday's build while devs work on today's fixes
- If QA hits a blocker or needs clarification, devs are available immediately
- No 12-hour feedback gap between finding a bug and getting an answer

---

## Bug Lifecycle

```
Found by QA → ClickUp (To Do, P1/P2/P3)
    → Dev picks up → Fixes → PR merged → "Ready for Testing"
        → QA verifies on TestFlight build
            → Working? → "Ready for Production" → Done
            → Still broken? → Back to "To Do" with note
```

| Severity | Meaning | Response Time |
|---|---|---|
| **P1** | Crash, data loss, blocked flow | Same day. QA messages Asif on Slack immediately. |
| **P2** | Broken feature, workaround exists | This week. Filed in ClickUp, picked up in standup. |
| **P3** | Cosmetic, minor annoyance | When convenient. Backlog. |

---

## QA in Standup

QA tester participates in daily standup like devs. Tracked metrics:

| Metric | How |
|---|---|
| Test cases written | QA creates test case file per module before testing |
| Test cases passed / failed | Marked in the test case file |
| Bugs found today | Count of new ClickUp tickets filed |
| Bugs verified today | Count of tickets moved to "Ready for Production" |
| Blockers | Anything preventing testing (build issues, unclear flows, device problems) |

---

## Regression Handling

- Regressions are auto-P1 — always urgent
- Tagged "regression" in ClickUp
- Dev who introduced it owns the fix
- After 3 regressions in same module → mandatory code review for all PRs touching that module
- P1 regressions require root cause note

---

## Test Case Management

QA creates a markdown file for each module listing every test scenario:

```
## Packing List — Test Cases
- [ ] Add personal item → appears in list
- [ ] Check off item → shows as packed
- [ ] Delete item via swipe → removed
- [ ] AI suggestions → load and can be added
- [ ] Group item → can claim quantity
...
```

These files live in the repo and are the source of truth for "what's tested." Everyone can see the current state.

---

## Tools Required

| Tool | Purpose | Access Level |
|---|---|---|
| TestFlight | Install and update iOS builds | Invited via email |
| ClickUp | Bug tracking, test status | Full access to "01 - This Week" list |
| Slack | Team communication, P1 alerts | Added to #qa channel |
| GitHub | Read PRs, see code changes | Read-only collaborator |
| iPhone 12+ | Physical device testing | QA's own device |
| iOS Screen Recording | Bug evidence | Built into iOS |

---

## Current Status (April 1, 2026)

| Metric | Count |
|---|---|
| Total bugs identified | 78 |
| Fixed (tested internally) | 35 |
| Remaining | 43 |
| Success criteria done | 72 / 166 |

---

## Hiring Plan

1. Post on Upwork (job posting ready at `hiring/qa-engineer-upwork-posting.md`)
2. Screen for: iOS testing experience, bug reporting quality, iPhone ownership, iMessage testing willingness
3. 3-day paid trial ($25/hr) — must demonstrate: clear bug reports, screen recordings, severity accuracy
4. Week 1: onboarding + learn all modules
5. Week 2: independent testing with daily standup participation
6. Week 3: evaluate adding 2nd QA tester
