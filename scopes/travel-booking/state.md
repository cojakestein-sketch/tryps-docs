---
id: travel-booking
status: in-progress
assignee: asif, rizwan
clickup_ids: ["86e06y10g", "86e0emu70"]
criteria: 5/70
blockers:
  - "Payments Infrastructure (scope 9) — payment handoff interface needed for booking finalization"
  - "API partnerships (Resy, OpenTable, etc.) — devs pursuing organically, will escalate to Jake if blocked"
last_updated: 2026-03-31
updated_by: rizwan
review_status: reviewed
---

> Parent: [[travel-booking/objective|Travel Booking Objective]]

## Current State

5 of 58 SC ready for QA as of 2026-03-31. Duffel flight search and booking integrated into iMessage agent and standalone demo. Booked flights write to the `flights` table with full structured data (airline, flight number, airports, times, price, PNR, booking status) and show up in the app's Overview Flights card.

**SCs ready (~5):**
- SC-1: Flight search via Duffel API — origin, destination, date, passengers, returns 5+ results ranked by price
- SC-2 (partial): Results include airline, flight number, airports, times, duration, stops, price. Missing: baggage allowance, deep link to airline site
- SC-5: Booked flight auto-appears in trip itinerary via `flights` table with all details
- SC-31: API credentials stored as Supabase secrets, read via `Deno.env.get()`
- SC-32: All Duffel calls go through `_shared/duffel.ts` edge function, never from client

**What was built (2026-03-31):**
- `_shared/duffel.ts` — Duffel API client (search + book + city-to-IATA mapping)
- `search_flights` + `book_flight` tools added to iMessage agent (tools.ts, tool-executor.ts)
- System prompt updated with flight booking capabilities (capabilities.ts)
- Agent demo chat UI at `agent-demo/app/flight-booking/` with live Duffel integration
- Duffel marked as **integrated** in services.md
- `linq-worker` deployed with flight booking support

**What's NOT done:**
- SC-3: Multi-person group flight search
- SC-4, SC-37-40: Payment delegation to scope 9 (Stripe not wired)
- SC-6: Auto-expense creation from bookings
- SC-7: Round-trip flight search
- SC-8-29: Stays, restaurants, events, transport, activities — no API integrations yet
- SC-33-36: Unified response format, rate limiting, fallback providers, provider abstraction
- SC-41-58: Multi-person coordination, edge cases, existing flow preservation

## What's Next

1. **Immediately:** Get Duffel secret deployed to production (pending senior access). Test end-to-end via iMessage.
2. **This week:** Complete SC-2 (baggage, deep links), SC-6 (auto-expense), SC-7 (round-trip search)
3. **Wave 2:** Stay search (evaluate Amadeus vs Duffel Stays vs Booking.com), restaurant APIs
4. **Wave 3:** Multi-person flight coordination, payment handoff with scope 9, edge cases, QA

## Open Questions

- Which event ticket API is primary? Dev investigation needed (SeatGeek, Ticketmaster, StubHub).
- Amadeus hotel search — use it as stay provider or not? Edge function exists but needs evaluation.
- Exact payment handoff interface with scope 9 — needs joint design session between Travel Booking and Payments Infrastructure devs.
- Uber/Lyft API access — do we have business accounts or need to apply?
