---
feature: Travel Life Connectors
date: 2026-03-17
status: ready
spec: spec.md
---

# P2 Scope 4: Travel Life Connectors — FRD

> **Phase:** P2: Stripe + Linq
> **Gantt ID:** `p2-connectors`
> **Spec:** `scopes/p2/connectors/spec.md`

## 1. Screens & Navigation

### 1.1 Connected Accounts Screen

**Entry point:** Profile → "Connected Accounts" row (new row in existing profile settings list).

**Layout:** Grouped list by category. Each group has a header ("Airlines," "Hotels," "Rideshare & Transport," "Vacation Rentals"). Each row shows:

| Element | Connected State | Not Connected State |
|---------|----------------|-------------------|
| Provider logo | 32×32 color logo | 32×32 grayscale logo |
| Provider name | "American Airlines" | "American Airlines" |
| Status label | Last 4 digits: "••••4567" | "Not connected" in muted text |
| Action | Chevron → edit/disconnect | "Connect" button |

**Progress indicator** at top of screen (spec **P2.S4.C08**):
- Ring or bar: "2 of 8 connected"
- Subtitle: "Connect your travel accounts to earn points when you book through Tryps"

**Supported providers at launch:**

| Category | Providers |
|----------|-----------|
| Airlines | American Airlines, Delta, United, Southwest, JetBlue, Alaska Airlines |
| Hotels | Marriott Bonvoy, Hilton Honors, IHG One Rewards, Hyatt |
| Rideshare & Transport | Uber, Lyft |
| Vacation Rentals | Airbnb |

Total: ~13 providers. Progress shows "X of 13 connected."

### 1.2 Connect Provider — Manual Entry (Airlines, Hotels)

**Trigger:** Tap a not-connected airline or hotel row.

**Sheet/modal fields:**
- Provider logo + name (read-only header)
- Loyalty number input (text field, alphanumeric, provider-specific placeholder)
  - AA: "AAdvantage number (e.g., A1B2C3D4)"
  - Delta: "SkyMiles number"
  - Marriott: "Bonvoy member number"
- "Save" button (disabled until input passes format validation)

**Validation (spec P2.S4.C05):**
- Client-side format check per provider (regex). Examples:
  - AA AAdvantage: 7–10 alphanumeric characters
  - Delta SkyMiles: 10–11 digits
  - Marriott Bonvoy: 9–12 digits
  - United MileagePlus: 2 letters + 6 digits (e.g., AB123456)
- On invalid format: inline error below field — "{Provider} numbers are usually {format hint}. Check your number and try again."
- On valid format + save: dismiss sheet, row updates to "Connected" state with masked number.

**Note:** Format validation only — we are not calling provider APIs to verify the number is active. If providers offer lookup APIs in the future, this can be enhanced.

### 1.3 Connect Provider — OAuth (Airbnb, Uber, Lyft)

**Trigger:** Tap "Connect" on Airbnb, Uber, or Lyft row.

**Flow (spec P2.S4.C04):**
1. Open provider's OAuth authorization URL in an in-app browser (WebBrowser API / `expo-web-browser`).
2. User authenticates with the provider.
3. Provider redirects back to `tripful://connectors/callback?provider={id}&code={auth_code}`.
4. App exchanges code for access token via backend edge function.
5. Store access token encrypted in Supabase (see §3 Data Model).
6. Dismiss browser, update row to "Connected."

**Error states:**
- User cancels OAuth flow → return to Connected Accounts, no change.
- OAuth callback fails (invalid code, network error) → toast: "Couldn't connect {Provider}. Try again."
- Provider revokes access externally → next app launch, background check detects revocation → row reverts to "Not connected" with toast: "Your {Provider} connection expired. Reconnect to keep earning points."

### 1.4 Edit / Disconnect Provider

**Trigger:** Tap a connected provider row → chevron opens detail sheet.

**Detail sheet contents:**
- Provider logo + name
- For manual entry providers: loyalty number field (pre-filled, editable, same validation as §1.2)
- "Save Changes" button (if number edited)
- "Disconnect" button (destructive, red text)

**Disconnect flow (spec P2.S4.C07, P2.S4.C24):**
1. Tap "Disconnect" → confirmation alert: "Disconnect {Provider}? Your {loyalty type} number will be permanently deleted."
2. Confirm → hard-delete from database (no soft delete) → row reverts to "Not connected."
3. Cancel → dismiss alert, no change.

For OAuth providers, disconnect also revokes the access token if the provider's API supports revocation.

### 1.5 Travel Documents Screen

**Entry point:** Profile → "Travel Documents" row (below "Connected Accounts").

**Biometric gate (spec P2.S4.C14):**
- Tapping "Travel Documents" triggers `expo-local-authentication` (Face ID / Touch ID / device PIN).
- Success → show documents screen.
- Failure/cancel → return to profile, documents never shown.

**Layout:**
- **Passport section:**
  - If no passport saved: "Add Passport" button with passport icon.
  - If passport saved: card showing:
    - Full legal name
    - Nationality (flag emoji + country name)
    - Passport number (masked: "••••••4567", last 4 visible)
    - Expiration date
    - Warning badge if expiration < 6 months away (spec **P2.S4.C13**)
    - "Edit" and "Delete" actions
- **Known Traveler section:**
  - If none saved: "Add Known Traveler Number" button.
  - If saved: card showing KTN (masked), "Edit" and "Delete" actions.

### 1.6 Add / Edit Passport

**Sheet fields:**
- Full legal name (as on passport) — text input, required
- Passport number — text input, required, alphanumeric
- Nationality — country picker (searchable dropdown)
- Date of birth — date picker
- Issue date — date picker
- Expiration date — date picker

**Validation:**
- All fields required.
- Expiration date must be in the future.
- Issue date must be before expiration date.
- Date of birth must be in the past.

**On save:** Encrypt all fields before writing to database (see §3).

### 1.7 People Tab — Connection Badges

**Location:** Trip → People tab → each member row (spec **P2.S4.C20**).

**Behavior:**
- After member name and avatar, show up to 3 small (20×20) provider logo badges for services the member has connected.
- If member has > 3 connections, show first 3 + "+N" overflow indicator.
- Members with no connections show no badges.
- Tapping a badge shows a tooltip: "{Name} is connected to {Provider}" — no account details (spec **P2.S4.C21**).

**Data source:** Read from `user_connectors` table, filtered to connected providers. Only connection existence is exposed — never loyalty numbers or account details (spec **P2.S4.C22, P2.S4.C23**).

## 2. API Contracts

### 2.1 User Connectors

**Table: `user_connectors`**

```
POST /rest/v1/user_connectors — upsert connector
GET  /rest/v1/user_connectors?user_id=eq.{id} — list user's connectors (own data only)
DELETE /rest/v1/user_connectors?id=eq.{id} — hard delete
```

**RLS policies:**
- SELECT: `auth.uid() = user_id` — users can only read their own connectors.
- INSERT/UPDATE: `auth.uid() = user_id`
- DELETE: `auth.uid() = user_id`

**People tab badge query** (read-only, cross-user):
- Supabase RPC `get_trip_member_connections(trip_id)` returns:
  ```json
  [
    { "user_id": "abc", "providers": ["american_airlines", "marriott"] },
    { "user_id": "def", "providers": ["delta", "airbnb"] }
  ]
  ```
- Returns only provider slugs — never loyalty numbers or tokens.
- RLS: caller must be a member of the trip.

### 2.2 Travel Documents

**Table: `user_travel_documents`**

```
POST /rest/v1/user_travel_documents — create document
GET  /rest/v1/user_travel_documents?user_id=eq.{id} — list own documents
PATCH /rest/v1/user_travel_documents?id=eq.{id} — update
DELETE /rest/v1/user_travel_documents?id=eq.{id} — hard delete
```

**RLS policies:**
- ALL operations: `auth.uid() = user_id` — no cross-user access ever.
- No RPC exposes travel documents to other users.

**Booking passthrough** (server-side only):
- Edge function `get_booking_passenger_data(user_id, provider_slug)` decrypts and returns loyalty number + passport data.
- Called only by the booking edge function during an active booking transaction.
- Never exposed to client-side API.

### 2.3 Booking Integration

**At booking time (specs P2.S4.C15–C19):**

The booking edge function (from `p2-stripe-payments` / `p3-logistics-agent`) calls:

```
get_booking_passenger_data(user_ids[], provider_slug) →
[
  {
    "user_id": "abc",
    "loyalty_number": "AA1234567",  // or null if not connected
    "passport": {                    // or null if not stored
      "legal_name": "...",
      "number": "...",
      "nationality": "...",
      "dob": "...",
      "expiration": "..."
    },
    "known_traveler_number": "..."   // or null
  }
]
```

- For group bookings, the function accepts an array of user_ids.
- Missing data returns `null` for that field — booking proceeds without it (spec **P2.S4.C19**).
- This function runs SECURITY DEFINER (exception to the SECURITY INVOKER default) because it decrypts data on behalf of the booking system, not the requesting user.

## 3. Data Model

### 3.1 `user_connectors` Table

```sql
CREATE TABLE user_connectors (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  provider_slug TEXT NOT NULL,           -- e.g., 'american_airlines', 'marriott', 'airbnb'
  provider_category TEXT NOT NULL,       -- 'airline', 'hotel', 'rideshare', 'vacation_rental'
  loyalty_number TEXT,                   -- encrypted, NULL for OAuth-only providers
  oauth_access_token TEXT,              -- encrypted, NULL for manual-entry providers
  oauth_refresh_token TEXT,             -- encrypted
  oauth_expires_at TIMESTAMPTZ,
  connected_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(user_id, provider_slug)
);
```

### 3.2 `user_travel_documents` Table

```sql
CREATE TABLE user_travel_documents (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  doc_type TEXT NOT NULL CHECK (doc_type IN ('passport', 'known_traveler')),
  -- All PII fields use pgcrypto column-level encryption
  legal_name TEXT NOT NULL,              -- encrypted
  doc_number TEXT NOT NULL,              -- encrypted
  nationality VARCHAR(2),               -- ISO 3166-1 alpha-2, encrypted
  date_of_birth DATE,                   -- encrypted
  issue_date DATE,                      -- encrypted
  expiration_date DATE,                 -- NOT encrypted (needed for expiration warning queries)
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(user_id, doc_type)
);
```

**Encryption approach:**
- Use Supabase Vault (pgsodium) for column-level encryption on PII fields.
- `expiration_date` is stored unencrypted so the app can query "expiration < now() + interval '6 months'" without decrypting.
- Decryption happens server-side only, via the `get_booking_passenger_data` edge function.
- No PII is ever sent to the client in decrypted form except to the owning user through the biometric-gated Travel Documents screen.

### 3.3 `providers` Reference Table

```sql
CREATE TABLE providers (
  slug TEXT PRIMARY KEY,                 -- 'american_airlines', 'delta', etc.
  name TEXT NOT NULL,                    -- 'American Airlines'
  category TEXT NOT NULL,                -- 'airline', 'hotel', 'rideshare', 'vacation_rental'
  logo_url TEXT NOT NULL,
  auth_type TEXT NOT NULL CHECK (auth_type IN ('manual', 'oauth')),
  loyalty_format_regex TEXT,             -- client-side validation pattern
  loyalty_format_hint TEXT,              -- "7-10 alphanumeric characters"
  oauth_base_url TEXT,                   -- NULL for manual providers
  sort_order INTEGER NOT NULL DEFAULT 0
);
```

## 4. Edge Cases

### 4.1 Multiple Connectors Same Category
A user can connect multiple airlines (AA + Delta + United). All are stored. At booking time, the system matches the provider to the booking (AA flight → AA loyalty number).

### 4.2 Provider Not in List
v1 ships with ~13 hardcoded providers. Users who use an unsupported provider cannot connect it. No "Other" or custom entry option in v1.

### 4.3 OAuth Token Expiration
For OAuth providers, if the refresh token is expired or revoked:
- Background check on app launch detects failure.
- Row shows "Reconnect" instead of "Connected."
- User taps "Reconnect" → OAuth flow restarts.

### 4.4 Passport Expiration During Trip Planning
If a user's passport expires within 6 months and they're on a trip with international flights:
- Warning on Travel Documents screen (spec **P2.S4.C13**).
- At booking time, if passport is expired or expires before trip end date, the booking edge function returns an error: "Passport expires before your trip ends. Update your passport details before booking."

### 4.5 Group Booking — Mixed Connector States
When booking for a group of 4:
- 3 have AA loyalty numbers → attached to their individual bookings.
- 1 has no AA number → that member's booking proceeds without loyalty number (spec **P2.S4.C19**).
- 2 have passports stored, 2 don't → international flight booking pauses with: "{Name} and {Name} need to add passport details before this flight can be booked."

### 4.6 Disconnect During Active Trip
User disconnects AA while on a trip with AA flights already booked:
- Existing bookings are unaffected (loyalty number was already sent at booking time).
- Future bookings for that user won't include an AA number.
- No warning or blocking — disconnect always succeeds immediately.

## 5. Security Requirements

| Requirement | Implementation |
|-------------|---------------|
| Encryption at rest (spec **P2.S4.C11**) | Supabase Vault (pgsodium) column-level encryption on all PII columns |
| Access control (spec **P2.S4.C12**) | RLS policies: `auth.uid() = user_id` on all tables. No cross-user queries except provider slugs via RPC. |
| Biometric gate (spec **P2.S4.C14**) | `expo-local-authentication` required before Travel Documents screen renders |
| Hard delete (spec **P2.S4.C24**) | No soft-delete columns. `DELETE` removes the row. No audit trail of deleted PII. |
| API surface (spec **P2.S4.C23**) | Trip member API returns only `{ user_id, providers[] }` — never loyalty numbers or document data |
| Booking decryption | Server-side only via SECURITY DEFINER edge function, never client-side |

## 6. Dependencies

| This scope needs | From scope | What |
|-----------------|------------|------|
| Card on file / payment | `p2-stripe-payments` | Bookings that consume loyalty data require payment processing |
| Booking APIs | `p3-duffel-apis` | Duffel, hotel APIs accept loyalty numbers as booking parameters |
| Agent booking flow | `p3-logistics-agent` | Agent calls `get_booking_passenger_data` when booking on behalf of group |

| Other scopes need | From this scope | What |
|-------------------|----------------|------|
| Loyalty passthrough | `p2-stripe-payments` C04 | "booking agent applies stored travel preferences" |
| Pre-filled booking links | `p2-booking-links` | Links carry loyalty numbers and travel profile data |
| Passenger data at booking | `p3-logistics-agent` | Agent reads connector + passport data during booking |

## 7. Criterion ID Index

All criterion IDs from the spec, preserved verbatim:

| ID | Summary |
|----|---------|
| P2.S4.C01 | Connected Accounts screen accessible from profile |
| P2.S4.C02 | Connect airline loyalty account (manual entry) |
| P2.S4.C03 | Connect hotel rewards account (manual entry) |
| P2.S4.C04 | OAuth connection for Airbnb, Uber, Lyft |
| P2.S4.C05 | Loyalty number format validation |
| P2.S4.C06 | Connections persist across all trips (profile-level) |
| P2.S4.C07 | Disconnect permanently deletes stored data |
| P2.S4.C08 | Progress indicator encouraging more connections |
| P2.S4.C09 | Store passport details (name, number, nationality, DOB, dates) |
| P2.S4.C10 | Store Known Traveler Number |
| P2.S4.C11 | Encrypted at rest — no plaintext PII |
| P2.S4.C12 | Access restricted to owning user + booking system |
| P2.S4.C13 | Passport expiration warning (< 6 months) |
| P2.S4.C14 | Biometric re-authentication to view travel docs |
| P2.S4.C15 | Airline loyalty number passed to flight booking API |
| P2.S4.C16 | Group booking: each member's own loyalty number attached |
| P2.S4.C17 | Hotel rewards number passed to hotel booking API |
| P2.S4.C18 | Passport data passed to international flight booking API |
| P2.S4.C19 | Missing loyalty number doesn't block booking |
| P2.S4.C20 | People tab shows provider logo badges per member |
| P2.S4.C21 | Tapping badge reveals no personal data |
| P2.S4.C22 | No passport/loyalty data visible to other members |
| P2.S4.C23 | No document/loyalty data in cross-user API responses |
| P2.S4.C24 | Disconnect = permanent hard delete |
