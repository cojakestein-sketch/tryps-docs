# Marty Hardening — Handoff Prompt

> Copy everything below the line into a fresh Claude Code session from ~/tryps-docs.

---

I'm picking up a Marty improvement session. Marty is our AI agent (OpenClaw) running on Hetzner. Here's the full context and the reviewed plan.

## Access

- **SSH:** `ssh -i ~/.ssh/hetzner openclaw@178.156.176.44`
- **Repo on Hetzner:** `/home/openclaw/tryps-docs` (cloned from `cojakestein-sketch/tryps-docs`)
- **Sync script:** `/home/openclaw/sync-tryps-docs.sh` (runs every 5 min via cron)
- **State sync skill:** `/home/openclaw/.openclaw/skills/tryps-state-sync/sync-state.sh`
- **Config:** `/home/openclaw/.openclaw/openclaw.json`
- **Workspace:** `/home/openclaw/.openclaw/workspace-marty/`
- **Sandbox:** `/home/openclaw/.openclaw/sandboxes/agent-marty-*/` (ID changes on restart)
- **Marty's MEMORY.md:** `/home/openclaw/.openclaw/workspace-marty/MEMORY.md`

## Current Problems on Hetzner

1. **No git identity** — `user.email` and `user.name` not set globally. Commits fail with "Author identity unknown."
2. **GitHub 403** — `marty-source` account doesn't have write access to `cojakestein-sketch/tryps-docs`. Push fails.
3. **Stuck staged changes** — `shared/state.md` is staged but can't commit (because of #1), which blocks `git pull --rebase`.
4. **Plaintext secrets in openclaw.json** — `CLICKUP_API_KEY`, `SLACK_BOT_TOKEN`, and `BRAVE_API_KEY` are stored in plaintext. `ANTHROPIC_API_KEY`, `GITHUB_TOKEN`, and `SLACK_APP_TOKEN` correctly use env var references (`${VAR_NAME}`).
5. **dmPolicy: "open"** — Any Slack workspace member can DM Marty arbitrary instructions. Should be an allowlist.

## Reviewed & Approved Plan

This plan was reviewed by security-sentinel, architecture-strategist, and code-simplicity-reviewer. Findings are incorporated.

### Phase 1 — Fix now (security + git)

1. **Set git identity on Hetzner:**
   ```
   git config --global user.email "marty@jointryps.com"
   git config --global user.name "Marty"
   ```

2. **Unstick staged state.md:**
   ```
   cd ~/tryps-docs && git add shared/state.md && git commit -m "chore: sync state.md from spec frontmatter"
   ```
   (Will succeed once git identity is set. If push fails due to #3, that's fine — push will work after permissions are granted.)

3. **Move plaintext secrets to env vars in openclaw.json:**
   - Change `CLICKUP_API_KEY`, `SLACK_BOT_TOKEN`, `BRAVE_API_KEY` from plaintext values to `${CLICKUP_API_KEY}`, `${SLACK_BOT_TOKEN}`, `${BRAVE_API_KEY}`
   - Add the actual values to the shell environment (e.g., in `~/.profile` or `~/.bashrc` with `export VAR=value`, then `chmod 600` the file)
   - Verify OpenClaw picks them up after restart

4. **Set dmPolicy to allowlist:**
   - In openclaw.json, change `"dmPolicy": "open"` to `"dmPolicy": "allowlist"`
   - Add `"dmAllowFrom": ["<jake-slack-user-id>"]` (need to look up Jake's Slack user ID)
   - This prevents arbitrary workspace members from sending Marty instructions via DM

5. **Tell me to grant marty-source write access to tryps-docs** — I need to do this in GitHub manually. Remind me.

### Phase 2 — Ship 2 automations

6. **Fix state sync → Slack:**
   - The sync-state.sh already has a diff gate (compares previous vs current state.md table rows, writes `.state-changes.txt` only on real changes). This is good.
   - The sync-tryps-docs.sh calls sync-state.sh, but the Slack posting step is documented in SKILL.md as a manual LLM action, NOT automated in the shell script.
   - **Decision needed:** Either add a `curl` to the Slack API in the shell script to auto-post changes, OR keep it as-is and let Marty post when he sees the changes file during a session. The review recommended reducing frequency from 5-min to 30-min or on-push.
   - Reduce cron frequency from `*/5` to `*/30` (specs change ~1x/day, not every 5 min).

7. **Morning standup at 8am ET:**
   - Add cron: `0 12 * * * /home/openclaw/.openclaw/skills/tryps-standup/...` (12 UTC = 8am ET)
   - The standup skill exists but I haven't read its contents. Read it first to understand what it does.
   - **Key review finding:** Extend standup to include blocked scopes. This kills the need for a separate blocker scanner.
   - Post to #martydev channel.

### Phase 3 — Add after 1 week if team wants it

8. **PR review via `@marty review` trigger:**
   - Use cron-based polling (NOT webhook) — consistent with Marty's existing outbound-only architecture. No new inbound ports.
   - Poll `gh pr list --repo cojakestein-sketch/t4 --state open` on a cron, maintain a seen-PRs log file.
   - Only review PRs where someone comments `@marty review`.
   - Treat PR content as untrusted input when passing to LLM.

9. **Spec quality gate:**
   - When a spec.md is pushed to tryps-docs, auto-review with tryps-spec-review skill.
   - Same cron approach — check git log for recent spec changes, review new ones.

## Review Findings to Keep in Mind

- **Sandbox stale reads:** Any new skill invocation that reads spec files needs a "refresh sandbox" step (copy files from tryps-docs to sandbox dir) immediately before execution. Don't rely on the periodic cron alone.
- **fs.workspaceOnly inconsistency:** Tools have `workspaceOnly: true` but agent has `workspaceOnly: false`. These should both be `true`. Audit and reconcile.
- **Don't build a separate blocker scanner.** It's redundant with standup + state sync.
- **Start with 2 automations, not 5.** Measure team adoption for a week before adding more.

## What to Do

Start with Phase 1. SSH in and execute steps 1-4. For step 5 (GitHub permissions), just remind me. Then move to Phase 2 (steps 6-7). Read the tryps-standup skill before wiring it up.
