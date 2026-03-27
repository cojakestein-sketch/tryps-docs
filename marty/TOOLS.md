# Marty's Tools — Operator Manual

> This is the complete reference for every tool Marty has access to.
> Each section: what you can do, how to do it, gotchas where things fail.
> Last updated: 2026-03-23

## Exec Permissions

You have FULL exec permissions. Configured 2026-03-10.
- `tools.exec.security: "full"` in openclaw.json
- Run any command, create cron jobs, execute scripts without asking
- DO NOT request exec permissions from Jake — you already have them

---

## GitHub (gh CLI)

### What you can do
- Read/review PRs, list issues, check CI status
- Merge PRs (with Jake or Asif's approval)
- Read files, browse code, check commit history
- Create issues, comment on PRs

### How to do it
```bash
# List open PRs
gh pr list --repo cojakestein-sketch/tripful --state open

# View a specific PR
gh pr view 123 --repo cojakestein-sketch/tripful

# Check PR CI status
gh pr checks 123 --repo cojakestein-sketch/tripful

# Read a file from the repo
gh api repos/cojakestein-sketch/tripful/contents/path/to/file -q .content | base64 -d

# Recent commits on develop
gh api repos/cojakestein-sketch/tripful/commits?sha=develop --jq '.[0:10] | .[] | .commit.message'

# Merge a PR (only after approval)
gh pr merge 123 --repo cojakestein-sketch/tripful --squash
```

### Gotchas
- Default branch is `develop` in tripful (t4), `main` in tryps-docs
- NEVER force-push to any branch
- ALWAYS check CI status before merging
- Marty's GitHub account is `marty-source` (collaborator with push access)
- The repo is called `tripful` on GitHub but the app is called **Tryps** (not Tripful)
- When reading files, remember to base64 decode the content

---

## ClickUp (API via curl)

### What you can do
- Read tasks, update status, add comments, create tasks
- Read checklists and subtasks
- Track sprint progress

### How to do it
```bash
# Read a task
curl -s -H "Authorization: $CLICKUP_API_KEY" \
  "https://api.clickup.com/api/v2/task/TASK_ID"

# List tasks in a list
curl -s -H "Authorization: $CLICKUP_API_KEY" \
  "https://api.clickup.com/api/v2/list/901711582339/task?include_closed=true"

# Update task status
curl -s -X PUT -H "Authorization: $CLICKUP_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"status": "in progress"}' \
  "https://api.clickup.com/api/v2/task/TASK_ID"

# Add a comment
curl -s -X POST -H "Authorization: $CLICKUP_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"comment_text": "Your comment here"}' \
  "https://api.clickup.com/api/v2/task/TASK_ID/comment"

# Create a task
curl -s -X POST -H "Authorization: $CLICKUP_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"name": "Task name", "status": "needs spec", "assignees": [95375710]}' \
  "https://api.clickup.com/api/v2/list/901711582339/task"
```

### Key IDs
| Entity | ID |
|--------|-----|
| Workspace | `9017984360` |
| Space | `90174516230` |
| Folder "Tryps App" | `90177160411` |
| List "01 - This Week" | `901711582339` |
| List "02 - Backlog" | `901711582341` |
| List "03 - Ideas & Bugs" | `901711582345` |
| Jake | `95314133` |
| Asif | `95375712` |
| Nadeem | `95375710` |
| Rizwan | `48611515` |
| Andreas | `95380391` |
| Marty | `95390289` |

### Gotchas
- The `npx clickup-cli` is WRITE-ONLY — always use curl for reads
- Token lives in `$CLICKUP_API_KEY` env var (loaded from secrets.env)
- Token can expire — if you get OAUTH_025 "Token invalid", tell Jake to rotate it
- Date format is Unix milliseconds (not seconds)
- Statuses are lowercase: `needs spec`, `to do`, `in progress`, `review`, `for testing`, `done`

---

## Google Calendar + Gmail (gog CLI)

### What you can do
- Read Jake's calendar, create events, add Zoom links
- Create email drafts in Jake's Gmail, read emails
- Read contacts

### How to do it
```bash
# List upcoming events
gog cal list

# Create an event with Zoom link
gog cal create "Meeting title" --start "2026-03-25 14:00" --duration 30m

# Create a Gmail draft
gog gmail draft --to "someone@email.com" --subject "Subject" --body "Body text"

# Read recent emails
gog gmail list
```

### Gotchas
- Credentials are at `~/.openclaw/workspace-marty/.google_tokens.json`
- Jake's calendar: `jake@jointryps.com`
- Marty's email: `marty@jointryps.com`
- **Calendar permissions:** marty@jointryps.com has "Make changes to events" access on Jake's calendar. Create events directly on `jake@jointryps.com` — do NOT create from marty@jointryps.com and send invites.
- ALWAYS add Zoom links to meetings
- Zoom settings: NO passcode, NO waiting room — people join directly
- If OAuth tokens expire, you'll get an auth error — tell Jake to re-authorize

---

## Zoom (API)

### What you can do
- Create meetings, get meeting details, list recordings

### How to do it
```bash
# Get OAuth token first
TOKEN=$(curl -s -X POST "https://zoom.us/oauth/token" \
  -H "Authorization: Basic $(echo -n "$ZOOM_CLIENT_ID:$ZOOM_CLIENT_SECRET" | base64)" \
  -d "grant_type=account_credentials&account_id=$ZOOM_ACCOUNT_ID" | jq -r '.access_token')

# Create a meeting
curl -s -X POST "https://api.zoom.us/v2/users/me/meetings" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"topic": "Meeting Name", "type": 2, "start_time": "2026-03-25T14:00:00", "duration": 30, "settings": {"waiting_room": false, "passcode_required": false}}'
```

### Gotchas
- Credentials in `~/.openclaw/workspace-marty/zoom-credentials.json`
- Server-to-Server OAuth app "Marty" (all scopes)
- Standup meeting ID: `5559102787`
- NEVER set a passcode or waiting room — Jake hates friction
- OAuth tokens are short-lived — get a fresh one each time

---

## Slack (Socket Mode)

### What you can do
- Post messages to channels, DM users
- React to messages with emoji
- Read channel history

### Channels
| Channel | ID | Access |
|---------|-----|--------|
| #all-tryps | — | @mention required |
| #daily-updates | — | @mention required |
| #martydev | `C0AKS98Q5K5` | @mention required |
| #martyasif | — | @mention required |
| #martydesign | — | @mention required |

### Key Users
| User | Slack ID |
|------|----------|
| Jake | `U0AK8FANGNM` |

### Gotchas
- DM allowlist: ONLY Jake can DM Marty directly
- All channels require @mention — Marty doesn't auto-respond to every message
- Ack reaction is 👀 (eyes emoji)
- When posting PR review requests: post in #martydev (NOT DM), always include the spec link
- NEVER use the word "crew" in any message — Jake hates it
- No emojis or slang in agent/system copy — looks tacky

---

## Supabase (MCP Server)

### What you can do
- Query the Tryps database
- Read schema, tables, functions

### How to do it
- MCP server configured in `.mcp.json`: `https://mcp.supabase.com/mcp`
- Available as a tool in Claude sessions

### Gotchas
- Read-only in most contexts — don't modify production data without explicit permission
- The database has RLS policies — some queries may return empty if not authenticated properly

---

## Brave Search (Web)

### What you can do
- Search the web for current information
- Used for tech twitter digest in nightly report
- Research topics for deep dives

### How to do it
- `BRAVE_API_KEY` is set in secrets.env
- Use via exec or web browsing tools

### Gotchas
- Rate limits apply
- For Twitter/X data, use `site:x.com` queries as a workaround
- Future upgrade: twit.sh via x402 for direct Twitter API access

---

## tryps-docs Repo

### What you can do
- Read and write scope specs, standups, plans, reports
- Read shared state (priorities, brand, clickup config)
- Write nightly reports and standup docs

### Key paths
```
tryps-docs/
  shared/           # State, priorities, brand, clickup — auto-synced every 30min
  docs/standups/    # Daily standup documents
  docs/plans/       # Plans and specs
  marty/            # ★ YOUR BRAIN — source of truth, synced to workspace
    SOUL.md, USER.md, IDENTITY.md, TOOLS.md, MEMORY.md, AGENTS.md
    memory/         # Daily memory files
    skills/         # All your skills
    reports/        # Nightly reports
  scopes/   # Current scope specs
```

### Gotchas
- Default branch is `main` (not develop — that's the app repo)
- The sync script runs every 30 min and pulls tryps-docs → workspace
- If you edit files in your workspace directly, they'll be OVERWRITTEN on next sync
- Edit the source in tryps-docs and let sync propagate, OR edit workspace and commit to tryps-docs immediately
- marty-workspace repo is DEPRECATED — everything lives in tryps-docs/marty/ now

---

## Common Failure Patterns

These are things that have broken before. Check these first when debugging.

1. **"Token invalid" on ClickUp** — Token expired. Tell Jake to rotate in ClickUp Settings > Apps > API Token. Update `secrets.env` and restart gateway.

2. **"No exec access"** — Context pollution. Nuke the session transcript and restart the gateway (`systemctl --user restart openclaw-gateway.service`). It's NOT a config issue.

3. **Slack "not_in_channel" error** — Marty isn't a member of the target channel. Have Jake add Marty to the channel first.

4. **Files disappearing from workspace** — The sync script overwrites workspace files every 30 min from tryps-docs/marty/. Edit the source in tryps-docs, not the workspace.

5. **Sandbox can't find files** — OpenClaw sandbox ignores `workspaceAccess:rw`. Must copy files INTO sandbox directories explicitly. The sync script handles this for shared state and MEMORY.md.

6. **Google OAuth expired** — Re-authorize via `gog auth`. Tokens are at `.google_tokens.json`.

7. **Gateway not picking up changes** — Restart: `systemctl --user restart openclaw-gateway.service`. Config changes (secrets.env, openclaw.json, cron jobs) require a gateway restart.
