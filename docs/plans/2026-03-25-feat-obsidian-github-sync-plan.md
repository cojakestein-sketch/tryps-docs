---
title: "Obsidian + GitHub Bidirectional Sync for tryps-docs"
type: feat
date: 2026-03-25
---

# Obsidian + GitHub Bidirectional Sync for tryps-docs

## The Dream

Jake opens Obsidian, sees the entire tryps-docs repo as a connected knowledge graph. Edits in Obsidian push to GitHub automatically. Commits from the team (Asif, Nadeem, Rizwan, Andreas, Marty) appear in Obsidian automatically. Everything stays in sync. The graph view shows how scopes, plans, standups, and brand docs connect.

## How It Works

Obsidian is a local-first markdown editor. It reads a folder of `.md` files and calls it a "vault." The key insight: **your local `~/tryps-docs` git clone IS the vault.** Obsidian reads from it, the Obsidian Git plugin syncs it with GitHub, and the graph view visualizes all the connections.

```
GitHub (origin/main)
    ↕ auto-pull every 2 min / auto-push on save
~/tryps-docs (local git clone = Obsidian vault)
    ↕ Obsidian reads/writes .md files directly
Obsidian UI + Graph View
```

No special format conversion. No migration. Your existing markdown files work as-is.

---

## Setup (Jake's Machine — 15 Minutes)

### Step 1: Install Obsidian

```bash
brew install --cask obsidian
```

Or download from https://obsidian.md. Free for personal use (commercial license also free since Feb 2025).

### Step 2: Open tryps-docs as a Vault

1. Launch Obsidian
2. Click **"Open folder as vault"**
3. Select `~/tryps-docs`
4. Done — every `.md` file in the repo is now a note in Obsidian

Obsidian creates a `.obsidian/` folder inside tryps-docs for its config. Add it to `.gitignore` so it doesn't pollute the repo:

```bash
echo ".obsidian/" >> ~/tryps-docs/.gitignore
```

### Step 3: Install the Obsidian Git Plugin

This is the plugin that makes bidirectional sync work.

1. In Obsidian: **Settings > Community plugins > Turn on community plugins**
2. Click **Browse** > Search for **"Obsidian Git"** (by Vinzent03, 1M+ downloads)
3. Install > Enable

### Step 4: Configure Obsidian Git for Auto-Sync

Settings > Community plugins > Obsidian Git > Options:

| Setting | Value | Why |
|---------|-------|-----|
| **Auto pull interval** | `2` (minutes) | Team changes appear within 2 min |
| **Auto push after commit** | `ON` | Your edits go to GitHub immediately |
| **Auto commit interval** | `5` (minutes) | Batches small edits into commits |
| **Commit message** | `docs: obsidian auto-sync` | Clean commit messages |
| **Pull on startup** | `ON` | Always start with latest |
| **Push on close** | `ON` | Never lose edits |
| **Merge strategy** | `rebase` | Clean linear history |

After this, the sync loop is:
- **Every 2 min:** Pulls from GitHub (team's changes appear)
- **Every 5 min (or on close):** Commits + pushes your changes to GitHub
- **On startup:** Pulls latest before you see anything

### Step 5: Make the Graph View Useful

The graph view shows connections based on **links between notes.** Right now your `.md` files use standard markdown links (`[text](path)`), which Obsidian can follow. But the graph gets much better with **wiki links** (`[[note name]]`).

**Phase 1 (immediate): Use the graph with existing links.** It already works — Obsidian resolves relative markdown links. Open the graph view with `Cmd+G` or click the graph icon in the left sidebar.

**Phase 2 (optional, later): Add wiki links for richer connections.** In key files like INDEX.md, spec.md, objective.md, add `[[links]]` to related scopes:

```markdown
## Dependencies
- Requires [[agent-intelligence]] to be functional
- Shares payment flow with [[payments-infrastructure]]
- Voice guide at [[imessage-agent/voice-guide]]
```

Each `[[link]]` creates a visible edge in the graph. The more links, the more useful the graph.

**Graph view tips:**
- **Local graph** (right-click a note > "Open local graph") is more useful than global graph for large vaults
- **Filter by folder** — show only `scopes/` to see scope connections
- **Color by folder** — scopes in one color, plans in another, standups in another
- Drag nodes around, zoom in/out. The layout is force-directed.

---

## What the Sync Loop Looks Like in Practice

### Jake edits in Obsidian
1. Opens Obsidian, sees tryps-docs
2. Edits `scopes/customer-service-triaging/objective.md`
3. Obsidian Git auto-commits after 5 min (or Jake hits `Cmd+P > "Obsidian Git: Commit and push"`)
4. Change appears on GitHub within seconds

### Nadeem pushes a PR that merges to main
1. PR merges on GitHub
2. Within 2 minutes, Obsidian Git auto-pulls
3. Jake sees the updated files in Obsidian immediately
4. Graph view updates to reflect any new links

### Marty pushes a nightly report
1. Marty commits to main on Hetzner
2. Next auto-pull (max 2 min), Jake sees it in Obsidian

### Jake edits in Claude Code
1. Claude edits files in `~/tryps-docs` and commits
2. Next Obsidian Git cycle picks it up and pushes
3. OR: Claude pushes directly, and Obsidian pulls on next cycle
4. Either way, everything converges

### Conflict handling
If Jake edits in Obsidian AND someone else edits the same file before sync:
- Obsidian Git uses rebase strategy — applies Jake's changes on top
- If there's a real conflict, Obsidian shows conflict markers in the file
- Jake resolves manually (rare — different people edit different files)

---

## Acceptance Criteria

- [ ] Obsidian installed and opens `~/tryps-docs` as a vault
- [ ] `.obsidian/` added to `.gitignore`
- [ ] Obsidian Git plugin installed and configured
- [ ] Auto-pull works: team commit on GitHub appears in Obsidian within 2 min
- [ ] Auto-push works: edit in Obsidian appears on GitHub within 5 min
- [ ] Graph view shows connections between scopes (at minimum, folder-level clustering)
- [ ] Claude Code edits in `~/tryps-docs` sync correctly (no conflicts with Obsidian)
- [ ] Startup pull works: opening Obsidian after being closed shows latest state

---

## Graph View: Making It Actually Useful (Not Just Pretty)

The graph view gets useful when notes have explicit connections. Here's a quick-win approach for tryps-docs:

### Quick Wins (Add to existing files)

**1. INDEX.md links to all scope folders:**
```markdown
| 7 | [[imessage-agent/spec|iMessage Agent]] | **in-progress** | asif |
```

**2. Spec files link to dependencies:**
```markdown
## Dependencies
- [[payments-infrastructure/spec|Payments Infrastructure]] must be functional
- Shares voice guide with [[imessage-agent/voice-guide]]
```

**3. Standups link to scopes being discussed:**
```markdown
### Nadeem — [[output-backed-screen/spec|output-backed-screen]] (48 SC)
```

**4. Plans link to the scopes they cover:**
```markdown
See [[scopes/INDEX|MECE Scope List]] for current status.
```

### Graph View Settings (in Obsidian)

Open graph view (`Cmd+G`), click the settings gear:

| Setting | Recommendation |
|---------|---------------|
| **Groups** | Color by folder: scopes=blue, docs/plans=green, standups=orange, brand-and-gtm=red |
| **Show orphans** | OFF (hides unlinked notes — reduces noise) |
| **Show attachments** | OFF (hides .png, .pdf, etc.) |
| **Link distance** | 200-300 (spreads nodes for readability) |
| **Repel force** | Medium-high (prevents clumping) |

---

## Gotchas and Edge Cases

### `.obsidian/` folder
Obsidian stores its config (plugins, themes, graph settings) in `.obsidian/` inside the vault. **Do not commit this to GitHub** — it's Jake's personal Obsidian config and would pollute the repo for the team.

### Large files
The `.pen` file (Pencil design file) and any images will show in Obsidian but aren't editable there. That's fine — they just appear as attachments.

### Marty pushing frequently
If Marty pushes to main every few minutes, Obsidian Git might occasionally need to rebase. This is handled automatically — just keep the auto-pull interval at 2 min so divergence stays small.

### Claude Code and Obsidian editing the same file
If Claude Code is editing files in `~/tryps-docs` while Obsidian is open, Obsidian sees the changes instantly (it watches the filesystem). The Git sync still works — Claude commits, Obsidian Git pushes on next cycle. Just don't have both Obsidian and Claude editing the *same file* at the *same second*.

### The archive/ folder
Obsidian will show `archive/` files in the graph and file explorer. To keep it clean:
- In Obsidian Settings > Files & Links > **Excluded files**, add `archive/`
- This hides archived content from search, graph, and suggestions

---

## Timeline

| Step | Time | What |
|------|------|------|
| 1 | 2 min | Install Obsidian |
| 2 | 1 min | Open tryps-docs as vault |
| 3 | 2 min | Install Obsidian Git plugin |
| 4 | 3 min | Configure auto-sync settings |
| 5 | 2 min | Add `.obsidian/` to `.gitignore`, exclude `archive/` |
| 6 | 5 min | Set up graph view colors and filters |
| **Total** | **~15 min** | **Full bidirectional sync + graph view** |

Optional follow-up (when you have time):
- Add `[[wiki links]]` to key files for richer graph connections
- Explore the Canvas plugin (infinite whiteboard connecting notes visually)
- Try the Local Graph view for scope-level exploration

---

## Why Obsidian (vs Alternatives)

| Tool | Graph | Git sync | Works with existing .md | Notes |
|------|-------|----------|------------------------|-------|
| **Obsidian** | Built-in, best-in-class | Via plugin (mature, 1M+ downloads) | Yes, just point at folder | Best option for your use case |
| Logseq | Has graph | Native git support | Needs restructuring (block-based) | Would require reformatting all files |
| Foam (VS Code) | Has graph | Native (it IS VS Code + git) | Yes | Good if you live in VS Code, weaker graph |
| Dendron | Has graph | Native git | Needs hierarchy convention | More structured than you need |

**Obsidian wins** because: best graph view, works with your existing markdown as-is, mature Git plugin, zero restructuring needed.

---

## References

- Obsidian Git plugin: https://github.com/Vinzent03/obsidian-git
- Obsidian graph view docs: https://help.obsidian.md/Plugins/Graph+view
- kepano (Obsidian CEO) on Claude Code + Obsidian integration: recent X posts
- Twitter research: Claude Code + Obsidian is "the new hot combo" — official Skills let Claude read/modify vault notes
