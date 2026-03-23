---
name: spec-and-build
description: "End-to-end feature pipeline: spec → review → build → PR → CodeRabbit → submit"
user-invocable: true
---

# Spec-and-Build — Marty Supreme Workflow

End-to-end autonomous feature pipeline. Jake describes a feature → Marty delivers a reviewed PR.

## Input Parsing

Jake says something like:
- `"Add sunset notifications for trip locations"`
- `"spec-and-build Add sunset notifications, I'll review, ask the agents"`
- `"Build expense splitting by percentage. Asif reviews. Interview me. Put in This Week."`

Parse:
- **feature** — the feature description (required)
- **review_gate** — who reviews the spec: `jake`, `asif`, or `auto` (if unspecified → ask)
- **interview_mode** — who answers spec questions: `agents`, `jake`, `asif`, `nadeem` (if unspecified → ask)
- **urgency** — `this-week` (list 901711582339) or `backlog` (list 901711582341). Default: `this-week`
- **constraints** — any additional requirements Jake mentioned

If review gate is not specified, ask:
> "Who should review the spec? You, Asif, or should I just proceed?"

If interview mode is not specified, ask:
> "Who should answer the spec questions? You, a dev (Asif/Nadeem), or should I consult my SME agents?"

You can ask both in a single message if both are unspecified.

## Step 1 — Generate Spec

Run the `/spec-interview` skill with:
- The feature description
- The interview mode (agents/jake/asif/nadeem)

This produces a structured spec with: Intent, Summary, User Story, Success Criteria (with "Verified by:" patterns), Screens Affected, Data Model Changes, Edge Cases, Out of Scope, Dev Notes, QA Notes, Acceptance Tests.

## Step 2 — Create ClickUp Ticket

Create a task in the appropriate list:

```
Tool: clickup_create_task
List: <urgency list ID>
Title: [Feature] <short feature name>
Description: <full structured spec from Step 1>
Status: "needs spec"
Assignee: Asif (95375712)
```

Save the returned `task_id` for later status updates.

## Step 3 — Review Gate

### If `jake`:
1. DM Jake in Slack with spec summary + ClickUp task link
2. Message: "Spec ready for review: [ClickUp link]\n\n**Summary:** [1-2 lines]\n**Complexity:** [S/M/L/XL]\n\nReply 'approved' to proceed, or send feedback."
3. Wait for Jake's response in the thread
4. If feedback → revise spec, update ClickUp, re-send for review
5. If approved → continue

### If `asif`:
1. Update ClickUp task: assign to Asif, add comment "Spec ready for review"
2. Message #dev in Slack: "Spec for review by @Asif: [ClickUp link] — [feature summary]"
3. Wait for ClickUp status change from "needs spec" to "to do"
4. Poll every 15 minutes (max 24 hours), then remind in Slack

### If `auto`:
1. Run the `tryps-spec-review` skill on the generated spec
2. If verdict is "Ready" → proceed
3. If "Needs work" → self-fix based on review feedback, re-review (max 2 iterations)
4. Update ClickUp status to "to do"
5. Continue

## Step 4 — Build

Update ClickUp status to "in progress".

### 4a — Set up workspace
```bash
cd ~/.openclaw/workspace-marty/tryps
git fetch origin main
git checkout -b marty/feat-<short-name> origin/main
npm install
```

### 4b — Implement
Spawn a coding agent in the Tryps repo with the spec:

```bash
bash pty:true workdir:~/.openclaw/workspace-marty/tryps background:true command:"claude 'Implement this feature spec:

<paste full spec here>

Rules:
- Use @/ path aliases, never relative imports
- No any types
- StyleSheet.create() for all styles
- Run npm run typecheck before committing
- Run npm test for affected areas
- Follow conventions in docs/conventions.md
- Create small, focused commits

When done, run: openclaw system event --text \"Done: <feature-name> implementation complete\" --mode now'"
```

Monitor progress via `process action:log`. If agent gets stuck or errors, intervene or restart.

### 4c — Verify
After agent completes:
```bash
cd ~/.openclaw/workspace-marty/tryps
npm run typecheck
npm test
```

If failures, fix them (directly or via another coding agent pass).

## Step 5 — Open Draft PR

```bash
cd ~/.openclaw/workspace-marty/tryps
git push -u origin marty/feat-<short-name>
gh pr create \
  --repo cojakestein-sketch/tripful \
  --title "[Marty] <feature title>" \
  --body "## Summary
<spec summary>

## ClickUp Task
<clickup link>

## Changes
<list of key changes>

## Test Plan
<acceptance tests from spec>

---
🤖 Built by Marty (autonomous spec-and-build pipeline)" \
  --draft
```

Save the PR number.

## Step 6 — CodeRabbit Review Cycle

Wait 2-3 minutes for CodeRabbit to review the draft PR.

Run the `/coderabbit-fix` skill with the PR number. Max 3 iterations.

If CodeRabbit passes (no critical/major issues) → continue.
If CodeRabbit still failing after 3 iterations → escalate to Jake.

## Step 7 — Submit for Human Review

```bash
# Mark PR ready (not draft)
gh pr ready <pr_number> --repo cojakestein-sketch/tripful

# Assign Asif as reviewer
gh pr edit <pr_number> --repo cojakestein-sketch/tripful --add-reviewer asifraza1013
```

Update ClickUp:
```
Tool: clickup_update_task
Task: <task_id>
Status: "review"
Comment: "PR ready for review: <pr_link>"
```

Notify in Slack:
- #dev: "PR ready for review: [PR link] — [feature summary]. Assigned to @Asif."
- DM Jake: "Feature shipped to PR: [PR link]. Asif reviewing. ClickUp: [task link]"

## Failure Handling

| Scenario | Action |
|---|---|
| Coding agent fails mid-build | Retry once with fresh agent. If still fails, DM Jake with error log. |
| Typecheck/tests fail after build | Spawn fix agent with error output. Max 2 fix attempts. |
| CodeRabbit loop (3+ iterations) | Post remaining issues as PR comment, DM Jake. |
| Jake never responds to review gate | Remind in Slack after 4 hours, then again at 24 hours. |
| ClickUp API fails | Log error, continue without ClickUp updates, notify Jake. |
| Branch conflict with main | Rebase: `git fetch origin main && git rebase origin/main`. If conflicts, DM Jake. |

## Progress Updates

Send Slack updates at these milestones:
1. **Spec generated** — DM Jake with summary
2. **Build started** — Post in thread
3. **Build complete** — Post in thread with commit summary
4. **PR opened** — Post PR link
5. **CodeRabbit passed** — Post in thread
6. **Submitted for review** — Final notification with all links

Keep updates in a SINGLE Slack thread per feature (reply to the first message).

## Rules

- Always prefix PR titles with `[Marty]`
- Never force-push or merge PRs — that's Asif's job
- Never skip typecheck or tests
- Never modify the invite flow without explicit Jake approval
- Keep feature branches small — one feature per branch
- Clean up branches after PR is merged (Asif handles merge)
