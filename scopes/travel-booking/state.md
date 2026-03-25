---
id: travel-booking
status: specced
assignee: asif, rizwan
clickup_ids: ["86e06y10g"]
criteria: 0/58
blockers:
  - "Payments Infrastructure (scope 9) — payment handoff interface needed for booking finalization"
  - "API partnerships (Resy, OpenTable, etc.) — devs pursuing organically, will escalate to Jake if blocked"
last_updated: 2026-03-23
updated_by: jake
review_status: reviewed
---

> Parent: [[travel-booking/objective|Travel Booking Objective]]

## Current State

Spec session complete (2026-03-23). 58 success criteria across 6 booking categories (flights, stays, restaurants, events, transportation, activities), API infrastructure, payment handoff, multi-person coordination, edge cases, and existing flow preservation.

What exists today: manual entry forms + URL scraping for flights, accommodations, restaurants, and transportation. AeroDataBox flight number lookup working. Amadeus hotel search edge function exists but is not wired to UI. No API-powered search or booking for any category.

## What's Next

1. **Immediately:** Asif + Rizwan start on Wave 1 (API infrastructure — provider abstraction layer, unified response format, edge function skeleton, services.md investigation)
2. **Devs pursue all API partnerships organically** — apply for access, sign up for programs, test sandboxes. Only escalate to Jake if blocked (tracked in services.md escalation queue)
3. **Wave 2:** Category integrations in parallel (Duffel flights, restaurant APIs, event APIs, stay APIs, transport APIs, activity APIs)
4. **Wave 3:** Multi-person flight coordination, payment handoff wiring with scope 9, edge cases, QA

## Open Questions

- Which event ticket API is primary? Dev investigation needed (SeatGeek, Ticketmaster, StubHub).
- Amadeus hotel search — use it as stay provider or not? Edge function exists but needs evaluation.
- Exact payment handoff interface with scope 9 — needs joint design session between Travel Booking and Payments Infrastructure devs.
- Uber/Lyft API access — do we have business accounts or need to apply?
