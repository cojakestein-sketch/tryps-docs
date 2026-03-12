# Trip Detail Tabs — Functional Requirements

**Assignee:** Nadeem
**Status:** Not Started
**Phase:** P1: Core App

---

## Overview

The Trip Detail screen is the heart of Tryps. A 7-tab hub where all trip planning happens. Tabs: Itinerary (default), Activities, People, Stay, Vibe, Packing List, Expenses.

## Tab Summary

| Tab | Screens | Key Features |
|-----|---------|-------------|
| Itinerary (Flow 6) | ~12 | Day-by-day cards, drag-to-reorder, time scheduling, AI import |
| Activities (Flow 7) | ~11 | Ideas Pool, voting, discover, drag-to-confirm, day assignment |
| People (Flow 8) | 14 | Participant list, RSVP, flight info, roles, phantom participants |
| Stay (Flow 9) | 24 | Accommodation search/add, voting (48hr), multi-city, booking |
| Vibe (Flow 10) | 15 | Group DNA, Spotify, mood board, compatibility |
| Packing List (Flow 11) | 9 | Personal + group items, AI suggestions, dress code |
| Expenses (Flow 12) | 32 | Add/split/settle, OCR, multi-currency, settlement |

## Cross-Tab Interactions

- Activities ↔ Itinerary: confirmed activities appear on day cards
- Stay → Expenses: "Mark as Booked" creates expense split
- People → Expenses: settlement balances per person
- Vibe → Travel DNA: quiz accessible from Vibe tab
- Post-Trip (Flow 13): all tabs go read-only after trip end date

## Key Design Principles

- **Trip card = trip plan** — a filled card means the trip is fully planned
- **Every section always visible** — empty = prompt to act
- **Uniform card height** — no layout shift between swipes
- **Tap to edit** — every section is a tap target

## Technical Notes

- Tab bar: horizontal scrollable
- Real-time sync via Supabase Realtime
- Skeleton loading states per tab
- Deep link per tab: `tripful://trip/{id}/{tab}`
