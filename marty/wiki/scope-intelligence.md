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

## Technical Challenges (from Mar 27 standup)

Top 5 challenges for trip coordination (per Asif):
1. **Context window management** — trips with 20+ activities, 8 people exceed token limits
2. **Multi-user state tracking** — completeness needs to be per-member, not per-trip
3. **Proactive sequencing** — daily facilitator needs to become a real workflow engine
4. **Conflict resolution** — knowing when to push vs back off on date/stay disagreements
5. **External data integration** — needs real-time pricing/availability APIs (Google Places, flights)

Agent memory gap (per Rizwan): fire-and-forget extraction has no retry or alerting at network level.

## Scope Completion Forecast

- **Done:** iMessage Agent (51/57), Voice Calls
- **Near done:** Core Trip Experience (15/16 — in testing)
- **Progressing:** Agent Intelligence (29/61), Group Decision-Making (5/25)
- **Specced but not started:** Onboarding, Post-Trip, Travel Identity (total: 95 SC)
