---
id: travel-booking
needs_figma: true
designer: unassigned
design_status: not-started
screens:
  - unified-search-results
  - booking-confirmation
  - group-flight-picker
  - search-entry-points
last_updated: 2026-03-23
---

> Parent: [[travel-booking/objective|Travel Booking Objective]]

# Travel Booking — Design Needs

This scope has UI deliverables: search results screens, booking confirmation flows, and the group flight coordination picker. The existing manual entry screens (add-flight, add-accommodation, add-dinner, add-transportation) stay as-is — these are NEW screens for API-powered search and booking.

## 1. Search Entry Points

**Status:** Not started

**What:** How users access API-powered search from the trip card. Today, each section has an "Add" button that opens a manual entry form. The API-powered search needs to be the primary path, with manual entry as a secondary option.

**Design questions:**
- Does each trip card section (Flights, Stay, Restaurants, Activities, Transport, Events) get a "Search" button alongside the existing "Add" button?
- Or does "Add" become "Search" by default, with manual entry as a secondary tab/option?
- Where does the search input UI live? Inline on the trip card, or a dedicated search screen?

## 2. Search Results Display

**Status:** Not started

**What:** How search results appear after the user (or agent) triggers a search. Needs to work across all 6 categories with category-specific detail cards.

**Requirements:**
- Results as scrollable cards, each showing key info at a glance (reference: Citymapper-style layout per the strategy intake)
- Category-specific card layouts: flights show airline + times + price, restaurants show cuisine + rating + available times, events show venue + date + price range
- Clear "Book" or "Select" CTA per card
- Source/provider badge on each card (e.g., "via Duffel", "via Resy")
- Loading state while search runs
- Empty state when no results match

**Design questions:**
- Unified card design across categories with variable content? Or distinct card templates per category?
- How do multi-provider results indicate their source?

## 3. Booking Confirmation Flow

**Status:** Not started

**What:** The screen(s) between "user selects an option" and "booking is confirmed." This is where payment handoff (scope 9) happens.

**Requirements:**
- Summary of what's being booked (flight details, restaurant + time, event + tickets, etc.)
- Price breakdown (per person, total, group split if applicable)
- Payment method display (delegated to scope 9's UI components)
- Confirm button
- Success state: confirmation number, key details, "added to your itinerary"
- Failure state: clear error message with retry/alternative options

## 4. Group Flight Picker

**Status:** Not started

**What:** The UI for the multi-person group flight search (SC-3, SC-41-43). Shows flight "sets" where each set contains one flight per participant, all landing within the arrival window.

**Requirements:**
- Input: destination, list of participants (with home airports from Travel Identity), date
- Results: grouped into "sets" — each set is a row/card showing all participants' flights side by side
- Per-set: total group price, arrival window, individual flight details per person
- Each participant can confirm or decline their flight within the set
- Visual indicator of who's confirmed vs. pending
- Partial confirmation handling (2 of 3 confirmed — show this state)

**Design questions:**
- How are sets compared? Vertical list? Side-by-side cards?
- How does the arrival window visualize (timeline bar showing landing times?)

## 5. Price Change / Availability Warning Modals

**Status:** Not started

**What:** Modals/alerts for edge cases: price changed between search and booking, option no longer available, duplicate booking warning.

**Requirements:**
- Price change: show original price, new price, delta, and confirm/cancel
- Unavailable: clear message, "Search again" button
- Duplicate: warning with existing booking details, "Book anyway" or "Cancel"
