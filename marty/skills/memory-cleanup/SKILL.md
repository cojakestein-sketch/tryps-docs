---
name: memory-cleanup
description: Archive old daily files, flag stale MEMORY.md sections, track overdue promises
user-invocable: true
---

# Memory Cleanup

Maintains Marty's memory hygiene. Handles archival, staleness detection, and promise expiry.

## When to Run

- **Weekly:** Sunday 22:00 ET (scheduled via HEARTBEAT.md)
- **Manually:** When Jake says "clean up memory" or "memory maintenance"
- **During heartbeat:** If `memoryCleanup` in heartbeat-state.json is null or >7 days old

## Steps

### 1. Archive Old Daily Files

Move daily memory files older than 7 days from `memory/` to `memory/archive/`:

```
memory/2026-03-08.md → memory/archive/2026-03-08.md
```

**Rules:**
- Only move files matching `YYYY-MM-DD.md` (no suffixed files — those belong in `memory/notes/`)
- Keep the most recent 7 days of daily files in `memory/`
- Never delete — always move to archive

### 2. Redirect Suffixed Files to Notes

Any file matching `YYYY-MM-DD-*.md` (e.g., `2026-03-11-fresh-start.md`) does NOT belong in `memory/`. Move it to `memory/notes/`:

```
memory/2026-03-11-fresh-start.md → memory/notes/2026-03-11-fresh-start.md
```

### 3. Scan MEMORY.md for Stale Sections

Each `##` heading in MEMORY.md should have a `<!-- last_verified: YYYY-MM-DD -->` comment after it.

- If `last_verified` is >30 days old → flag the section as **stale** in the cleanup report
- If `last_verified` is missing → flag as **unverified**
- When you verify a section is still accurate, update its `last_verified` to today's date

### 4. Surface Overdue Promises

Scan the most recent daily memory files for promises with target dates:

- **>3 days overdue:** Inject into the next standup questions as a follow-up
- **>7 days overdue:** Move to an "Expired Promises" section at the bottom of the daily file and note that it was never resolved

### 5. Write Cleanup Report

Append to today's daily memory file (`memory/YYYY-MM-DD.md`):

```markdown
## Memory Cleanup — [Date]

### Archived
- [list of files moved to archive/]

### Redirected to Notes
- [list of files moved to notes/]

### Stale MEMORY.md Sections
- [section name]: last verified [date] ([X] days ago)

### Overdue Promises
- [promise]: was due [date], now [X] days overdue → [action taken]

### Stats
- Daily files in memory/: [count]
- Archived files: [count]
- Notes files: [count]
- MEMORY.md size: [KB]
```

### 6. Update Heartbeat State

Set `lastChecks.memoryCleanup` in `memory/heartbeat-state.json` to the current Unix timestamp.

## What This Skill Does NOT Do

- Does NOT delete any files (archive only)
- Does NOT modify MEMORY.md content (only updates `last_verified` timestamps)
- Does NOT split MEMORY.md into topic files (deferred until >30KB)
