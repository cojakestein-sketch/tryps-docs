---
id: agent-intelligence
status: specced
assignee: rizwan
clickup_ids: ["86e05v28h", "86e0ajhte"]
clickup_status: needs spec
criteria: 0/61
blockers: ["Vibe quiz data must be accessible (already built)", "System prompt extension points (SC-34 from iMessage Agent) must exist"]
last_updated: 2026-03-22T00:00:00Z
updated_by: jake
review_status: reviewed
---

## Current State

Spec updated to 61 criteria across 3 sub-systems + cross-scope coordination + open design decisions. Nothing built yet. Scope was refined during scoping interview on 2026-03-22 — Claude Connector and Logistics Agent moved to their own post-April 2 scopes. What remains: memory architecture, vote-on-behalf, and recommendations engine. Post-audit additions (2026-03-22): NLP extraction pipeline design decision (SC-57), routing logic design doc (SC-58, shared with scope 7), and 3 cross-scope coordination SCs (SC-59-61) for DM delivery, vote override routing, and rate limiting.

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

- **NLP extraction pipeline (SC-57, BLOCKING):** How does free-text NL become structured memory signals? Rizwan needs to design this before starting Tier 2/4 memory. See memory-architecture.md Section 3 for options.
- **Routing logic design doc (SC-58, BLOCKING, shared with scope 7):** When does the agent speak vs. stay silent? Needs 20+ examples, edge cases, and Jake review. Asif and Rizwan co-own.
- **Cross-scope interfaces (SC-59-61, BLOCKING):** DM delivery pipeline, vote override routing, and rate limiting between scopes 7 and 8. Asif and Rizwan must jointly design before either implements.
- Activity database: generic templates should cover ALL destinations (no zero-rec destinations). Specific activities for 50+ popular destinations. 1000+ specific activities target.
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
