# Slack Mission Sync

> Marty prompt. Handle a Slack `/mission` command by updating Jake's Missions in the latest standup doc.
> Canonical standup path: `~/tryps-docs/docs/standups/YYYY-MM-DD-standup.md`

## Goal

Take the mission text from Slack and update the **canonical missions file** at `~/tryps-docs/shared/missions.md`. Standups REFERENCE this file — never store missions inside standup docs.

## Inputs

- Slash command: `/mission`
- Command text: freeform mission text
- Optional metadata: Slack user, channel, timestamp

## Instructions

1. Read the command text after `/mission`
2. Open `~/tryps-docs/shared/missions.md`
3. If the text clearly matches an existing mission, update that mission in place
4. Otherwise append a new `### Mission N: ...` entry under `## Active Missions` as the next number
5. Keep the wording concise and outcome-oriented
6. Update the `Last updated:` date in the frontmatter
7. Commit and push

## Important: Standup Generation

When generating standups, **read missions from `shared/missions.md`** — do NOT rewrite or invent new missions. The standup `## Jake's Missions` section should reference the canonical list, not replace it. Ops-level items (PR backlog, bug burndown) go under `## Ops Missions` separately.

## Commit

```bash
cd ~/tryps-docs
git add shared/missions.md
git commit -m "mission: [added|updated] Mission N — [title]"
git push origin main
```

## Response Back to Slack

Reply with:

- Whether the mission was added or updated
- The final mission title and number
- Current active mission count

Example:

> Mission captured. Added `Mission 8: Founder Presence Optimization` to shared/missions.md. 10 active missions.
