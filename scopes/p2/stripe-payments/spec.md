---
id: p2-stripe-payments
title: "Stripe Payments"
phase: p2
status: not-started
assignee: asif
priority: 2
dependencies: [p2-connectors]
blocked: false
blocked_reason: ""
---
# P2 Scope 2: Stripe Payments — Spec

> **Status:** draft
> **Phase:** P2: Stripe + Linq
> **Gantt ID:** `p2-stripe-payments`
> **Date:** 2026-03-16

## What

Payment processing so Tryps can book flights, hotels, and Airbnbs on behalf of users. Charge a card on file, confirm the booking, done.

## Why

Tryps acts as a travel broker. To book anything on a user's behalf — airlines, hotels, Airbnb — the platform needs to accept and process payments. Without this, every booking is manual and off-platform.

## Intent

> "Instead of every service that Expedia provides, we just also need to provide it for an entire group and also in natural language via agents. It should feel like AgentCash where you can just buy shit online or do stuff directly."
>
> Zero friction. User says "book it," the agent handles everything. No checkout flows, no forms. It just happens.

## Success Criteria

### Core Behavior

- [ ] **P2.S2.C01** — A user can confirm a travel booking (flight, hotel, or Airbnb) and their saved card is charged immediately. Verified by: Given a user with a card on file viewing a flight option → user confirms "book it" → card is charged and a booking reference number is returned within 30 seconds.

- [ ] **P2.S2.C02** — Booking confirmation appears in the same channel the user booked from. Verified by: Given a user who confirms a booking via iMessage → a confirmation message with booking details appears in that iMessage thread. Given a user who confirms in-app → a confirmation screen displays in the app.

- [ ] **P2.S2.C03** — One user can book travel for multiple members of the same trip. Verified by: Given a trip with 4 members and all members have travel profiles set up → one user selects "book for everyone" on a flight → 4 separate bookings are created and the booking user's card is charged for the total amount.

- [ ] **P2.S2.C04** — The booking agent applies stored travel preferences (e.g., aisle seat) when suggesting options. Verified by: Given a user whose travel profile specifies "aisle seat" → agent presents flight options → suggested flights highlight aisle seat availability and pre-select it.

- [ ] **P2.S2.C05** — A user can save a payment method (credit/debit card) to their account for future bookings. Verified by: Given a user on the payment settings screen → user enters card details → card is saved and appears as their default payment method on the next booking attempt.

### Edge Cases & Error States

- [ ] **P2.S2.C06** — A user with no saved payment method is prompted to add one before completing a booking. Verified by: Given a user with no card on file who confirms a booking → a payment method entry screen appears before the charge is attempted → after adding a card, the booking completes.

- [ ] **P2.S2.C07** — When a card is declined, the user sees a plain-language reason. Verified by: Given a user whose card is declined for insufficient funds → the message displays "Your card was declined — insufficient funds. Try a different card." (not a Stripe error code).

- [ ] **P2.S2.C08** — When a booking fails on the supplier side (airline, hotel), the user sees what went wrong and is not charged. Verified by: Given a flight that becomes unavailable after the user confirms → the user sees "This flight is no longer available — you were not charged" → no charge appears on the card.

- [ ] **P2.S2.C09** — When a user books for a group and one member's profile is incomplete (missing passport or preferences), the booking flow surfaces which member needs attention. Verified by: Given a group booking where 1 of 4 members has no passport info → the flow pauses and displays "[Member name] is missing passport information" before charging.

### Should NOT Happen

- [ ] **P2.S2.C10** — A payment must never be charged without the user explicitly confirming the booking. No auto-charge on browse or selection.

- [ ] **P2.S2.C11** — Completing a booking must not create, modify, or remove any entries in the trip's expense log. Stripe bookings and expense logging are separate features.

### Open Questions

- **OQ1:** How does Tryps collect payment and then pay suppliers (airlines, hotels, Airbnb)? Direct API billing, Stripe Connect with connected accounts, or another model? Needs architecture research.
- **OQ2:** What is the lowest-friction payment method for first-time users? Candidates: Apple Pay, Stripe Payment Links (for iMessage), in-app card entry. Needs UX research.
- **OQ3:** What are the specific error states and retry patterns for each supplier type? Needs research per integration (Duffel for flights, Airbnb API, hotel APIs).
- **OQ4:** How does the P3 agent layer (X402 / pay-on-behalf) extend this payment infrastructure? Needs alignment with P3 scoping.

### Out of Scope

- Expense splitting or settlement between group members — separate feature
- Supplier-specific booking APIs (Duffel, Airbnb) — covered in P3 `duffel-apis` and other scopes
- Travel Connector profiles (card storage, passport, preferences) — next scope `p2-connectors`
- Agent-initiated autonomous payments (X402) — P3 `pay-on-behalf`

### Regression Risk

| Area | Why | Risk |
|------|-----|------|
| Expenses tab | Shared trip data model — bookings must not write to expenses | Med |
| iMessage integration | Booking confirmations sent via existing message channel | Med |
| Travel DNA / Connectors | Reads user preferences — depends on P2 Connectors scope | High |

- [ ] **P2.S2.C12** — Typecheck passes.
