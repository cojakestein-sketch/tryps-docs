---
id: group-decision-making
status: in-progress
assignee: rizwan
clickup_ids: ["86e0emu5q"]
criteria: 0/25
blockers: ["Linq tapback reaction API investigation needed", "Vote timeout algorithm needs formal design doc", "Rate limiter interaction with SC-61 needs resolution"]
last_updated: 2026-04-02
updated_by: jake
review_status: un-reviewed
---

> Parent: [[group-decision-making/objective|Group Decision-Making Objective]]

## Current State

Destination voting, date voting, and activity voting are all built. Facilitation engine spec expanded from 14 → 25 SC. New areas: participant awareness (SC-15–17), emoji voting via iOS tapback reactions (SC-18–22), facilitation → booking transition (SC-23), and two new negative criteria (SC-24–25). Notification triggers (22 events) are partial — push infra exists, triggers need mapping. Role cards deferred to separate design pass.

## What's Next

- **Priority 1:** Fix participant awareness — agent must know who's in the group chat (SC-15, SC-16). Live bug per Issue #341.
- **Priority 2:** Build emoji voting mechanism (SC-18, SC-19, SC-20). Investigate Linq tapback reaction API.
- **Priority 3:** Build facilitation intelligence loop (SC-1 through SC-5)
- Build criticality matrix (SC-4, SC-5)
- Build disagreement resolution flow (SC-8, SC-9)
- Build done detection and off-ramp (SC-10)
- Build non-voter nudging (SC-21) and vote prediction (SC-22)
- Build facilitation → booking transition (SC-23)
- Wire 22 notification triggers (separate pass after facilitation ships)
- Design role cards (separate scope)
