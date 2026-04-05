# Scope Intelligence

> Cross-scope observations, dependency risks, and integration notes.
> Updated by Marty weekly. Sources: state.md, standups, PRs.
> Last compiled: 2026-04-05 (initial)

## Active Dependencies

- **SC-59/60/61:** Asif + Rizwan interface session needed — DM delivery, vote override routing, rate limiter. Blocks Group Decision-Making progress.
- **Travel Booking → Payments:** Duffel flight booking requires Stripe payment infra. Rizwan blocked until Payments Infrastructure is wired.
- **Agent Intelligence → Group Decision-Making:** Vote-on-behalf (agent proxy voting) needs group decision primitives.

## Risk Flags

| Scope | Risk | Why |
|-------|------|-----|
| Output-Backed Screen | 7/48 SC — lowest velocity | Large scope, Nadeem splitting time with bug fixes |
| Travel Booking | 5/70 SC — Duffel pending prod approval | External dependency (Duffel approval timeline) |
| Payments Infrastructure | 0/12 SC — not started | Blocked until Rizwan finishes agent intelligence wave |

## Scope Completion Forecast

- **Done:** iMessage Agent (51/57), Voice Calls
- **Near done:** Core Trip Experience (15/16 — in testing)
- **Progressing:** Agent Intelligence (29/61), Group Decision-Making (5/25)
- **Specced but not started:** Onboarding, Post-Trip, Travel Identity (total: 95 SC)
