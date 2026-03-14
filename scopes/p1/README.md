# Phase 1: Core App — Functional Requirements Document

**Version:** 1.0
**Date:** March 12, 2026
**Author:** Jake Stein, Founder
**Domain:** jointryps.com | tripful://

---

## Overview

Phase 1 delivers the complete trip planning application — everything a group needs to plan, coordinate, and settle up on a trip together. This is the foundation that Phase 2 (payments/iMessage) and Phase 3 (AI agents) build on.

**Success criteria:** A user can:
1. Onboard (all auth screens working)
2. Invite someone → they go through their onboarding flow
3. Create a trip → invite someone else
4. Use ALL functionality within trip management (all 7 tabs)

## Scope

| Category | Features |
|----------|----------|
| **Auth** | Phone OTP, Apple Sign-In, profile setup, onboarding |
| **Trip Creation** | Multi-step wizard, multi-city, date voting, card customization |
| **Invite & Join** | Shareable links, QR codes, preview-before-join, auto-join on auth |
| **Trip Detail** | 7-tab hub (Itinerary, Activities, People, Stay, Vibe, Packing List, Expenses) |
| **Activities** | Add, vote, discover, AI suggestions, scrapbook |
| **Itinerary** | Day-by-day cards, drag-to-reorder, time-based scheduling, AI import |
| **People** | Participant list, RSVP, flight info, couples, co-host |
| **Stay** | Accommodation options, voting, booking status |
| **Vibe** | Mood board, music/Spotify, dress code, DNA compatibility |
| **Expenses** | Add/split/settle, receipt OCR, multi-currency, balance ledger |
| **Flights** | Manual flight entry, arrival timeline display (search/booking → Phase 3) |
| **Travel DNA** | 10-dimension quiz, compatibility scoring, trip-specific questions |
| **Social** | Public trips, discover feed, trip cloning, friend activity |
| **Explore** | 3D globe, country wishlists, friend overlay, place discovery |
| **Calendar** | Month view, trip markers, countdown |
| **Profile** | Public profiles, travel stats, mutual friends, QR sharing |

### NOT in Phase 1
- Flight search/booking (Phase 3 — Duffel/Amadeus)
- In-app payments/Stripe (Phase 2)
- iMessage/Linq integration (Phase 2)
- Agent voting on behalf of users (Phase 3)

## Flows & Screen Count

| Flow | Screens | Status |
|------|---------|--------|
| 1. New User Onboarding | 12 | Mostly in Figma, 6 dev handles |
| 2. Invite → Join (new user) | 12 | 5 in Figma, 5 need design |
| 3. Invite → Join (existing) | 9 | 4 need design, 5 dev handles |
| 4. Trip Creation | 21 | Mostly in Figma, 7 dev handles |
| 5. Invite & Share | 11 | 3 need design, 6 dev handles |
| 6. Itinerary Tab | ~12 | In Figma |
| 7. Activities Tab | ~11 | In Figma |
| 8. People Tab | 14 | 14 need design |
| 9. Stay Tab | 24 | 24 need design |
| 10. Vibe Tab | 15 | 11 need design |
| 11. Packing List | 9 | 6 need design |
| 12. Expenses Tab | 32 | 23 Pencil → Figma |
| 13. Post-Trip State | 6 | 6 need design |
| 14. Travel DNA | 6 | 6 need design |
| Cross-Flow | 9 | 4 need design |
| **TOTAL** | **~195** | **~86 need design, ~47 dev handles** |

## Technical Architecture

- **Stack:** Expo SDK 54 + TypeScript + Supabase + Expo Router
- **Auth:** Phone OTP via Supabase Auth + Apple Sign-In
- **Database:** Supabase PostgreSQL with Row-Level Security on all tables
- **Real-time:** Supabase Realtime for live updates across group members
- **Deep Links:** `tripful://` scheme + `https://jointryps.com` universal links

## Assignees

| Scope | Assignee | Sub-tasks |
|-------|----------|-----------|
| Auth & Onboarding | Asif | 5 |
| Expense Tracking | Nadeem | 5 |
| Invite Flow | Asif | 4 |
| Trip Detail Tabs | Nadeem | TBD |
| Notifications | Muneeb | TBD |
| Design System | Krisna | 3 |
| QA & Testing | Andreas | TBD |
| Explore & Globe | Unassigned | TBD |

## Full Detail

See `_private/specs/frd-p1-core-app.md` in the main Tryps repo for complete flow-by-flow screen descriptions.
