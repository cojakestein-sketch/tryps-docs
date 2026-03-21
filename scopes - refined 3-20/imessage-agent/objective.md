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

## Success Looks Like

- Agent personality passes the Jennifer Test (voice guide + behavioral tests + Jake transcript review)
- System prompt architecture is modular, maintainable, and supports plugging in memory/intelligence later
- All 19 existing functional flows work (expenses, voting, queries, edge cases)
- Proactive behavior surfaces at the right moments without being annoying
- Non-app users have full participation, zero features gated behind app download

## Wave Assignment

- **Wave 1:** Voice & tone guide (copy doc), system prompt architecture, routing logic
- **Wave 2:** Functional flows (expenses, voting, queries, proactive behavior), non-app-user participation
- **Wave 3:** Jennifer Test validation, behavioral tests, QA pass

## Dependencies

- Voice & tone guide (scope 11, Brand & Design System) blocks agent personality work. Draft complete, needs final review.
- Memory (per-user, per-trip) lives in scope 8 (Agent Intelligence). Architect the agent to support it now.
