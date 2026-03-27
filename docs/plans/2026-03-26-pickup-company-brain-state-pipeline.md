# Pickup Prompt: Company Brain State Pipeline

Copy-paste this into a new Claude Code session:

---

```
/workflows:work ~/tryps-docs/docs/plans/2026-03-26-feat-company-brain-state-pipeline-plan.md

Context: We just added ~150 wiki links across 47 files in tryps-docs to make the Obsidian graph useful. Now we need to close three structural gaps to make the repo an operational "company brain."

The plan has 3 moves + a standup update. Execute them in order:

MOVE 1 (State Pipeline):
- Create scopes/customer-service-triaging/state.md (only missing scope state file)
- Update all 12 scope state.md frontmatter to reflect current reality from standup data (March 23-26). Key numbers: Rizwan 55/61, Asif 34/57, Nadeem 7/48 implemented.
- Populate shared/state.md with aggregated data from all 12 scopes (currently empty — every Claude session loads "0 scopes")
- Update shared/priorities.md to reflect MECE scopes (currently stale, still says P1/P2/P3 from March 18)
- Add > Parent: backlinks to the 8 scope state.md files that don't have them yet

MOVE 2 (Feedback Loop):
- Document the state sync process for Marty: after standups are committed, read answers → update scope state.md frontmatter → regenerate shared/state.md
- Add to marty/HEARTBEAT.md as a new scheduled task ("Post-Standup State Sync")
- Do NOT modify marty/skills/ — just document the process

MOVE 3 (Connect Orphans):
- Create docs/plans/INDEX.md with wiki links to all 17+ plan files
- Update README.md Key Files table to include: decisions.md, team.md, observations.md, priorities.md, brand-strategy.md, plans INDEX
- Update README.md "For Agents" section to also reference plans/INDEX.md

STANDUP UPDATE:
- Add a "## Knowledge Graph Update (Jake)" section to ~/tryps-docs/standups/2026-03-26-standup.md BEFORE the "## Today's Questions" section
- 1 paragraph explaining what was done with wiki links + state pipeline, note Rizwan can verify
- The standup was recently modified by Marty — the current version has new questions and a simplified SC tracking table. Preserve all existing content.

CRITICAL RULES:
1. DO NOT change existing file content — only add links, state data, new sections, and new files
2. Repo is ~/tryps-docs, branch is main
3. Commit after each move (3 commits + 1 for standup update)
4. Push to origin/main when done
5. After all changes, run: open -a Obsidian
```
