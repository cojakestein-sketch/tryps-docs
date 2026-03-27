# Scopes — Tryps Product Pipeline

Each scope lives in `scopes/<phase>/<scope-name>/` and contains **10 pipeline documents** matching the [Gantt pipeline](https://marty.jointryps.com/gantt):

| Step | File | Owner | Description |
|------|------|-------|-------------|
| 1 | `spec.md` | Jake | Product specification |
| 2 | `frd.md` | Jake | Functional requirements document |
| 3 | `plan.md` | Claude | Implementation plan |
| 4 | `work.md` | Claude | Work execution output |
| 5 | `review.md` | Claude | Code review findings |
| 6 | `compound-learnings.md` | Claude | Aggregated learnings |
| 7 | `agent-ready.md` | Claude | Agent work done — ready for developer review |
| 8 | `dev-feedback.md` | Dev | Developer feedback on agent work |
| 9 | `fixes-learnings.md` | Claude | Fixes applied + learnings from dev feedback |
| 10 | `merged.md` | Dev | Final merge status |

## Phases

### P1: Core App (7 scopes)
1. [Core Flows](p1/core-flows/) — 19 user flows (47% complete)
2. [Tooltips & Teaching](p1/tooltips-teaching/)
3. [Notifications & Voting](p1/notifications-voting/)
4. [Post-Trip Review](p1/post-trip-review/)
5. [Travel DNA](p1/travel-dna/)
6. [Recommendations](p1/recommendations/)
7. [Claude Connector](p1/claude-connector/) — MCP server so Claude can read/write Tryps

### P2: Stripe + Linq (4 scopes)
1. [iMessage via Linq](p2/linq-imessage/)
2. [Stripe Payments](p2/stripe-payments/)
3. [Booking Links](p2/booking-links/)
4. [Travel Life Connectors](p2/connectors/)

### P3: Agent Layer (4 scopes)
1. [Vote on My Behalf](p3/vote-on-behalf/)
2. [Pay on My Behalf (X-402)](p3/pay-on-behalf/)
3. [Duffel API & Dependencies](p3/duffel-apis/)
4. [Logistics Agent](p3/logistics-agent/)

### P4: Brand & Go-to-Market (4 scopes)
1. [Socials & Presence](p4/socials-presence/)
2. [Wispr Flow Playbook (UGC)](p4/wispr-playbook/)
3. [Referral Incentives (999/369)](p4/referral-incentives/)
4. [Giveaways (Dream Trip)](p4/giveaways/)

### P5: V2 Beta (2 scopes)
1. [Family & Friends Testing](p5/friends-family/)
2. [MIT + Stranger Reviews](p5/strangers-review/)

## Cross-Cutting
- [QA & Testing](qa-testing.md)
