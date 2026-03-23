## Marty Revamp — Phase 1 Kickoff Prompt

Copy-paste this into a fresh Claude Code session:

---

Read the Marty revamp plan at ~/tryps-docs/docs/plans/2026-03-23-marty-revamp-plan.md

Start with Phase 1: Clean House.

1. SSH into Marty's server (ssh -i ~/.ssh/hetzner openclaw@178.156.176.44)
2. Kill the dashboard-data and morning-standup cron jobs from ~/.openclaw/cron/jobs.json
3. Fix the ClickUp token — rotate it and update secrets.env + clickup-token.txt
4. Begin repo consolidation: create tryps-docs/marty/ directory structure, copy all files from the marty-workspace repo (cojakestein-sketch/marty-workspace) into tryps-docs/marty/
5. Update sync-tryps-docs.sh to sync tryps-docs/marty/ into the OpenClaw workspace
6. Archive the mission-control Docker container on Hetzner and the GitHub repo

Don't touch Phase 2+ yet — we'll review after Phase 1 is clean.
