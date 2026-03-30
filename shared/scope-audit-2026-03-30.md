---
title: "Scope Audit: Pitch vs. Repo Alignment"
date: 2026-03-30
triggered_by: Martin Trust Center pitch (presentations/martin-trust-center-2026-03-30.html)
status: EXECUTED — all recommendations applied
---

# Scope Audit — 2026-03-30

The Martin Trust Center pitch presents **9 product scopes**. The repo currently tracks **13 scopes** (plus voice-calls added post-roadmap). This audit reconciles the two.

**Principle:** The pitch is the source of truth for strategy. The repo should match what we're telling investors and advisors.

---

## 1. Pitch vs. Repo Comparison

| Pitch Scope | Status in Pitch | Repo Scope(s) | Repo Status | Gap |
|---|---|---|---|---|
| Core Trip Experience | Testing · Nadeem · 15/16 | `core-trip-experience` | testing · 15/16 | **Aligned** |
| iMessage Agent | In Progress · Asif · 34/57 | `imessage-agent` | in-progress · 34/57 | **Aligned** |
| Agent Intelligence | In Progress · Rizwan · 55/61 | `agent-intelligence` | in-progress · 55/61 | **Aligned** |
| **Travel Booking & Payments** | In Progress · Asif + Rizwan | `travel-booking` + `payments-infrastructure` | in-progress · 0/58 + not-started · 0/12 | **Collapsed in pitch** — repo has 2 separate scopes |
| Beta & User Feedback | In Progress · Jake | `beta-user-feedback` | in-progress · 0/0 | **Aligned** |
| Group Decision-Making | Specced · 14 criteria | `group-decision-making` | specced · 0/14 | **Aligned** |
| Post-Trip & Retention | Specced · 39 criteria | `post-trip-retention` | specced · 0/39 | **Aligned** |
| Travel Identity | Needs Spec | `travel-identity` | needs-spec · 0/50 | **Aligned** |
| Onboarding & Teaching | Needs Spec | `onboarding-teaching` | needs-spec · 0/0 | **Aligned** |
| *(not in pitch)* | — | `output-backed-screen` | in-progress · 7/48 | **Missing from pitch** |
| *(not in pitch)* | — | `customer-service-triaging` | needs-spec · 0/0 | **Missing from pitch** |
| *(not in pitch)* | — | `voice-calls` | specced · — | **Missing from pitch** |
| *(not in pitch)* | — | `payments-infrastructure` | not-started · 0/12 | **Collapsed under Travel Booking in pitch** |

### Brand & GTM

The pitch dedicates a full slide to GTM (launch video, giveaway, UGC, ambassadors, social, physical presence). This is correctly tracked in `brand-and-gtm/` NOT in `scopes/`. No action needed.

### Architecture Slide — X-402 Protocol

The architecture slide mentions "X-402 Protocol — Agent-to-API micropayments" as part of the Agent Layer. This isn't explicitly tracked in any scope. It likely lives under Agent Intelligence or Travel Booking as an implementation detail, not a scope.

---

## 2. Recommendations

### COLLAPSE: `payments-infrastructure` → `travel-booking`

**Rename:** `travel-booking` → `travel-booking` (keep name, absorb payments)

The pitch already presents these as one: "Travel Booking & Payments." Payments (Stripe card-on-file, pay-on-behalf, auto-expense logging) is an implementation dependency of booking, not a separate capability area. This is the right call — users don't experience "payments" as a distinct product surface.

**Action:**
- Merge `payments-infrastructure/spec.md` criteria (12 SC) into `travel-booking/spec.md`
- Update `travel-booking` criteria count from 58 → 70
- Update assignees to Asif + Rizwan (already shown in pitch)
- Archive `payments-infrastructure/` folder (don't delete — move to `archive/`)
- Update INDEX.md and state.md

### DEFER: `voice-calls`

Voice calls (AI phone concierge) is a compelling feature but depends on iMessage Agent + Agent Intelligence being done first. Not in the pitch. Not started. The spec exists but no dev has picked it up.

**Action:**
- Move to deferred status in state.md (like AI Platform Connectors and Logistics Agent)
- Add note: "Post-launch. Depends on iMessage Agent + Agent Intelligence."
- Keep the scope folder — spec is good, just not on the critical path

### DEFER: `customer-service-triaging`

Needs-spec, 0/0, not in pitch. This is ops infrastructure that matters post-launch when real users hit real problems. Pre-launch, the team (Jake + Marty) handles support manually.

**Action:**
- Move to deferred status in state.md
- Add note: "Post-launch. Manual triaging until user volume justifies automation."

### KEEP (but clarify relationship): `output-backed-screen`

This is the hardest call. Output-Backed Screen (48 SC, 7/48 done, Nadeem actively building) is real, active work — but it's not in the pitch. Two possible reads:

**Option A — Fold into Core Trip Experience:** The pitch's "Core Trip Experience" implicitly includes the overview/itinerary deliverable. The output-backed screen IS the trip experience at its most tangible. Folding it in makes the repo match the pitch.

**Option B — Keep separate, accept the pitch simplifies:** The pitch collapses for narrative clarity. Nadeem needs a distinct scope with 48 SC to work against. Folding 48 criteria into an already-near-done scope (15/16) would be confusing.

**Recommendation: Option B — Keep separate.** The pitch simplifies for narrative. The repo needs operational precision. But add a note to INDEX.md that output-backed-screen is the "interactive layer" of Core Trip Experience, and that the pitch presents them as one.

---

## 3. Updated Scope List (Post-Audit)

If recommendations are accepted, the active scope list becomes **10 scopes** (pitch shows 9 because it doesn't distinguish output-backed-screen):

| # | ID | Title | Status | Assignee | Criteria | Notes |
|---|-----|-------|--------|----------|----------|-------|
| 1 | core-trip-experience | Core Trip Experience | testing | nadeem | 15/16 | Bug testing |
| 2 | imessage-agent | iMessage Agent | in-progress | asif | 34/57 | |
| 3 | agent-intelligence | Agent Intelligence | in-progress | rizwan | 55/61 | |
| 4 | travel-booking | Travel Booking & Payments | in-progress | asif, rizwan | 0/70 | Absorbs payments-infrastructure (12 SC) |
| 5 | output-backed-screen | Output-Backed Screen | in-progress | nadeem | 7/48 | Pitch groups with Core Trip |
| 6 | beta-user-feedback | Beta & User Feedback | in-progress | jake | 0/0 | Ongoing |
| 7 | group-decision-making | Group Decision-Making | specced | rizwan | 0/14 | |
| 8 | post-trip-retention | Post-Trip & Retention | specced | nadeem | 0/39 | |
| 9 | travel-identity | Travel Identity | needs-spec | jake | 0/50 | Jake to spec |
| 10 | onboarding-teaching | Onboarding & Teaching | needs-spec | jake | 0/0 | Jake to spec |

**Deferred (post-launch):**

| ID | Title | Status | Notes |
|----|-------|--------|-------|
| voice-calls | Voice Calls | deferred | Spec exists. Post-launch. |
| customer-service-triaging | Customer Service & Triaging | deferred | Needs spec. Post-launch. |
| *(existing)* | AI Platform Connectors | deferred | Already deferred |
| *(existing)* | Logistics Agent | deferred | Already deferred |

---

## 4. MECE Check

Does the updated list still cover everything mutually exclusively and collectively exhaustively?

| User Journey Stage | Covered By |
|---|---|
| First contact (iMessage text) | iMessage Agent |
| First contact (app download) | Onboarding & Teaching |
| Trip creation & management | Core Trip Experience |
| Group alignment & voting | Group Decision-Making |
| Who you are as a traveler | Travel Identity |
| Searching & booking travel | Travel Booking & Payments |
| Seeing the trip come together | Output-Backed Screen |
| Smart recommendations & memory | Agent Intelligence |
| After the trip | Post-Trip & Retention |
| Testing & feedback | Beta & User Feedback |
| Brand, launch, distribution | brand-and-gtm/ (separate) |

**Verdict:** MECE still holds. No user-facing capability falls through the cracks. Customer service and voice calls are deferred, not missing — they're post-launch ops and channel expansion.

---

## 5. Questions for Jake

1. **Travel Booking name:** The pitch says "Travel Booking & Payments." Should we rename the scope folder/ID to `travel-booking-payments` or keep `travel-booking` and just note that payments is absorbed? (Leaning: keep `travel-booking`, less churn.)

2. **Output-Backed Screen in next pitch iteration:** Should this get its own card in future pitches, or does "Core Trip Experience" cover it narratively? The 48 SC are real work — might be worth showing progress separately to advisors.

3. **X-402 Protocol:** The architecture slide mentions it. Is this tracked as criteria within Agent Intelligence or Travel Booking? Or is it aspirational for the pitch and not yet scoped?

4. **Voice Calls timing:** The spec is solid. Is there a target date post-launch, or is this indefinitely deferred? Might be worth mentioning in pitch as "next horizon" to show pipeline depth.
