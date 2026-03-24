# ClickUp — Source of Truth

> This is the canonical reference for how Tryps uses ClickUp.
> All sessions (Jake, Marty, any Claude instance) should @import this file.
> Last updated: 2026-03-18

## Decision (2026-03-18)

ClickUp replaces Mission Control as the source of truth for all project tracking.
Mission Control Gantt chart is discontinued. Specs still live in tryps-docs.

## Workspace

- **Workspace ID:** `9017984360`
- **CLI:** `npx clickup-cli` (v1.0.18) — reads config or env for auth
- **Jake's API Key:** Generate from ClickUp Settings > Apps > API Token. Add to `~/.zshrc` as `export CLICKUP_API_KEY=...`
- **Marty's API Key:** On Hetzner in openclaw.json (separate key, needs migration to env var)
- **Slash command:** `/clickup` — interactive task creator, `/clickup quick [title]` for brain dumps

## Lists

| Name | ID | Purpose |
|------|-----|---------|
| 01 - This Week | `901711582339` | Active sprint work |
| 02 - Backlog | `901711582341` | Specced but not yet scheduled |
| 03 - Ideas & Bugs | `901711582345` | Brain dumps, needs spec, bugs |

## Statuses (Pipeline)

`needs spec` → `to do` → `in progress` → `review` → `for testing` → `done`

Maps to tryps-docs workflow: SPEC → BUILD → VALIDATE → DONE

## Team Member IDs

| Name | ClickUp ID | Role |
|------|------------|------|
| Jake | `95314133` | Product/founder |
| Asif | `95375712` | Head of dev |
| Nadeem | `95375710` | Dev (P1 — Core App) |
| Ken | `95375711` | (Legacy ID — may need update) |
| Rizwan | `48611515` | Dev (P3 — Agent Layer) |
| Andreas | `95380391` | QA |
| Marty | `95390289` | AI Agent |
| Arslan | `102619517` | |
| Krisna | `84754219` | |

## Scope ↔ ClickUp Mapping

Each scope from tryps-docs maps to a ClickUp task. Subtasks are created by devs as they break down work.

| Scope ID | Phase | Assignee | ClickUp Status | ClickUp Task ID | Dates | Notes |
|----------|-------|----------|---------------|-----------------|-------|-------|
| p1-post-trip-review | P1 | Nadeem | for testing | `86e0emu4g` | Mar 25 → Apr 2 | 39 criteria |
| p1-travel-dna | P1 | Nadeem | in progress | `86e0emu52` | Mar 24 → Mar 31 | 25 criteria |
| p1-claude-connector | P1 | Nadeem | needs spec | `86e0emu56` | Mar 22 → Apr 5 | 36 criteria |
| p1-notifications-voting | P1 | Nadeem | needs spec | `86e0emu5q` | Mar 22 → Mar 30 | 41 criteria |
| p1-core-flows | P1 | Nadeem | — | — | Mar 9 → Mar 22 | No scope ticket — existing feature tickets cover this |
| p1-recommendations | P1 | Nadeem | needs spec | `86e05v28h` | Mar 28 → Apr 5 | (was "Friend-Based Activity Recs") |
| p1-tooltips-teaching | P1 | Nadeem | needs spec | `86e0emu6c` | Mar 22 → Mar 28 | |
| p2-stripe-payments | P2 | Asif | to do | `86e0emu70` | Mar 25 → Apr 8 | 12 criteria |
| p2-linq-imessage | P2 | Asif | needs spec | `86e0emu7g` | Mar 22 → Apr 5 | 41 criteria |
| p2-connectors | P2 | Asif | needs spec | `86e0emu86` | Apr 1 → Apr 12 | 25 criteria |
| p3-vote-on-behalf | P3 | Rizwan | needs spec | `86e0ajhte` | Apr 5 → Apr 15 | (was "Agent Proxy Voting") |
| p3-pay-on-behalf | P3 | Rizwan | needs spec | `86e0emu8e` | Apr 8 → Apr 18 | |
| p3-duffel-apis | P3 | Rizwan | needs spec | `86e06y10g` | Apr 10 → Apr 20 | (was "Group Flight Search") |
| p3-logistics-agent | P3 | Rizwan | needs spec | `86e0emu8z` | Apr 12 → Apr 22 | 26 criteria |
| ~~p4-brand-strategy~~ | — | — | REMOVED | — | — | Moved to `brand-and-gtm/` (2026-03-24) |
| ~~p4-wispr-playbook~~ | — | — | REMOVED | — | — | Moved to `brand-and-gtm/` (2026-03-24) |
| ~~p4-launch-video~~ | — | — | REMOVED | — | — | Moved to `brand-and-gtm/` (2026-03-24) |
| ~~p4-referral-incentives~~ | — | — | REMOVED | — | — | Moved to `brand-and-gtm/` (2026-03-24) |
| ~~p4-giveaways~~ | — | — | REMOVED | — | — | Moved to `brand-and-gtm/` (2026-03-24) |
| p5-friends-family | P5 | unassigned | needs spec | `86e0emube` | May 10 → May 22 | |
| p5-strangers-review | P5 | unassigned | needs spec | `86e0emubu` | May 15 → May 30 | |

**Removed:** `p2-booking-links` — killed per team meeting 2026-03-18.
**Removed:** All P4 brand/GTM tasks — moved to `brand-and-gtm/` folder (2026-03-24). Brand work is tracked in tryps-docs, not ClickUp.

## CLI Usage

```bash
# Create a task
npx clickup-cli create "Task Name" \
  -l 901711582339 \
  -s "needs spec" \
  -a 95375710 \
  -d "Description here"

# Update a task
npx clickup-cli update TASK_ID -s "in progress"

# Add a checklist item
npx clickup-cli check TASK_ID "Criterion text"

# Add a comment
npx clickup-cli comment TASK_ID "Update message"
```

## Dashboard Views (To Set Up in ClickUp)

1. **Gantt/Timeline** — All scopes by phase, colored by assignee, April 2 deadline
2. **Board by Assignee** — Kanban per team member showing their pipeline
3. **Table with Criteria** — Success criteria count + progress per scope

## Integration Points

- **Specs:** Each ClickUp task should link to its `tryps-docs/scopes/{phase}/{scope}/spec.md`
- **PRs:** GitHub PRs reference ClickUp task IDs in commit messages
- **Marty:** Uses ClickUp API to read/update task status, post comments
- **QA (Andreas):** Moves tasks to `for testing` → validates criteria → `done` or back to `in progress`

## Hard Deadline

**Everything on this board must be DONE by April 2, 2026.**

## Workflow

1. Jake creates scope ticket in ClickUp with status `needs spec` (due date = spec deadline this week)
2. Jake runs `/spec` to generate spec.md in tryps-docs
3. Ticket moves to `to do` once spec is written — **due date resets to April 2** — reassigned to dev
4. Dev picks up, moves to `in progress`
5. Dev ships PR, moves to `review`
6. PR merged, moves to `for testing`
7. Andreas validates criteria → `done` or back to `in progress` with failing notes
