---
generated: 2026-03-24
total_scopes: 13
---

# Scopes Index

13 MECE capability areas covering everything Tryps needs. Flat folder structure — no phase nesting.

Updated 2026-03-24: removed brand-design-system, launch-gtm (moved to `brand-and-gtm/`), ai-platform-connectors, logistics-agent. Added customer-service-triaging.

**Agent reading order:** INDEX.md → state.md → objective.md → spec.md

| # | ID | Title | Where it lives | Status | Assignee |
|---|-----|-------|----------------|--------|----------|
| 1 | beta-user-feedback | Beta & User Feedback | Jake's iMessages, outreach | in-progress | jake |
| 2 | core-trip-experience | Core Trip Experience | Trip card (mobile app) | built (needs testing) | — |
| 3 | group-decision-making | Group Decision-Making | iMessage, trip card | **TBD** | nadeem |
| 4 | travel-identity | Travel Identity | People + profile tab | partial | nadeem |
| 5 | onboarding-teaching | Onboarding & Teaching | Mobile app (everywhere), iMessage | partial | jake |
| 6 | post-trip-retention | Post-Trip & Retention | Mobile app (after trip card), iMessage | partial | nadeem |
| 7 | imessage-agent | iMessage Agent | iMessage | in-progress | asif |
| 8 | agent-intelligence | Agent Intelligence | Backend, mobile; Claude Connector in external services | not-started | rizwan |
| 9 | payments-infrastructure | Payments Infrastructure | Backend, mobile, iMessage frontend | not-started | asif |
| 10 | travel-booking | Travel Booking | iMessage, mobile, backend | specced | asif |
| 11 | qa-testing | QA & Testing | ClickUp, GitHub Issues | in-progress | andreas |
| 12 | output-backed-screen | Output-Backed Screen | iMessage, mobile app | in-progress | nadeem |
| 13 | customer-service-triaging | Customer Service & Triaging | TBD | needs-spec | jake |

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
