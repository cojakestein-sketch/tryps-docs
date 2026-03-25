---
id: p2-connectors
title: "Travel Life Connectors"
phase: p2
status: not-started
assignee: asif
priority: 4
dependencies: [p1-travel-dna]
blocked: false
blocked_reason: ""
---

# P2 Scope 4: Travel Life Connectors — Spec

> **Phase:** P2: Stripe + Linq
> **Gantt ID:** `p2-connectors`
> **Comp:** [Apple Wallet](https://www.apple.com/wallet/) — all your cards and passes in one place, tap to use. [TripIt](https://www.tripit.com/) — connected travel accounts auto-import itineraries.

## What

A travel identity layer where users link airline loyalty accounts, hotel rewards programs, rideshare services, and Airbnb — plus securely store passport and travel documents. Connected accounts persist across all trips so bookings through Tryps automatically earn loyalty points and pre-fill travel details. A visual connector hub in the profile shows connection status and encourages full setup.

## Why

When Tryps books a flight or hotel on behalf of a user (or group), it needs their loyalty numbers to earn points and their passport info for international travel. Without connectors, every booking requires manual data entry and users miss out on rewards they've already earned. This scope is the data foundation that Stripe Payments reads from, the Logistics Agent applies at booking time, and Booking Links pre-fill.

## Intent

> "I use Marriott, so I need to connect my Marriott account. I use American Airlines, so I need to connect my American Airlines profile. If I book through Tryps, I still get my American Airlines points, I still get my Marriott points."
>
> "What we're trying to get to is a visual on the UI that shows that Tryps is better with all of our partners connected. Ideally we partner with Uber, Lyft, Marriott, Delta, American — everybody can be connected into Tryps. We can pull from whoever will let us pull from them."
>
> "Passports need to be really secure. We can't mess up and leave a bunch of passports exposed."

## Success Criteria

### Connector Hub

- [ ] **P2.S4.C01.** User can open a "Connected Accounts" screen from their profile settings. Verified by: user taps profile icon → taps "Connected Accounts" → screen displays a list of supported travel services (airlines, hotels, rideshare, vacation rentals) grouped by category, each showing "Connected" or "Not connected."

- [ ] **P2.S4.C02.** User can connect an airline loyalty account by selecting an airline (e.g., American Airlines, Delta, United) and entering their frequent flyer number. Verified by: user taps "American Airlines" → enters AAdvantage number → taps Save → screen shows American Airlines as "Connected" with the last 4 digits of the number visible.

- [ ] **P2.S4.C03.** User can connect a hotel rewards account by selecting a hotel chain (e.g., Marriott Bonvoy, Hilton Honors) and entering their rewards number. Verified by: user taps "Marriott" → enters Bonvoy number → taps Save → screen shows Marriott as "Connected."

- [ ] **P2.S4.C04.** For services that support OAuth login (e.g., Airbnb, Uber, Lyft), tapping "Connect" opens the service's login page and links the account after the user authenticates. Verified by: user taps "Connect" on Airbnb → Airbnb login page opens in a browser → user signs in and authorizes → redirected back to Tryps → Airbnb shows as "Connected."

- [ ] **P2.S4.C05.** Loyalty and rewards numbers are validated before saving. If a number does not match the provider's expected format, the user sees an error and the number is not saved. Verified by: user enters "XYZ" as an American Airlines AAdvantage number → error message appears (e.g., "That doesn't look like a valid AAdvantage number") → number is not saved → user enters a correctly formatted number → saves successfully.

- [ ] **P2.S4.C06.** Connected accounts are linked to the user's profile and persist across all trips — not per-trip. Verified by: user connects American Airlines → creates Trip A → creates Trip B → both trips can access the same AA loyalty number without re-entering it.

- [ ] **P2.S4.C07.** User can disconnect a previously linked account and the stored data is permanently deleted. Verified by: user opens Connected Accounts → taps American Airlines (connected) → taps "Disconnect" → confirms → American Airlines shows "Not connected" → reconnecting later requires re-entering the number.

- [ ] **P2.S4.C08.** The Connected Accounts screen shows a progress indicator encouraging users to link more services. Verified by: user with 2 of 8 supported services connected → screen shows "2 of 8 connected" with a progress bar or ring and text encouraging more connections.

### Travel Documents

- [ ] **P2.S4.C09.** User can store passport details including full legal name, passport number, nationality, date of birth, issue date, and expiration date. Verified by: user opens "Travel Documents" from profile → taps "Add Passport" → fills all fields → saves → passport details appear on the Travel Documents screen with the passport number partially masked.

- [ ] **P2.S4.C10.** User can store a Known Traveler Number (Global Entry / TSA PreCheck). Verified by: user opens Travel Documents → taps "Add Known Traveler Number" → enters number → saves → number appears on the Travel Documents screen.

- [ ] **P2.S4.C11.** Passport and travel document data is encrypted at rest in the database — never stored as plaintext. Verified by: query the database table storing passport data → values in the passport number and Known Traveler Number columns are encrypted and unreadable without the decryption key.

- [ ] **P2.S4.C12.** Travel document data is accessible only to the user who owns it and to the booking system at the moment of booking. No other user or trip member can view it. Verified by: User A stores passport details → User B (same trip) inspects all app screens and API responses → no trace of User A's passport number, nationality, or date of birth appears.

- [ ] **P2.S4.C13.** The app warns the user when their stored passport expiration date is within 6 months of today. Verified by: user stores a passport expiring in 4 months → Travel Documents screen shows a warning badge (e.g., "Expires in 4 months — some countries require 6+ months validity") → user updates passport with later expiration → warning disappears.

- [ ] **P2.S4.C14.** Viewing or editing travel documents requires re-authentication via device biometrics (Face ID / Touch ID) or device PIN. Verified by: user taps "Travel Documents" → device biometric prompt appears → only after successful authentication are document details revealed → canceling authentication returns to profile without showing data.

### Booking Passthrough

- [ ] **P2.S4.C15.** When a user books a flight through Tryps, their stored frequent flyer number for that airline is automatically included in the booking request. Verified by: user with a stored AA AAdvantage number books an American Airlines flight → booking confirmation references the frequent flyer number → miles are credited to the user's loyalty account.

- [ ] **P2.S4.C16.** When one user books flights for the entire group, each group member's individual frequent flyer number is attached to their respective booking. Verified by: trip with 4 members, 3 have AA numbers stored → group AA flight booked → the 3 members' individual AA numbers appear on their respective booking confirmations → the 4th member's booking proceeds without a loyalty number.

- [ ] **P2.S4.C17.** When a user books a hotel through Tryps, their stored hotel rewards number is included in the booking request. Verified by: user with a Marriott Bonvoy number books a Marriott hotel → booking confirmation references the Bonvoy number → points are credited.

- [ ] **P2.S4.C18.** When booking an international flight, stored passport details (legal name, number, nationality, date of birth, expiration) are passed to the booking API so the user does not re-enter them. Verified by: user with stored passport books an international flight → booking API receives passport data → no manual passport entry screen appears during checkout.

- [ ] **P2.S4.C19.** If a group member has no loyalty number for the booking provider, that member's booking proceeds normally without a loyalty number — no error or blocking prompt. Verified by: user with no Delta SkyMiles number books a Delta flight → booking completes successfully → user simply does not earn miles for that flight.

### People Tab Badges

- [ ] **P2.S4.C20.** On a trip's People tab, small provider logo badges appear next to each member's name showing which travel services they have connected. Verified by: trip People tab → "Quinn" shows an American Airlines logo badge and a Marriott logo badge → "Jake" shows Delta and Hilton badges → a member with no connections shows no badges.

- [ ] **P2.S4.C21.** Tapping a member's connection badge does not reveal their loyalty number, account details, or any personal data — only that they are connected to that service. Verified by: user taps Quinn's AA badge → no account number, loyalty details, or personal information is displayed → at most a label like "Quinn is connected to American Airlines."

### Should NOT Happen

- [ ] **P2.S4.C22.** Passport numbers, travel document details, and full loyalty account numbers are never visible to other trip members anywhere in the app. Verified by: inspect the People tab, trip details, group chat, and all visible screens for a trip → no other member's passport data or full loyalty numbers appear.

- [ ] **P2.S4.C23.** Travel document and loyalty data is never included in API responses to other users. Verified by: call the trip members API authenticated as User B → response for User A contains only connection status (connected/not connected per service), never passport numbers or loyalty account numbers.

- [ ] **P2.S4.C24.** Disconnecting an account permanently deletes the stored number — no soft-delete, no retention. Verified by: user disconnects AA → query the database for that user's AA entry → no record or remnant exists.

### Out of Scope

- **Booking APIs** (Duffel flights, hotel APIs, Airbnb API) — covered in `p3-duffel-apis`. This scope stores the identity data; those scopes consume it at booking time.
- **Payment processing** — covered in `p2-stripe-payments`. Connectors store loyalty/passport data, not credit cards or payment methods.
- **Agent recommendation logic** — covered in `p3-logistics-agent`. The agent reads connector data to apply preferences, but search/rank/book logic is separate.
- **Booking links with pre-filled data** — covered in `p2-booking-links`.
- **OAuth API implementation details** — if Airbnb or Uber OAuth requires custom API integration work, those details are deferred to the plan phase. This spec defines the user-facing flow.

### Regression Risk

| Area | Why | Risk |
|------|-----|------|
| User profile | New sections (Connected Accounts, Travel Documents) added to existing profile screen | Medium |
| People tab | Adding connection badges to existing member list items | Low |
| Database security | Encrypted passport storage adds column-level encryption to the data layer | High |
| Booking flow | Passing loyalty/passport data to booking APIs at transaction time | Medium |

## References

- Stripe Payments spec: `scopes/p2/stripe-payments/spec.md` — defers connector profiles to this scope
- Logistics Agent spec: `scopes/p3/logistics-agent/spec.md` — reads stored preferences + loyalty at booking time
- Duffel APIs spec: `scopes/p3/duffel-apis/spec.md` — consumes loyalty numbers via booking API
- Booking Links spec: `scopes/p2/booking-links/spec.md` — pre-fills trip data from connector profiles

- [ ] Typecheck passes
