# Tracker Dashboard Refinement — Brainstorm

**Date:** 2026-03-18
**Status:** Approved — ready for implementation

## What We're Building

Refine the auto-generated dashboard at tracker.jointryps.com so Jake can walk through every individual success criterion during standup — not just see counts.

## Key Decisions

1. **Inline expansion per scope.** Click a scope row → criteria appear right below it. No separate page, no scrolling to a different section.

2. **Three-state criteria tracking.** In spec.md:
   - `- [ ]` = untested (renders as `--` gray)
   - `- [x]` = pass (renders as `✅` green)
   - `- [!]` = fail (renders as `❌` red)

3. **Expand All / Collapse All toggle.** Default collapsed. Button at top toggles all scopes open/closed. Best for projecting on screen during standup.

4. **Criteria progress bar per scope** shows green (pass) / red (fail) / gray (untested) segments inline with the scope row.

## Why This Approach

- Three-state checkboxes are dead simple — QA changes one character in spec.md
- Inline expansion keeps everything on one page
- Collapse by default keeps 22 scopes scannable
- Expand All is perfect for standup screen projection

## What Changes

### spec.md criteria format
```markdown
- [x] **SC-2.** Push notif sends...     ← pass
- [!] **SC-3.** Deep links resolve...   ← fail
- [ ] **SC-7.** Linq fallback...        ← untested
```

### generate-dashboard.sh
- Parse `- [!]` in addition to `- [ ]` and `- [x]`
- Render criteria inline under each scope row with colored status icons
- Add Expand All / Collapse All toggle button
- Add per-scope criteria progress bar (green/red/gray segments)

### generate-status.sh
- Count `- [!]` as a third state (failing count)
- Update STATUS.md format to show pass/fail/untested per scope

## Open Questions

- Should failing criteria show at the top of the expanded list (failures-first sort)?
- Should there be a "Failures Only" filter to show just what's broken across all scopes?

## Next Step

Implement via `/workflows:plan` — update generate-dashboard.sh and generate-status.sh.
