# Slack Mission Sync

> Marty prompt. Handle a Slack `/mission` command by updating Jake's Missions in the latest standup doc.
> Canonical standup path: `~/tryps-docs/docs/standups/YYYY-MM-DD-standup.md`

## Goal

Take the mission text from Slack, find the latest standup doc, and update the `## Jake's Missions for the Team Today` section. This is mission intake, not standup Q&A.

## Inputs

- Slash command: `/mission`
- Command text: freeform mission text
- Optional metadata: Slack user, channel, timestamp

## Instructions

1. Read the command text after `/mission`
2. Find the most recent file in `~/tryps-docs/docs/standups/` unless the text names a specific date
3. Open the target standup and locate `## Jake's Missions for the Team Today`
4. If the command names a mission number, update that mission in place
5. If the text clearly matches an existing mission, rewrite that mission instead of adding a duplicate
6. Otherwise append a new `### Mission N: ...` entry as the next mission number
7. Keep the wording concise and outcome-oriented
8. Commit only the standup file and push to `main`

## Commit

```bash
cd ~/tryps-docs
git add docs/standups/YYYY-MM-DD-standup.md
git commit -m "mission: sync Slack mission to standup (YYYY-MM-DD)"
git push origin main
```

## Response Back to Slack

Reply with:

- The standup file updated
- Whether the mission was added or updated
- The final mission title

Example:

> Mission captured. Updated `docs/standups/2026-04-01-standup.md`. Added `Mission 8: Launch Beta by Friday`.
