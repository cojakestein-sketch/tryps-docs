# TOOLS.md - Local Notes

## Exec Permissions

You have FULL exec permissions. Configured 2026-03-10.
- `tools.exec.security: "full"` in openclaw.json
- Run any command, create cron jobs, execute scripts without asking
- DO NOT request exec permissions from Jake — you already have them

## GitHub MCP
- **Repo:** cojakestein-sketch/tripful (private)
- **Marty GitHub:** marty-source (collaborator, push access)
- **Workspace repo:** cojakestein-sketch/marty-workspace (private — for syncing workspace files)
- **Use for:** Reading files, browsing code, reviewing PRs, checking CI status

## ClickUp MCP
- **Workspace:** 9017984360
- **Space:** 90174516230
- **Folder:** "Tryps App" 90177160411
- **Lists:**
  - "01 - This Week" `901711582339`
  - "02 - Backlog" `901711582341`
  - "03 - Ideas & Bugs" `901711582345`
- **Statuses:** Needs Spec → To Do → In Progress → Review → Done
- **Member IDs:** Jake `95314133`, Asif `95375712`, Nadeem `95375710`

## Zoom
- **API:** Server-to-Server OAuth app "Marty" (all scopes)
- **Credentials:** ~/.openclaw/workspace-marty/zoom-credentials.json
- **Standup meeting:** 5559102787 (https://us05web.zoom.us/j/5559102787)
- **Auth flow:** POST https://zoom.us/oauth/token with account_credentials grant → Bearer token

## Slack
- **Standup channel:** C0AJP6B9KCK (#dev/standup)
- **Standup reminders:** 3x daily (10am, 2pm, 5:45pm ET) → post to #all-tryps
- **Zoom link for standups:** https://us05web.zoom.us/j/5559102787

## Google Calendar
- **Credentials:** ~/.openclaw/workspace-marty/credentials.json
- **Jakes calendar:** jake@jointryps.com
- **Martys email:** marty@jointryps.com

## GitHub Sync

Workspace is git-backed at: https://github.com/cojakestein-sketch/marty-workspace (private)
After significant workspace file changes, commit and push:
```bash
cd ~/.openclaw/workspace-marty && git add -A && git commit -m "update workspace" && git push
```
Do this at least once per session or after major updates.
