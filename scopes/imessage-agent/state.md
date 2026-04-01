---
id: imessage-agent
status: done
assignee: asif
clickup_ids: ["86e0emu7g", "86e0f948t"]
criteria: 51/57
blockers: [SC-54/55 (recommendations, scope 8), SC-56/57 (DM pipeline, scope 8)]
last_updated: 2026-04-02
updated_by: asif
review_status: reviewed
---

> Parent: [[imessage-agent/objective|iMessage Agent Objective]]

## Current State

Spec updated to 57 criteria after audit on 2026-03-22. Voice & tone guide drafted and approved by Jake. Linq iMessage integration exists and works, needs system prompt architecture upgrades. Basic trip context and trip queries are partially working. App-iMessage sync is partial. Linq native polling coming in next few weeks — build text Q&A as baseline, architect for plug-in.

Major additions from audit:
- **Daily facilitator model** replaces event-driven notifications. Agent checks in ~1x/day with specific asks.
- **Trip completeness levels** (SC-53) — leveling system that drives daily check-ins. Needs design.
- **Routing logic design doc** (SC-52) — hardest technical problem, needs intentional design with 20+ examples.
- **Recommendations in iMessage** (SC-54-55) — one brain, both channels. Agent pulls from scope 8's engine.
- **Cross-scope coordination** (SC-56-57) — DM pipeline and vote override routing with Agent Intelligence.

Voice guide unblocks personality work. Design blockers: trip completeness level definitions, routing logic doc.

## Open Questions

- **Routing logic (SC-52, BLOCKING):** When does the agent speak vs. stay silent? Needs intentional design doc with 20+ examples, edge cases, and Jake review before implementation.
- **Trip completeness levels (SC-53, BLOCKING):** What are the exact levels? Jake sketched ~10 levels (location → flights → stay → activities → itinerary → fully planned). Needs formal design with milestone definitions, edge cases (road trips skip flights), and UI treatment.
- **Cross-scope interfaces (SC-56-57, BLOCKING):** DM delivery pipeline and vote override routing with Agent Intelligence. Asif and Rizwan must jointly design.
- Agent removal mechanic (kicking agent from group): may not be technically possible via Linq. Deferred, not blocking.
- Linq native polling: confirmed coming in next few weeks. Build text Q&A baseline, architect for plug-in.

## What's Next

1. **Routing logic design doc** (SC-52) — examples, edge cases, gotchas. Review with Jake.
2. **Trip completeness level definitions** (SC-53) — milestone design. Review with Jake.
3. System prompt architecture (modular: persona, routing, trip context, user context)
4. Integrate voice-guide.md directives into system prompt persona section
5. **Cross-scope interface design with Rizwan** (SC-56-57) — DM pipeline, vote override routing
6. Functional flows: expense parsing, voting facilitation, trip queries
7. Daily facilitator model: implement ~1x/day check-in driven by completeness levels
8. Recommendations in iMessage (SC-54-55) — integrate with Agent Intelligence engine
9. Jennifer Test validation: behavioral tests + Jake transcript review
