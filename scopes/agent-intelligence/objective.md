---
id: agent-intelligence
title: "Agent Intelligence"
scope_number: 8
owner: jake
created: 2026-03-20
last_updated: 2026-03-22
review_status: reviewed
---

## What

The AI brain that makes Tryps smarter than manual planning. Three tightly coupled sub-systems: memory architecture (per-user, per-trip, and cross-trip learning), vote-on-behalf (agent proxy voting from Travel DNA + behavioral history), and a recommendations engine (activity database + personalized ranking). Memory is the foundation — it feeds both vote-on-behalf and recommendations. The iMessage Agent (scope 7) is the channel; Agent Intelligence is the brain.

## Why

Without intelligence, Tryps is just a trip organizer. With it, Tryps knows your friends, your vibe, and your home airport — and gets better every trip. Memory architecture is the hardest technical problem and the deepest moat. The more you use Tryps, the better it gets. That's the lock-in.

## Key Concepts

- **Travel DNA is the Seed, Memory is the Growth:** Users enter the system at different tiers of engagement (vibe quiz only → natural language intent → full Travel DNA → ongoing 1:1 DM relationship). Each tier produces richer data. Memory extends Travel DNA over time — the quiz is the starting point, behavior is the growth.
- **One Agent, One Brain:** Memory is shared across channels. The user experiences one unified agent whether they're in iMessage or the app. Same context, same preferences, same history.
- **Batch, Don't Spam:** Vote-on-behalf notifications are always batched into a single DM per user, never one-per-poll. The agent votes, tells you what it did, and you override what you disagree with.
- **User Data > Seed Data:** User-generated activities from other Tryps users rank higher than scraped defaults. "Other Tryps users loved this in Bangkok" beats a generic travel blog recommendation. Social graph comes from shared trips + contact book sync.
- **Facilitator, Not Dictator:** The agent suggests votes and recommendations. Humans override. Explicit always beats inferred.

## Success Looks Like

- Memory persists across sessions and channels — the agent knows you in iMessage and in the app
- Vote-on-behalf works from vibe quiz alone and gets better every trip as more signals accumulate
- Activity recommendations feel personalized to the group, not generic — different groups going to the same city get different suggestions
- Recommendations surface in BOTH the app and iMessage — one brain, both channels
- User-generated activities surface as higher-priority than seed data
- The feedback loop is closed: recommendations → adoption tracking → post-trip favorites → better rankings
- Users can see what the agent remembers about them (transparency)
- NLP extraction pipeline is designed and documented — how free text becomes structured memory
- Cross-scope interfaces with iMessage Agent (scope 7) are jointly designed: DM delivery pipeline, vote override routing, recommendation serving, rate limiting

## Wave Assignment

- **Wave 1:** Memory architecture (data model, tables, signal types), activity database schema, scraping pipeline setup
- **Wave 2:** Vote-on-behalf engine, recommendations algorithm, activity database population, memory injection into iMessage agent system prompt
- **Wave 3:** Cross-trip learning, feedback loop validation, QA pass

## Dependencies

- [[travel-identity/objective|Travel Identity]] (scope 4): Vibe quiz data feeds vote-on-behalf and recommendations. Vibe quiz is already built — full Travel DNA not required but enriches memory.
- [[imessage-agent/objective|iMessage Agent]] (scope 7): System prompt extension points (SC-34) must exist for memory injection. Agent Intelligence provides the data; iMessage Agent renders it.

## Scope Files
- [[agent-intelligence/spec|Spec (61 SC)]]
- [[agent-intelligence/state|Current State]]
- [[agent-intelligence/design|Design Brief]]
- [[agent-intelligence/testing|QA Criteria]]
- [[agent-intelligence/memory-architecture|Memory Architecture]]
