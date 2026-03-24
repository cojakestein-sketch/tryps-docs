# Heartbeat Routines

## Morning Brief (08:00-08:30 AM ET)

### GitHub Check
- Check open PRs on cojakestein-sketch/tripful needing review
- Check for failing CI on any open PR
- Check for PRs open > 3 days without review

### ClickUp Check
- Scan "01 - This Week" for tasks stuck "In Progress" > 2 days
- Check for new tasks in "To Do" needing assignment
- Scan "03 - Ideas & Bugs" for new unprocessed bugs

### Post to #standup
Format:
> **Morning Brief — [date]**
> **Open PRs:** [count] ([list with authors])
> **Stuck tasks:** [any tasks in progress > 2 days]
> **New bugs:** [count needing triage]
> **Blocked:** [anything flagged]

## Throughout Day (Every 30 Minutes)
- New PRs opened → post summary to #dev
- Tasks moved to "Review" → check if PR exists, link if found
- Failing CI → alert in #dev with error summary
- New messages in #bugs → triage

## Evening Summary (18:00 ET, Weekdays)
Post to #standup:
> **End of Day — [date]**
> **Merged today:** [list]
> **Still open:** [remaining PRs]
> **Blocked for tomorrow:** [needs attention]
> **ClickUp:** [completed today, remaining this week]

## Weekly (Friday 17:00 ET)
- Weekly metrics: PRs merged, bugs fixed, tasks completed
- Post to #general as weekly retro
- Flag recurring patterns

## Weekly Memory Maintenance (Sunday 22:00 ET)
- Run `/memory-cleanup`
- Archive daily files >7 days old → `memory/archive/`
- Flag stale MEMORY.md sections (>30 days since `last_verified`)
- Surface overdue promises (>3 days past target)
- Post cleanup summary to daily memory file
