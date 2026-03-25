---
id: travel-booking
qa_assignee: andreas
test_status: not-started
criteria_total: 58
criteria_passing: 0
last_tested: null
last_updated: 2026-03-23
---

> Parent: [[travel-booking/objective|Travel Booking Objective]]

# Travel Booking — Testing Plan

## How to Test

Most tests require real API access (Duffel, Resy/OpenTable, ticket APIs, Uber/Lyft, Viator/GetYourGuide). Use sandbox/test modes where available. For booking tests that involve payment, coordinate with scope 9 (Payments Infrastructure) — use Stripe test mode. All tests run against the Supabase edge functions, never against external APIs directly.

## Flight Search & Booking (SC-1 to SC-7)

- [ ] **SC-1.** Search flights: JFK → LAX, March 30, 1 passenger → 5+ results with airline, times, price, stops
- [ ] **SC-2.** Inspect one flight result → all fields present (airline, flight number, departure/arrival airports+times, duration, stops, price per person, baggage, deep link)
- [ ] **SC-3.** Group flight search: 3 passengers from JFK, ORD, DEN → destination MIA → results grouped into sets → all arrivals within 90 min within each set → ranked by total price
- [ ] **SC-4.** Select flight → payment via scope 9 → booking confirmed → PNR + confirmation number + e-ticket returned
- [ ] **SC-5.** Booked flight appears in trip itinerary on correct date + appears in participant's flight list
- [ ] **SC-6.** Book flight for 3 people (Jake pays) → expense created → split 3 ways → balances updated
- [ ] **SC-7.** Round-trip search with return date → outbound + return pairs with combined pricing

## Stay Search & Booking (SC-8 to SC-12)

- [ ] **SC-8.** Search stays: Miami, April 1-5, 4 guests → 5+ results with name, price, photos
- [ ] **SC-9.** Inspect one stay result → all fields present (name, address, nightly+total price, bedrooms/baths, capacity, photo, rating, amenities, cancellation, source)
- [ ] **SC-10.** Multi-provider search → results from 2+ providers → no duplicate listings for same property
- [ ] **SC-11.** Book a stay → payment via scope 9 → confirmation number → stay in itinerary with address and check-in/out
- [ ] **SC-12.** Book stay for 4 people (Jake pays) → expense created → split 4 ways

## Restaurant Search & Booking (SC-13 to SC-17)

- [ ] **SC-13.** Search restaurants: Italian, Midtown NYC, 4 people, Friday 7pm → 5+ results with available time slots
- [ ] **SC-14.** Inspect one restaurant result → all fields present (name, cuisine, price range, rating, address, time slots, photo, source)
- [ ] **SC-15.** Select restaurant + 7:30pm → reservation confirmed → confirmation ID, name, time, party size → reservation visible on Resy/OpenTable
- [ ] **SC-16.** Reservation appears in trip itinerary on correct date/time
- [ ] **SC-17.** Select restaurant requiring card hold → user sees hold amount → confirms → hold processed via scope 9 → reservation confirmed

## Event & Ticket Search & Booking (SC-18 to SC-21)

- [ ] **SC-18.** Search events: NYC, March 28-31, "sports" → 5+ real events
- [ ] **SC-19.** Inspect one event result → all fields present (name, artist/team, venue+address, date/time, price range, availability, source, category)
- [ ] **SC-20.** Select event → buy 2 tickets → payment via scope 9 → confirmation with seat info + delivery method
- [ ] **SC-21.** Tickets in itinerary on event date → expense for 4 tickets split 4 ways when Jake pays for group

## Transportation Search & Booking (SC-22 to SC-25)

- [ ] **SC-22.** Search rides: JFK → Manhattan hotel, 4 passengers → ride options with types and prices
- [ ] **SC-23.** Inspect one ride result → all fields present (type, price range, duration, ETA, capacity, provider)
- [ ] **SC-24.** Book UberXL → confirmation with driver info (when assigned) + pickup time + tracking link → ride in itinerary
- [ ] **SC-25.** Booked ride in itinerary with pickup/dropoff + time → expense logged

## Activity & Experience Search & Booking (SC-26 to SC-29)

- [ ] **SC-26.** Search activities: Bali, April 1-5, "outdoor" → 5+ results with pricing
- [ ] **SC-27.** Inspect one activity result → all fields (name, description <100 words, duration, price/person, rating, reviews, availability, photo, source, cancellation)
- [ ] **SC-28.** Book volcano hike for 4 → confirmation with meeting point + requirements ("wear hiking shoes") → activity in itinerary
- [ ] **SC-29.** Booked activity in itinerary on correct date → expense logged and split among participants

## API Infrastructure & Services Catalog (SC-30 to SC-36)

- [ ] **SC-30.** services.md exists in scope folder → every API listed → all required fields populated → no TBDs on integrated services
- [ ] **SC-31.** Grep codebase for API keys → zero hardcoded credentials → all edge functions use Deno.env.get()
- [ ] **SC-32.** Code review: all external API calls go through Supabase edge functions → mobile client never calls external APIs directly
- [ ] **SC-33.** Call search + book for 3 categories → all responses match unified format → no raw provider responses leak
- [ ] **SC-34.** Simulate high-volume requests → rate limiting queues instead of failing → no 429 errors reach client
- [ ] **SC-35.** Simulate primary provider down → fallback provider returns results (if configured) → response includes backup provider name
- [ ] **SC-36.** Code review: each category has a TypeScript interface → each provider implements it → consuming code uses only the interface

## Payment Handoff Interface (SC-37 to SC-40)

- [ ] **SC-37.** Trace flight booking: availability check → payment request to scope 9 → payment confirmed → Duffel booking finalized → confirmation returned → all steps logged
- [ ] **SC-38.** Simulate payment failure → reservation held → retry within 5 min → booking confirmed. Simulate permanent failure → reservation released → user sees friendly error
- [ ] **SC-39.** Book flight for 3 people → expense created with description "Flight: JFK→MIA, Mar 30" → split 3 ways → balances correct
- [ ] **SC-40.** Book a stay → open in trip → confirmation number, provider reference, and receipt link all visible

## Multi-Person Flight Coordination (SC-41 to SC-43)

- [ ] **SC-41.** API call: destination MIA, 3 participants (JFK, ORD, DEN), March 30 → call succeeds → parameters correct
- [ ] **SC-42.** Results grouped into flight sets → each set has 3 flights → all arrivals within 90 min → sets ranked cheapest first
- [ ] **SC-43.** 3-person set → Jake + Sarah confirm → Tom declines → Jake + Sarah booked → Tom sees remaining options

## Edge Cases & Error States (SC-44 to SC-49)

- [ ] **SC-44.** Simulate provider timeout → response within 12 sec → partial results or timeout message (never hangs)
- [ ] **SC-45.** Select sold-out flight → "this flight is no longer available" → "search again" → new results load
- [ ] **SC-46.** Price changed from $450 to $490 → user sees delta → must re-confirm or pick another
- [ ] **SC-47.** Trip has flight JFK→MIA March 30 → try booking duplicate → warning shown → user can override
- [ ] **SC-48.** Simulate expired API key → user sees "temporarily unavailable" → dev logs have provider + error → no credentials in UI or logs
- [ ] **SC-49.** Cancel restaurant reservation → provider confirms → reservation removed from itinerary → expense deleted/voided

## Should NOT Happen (SC-50 to SC-53)

- [ ] **SC-50.** Code review: zero Stripe calls or card handling in Travel Booking code → all payment through scope 9
- [ ] **SC-51.** Trigger search → results returned → no booking executes until explicit user confirmation → no auto-book logic
- [ ] **SC-52.** Trigger errors across all 6 categories → no raw JSON, provider error codes, or stack traces reach UI
- [ ] **SC-53.** Grep Travel Booking code for card-related fields (card_number, cvv, card_token) → zero matches

## Existing Flow Preservation (SC-54 to SC-58)

- [ ] **SC-54.** Manual flight entry: open add-flight → enter details manually → saves → AeroDataBox lookup by flight number still works
- [ ] **SC-55.** URL paste accommodation: paste Airbnb URL → ScrapingBee + OpenAI extracts → saves with correct price/beds/baths
- [ ] **SC-56.** Manual restaurant entry: open add-dinner → enter name, time, party size → saves
- [ ] **SC-57.** Manual transport entry: open add-transportation → enter vehicle type, pickup/dropoff, time → saves
- [ ] **SC-58.** URL paste restaurant/transport: paste OpenTable URL into add-dinner → details extracted → saves

## Regression Tests

| Area | Test | Priority |
|------|------|----------|
| Manual add-flight | Enter flight manually + AeroDataBox lookup → both still save correctly | High |
| URL scrape accommodations | Paste Airbnb URL → AI extraction still works | High |
| Trip itinerary | API-booked item + manually added item coexist on same trip | High |
| Expense ledger | Auto-created expense from booking + manual expense coexist → balances correct | High |
| Flight lookup | AeroDataBox lookup still works after Duffel integration added | Medium |
| URL scrape restaurants | Paste restaurant URL → generic scrape still works | Medium |
