---
title: "P2/P3 Scope Consolidation & Spec Pipeline"
type: feat
date: 2026-03-18
---

# P2/P3 Scope Consolidation & Spec Pipeline

## Overview

Get all 7 P2/P3 scopes to dev-ready state: fix ClickUp drift, resolve open questions, run spec sessions for 3 P3 stubs, clean up tickets, and hand off to Asif and Rizwan. Strategy-first approach using targeted questionnaires (same vibe as brand intake) that feed into `/spec` sessions.

## Problem Statement / Motivation

P2 and P3 scopes are scattered across 3 states of readiness:

1. **Specs done, ClickUp wrong** (4 scopes) — devs don't know they can start
2. **Spec done but blocked by open questions** (1 scope) — architecture decisions needed
3. **Intent stubs with no criteria** (3 scopes) — Jake's raw thoughts not yet formalized

Meanwhile:
- Asif has parked tasks from before the P2 restructuring — unclear what's active
- Rizwan is new to the team with no onboarding doc for the agent layer
- ClickUp statuses are drifted — 4 scopes say "needs spec" but specs are written
- P1 dependencies (travel-dna, claude-connector) are upstream blockers nobody's tracking
- No shared agent architecture doc exists for P3's most complex work
- Existing kickoff prompts reference deprecated Mission Control API

**The cost of not fixing this:** Asif sits idle waiting for specs that are already written. Rizwan starts P3 without understanding the architecture. Jake answers the same questions in Slack that should be in specs. April 2 arrives with P2 unshipped.

## Proposed Solution

```
Phase 0: Quick Wins — Fix ClickUp, Clarify Blockers (today, 30 min)
    ↓
Phase 1: Asif Sync — Get current state, clear P2 blockers (today/tomorrow)
    ↓
Phase 2: P2 Gap Resolution — Answer open questions, add kickoff prompts (Mar 19-20)
    ↓
Phase 3: P3 Agent Intake — Questionnaire + 3 spec sessions (Mar 20-22)
    ↓
Phase 4: ClickUp & Spec Cleanup — Final pass, all tickets dev-ready (Mar 22-23)
    ↓
Phase 5: Handoff — Asif starts P2, Rizwan onboards + starts P3 (Mar 24+)
```

---

## Implementation Phases

### Phase 0: Quick Wins — Fix ClickUp Drift & Clarify Blockers (Mar 18, 30 min)

**Owner:** Jake
**Deliverable:** ClickUp reflects reality. Critical blockers identified.

#### Tasks

- [ ] Update ClickUp status for 4 scopes with wrong "needs spec" status:
  - `p2-linq-imessage` (86e0emu7g) → `to do` — spec has 40 criteria
  - `p2-connectors` (86e0emu86) → `to do` — spec has 24 criteria
  - `p3-logistics-agent` (86e0emu8z) → `to do` — spec has 26 criteria
  - `p1-claude-connector` (86e0emu56) → `to do` — spec has 36 criteria
- [ ] Confirm due dates are set to April 2 for all P2 scopes
- [ ] Decide: **Does the April 2 deadline apply to P3?** If not, set realistic P3 dates.
  - Current ClickUp dates for P3 are Apr 5-22 (all AFTER the hard deadline)
  - Recommendation: April 2 = P1/P2 must be DONE. P3 specs ready by April 2, P3 build starts April 3.
- [ ] Clarify: **Is `p1-claude-connector` really a dependency for `p2-linq-imessage`?**
  - The two specs describe different integration surfaces (Claude MCP vs Linq iMessage API)
  - If false dependency → Asif can start Linq immediately
  - If real → what's the shared layer? Document it.

**Success criteria:** ClickUp board matches spec reality. Jake has answered the April 2 / P3 question and the claude-connector dependency question.

**Commands to run:**
```bash
# Fix ClickUp statuses
npx clickup-cli update 86e0emu7g -s "to do"
npx clickup-cli update 86e0emu86 -s "to do"
npx clickup-cli update 86e0emu8z -s "to do"
npx clickup-cli update 86e0emu56 -s "to do"
```

---

### Phase 1: Asif Sync — Understand Current State (Mar 18-19)

**Owner:** Jake + Asif
**Deliverable:** Clear picture of what Asif is working on and what he can pick up

#### Tasks

- [ ] Ask Asif in Slack/call:
  1. What are you working on TODAY?
  2. What's the status of "Packing List Feature" (for testing) — is it ready for Andreas?
  3. What's the status of "Migrate domain: jointripful.com → jointryps.com" — is this blocking anything?
  4. Have you looked at any P2 specs yet?
  5. Which P2 scope do you want to start first?
  6. Are you blocked on anything from Nadeem (p1-travel-dna)?
- [ ] Triage Asif's parked items — confirm these stay parked:
  - Activity Sharing Opt-Out Toggle
  - Post-Trip Activity Ranking (Beli-Inspired)
  - Connections System (Replace Friend Graph)
  - Discover — Friend-Based Activity Recs
  - Fixed Screen Design for Trip Members
  - Bug: Temporary password not rotated
- [ ] Determine Asif's available capacity for P2 work starting this week

**Success criteria:** Jake knows exactly what Asif is doing, what's blocking him, and when he can start P2.

---

### Phase 2: P2 Gap Resolution — Answer Open Questions, Polish Specs (Mar 19-20)

**Owner:** Jake (decisions) + Claude (drafting)
**Deliverable:** All 3 P2 specs fully dev-ready with resolved open questions and kickoff prompts

#### 2a: Resolve Stripe Payments Open Questions

The 4 open questions in `p2-stripe-payments` block Asif from starting:

- [ ] **OQ1: Payment architecture** — How does Tryps collect payment and pay suppliers?
  - Options: (a) Stripe Connect, Tryps as platform, suppliers as connected accounts (b) Direct API billing per supplier (Duffel handles its own) (c) Tryps holds funds, pays suppliers via separate transfers
  - Recommendation: Start with Stripe payment intents for user charges + let each supplier API handle its own billing. Tryps doesn't need to be a middleman in v1.
  - **Use Claude to think through this** — dictate raw thoughts, Claude structures the decision
- [ ] **OQ2: Lowest-friction payment method for first-time users?**
  - Options: Apple Pay (lowest friction on iOS), in-app card entry via Stripe, Stripe Payment Links (for iMessage)
  - Recommendation: Apple Pay primary, card entry as fallback. Stripe handles both.
- [ ] **OQ3: Error states per supplier type?**
  - This can be deferred to dev — Asif can research Duffel/Airbnb error codes during implementation. Mark as "dev researches during build" in spec.
- [ ] **OQ4: How does P3 pay-on-behalf extend this?**
  - Answer this DURING the P3 spec session for pay-on-behalf (Phase 3)
  - For now, add a note: "P2 Stripe handles user-initiated payments. P3 X-402 handles agent-initiated micropayments. They share the Stripe infrastructure but are separate flows."
- [ ] Update `p2-stripe-payments/spec.md` with answers
- [ ] Add a note clarifying: stripe-payments = user pays for bookings they confirm. Logistics agent v1 does NOT charge users (costs are Tryps-subsidized internally).

#### 2b: Fix Spec Accuracy Issues

- [ ] Update `p2-connectors/spec.md` — remove reference to killed `p2-booking-links` in Out of Scope section
- [ ] Update `p3-logistics-agent/spec.md` frontmatter — add actual dependencies: `[p2-connectors, p3-pay-on-behalf, p3-duffel-apis]`
- [ ] Update `p3-vote-on-behalf/spec.md` frontmatter — add missing dependency: `[p1-travel-dna, p1-notifications-voting]`

#### 2c: Add Kickoff Prompts to Complete Specs

Five specs need kickoff prompts. Generate them using ClickUp API (not deprecated Mission Control):

- [ ] `p2-stripe-payments/spec.md` — add kickoff prompt
- [ ] `p2-connectors/spec.md` — add kickoff prompt
- [ ] `p3-logistics-agent/spec.md` — add kickoff prompt

(P3 stubs get kickoff prompts after spec sessions in Phase 3)

**Success criteria:** All 3 P2 specs have resolved open questions, accurate Out of Scope, correct dependencies, and kickoff prompts. Asif can read any P2 spec and start building without needing to ask Jake.

**Key files:**
- `tryps-docs/scopes/p2/stripe-payments/spec.md` — OQ1-4 need answers
- `tryps-docs/scopes/p2/connectors/spec.md` — stale booking-links reference
- `tryps-docs/scopes/p2/linq-imessage/spec.md` — already complete, already has kickoff prompt
- `tryps-docs/scopes/p3/logistics-agent/spec.md` — needs dependency update + kickoff prompt

---

### Phase 3: P3 Agent Intake — Questionnaire + Spec Sessions (Mar 20-22)

**Owner:** Jake (answers) + Claude (structures + generates specs)
**Deliverable:** 3 fully specced P3 scopes with success criteria and kickoff prompts

This is the "vibe it" phase. Jake dictates raw thoughts per scope, Claude structures them via targeted questions, then Claude runs `/spec` to generate formal criteria.

#### 3a: Agent Layer Intake Questionnaire (create once, use for all 3)

Before running individual `/spec` sessions, create a lightweight intake questionnaire specific to agent-layer features. Model on the brand intake questionnaire but focused on:

- [ ] Create `tryps-docs/docs/p3-agent-intake-questionnaire.md` with sections:

**Section 1: Autonomy Boundaries (all P3 scopes)**
1. What can the agent do WITHOUT asking the user? [MUST]
2. What MUST the agent ask permission for? [MUST]
3. What should the agent NEVER do? [MUST]
4. How does the user override or undo an agent action? [MUST]

**Section 2: Trust & Confidence (vote-on-behalf)**
5. At what confidence level should the agent auto-vote? (e.g., 90%? 80%?) [MUST]
6. Can the user see WHY the agent voted a certain way? [MUST]
7. What happens if the agent votes wrong and the group is unhappy? [MUST]
8. Can someone opt out of agent voting for just one category (e.g., activities yes, dates no)? [REFINE]

**Section 3: Money & Budget (pay-on-behalf)**
9. What's the maximum the agent can spend without human approval? [MUST]
10. Is there a per-trip budget cap? Who sets it? [MUST]
11. What happens when the wallet runs out mid-task? [MUST]
12. How does the user see what the agent spent? [MUST]
13. Is X-402 the right protocol, or should we use pre-funded Stripe wallets? [MUST — needs research]

**Section 4: External APIs (duffel-apis)**
14. Which APIs are confirmed available vs aspirational? [MUST]
15. Do we have sandbox accounts for Duffel? Amadeus? Others? [MUST]
16. What's the fallback if an API is down or doesn't have inventory? [MUST]
17. Which booking categories are v1 vs v2? (flights, hotels, restaurants, activities, transport) [MUST]

**Section 5: Architecture (all P3 scopes)**
18. Where does the agent orchestration brain live? (Supabase edge function, Marty, separate service?) [MUST]
19. How do agent results get to the app? (Supabase realtime, push notifications, both?) [MUST]
20. How does the P3 agent layer relate to the P1 Claude Connector? [REFINE]

#### 3b: Jake Answers the Questionnaire (vibe session with Claude)

- [ ] Jake dictates answers to Claude — raw thoughts, stream of consciousness
- [ ] Claude structures answers, probes vague ones, flags contradictions
- [ ] Answers saved to the questionnaire file with `> **ANSWERED:**` markers
- [ ] This session should take ~45-60 min for all 20 questions

#### 3c: Spec Sessions (one per P3 stub)

Run `/spec` for each of the 3 stubs, using questionnaire answers as input:

**Order: duffel-apis → pay-on-behalf → vote-on-behalf** (dependency order — duffel-apis is foundational, pay-on-behalf extends it, vote-on-behalf is independent but benefits from agent architecture decisions)

- [ ] `/spec` session for `p3-duffel-apis` (~20 min)
  - Input: questionnaire Section 4 (APIs) + Section 5 (architecture)
  - Target: 10-15 success criteria covering API integration, fallbacks, rate limits, sandbox testing
  - Resolve: which APIs are v1 vs v2, fallback behavior
- [ ] `/spec` session for `p3-pay-on-behalf` (~20 min)
  - Input: questionnaire Section 3 (money) + Section 5 (architecture)
  - Target: 10-15 success criteria covering wallet, budget limits, approval thresholds, cost logging
  - Resolve: X-402 vs alternative, maximum auto-spend, wallet depletion
  - Also resolves `p2-stripe-payments` OQ4 (how P3 extends P2 payment infra)
- [ ] `/spec` session for `p3-vote-on-behalf` (~20 min)
  - Input: questionnaire Section 1 (autonomy) + Section 2 (trust)
  - Target: 10-15 success criteria covering inference engine, nudges, opt-in/out, confidence scoring
  - Resolve: confidence threshold, override mechanism, category opt-out
- [ ] Add kickoff prompts to all 3 new specs
- [ ] Update frontmatter: `blocked: false`, `assignee: rizwan`, `status: not-started`

**Success criteria:** All 3 P3 stubs upgraded to full specs with 10-15 testable criteria each, "Verified by:" format, edge cases, kickoff prompts. Jake's intent preserved verbatim.

**Key files:**
- `tryps-docs/docs/p3-agent-intake-questionnaire.md` — new, create this
- `tryps-docs/scopes/p3/vote-on-behalf/spec.md` — upgrade from stub
- `tryps-docs/scopes/p3/pay-on-behalf/spec.md` — upgrade from stub
- `tryps-docs/scopes/p3/duffel-apis/spec.md` — upgrade from stub

---

### Phase 4: ClickUp & Spec Cleanup — Final Pass (Mar 22-23)

**Owner:** Jake + Claude
**Deliverable:** Every P2/P3 scope has a clean ClickUp ticket with correct status, assignee, dates, and linked spec

#### Tasks

- [ ] Final ClickUp audit — verify all 7 scopes:

| Scope | Expected Status | Assignee | Due Date | Criteria Count |
|-------|----------------|----------|----------|---------------|
| p2-stripe-payments | `to do` | Asif | Apr 2 | 12 |
| p2-linq-imessage | `to do` | Asif | Apr 2 | 40 |
| p2-connectors | `to do` | Asif | Apr 2 | 24 |
| p3-vote-on-behalf | `to do` | Rizwan | [P3 deadline] | ~12 |
| p3-pay-on-behalf | `to do` | Rizwan | [P3 deadline] | ~12 |
| p3-duffel-apis | `to do` | Rizwan | [P3 deadline] | ~12 |
| p3-logistics-agent | `to do` | Rizwan | [P3 deadline] | 26 |

- [ ] Add success criteria counts to each ClickUp task description
- [ ] Link spec paths in each ClickUp task: `tryps-docs/scopes/{phase}/{scope}/spec.md`
- [ ] Move P3 tasks from Backlog (list 901711582341) to This Week (list 901711582339) once specced
- [ ] Update `shared/state.md` — regenerate from spec frontmatter to reflect new statuses
- [ ] Update `shared/clickup.md` — fix the Scope ↔ ClickUp Mapping table with correct statuses

**Success criteria:** ClickUp board is clean. Any team member can look at ClickUp and know exactly what to build, where the spec is, and when it's due.

---

### Phase 5: Handoff — Devs Start Building (Mar 24+)

**Owner:** Jake (handoff) + Asif (P2 build) + Rizwan (P3 build)
**Deliverable:** Both devs building against specs with clear priorities

#### 5a: Asif P2 Handoff

- [ ] Confirm Asif's build order based on dependencies:
  1. **p2-connectors** (no P2 blocker, but blocked by p1-travel-dna — check with Nadeem)
  2. **p2-linq-imessage** (blocked by p1-claude-connector — or not, per Phase 0 decision)
  3. **p2-stripe-payments** (blocked by p2-connectors)
- [ ] If p1-travel-dna is close to done → Asif starts connectors
- [ ] If p1-travel-dna is not close → Asif starts linq-imessage (if dependency cleared) or helps Nadeem unblock

#### 5b: Rizwan P3 Onboarding + Handoff

- [ ] Create a Rizwan onboarding brief (lightweight, not a novel):
  - Link to Supabase schema / key tables
  - Existing agent patterns in codebase (if any)
  - Key files: `t4/utils/theme.ts`, trip data model, expense model, voting model
  - How the autonomous pipeline works (spec → kickoff prompt → agent builds)
  - 30-min pairing session with Asif on codebase orientation
- [ ] Confirm Rizwan's build order:
  1. **p3-duffel-apis** (foundational — APIs are the building blocks)
  2. **p3-pay-on-behalf** (payment layer for agent execution)
  3. **p3-vote-on-behalf** (inference engine, somewhat independent)
  4. **p3-logistics-agent** (orchestration layer, depends on all above)
- [ ] Rizwan picks up first scope, moves to "in progress"

**Success criteria:** Asif has started his first P2 scope. Rizwan has read the onboarding brief and started his first P3 scope.

---

## Dependency Map

```
P1 (Nadeem — in progress)                    P2 (Asif)                P3 (Rizwan)
─────────────────────────                    ──────────                ──────────
p1-travel-dna ─────────────────────┐
  (in progress, 24 criteria)       ├──→ p2-connectors ──→ p2-stripe-payments
                                   │      (24 criteria)     (12 criteria)
                                   │
                                   └──────────────────────→ p3-vote-on-behalf
                                                              (~12 criteria)

p1-claude-connector ──→ p2-linq-imessage
  (to do, 36 criteria)    (40 criteria)
  [VERIFY THIS DEPENDENCY]

p1-notifications-voting ──────────────────→ p3-vote-on-behalf
  (needs spec, 41 criteria)                   (~12 criteria)

                          p2-connectors ──┐
                          p3-duffel-apis ─┼──→ p3-logistics-agent
                          p3-pay-on-behalf┘      (26 criteria)
```

**Critical path for P2:** `p1-travel-dna` → `p2-connectors` → `p2-stripe-payments`
**Critical path for P3:** `p3-duffel-apis` + `p3-pay-on-behalf` → `p3-logistics-agent`

---

## Dependencies & Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| p1-travel-dna doesn't finish this week | Blocks p2-connectors → p2-stripe-payments → entire P2 chain | Check with Nadeem on ETA. If >3 days out, Asif starts Linq instead. |
| p1-claude-connector is a false dependency for Linq | Asif is blocked unnecessarily for 1-2 weeks | Verify in Phase 0. If false, remove from frontmatter and unblock. |
| Stripe payments OQ1 (architecture) takes too long to decide | Asif can't start stripe-payments | Jake answers OQ1 by Mar 20. Imperfect answer > no answer. |
| X-402 protocol is not implementation-ready | p3-pay-on-behalf spec is based on vaporware | Research X-402 viability before spec session. Fallback: pre-funded Stripe wallets. |
| Rizwan ramp-up time on unfamiliar codebase | P3 velocity is low for first 1-2 weeks | Onboarding brief + pairing session. Start with duffel-apis (most isolated scope). |
| Jake's spec session time is the bottleneck | 3 spec sessions × 30-45 min = 1.5-2.5 hrs of focused Jake time | Schedule all 3 in one morning. Use questionnaire to pre-load thinking. |
| April 2 deadline is impossible for P3 | Team demoralizes, cuts corners | Make explicit: April 2 = P1/P2 done + P3 specced. P3 build has separate deadline. |
| Logistics agent architecture question (where does brain live?) unresolved | Rizwan picks wrong architecture, has to rewrite | Jake decides during P3 intake questionnaire (Question 18). |
| Existing kickoff prompts reference deprecated Mission Control | Pipeline status updates silently fail | Update all prompts to use ClickUp in Phase 2c. |

---

## Open Questions for Jake (Decide Before Phase 3)

These are the questions that surfaced during analysis. Jake should answer these — either during the P3 intake questionnaire or separately:

1. **Does April 2 apply to P3?** Recommendation: No. P3 specs done by Apr 2, P3 build starts Apr 3 with a separate deadline (Apr 15-22 based on current ClickUp dates).

2. **Is p1-claude-connector really a dependency for p2-linq-imessage?** They look architecturally separate. Removing this dependency could unblock Asif immediately.

3. **Where does the P3 agent orchestration brain live?** Options: Supabase edge functions (simplest), Marty/Hetzner (existing infra), separate service (most flexible). This shapes all 4 P3 scopes.

4. **What's the relationship between p2-stripe-payments and p3-logistics-agent?** Proposed answer: P2 stripe = user-initiated bookings (user confirms, user pays). P3 logistics v1 = agent-recommended, Tryps-subsidized (no real user charges). They share Stripe infra but are separate payment flows.

5. **Is X-402 ready to implement?** If not, what's the alternative for agent micropayments?

---

## Success Metrics

1. **ClickUp accuracy** — all 7 P2/P3 scope statuses match spec reality
2. **All specs complete** — 0 stubs remaining. Every scope has testable criteria in "Verified by:" format.
3. **Open questions resolved** — p2-stripe-payments OQ1-4 answered in spec
4. **Agent intake done** — questionnaire answered, all 3 P3 specs generated
5. **Kickoff prompts exist** — all 7 specs have pipeline-ready kickoff prompts using ClickUp API
6. **Devs unblocked** — Asif has started first P2 scope, Rizwan has onboarding brief + first P3 scope

## Timeline Summary

```
Mar 18 (today):
├── Phase 0: Fix 4 ClickUp statuses (30 min)
├── Phase 0: Decide April 2 / P3 question + claude-connector dependency
└── Phase 1: Slack Asif — what are you working on?

Mar 19:
├── Phase 1: Complete Asif sync — triage parked items, determine capacity
├── Phase 2a: Answer Stripe OQ1 + OQ2 (dictate to Claude, 30 min)
└── Phase 2b: Fix spec accuracy issues (connectors booking-links ref, dependency frontmatter)

Mar 20:
├── Phase 2c: Generate kickoff prompts for p2-stripe, p2-connectors, p3-logistics
├── Phase 3a: Create P3 agent intake questionnaire
└── Phase 3b: Jake answers questionnaire (45-60 min vibe session with Claude)

Mar 21:
├── Phase 3c: /spec session for p3-duffel-apis (20 min)
├── Phase 3c: /spec session for p3-pay-on-behalf (20 min)
└── Phase 3c: /spec session for p3-vote-on-behalf (20 min)

Mar 22-23:
├── Phase 4: Final ClickUp audit — all 7 scopes clean
├── Phase 4: Update shared/state.md + shared/clickup.md
└── Phase 5b: Write Rizwan onboarding brief

Mar 24 (Monday):
├── Phase 5a: Asif starts first P2 scope
└── Phase 5b: Rizwan reads onboarding brief + starts first P3 scope
```

**Total Jake time required:** ~4-5 hours across 4 days
- Phase 0: 30 min (ClickUp fixes + decisions)
- Phase 1: 30 min (Asif sync)
- Phase 2: 45 min (Stripe OQ answers)
- Phase 3: 2-2.5 hours (questionnaire answers + 3 spec sessions)
- Phase 4: 30 min (final review)

## References

### Internal
- `tryps-docs/docs/plans/2026-03-18-feat-brand-strategy-and-brand-book-plan.md` — format reference (brand plan)
- `tryps-docs/docs/brand-intake-questionnaire.md` — questionnaire template model
- `tryps-docs/scopes/workflow.md` — SPEC → BUILD → VALIDATE pipeline
- `tryps-docs/shared/clickup.md` — ClickUp workspace config and scope mapping
- `tryps-docs/shared/state.md` — auto-generated scope status tracker

### P2 Specs (all complete)
- `tryps-docs/scopes/p2/stripe-payments/spec.md` — 12 criteria, 4 open questions
- `tryps-docs/scopes/p2/linq-imessage/spec.md` — 40 criteria, complete + has kickoff prompt
- `tryps-docs/scopes/p2/connectors/spec.md` — 24 criteria, stale booking-links reference

### P3 Specs (1 complete, 3 stubs)
- `tryps-docs/scopes/p3/logistics-agent/spec.md` — 26 criteria, complete
- `tryps-docs/scopes/p3/vote-on-behalf/spec.md` — STUB, needs /spec session
- `tryps-docs/scopes/p3/pay-on-behalf/spec.md` — STUB, needs /spec session
- `tryps-docs/scopes/p3/duffel-apis/spec.md` — STUB, needs /spec session

### P1 Dependencies (upstream blockers)
- `tryps-docs/scopes/p1/travel-dna/spec.md` — in progress (Nadeem), blocks P2 connectors + P3 vote
- `tryps-docs/scopes/p1/claude-connector/spec.md` — to do (Nadeem), may block P2 Linq
- `tryps-docs/scopes/p1/notifications-voting/spec.md` — needs spec, blocks P3 vote

### Commands
- `~/.claude/commands/spec.md` — the `/spec` interview-to-spec generator
- `~/.claude/commands/vision.md` — full voice-to-PR pipeline
