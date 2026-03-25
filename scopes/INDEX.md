---
generated: 2026-03-25
total_scopes: 12
---

# Scopes Index

12 active scopes. Brand/GTM moved to `brand-and-gtm/`. AI Platform Connectors + Logistics Agent deferred post-April 2. QA is cross-cutting (always running).

Updated 2026-03-25: statuses refreshed, assignees updated, numbering cleaned up.

**Agent reading order:** INDEX.md → state.md → objective.md → spec.md

| # | ID | Title | Status | Assignee | Notes |
|---|-----|-------|--------|----------|-------|
| ~~1~~ | ~~beta-user-feedback~~ | ~~Beta & User Feedback~~ | **in-progress** | jake | No spec needed — ongoing |
| 2 | core-trip-experience | Core Trip Experience | **testing** | nadeem / andreas | Bug testing in progress |
| 3 | group-decision-making | Group Decision-Making | **needs-spec** | — | Jake to spec |
| 4 | travel-identity | Travel Identity | **needs-spec** | — | Jake to spec |
| 5 | onboarding-teaching | Onboarding & Teaching | **needs-spec** | — | Jake to spec |
| 6 | post-trip-retention | Post-Trip & Retention | **specced** | nadeem | Spec in archive/scopes-deprecated/p1/post-trip-review (39 criteria) — migrate |
| 7 | imessage-agent | iMessage Agent | **in-progress** | asif | 57 SC |
| 8 | agent-intelligence | Agent Intelligence | **in-progress** | rizwan | 61 SC |
| 9 | payments-infrastructure | Payments Infrastructure | **not-started** | rizwan | |
| 10 | travel-booking | Travel Booking | **in-progress** | asif | |
| 11 | output-backed-screen | Output-Backed Screen | **in-progress** | nadeem | 48 SC |
| 12 | customer-service-triaging | Customer Service & Triaging | **needs-spec** | jake | Added 2026-03-24, cancellations/disputes/support |
| — | qa-testing | QA & Testing | **cross-cutting** | andreas | Ongoing, not a discrete scope |

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
