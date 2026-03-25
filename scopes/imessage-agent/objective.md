---
id: imessage-agent
title: "iMessage Agent"
scope_number: 7
owner: jake
created: 2026-03-20
last_updated: 2026-03-21
review_status: reviewed
---

## What

A Tryps travel agent living in your iMessage group chat via Linq. Add the number, everyone's on the trip. The agent handles expenses, voting, trip queries, and proactive facilitation, all without anyone needing to download the app. Powered by Claude Opus with a custom system prompt architecture.

## Why

iMessage is THE acquisition channel. One person adds the agent, everyone experiences it, some download the app. The agent must pass the Jennifer Test: if grandma can't tell it's AI, we win. This is the "holy shit" moment that makes Tryps real.

## Key Concepts

- **Jennifer Test:** If you told your grandmother the agent was a human travel agent named Jennifer, she would 100% believe it. The bar for April 2: a written voice guide the system prompt follows, behavioral tests where strangers can't tell it's AI, and Jake reviews a conversation transcript and approves it. All three.
- **System Prompt Architecture:** Three layers: (1) routing logic (when the agent speaks vs. stays silent), (2) persona instructions (voice, tone, personality), (3) context window management (trip data, user data, conversation history). Must be modular so memory and intelligence plug in later. Rizwan has experience here.
- **85/15 Rule:** 85% purely reactive and helpful. 15% personality, a witty concierge who occasionally drops a one-liner. Never gimmicky.
- **iMessage-sufficient:** Non-app users can do everything: vote, log expenses, query the itinerary. App download encouraged, never required.
- **Daily Facilitator Model:** The agent is NOT event-driven. It checks in ~once a day with the group, telling everyone exactly what's needed to progress the trip. Like a real travel agent who texts because they want the trip booked. Reactive confirmations (expenses, votes) still happen immediately.
- **Trip Completeness Levels:** The agent knows what a fully planned trip looks like (level 10) and steers the group from level 1 to level 10. Each level is a planning milestone. Levels are visible to users. This system drives what the agent asks for each day.
- **One Brain, Both Channels:** The agent draws from the same intelligence infrastructure (scope 8) in iMessage and the app. Recommendations, memory, vote-on-behalf are one system.

## Success Looks Like

- Agent personality passes the Jennifer Test (voice guide + behavioral tests + Jake transcript review)
- System prompt architecture is modular, maintainable, and supports plugging in memory/intelligence later
- All 19 existing functional flows work (expenses, voting, queries, edge cases)
- Daily facilitator model: agent checks in ~once a day with what's needed, never blows up the chat
- Trip completeness levels drive the agent's asks — it knows what stage the group is in
- Recommendations from Agent Intelligence surface in iMessage (one brain, both channels)
- Non-app users have full participation, zero features gated behind app download
- Routing logic design doc exists with examples and edge cases for when agent speaks vs. stays silent

## Wave Assignment

- **Wave 1:** Voice & tone guide (copy doc), system prompt architecture, routing logic design doc, trip completeness level definitions
- **Wave 2:** Functional flows (expenses, voting, queries), daily facilitator model, trip completeness tracking, recommendations in iMessage, cross-scope interface with Agent Intelligence (SC-56, SC-57)
- **Wave 3:** Jennifer Test validation, behavioral tests, QA pass

## Dependencies

- Voice & tone guide (scope 11, [[brand-and-gtm/README|Brand & GTM]]) blocks agent personality work. Draft complete, needs final review.
- Memory (per-user, per-trip) lives in scope 8 ([[agent-intelligence/objective|Agent Intelligence]]). Architect the agent to support it now.
