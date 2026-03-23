---
name: tryps-bug-triage
description: Triage bugs reported in Slack, categorize severity, check for duplicates, create ClickUp tasks
user-invocable: true
---

When a team member reports a bug (in #bugs channel or DM):

1. **Acknowledge** — React with 👀 to show you're on it.

2. **Categorize Severity:**
   - **P0 (Critical):** App crash, data loss, auth failure, invite flow broken. Assign to Jake immediately.
   - **P1 (Major):** Feature broken but workaround exists, significant UX regression. Assign to Asif.
   - **P2 (Minor):** Cosmetic issue, non-blocking UX issue, edge case. Leave unassigned.

3. **Check for Duplicates:**
   - Search ClickUp "03 - Ideas & Bugs" (list 901711582345) for similar reports
   - Search recent GitHub issues for related PRs
   - If duplicate found, link to existing task and note it

4. **Create ClickUp Task:**
   - List: "03 - Ideas & Bugs" (901711582345)
   - Title: Clear, descriptive (e.g., "Bug: Trip card crashes with 20+ activities on Android")
   - Description includes:
     - Reporter (who reported it)
     - Severity (P0/P1/P2)
     - Steps to reproduce (from the report)
     - Expected vs actual behavior
     - Device/platform if mentioned
     - Screenshot/video if provided
   - Tags: Add severity tag (p0, p1, p2)
   - Assignee: Jake for P0, Asif for P1, unassigned for P2

5. **Respond in Slack:**
   - Confirm with ClickUp task link
   - Format: "Triaged as **P[X]** — [ClickUp link]. [Brief next step]"
   - For P0: Also DM Jake directly

6. **For P0 bugs:** Check if the issue is related to any recent PR merges (last 48 hours).
