---
id: output-backed-screen
status: specced
assignee: nadeem
clickup_ids: []
clickup_status: null
criteria: 0/48
blockers: ["Linq capability audit for iMessage infographic rendering", "Design: trip overview layout + draggable itinerary (blocks all dev)"]
last_updated: 2026-03-22T23:00:00Z
updated_by: jake
review_status: reviewed
---

> Parent: [[output-backed-screen/objective|Output-Backed Screen Objective]]

## Current State

Spec session complete (2026-03-22). 48 success criteria defined across: trip overview, inline editing, draggable itinerary, adaptive completeness system, iMessage infographic, celebration moment, post-trip handoff, multi-user sync, and edge cases.

Key decisions from the interview:
- The deliverable is a **single overview screen** (not a card stack) — one view, everything you need
- iMessage version is a **dynamically generated infographic** that taps through to the app
- Completeness levels are **adaptive per trip** (3-15 milestones depending on trip complexity)
- The trip spectrum runs from **direct** ("Aspen, these dates") to **ideated** ("6 friends, no idea where")
- Editing is **inline** on the overview
- Drag-and-drop is for **itinerary reordering** (within and between days)
- **Confetti** when the trip hits 100% completeness
- Post-trip, the deliverable **freezes as a memory** and becomes the review artifact (scope 6)

Completeness level definitions written in `completeness-levels.md` — this is the source of truth for iMessage Agent SC-53.

## Open Questions

- Linq capability audit: can Linq send images + deep links in iMessage? What format/dimensions?
- Drag-and-drop library: what Expo/React Native library for drag-and-drop itinerary?
- ClickUp task needs to be created
- Designer needs to be assigned

## What's Next

1. Create ClickUp task for this scope
2. Assign designer — hand off `design.md` (6 screens needed, overview + itinerary are immediate blockers)
3. Linq capability audit for infographic rendering
4. Nadeem begins data layer / infrastructure work while design is in progress
5. Coordinate with Asif (iMessage Agent) on infographic delivery pipeline integration
