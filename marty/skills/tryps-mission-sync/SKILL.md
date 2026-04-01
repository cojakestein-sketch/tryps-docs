---
name: tryps-mission-sync
description: Capture a Slack `/mission` command, update Jake's Missions in the latest standup doc, and commit the change
user-invocable: true
---

# Slack Mission Sync

Use this when a Slack `/mission` command is routed into Marty / OpenClaw. The goal is simple: take the mission text from Slack, update the latest standup in `tryps-docs/docs/standups/`, and keep Jake's Missions current without manual doc editing.

## Inputs

Expected input from Slack:

- Command: `/mission`
- Text: the mission body after the slash command
- Optional metadata: channel name/ID, Slack user ID, display name, timestamp

Examples:

- `/mission Launch beta by Friday`
- `/mission Rizwan: close agent-intelligence remaining 6 SCs`
- `/mission Mission 3 should now focus on all travel booking, not flights only`

## Core Rules

- Canonical standup path is `tryps-docs/docs/standups/`
- Ignore legacy `tryps-docs/standups/` paths unless explicitly told otherwise
- Update the most recent standup doc by date unless the Slack payload names a specific date
- Modify only the `## Jake's Missions for the Team Today` section unless the command explicitly asks for another section
- Prefer updating an existing matching mission over creating a duplicate
- Keep mission wording direct and outcome-oriented
- Preserve surrounding formatting and mission numbering

## Workflow

### 1. Parse the Slack command

Extract:

- The raw mission text
- Whether the text implies a new mission, a rewrite, or a status/update to an existing mission
- Any explicit owner names, dates, or mission numbers

If the command text is empty, stop and report that no mission text was provided.

### 2. Find the target standup doc

Default behavior:

1. Look in `tryps-docs/docs/standups/`
2. Select the most recent `YYYY-MM-DD-standup.md`
3. Use that file as the target

If the Slack text references a date like `for April 3` or `for 2026-04-03`, target that standup instead.

### 3. Read the existing missions

Open the target standup and locate:

- `## Jake's Missions for the Team Today`

Parse all `### Mission N: ...` headings and their description text.

### 4. Decide how to update

Use this decision order:

1. If the command references a mission number like `Mission 2`, update that mission directly.
2. If the text clearly matches an existing mission topic, rewrite that mission title/description in place.
3. Otherwise append a new mission as the next sequential `Mission N`.

Matching heuristics:

- Shared key nouns and verbs
- Same owner or same core outcome
- Explicit language like `update`, `replace`, `rewrite`, `make mission`

Avoid duplicate missions that say the same thing in slightly different words.

### 5. Write the mission cleanly

Format:

```markdown
### Mission N: [Short title]
[1-2 sentence description of the outcome Jake wants]
```

Writing rules:

- Title should be short and concrete
- Description should clarify the expected result, not just repeat the title
- Keep owner names in parentheses only if they materially matter
- Do not add filler or corporate language

### 6. Commit the update

```bash
cd ~/tryps-docs
git add docs/standups/YYYY-MM-DD-standup.md
git commit -m "mission: sync Slack mission to standup (YYYY-MM-DD)"
git push origin main
```

If there are unrelated local changes, stage only the standup file.

### 7. Report back to Slack

Return a short confirmation:

- Which standup file was updated
- Whether a mission was added or updated
- The final mission title

Example:

> Mission captured. Updated `docs/standups/2026-04-01-standup.md` and added `Mission 8: Launch Beta by Friday`.

## Editing Guidance

### New mission

If the command is a fresh mission like:

`/mission Launch beta by Friday`

append:

```markdown
### Mission N: Launch Beta by Friday
Everything needed for beta needs to converge on a Friday launch. Make blockers explicit, assign owners, and treat this as an execution mission rather than an open-ended theme.
```

### Existing mission rewrite

If the command is:

`/mission Mission 3 is booking all travel, not just flights`

rewrite the existing Mission 3 heading/description in place. Do not append a duplicate.

### Owner-specific mission

If the command is:

`/mission Rizwan: close the remaining 6 agent-intelligence SCs`

prefer a mission title like:

`### Mission N: Close Remaining Agent-Intelligence SCs (Rizwan)`

## Safety

- Do not edit answered dev sections unless the command explicitly asks for that
- Do not rewrite the whole standup
- Do not touch older standups unless a date is explicitly supplied
- If mission intent is ambiguous, make the smallest reasonable change and preserve the original wording where possible

## Relationship to Other Skills

- `tryps-standup` creates the daily standup skeleton and baseline missions
- `tryps-mission-sync` updates missions during the day from Slack
- `nightly-report` reads the updated mission list to evaluate what moved
