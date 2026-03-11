# Tryps — Functional Requirements Document (FRD)

**Version:** 1.0 (Draft)
**Date:** March 9, 2026
**Author:** Jake Stein, Founder
**Domain:** jointryps.com | tripful://

---

> ### This Week's Goal (March 9-15, 2026)
>
> **Complete the Trip Management System.** Success = a user can:
> 1. Onboard (all auth screens working)
> 2. Invite someone → they go through their onboarding flow
> 3. Create a trip → invite someone else (all Trip Menu screens)
> 4. Use ALL functionality within trip management:
>    - Activities tab (all screens)
>    - Itinerary tab (all screens)
>    - People tab (all screens)
>    - Stay tab (all screens)
>    - Expenses tab (all screens)
>    - Vibe tab (all screens)
>
> **This FRD's primary deliverable:** Every individual screen listed so designers can claim and build them.

---

## Table of Contents

1. [Product Vision](#1-product-vision)
2. [System Architecture](#2-system-architecture)
3. [User Roles & Types](#3-user-roles--types)
4. [Feature Overview by Phase](#4-feature-overview-by-phase)
5. [Flows & Screens — Designer Assignment Sheet](#5-flows--screens--designer-assignment-sheet)
6. [Non-Functional Requirements](#6-non-functional-requirements)
7. [Outstanding Questions](#7-outstanding-questions)

---

## 1. Product Vision

### 1.1 One-Liner

**"Tryps — the Partiful for trips."**

### 1.2 Problem

Group trip planning is fragmented across 7+ apps: iMessage for conversation, spreadsheets for coordination, Google Docs for itineraries, Venmo for expenses, Booking.com for flights, Airbnb for stays. Nobody owns the plan. Trips fall apart. Information gets lost.

### 1.3 Solution

One app where groups plan, coordinate, book, and settle up together. All sections (flights, activities, stays, expenses, itinerary, vibe) visible on one trip card. The filled card IS the planned trip.

### 1.4 Why Now

1. **Gen Z prioritizes travel spending while cutting everything else.** Travel spending surged 13.8% YoY even as overall spend dropped 13%. They plan to spend $6,434/person on international trips in 2026 — more than any other generation. 45% plan to join group trips in the next 12 months.

2. **"Social utility" is the defining app category — and travel doesn't have one yet.** Partiful grew 400% YoY to 500K MAU and was named Google's Best App of 2024. Every coordination problem is getting its own app (events, payments, availability) — except group travel.

3. **AI agents can now execute real bookings and payments.** Google launched Agent Payment Protocol (AP2) in Jan 2025. Mastercard completed Europe's first live AI agent payment in early 2026. Duffel's API lets software search, book, and manage flights programmatically. This infrastructure didn't exist in 2024.

4. **iMessage is opening up as a platform.** Linq raised $20M Series A (Feb 2026) to let AI assistants live natively inside iMessage, powering 30M+ messages/month. Apple added RCS support in iOS 18. A trip-planning agent can now meet users in the thread where the trip is already being discussed.

5. **The coordination tax is enormous and scales with group size.** The average traveler spends 16-20+ hours planning. Multiply by group dynamics across 4-8 people. Nearly half of adults say less planning time would reduce relationship stress. This is a $391B market growing to $690B by 2035.

6. **Tool fragmentation is getting worse.** 20+ group travel apps exist (SquadTrip, Wanderlog, TripIt, etc.) — each solving one slice. No product owns the full loop from "let's go somewhere" to "everyone's booked and paid."

7. **72% of Gen Z already trusts AI to plan and book travel.** (KAYAK 2026) The behavioral shift happened. The question isn't "will people let AI book?" — it's "who builds the group-native AI agent that does it?"

### 1.5 Target Users

**Primary:** Groups of 4-12 friends planning leisure trips (weekend getaways, vacations, bachelor/bachelorettes, annual trips)

**Demographic:** Gen Z / Millennials (20s-30s), group-oriented travelers

**Beachhead Markets:**
- College spring break trips
- Bachelorette/bachelor parties
- Destination weddings
- Friend group annual trips
- Family trips

### 1.6 The 60/30/10 Traveler Split

| Type | % | Behavior | How We Serve Them |
|------|---|----------|-------------------|
| "I Don't Care-ers" | 60% | Excited to be invited, doesn't want another app | Agent votes on their behalf using their DNA |
| Casual Engagers | 30% | Opens app, votes, logs flight | Simple voting, quick DNA, flight logging |
| Ultimate Planners | 10% | Lives in the app, manages everything | Full-featured trip cards, itinerary, expenses |

### 1.7 Five Core Tenets

1. **Traveler DNA** — The richest preference graph in travel. Human-selected, shareable preferences that power everything downstream.
2. **Built for Every Traveler Type** — Serve the 60/30/10 split. The product works for planners and "I don't care-ers" alike.
3. **UI-Lite / Meet Users in iMessage** — The best coordination tool lives in the conversation thread your group already uses.
4. **Social Discovery + Viral by Design** — Friends beat algorithms. Every trip is a growth event. Frictionless invites + human-driven recommendations create compounding network effects.
5. **Agents Execute on Your Behalf** — AI agents do the work: search flights, find accommodations, suggest activities, vote for you based on your DNA. You text what you want; agents make it happen.

### 1.8 Competitive Positioning

| Quadrant | Solo | Group |
|----------|------|-------|
| **Utility** | TripIt, Wanderlog, Google Trips | WhatsApp groups, spreadsheets |
| **Social + Utility** | Pinterest (inspiration only) | **Tryps** (owns this quadrant) |

**Closest Comp:** Partiful (social utility for events → we're social utility for trips)

### 1.9 Key Metrics

| Metric | Why |
|--------|-----|
| Trips created (monthly) | Core engagement |
| Invite-to-join conversion rate | Most important growth metric |
| Average group size per trip | Network density |
| % trips with 2+ active contributors | Collaboration health |
| Expense volume processed | Utility value |
| K-factor (viral coefficient) | Growth engine |
| Trip completion rate (created → happens) | Product-market fit signal |

---

## 2. System Architecture

### 2.1 Three-Layer Architecture

```
              LINQ (data)                    AGENTS (data)
         ◄──────────────────►          ◄──────────────────►

┌─────────────────┐          ┌─────────────────┐          ┌─────────────────┐
│                 │          │                 │          │                 │
│    iMessage     │◄────────►│   Tryps App     │◄────────►│  Agent Layer    │
│                 │          │                 │          │                 │
│  User texts     │          │  Source of      │          │  AI agents      │
│  naturally      │          │  truth for      │          │  execute via    │
│  in group chat  │          │  trip state     │          │  real APIs      │
│                 │          │                 │          │                 │
└─────────────────┘          └─────────────────┘          └─────────────────┘

         ◄──────────────────►          ◄──────────────────►
              STRIPE ($)                   TRYPS CASH ($)
```

**Layer 1 — iMessage:** Users text Tryps like texting a friend. Natural language in, structured responses out. Powered by Linq.

**Layer 2 — Tryps App:** React Native / Expo frontend. The visual source of truth. Trip cards with all sections. Real-time Supabase sync.

**Layer 3 — Agent Layer:** AI agents calling real APIs. Duffel (flights), X-402 (micropayments), future APIs (accommodations, activities, dining).

**Four Bridges:**
- **Linq** — iMessage ↔ Tryps message relay
- **Stripe** — User-facing payments (iMessage ↔ App)
- **Agents** — Task dispatch (App ↔ Agent Layer)
- **Tryps Cash** — Agent wallet for micropayments (App ↔ Agent Layer)

### 2.2 Example Flows

**Flow: Family Flight Booking** ("4 people, 2 origins, coordinated arrival")

| Step | Layer | Action |
|------|-------|--------|
| 1 | iMessage | "Book us flights to Lisbon" |
| 2 | Tryps | Parse: 4 travelers, 2 origins |
| 3 | Agent | Query Duffel for flights from both cities |
| 4 | Tryps | Present best options in trip card |
| 5 | iMessage | Options sent to group chat |
| 6 | iMessage | Group confirms → 4 tickets booked |

**Flow: Activity Voting** ("Group decides what to do Saturday")

| Step | Layer | Action |
|------|-------|--------|
| 1 | iMessage | "What should we do Saturday?" |
| 2 | Tryps | Load preferences + group DNA |
| 3 | Tryps | Generate DNA-calibrated poll |
| 4 | iMessage | Everyone votes in chat |
| 5 | Tryps | Winner auto-added to itinerary |

**Flow: Group Airbnb Search**

| Step | Layer | Action |
|------|-------|--------|
| 1 | iMessage | "Find us an Airbnb in Porto" |
| 2 | Tryps | Parse: budget, dates, group size |
| 3 | Agent | Search listing APIs |
| 4 | Tryps | Top matches in trip card |
| 5 | iMessage | Group votes on favorites |
| 6 | Tryps | Booked → cost auto-split |

---

## 3. User Roles & Types

### 3.1 Authentication States

| State | Description | Can Do |
|-------|-------------|--------|
| **Authenticated** | Has account (phone number verified via OTP) | Full app access |

> **Note:** There is no unauthenticated state. Phone number is required to view anything. Even invite link recipients must authenticate before seeing trip details.

### 3.2 Trip-Level Roles

| Role | Description | Permissions |
|------|-------------|-------------|
| **Trip Owner** | Created the trip | Full control including delete, transfer ownership |
| **Co-Host** | Elevated member | Edit trip details, manage participants, but cannot delete |
| **Trip Member** | Joined via invite | Add activities, expenses, flights; vote; RSVP |
| **Invited (Pending)** | Received invite, hasn't joined | View preview, join |

### 3.3 Entry Archetypes

| Type | Entry Point | Auth State |
|------|-------------|------------|
| Organic New User | App Store download | No account |
| Invited New User | Tap invite link | No account |
| Invited Existing User | Tap invite link | Has account |
| Returning User | Cold app launch | Has account |

---

## 4. Feature Overview by Phase

### Phase 1 — Core App (Current)

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

### Phase 2 — Stripe + Linq Integration

| Category | Features |
|----------|----------|
| **iMessage** | Text-to-Tryps via Linq, natural language parsing, response relay |
| **Payments** | Stripe for user-facing payments, in-app payment processing |
| **Booking Links** | Deep links to booking partners with pre-filled data |

### Phase 3 — Agent Layer

| Category | Features |
|----------|----------|
| **Flight Search** | Amadeus search, recommendations, fare comparison |
| **Flight Booking** | Full booking via Duffel API |
| **Agent Wallet** | Tryps Cash for funding agent API calls |
| **X-402** | Micropayment protocol for agent-to-API transactions |
| **Agent Voting** | AI votes on behalf of "I don't care-ers" using DNA |
| **Smart Recommendations** | DNA-calibrated suggestions for activities, stays, dining |

### Phase 3.5 — Agent Platform

| Category | Features |
|----------|----------|
| **External Agents** | Claude, ChatGPT can write to Tryps API |
| **AI Trip Generation** | NL prompt → fully planned trip card |
| **Programmable Coordinators** | Agents as autonomous trip planners |

---

## 5. Flows & Screens — Designer Assignment Sheet

> **How to read this:** Each flow below lists every screen in the order a user encounters them. One row = one screen a designer needs to create in Figma. "In Figma" means a designer already has this. "Needs Design" means it's assigned this week.
>
> **Tab order in Trip Detail:** Itinerary → Activities → People → Stay → Vibe → Packing List → Expenses

---

### Flow 1: New User Onboarding (organic download)

> User downloads from App Store with no invite link.

| # | Screen | What the user sees | Figma? |
|---|--------|--------------------|--------|
| 1.1 | Welcome | Logo, tagline "Plan trips with friends", CTA button | In Figma |
| 1.2 | Phone Entry | Phone number field, country code picker, Apple Sign-In option | In Figma |
| 1.3 | OTP Verify | 6-digit code input, resend countdown timer | In Figma |
| 1.4 | Profile Setup | Display name, avatar upload (optional), countries visited (optional) | In Figma |
| 1.5 | Contacts Permission | Optional contacts access prompt (can skip) | Needs Design |
| 1.6 | Trips Home (empty) | Empty state with prompt: "Create your first trip" | Needs Design |
| 1.7 | Phone Entry — Invalid | Inline error: invalid/incomplete phone number. "Enter a valid phone number." | Dev handles |
| 1.8 | OTP — Wrong Code | Wrong 6 digits entered. "Incorrect code, try again." Inline error, field clears. | Dev handles |
| 1.9 | OTP — Expired | Code timed out. "Code expired" + "Resend code" CTA. | Dev handles |
| 1.10 | OTP — Max Retries | Too many wrong attempts. "Too many attempts, wait X minutes." Retry locked. | Dev handles |
| 1.11 | Apple Sign-In | Apple ID auth flow. If phone not yet linked, prompt to add phone number post-sign-in. | Dev handles |
| 1.12 | Loading States | Spinner/skeleton between: OTP submit → profile setup, profile submit → home. | Dev handles |

---

### Flow 2: Invite → Join (new user, no app)

> Someone receives a Tryps invite link via text. They don't have the app.

| # | Screen | What the user sees | Figma? |
|---|--------|--------------------|--------|
| 2.1 | App Store Redirect | Taps link → redirected to App Store to download Tryps | N/A (system) |
| 2.2 | Welcome | (Same as 1.1 — app opens post-install) | In Figma |
| 2.3 | Phone Entry | (Same as 1.2) | In Figma |
| 2.4 | OTP Verify | (Same as 1.3) | In Figma |
| 2.5 | Profile Setup | (Same as 1.4) | In Figma |
| 2.6 | Trip Card Hero | Trip overview: name, dates, destination, hero image, participant avatars. Big "Join This Trip" button | Needs Design |
| 2.7 | "You're In!" | Celebratory confirmation. RSVP auto-confirmed. | Needs Design |
| 2.8 | Enter My Vibe | CTA: "Enter my vibe" button. Brief explanation of Travel DNA. | Needs Design |
| 2.9 | Vibe Selection | 10 Travel DNA A/B choices (new user must complete all 10) | Needs Design |
| 2.10 | Land on Trip | → Trip Detail, **Itinerary tab** (default) | Needs Design |
| 2.11 | Expired/Invalid Invite | Link broken, trip deleted, or at capacity. Error state with "Go to App Store" or "Create your own trip" fallback. | Dev handles |
| 2.12 | Deep Link Lost (App Store) | User installs via App Store, invite context lost. "Enter invite code" fallback or manual trip search. | Dev handles |

---

### Flow 3: Invite → Join (existing user, has app)

> Someone receives a Tryps invite link. They already have the app and an account.

| # | Screen | What the user sees | Figma? |
|---|--------|--------------------|--------|
| 3.1 | Trip Card Hero | (Same as 2.6) Trip overview + "Join This Trip" button | Needs Design |
| 3.2 | "You're In!" | (Same as 2.7) Celebratory confirmation | Needs Design |
| 3.3 | Vibe Defaults | Pre-filled from existing DNA. Can accept or edit. | Needs Design |
| 3.4 | Land on Trip | → Trip Detail, **Itinerary tab** (default) | Needs Design |
| 3.5 | Inviter Context | Trip Card Hero shows "Jake invited you" — inviter name + avatar for social proof. | Dev handles |
| 3.6 | Decline | "Not for me" option on Trip Card Hero. Distinct from closing (X). Optional: notify inviter. | Dev handles |
| 3.7 | Vibe Pre-Fill from DNA | Pre-fill trip vibe from user's existing Travel DNA profile (not just trip-specific). Accept or edit. | Dev handles |
| 3.8 | Removed User Blocked | Previously removed user re-taps invite link → "You're no longer part of this trip." No rejoin. | Dev handles |
| 3.9 | Already a Member | User re-taps invite link while already in trip → "You're already in!" + "Open Trip" button. | Dev handles |

---

### Flow 4: Trip Creation — "Trip Menu"

> User taps the + FAB on the home screen to create a new trip. Designers call this the "Trip Menu." Each step is its own screen.

| # | Screen | What the user sees | Figma? |
|---|--------|--------------------|--------|
| 4.1 | Initial Trip Menu | Trip card with empty fields: Destination, Hotel, Dates, Extras | In Figma |
| 4.2 | Destination — Single | Single destination input with autocomplete | In Figma |
| 4.3 | Destination — Multi-City | "Planning to visit both?" with chip selection (e.g., Tokyo, Barcelona) | In Figma |
| 4.4 | Destination — Multi-City Confirm | "Yes — we're going to all of them" confirmation | In Figma |
| 4.5 | Destination — Group Vote | "Let the group weigh in" with seeded destinations + deadline picker | In Figma |
| 4.6 | When Are You Going | Date entry: exact dates, flexible, or group vote options | In Figma |
| 4.7 | Date Picker | Calendar overlay for selecting date range | In Figma |
| 4.8 | Adjust Day Per Stop | Multi-city: drag handles to allocate days per destination | In Figma |
| 4.9 | What's Your Vibe | Vibe quiz: activity types, group time, budget, exploration style | In Figma |
| 4.10 | What's Your Vibe — Full | Scrolled state showing all vibe dimensions | In Figma |
| 4.11 | Card Preview — Halfway | Trip card filling in as fields are completed | In Figma |
| 4.12 | Card Preview — Complete | Fully filled trip card, ready to create | In Figma |
| 4.13 | Card Preview — Full Page | Full-page review of the complete trip card | In Figma |
| 4.14 | Success / Share | Trip created! Copy link / Share via iMessage, Instagram / Skip | Needs Design |
| 4.15 | Autocomplete — No Results | Unknown destination typed. "No results" + "Add manually" option. | Dev handles |
| 4.16 | Flexible Date Input | "Flexible" date option: month range picker or season selector. Designer TBD on exact format. | Dev handles |
| 4.17 | Draft Save Warning | User closes wizard mid-flow. "Save as draft?" prompt. Without this, all progress lost. | Dev handles |
| 4.18 | Draft Resume | User returns to saved draft. Wizard reopens at last completed step. | Dev handles |
| 4.19 | Multi-City + Flexible Dates | Days-per-stop (4.8) requires exact dates. With flexible/skipped dates, skip 4.8 or prompt "Set dates first." | Dev handles |
| 4.20 | Change Answer Rollback | User changes multi-city → single. "This will reset your day allocation" warning before clearing. | Dev handles |
| 4.21 | Share — Vote Pending | Trip created with destination = group vote. Share card shows "Vote on where we're going!" variant. | Dev handles |

---

### Flow 5: Invite & Share (owner invites others)

> Trip owner wants to invite friends to the trip they just created.

| # | Screen | What the user sees | Figma? |
|---|--------|--------------------|--------|
| 5.1 | Quick Invite (Share) | Tap "Invite" → generates link, copies to clipboard, opens native share sheet | Needs Design |
| 5.2 | In-App Invite | Browse mutuals/friends on Tryps → tap to invite directly | Needs Design |
| 5.3 | Text Blast | Bulk SMS to participants with custom message | Needs Design |
| 5.4 | Invite Mode Picker | Bottom sheet when tapping "Invite": Quick Link / In-App / Text Blast options. | Dev handles |
| 5.5 | Copy Confirmation Toast | "Link copied!" toast/snackbar after generating invite link. | Dev handles |
| 5.6 | In-App Invite — Empty | 0 Tryps friends. "None of your contacts are on Tryps yet" + fallback to share link. | Dev handles |
| 5.7 | In-App Invite — Already Member | Contact already in trip. "Already going" badge, non-tappable row. | Dev handles |
| 5.8 | In-App Invite — Non-Tryps Contact | Contact not on Tryps. "Not on Tryps" badge. Tap → routes to SMS/link share. | Dev handles |
| 5.9 | Text Blast — Compose | Recipient selector + editable message template + character count. | Dev handles |
| 5.10 | QR Code | Full-screen QR code for in-person trip sharing. Scannable by camera app. | Needs Design |
| 5.11 | Pending Invitees | List of invited-but-not-joined people. Shows name/phone, time since invited, "Nudge" button to resend. | Needs Design |

---

### Flow 6: Trip Detail — Itinerary Tab (DEFAULT)

> First tab users see when entering a trip. Day-by-day trip plan.

| # | Screen | What the user sees | Figma? |
|---|--------|--------------------|--------|
| | | **Confirm in standup with designers — 12 screens already in Figma** | In Figma |

Includes: day cards, expanded day view, time scheduling, import flow (paste text → AI extract → review), drag-to-reorder, day picker strip, add-to-day flow. Itinerary ↔ Activities tab interaction already defined.

> **Dev notes (from pressure test):** (a) Add path to create new activity from Itinerary "Add to Day" modal, (b) Confirm drag-to-reorder implementation with designers, (c) Add multi-city section headers for multi-city trips, (d) After activity promoted to "Confirmed" → prompt "Which day?", (e) Fix empty day routing bug (currently routes to dinner-add screen instead of Add Action Modal).

---

### Flow 7: Trip Detail — Activities Tab

> Browse, suggest, vote on, and schedule activities.

| # | Screen | What the user sees | Figma? |
|---|--------|--------------------|--------|
| | | **Confirm in standup with designers — 11 screens already in Figma** | In Figma |

Includes: empty state, Ideas Pool (add/import), activity cards with voting icons, Discover section (Browse All), drag-to-confirm from Ideas Pool to Confirmed, activity detail, 3-step day assignment.

---

### Flow 8: Trip Detail — People Tab

> See who's going, their RSVP, flight info, and invite more people.

| # | Screen | What the user sees | Figma? |
|---|--------|--------------------|--------|
| 8.1 | People List (empty) | No participants yet, invite prompt | Needs Design |
| 8.2 | People List (populated) | All participants: avatar, name, RSVP (Going/Maybe — no "Can't Go", declining = leaving trip), flight info (airline, airport) inline. Header: "5 travelers" top-right. Invite prompt at top. | Needs Design |
| 8.3 | RSVP Change | User changes own RSVP. Placement TBD by designer (inline or in profile). | Needs Design |
| 8.4 | Participant Profile | Tap person → profile card (top) + trip status + payment handles + recent activity + shared trips. Owner sees inline actions (Remove, Make Co-Host) directly on this card — no separate screen. | Needs Design |
| 8.5 | Quick Invite | Tap "Invite" → link generated + clipboard + native share sheet | Needs Design |
| 8.6 | In-App Invite | Browse mutuals/friends on Tryps → tap to invite | Needs Design |
| 8.7 | Role Badges | Visual distinction on people list: Owner (crown/star), Co-Host (shield), Member (default). Inline with name. | Needs Design |
| 8.8 | Remove from Trip — Confirm | Owner taps remove → "Remove [Name]? They'll lose access to this trip." Confirm/Cancel dialog. | Needs Design |
| 8.9 | Make Co-Host | Owner action on participant profile → "Make Co-Host?" confirm dialog → badge updates on list. | Needs Design |
| 8.10 | Phantom Participant Row | Invited-by-phone, no account yet. No avatar (placeholder), "Pending" badge, phone (masked). Different visual treatment from active members. | Needs Design |
| 8.11 | Phantom Participant Profile | Tap phantom → minimal card: masked phone, "Hasn't joined Tryps yet", "Resend Invite" CTA. | Needs Design |
| 8.12 | Quick Invite — Error | Link generation fails (bad network). "Couldn't generate link" + Retry button. | Needs Design |
| 8.13 | In-App Invite — Empty | 0 Tryps friends. "None of your contacts are on Tryps yet" + fallback to share link. | Needs Design |
| 8.14 | RSVP Change Feedback | Toast/snackbar confirming RSVP saved: "RSVP updated to Going" (or Maybe/Can't Go). | Needs Design |

**Rules:** Settle-up is NOT here (Expenses only). Flight info visible on list. Two invite paths (share link + in-app). Role badges always visible on list.

> **Phasing note:** Flight info *display* on the People list (airline, airport, arrival time) is Phase 1. Flight *search and booking* (Amadeus/Duffel) is Phase 3. Phase 1 = manual flight entry only.

---

### Flow 9: Trip Detail — Stay Tab

> Find, compare, vote on, and confirm accommodations.

| # | Screen | What the user sees | Figma? |
|---|--------|--------------------|--------|
| 9.1 | Stay List (empty) | No accommodations, prompt to add first | Needs Design |
| 9.2 | Stay List (populated) | Cards with name, photo, price, dates, vote count. Per-city sections for multi-city trips. | Needs Design |
| 9.3 | Search Accommodations | In-app search across Airbnb, VRBO, Booking.com | Needs Design |
| 9.4 | Search Results | Results from providers: price, photos, ratings | Needs Design |
| 9.5 | Accommodation Detail | Full details, photos, price breakdown, external booking link | Needs Design |
| 9.6 | Add Accommodation (manual) | Manual entry: name, URL, price, dates, photos | Needs Design |
| 9.7 | Voting Active | Upvote/downvote on each option, vote counts visible | Needs Design |
| 9.8 | Kick Off Voting | Owner taps chip: "Lock in the stay" → triggers 48hr deadline + push to all | Needs Design |
| 9.9 | Voting Countdown | 48hr countdown active, badge on tab | Needs Design |
| 9.10 | Voting Complete | Winner announced, becomes confirmed stay | Needs Design |
| 9.11 | Confirmed Stay | Winning option shown as confirmed. Owner/co-host can override. | Needs Design |
| 9.12 | Multi-City Stays | Per-city accommodation sections. **Horizontal city pills** at top (same pattern as 4.8 day allocation). Tap pill → filters stay list to that city. | Needs Design |
| 9.13 | Mark as Booked | After voting winner (9.11), CTA to mark stay as actually booked. Triggers expense split creation (cost ÷ participants). Links to Expenses tab. | Needs Design |
| 9.14 | Photo Gallery | Swipeable full-screen photo viewer for accommodation photos. Attribution, pinch-to-zoom. | Needs Design |
| 9.15 | Search — No Results | 0 matches for query. "No results" message + "Add manually" fallback CTA. | Needs Design |
| 9.16 | Search — API Error | Provider search fails. "Something went wrong" + Retry + "Add manually" fallback. | Needs Design |
| 9.17 | URL Paste Flow | Paste Airbnb/VRBO/Booking URL → auto-parse name, price, photos, dates → review extracted fields → save. Separate from manual entry (9.6). | Needs Design |
| 9.18 | Voting Tie-Breaker | 48hr deadline ends in tie. Owner gets notification + in-app prompt to break tie manually by picking winner. | Needs Design |
| 9.19 | Zero Votes on Expiry | Timer expires, nobody voted. "No winner" state. Owner prompted to re-run vote or override. | Needs Design |
| 9.20 | Override Confirmation | Owner overrides group vote. "Override the group vote? [Option name] will become the confirmed stay." Confirm/Cancel. | Needs Design |
| 9.21 | Override — Member View | Members see "Owner's pick" label (vs "Group's pick") on confirmed stay. Different badge/treatment. | Needs Design |
| 9.22 | Edit Accommodation | Edit name, price, dates, photos, URL after adding. Same form as manual entry, pre-filled. | Needs Design |
| 9.23 | Delete Accommodation | "Delete this option?" confirmation. Handles: if it has votes (warn), if it's confirmed (block or double-confirm). | Needs Design |
| 9.24 | Stay Card States (5) | List screen (9.2) card has 5 visual states: pre-vote (neutral), voting active (pulse/badge), won (highlighted), lost (dimmed), owner-override (distinct badge). Designer defines treatments. | Needs Design |

**Rules:** Upvote/downvote only. Owner triggers 48hr deadline. Owner + co-hosts can override. Each city = own section. "Mark as Booked" bridges voting → expense split. Stay cards have 5 visual states.

---

### Flow 10: Trip Detail — Vibe Tab

> Group personality, music, and mood for the trip.

| # | Screen | What the user sees | Figma? |
|---|--------|--------------------|--------|
| 10.1 | Vibe Landing | Hero: group vibe summary. Sections stacked: Signature 5 → Music → Mood Board | Needs Design |
| 10.2 | Vibe Hero (populated) | Group vibe results after everyone takes the quiz | Needs Design |
| 10.3 | DNA Prompt | "What does the group want?" — prompts to take Travel DNA quiz | Needs Design |
| 10.4 | Music (empty) | Prompt to link Spotify playlist | Needs Design |
| 10.5 | Music (populated) | Linked Spotify playlist + trending music in destination city | Needs Design |
| 10.6 | Mood Board (empty) | Prompt to add first photo/video | Needs Design |
| 10.7 | Mood Board (populated) | Grid of group images/videos (max 10 photos + 10 videos) | Needs Design |
| 10.8 | Add to Mood Board | Camera roll / AI suggestions / curated picks | Needs Design |
| 10.9 | DNA Compatibility | Brief group overview based on everyone's quiz answers | Needs Design |
| 10.10 | DNA Quiz Entry (in-tab) | CTA on Vibe tab to take/retake Travel DNA. Links to Flow 14 standalone quiz. | Needs Design |
| 10.11 | Vibe Landing — Partial | 3 of 6 members completed DNA. Progress ("3 of 6"), who has/hasn't, "Nudge" CTA for incomplete members. Most common real-world state. | Needs Design |
| 10.12 | Photo/Video Fullscreen | Tap mood board item → fullscreen viewer. Attribution ("Added by Sara"), swipe between items, delete option (adder or owner). | Dev handles |
| 10.13 | Spotify Connection | Connect Spotify: OAuth flow or paste playlist URL. Loading state while linking. | Dev handles |
| 10.14 | Mood Board Limit | Hit 10 photos or 10 videos. "+" disabled, explanation text. "Delete one to add another." | Dev handles |
| 10.15 | Music — Edit/Remove | Change or unlink Spotify playlist. "Unlink playlist?" confirmation. | Dev handles |

**Rules:** Everyone can add to mood board. Max 10 photos + 10 videos. Dress code → moved to Packing List. DNA quiz accessible from Vibe tab via Flow 14.

---

### Flow 11: Trip Detail — Packing List Tab (NEW)

> Personal/group packing checklist + dress code.

| # | Screen | What the user sees | Figma? |
|---|--------|--------------------|--------|
| 11.1 | Packing List (empty) | Prompt to start packing list | Needs Design |
| 11.2 | Packing List (populated) | Checklist: clothes, toiletries, gear, etc. | Needs Design |
| 11.3 | Add Item | Manual add or pick from suggestions | Needs Design |
| 11.4 | Dress Code | Group dress code guidance (e.g., "Beach casual") | Needs Design |
| 11.5 | AI Suggestions | Destination + weather-based packing recommendations | Needs Design |
| 11.6 | Item Detail / Edit | Tap item → edit name, category, quantity, notes. | Dev handles |
| 11.7 | Category Sheet | Bottom sheet for picking or creating item categories. | Dev handles |
| 11.8 | Group Items — Claim/Assign | Group items (e.g., "2 tents needed"). Members claim ("I'll bring it") or owner assigns. Shows who's bringing what, unclaimed items highlighted. | Needs Design |
| 11.9 | Packing Complete | All items checked → celebration state: "You're ready for Lisbon!" | Dev handles |

**Model:** Two item types — **Personal** (AI-generated suggestions, individual checklist) and **Group** (shared needs like tents, coolers — claimable or assignable to specific people). AI generates initial list based on destination, weather, and activities.

---

### Flow 12: Trip Detail — Expenses Tab

> Add, split, track, and settle expenses. **23 states fully designed in Pencil — need Figma conversion.**

| # | Screen | What the user sees | Figma? |
|---|--------|--------------------|--------|
| 12.1 | Empty State | No expenses yet, prompt to add | Pencil → Figma |
| 12.2 | Inline Entry Active | Keyboard up, amount field, payer chip | Pencil → Figma |
| 12.3 | Payer Changed | Different payer selected | Pencil → Figma |
| 12.4 | Participant Deselected | One person excluded from split | Pencil → Figma |
| 12.5 | Expense Logged | Success: card appears in list | Pencil → Figma |
| 12.6 | Filled State | Balance bar + expense list + quick-add | Pencil → Figma |
| 12.7 | Filter/Sort | Filtered view by date, amount, payer, category | Pencil → Figma |
| 12.8 | Full Add Modal | All fields: amount, merchant, category, payer, split, notes, receipt | Pencil → Figma |
| 12.9 | Custom Split | Editable $ per person | Pencil → Figma |
| 12.10 | Percentage Split | Editable % per person | Pencil → Figma |
| 12.11 | Receipt Camera | Camera viewfinder | Pencil → Figma |
| 12.12 | Receipt OCR Review | Extracted fields, editable before saving | Pencil → Figma |
| 12.13 | Expense Detail | Full breakdown, edit/delete | Pencil → Figma |
| 12.14 | Delete Confirmation | "Are you sure?" dialog | Pencil → Figma |
| 12.15 | Balance — Personal | My net position, individual debts | Pencil → Figma |
| 12.16 | Balance — Group | All debts, minimized transactions | Pencil → Figma |
| 12.17 | Settle Up — Method | Venmo/Zelle/CashApp with pre-filled handles | Pencil → Figma |
| 12.18 | Settle Up — Pending | Yellow "Pending confirmation" badge | Pencil → Figma |
| 12.19 | Settle Up — Confirm | Payee taps: Confirm / Didn't Receive | Pencil → Figma |
| 12.20 | All Settled | Celebration! Green checkmark. | Pencil → Figma |
| 12.21 | 48hr Countdown | Post-trip expense cutoff banner (auto after trip ends OR owner triggers) | Pencil → Figma |
| 12.22 | Currency Selector | Searchable, trip-context suggested | Pencil → Figma |
| 12.23 | Payment Handle Prompt | First time owed → "Add your Venmo/Zelle/CashApp" | Pencil → Figma |
| 12.24 | "Didn't Receive" Resolution | Payee taps "Didn't Receive" → notify payer, revert expense to unsettled. | Dev handles |
| 12.25 | Mark Settled Outside App | Cash/in-person settlement. "Mark as Paid" without Venmo/Zelle/CashApp. Both parties confirm. | Dev handles |
| 12.26 | Post-48hr Locked State | After countdown expires, expenses locked. "Expenses locked" banner. Owner can unlock if needed. | Dev handles |
| 12.27 | Inline → Modal Escalation | "More options" link on inline entry (12.2) routes to full modal (12.8). | Dev handles |
| 12.28 | OCR → Modal Return | After receipt scan review (12.12), return to full modal (12.8) with extracted fields pre-filled. | Dev handles |
| 12.29 | Split Validation Error | Custom $ or % split doesn't sum to total. Inline error: "Split must equal $X" with remainder shown. | Dev handles |
| 12.30 | Payment Handle Not Set | Payer tries to settle but payee has no handles. "Alex hasn't set up payment handles" + nudge CTA. | Dev handles |
| 12.31 | Edit Settled Expense | Editing an expense after settlement resets settlement status. Warning: "This will reopen the settlement." | Dev handles |
| 12.32 | Payment Handle Dismiss | User dismisses handle prompt without adding. Returns to previous screen. Can be prompted again on next settle attempt. | Dev handles |

---

### Flow 13: Post-Trip State (NEW)

> What happens when a trip's end date passes. Transition from active → completed.

| # | Screen | What the user sees | Figma? |
|---|--------|--------------------|--------|
| 13.1 | Trip Complete Banner | Banner at top of trip detail: "This trip has ended!" with date. Replaces active trip header. | Needs Design |
| 13.2 | Tab Locking State | All tabs switch to read-only. Edit buttons hidden/disabled. Visual treatment (dimmed, lock icon, or subtle overlay). | Needs Design |
| 13.3 | Expense Settlement Prompt | If unsettled balances exist: prominent CTA "Settle up before it's too late!" Links to Expenses tab. 48hr countdown starts automatically. | Needs Design |
| 13.4 | Memories / Scrapbook Placeholder | New section or CTA: "Add trip memories." Photo upload, captions, group contributions. Placeholder for v1 — full feature TBD. | Needs Design |
| 13.5 | Trip Card (Completed) | Home screen trip card shows "Completed" badge. Different visual treatment from active trips. | Needs Design |
| 13.6 | Reopen Trip | Owner action: "Reopen trip" to unlock tabs temporarily (e.g., add a late expense). Confirmation dialog. | Needs Design |

**Rules:** Tabs become read-only after trip end date. Expenses tab stays editable during 48hr settlement window. Owner can reopen. Completed trips sort below active trips on home screen.

---

### Flow 14: Travel DNA — Standalone (NEW)

> Take, retake, or view Travel DNA quiz outside of onboarding or trip creation.

| # | Screen | What the user sees | Figma? |
|---|--------|--------------------|--------|
| 14.1 | DNA Entry (Profile) | "My Travel DNA" section on Profile screen. Shows current DNA summary or "Take the quiz" CTA if not completed. | Needs Design |
| 14.2 | DNA Entry (Vibe Tab) | From Vibe tab's DNA prompt (10.3), tap → launches standalone quiz. | Needs Design |
| 14.3 | Quiz — 10 Questions | Same A/B-style Travel DNA quiz as onboarding (2.9). Progress bar. Can quit mid-way (saves partial). | Needs Design |
| 14.4 | Quiz Complete — Results | Your Travel DNA profile: all 10 dimensions visualized. Persona label (e.g., "The Explorer"). Shareable. | Needs Design |
| 14.5 | Retake Quiz | "Retake" CTA on results screen. Confirmation: "This will replace your current DNA." Then back to 14.3. | Needs Design |
| 14.6 | Group Compatibility | View DNA compatibility with a specific trip group. Radar chart or comparison grid. Accessed from Vibe tab. | Needs Design |

**Rules:** DNA persists across trips. Retaking replaces the old profile. Trip-specific vibe questions (from trip creation/join) are separate from global DNA. Quiz accessible from Profile and Vibe tab.

---

### Flow 15: Calendar Tab (bottom nav)

> Month-view calendar with trip bars, countdowns, and holiday discovery. **Screens exist in code — need design polish, not net-new builds.**

| # | Screen | What the user sees | Exists in Code? | Figma? |
|---|--------|--------------------|-----------------|--------|
| 15.1 | Calendar Main | Year nav + horizontal month pills + calendar grid with trip bars + countdown card + year stats + timeline view | Yes (`calendar.tsx`) | Needs Design |
| 15.2 | Trip Bar Overlay | Colored bars spanning trip date ranges on calendar grid. Max 2 visible per row. | Yes (`TripBar.tsx`) | Needs Design |
| 15.3 | Overflow Sheet | "+N more" chip on days with 3+ trips → bottom sheet listing all trips for that day | Yes (BottomSheet in `calendar.tsx`) | Needs Design |
| 15.4 | Trip Countdown Card | Large countdown to next trip ("3 days!", "Tomorrow", "Today!") with trip name | Yes (`TripCountdown.tsx`) | Needs Design |
| 15.5 | Year Stats | Trips count, total days traveling, destinations visited for selected year | Yes (inline in `calendar.tsx`) | Needs Design |
| 15.6 | Timeline View | Vertical timeline with dot-and-line chronological trip cards (title, location, dates, avatars) | Yes (`TimelineView.tsx`) | Needs Design |
| 15.7 | Month Trip List | Sticky header "N trips in [Month]" + scrollable trip cards for selected month | Yes (`MonthTripList.tsx`) | Needs Design |
| 15.8 | Holiday Suggestion Panel | Tap holiday emoji → slide-up panel with holiday info + horizontal destination cards + "Curate your own" | Yes (`HolidaySuggestionPanel.tsx`) | Needs Design |
| 15.9 | Empty State | No trips yet. Prompt to create first trip or explore holidays. | TBD | Needs Design |
| 15.10 | Tap Trip → Navigate | Tap any trip bar/card/timeline item → navigate to trip detail | Yes (handlers exist) | Dev handles |

**What designers need to know:** All 8 visible screens exist and function. This is a **reskin/polish** job, not a build-from-scratch. Designers should screenshot the current app, then redesign with consistent visual language.

**Open questions for Jake:** *(to be filled via interview)*

---

### Flow 16: Explore Tab (bottom nav)

> Interactive 3D globe with country tracking, wishlists, friend overlays, and place discovery. **Screens exist in code — need design polish, not net-new builds.**

| # | Screen | What the user sees | Exists in Code? | Figma? |
|---|--------|--------------------|-----------------|--------|
| 16.1 | Explore Main (Globe) | 3D globe with visited (green), wishlist (gold) countries, pulsing pins, stats overlay (country count, %, continents) | Yes (`explore.tsx` + `GlobeView.tsx`) | Needs Design |
| 16.2 | Search Bar + Results | Top overlay search. Type → dropdown of matching countries (4) + places/hot spots (4). Tap → globe focuses + card opens. | Yes (`GlobeSearchBar.tsx`) | Needs Design |
| 16.3 | Country Info Card | Slide-up card: hero image, flag, title, capital, social proof (friends), CTA ("Plan trip" / "Plan with friends"), status toggles (Wishlist/Visited), info chips (language, currency, region), cuisine, hot spots with wishlist hearts, friends' activities, trip history | Yes (`CountryInfoCard.tsx`) | Needs Design |
| 16.4 | Friends Toggle | Frosted pill button toggling friend-visited heat map overlay on globe | Yes (`FriendsToggle.tsx`) | Needs Design |
| 16.5 | Globe Legend | Color key: Visited (green dot), Wishlist (orange dot) | Yes (`GlobeLegend.tsx`) | Needs Design |
| 16.6 | Wishlist Swap Sheet | "Swap into Top 5" modal showing current 5 ranked wishlist countries. Tap to replace. | Yes (`WishlistSwapSheet.tsx`) | Needs Design |
| 16.7 | Suggest Place Sheet | Form modal: country (read-only) + place name input + submit. Adds to hot spots. | Yes (`SuggestPlaceSheet.tsx`) | Needs Design |
| 16.8 | AI Chat Sheet | Sliding chat interface for AI-powered explore conversations. Message history + text input. | Yes (`ExploreChatSheet.tsx`) | Needs Design |
| 16.9 | Chat FAB | Floating action button to open AI chat | Yes (`ChatFAB.tsx`) | Needs Design |
| 16.10 | Confetti Animation | Celebratory confetti burst when marking a country as visited | Yes (`ConfettiAnimation.tsx`) | Dev handles |
| 16.11 | Discovery Prompt | First-time user intro to Explore tab features | Yes (`TravelMapDiscoveryPrompt.tsx`) | Needs Design |
| 16.12 | Empty State | 0 countries visited, 0 wishlist. Prompt to mark first country or explore. | TBD | Needs Design |

**What designers need to know:** All 11 visible screens exist and function. This is a **reskin/polish** job. The globe is WebView-powered (globe.gl) so globe styling is code-side, but all overlays, cards, and sheets need Figma treatment.

**Open questions for Jake:** *(to be filled via interview)*

---

### Flow 17: People Tab — Social (bottom nav)

> Friends list, activity feed, shared wishlists, and social discovery. **Screens exist in code — need design polish, not net-new builds.**

| # | Screen | What the user sees | Exists in Code? | Figma? |
|---|--------|--------------------|-----------------|--------|
| 17.1 | People Main | Own profile card (photo, stats: countries/trips/tripmates/furthest) + Bucket List Top 5 + Travel DNA widget + QR row + activity feed + filter chips (All/Tripmates/Contacts) + search + friend list | Yes (`people.tsx`) | Needs Design |
| 17.2 | Friend Requests Banner | Expandable pill showing pending request count. Expand → request cards with Accept/Decline. | Yes (`FriendRequestsBanner.tsx`) | Needs Design |
| 17.3 | Friend Activity Feed | Collapsible feed: new trips, bucket list adds, DNA completions, new joins, activity cards. Avatars + timestamps. | Yes (`FriendActivityFeed.tsx`) | Needs Design |
| 17.4 | Shared Wishes Section | Countries where friends share bucket list items. Flag + friend avatars + "Plan" CTA (→ create trip with destination + friends pre-filled) | Yes (`SharedWishesSection.tsx`) | Needs Design |
| 17.5 | Person Row | Single friend row: avatar, name, subtitle, follow/chevron button. Tap → profile. | Yes (`PersonRow.tsx`) | Needs Design |
| 17.6 | Contact Sync Card | "Find friends from contacts" CTA card injected at position 5 in list (if no contacts imported) | Yes (`ContactSyncCard.tsx`) | Needs Design |
| 17.7 | Bucket List Edit Modal | Manage Top 5 wishlist ranking | Yes (`BucketListSearchModal.tsx`) | Needs Design |
| 17.8 | Profile Share Card | Bottom sheet: avatar, name, QR code, profile URL, Copy Link + Share buttons | Yes (`ProfileShareCard.tsx`) | Needs Design |
| 17.9 | User Profile (other) | Tap friend → full profile: header, follow button, trips together, mutual friends, travel stats, countries visited | Yes (`profile/[userId].tsx`) | Needs Design |
| 17.10 | Mutual Friends Modal | Slide-up list of mutual friends with avatars | Yes (`MutualFriendsModal.tsx`) | Needs Design |
| 17.11 | Friends List (alt tab) | Dedicated friends list with search + requests + suggestions (UnifiedPeopleList) | Yes (`friends.tsx`) | Needs Design |
| 17.12 | Empty State | 0 friends. Prompt to sync contacts or share invite link. | TBD | Needs Design |

**What designers need to know:** All 11 visible screens exist and function. This is a **reskin/polish** job. The People tab is the most socially rich tab — designers should pay attention to the activity feed and shared wishes patterns as these drive viral loops.

**Open questions for Jake:** *(to be filled via interview)*

---

### Flow 18: Profile & Settings

> Account management, preferences, payment handles, and public profile. **Screens exist in code — need design polish, not net-new builds.**

| # | Screen | What the user sees | Exists in Code? | Figma? |
|---|--------|--------------------|-----------------|--------|
| 18.1 | Settings Main | Scrollable settings hub: profile banner (editable name + avatar), quick action grid, DNA progress, home airport, appearance toggle, notification prefs (7 types), payment accounts, privacy toggle, legal links, beta feedback, sign out, delete account | Yes (`settings.tsx`) | Needs Design |
| 18.2 | Quick Action Grid | 3-column tiles: Edit Profile, Countries, Travel DNA | Yes (`SettingsQuickActionGrid.tsx`) | Needs Design |
| 18.3 | DNA Progress Card | Horizontal card with animated progress ring + question count + arrow to DNA flow | Yes (`DnaProgressCard.tsx`) | Needs Design |
| 18.4 | Payment Accounts Section | View/edit mode for Venmo, PayPal, Cash App usernames + preferred method selector | Yes (inline in `settings.tsx`) | Needs Design |
| 18.5 | Countries Visited | Full screen: header with count + CountryPicker (toggle countries on/off) | Yes (`settings/countries.tsx`) | Needs Design |
| 18.6 | Notification Preferences | 7 toggle switches: expense added, settlement, dinner RSVP, new vote, trip invite, participant joined, bestie updates | Yes (inline in `settings.tsx`) | Needs Design |
| 18.7 | Appearance / Theme | Dark mode toggle + Light/Dark mode picker | Yes (inline in `settings.tsx`) | Needs Design |
| 18.8 | Delete Account | Confirmation dialog → account deletion flow | Yes (inline in `settings.tsx`) | Needs Design |
| 18.9 | Beta Feedback Modal | Report Bug button + feedback text input modal | Yes (inline in `settings.tsx`) | Needs Design |
| 18.10 | Profile Completeness Ring | SVG ring around avatar showing 4 segments: photo, home city, DNA, bucket list | Yes (`ProfileCompletenessRing.tsx`) | Needs Design |
| 18.11 | Own Profile View | Self-view of profile: header + My Trips list + travel stats + countries | Yes (`profile/[userId].tsx` self-mode) | Needs Design |

**What designers need to know:** Settings is ONE long scrollable screen with sections — not separate screens per setting. Designers should treat each section as a card/module within the scroll. The Countries screen (18.5) is the only separate full screen.

**Open questions for Jake:** *(to be filled via interview)*

---

### Cross-Flow Screens (NEW)

> Screens that don't belong to a single flow — app-level navigation, profile, and system states.

| # | Screen | What the user sees | Figma? |
|---|--------|--------------------|--------|
| X.1 | Trips Home — Populated | Multiple trip cards (active + past). Sort by upcoming date. Active trips above, completed below with "Completed" badge. | Needs Design |
| X.2 | Trip Detail Header/Hero | Top of trip detail above tab bar: trip name, dates, destination, hero photo, participant avatars, edit button. | Needs Design |
| X.3 | Profile & Settings | Change display name, avatar, payment handles (Venmo/Zelle/CashApp), notification prefs, Travel DNA link, log out. | Needs Design |
| X.4 | Returning User Cold Launch | App opens after 2+ weeks. Auth restored silently → land on Trips Home (or directly into trip if only one active). | Dev handles |
| X.5 | Tab Loading/Skeleton States | Skeleton screens for first tab load and tab switching. Consistent across all 7 tabs. | Dev handles |
| X.6 | Deep Link — Non-Member | User receives tripful://trip/123 but wasn't invited. "You weren't invited to this trip" + "Request to join" or back to home. | Dev handles |
| X.7 | Deep Link — Not Logged In | Auth wall intercepts deep link. Save intent → complete auth → resume navigation to intended trip. | Dev handles |
| X.8 | Notifications In-App | Notification center / activity feed: voting deadlines, expense reminders, new participants, RSVP changes. Bell icon on home. | Needs Design |
| X.9 | Success/Share Dedup | 4.14 (Trip Created → Share) and 5.1 (Quick Invite) are the same screen. Consolidate into one reusable share sheet. | Dev handles |

**Rules:** X10 (Flights) → Phase 3 per C1. X11 (Post-Trip) → Flow 13 per C4. X12 (Travel DNA) → Flow 14 per C6.

---

### Summary: What Needs Design This Week

| Flow | Screens | Status |
|------|---------|--------|
| 1. New User Onboarding | 12 | Mostly in Figma (2 need design), **6 dev handles** |
| 2. Invite → Join (new user) | 12 | 5 in Figma, 5 need design, **2 dev handles** |
| 3. Invite → Join (existing user) | 9 | 4 need design, **5 dev handles** |
| 4. Trip Creation (Trip Menu) | 21 | Mostly in Figma (1 needs design), **7 dev handles** |
| 5. Invite & Share | 11 | 3 need design, 2 new need design, **6 dev handles** |
| 6. Itinerary Tab | ~12 | In Figma — confirm in standup |
| 7. Activities Tab | ~11 | In Figma — confirm in standup |
| 8. People Tab | 14 | **14 need design** |
| 9. Stay Tab | 24 | **24 need design** |
| 10. Vibe Tab | 15 | 11 need design, **4 dev handles** |
| 11. Packing List Tab | 9 | 6 need design, **3 dev handles** |
| 12. Expenses Tab | 32 | 23 Pencil → Figma, **9 dev handles** |
| 13. Post-Trip State (NEW) | 6 | **6 need design** |
| 14. Travel DNA Standalone (NEW) | 6 | **6 need design** |
| 15. Calendar Tab (NEW) | 10 | 8 exist in code — **reskin**, 1 net-new, **1 dev handles** |
| 16. Explore Tab (NEW) | 12 | 11 exist in code — **reskin**, 1 net-new, **1 dev handles** |
| 17. People Tab — Social (NEW) | 12 | 11 exist in code — **reskin**, 1 net-new |
| 18. Profile & Settings (NEW) | 11 | All exist in code — **reskin** |
| Cross-Flow (NEW) | 9 | 4 need design, **5 dev handles** |
| **TOTAL** | **~240** | **~86 need design, ~45 reskin, ~47 dev handles** |

---

## 6. Non-Functional Requirements

### 6.1 Performance

| Requirement | Target |
|-------------|--------|
| App cold launch to interactive | < 3 seconds |
| Trip detail load time | < 2 seconds |
| Real-time sync latency | < 500ms |
| Expense calculation refresh | < 100ms |
| Image upload + OCR | < 5 seconds |

### 6.2 Offline Support

| Capability | Offline Behavior |
|------------|-----------------|
| View trips | Cached data available |
| Add expense | Queued, syncs when online |
| Create trip | Draft saved locally |
| View itinerary | Cached data available |
| Join trip | Requires network |
| Real-time updates | Resume on reconnect |

### 6.3 Security

| Requirement | Implementation |
|-------------|----------------|
| Authentication | Phone OTP via Supabase Auth |
| Authorization | Row-Level Security (RLS) on all tables |
| Data encryption | TLS in transit, AES at rest (Supabase) |
| API keys | Never in client code, edge functions only |
| Phone numbers | Normalized, never displayed to non-members |
| Payment handles | Visible only to trip members |

### 6.4 Supported Platforms

| Platform | Minimum Version |
|----------|----------------|
| iOS | 16.0+ |
| Android | API 24+ (Android 7.0) |
| Expo SDK | 54 |

### 6.5 Deep Link Scheme

| Scheme | Purpose |
|--------|---------|
| `tripful://` | In-app deep links |
| `https://jointryps.com` | Universal links (web → app) |
| `exp://` | Development (Expo Go) |

---

## 7. Outstanding Questions

> Questions that need answers from Jake before the FRD can be finalized. Organized by priority.

### Answered (Captured in Flows Above)

- ~~Settlement countdown~~ → Auto after trip end date OR owner triggers manually
- ~~Stay voting deadline~~ → Owner triggers 48hr via chip + push notification
- ~~Stay voting override~~ → Owner + co-hosts can override group vote
- ~~Web preview~~ → Not needed. Redirect straight to App Store.
- ~~Itinerary vs Activities sync~~ → Already defined by designers, confirm in standup
- ~~Packing List (new)~~ → New tab replaces dress code from Vibe tab

### Answered During Session 2 (Pressure Test Review)

- ~~Q5: Decline option on invites~~ → **Yes.** Decline = you're out of the trip entirely (like declining a calendar invite). Inviter gets notified.
- ~~Q19: RSVP model~~ → **Binary: Going/Maybe = in the trip. Decline = out entirely.** No "Can't Go but still in the group" state. You're either in the trip or you're not.
- ~~Q20: Removed participant's expenses~~ → **Expenses released.** Owner gets notification listing which expenses were affected.
- ~~Q21: Owner in People list~~ → **Yes.** Owner appears in their own People list.
- ~~Q23: Tie-breaker rule~~ → **Owner or co-host manually picks winner.**
- ~~Q24: Change vote~~ → **Yes.** Members can change/toggle votes during the voting window.
- ~~Q25: Voting window~~ → **Only during 48hr countdown.** One voting block, already established.
- ~~Q26: Vote attribution~~ → **Both names and counts visible.** Already designed.
- ~~Q34: Packing List model~~ → **Both.** Personal items (AI-generated, individual checklist) + Group items (shared needs — claimable/assignable).
- ~~Q42: Trips Home populated~~ → **Already designed.**
- ~~Q43: Profile/Settings~~ → **Yes, Phase 1 scope.**

### Still Open — Blocks Designer Work

1. ~~**Packing List: Personal or Shared?**~~ → Answered: Both (see above).

2. **Co-Host Permissions Boundary:** What exactly can co-hosts do that members cannot? Remove members? Change dates? Delete expenses?

3. **Trip Deletion & Data:** Soft-delete (recoverable) or hard-delete? What about associated flights and expenses?

4. ~~**Multi-City Stay UX**~~ → Horizontal city pills (same pattern as Trip Creation 4.8). Tap pill to filter.

5. ~~**Q22: Owner actions on participant profile card**~~ → Inline on the profile card itself. Not a separate screen.

6. ~~**Q28: "Signature 5"**~~ → Removed. Was never defined. Screen 10.3 renamed to "DNA Prompt."

### Still Open — Blocks Dev Work

7. **Voting Deadline Enforcement:** When destination/date voting deadline passes, what happens? Auto-lock? Notification to owner? Or just stays open?

8. **Multi-Currency Settlement:** Balance summary converts to one currency? Which exchange rate? At time of expense or time of settlement?

9. **Travel DNA Dimensions:** Are all 10 finalized? What are they exactly?

10. **Notification Strategy:** What push notifications does Tryps send? Frequency cap?

### Remaining Pressure Test Questions (Lower Priority)

11. **Q1:** Is display name required on profile setup, or can user skip?
12. **Q2:** Does Apple Sign-In skip OTP entirely, or is phone still required?
13. **Q3:** Does deferred deep linking work through the App Store? (Branch.io, AppsFlyer, or custom?)
14. **Q6:** Should removed users be blocked from rejoining via same link? *(FRD says yes per 3.8)*
15. **Q7:** Do invite links ever expire?
16. **Q8:** Where does the user enter the trip name? *(Per C2: already in designer flow)*
17. **Q9:** What does "Flexible" dates mean? Month range, season, or free text?
18. **Q10:** Can a trip be created with BOTH destination and dates as group vote (essentially empty)?
19. **Q11:** What does the "Hotel" field on 4.1 do?
20. **Q12:** What is "Extras" on 4.1?
21. **Q13:** Is Text Blast native iOS SMS or server-side (Twilio)?
22. **Q14:** Is QR code sharing in scope this sprint?
23. **Q15:** Revisit web preview decision? (Partiful's success is partly their gorgeous web preview)
24. **Q27:** Multi-city navigation in Stay: tabs within tab, city pills, or section headers?
25. **Q29:** What does DNA Compatibility (10.9) display — radar chart, percentages, persona labels?
26. **Q30:** Mood board cap (10 photos + 10 videos) per-person or per-trip?
27. **Q31:** Spotify only, or Apple Music too?
28. **Q32:** Spotify OAuth or paste URL?
29. **Q33:** Who can delete mood board items — only adder, or also owner/co-host?
30. **Q35:** Dress code: structured picker or freeform text?
31. **Q36:** Does AI packing suggestions read from Activities tab?
32. **Q38:** Does "+" default to inline expense entry or full modal?
33. **Q39:** After 48hr countdown, are new expenses hard-blocked or just nudged?
34. **Q40:** Can someone mark a debt as "settled in cash"? *(FRD says yes per 12.25)*
35. **Q41:** Can partial settlements happen? ($40 of $100 owed)
36. **Q44:** Returning user with one active trip: land in trip or home list?
37. **Q45:** Is there an in-app notification center / activity feed? *(FRD says yes per X.8)*

### Parked — Not Blocking This Week

38. Agent voting mechanics (P3)
39. Trip templates / cloning flow
40. Couple linking mechanics
41. Public trip publishing rules
42. Calendar device sync
43. Offline conflict resolution
44. Trip archival rules

---

## Glossary

| Term | Definition |
|------|-----------|
| **Trip Card** | The visual representation of a trip showing all sections (activities, itinerary, people, stay, vibe, expenses). A filled card = a planned trip. |
| **Travel DNA** | A user's travel preference profile built from A/B-style questions across 10 dimensions. |
| **Vibe** | The mood/personality of a trip, informed by group DNA, mood board, music, and dress code. |
| **Atomic Network** | a16z concept: the smallest viable group that makes the product work. For Tryps: one friend group successfully planning one trip. |
| **K-Factor** | Viral coefficient: average invites per user × conversion rate. K > 1 = organic growth. |
| **Linq** | Third-party iMessage integration provider enabling text-based interaction with Tryps. |
| **X-402** | Proposed micropayment protocol where agents receive HTTP 402 responses and auto-pay via Tryps Cash. |
| **Tryps Cash** | Agent execution wallet for funding API calls and micropayments in the Agent Layer. |
| **Duffel** | Flight booking API used in the Agent Layer for search, pricing, and booking. |
| **RLS** | Row-Level Security — Supabase/PostgreSQL feature enforcing data access rules per user. |
| **OTP** | One-Time Password — 6-digit code sent via SMS for phone authentication. |
| **FAB** | Floating Action Button — the center "+" button on the tab bar for creating trips. |
| **Phantom Participant** | A trip participant added by phone number who hasn't created a Tryps account yet. |

---

*This FRD is a living document. Version history tracked in git. Last updated: March 9, 2026.*

*Prepared with input from: Codebase audit (137K LOC, 50+ screens), Pencil design files (23 expense states), product context docs, user flow research (20 flows), and architectural vision documents.*
