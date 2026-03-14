# Phase 3: Agent Layer — Functional Requirements Document

**Version:** 1.0
**Date:** March 12, 2026
**Author:** Jake Stein, Founder
**Domain:** jointryps.com | tripful://
**Depends on:** Phase 1 + Phase 2

---

## Overview

Phase 3 adds AI agents that execute real-world actions: search/book flights, make DNA-calibrated recommendations, vote for "I don't care-ers," and handle micropayments for API calls. Transforms Tryps from a planning tool into an execution platform.

**Success criteria:**
1. Agent can search flights and present options to the group
2. Agent can book a flight through Duffel API using Tryps Cash
3. Agent can vote on activities/stays based on user's Travel DNA
4. Recommendations calibrated to group DNA (not generic)

## Scope

| Category | Features |
|----------|----------|
| **Flight Search** | Amadeus/Duffel search, DNA-sorted recommendations, fare comparison |
| **Flight Booking** | Full booking via Duffel API, PNR management |
| **Agent Wallet** | Tryps Cash for funding agent API calls |
| **X-402** | Micropayment protocol for agent-to-API transactions |
| **Agent Voting** | AI votes on behalf of "I don't care-ers" using DNA |
| **Smart Recommendations** | DNA-calibrated suggestions for activities, stays, dining |

## 3.1 Flight Search & Booking

Agent searches flights for all trip participants based on home airports, ranks by DNA preferences (price-sensitive → cheapest first, convenience → direct flights first), enables group voting on flights, then books winner through Duffel.

### New Screens (13)

| # | Screen | Description |
|---|--------|-------------|
| P3.1-P3.8 | Flight Search | Trigger, config, results, comparison, detail, group vote, price alerts |
| P3.9-P3.13 | Flight Booking | Confirm, passenger details, success, failed, manage booking |

## 3.2 Tryps Cash (Agent Wallet)

Pre-funded wallet for agent API calls. Users fund via Stripe; agents spend executing tasks (flight searches ~$0.02, bookings ~$0.50).

### New Screens (5)

| # | Screen | Description |
|---|--------|-------------|
| P3.14-P3.18 | Wallet | Overview, fund, transaction history, auto-top-up, group wallet |

## 3.3 X-402 Micropayment Protocol

When agent calls an external API and gets HTTP 402, X-402 auto-handles the micropayment from Tryps Cash. Needs research — may be pre-standard.

## 3.4 Agent Voting (DNA-Calibrated)

For the 60% "I don't care-ers": agent votes using Travel DNA dimensions. Opt-in only, transparent reasoning, user can always override.

### New Screens (4)

| # | Screen | Description |
|---|--------|-------------|
| P3.19-P3.22 | Agent Voting | Opt-in, vote cast notification, override, summary |

## 3.5 Smart Recommendations

DNA-calibrated suggestions: activities, stays, restaurants, itinerary optimization, conflict resolution when group DNA diverges.

### New Screens (3)

| # | Screen | Description |
|---|--------|-------------|
| P3.23-P3.25 | Recommendations | Feed, detail, DNA conflict resolution |

## Cost Model

Tryps absorbs agent costs initially. Estimated $3-8 per trip (search + booking + recommendations + voting). At 1,000 trips/month: $3,000-8,000/month.

## Dependencies

| Dependency | Status |
|-----------|--------|
| Phase 1 complete | In Progress |
| Phase 2 Stripe | Not started |
| Duffel API access | Not started |
| X-402 protocol spec | Research needed |

## Open Questions

1. Where does the orchestration "brain" live? (Edge Functions? Dedicated server? OpenClaw?)
2. Which APIs support X-402 today?
3. Duffel per-booking fees?
4. How to measure agent voting accuracy vs user preference?
