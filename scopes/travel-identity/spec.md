---
id: travel-identity
title: "Travel Identity"
status: specced
assignee: nadeem
wave: 2
dependencies: [core-trip-experience]
clickup_ids: ["86e0emu52", "86e0emu86"]
criteria_count: 50
criteria_done: 0
last_updated: 2026-03-30
links:
  objective: ./objective.md
  state: ./state.md
---

> Parent: [[travel-identity/objective|Travel Identity Objective]]

# Travel Identity — Spec

## What

A travel identity layer with two halves: (1) Travel DNA — a shareable personality quiz, per-trip preferences, nudges to drive completion, and privacy-first group vibe summaries. (2) Connectors — link airline loyalty accounts, hotel rewards, rideshare, plus securely store passport and travel documents. Connected accounts persist across all trips so bookings automatically earn points and pre-fill details.

## Why

The agent needs to know who you are as a traveler. Travel DNA captures preferences and personality. Connectors capture loyalty programs and documents. Together they power personalized recommendations, automatic loyalty point earning, and frictionless international bookings.

## Intent

> "It's not a compatibility score. We're seeing how people want to spend their time and tailoring recommendations. Spotify Wrapped vibes — personal, shareable, identity-forming."

> "I use Marriott, so I connect my Marriott account. If I book through Tryps, I still get my points. Passports need to be really secure."

## Key Concepts

- **Travel DNA Quiz:** existing A/B choice quiz with 220+ questions, 4 tiers, 10 dimensions, persona archetypes
- **Sharing Card:** Spotify Wrapped-style shareable image of travel personality
- **Per-Trip Preferences:** free-text field for trip-specific considerations
- **Group Vibe Summary:** aggregate group traits without exposing individual answers
- **Connector Hub:** link airline, hotel, rideshare, rental accounts with loyalty numbers
- **Travel Documents:** encrypted passport and Known Traveler Number storage
- **Booking Passthrough:** loyalty numbers auto-applied at booking time

---

## Success Criteria

### Part 1: Travel DNA

#### Sharing Card

- [ ] **SC-1.** User can generate a shareable image of their travel personality from the My DNA tab. Verified by: user who completed the core 10 questions -> taps Share on the My DNA tab -> image generated showing persona name, top trait pills, radar chart, and Tryps branding -> native share sheet opens with the image ready to send.

- [ ] **SC-2.** Sharing card displays the user's current persona archetype, their strongest trait pills, and the 10-dimension radar chart. Verified by: user with "Adventurous Explorer" persona and 4 strong traits -> generates card -> card shows "Adventurous Explorer" title, all 4 trait pills, radar chart with 10 axes, and Tryps logo.

- [ ] **SC-3.** Shared card image renders correctly at standard social media dimensions. Verified by: generate card -> save to camera roll -> open in Photos -> image is clear, text is legible, no cropping of persona name or chart on a standard phone screen.

#### Per-Trip Free-Text

- [ ] **SC-4.** Each trip has a free-text field on the Vibe tab where users describe special considerations for that trip. Verified by: user opens Vibe tab for a trip -> scrolls to free-text field -> types "I tore my ACL — no hiking or long walks" -> text saves -> reopening the Vibe tab shows the saved text.

- [ ] **SC-5.** The same free-text field appears at the bottom of the 10-question core quiz when a user joins a trip. Verified by: user joins a new trip -> completes the 10 core DNA questions -> free-text field appears below the last question with placeholder like "Anything special for this trip?" -> user types preferences -> text saves to that trip.

- [ ] **SC-6.** Free-text preferences are per-trip, not global. Verified by: user writes "I'm injured" on Trip A -> opens Trip B -> free-text field for Trip B is empty -> Trip A still shows "I'm injured."

- [ ] **SC-7.** Free-text preferences are private to the user who wrote them. Verified by: user writes preferences on Trip A -> another trip member opens the same trip's Vibe tab -> they do not see the first user's free-text content.

#### Nudges

- [ ] **SC-8.** After completing signup, users who have not taken the DNA quiz see a prompt to discover their travel personality. Verified by: new user completes signup with zero DNA answers -> prompt appears (e.g., "Discover your travel personality — takes 2 minutes") -> tapping it opens the DNA quiz.

- [ ] **SC-9.** Post-onboarding nudge does not reappear after the user completes the core 10 questions. Verified by: user completes all 10 core questions -> navigates back to home -> onboarding nudge no longer appears.

- [ ] **SC-10.** When a user creates a trip and has not completed the core DNA quiz, a prompt appears during trip creation. Verified by: user with zero DNA answers taps "Create Trip" -> during the creation flow, a nudge appears (e.g., "Complete your Travel DNA for smarter trip suggestions") -> user can dismiss or tap to take the quiz.

- [ ] **SC-11.** Trip creation nudge does not block trip creation. Verified by: user sees the DNA nudge during trip creation -> dismisses it -> trip is still created successfully.

- [ ] **SC-12.** On a trip's People tab, a status indicator shows how many members have completed their DNA. Verified by: trip with 5 members, 3 have completed DNA -> People tab shows "3 of 5 completed Travel DNA" or equivalent visual.

- [ ] **SC-13.** Members who have not completed DNA are visually distinguishable from those who have, without revealing anyone's answers. Verified by: People tab shows member avatars -> completed members have a checkmark or filled indicator -> incomplete members show a prompt or unfilled indicator -> no scores, traits, or answers are visible for any member.

- [ ] **SC-14.** User's profile card shows DNA completion progress when the core quiz is partially complete. Verified by: user answers 7 of 10 core questions -> profile card shows a progress indicator (e.g., "7/10") -> completing all 10 replaces the progress bar with their persona name.

- [ ] **SC-15.** The Tryps agent sends a contextual message to the group chat when DNA data would improve a recommendation but members haven't completed it. Verified by: trip has 4 members, 2 incomplete -> agent is generating activity recommendations -> agent sends a message tied to the moment (e.g., "I'd give you better activity picks if everyone filled out their Travel DNA — 2 people haven't yet") -> message appears in the trip's group chat.

- [ ] **SC-16.** Agent DNA nudge fires at most once per trip. Verified by: agent sends DNA nudge for a trip -> same trip triggers recommendation generation again later -> no second nudge message is sent.

#### Group Vibe Summary

- [ ] **SC-17.** When enough trip members complete DNA, the trip displays a group vibe summary showing approximately three commonalities about the group. Verified by: 4 of 5 members complete DNA, all lean toward adventure and early mornings -> trip shows a group vibe section with ~3 commonalities like "Adventure seekers," "Early risers," "Budget-conscious."

- [ ] **SC-18.** Group vibe summary does not expose any individual's scores, answers, or dimension positions. Verified by: inspect the group vibe summary for a trip -> only aggregate traits visible (e.g., "Your group likes adventure") -> no individual names linked to specific preferences -> no numerical scores shown.

- [ ] **SC-19.** Group vibe summary updates when a new member completes their DNA. Verified by: trip shows "Adventure seekers, Early risers" with 3 members -> 4th member completes DNA with luxury and nightlife preferences -> group vibe summary recalculates and may shift (e.g., adds "Mixed on nightlife").

#### Privacy

- [ ] **SC-20.** Individual DNA answers, dimension scores, persona, and radar chart are never visible to other trip members anywhere in the app. Verified by: inspect all trip screens (People tab, Vibe tab, group vibe summary, activity recommendations) -> no individual DNA data from other members is displayed.

- [ ] **SC-21.** The sharing card is the only way another person sees your DNA details, and it requires the user to explicitly tap Share. Verified by: user does not tap Share -> their persona, traits, and radar are not visible to anyone else in any context -> user taps Share and sends via iMessage -> recipient sees the card image.

#### Should NOT Happen

- [ ] **SC-22.** Individual DNA answers or scores are never included in API responses to other users. Verified by: inspect network requests on the People tab and group vibe summary -> responses contain only aggregate data and completion booleans, never another user's raw answers or dimension scores.

- [ ] **SC-23.** Nudges never block or interrupt core app flows. Verified by: trigger each of the 5 nudge touchpoints -> in every case, the user can dismiss the nudge and continue their original task (signup, trip creation, browsing People tab) without completing the quiz.

- [ ] **SC-24.** The app never labels the group output as a "compatibility score" or shows a numerical compatibility percentage to users. Verified by: search all user-facing text in the trip -> no "compatibility score," "match percentage," or numerical group rating appears.

- [ ] **SC-25.** Typecheck passes.

### Part 2: Travel Life Connectors

#### Connector Hub

- [ ] **SC-26.** User can open a "Connected Accounts" screen from their profile settings. Verified by: user taps profile icon -> taps "Connected Accounts" -> screen displays a list of supported travel services (airlines, hotels, rideshare, vacation rentals) grouped by category, each showing "Connected" or "Not connected."

- [ ] **SC-27.** User can connect an airline loyalty account by selecting an airline (e.g., American Airlines, Delta, United) and entering their frequent flyer number. Verified by: user taps "American Airlines" -> enters AAdvantage number -> taps Save -> screen shows American Airlines as "Connected" with the last 4 digits of the number visible.

- [ ] **SC-28.** User can connect a hotel rewards account by selecting a hotel chain (e.g., Marriott Bonvoy, Hilton Honors) and entering their rewards number. Verified by: user taps "Marriott" -> enters Bonvoy number -> taps Save -> screen shows Marriott as "Connected."

- [ ] **SC-29.** For services that support OAuth login (e.g., Airbnb, Uber, Lyft), tapping "Connect" opens the service's login page and links the account after the user authenticates. Verified by: user taps "Connect" on Airbnb -> Airbnb login page opens in a browser -> user signs in and authorizes -> redirected back to Tryps -> Airbnb shows as "Connected."

- [ ] **SC-30.** Loyalty and rewards numbers are validated before saving. If a number does not match the provider's expected format, the user sees an error and the number is not saved. Verified by: user enters "XYZ" as an American Airlines AAdvantage number -> error message appears (e.g., "That doesn't look like a valid AAdvantage number") -> number is not saved -> user enters a correctly formatted number -> saves successfully.

- [ ] **SC-31.** Connected accounts are linked to the user's profile and persist across all trips — not per-trip. Verified by: user connects American Airlines -> creates Trip A -> creates Trip B -> both trips can access the same AA loyalty number without re-entering it.

- [ ] **SC-32.** User can disconnect a previously linked account and the stored data is permanently deleted. Verified by: user opens Connected Accounts -> taps American Airlines (connected) -> taps "Disconnect" -> confirms -> American Airlines shows "Not connected" -> reconnecting later requires re-entering the number.

- [ ] **SC-33.** The Connected Accounts screen shows a progress indicator encouraging users to link more services. Verified by: user with 2 of 8 supported services connected -> screen shows "2 of 8 connected" with a progress bar or ring and text encouraging more connections.

#### Travel Documents

- [ ] **SC-34.** User can store passport details including full legal name, passport number, nationality, date of birth, issue date, and expiration date. Verified by: user opens "Travel Documents" from profile -> taps "Add Passport" -> fills all fields -> saves -> passport details appear on the Travel Documents screen with the passport number partially masked.

- [ ] **SC-35.** User can store a Known Traveler Number (Global Entry / TSA PreCheck). Verified by: user opens Travel Documents -> taps "Add Known Traveler Number" -> enters number -> saves -> number appears on the Travel Documents screen.

- [ ] **SC-36.** Passport and travel document data is encrypted at rest in the database — never stored as plaintext. Verified by: query the database table storing passport data -> values in the passport number and Known Traveler Number columns are encrypted and unreadable without the decryption key.

- [ ] **SC-37.** Travel document data is accessible only to the user who owns it and to the booking system at the moment of booking. No other user or trip member can view it. Verified by: User A stores passport details -> User B (same trip) inspects all app screens and API responses -> no trace of User A's passport number, nationality, or date of birth appears.

- [ ] **SC-38.** The app warns the user when their stored passport expiration date is within 6 months of today. Verified by: user stores a passport expiring in 4 months -> Travel Documents screen shows a warning badge (e.g., "Expires in 4 months — some countries require 6+ months validity") -> user updates passport with later expiration -> warning disappears.

- [ ] **SC-39.** Viewing or editing travel documents requires re-authentication via device biometrics (Face ID / Touch ID) or device PIN. Verified by: user taps "Travel Documents" -> device biometric prompt appears -> only after successful authentication are document details revealed -> canceling authentication returns to profile without showing data.

#### Booking Passthrough

- [ ] **SC-40.** When a user books a flight through Tryps, their stored frequent flyer number for that airline is automatically included in the booking request. Verified by: user with a stored AA AAdvantage number books an American Airlines flight -> booking confirmation references the frequent flyer number -> miles are credited to the user's loyalty account.

- [ ] **SC-41.** When one user books flights for the entire group, each group member's individual frequent flyer number is attached to their respective booking. Verified by: trip with 4 members, 3 have AA numbers stored -> group AA flight booked -> the 3 members' individual AA numbers appear on their respective booking confirmations -> the 4th member's booking proceeds without a loyalty number.

- [ ] **SC-42.** When a user books a hotel through Tryps, their stored hotel rewards number is included in the booking request. Verified by: user with a Marriott Bonvoy number books a Marriott hotel -> booking confirmation references the Bonvoy number -> points are credited.

- [ ] **SC-43.** When booking an international flight, stored passport details (legal name, number, nationality, date of birth, expiration) are passed to the booking API so the user does not re-enter them. Verified by: user with stored passport books an international flight -> booking API receives passport data -> no manual passport entry screen appears during checkout.

- [ ] **SC-44.** If a group member has no loyalty number for the booking provider, that member's booking proceeds normally without a loyalty number — no error or blocking prompt. Verified by: user with no Delta SkyMiles number books a Delta flight -> booking completes successfully -> user simply does not earn miles for that flight.

#### People Tab Badges

- [ ] **SC-45.** On a trip's People tab, small provider logo badges appear next to each member's name showing which travel services they have connected. Verified by: trip People tab -> "Quinn" shows an American Airlines logo badge and a Marriott logo badge -> "Jake" shows Delta and Hilton badges -> a member with no connections shows no badges.

- [ ] **SC-46.** Tapping a member's connection badge does not reveal their loyalty number, account details, or any personal data — only that they are connected to that service. Verified by: user taps Quinn's AA badge -> no account number, loyalty details, or personal information is displayed -> at most a label like "Quinn is connected to American Airlines."

#### Should NOT Happen

- [ ] **SC-47.** Passport numbers, travel document details, and full loyalty account numbers are never visible to other trip members anywhere in the app. Verified by: inspect the People tab, trip details, group chat, and all visible screens for a trip -> no other member's passport data or full loyalty numbers appear.

- [ ] **SC-48.** Travel document and loyalty data is never included in API responses to other users. Verified by: call the trip members API authenticated as User B -> response for User A contains only connection status (connected/not connected per service), never passport numbers or loyalty account numbers.

- [ ] **SC-49.** Disconnecting an account permanently deletes the stored number — no soft-delete, no retention. Verified by: user disconnects AA -> query the database for that user's AA entry -> no record or remnant exists.

- [ ] **SC-50.** Typecheck passes.

### Out of Scope

- Recommendation engine (Travel DNA powers it, but algorithm is Agent Intelligence scope)
- Quiz redesign (existing quiz is shipped, no changes)
- Payment processing (Stripe is in Travel Booking scope)
- OAuth API implementation details (deferred to plan phase)

### Regression Risk

| Area | Why | Risk |
|------|-----|------|
| Vibe tab | Adding free-text field to existing tab layout | Medium |
| Core quiz flow | Appending free-text field after 10th question | Medium |
| People tab | Adding completion indicators and connection badges to existing member list | Low |
| Profile card | Adding progress indicator to existing card component | Low |
| User profile | New sections (Connected Accounts, Travel Documents) added to existing profile screen | Medium |
| Database security | Encrypted passport storage adds column-level encryption to the data layer | High |
| Booking flow | Passing loyalty/passport data to booking APIs at transaction time | Medium |

---

## Kickoff Prompt

**Scope:** Travel Identity
**Spec:** `scopes/travel-identity/spec.md` (50 SC)
**What:** Two-part scope. Part 1 — Travel DNA (SC-1 to SC-25): shareable personality card, per-trip free-text preferences, 5 nudge touchpoints, group vibe summary, privacy. Part 2 — Connectors (SC-26 to SC-50): airline/hotel/rideshare account linking, passport storage with encryption, booking passthrough for loyalty numbers, People tab badges. Start with Part 1 (Travel DNA), then Part 2 (Connectors). Part 2 depends on Part 1 being functional. Existing DNA code at `/t4/constants/travelDna/`, `/t4/utils/travelDnaScoring.ts`.
