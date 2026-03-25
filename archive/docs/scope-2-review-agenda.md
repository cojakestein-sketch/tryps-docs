# Scope 2 Review — Working Session
**March 17, 2026 | 12:15–2:00pm ET | Zoom**
**Attendees:** Jake, Asif, Nadim

---

## Objectives (Win Conditions for 2pm Standup)

1. **All three scopes are running through the pipeline and PRs are merged.** Link (Asif), Travel DNA (Nadim), Morning Report (Jake). *(Notifications & Voting — unassigned, was Muneeb's)*
2. **Morning reports and user feedback processes are defined.** Jake's personal morning report routine is codified. How we respond to user feedback is documented.
3. **QA team scope is clear.** What Andreas reviews nightly vs. what devs review in the dev report — defined and agreed.

---

## Agenda

### 12:15–12:35 — Scope Walkthrough (20 min)

Walk each person through their scope and how to kick it off.

| Person | Scope | Spec Location | Pipeline Status |
|--------|-------|---------------|-----------------|
| **Asif** | iMessage via Linq | `tryps-docs/scopes/p2/linq-imessage/spec.md` | Plan not started |
| **Nadim** | Travel DNA | `tryps-docs/scopes/p1/travel-dna/spec.md` | Plan not started |
| **Unassigned** | Notifications & Voting | `tryps-docs/scopes/p1/notifications-voting/spec.md` | Plan not started |
| **Jake** | Morning Report 03-17 | `tryps-docs/scopes/reports/2026-03-17/spec.md` | Kickoff prompt ready |

**For each person, demo:**
1. Open terminal in their worktree (`t4-wt/2/`, `t4-wt/3/`, etc.)
2. Copy the kickoff prompt from their scope's spec into the terminal (or run `/vision` pointing at the spec path)
3. Claude runs Steps 3-7 autonomously: Plan → Work → Review → Compound → Agent Ready (PR)
4. When the agent finishes, the PR targets `develop`

**Dev notes reminder:** After agent work completes, each dev writes their feedback in `dev-feedback.md` inside their scope directory. This is where they flag anything the agent got wrong, anything that needs manual adjustment, and any learnings.

**Pipeline reference (10 steps):**
```
spec.md → frd.md → plan.md → work.md → review.md → compound-learnings.md → agent-ready.md → dev-feedback.md → fixes-learnings.md → merged.md
```

### 12:35–1:20 — Scopes Running + Process Definitions (45 min)

Scopes are running autonomously. While they execute, define two things:

#### A. Morning Report Process (15 min)

Jake's personal morning routine:
- Open the app first thing, use it like a real user for 10-15 minutes
- Log bugs, UX issues, ideas, and follow-ups into a spec at `tryps-docs/scopes/reports/YYYY-MM-DD/spec.md`
- The spec has a kickoff prompt at the bottom — copy it into a terminal
- Claude runs the autonomous pipeline: plans fixes, implements, reviews, opens PR
- **Assigned reviewer:** One dev is responsible for reviewing the morning report PR each day (rotate or assign)

Decide:
- [ ] Who reviews the morning report PR? (Rotate daily? Fixed person?)
- [ ] What time does Jake post the spec by? (Target: before team's work hours start)
- [ ] Does the reviewer also run the scope or just review the PR?

#### B. User Feedback Process (15 min)

How we respond to feedback from real users (not Jake's morning reports, not QA):
- [ ] Where does user feedback get logged? (GitHub issues? tryps-docs?)
- [ ] Who triages severity? (Jake? Whoever sees it first?)
- [ ] What's the pipeline — does feedback become a scope spec, or goes straight to a bug fix?
- [ ] SLA: P1 same day, P2 this week, P3 backlog?

### 1:20–1:45 — QA Team Scope (25 min)

Define the boundary between dev review and QA review.

**Andreas (QA) reviews nightly:**
- Smoke test (app opens, login, tabs load)
- Regression on the device matrix (iPhone 15 Pro, iPhone 13, Pixel 8)
- Visual/UX bugs a developer wouldn't catch on simulator
- Multi-user sync testing (2-3 devices simultaneously)
- New PR features from that day's merges

**Devs review before merging:**
- Typecheck passes (`npm run typecheck`)
- Tests pass (`npm test`)
- Code review findings addressed (review.md)
- On-device spot check of their specific changes
- dev-feedback.md written

Decide:
- [ ] What does Andreas's nightly test plan look like now? (Old Ken format or new?)
- [ ] Does Andreas use the same focus-plan rotation (Mon=Auth, Tue=Create Trip, etc.) or new schedule?
- [ ] How does Andreas submit reports? (GitHub issues? tryps-docs?)
- [ ] Who generates the nightly handoff? (Jake runs it? Automated?)

### 1:45–2:00 — Merge + Verify (15 min)

- Check all four scope PRs — are they open against `develop`?
- Review and merge what's ready
- Any scope not finished: note what step it's on, who picks it up after standup
- Confirm everything is green for 2pm standup

---

## Quick Reference

**Zoom:** us05web.zoom.us/j/5559102787
**Standup:** 2:00pm ET (hard stop)
**Pipeline docs:** `tryps-docs/scopes/README.md`
**Gantt:** marty.jointryps.com/gantt
