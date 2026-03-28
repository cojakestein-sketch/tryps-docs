---
id: group-decision-making
status: specced
assignee: rizwan
clickup_ids: ["86e0emu5q"]
criteria: 0/14
blockers: ["Criticality matrix design doc needed", "Rate limiter interaction with SC-61 needs resolution"]
last_updated: 2026-03-28
updated_by: jake
review_status: un-reviewed
---

> Parent: [[group-decision-making/objective|Group Decision-Making Objective]]

## Current State

Destination voting, date voting, and activity voting are all built. Facilitation engine spec written (14 SC). Notification triggers (22 events) are partial — push infra exists, triggers need mapping. Role cards deferred to separate design pass.

## What's Next

- Build facilitation intelligence loop (SC-1 through SC-5)
- Build criticality matrix (SC-4, SC-5)
- Build disagreement resolution flow (SC-8, SC-9)
- Build done detection and off-ramp (SC-10)
- Wire 22 notification triggers (separate pass after facilitation ships)
- Design role cards (separate scope)
