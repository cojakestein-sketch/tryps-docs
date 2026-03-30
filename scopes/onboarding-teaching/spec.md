---
id: onboarding-teaching
title: "Onboarding & Teaching"
status: specced
assignee: nadeem
wave: 2
dependencies: [core-trip-experience, travel-identity]
clickup_ids: ["86e0emu6c"]
criteria_count: 14
criteria_done: 0
last_updated: 2026-03-30
links:
  objective: ./objective.md
  state: ./state.md
---

> Parent: [[onboarding-teaching/objective|Onboarding & Teaching Objective]]

# Onboarding & Teaching — Spec

## What

Eight contextual tooltips that teach first-time app users the core features. Four show on first trip open as a step-through sequence. Four trigger individually on first visit to other screens.

## Why

Every user arrives from iMessage. The app is the retention layer, but nobody knows what it does on first open. Eight lightweight tooltips — not a tutorial, not a walkthrough — just enough to make the value obvious without blocking anything.

## Intent

> "Basically we should just have a way of teaching the user how to use the app. Like eight tooltips scattered throughout the app. Four of them are probably when they click on their first trip for the first time and then other tooltips are like navigating the rest of the features."

## Key Concepts

**iMessage-first assumption:** Every first-time app user arrived from a group chat link. They already know the trip context. The tooltips teach "here's what the app can do that the chat can't" — not "here's what Tryps is."

**Two tooltip sets:** Set A (T1–T4) fires as a sequential step-through on first trip open. Set B (T5–T8) fires individually, each on first visit to its respective screen. Sets are independent — a user might see Set A today and T7 next week.

**Lightweight, not blocking:** Tooltips overlay the screen with a highlight on the target element. Tap anywhere to dismiss and advance. They never prevent the user from interacting with the underlying UI.

---

## Success Criteria

### Set A — First Trip Open (Sequential)

- [ ] **SC-1.** When a user opens a trip for the first time, a 4-step tooltip sequence begins automatically. The sequence is: T1 → T2 → T3 → T4. Each tooltip advances on tap. Skipping any tooltip skips the rest of the sequence.
  **Verified by:** New user opens a trip → sees T1 → taps → sees T2 → taps → sees T3 → taps → sees T4 → taps → tooltips gone. Re-opening the trip shows no tooltips.

- [ ] **SC-2.** **T1 — Itinerary (Overview tab).** Tooltip highlights the itinerary section and reads: "This is your trip. Drag to reorder your itinerary." Points to a draggable itinerary item.
  **Verified by:** Tooltip appears anchored to the itinerary section on the overview tab. Copy matches. Highlight is on a draggable element.

- [ ] **SC-3.** **T2 — Voting.** Tooltip highlights the activities/voting section and reads: "Suggest an activity and vote on it with your group." Points to the add-activity or vote button.
  **Verified by:** Tooltip appears anchored to the voting section. If no activities exist yet, points to the "+" or "suggest" action.

- [ ] **SC-4.** **T3 — Flights.** Tooltip highlights the flights section and reads: "Search flights for your group. Book when everyone's ready." Points to the flight search entry point.
  **Verified by:** Tooltip appears anchored to the flights section or search CTA.

- [ ] **SC-5.** **T4 — Share Trip Card.** Tooltip highlights the share action and reads: "Share this card to invite friends to your trip." Points to the share button or trip card.
  **Verified by:** Tooltip appears anchored to the share CTA. Tapping past it leaves the share button functional.

### Set B — App Exploration (Individual)

- [ ] **SC-6.** **T5 — Home Tab.** On first visit to the home/all-trips screen, a tooltip reads: "All your trips live here. Tap + to start a new one." Points to the create-trip button.
  **Verified by:** Navigate to home tab for the first time → tooltip appears. Second visit → no tooltip.

- [ ] **SC-7.** **T6 — Explorer Tab.** On first visit to the Explorer tab, a tooltip reads: "Track where you've been. Add your countries." Points to the country-add interaction.
  **Verified by:** Navigate to Explorer for the first time → tooltip appears. Second visit → no tooltip.

- [ ] **SC-8.** **T7 — Travel DNA.** On first visit to the Travel DNA / profile screen, a tooltip reads: "Take the quiz. The agent uses this to personalize your trips." Points to the quiz CTA.
  **Verified by:** Navigate to Travel DNA for the first time → tooltip appears. If quiz is already completed, tooltip does NOT appear.

- [ ] **SC-9.** **T8 — Expenses Tab.** On first visit to the expenses tab within a trip, a tooltip reads: "Log expenses and split with your group automatically." Points to the add-expense button.
  **Verified by:** Open expenses tab for the first time → tooltip appears. Second visit → no tooltip.

### Tooltip System

- [ ] **SC-10.** Tooltip dismissed state persists across app sessions. Once a user dismisses a tooltip (or completes the Set A sequence), it never shows again — even after app restart, logout/login, or app update.
  **Verified by:** Dismiss T6 → force-quit app → reopen → navigate to Explorer → no tooltip.

- [ ] **SC-11.** Tooltips never block the underlying UI interaction. The user can tap through the tooltip OR tap the highlighted element directly. Either action dismisses the tooltip.
  **Verified by:** With T2 (voting) showing, tap the actual add-activity button → tooltip dismisses AND the action fires.

- [ ] **SC-12.** Set A sequence only triggers on the FIRST trip the user opens. Opening a second trip does not re-trigger the sequence.
  **Verified by:** Complete Set A on Trip 1 → open Trip 2 → no tooltip sequence.

### Should NOT Happen

- [ ] **SC-13.** Tooltips never appear during active agent-driven flows. If the user opens a trip while the agent is sending messages or a vote is in progress, Set A defers until the next quiet open.
  **Verified by:** Agent is actively sending messages in trip → user opens trip in app → no tooltip sequence fires.

- [ ] **SC-14.** Typecheck passes.

---

### Out of Scope

- Full onboarding walkthrough or multi-screen tutorial
- iMessage-side onboarding (handled by iMessage Agent scope, SC-1 and SC-6)
- Vibe quiz in trip creation (already built)
- App download CTA from iMessage (already built — deep link to trip)
- Tooltip copy localization (English only for launch)

### Regression Risk

| Area | Why | Risk |
|------|-----|------|
| Trip overview rendering | Tooltip overlay on overview tab | Tooltip z-index conflicts with existing modals |
| Navigation state | Tooltip dismissed state stored per-user | State persistence across auth changes |
| Performance | 8 tooltip checks on screen transitions | Negligible if using simple boolean flags |

---

## Kickoff Prompt

**Scope:** Onboarding & Teaching
**Spec:** `scopes/onboarding-teaching/spec.md` (14 SC)
**What:** Eight contextual tooltips that teach first-time app users the core features. Set A (SC-1 through SC-5): 4-step sequential sequence on first trip open — itinerary drag, voting, flight search, share trip card. Set B (SC-6 through SC-9): individual tooltips on first visit to home, explorer, travel DNA, and expenses screens. System behavior (SC-10 through SC-14): persistence, non-blocking interaction, single-trigger, quiet-open deferral. Start with the tooltip component and persistence layer, then wire up Set A, then Set B.
