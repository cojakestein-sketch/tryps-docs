---
title: "Jake's QA Interview — Context for Asif"
date: 2026-03-31
type: interview-output
---

# Jake's QA Interview — What We Know

> This is the output of Jake's grill-me session on QA process. Asif should read this BEFORE starting his own interview. It captures the current state, decisions made, and open questions for Asif to resolve.

---

## Current State (As of March 31, 2026)

### What Exists Today

**Automated QA (Marty runs nightly):**
- Playwright UI tests + Jest API tests against a dedicated nightly Supabase project
- 4 test personas (Alice, Bob, Charlie, Dave) on Expo Web
- Outputs to `t4/test-results/` — JSON reports, screenshots, traces
- Auto-creates GitHub Issues for new failures (label: `nightly`)
- Last ran: February 14, 2026 — **appears to have stopped running**

**Human QA Pipeline (designed for Ken, now inactive):**
- Full onboarding doc: `t4/tasks/qa/tester-onboarding.md`
- Scope of work template: `t4/tasks/qa/tester-scope-of-work.md`
- 5 focus plans (Mon-Fri): `t4/tasks/qa/focus-plans/`
- Report template: `t4/tasks/qa/report-template.md`
- Smoke test: `t4/tasks/qa/smoke-test.md`
- Feedback pipeline doc: `t4/tasks/qa/feedback-pipeline.md`
- Slash commands: `/nightly-qa-handoff`, `/morning-qa-ingest`, `/nightly-qa`

**Andreas (current QA):**
- Fills "SC Passed QA" column in standups
- No documented process for what he does, how he tests, or on what devices
- His workflow is tribal knowledge

### What's Broken

1. **Ken is gone.** Hired March 2 via Upwork ($15/hr), appears inactive since ~March 4. Pipeline designed for him has been dead for a month.
2. **Bug count mismatch.** Standup says 78+ bugs. GitHub shows only 10 open issues (3 labeled `bug`). The 78 number likely comes from Asif tracking internally — bugs are NOT in a single queryable place.
3. **Andreas has no docs.** He's doing QA but there's zero documentation of his process.
4. **Nightly automated QA stopped.** Last report: February 14. Needs to be restarted or replaced.

### What Works Well (Keep These)

- The feedback pipeline design is solid: handoff -> test -> ingest -> bug -> fix -> verify
- Focus rotation (Mon: Auth, Tue: Wizard, Wed: Invite, Thu: Expenses, Fri: Exploratory)
- Report template with severity guide (P1/P2/P3)
- Morning ingestion slash command that auto-creates bug issues
- Smoke test as gate (fail = stop, report P1)

## Decisions Jake Has Made

1. **Asif is hiring QA testers today** — he owns this
2. **The existing pipeline docs are the starting point** — don't reinvent, refine and restart
3. **Output must include:** executive one-pager + HTML flow diagram (MIT Trust Center style)
4. **QA docs live in `~/tryps-docs/QA/`** — not in t4
5. **Bug tracking must consolidate to one place** — GitHub Issues with labels

## Open Questions for Asif

These are the things Jake couldn't answer. Asif must resolve these:

1. **Where are the 78 bugs?** Are they in ClickUp subtasks? A spreadsheet? Asif's head? They need to be in GitHub Issues.
2. **What does Andreas actually do?** Document his current workflow so we can replicate/improve it.
3. **How many QA people do we need?** Given 3 devs, 13 scopes, 78+ bugs — what's the right number?
4. **Should QA be per-scope or cross-cutting?** One QA per dev vs. QA team that tests everything?
5. **What devices are required?** The Ken scope of work assumed iPhone 16 + iPhone 11 + iPhone 10. Is that still right?
6. **What does the job post look like?** Upwork? Full-time? Part-time? Rate? What to screen for?
7. **How do we prevent bug count from growing faster than fixes?** Process-level fix, not just more bodies.
8. **Should new QA testers use the automated nightly output as their starting point?** Or is the human-focused pipeline better?

## Numbers

- **Open GitHub Issues:** 10 total (3 bug, 8 user-feedback, 1 nightly)
- **P0-Critical:** 1 (iMessage trip creation doesn't auto-add creator)
- **P1-High:** 2 (trip card collapse, calendar UX)
- **Standup-reported bugs:** 78 open, 35 fixed (Asif's count as of March 30)
- **Success Criteria:** 72/166 done across all scopes
- **SC Passed QA (Andreas):** Unknown — not tracked in standup numbers
