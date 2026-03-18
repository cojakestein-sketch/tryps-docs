# Agent Ready — Morning Report 2026-03-17

## PR

**[#285 — [Report 0317] Fix bugs + improvements from Jake's morning report](https://github.com/cojakestein-sketch/tryps/pull/285)**

- Branch: `fix/morning-report-0317` → `develop`
- Reviewers: @asifraza1013, @Nadimkhan120
- 11 commits, 8 bug fixes + 3 UX improvements

## Summary

All 11 actionable items from Jake's morning testing session have been fixed and pushed in a single PR. The branch is 11 commits ahead of `develop`. Six items were triaged as skipped (need design, backend, or separate specs).

### Bugs Fixed
1. Globe not loading — improved WebView resilience with auto-retry and longer timeout
2. Explore tab too dark in light mode — theme-aware background colors
3. People tab cream background — matched to standard #F5F7FA
4. Group vibe not saving — await refetch after save, reduced stale window
5. Mood board photo removal — wired up long-press delete for photos
6. Can't add flights in People tab — added visible "Add your flight" button
7. Default tab is Activities — reordered CORE_TABS so Itinerary is first
8. "My Trip" to "My Trips" — corrected plural on home tab + calendar typecheck fix

### UX Fixes
9. Dot indicator lag — tightened spring physics on swipe indicators
10. Date picker doesn't scroll — added auto-scroll + day expansion on date tap
11. Share not a bottom sheet — added modal presentation to share screen

### Skipped (needs design/backend)
- Calendar tab Figma audit (design team)
- Dress code rework (needs spec)
- Drag activities (large scope, needs spec)
- Share from home screen (needs design)
- Itinerary left-hand slider (not built yet)
- Trending songs (backend issue)

## Artifacts

| File | Description |
|------|-------------|
| [plan.md](plan.md) | Execution plan with all 17 items triaged |
| [work-log.md](work-log.md) | Step-by-step implementation log |
| [review.md](review.md) | Self-review of all changes |
| [compound-log.md](compound-log.md) | Compound tool usage log |
| [spec.md](spec.md) | Original spec from morning report |

## Follow-Up Items

These were noted in review as out-of-scope or needing further work:

- **Calendar tab Figma audit** — needs design team input; file a separate scope
- **Dress code rework** — needs a dedicated spec with design mockups
- **Drag-to-reorder activities** — large scope; needs its own spec and sprint allocation
- **Share from home screen** — needs design for share target placement
- **Itinerary left-hand time slider** — component doesn't exist yet; needs design + build
- **Trending songs** — backend/API issue, not a frontend fix
