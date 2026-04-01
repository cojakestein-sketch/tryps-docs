---
generated: 2026-03-30
total_scopes: 9
---

# Scopes Index

9 active scopes. All specs written. Aligned to Martin Trust Center pitch (2026-03-30).

Brand/GTM in `brand-and-gtm/`. Voice Calls + Customer Service deferred post-launch. OBS folded into Core Trip. Payments absorbed into Travel Booking. QA is cross-cutting.

**Agent reading order:** INDEX.md → state.md → objective.md → spec.md

| # | ID | Title | Status | Assignee | SC | Notes |
|---|-----|-------|--------|----------|-----|-------|
| 01 | [[core-trip-experience/objective|core-trip-experience]] | Core Trip Experience | **testing** | nadeem | 15/16 | OBS folded in |
| 02 | [[imessage-agent/objective|imessage-agent]] | iMessage Agent | **done** | asif | 51/57 | 6 blocked on scope 8 |
| 03 | [[agent-intelligence/objective|agent-intelligence]] | Agent Intelligence | **in-progress** | rizwan | 55/61 | |
| 04 | [[travel-booking/objective|travel-booking]] | Travel Booking & Payments | **in-progress** | asif, rizwan | 0/70 | Payments absorbed (SC-59–70) |
| 05 | [[beta-user-feedback/objective|beta-user-feedback]] | Beta & User Feedback | **in-progress** | jake | — | Ongoing |
| 06 | [[group-decision-making/objective|group-decision-making]] | Group Decision-Making | **specced** | rizwan | 0/14 | |
| 07 | [[post-trip-retention/objective|post-trip-retention]] | Post-Trip & Retention | **specced** | nadeem | 0/31 | Migrated from archive |
| 08 | [[travel-identity/objective|travel-identity]] | Travel Identity | **specced** | nadeem | 0/50 | DNA (25) + Connectors (25) |
| 09 | [[onboarding-teaching/objective|onboarding-teaching]] | Onboarding & Teaching | **specced** | nadeem | 0/14 | 8 tooltips |

### Deferred (Post-Launch)

| ID | Title | Notes |
|----|-------|-------|
| voice-calls | Voice Calls | **Done** — Tryps agent + Marty voice both live. 14/14 SC. |
| customer-service-triaging | Customer Service & Triaging | Needs spec. Manual triaging pre-launch. |
| output-backed-screen | Output-Backed Screen | Folded into Core Trip Experience. |
| payments-infrastructure | Payments Infrastructure | Absorbed into Travel Booking (SC-59–70). |

See [[brand-and-gtm/README|Brand & GTM]] for brand/launch scopes.

## Per-Scope File Structure

Each scope folder contains:

| File | Purpose | Who writes it |
|------|---------|--------------|
| `objective.md` | What + why + success looks like | Jake |
| `spec.md` | Engineering spec with success criteria | Jake → dev |
| `design.md` | What needs Figma input | Jake → designer |
| `testing.md` | QA criteria + test plan | Extracted from spec → Andreas |
| `state.md` | Living progress | Marty (auto) + Jake (verify) |
| `refs/` | Reference material (optional) | Anyone |
