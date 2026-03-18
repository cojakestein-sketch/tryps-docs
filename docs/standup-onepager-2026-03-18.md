# How We Work Now

**Tryps Team — March 18, 2026**

---

## The old way (what we're stopping)

- Heavy pipeline with reviews, FRDs, approval chains
- Jake involved in HOW things get built
- Too many steps between "here's what we need" and "it's done"

## The new way (3 steps)

### 1. SPEC — Jake writes it

I define **what** needs to happen and the **success criteria** — the exact conditions that prove it works. Each criterion is a testable statement like:

> "User taps 'Find Flights' → agent task appears in chat within 3 seconds"

You'll find your specs in `tryps-docs/scopes/<phase>/<scope>/spec.md`.

### 2. BUILD — You ship it

How you build it is up to you. Architecture, libraries, patterns — your call. When you believe all the success criteria in your spec are met, push to `develop` and tag it `ready-qa`.

### 3. VALIDATE — Andreas tests it

Andreas goes through each success criterion and marks pass or fail. If something fails, he sends you the repro steps. You fix it. When everything passes, the scope is done.

**That's it. No other process.**

---

## Your assignments

| Dev | Scope(s) | Phase |
|-----|----------|-------|
| **Asif** | Core Flows | P1 |
| **Nadeem** | Notifications & Voting | P1 |
| **Arslan** | Travel DNA, Connectors | P1, P2 |
| **Krisna** | Claude Connector, iMessage via Linq | P1, P2 |
| **Andreas** | QA — validates all scopes against criteria | All |

P3 (Agent Layer) is on hold until the replacement hire starts.

---

## What I need from you

1. **Read your spec(s).** If success criteria are unclear, tell me today.
2. **Start building.** No waiting for approval.
3. **Tag `ready-qa` when you think criteria pass.** Andreas takes it from there.

## What you can expect from me

- Clear specs with testable criteria (I'll finish the gaps this week)
- No opinions on your implementation approach
- Quick answers if a spec is ambiguous

---

## Status tracking

I'll keep a simple tracker at `tryps-docs/scopes/tracker.md`. Each criterion is either:
- `—` Not started
- `🔨` Building
- `🧪` In QA
- `✅` Passing
- `❌` Failing

A scope is **done** when every criterion is ✅. That's the only metric that matters.
