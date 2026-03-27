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

## Post-Standup State Sync (after standup commits land, ~3:00 PM ET)

1. Detect new commits to `standups/` since last check
2. Read the standup doc and extract from each dev's answers:
   - SC counts (e.g., "34 out of 57 are done" → `criteria: 34/57`)
   - Status changes (e.g., "started implementation" → `status: in-progress`)
   - New blockers mentioned
   - PRs merged (cross-reference with GitHub)
3. Update the corresponding `scopes/{scope}/state.md` frontmatter fields:
   - `criteria` — update done/total count
   - `status` — update if changed
   - `blockers` — add/remove based on answers
   - `last_updated` — set to today
   - `updated_by` — set to `marty`
4. Regenerate `shared/state.md` by reading all 12 scope state.md frontmatter values
5. Commit and push with message: `chore: sync state from standup answers (YYYY-MM-DD)`

**Manual fallback:** Until this automation is running, any session can run:
> Read the latest standup. Extract SC counts, status changes, and blockers from each dev's answers. Update the corresponding scopes/*/state.md frontmatter. Regenerate shared/state.md by aggregating all 12 scope state.md files. Commit and push.

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
