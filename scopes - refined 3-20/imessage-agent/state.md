---
id: imessage-agent
status: specced
assignee: asif
clickup_ids: ["86e0emu7g", "86e0f948t"]
criteria: 0/51
blockers: []
last_updated: 2026-03-21
updated_by: jake
review_status: reviewed
---

## Current State

Spec complete (51 criteria). Voice & tone guide drafted and approved by Jake. Linq iMessage integration exists and works, needs system prompt architecture upgrades. Basic trip context and trip queries are partially working. App-iMessage sync is partial.

Agent personality, expense parsing, voting facilitation, proactive behavior, and non-app-user participation are not started but now fully specced.

Voice guide unblocks personality work. No remaining design blockers.

## Open Questions

- Agent removal mechanic (kicking agent from group): may not be technically possible via Linq. Deferred, not blocking.
- Linq native polling support: unclear if available. Numbered-reply fallback is specced as baseline.

## What's Next

1. System prompt architecture (modular: persona, routing, trip context, user context)
2. Integrate voice-guide.md directives into system prompt persona section
3. Functional flows: expense parsing, voting facilitation, trip queries
4. Proactive behavior: opportunity detection, stall nudges, funnel suggestions
5. Jennifer Test validation: behavioral tests + Jake transcript review
