# Pickup Prompt: Add Wiki Links to tryps-docs

Copy-paste this into a new Claude Code session:

---

```
Read the plan at ~/tryps-docs/docs/plans/2026-03-25-feat-obsidian-wiki-links-plan.md and execute it.

Context: We just set up Obsidian pointing at ~/tryps-docs as a vault with the Obsidian Git plugin for bidirectional GitHub sync. The graph view is working but shows mostly disconnected dots because files don't link to each other. This plan adds ~150 [[wiki links]] across ~47 files to make the graph useful.

CRITICAL RULES:
1. DO NOT change any file content — only add [[wiki links]] where the plan specifies. No rewording, no restructuring, no new sections (except "## Scope Files" at the bottom of objective.md files as specified).
2. DO NOT change file/folder structure. Everything stays where it is.
3. DO NOT link to anything in archive/. Fix any existing links pointing to deprecated paths.
4. Fix all broken URL-encoded links in standups (scopes%20-%20refined%203-20 paths).
5. Delete the empty file at repo root: ~/tryps-docs/2026-03-25.md (0 bytes).

Execute all 4 tiers in order. After each tier, commit with a descriptive message. Push to origin/main when done.

After all links are added, run: open -a Obsidian
Then tell me to check the graph view (Cmd+G) and compare to the before screenshot.
```
