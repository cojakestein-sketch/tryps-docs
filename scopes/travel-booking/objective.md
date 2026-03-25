---
id: travel-booking
title: "Travel Booking"
scope_number: 10
where_it_lives: "iMessage, mobile, backend"
owner: jake
created: 2026-03-20
last_updated: 2026-03-23
review_status: reviewed
---

## What

The API service layer for searching, sourcing, and booking everything trip-related: flights, stays, restaurants, events/tickets, transportation, and activities. Travel Booking exposes search(), book(), and cancel() interfaces that the app UI, iMessage Agent (scope 7), and Logistics Agent (scope 15) all call. It connects to external providers (Duffel, Resy, OpenTable, Ticketmaster, Uber, Viator, etc.), returns unified results, and executes bookings — delegating payment to Payments Infrastructure (scope 9).

## Why

The core promise of Tryps is: say what you want in natural language and it gets booked. "Find Blake a flight from Newport Beach to NYC" → search → options → confirm → ticket issued. Travel Booking is the hands that make that happen — the actual API integrations that turn intent into reservations, tickets, and confirmations. Without it, Tryps is a planning tool. With it, Tryps is a travel agent.

## Key Concepts

- **Service Layer Pattern:** Travel Booking is infrastructure, not UI. It exposes unified interfaces (search, book, cancel) per category. The app, iMessage Agent, and Logistics Agent are all consumers. Swap or add providers without changing calling code.
- **Six Booking Categories:** Flights, stays, restaurants, events/tickets, transportation, activities. Each category has at least one API provider, some have multiple with fallback.
- **Multi-Person Flight Coordination:** Search flights for N people from different origin cities that land within a configurable window (default 90 minutes). This powers the "holy shit" moment.
- **services.md Catalog:** A living document in this scope folder cataloging every external API — what it does, pricing, auth, integration status, and who owns the next action (dev or Jake). Devs maintain it, Jake reviews it.
- **Payment Delegation:** Travel Booking never handles money directly. It hands off to Payments Infrastructure (scope 9) for charges. Booking + payment confirmation flow back through Travel Booking to finalize with the provider.
- **Provider Abstraction:** Unified response format across all providers. Results always look the same regardless of whether they came from Duffel, Resy, or Viator.

## Success Looks Like

- All 6 booking categories have API-powered search returning real results
- Flights: Duffel search + book + ticket, including multi-person from different cities
- Restaurants: Resy/OpenTable search + reservation
- Events: Ticket search + purchase via best available API
- Stays, transport, activities: API search + book via best available providers
- services.md catalog exists and is actively maintained with status per provider
- Payment handoff to scope 9 works — booking triggers charge triggers confirmation
- Bookings auto-log as expenses (individual or group split)
- All existing manual entry flows (add-flight, add-accommodation, add-dinner, add-transportation) still work alongside API search

## Wave Assignment

- **Wave 1:** API infrastructure (provider abstraction layer, unified response format, credential management, services.md initial catalog, Supabase edge function skeleton per category)
- **Wave 2:** Category integrations in parallel — Duffel flights (Asif), restaurants + events (Rizwan), stays + transport + activities (split)
- **Wave 3:** Multi-person flight coordination, payment handoff wiring (scope 9), edge case handling, QA validation of all flows

## Dependencies

- **[[payments-infrastructure/objective|Payments Infrastructure]] (scope 9):** Travel Booking delegates all charges to scope 9. The handoff interface (book request → payment → confirmation) must be designed jointly. Travel Booking cannot finalize bookings until scope 9 has a working Stripe integration.
- **External API Access:** Some providers (Resy, potentially Ticketmaster purchase API) require partnership agreements or API key approval. Jake needs to make calls — tracked in services.md.
- **Logistics Agent (scope 15, post-April 2):** Will be the primary consumer of Travel Booking's search/book interfaces for autonomous orchestration. Travel Booking must expose clean interfaces that scope 15 can call later.
- **[[imessage-agent/objective|iMessage Agent]] (scope 7):** Can trigger booking flows via text. Travel Booking provides the execution; iMessage Agent provides the conversational interface.
