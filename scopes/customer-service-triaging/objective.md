---
id: customer-service-triaging
title: "Customer Service & Triaging"
scope_number: 12
owner: jake
status: needs-spec
created: 2026-03-24
---

# Customer Service & Triaging

## What

How Tryps handles customer service operations: cancellations, disputes, refunds, chargebacks, support requests, and triaging incoming issues. The ops layer that sits behind the product.

## Why

As we onboard real users, things will go wrong — bookings need cancelling, payments need disputing, people will have questions the agent can't answer. We need a plan for how these get surfaced, triaged, and resolved before we're drowning in support requests.

## Open Questions (For Spec Session)

- What's the first line of defense — agent handles it, or human escalation?
- How do cancellations flow? User requests in iMessage → agent processes → refund?
- What about chargebacks and payment disputes (Stripe)?
- Do we need a support queue / ticketing system, or does ClickUp handle this?
- What's the escalation path: agent → Marty → Jake?
- How do we handle issues the agent caused (bad booking, wrong date, etc.)?

## In Scope

- Cancellation flows (flights, stays, activities, restaurants) — see [[travel-booking/objective|Travel Booking]]
- Refund/dispute handling (Stripe integration) — see [[payments-infrastructure/objective|Payments Infrastructure]]
- Support request triaging (where do they land, who sees them)
- Agent error recovery (what happens when the agent messes up)
- Escalation paths

## Out of Scope

- Building a full customer service platform (we're not Zendesk)
- Phone support
- 24/7 human support staffing
