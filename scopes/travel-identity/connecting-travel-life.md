# Connecting Travel Life to Tryps — Architecture Doc

> Author: Rizwan | Date: 2026-03-31
> Context: Jake's mission — "How are we connecting everyone's existing travel life into Tryps?"

---

## What Exists Today

### Integrated APIs (Working Code)

| API | Purpose | File | Status |
|-----|---------|------|--------|
| Duffel | Flight search + booking | `supabase/functions/_shared/duffel.ts` | Sandbox working, 293 lines |
| Amadeus | Hotel search | `supabase/functions/search-hotels/index.ts` | Free tier (500/mo) |
| AeroDataBox | Flight number lookup | `supabase/functions/lookup-flight/index.ts` | Free tier (300/mo) |
| ScrapingBee + OpenAI | Accommodation URL scraping | `supabase/functions/scrape-accommodation/index.ts` | Working (Airbnb, VRBO, Booking.com) |

### User Profile Data (Working Code)

| Field | Table | Status |
|-------|-------|--------|
| Home airport | `user_profiles.home_airport` | Shipped, UI in settings.tsx |
| Travel DNA (10 dimensions, 220+ questions) | `user_profiles.travel_dna` | Shipped, full quiz + scoring |
| Visited countries | `user_profiles.visited_countries` | Shipped |
| Preferred airline alliance | `travelProfile.ts` type only | Defined, never populated in UI |

### Agent Memory (Working Code)

| Component | Status |
|-----------|--------|
| `user_memory` table (per-user preference signals) | Migrated, 5 auto-triggers |
| `trip_memory` table (per-trip event log) | Migrated |
| `buildUserContext()` — injects memory into agent prompt | Working |
| NLP signal extraction (Claude Haiku) | Working, fire-and-forget |
| Vote-on-behalf engine | Working, inference + override |
| Recommendations engine | Working, content + collaborative + social scoring |

### What Does NOT Exist

- Loyalty number storage (no DB field, no UI)
- Connected accounts screen (no UI)
- Passport/document storage (no DB, no encryption)
- OAuth connectors (no code)
- Booking passthrough for loyalty numbers (Duffel supports it, not wired)
- Email forwarding/parsing
- Calendar sync
- Restaurant APIs (Resy/OpenTable — need partnerships)
- Ride APIs (Uber/Lyft — public APIs, not integrated)
- Activity booking APIs (Viator/GetYourGuide — not integrated)

---

## What We Build Next (Ordered)

### Phase 1: This Week — "Travel Connectors V1" (Rizwan)

**Goal:** Agent knows your travel identity and uses it when booking.

#### 1a. Database: `travel_connectors` table

```sql
CREATE TABLE travel_connectors (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  provider TEXT NOT NULL,          -- 'delta', 'united', 'american', 'marriott', 'hilton', etc.
  provider_category TEXT NOT NULL, -- 'airline', 'hotel', 'rideshare', 'rental', 'payment'
  loyalty_number TEXT,             -- encrypted at rest via Supabase vault
  loyalty_tier TEXT,               -- 'silver', 'gold', 'platinum', etc. (user-reported)
  preferences JSONB DEFAULT '{}',  -- seat_pref, cabin_class, room_type, etc.
  connected_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, provider)
);

-- RLS: users can only see/edit their own connectors
ALTER TABLE travel_connectors ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own connectors"
  ON travel_connectors FOR ALL
  USING (auth.uid() = user_id);

-- Auto-insert memory signal when connector is saved
CREATE OR REPLACE FUNCTION sync_connector_to_memory()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO user_memory (user_id, signal_type, category, key, value, weight, source)
  VALUES (
    NEW.user_id,
    'preference',
    NEW.provider_category,
    'preferred_' || NEW.provider_category,
    NEW.provider,
    0.7,
    'connector'
  )
  ON CONFLICT (user_id, category, key, source)
  DO UPDATE SET value = EXCLUDED.value, weight = EXCLUDED.weight, updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

#### 1b. Agent Context: Wire connectors into `buildUserContext()`

Update `agent-intelligence.ts` to query `travel_connectors` and include in context:

```
[USER CONTEXT: Jake]
- Likes: beaches (strong), outdoor activities (strong)
- Airlines: Delta (SkyMiles ****567, Gold, prefers aisle)
- Hotels: Marriott (Bonvoy ****890, Platinum)
- Home airport: JFK
- Engagement: Tier 3
```

#### 1c. Booking Passthrough: Wire into Duffel

Update `executeBookFlight()` to pull loyalty number from `travel_connectors` and pass to Duffel's `passengers[].loyalty_programme_accounts` field. Booked flights earn miles automatically.

**LOE:** ~200 lines. No UI dependency (Nadeem builds Connected Accounts screen later).

### Phase 2: Next Week — Email Forwarding

**Goal:** "Forward your Delta confirmation to trips@tryps.com, we'll handle the rest."

#### Architecture:
1. Set up email receiving (SendGrid Inbound Parse or AWS SES)
2. Edge function receives email → extracts body
3. Claude parses confirmation email → structured flight/hotel data
4. Auto-creates trip item (flight, hotel, etc.) linked to user
5. Sends confirmation via agent DM: "Got your Delta flight to Tokyo. Added to your March trip."

**Why email first:** No partnerships needed. No OAuth. Works with every airline, hotel, and service. TripIt proved this model works. Google Travel does it automatically from Gmail.

**LOE:** ~500 lines. 1 edge function + email infrastructure setup.

### Phase 3: Week 2-3 — Calendar Sync

**Goal:** Import travel events from Google Calendar.

1. Google Calendar OAuth (well-documented, fast approval)
2. Pull events with travel keywords or locations
3. Auto-suggest trip creation from detected travel patterns
4. Sync bidirectionally — Tryps bookings → calendar events

**LOE:** ~400 lines. Google OAuth is standard. Calendar API is clean.

### Phase 4: Post-April 2 — OAuth Connectors

For services that actually have consumer OAuth:
- Uber (ride history, request rides)
- Lyft (same)
- Airbnb (past bookings, wishlists — if approved)

Airlines and hotels do NOT have consumer OAuth. Don't plan for it.

### Phase 5: Post-April 2 — API Partnerships

Jake needs to initiate:
- Resy (restaurant reservations)
- OpenTable (restaurant reservations)
- SeatGeek or Ticketmaster (event tickets)
- Viator or GetYourGuide (activity booking)

---

## Data Flow Diagram

```
                    ┌─────────────────────────────────────┐
                    │           USER ENTRY POINTS          │
                    ├─────────────────────────────────────┤
                    │  Manual Entry     Email Forward      │
                    │  (loyalty #s,     (confirmation      │
                    │   preferences)     emails parsed)    │
                    │       │                │              │
                    │  OAuth Connect    Calendar Sync      │
                    │  (Uber, Airbnb    (Google Calendar   │
                    │   — post-V1)       travel events)    │
                    └────┬──────┬──────┬──────┬───────────┘
                         │      │      │      │
                         ▼      ▼      ▼      ▼
              ┌──────────────────────────────────────┐
              │          STORAGE LAYER                │
              ├──────────────────────────────────────┤
              │                                      │
              │  travel_connectors                   │
              │  ├── provider (delta, marriott...)   │
              │  ├── loyalty_number (encrypted)      │
              │  ├── loyalty_tier                    │
              │  └── preferences (JSONB)             │
              │                                      │
              │  user_memory (auto-populated)        │
              │  ├── preference signals              │
              │  ├── behavioral signals              │
              │  └── correction signals              │
              │                                      │
              │  user_profiles                       │
              │  ├── home_airport                    │
              │  ├── travel_dna                      │
              │  └── visited_countries               │
              │                                      │
              │  travel_documents (future)           │
              │  ├── passport (encrypted)            │
              │  └── known_traveler_number           │
              │                                      │
              └──────────────┬───────────────────────┘
                             │
                             ▼
              ┌──────────────────────────────────────┐
              │       AGENT CONTEXT ASSEMBLY          │
              │       buildUserContext()               │
              ├──────────────────────────────────────┤
              │                                      │
              │  [USER CONTEXT: Jake]                │
              │  - Likes: beaches, adventure         │
              │  - Airlines: Delta (Gold, aisle)     │
              │  - Hotels: Marriott (Platinum)       │
              │  - Home: JFK                         │
              │  - Tier: 3                           │
              │                                      │
              └──────────────┬───────────────────────┘
                             │
                 ┌───────────┼───────────┐
                 ▼           ▼           ▼
          ┌──────────┐ ┌──────────┐ ┌──────────────┐
          │ iMessage  │ │ App UI   │ │ Voice Call   │
          │ Agent     │ │ Agent    │ │ Agent        │
          │ (Marty)   │ │          │ │              │
          └─────┬─────┘ └────┬─────┘ └──────┬───────┘
                │            │               │
                └────────────┼───────────────┘
                             │
                             ▼
              ┌──────────────────────────────────────┐
              │       BOOKING EXECUTION               │
              ├──────────────────────────────────────┤
              │                                      │
              │  Duffel (flights)                    │
              │  ├── search_flights()                │
              │  ├── book_flight()                   │
              │  └── passes loyalty_number           │  ← NEW
              │       to booking request             │
              │                                      │
              │  Amadeus (hotels)                    │
              │  ├── search_hotels()                 │
              │  └── (booking TBD)                   │
              │                                      │
              │  Future: Viator, SeatGeek,           │
              │  Uber, Resy                          │
              │                                      │
              └──────────────────────────────────────┘
```

---

## Key Architectural Decisions

### 1. Manual entry first, OAuth never (for airlines/hotels)
Airlines and hotels have no consumer APIs. "Connecting your Delta account" means typing your SkyMiles number. This is the right V1 and possibly the right V-forever. OAuth is only viable for Uber, Lyft, and Airbnb.

### 2. Connectors feed memory, memory feeds agent
A `travel_connectors` row auto-generates a `user_memory` signal via trigger. The agent never queries `travel_connectors` directly — it gets everything through the unified `buildUserContext()` pipeline. One brain, one context assembly path.

### 3. Email parsing is the highest-leverage "connector"
Forwarding a confirmation email covers every airline, hotel, and service without any partnership. It's the TripIt model and it works. Build this before any OAuth flow.

### 4. Booking passthrough is the killer feature
The moment a user's SkyMiles number gets automatically applied to a Duffel booking and they earn miles — that's the "holy shit, Tryps knows me" moment. This is 10 lines of code on top of the existing booking flow.

### 5. Privacy: connectors are user-scoped, never shared
RLS policies ensure loyalty numbers and preferences are invisible to trip-mates. The People tab shows a Delta logo badge (SC-45) but never the SkyMiles number. Group bookings pass each person's loyalty number server-side — the booker never sees them.

### 6. "Be the booking layer" AND "connect existing accounts"
Not either/or. Book through Tryps = data is already there. Import from elsewhere = email forwarding + manual entry. Both paths feed the same memory and context system.

---

## Provider Feasibility Matrix

| Provider | Category | Public API | Auth Method | V1 Approach | Partnership Needed |
|----------|----------|-----------|-------------|-------------|-------------------|
| Duffel | Flights | Yes | API key | **Integrated** | No |
| Amadeus | Hotels | Yes | OAuth client creds | **Integrated** | No |
| AeroDataBox | Flight lookup | Yes | API key | **Integrated** | No |
| ScrapingBee | Accommodation scraping | Yes | API key | **Integrated** | No |
| Delta/United/AA | Airlines | No | N/A | Manual loyalty # | No |
| Marriott/Hilton | Hotels | No | N/A | Manual loyalty # | No |
| Uber | Rideshare | Yes | OAuth | Phase 4 | Developer approval |
| Lyft | Rideshare | Yes | OAuth | Phase 4 | Developer approval |
| Airbnb | Vacation rental | Restricted | OAuth (partner) | URL scraping now | Yes (for API) |
| Resy | Restaurants | Invite-only | API key | Jake call needed | Yes |
| OpenTable | Restaurants | Partner | API key | Jake call needed | Yes |
| SeatGeek | Events/tickets | Yes | API key | Phase 3-4 | No |
| Ticketmaster | Events/tickets | Yes | API key | Phase 3-4 | No |
| Viator | Activities | Yes (affiliate) | API key | Phase 3-4 | Affiliate signup |
| Google Calendar | Calendar | Yes | OAuth | Phase 3 | No |
