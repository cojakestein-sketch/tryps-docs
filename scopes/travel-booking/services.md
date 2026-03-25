---
id: travel-booking-services
title: "Travel Booking — Services Catalog"
maintained_by: dev
reviewed_by: jake
last_updated: 2026-03-23
---

# Travel Booking — Services Catalog

> **Purpose:** Every external API that Travel Booking integrates with. Devs maintain this as they investigate and integrate. Jake reviews and acts on partnership items.
>
> **Status key:** integrated | in-progress | investigating | needs-partnership | blocked | rejected

---

## Flights

| Service | What It Does | Pricing / Free Tier | Auth | Status | Action Owner | Notes |
|---------|-------------|---------------------|------|--------|-------------|-------|
| **Duffel** | Flight search + book + ticket for 300+ airlines | Pay-per-booking (commission on ticket price) | API key (OAuth 2.0) | investigating | Dev | Primary flight provider. Supports search, booking, ticketing, seat selection, baggage. Sandbox available for testing. |
| **Amadeus** | Flight search (backup), hotel search | 500 free calls/month (self-service), paid tiers | API key + secret | investigating | Dev | Already have credentials in Supabase env. `search-hotels` edge function exists but unused. Evaluate as flight backup. |
| **AeroDataBox** | Flight number lookup (existing) | 300 free calls/month (RapidAPI) | RapidAPI key | **integrated** | — | Already working in add-flight.tsx. Lookup by flight number + date. Keep as utility alongside Duffel search. |

## Stays

| Service | What It Does | Pricing / Free Tier | Auth | Status | Action Owner | Notes |
|---------|-------------|---------------------|------|--------|-------------|-------|
| **Duffel Stays** | Hotel/accommodation search + book | TBD (part of Duffel platform) | API key | investigating | Dev | If we use Duffel for flights, evaluate stays add-on. |
| **Booking.com** | Hotel/accommodation search + book | Affiliate program (commission) | Affiliate API key | investigating | Dev | Large inventory. Affiliate program may be easier than direct API. |
| **Airbnb API** | Vacation rental search | Limited/closed API — may need partnership | OAuth | investigating | Dev — pursue organically, escalate to Jake if blocked | Airbnb API is restricted. Devs explore access options first. Pull Jake in if founder-level outreach would help. Fallback: continue URL scrape via ScrapingBee. |
| **VRBO/Expedia** | Vacation rental search + book | Affiliate/partner API | API key | investigating | Dev | Part of Expedia Group. Evaluate availability. |
| **ScrapingBee + OpenAI** | URL paste → AI extraction (existing) | ScrapingBee: pay per credit. OpenAI: per-token. | API keys | **integrated** | — | Already working for accommodation URL scraping. Keep as fallback. |

## Restaurants

| Service | What It Does | Pricing / Free Tier | Auth | Status | Action Owner | Notes |
|---------|-------------|---------------------|------|--------|-------------|-------|
| **Resy** | Restaurant search + reservation | API may require partnership | TBD | needs-partnership | Dev — pursue organically, escalate to Jake if blocked | Semi-closed API. Devs should try to get API access on their own first. Pull Jake in only if a personal intro or founder-level outreach would help. |
| **OpenTable** | Restaurant search + reservation | Partner API available | API key | needs-partnership | Dev — pursue organically, escalate to Jake if blocked | Has a booking API but requires approval. Devs apply for partner access first. Pull Jake in if application stalls or needs escalation. |
| **Google Places** | Restaurant search (no booking) | $200 free monthly credit | API key | investigating | Dev | Could supplement Resy/OpenTable for discovery (search only, no reservations). |
| **Yelp Fusion** | Restaurant search + reviews (no booking) | 5,000 calls/day free | API key | investigating | Dev | Good for discovery and reviews. No booking capability. |

## Events & Tickets

| Service | What It Does | Pricing / Free Tier | Auth | Status | Action Owner | Notes |
|---------|-------------|---------------------|------|--------|-------------|-------|
| **Ticketmaster** | Event discovery + tickets (Discovery API free, purchase API needs partnership) | Discovery: 5,000 calls/day free. Purchase: partnership required. | API key | investigating | Dev — pursue organically, escalate to Jake if blocked | Discovery API is open. Purchase API requires Live Nation partnership. Devs start with discovery and explore purchase path. Pull Jake in if founder-level outreach needed for partnership. |
| **SeatGeek** | Event search + ticket purchase | Open API for search. Purchase via affiliate or partner. | API key | investigating | Dev | More open than Ticketmaster. Evaluate as primary ticket provider. |
| **StubHub** | Secondary market tickets | API available (may need approval) | API key | investigating | Dev | Good for sold-out events and secondary market. |
| **Vivid Seats** | Event tickets | API available | API key | investigating | Dev | Another option. Evaluate coverage and pricing. |
| **Eventbrite** | Event discovery (smaller/local events) | Free API | API key | investigating | Dev | Good for local events, festivals, classes. Not for major sports/concerts. |

## Transportation

| Service | What It Does | Pricing / Free Tier | Auth | Status | Action Owner | Notes |
|---------|-------------|---------------------|------|--------|-------------|-------|
| **Uber** | Ride search + booking | API available (requires business account) | OAuth 2.0 | investigating | Dev | Uber for Business API. Evaluate ride estimates + booking. |
| **Lyft** | Ride search + booking | API available | OAuth 2.0 | investigating | Dev | Evaluate alongside Uber. |

## Activities & Experiences

| Service | What It Does | Pricing / Free Tier | Auth | Status | Action Owner | Notes |
|---------|-------------|---------------------|------|--------|-------------|-------|
| **Viator** | Activity/tour search + book | Affiliate program (commission) | API key | investigating | Dev | Owned by TripAdvisor. Large inventory of tours and activities worldwide. Affiliate program available. |
| **GetYourGuide** | Activity/tour search + book | Partner API (commission) | API key | investigating | Dev | Good European coverage. Partner/affiliate program. |
| **Airbnb Experiences** | Unique local experiences | Closed API | — | investigating | Dev — pursue organically, escalate to Jake if blocked | May need partnership. Devs evaluate if worth pursuing vs. Viator/GYG. Pull Jake in if needed. |

## x402 / AgentCash Endpoints

| Service | What It Does | Pricing | Auth | Status | Notes |
|---------|-------------|---------|------|--------|-------|
| **stableenrich.dev** | Google Maps, web search, scraping | Pay-per-call (USDC) | x402 | investigating | Could supplement restaurant/activity discovery. Evaluate vs. direct API. |

---

## Partnership Escalation Protocol

**Default: devs pursue all API access and partnerships organically.** Apply for developer accounts, sign up for affiliate programs, explore free tiers, test sandbox environments. Only pull Jake in when:

1. An application requires a founder/CEO to sign or represent the company
2. A personal intro or relationship would meaningfully accelerate access
3. A partnership negotiation is stalled and needs founder-level outreach
4. Commercial terms need a business decision (pricing tiers, revenue share, etc.)

**When escalating to Jake:** Add a row to the table below with the service, what you tried, what's blocking, and what Jake specifically needs to do.

### Escalation Queue (empty until needed)

| # | Service | What Dev Tried | What's Blocking | What Jake Needs To Do | Priority |
|---|---------|---------------|-----------------|----------------------|----------|
| — | — | — | — | — | — |

## Dev Investigation Priorities

| # | Service | Category | Why First | Assigned |
|---|---------|----------|-----------|----------|
| 1 | Duffel | Flights | Primary flight provider — search + book + ticket | TBD |
| 2 | SeatGeek | Events | Most open ticket API — evaluate as primary | TBD |
| 3 | Viator | Activities | Largest activity inventory, affiliate model | TBD |
| 4 | Uber | Transport | Most common ride service | TBD |
| 5 | Booking.com | Stays | Large inventory, affiliate program | TBD |
| 6 | Amadeus | Flights (backup) | Already have credentials, evaluate as fallback | TBD |
