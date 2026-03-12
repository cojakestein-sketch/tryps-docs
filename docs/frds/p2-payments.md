# Phase 2: Stripe + Linq — Functional Requirements Document

**Version:** 1.0
**Date:** March 12, 2026
**Author:** Jake Stein, Founder
**Domain:** jointryps.com | tripful://
**Depends on:** Phase 1 (Core App)

---

## Overview

Phase 2 adds two critical capabilities: (1) real payments via Stripe so users can settle expenses in-app, and (2) iMessage integration via Linq so users can interact with Tryps without leaving their group chat.

**Success criteria:**
1. A user can pay another user directly in the Tryps app (Stripe)
2. A user can text their group chat and Tryps responds with trip updates/actions (Linq)
3. Booking links carry pre-filled data to partner sites

## Scope

| Category | Features |
|----------|----------|
| **iMessage** | Text-to-Tryps via Linq, natural language parsing, response relay |
| **Payments** | Stripe for user-facing payments, in-app payment processing |
| **Booking Links** | Deep links to booking partners with pre-filled data |

## 2.1 iMessage Integration (Linq)

Users text Tryps in their existing iMessage group chat. Linq relays messages to Tryps backend, which parses intent and responds with structured data.

### Core Flows

| Flow | User Action | Tryps Response |
|------|-------------|----------------|
| Trip Status | "what's the plan for Miami?" | Trip card summary |
| Activity Suggestion | "we should do jet skiing" | Adds to Ideas Pool, notifies group |
| Vote from Text | "vote yes on the Airbnb" | Registers vote, updates count |
| RSVP from Text | "I'm in!" | Updates RSVP, notifies trip members |
| Expense from Text | "Jake paid $50 for dinner" | Creates expense, splits evenly |
| Flight Info | "my flight is AA123" | Logs flight, updates People tab |

### Open Questions
- Linq data format: raw text relay (we parse) or structured/parsed data?
- Linq pricing model
- User identity mapping (iMessage phone → Tryps user)

## 2.2 Payments (Stripe Connect)

In-app payment processing via Stripe Connect. Tryps acts as platform, each user is a Connected Account.

### Payment Flows

| Flow | Description |
|------|-------------|
| Stripe Onboarding | User links bank account / debit card |
| Pay Balance | Tap "Pay" → Stripe payment intent → confirmed |
| Receive Payment | Payee gets notification + confirmation |
| Payment History | Transaction history |
| Failed Payment | Retry/change method options |

### Open Questions
- Fee structure: who pays Stripe's 2.9% + $0.30?
- Settlement timing: instant vs standard 2-day
- Keep Venmo/Zelle as fallback alongside Stripe?

## 2.3 Booking Links

Direct booking links that pre-fill data on partner sites (Airbnb, VRBO, Booking.com, OpenTable, Viator). URL construction with query parameters, no API integration needed.

## New Screens (11)

| # | Screen | Description |
|---|--------|-------------|
| P2.1-P2.4 | Linq Setup/Settings | Connect trip to iMessage, preview, settings, history |
| P2.5-P2.11 | Payment Screens | Stripe onboarding, method, confirm, success, failed, history, payout settings |

## Dependencies

| Dependency | Status |
|-----------|--------|
| Phase 1 Expenses complete | In Progress |
| Linq API access | Pending (meeting March 12) |
| Stripe account setup | Not started |
