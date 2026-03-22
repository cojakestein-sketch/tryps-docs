---
id: agent-intelligence
status: specced
assignee: rizwan
clickup_ids: ["86e05v28h", "86e0ajhte"]
clickup_status: needs spec
criteria: 0/56
blockers: ["Vibe quiz data must be accessible (already built)", "System prompt extension points (SC-34 from iMessage Agent) must exist"]
last_updated: 2026-03-22T00:00:00Z
updated_by: jake
review_status: reviewed
---

## Current State

Spec complete (56 criteria across 3 sub-systems). Nothing built yet. Scope was refined during scoping interview on 2026-03-22 — Claude Connector and Logistics Agent moved to their own post-April 2 scopes. What remains: memory architecture, vote-on-behalf, and recommendations engine.

Memory-architecture.md (technical reference) is drafted and ready for Rizwan to build from.

## Restructuring from Original Gap Card

The original scope had 6 sub-systems. After scoping interview:
- **Kept (3):** Memory architecture, vote-on-behalf, recommendations engine
- **Moved to new scope 14 (post-April 2):** Claude Connector — expanded to multi-platform AI connectors (Claude, OpenAI, etc.)
- **Moved to own scope (post-April 2):** Logistics Agent — autonomous booking orchestration, built last
- **Folded into recommendations:** Research & suggest

Also deferred to post-April 2:
- Role cards (Mario-style character select)
- Flight/trip/discovery recommendations (only activity + accommodation recommendations for April 2)

## Open Questions

- Activity database size: Jake said "might need to be bigger than 10K." How much seed data is realistic for April 2?
- Activity template vs. specific activity architecture: generic templates ("beach day") that apply broadly vs. specific activities ("Bondi Beach") tied to locations. Need to validate the two-tier model works.
- Agent memory screen design: proposed in design.md, needs designer assignment and Figma mockup.
- Scraping pipeline: who builds the initial scrape? Rizwan owns the scope but may need support for data sourcing.

## What's Next

1. Rizwan reads memory-architecture.md and validates the data model
2. Designer assigned to agent memory screen + recommended activities section
3. Memory tables created in Supabase
4. Activity database schema built, seed data pipeline started
5. Vote-on-behalf engine built on top of memory
6. Recommendations algorithm built on top of memory + activity database
7. Memory injection into iMessage agent system prompt (coordinate with scope 7)
