# Notifications — Functional Requirements

**Assignee:** Muneeb
**Status:** Not Started
**Phase:** P1: Core App

---

## Overview

Push notifications and in-app notification center. Every key event in a trip triggers a notification to relevant participants.

## Notification Types

| Event | Who Gets Notified | Priority |
|-------|-------------------|----------|
| New trip invite | Invitee | High |
| Someone joined trip | All members | Medium |
| New activity suggested | All members | Medium |
| Voting deadline approaching | All members | High |
| Voting complete (winner) | All members | High |
| New expense added | All members | Medium |
| Settlement requested | Debtor | High |
| Settlement confirmed | Creditor | Medium |
| RSVP changed | Trip owner | Low |
| New message (Linq, P2) | All members | Medium |
| Flight info added | All members | Low |
| Trip date approaching | All members | High |
| 48hr expense countdown | All members | High |

## Screens

| # | Screen | Description |
|---|--------|-------------|
| X.8 | Notifications Center | Activity feed: voting deadlines, expenses, new participants, RSVP changes. Bell icon on home. |

## Technical Requirements

- Expo Push Notifications via Supabase Edge Function
- Push token registration on app launch
- Notification preferences (per-type toggle)
- Frequency cap (TBD — avoid notification fatigue)
- Deep link from notification → specific trip/tab

## Open Questions

- Full notification strategy and frequency cap
- Silent push for background data sync?
- Group notification batching (e.g., "3 people joined" instead of 3 separate notifications)
