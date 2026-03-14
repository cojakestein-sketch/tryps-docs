# Expense Tracking — Functional Requirements

**Assignee:** Nadeem
**Status:** In Progress
**Phase:** P1: Core App

---

## Overview

Full expense management system: add, split, track, and settle expenses within a trip. 32 screens covering the complete lifecycle from logging an expense to settling up via Venmo/Zelle/CashApp. 23 states already designed in Pencil (need Figma conversion).

## Screens (Flow 12: 32 total)

| # | Screen | Description | Status |
|---|--------|-------------|--------|
| 12.1 | Empty State | No expenses, prompt to add | Pencil → Figma |
| 12.2 | Inline Entry Active | Keyboard up, amount field, payer chip | Pencil → Figma |
| 12.3 | Payer Changed | Different payer selected | Pencil → Figma |
| 12.4 | Participant Deselected | One person excluded from split | Pencil → Figma |
| 12.5 | Expense Logged | Success: card in list | Pencil → Figma |
| 12.6 | Filled State | Balance bar + expense list + quick-add | Pencil → Figma |
| 12.7 | Filter/Sort | By date, amount, payer, category | Pencil → Figma |
| 12.8 | Full Add Modal | All fields: amount, merchant, category, payer, split, notes, receipt | Pencil → Figma |
| 12.9 | Custom Split | Editable $ per person | Pencil → Figma |
| 12.10 | Percentage Split | Editable % per person | Pencil → Figma |
| 12.11 | Receipt Camera | Camera viewfinder | Pencil → Figma |
| 12.12 | Receipt OCR Review | Extracted fields, editable | Pencil → Figma |
| 12.13 | Expense Detail | Full breakdown, edit/delete | Pencil → Figma |
| 12.14 | Delete Confirmation | "Are you sure?" dialog | Pencil → Figma |
| 12.15 | Balance — Personal | My net position, individual debts | Pencil → Figma |
| 12.16 | Balance — Group | All debts, minimized transactions | Pencil → Figma |
| 12.17 | Settle Up — Method | Venmo/Zelle/CashApp with pre-filled handles | Pencil → Figma |
| 12.18 | Settle Up — Pending | Yellow "Pending confirmation" badge | Pencil → Figma |
| 12.19 | Settle Up — Confirm | Payee taps: Confirm / Didn't Receive | Pencil → Figma |
| 12.20 | All Settled | Celebration! Green checkmark. | Pencil → Figma |
| 12.21 | 48hr Countdown | Post-trip expense cutoff banner | Pencil → Figma |
| 12.22 | Currency Selector | Searchable, trip-context suggested | Pencil → Figma |
| 12.23 | Payment Handle Prompt | First time owed: "Add your Venmo/Zelle/CashApp" | Pencil → Figma |
| 12.24-12.32 | Error & edge states | Didn't receive, cash settlement, locked state, split validation, etc. | Dev handles |

## Key Rules

- Split types: equal, custom $, percentage %
- Receipt OCR → auto-fill expense fields
- 48hr settlement countdown starts after trip end date (or owner triggers)
- Payment handles: Venmo, Zelle, CashApp
- Minimum transaction graph: debts minimized to fewest transfers
- Multi-currency with exchange rate (timing TBD)

## Sub-Tasks

1. Inline expense entry (quick-add)
2. Full expense modal (all fields)
3. Split calculation engine (equal, custom, percentage)
4. Receipt OCR pipeline
5. Balance ledger + settlement flow

## Open Questions

- Multi-currency: convert at time of expense or settlement?
- After 48hr countdown, hard-block or just nudge?
- Can partial settlements happen ($40 of $100)?
