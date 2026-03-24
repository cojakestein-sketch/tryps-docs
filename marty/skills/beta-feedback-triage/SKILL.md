---
name: beta-feedback-triage
description: Read all open tasks and incoming feedback, find unassigned/stuck/duplicate items, and surface what needs attention
user-invocable: true
---

# Beta Feedback Triage

Read every open task in ClickUp. Understand what each one is by reading the full details — not titles or tags. Find unassigned tasks, stuck items, potential duplicates, and surface what needs a human decision. No categories imposed — we read what's actually there.

## Why This Exists

Our ClickUp has no standardized categorization. Tasks are named inconsistently ("Bug: ...", "P1: ...", "Sub-ticket 1: ..."). Some have tags, most don't. Some have assignees, some don't. The only way to know what a task is about is to read it. Marty's job: read everything, make sense of it, and tell the team what needs attention.

## How Our ClickUp Actually Works

- **Andreas (QA)** is the primary bug reporter. He uses a consistent format: Source → Steps to Reproduce → Bug (Actual/Expected) → Device/Build → Evidence → Acceptance Criteria → Technical Notes.
- **Tags are inconsistent** — `qa-feedback`, `auth-bugs`, `figma-design` exist but aren't used on every task.
- **Priorities are inconsistent** — some tasks use ClickUp priority (urgent/high/normal/low), some put P0/P1/P2 in the title, some have neither.
- **Parent/subtask structure** — bug epics (e.g., "Bug: Trip Creation Flow") contain subtasks for individual bugs. Marty must understand this hierarchy to avoid double-counting.
- **Naming is mixed** — "Bug: ...", "P1: ...", "Sub-ticket 1: ...", plain descriptions. Can't rely on title prefixes.

## Feedback Sources

| Source | How to Read |
|--------|------------|
| ClickUp "01 - This Week" (901711582339) | Filter tasks via API — main active board |
| ClickUp "02 - Backlog" (901711582341) | Filter tasks via API — parked/future work |
| ClickUp "03 - Ideas & Bugs" (901711582345) | Filter tasks via API — currently empty |
| Slack #bugs / #user-feedback | Read channel history via Slack API |
| Gmail (jake@ / marty@) | `gog gmail list` + `gog gmail read` — TestFlight feedback emails |

## Steps

### 1. Pull All Open Tasks

```bash
# Get tasks from all three lists
curl -s -H "Authorization: $CLICKUP_API_KEY" \
  "https://api.clickup.com/api/v2/list/901711582339/task?include_closed=false"

curl -s -H "Authorization: $CLICKUP_API_KEY" \
  "https://api.clickup.com/api/v2/list/901711582345/task?include_closed=false"
```

### 2. Read Each Task — Understand What It Actually Is

For every task, pull the full details (title, description, comments, status, assignee, tags, subtasks, parent). Then determine:

- **What is this about?** Read the description, not just the title. "Bug: Trip Creation Flow" is actually a parent ticket with 5 child bugs.
- **Who owns it?** If no assignee, flag it.
- **What's the real status?** ClickUp says "to do" but the description might reference an old build — it could be already fixed. Note the build number.
- **Is it stale?** Same status for 3+ days with no updates = stale.
- **Is it a parent or subtask?** Check `parent` field. Don't double-count subtasks that also appear under their parent.

### 3. Find Potential Duplicates

When comparing tasks, read the full details and match by **screen + flow + behavior**, not keywords:

- Two tasks about the same screen with similar symptoms = potential duplicate, even if worded differently
- Example: "App crashes when verifying phone number" (crash on second OTP attempt) vs. "Failing to send OTP for valid phone numbers" (OTP doesn't send at all) — same screen, different symptoms. Flag as "possibly related, needs investigation" not "duplicate."
- Check build numbers — a bug on Build #65 might already be fixed in Build #99.

**If confirmed duplicate:** Add a comment to the existing task noting the overlap. Don't create a new task.
**If possibly related:** Flag both in the triage report and let a dev investigate.

### 4. Surface What Needs Attention

Present a report with three sections:

**Section A: Unassigned tasks that need an owner**
```
7 tasks have no assignee:

URGENT:
- "Bug: App crashes when verifying phone number" (86e08gbzq)
  to do, urgent, created by Andreas, Build #78
  Crash on second OTP attempt with Indonesian number.
  → Auth flow crash. Suggest: assign to Asif or Nadeem.

- "Bug: Trip Creation Flow" (86e0e5qj2) — PARENT with 5 subtasks
  All 5 subtasks also unassigned:
  • Dark mode not applied during trip creation
  • New trip creation design not appearing (Build #99)
  • Newly created trip not showing up
  • Calendar view doesn't match Figma
  • No popup on calendar date tap
  → Trip creation bugs. Suggest: assign parent to Nadeem (owns trip creation UI).

HIGH:
- "P1: Failing to send OTP" (86e0630ta)
  needs spec, urgent, Build #65, no due date
  → Old build. Might be fixed already. Someone should verify on latest build.
```

**Section B: Potential duplicates or related bugs**
```
Possibly related — same flow, different symptoms:

• 86e08gbzq "crashes when verifying phone" (Build #78, crash on 2nd attempt)
• 86e0630ta "failing to send OTP" (Build #65, OTP never sends)
  Both on phone → OTP flow. Different builds, different symptoms.
  → Needs dev to check if same root cause.
```

**Section C: Stale tasks (no activity for 3+ days)**
```
3 tasks stuck with no updates:

- "P1: Failing to send OTP" — created 2+ weeks ago, status "needs spec", no assignee, no due date
- "Bug: Unable to delete account" — parked, no assignee
- "Bug: Cannot save Home City" — parked, no assignee
```

### 5. Weekly Digest (Monday 9 AM ET)

Post to #martydev:

```
Feedback Digest — Week of [date]

Open tasks with no assignee: X
Tasks stuck 3+ days with no updates: X
Potential duplicates flagged: X

Top unresolved:
1. [Title] — [why it matters] — [days open] — [suggested owner]
2. [Title] — [why it matters] — [days open] — [suggested owner]

New feedback this week from Slack/Gmail: X items
```

## What Marty Does Autonomously vs. Human-Gated

| Action | Autonomous? | Why |
|--------|------------|-----|
| Read all tasks and feedback sources | Yes | Read-only |
| Identify unassigned/stuck/duplicate tasks | Yes | Analysis only |
| Add comment to existing task (duplicate context) | Yes | Low risk, adds info |
| Create new ClickUp tasks | **No — staged for review** | Jake or dev reviews first |
| Assign tasks to devs | **No — suggest only** | Jake decides routing |
| Close tasks as duplicate | **No — flag only** | Human confirms |
| Weekly digest post to #martydev | Yes | Informational |
| DM Jake for urgent unassigned crashes | Yes | Time-sensitive |

## Cron Schedule

| Job | Schedule | What It Does |
|-----|----------|-------------|
| `feedback-scan` | Daily, 9:00 AM ET | Read all sources, surface what needs attention |
| `feedback-digest` | Monday, 9:00 AM ET | Weekly summary to #martydev |
