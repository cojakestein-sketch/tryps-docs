---
generated: 2026-03-20
total_scopes: 13
---

# Scopes Index

13 MECE capability areas covering everything Tryps needs. Flat folder structure — no phase nesting.

**Agent reading order:** INDEX.md → state.md → objective.md → spec.md

| # | ID | Title | Where it lives | Status | Assignee |
|---|-----|-------|----------------|--------|----------|
| 1 | beta-user-feedback | Beta & User Feedback | Jake's iMessages, outreach | in-progress | jake |
| 2 | core-trip-experience | Core Trip Experience | Trip card (mobile app) | built | — |
| 3 | group-decision-making | Group Decision-Making | iMessage, trip card | partial | nadeem |
| 4 | travel-identity | Travel Identity | People + profile tab | partial | nadeem |
| 5 | onboarding-teaching | Onboarding & Teaching | Mobile app (everywhere), iMessage | partial | jake |
| 6 | post-trip-retention | Post-Trip & Retention | Mobile app (after trip card), iMessage | partial | nadeem |
| 7 | imessage-agent | iMessage Agent | iMessage | specced | asif |
| 8 | agent-intelligence | Agent Intelligence | Backend, mobile; Claude Connector in external services | not-started | rizwan |
| 9 | payments-infrastructure | Payments Infrastructure | Backend, mobile, iMessage frontend | not-started | asif |
| 10 | travel-booking | Travel Booking | iMessage, mobile, backend | built | — |
| 11 | brand-design-system | Brand & Design System | Figma | partial | jake |
| 12 | launch-gtm | Launch & GTM | Figma, social platforms, etc. | not-started | jake |
| 13 | qa-testing | QA & Testing | ClickUp, GitHub Issues | in-progress | andreas |

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
