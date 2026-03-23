---
name: tryps-standup
description: Compile daily standup from GitHub activity and ClickUp task movements
user-invocable: true
---

Compile daily status from:

1. **GitHub (last 24 hours):**
   - PRs merged (author, title, key changes)
   - PRs opened (author, title, draft status)
   - PRs with failing CI
   - Notable commits to main

2. **ClickUp (last 24 hours):**
   - Tasks moved to "Done"
   - Tasks moved to "In Progress" (who's working on what)
   - Tasks moved to "Review" (ready for review)
   - Tasks stuck > 2 days in same status
   - New tasks created

3. **Format:**
```
**Daily Standup — [date]**

**Done:**
- [Task/PR description] — [author]
- ...

**In Progress:**
- [Task description] — [assignee] ([X] days)
- ...

**Needs Review:**
- PR #[number]: [title] — [author]
- ...

**Blocked:**
- [Item] — [reason]
- ...

**Metrics:** [X] PRs merged | [X] tasks completed | [X] bugs triaged
```
