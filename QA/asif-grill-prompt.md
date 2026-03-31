---
title: "Asif's QA Process Interview"
date: 2026-03-31
type: grill-me-prompt
---

# QA Process & Team — Asif's Interview

> **What this is:** Jake already did his half of the QA interview. His notes are at `~/tryps-docs/QA/jake-qa-interview.md`. Read that first. Now it's your turn — you fill in the execution gaps. When you're done, you produce 3 deliverables.

## Instructions

1. Read `~/tryps-docs/QA/jake-qa-interview.md` — Jake's interview output
2. Read the existing QA pipeline docs in `~/t4/tasks/qa/` — the pipeline already exists, it just needs restarting
3. Answer every question below. Claude will grill you on each one — don't skip any.
4. When all questions are answered, Claude produces your 3 deliverables.

---

## Part 1: Ground Truth (5 min)

**1. Where are the 78 bugs?**
Jake sees 10 open issues in GitHub. You reported 78. Where is the real list? ClickUp? A spreadsheet? Your memory? We need to consolidate to ONE place before we hire anyone.

**2. What does Andreas actually do today?**
He fills "SC Passed QA" in standups. But: what's his process? Does he have a checklist? Does he test on a physical device or simulator? Does he file bugs anywhere? We need to document his workflow to know what the gap is.

**3. What happened to Ken?**
He was hired March 2. Last activity was ~March 4. Did he quit? Did we fire him? Did the trial fail? What went wrong — because we're about to hire again and need to not repeat it.

## Part 2: Team Size & Structure (5 min)

**4. How many QA people do we need?**
We have 3 devs shipping code. 13 scopes. 78+ bugs. 166 success criteria. April 2 is tomorrow. What's the right number of QA testers? Jake's instinct: 2 testers minimum. What's yours?

**5. Should QA be per-scope or cross-cutting?**
Option A: Each QA person owns specific scopes (e.g., QA-1 covers Asif's scopes, QA-2 covers Nadeem's).
Option B: QA team tests everything, rotating through focus areas.
Which is better for us right now?

**6. What does the job post look like?**
- Platform: Upwork? LinkedIn? Other?
- Rate: Ken was $15/hr. Is that the right rate for quality?
- Hours: 1.5 hrs/night? Full-time? Part-time daytime?
- Devices: Do they need their own iPhones? Multiple devices?
- Skills: What do you screen for? Manual testing experience? Expo/React Native knowledge? Just "can follow a checklist"?

## Part 3: Daily Workflow (5 min)

**7. What should a QA tester's day look like?**
The Ken pipeline had: 6PM handoff -> 1.5hr test -> midnight report -> 8AM ingestion.
Is this still the right cadence? Or do we need daytime QA now?

**8. Should QA testers start from the automated nightly output?**
Marty's automated tests generate reports. Should human QA start by reading those and testing what the automation flagged? Or is the focus-plan rotation better?

**9. How does a QA tester interact with devs?**
When a QA person finds a bug — do they Slack the dev directly? Just file a GitHub issue? Add it to ClickUp? What's the communication path?

## Part 4: Bug Prevention (5 min)

**10. How do we stop bugs from growing faster than fixes?**
78 bugs and growing. More QA people will find MORE bugs, not fewer. What's the process-level fix? Options:
- Bug budget (no new features until bug count < X)?
- Bug bar (P1s block PRs, P2s block releases)?
- Bug rotation (each dev spends 1 day/week on bugs)?
- Something else?

**11. What's the definition of "done" for a bug?**
Dev says fixed -> QA verifies -> who closes the issue? Is it closed when the PR merges, when QA verifies, or when it ships to TestFlight?

**12. How do we handle regressions?**
A bug gets fixed but comes back in a later build. What's the process? P1 automatically? Blame the dev? Root cause analysis?

## Part 5: Tooling (3 min)

**13. What tools does a QA tester need access to?**
- TestFlight (obviously)
- GitHub (for issues)
- ClickUp?
- Supabase (read access for checking data)?
- Slack?
- Physical devices — which models/OS versions?

**14. Do we need a test management tool?**
Right now it's GitHub Issues + markdown files. Is that enough? Or do we need something like TestRail, Linear, etc.?

---

## Deliverables

When all questions are answered, produce exactly 3 things:

### Deliverable 1: QA One-Pager (`~/tryps-docs/QA/qa-process.md`)

An executive-level markdown doc. Max 2 pages when printed. Must cover:
- Team structure (who, how many, ownership model)
- Daily workflow (morning, day, evening)
- Bug lifecycle (found -> triaged -> fixed -> verified -> closed)
- Tooling requirements
- Hiring plan (rate, platform, screening criteria)
- Metrics to track (bug count trend, fix velocity, SC pass rate)

### Deliverable 2: QA Flow Diagram (`~/tryps-docs/QA/qa-process.html`)

A self-contained HTML file matching the Martin Trust Center deck style. Reference: `~/tryps-docs/presentations/martin-trust-center-2026-03-30.html`

**Format:**
- Single-page HTML, no external deps (except Google Fonts: Plus Jakarta Sans + Space Mono)
- Scroll-snap slides like the Trust Center deck
- CSS variables: `--red: #D9071C`, `--slate: #1A1A1A`, `--g100-g500` grays, `--green: #2D6B4F`, `--blue: #3478F6`
- 3-4 slides max:
  1. **Title:** "QA at Tryps" + team size + one-line summary
  2. **The Loop:** Visual flow diagram showing the daily cycle (Handoff -> Test -> Report -> Ingest -> Fix -> Verify)
  3. **Team & Ownership:** Who owns what, how they interact with devs
  4. **Metrics:** Bug count target, fix velocity, SC pass rate goals
- Clean, minimal, same aesthetic as the pitch deck
- Must be presentable to anyone — new hire, investor, advisor

### Deliverable 3: Slack Message to Jake

Post a message in Slack (DM to Jake) with:
- "QA process doc is done" + link/path to the one-pager
- "HTML deck is done" + link/path to the HTML file
- 3-line summary: how many QA people, what the daily workflow is, what the bug target is

---

## After Asif Completes This

Jake will:
1. Review the one-pager and HTML deck
2. Merge into tryps-docs
3. Share the HTML deck with the team
4. Use the one-pager as the onboarding doc for new QA hires
