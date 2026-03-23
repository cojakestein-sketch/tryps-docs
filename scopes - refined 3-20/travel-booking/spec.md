---
id: travel-booking
title: "Travel Booking"
status: specced
assignee: asif, rizwan
wave: 1
dependencies: [payments-infrastructure]
clickup_ids: ["86e06y10g"]
criteria_count: 58
criteria_done: 0
last_updated: 2026-03-23
links:
  design: ./design.md
  testing: ./testing.md
  objective: ./objective.md
  state: ./state.md
  services: ./services.md
---

# Travel Booking — Spec

## What

The API service layer for searching, sourcing, and booking flights, stays, restaurants, events/tickets, transportation, and activities. Exposes unified search(), book(), and cancel() interfaces per category. Connects to external providers (Duffel, Resy, OpenTable, ticket APIs, Uber/Lyft, Viator/GetYourGuide), returns standardized results, and executes bookings — delegating payment to Payments Infrastructure (scope 9).

## Why

Tryps is a travel agent, not a planning tool. The promise is: say what you want and it gets booked. Travel Booking is the execution layer that makes that real — the actual API integrations that turn "find Blake a flight from Newport Beach to NYC" into a ticket in his email.

## Intent

> "The whole notion of the app is that you can just plan and book anything related to your trip via natural language and iMessage, and it'll basically just charge your credit card. I can quite literally say, 'I just got off the phone call with my friend Blake.' Blake wants to come to New York and he wants to hit a Yankees game. What we should do is plan the entire trip end-to-end. We can find Blake a flight from Newport Beach to New York City, book the flight, recommend the Yankees game happening that weekend, and ultimately buy tickets. That's what Travel Booking is."

## Key Concepts

**Service Layer Pattern:** Travel Booking is infrastructure. It exposes search/book/cancel per category. The app UI, iMessage Agent (scope 7), and Logistics Agent (scope 15) are all consumers. Provider-agnostic interfaces — swap or add providers without changing calling code.

**Six Booking Categories:** Flights, stays, restaurants, events/tickets, transportation, activities. Each has at least one API provider. Some have multiple with automatic fallback.

**Multi-Person Flight Coordination:** Search flights for N people from different origin cities, returning options that land within a configurable window (default 90 minutes). This is the "holy shit" moment from the strategy intake.

**services.md Catalog:** A living document in the scope folder cataloging every external API: name, category, what it does, pricing/free tier, auth method, integration status, and action owner (dev vs. Jake). Devs maintain it. Jake reviews it and acts on partnership items.

**Payment Delegation:** Travel Booking never handles money. It sends a book request to Payments Infrastructure (scope 9), receives a payment confirmation, then finalizes the booking with the provider. The exact wiring (Duffel handles payment directly vs. Stripe via scope 9) is a dev decision — the spec just says it works.

**Provider Abstraction:** Every search() returns the same shape: `{ results: [], provider: string, query: object }`. Every book() returns: `{ confirmation: object, provider: string, expense: object }`. Consumers never see raw API responses.

---

## Success Criteria

### Flight Search & Booking

- [ ] **SC-1.** Search flights via Duffel API with origin airport, destination airport, departure date, return date (optional), number of passengers. Returns 5+ results ranked by price. Verified by: call flight search with JFK → LAX, March 30, 1 passenger → receive 5+ real flight options with airline, flight number, times, duration, stops, price.

- [ ] **SC-2.** Each flight result includes: airline name, flight number, departure/arrival airports, departure/arrival times, total duration, number of stops (with layover airports if connecting), price per person, baggage allowance, and a deep link to the airline's site. Verified by: inspect a search result → all listed fields are present and populated with real data → no placeholder values.

- [ ] **SC-3.** Multi-person group flight search: given N participants with different home airports and a shared destination, return compatible flight sets where all participants land within a configurable window (default 90 minutes). Verified by: search for 3 passengers from JFK, ORD, and DEN all flying to MIA → results grouped into "sets" where all 3 land within 90 minutes of each other → each set shows individual flights + combined group price.

- [ ] **SC-4.** Select a flight → booking initiated → payment delegated to scope 9 → on payment confirmation, Duffel booking finalized → PNR and confirmation number returned. Verified by: select a flight from search results → confirm booking → payment succeeds → receive booking confirmation with PNR, airline confirmation number, and e-ticket number → booking status shows "confirmed."

- [ ] **SC-5.** Booked flight automatically appears in the trip itinerary with all details (airline, times, airports, confirmation number) and in the participant's personal flight list. Verified by: book a flight → open trip → flight visible in itinerary on the correct date → open participant profile → flight listed under their trips.

- [ ] **SC-6.** Booked flight automatically creates an expense entry. Individual booking = personal expense (not split). Group booking (one person pays for multiple) = group expense split equally among passengers. Verified by: Jake books a flight for Jake, Sarah, and Tom → expense created for the total amount → split 3 ways → each person's balance updated.

- [ ] **SC-7.** Round-trip flight search: when return date is provided, search returns outbound + return flight pairs. Verified by: search JFK → LAX departing March 30, returning April 3 → results show paired outbound and return flights with combined pricing.

### Stay Search & Booking

- [ ] **SC-8.** Search stays via API with destination (city or area), check-in date, check-out date, number of guests, and optional budget range. Returns 5+ results. Verified by: search for stays in Miami, April 1-5, 4 guests → receive 5+ real listings with name, nightly price, total price, and photos.

- [ ] **SC-9.** Each stay result includes: property name, address, nightly price, total price, number of bedrooms/bathrooms, guest capacity, at least 1 photo, rating/reviews if available, amenities list, cancellation policy summary, and source (which provider). Verified by: inspect a stay result → all listed fields present → photos render correctly.

- [ ] **SC-10.** Multi-provider search when available: query multiple stay providers → deduplicate listings that appear on multiple platforms → return unified results sorted by relevance. Verified by: search returns results from 2+ providers (indicated by source field) → no duplicate listings for the same property.

- [ ] **SC-11.** Select a stay → booking initiated → payment delegated to scope 9 → confirmation number returned. Stay auto-populates in trip itinerary with address, check-in/out dates and times, and host contact info if available. Verified by: book a stay → confirmation received → trip itinerary shows stay with full details on the correct dates.

- [ ] **SC-12.** Booked stay auto-creates an expense entry. One person books for the group = group expense split equally. Verified by: Jake books an Airbnb for 4 people → expense created → split 4 ways → balances updated.

### Restaurant Search & Booking

- [ ] **SC-13.** Search restaurants via Resy and/or OpenTable APIs with location, cuisine type (optional), party size, date, time, and price range (optional). Returns 5+ results with available reservation times. Verified by: search for Italian restaurants in Midtown NYC, party of 4, Friday 7pm → receive 5+ options with at least one available time slot each.

- [ ] **SC-14.** Each restaurant result includes: name, cuisine type, price range ($/$$/$$$/$$$), rating, address, available reservation time slots for the requested date, at least 1 photo if available, and source (Resy or OpenTable). Verified by: inspect a result → all fields present → time slots are real and bookable.

- [ ] **SC-15.** Select a restaurant + time slot → reservation made via API → confirmation returned with reservation ID, restaurant name, date, time, party size, and any special instructions field. Verified by: select a restaurant and 7:30pm slot → reservation confirmed → confirmation includes all details → reservation visible on Resy/OpenTable.

- [ ] **SC-16.** Reservation auto-populates in trip itinerary on the correct date/time. Verified by: make a reservation → open trip → restaurant appears in itinerary with time, party size, and address.

- [ ] **SC-17.** If a restaurant requires a credit card hold for the reservation, the hold is communicated to the user before confirmation and delegated to scope 9 for processing. Verified by: select a restaurant that requires card hold → user sees "this reservation requires a card hold of $X per person" → user confirms → hold processed via scope 9 → reservation confirmed.

### Event & Ticket Search & Booking

- [ ] **SC-18.** Search events near the trip destination during the trip date range. Accepts: location, date range, category (sports, concerts, comedy, theater, festivals — optional), and keyword (optional). Returns 5+ results. Verified by: search for events in NYC, March 28-31, category "sports" → receive 5+ events including real games/matches.

- [ ] **SC-19.** Each event result includes: event name, artist/team/performer, venue name and address, date and time, price range (min-max), availability status, ticket source, and event category. Verified by: inspect a result → all fields present → prices reflect real market pricing.

- [ ] **SC-20.** Select an event → select quantity → ticket purchase initiated → payment delegated to scope 9 → ticket confirmation returned with confirmation number, seat info (if applicable), and delivery method (digital/email). Verified by: select a Yankees game → buy 2 tickets → payment succeeds → confirmation includes seat section/row or general admission designation → ticket delivery confirmed.

- [ ] **SC-21.** Purchased tickets auto-populate in trip itinerary on the event date with venue, time, and ticket count. Auto-creates expense (individual or group split). Verified by: buy 4 Yankees tickets (Jake pays for group) → event in itinerary → expense split 4 ways.

### Transportation Search & Booking

- [ ] **SC-22.** Search rides via Uber and/or Lyft APIs with pickup location, dropoff location, date/time (for scheduling), and number of passengers. Returns available ride options. Verified by: search for ride from JFK to Manhattan hotel, 4 passengers → receive options with ride types and estimated prices.

- [ ] **SC-23.** Each ride result includes: ride type (UberX, UberXL, Uber Black, Lyft, Lyft XL, etc.), estimated price (range), estimated duration, estimated pickup ETA (for immediate rides), vehicle capacity, and provider. Verified by: inspect results → all fields present → prices are current estimates.

- [ ] **SC-24.** Select a ride → booking initiated → payment handled per provider's flow → confirmation returned with driver info (when assigned), pickup time, and tracking link. Verified by: book an UberXL → confirmation received → ride appears in trip itinerary.

- [ ] **SC-25.** Booked ride auto-populates in trip itinerary with pickup/dropoff locations, time, and ride type. Auto-creates expense. Verified by: book ride → itinerary shows ride on correct date/time → expense logged.

### Activity & Experience Search & Booking

- [ ] **SC-26.** Search activities with destination, date range, category (outdoor, cultural, nightlife, food tours, water sports, sightseeing, etc.), and optional budget. Returns 5+ results. Verified by: search for activities in Bali, April 1-5, category "outdoor" → receive 5+ real activities with pricing.

- [ ] **SC-27.** Each activity result includes: name, description (under 100 words), duration, price per person, rating, number of reviews, availability for requested dates, at least 1 photo, provider source, and cancellation policy summary. Verified by: inspect a result → all fields present → photos load → price is per person.

- [ ] **SC-28.** Select an activity → select date + number of participants → booking initiated → payment delegated to scope 9 → confirmation returned with booking reference, meeting point or pickup location, and any requirements (what to bring, dress code, etc.). Verified by: book a volcano hike for 4 people → confirmation includes meeting point and "wear hiking shoes" → activity in itinerary.

- [ ] **SC-29.** Booked activity auto-populates in trip itinerary on the correct date with time, duration, location, and booking reference. Auto-creates expense. Verified by: book activity → itinerary shows it → expense logged and split among participants.

### API Infrastructure & Services Catalog

- [ ] **SC-30.** A `services.md` file exists in the scope folder cataloging every external API: name, category, what it does, pricing/free tier limits, auth method, integration status (integrated | in-progress | investigating | needs-partnership), rate limits, and action owner (dev name or "Jake — needs call"). Verified by: open services.md → every API the scope uses is listed → each entry has all required fields → no TBDs on integrated services.

- [ ] **SC-31.** All API credentials are stored as Supabase environment variables. Zero credentials exist in client-side code, committed files, or hardcoded strings. Verified by: grep entire codebase for API key patterns → zero matches outside of .env files and Supabase config → all edge functions read credentials via `Deno.env.get()`.

- [ ] **SC-32.** Every external API call goes through a Supabase edge function. The mobile client never calls external APIs directly. Verified by: code review of all booking-related network calls from the app → all route through Supabase functions, none hit external domains directly.

- [ ] **SC-33.** Unified response format: every search() function returns `{ results: Array<CategoryResult>, provider: string, query: object, timestamp: string }`. Every book() function returns `{ confirmation: object, provider: string, expense: object | null, status: "confirmed" | "pending" | "failed" }`. Verified by: call search and book for 3 different categories → response shapes match the spec'd format → no raw provider responses leak through.

- [ ] **SC-34.** Rate limiting: each API integration tracks call volume against provider limits. When approaching limits (80%+ consumed), queues requests instead of failing. When limits are hit, returns a clear "rate limited, retry in X seconds" response — never a raw error. Verified by: simulate high-volume search requests → observe queuing behavior → no 429 errors reach the client.

- [ ] **SC-35.** Fallback providers: when a primary provider fails or times out (>10 seconds), the system automatically tries a backup provider if one is configured in services.md. Verified by: simulate Duffel API down → flight search automatically retries with backup provider (if configured) → results still return → response includes `provider: "backup-provider-name"`.

- [ ] **SC-36.** Provider abstraction: each booking category (flights, stays, restaurants, events, transport, activities) has a unified interface defined as a TypeScript type. Adding a new provider means implementing the interface — no changes to consuming code. Verified by: code review → each category has a defined interface type → each provider implements it → consuming code references only the interface, never provider-specific types.

### Payment Handoff Interface

- [ ] **SC-37.** Travel Booking exposes a `bookWithPayment()` function per category that: (1) validates the selected option is still available with the provider, (2) sends a payment request to scope 9 with amount, currency, description, and payer info, (3) on payment success, finalizes the booking with the provider, (4) returns the combined booking + payment confirmation. Verified by: trace a flight booking end-to-end → availability check → payment request sent → payment confirmed → Duffel booking finalized → confirmation returned → all steps logged.

- [ ] **SC-38.** Failed payment: Travel Booking attempts to hold the reservation with the provider for up to 5 minutes. If scope 9 retries and succeeds within the window, booking finalizes. If payment ultimately fails, reservation is released and the user is notified with a clear message (not a raw error). Verified by: simulate payment failure → reservation held → retry succeeds within 5 min → booking confirmed. Simulate permanent failure → reservation released → user sees "payment failed, your reservation has been released."

- [ ] **SC-39.** Every successful booking auto-creates an expense entry via the trip's expense system. Rules: (1) individual booking for yourself = personal expense, not split. (2) One person books for N people = group expense, split equally among those N people. (3) The expense description includes the booking type and key details (e.g., "Flight: JFK→LAX, Mar 30"). Verified by: Jake books a flight for Jake, Sarah, Tom → expense created → description says "Flight: JFK→MIA, Mar 30" → amount split 3 ways → each person's balance reflects their share.

- [ ] **SC-40.** Booking confirmation data (confirmation number, provider reference, receipt URL) is stored on the trip item and accessible from the trip itinerary. Verified by: book a stay → open the stay in the trip → confirmation number, provider booking reference, and receipt/invoice link are all visible.

### Multi-Person Flight Coordination

- [ ] **SC-41.** The group flight search accepts: destination airport, list of participants with their home airports, travel date(s), and an optional arrival window (default 90 minutes). Verified by: API call with destination MIA, 3 participants (JFK, ORD, DEN), date March 30 → call succeeds → parameters correctly passed to search.

- [ ] **SC-42.** Results are grouped into "flight sets" — each set contains one flight per participant, all landing within the arrival window. Sets are ranked by total group price. Verified by: group search returns 3+ sets → each set has exactly 3 flights (one per participant) → within each set, all arrival times are within 90 minutes → sets ordered cheapest first.

- [ ] **SC-43.** Each participant can independently confirm or decline their flight within a set. Partial confirmation is supported — confirmed participants get booked, declined participants can pick from remaining sets or search individually. Verified by: 3-person set presented → Jake and Sarah confirm → Tom declines → Jake and Sarah's flights booked → Tom sees remaining options.

### Edge Cases & Error States

- [ ] **SC-44.** API timeout: if a provider doesn't respond within 10 seconds, return results from other providers (if multi-provider category) or a clear "search timed out, please try again" message. Never hang indefinitely. Verified by: simulate provider timeout → response returns within 12 seconds → includes partial results or timeout message.

- [ ] **SC-45.** Option unavailable at booking time: user selects an option that sold out or is no longer available between search and booking. Travel Booking returns a clear message and offers to refresh results. Verified by: select a flight → simulate it selling out → user sees "this flight is no longer available" → prompted to "search again" → new results load.

- [ ] **SC-46.** Price change between search and booking: provider returns a different price at booking time than was shown in search results. Travel Booking shows the delta ("Price changed from $450 to $490") and requires re-confirmation. Verified by: select a flight at $450 → price is $490 at booking → user sees the delta → must confirm or pick another.

- [ ] **SC-47.** Duplicate booking prevention: if a booking for the same provider, same category, and overlapping dates already exists on the trip, warn the user before proceeding. Verified by: trip has a flight JFK→MIA on March 30 → attempt to book another JFK→MIA on March 30 → warning shown "You already have a flight to MIA on March 30. Book anyway?"

- [ ] **SC-48.** API credential failure: if a provider returns an auth error (401/403), log the error for devs with the provider name and timestamp, and return a user-friendly message ("Flight search is temporarily unavailable"). Never expose raw API errors, auth tokens, or credential details. Verified by: simulate expired API key → user sees friendly error → dev logs contain provider name + error code → no credentials in logs or UI.

- [ ] **SC-49.** Cancellation support: for categories where the provider supports cancellation, Travel Booking exposes a cancel() function that cancels the booking, confirms the cancellation, and updates the trip itinerary and expense entry accordingly. Verified by: cancel a restaurant reservation → provider confirms cancellation → reservation removed from itinerary → associated expense deleted or marked void.

### Should NOT Happen

- [ ] **SC-50.** Travel Booking NEVER initiates a payment or charges a card directly. All payment flows are delegated to Payments Infrastructure (scope 9). Verified by: code review → no Stripe calls, no card handling, no payment processing in Travel Booking code → all payment interactions go through the scope 9 interface.

- [ ] **SC-51.** Travel Booking NEVER makes autonomous booking decisions. It returns options and waits for explicit user confirmation before executing any booking. Autonomous orchestration (agent picks the best option) is scope 15 (Logistics Agent). Verified by: trigger a search → results returned → no booking executes until user explicitly confirms → no "auto-book" logic in scope 10 code.

- [ ] **SC-52.** Travel Booking NEVER exposes raw API responses to the user. All responses go through the provider abstraction layer and return in the unified format. Verified by: trigger errors and edge cases across all 6 categories → no raw JSON, no provider-specific error codes, no stack traces reach the UI.

- [ ] **SC-53.** Travel Booking NEVER stores payment credentials (card numbers, CVVs, tokens). That is Stripe/scope 9 territory. Verified by: grep Travel Booking code for card-related fields → zero matches.

### Existing Flow Preservation

- [ ] **SC-54.** Manual flight entry via add-flight.tsx continues to work. Users can still manually enter flight details or look up flights by flight number via AeroDataBox. API-powered search is additive, not a replacement. Verified by: open add-flight → manually enter a flight → saves correctly → look up by flight number → AeroDataBox returns details → flight saved to trip.

- [ ] **SC-55.** URL paste and AI scrape for accommodations via add-accommodation.tsx continues to work alongside API-powered stay search. Verified by: paste an Airbnb URL into add-accommodation → ScrapingBee + OpenAI extract details → accommodation saved to trip with correct price, beds, baths.

- [ ] **SC-56.** Manual restaurant entry via add-dinner.tsx continues to work alongside API-powered restaurant search. Verified by: open add-dinner → manually enter restaurant name, time, party size → saves correctly.

- [ ] **SC-57.** Manual transportation entry via add-transportation.tsx continues to work alongside API-powered ride search. Verified by: open add-transportation → manually enter vehicle type, pickup/dropoff, time → saves correctly.

- [ ] **SC-58.** URL paste and generic scrape for restaurants and transportation continue to work. Verified by: paste an OpenTable URL into add-dinner → details extracted → restaurant saved.

---

## Out of Scope

- **Logistics Agent orchestration** (scope 15): autonomous research, ranking by group preferences, presenting recommendations, booking after group approval. Travel Booking provides the search/book APIs that scope 15 calls. Travel Booking returns results — it does not rank them by vibe or make autonomous decisions.
- **Payment processing** (scope 9): Stripe integration, card-on-file, trust ramp, charging cards. Travel Booking delegates to scope 9 for all payment flows.
- **Trip card display** (scope 2): how booked items appear in the trip card UI. Travel Booking writes the data; scope 2 displays it.
- **iMessage conversation handling** (scope 7): parsing "book us flights to Vegas" from a text message. The iMessage Agent handles the NL understanding and calls Travel Booking's search/book interfaces.
- **Agent Intelligence ranking** (scope 8): personalized ranking of search results based on travel DNA, group vibe, or past preferences. Travel Booking returns raw results; scope 8/15 ranks them.
- **Expense tracking logic** (scope 2): how expenses are displayed, settled, or split in custom ways. Travel Booking creates the expense entry; scope 2 handles the rest.

## Regression Risk

| Area | Why | Risk |
|------|-----|------|
| Manual entry flows | API search must coexist with manual add screens | High |
| URL scrape pipeline | ScrapingBee + OpenAI flow must not break when API search is added | Medium |
| Trip itinerary | Booked items write to same data model as manually added items | High |
| Expense ledger | Auto-created expenses from bookings use same ledger as manual expenses | High |
| Flight lookup (AeroDataBox) | Existing flight number lookup must continue working alongside Duffel search | Medium |

## Dependencies

| Scope | What's Needed | Blocks |
|-------|--------------|--------|
| payments-infrastructure (#9) | Stripe card-on-file and payment processing | SC-4, SC-11, SC-15, SC-17, SC-20, SC-24, SC-28, SC-37-40 (all booking finalization) |
| logistics-agent (#15) | Will consume Travel Booking's search/book interfaces for autonomous orchestration. Travel Booking must expose clean interfaces. | Does not block scope 10 work, but scope 15 depends on scope 10 being functional. |
| imessage-agent (#7) | Will trigger search/book via text. Travel Booking must be callable from the iMessage backend. | Does not block scope 10 work. |
| External API providers | Resy, OpenTable may require partnership agreements. Event ticket APIs may require approval. | SC-13-17 (restaurants), SC-18-21 (events). Tracked in services.md. |

## References

- Deprecated spec: `scopes - deprecated/p3/duffel-apis/spec.md` (intent + key areas, no criteria — Duffel flights, Amadeus backup, restaurant/activity/hotel APIs, credential management)
- Deprecated spec: `scopes - deprecated/p3/logistics-agent/spec.md` (26 criteria — the orchestration side, now scope 15. Travel Booking provides the underlying APIs.)
- Strategy intake: `docs/p2-p3-strategy-intake.md` (Q2: "holy shit" moment — booking flights for everyone landing within 90 min. Q3: if only ship one thing, "ability to book flights and Airbnbs with natural language." Q11-Q18: payments & booking vision.)
- Services catalog: `scopes - refined 3-20/travel-booking/services.md`
