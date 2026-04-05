---
id: payments-infrastructure
title: "Payments Infrastructure"
scope_number: 9
where_it_lives: "Backend, mobile, iMessage frontend"
owner: jake
created: 2026-03-20
review_status: un-reviewed
---

## What

Spending money through Tryps. Stripe card-on-file with trust ramp (first payment explicit, then progressively autonomous), pay-on-behalf (agent pays for you with explicit opt-in), auto-expense logging from bookings, and group booking.

## Why

The full vision is that Tryps handles real money — but per strategic principle, booking is last in the funnel (vibe → needs → facilitation → booking). Payments infrastructure enables the transaction layer once facilitation is working.

## Related Scopes

- [[travel-booking/objective|Travel Booking]] — all bookings delegate payment here
- [[core-trip-experience/objective|Core Trip Experience]] — expense flows depend on payment processing
- [[imessage-agent/objective|iMessage Agent]] — pay-on-behalf triggered via iMessage
- [[customer-service-triaging/objective|Customer Service & Triaging]] — refunds and chargebacks flow through Stripe

## Success Looks Like

- Stripe card-on-file integrated with trust ramp
- Pay-on-behalf working with explicit user opt-in ($0 default)
- Bookings auto-log as expenses
- Group booking (one pays for all, auto-splits to group expense)
