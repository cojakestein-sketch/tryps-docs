---
id: agent-intelligence
status: in-progress
assignee: rizwan
clickup_ids: ["86e05v28h", "86e0ajhte"]
clickup_status: in progress
criteria: 29/61
blockers: ["Cross-scope interfaces SC-59/60/61 need joint design with Asif"]
last_updated: 2026-04-04
updated_by: rizwan
review_status: reviewed
---

> Parent: [[agent-intelligence/objective|Agent Intelligence Objective]]

## Current State

27 of 61 SC ready for QA as of 2026-03-31; 29 of 61 as of 2026-04-04. Supabase local dev environment fully operational (130+ migrations passing). Three edge functions built and tested: **extract-memory-signals** (GPT-4o-mini for NLP extraction), **vote-on-behalf** (infers votes from preference profile), and **recommend-activities**. All supporting DB tables, triggers, and RPC functions are in place. Five DB triggers implemented. Test script passing 28/28 checks. Agent demo UI (Next.js) showcasing full pipeline + new flight booking chat demo (Duffel integration). Memory injection wired into iMessage agent via agent-router (#304). Vote override via DM reply and auto-vote on activities using Travel DNA shipped on `feat-flight-booking-101`.

**SCs ready (~27):**
- Memory Architecture (13/17): SC-1, 2, 3, 4, 6, 7, 9, 10, 11, 12, 13, 14, 15, 17
- Vote-on-Behalf (10/15): SC-18, 19, 22, 23, 24, 25, 26, 28, 30, 53
- Recommendations (2/18): SC-34, 37
- Should NOT Happen (2/6): SC-53, 55
- Design Decisions (1/2): SC-57

**What moved since March 27:**
- SC-13: Memory injection into iMessage agent system prompt (PR #304 + agent-router wiring)
- SC-23: Vote override via DM reply (`cd60b49c`)
- SC-24: Vote overrides stored as correction signals in memory (`cd60b49c`)
- SC-26: Auto-vote on activities using Travel DNA + user memory (`3bbe2e91`)
- SC-15: Agent memory screen built in app — `useAgentMemory` hook + `app/agent-memory.tsx`, entry point in Travel DNA My DNA tab (`2026-04-04`)

**What's NOT done:**
- Memory: SC-5 (cross-channel testing), SC-8 (Travel DNA extends memory), SC-16 (tier quality comparison)
- Vote-on-Behalf: SC-20/21 (batch DM delivery — blocked on SC-59), SC-27 (date votes), SC-29 (accommodation votes), SC-31/32 (all signals + accuracy over time)
- Recommendations: 16/18 SCs remaining — biggest gap. Activity DB expansion, group filtering, feedback loops, UGC, social graph all open.
- Should NOT Happen: SC-51/52/54/56 — need integration testing
- Design: SC-58 (routing logic doc, shared with scope 7)
- Cross-Scope: SC-59/60/61 — blocked on joint design with Asif

Scope was refined during scoping interview on 2026-03-22 — Claude Connector and Logistics Agent moved to their own post-April 2 scopes. What remains: memory architecture, vote-on-behalf, and recommendations engine. Post-audit additions (2026-03-22): NLP extraction pipeline design decision (SC-57), routing logic design doc (SC-58, shared with scope 7), and 3 cross-scope coordination SCs (SC-59-61) for DM delivery, vote override routing, and rate limiting.

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
- Scraping pipeline: who builds the initial scrape? Rizwan owns the scope but may need support for data sourcing.

## What's Next

1. Rizwan reads memory-architecture.md and validates the data model
2. Designer assigned to agent memory screen + recommended activities section
3. Memory tables created in Supabase
4. Activity database schema built, seed data pipeline started
5. Vote-on-behalf engine built on top of memory
6. Recommendations algorithm built on top of memory + activity database
7. Memory injection into iMessage agent system prompt (coordinate with scope 7)
