# Tryps Dev Workflow — v2 (Simplified)

**Effective:** 2026-03-18

---

## The Loop

```
┌─────────────────────────────────────────────────────────┐
│                                                         │
│   1. SPEC (Jake)                                        │
│   ┌───────────────────────────────────┐                 │
│   │ • Write spec with success criteria │                │
│   │ • Each criterion = testable statement               │
│   │ • Assign to a dev                  │                │
│   │ • Push to tryps-docs/scopes/       │                │
│   └──────────────┬────────────────────┘                 │
│                  │                                       │
│                  ▼                                       │
│   2. BUILD (Dev)                                        │
│   ┌───────────────────────────────────┐                 │
│   │ • Dev executes however they want   │                │
│   │ • No prescribed process            │                │
│   │ • Ship when criteria are met       │                │
│   │ • Push to develop, tag "ready-qa"  │                │
│   └──────────────┬────────────────────┘                 │
│                  │                                       │
│                  ▼                                       │
│   3. VALIDATE (Andreas/QA)                              │
│   ┌───────────────────────────────────┐                 │
│   │ • Test each success criterion      │                │
│   │ • Mark: ✅ Pass / ❌ Fail          │                │
│   │ • Fails go back to dev w/ repro    │                │
│   │ • All pass = scope is DONE         │                │
│   └───────────────────────────────────┘                 │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

## Rules

1. **Jake writes specs.** Nobody else defines what to build.
2. **Devs choose how.** No code review pipeline, no PRD approval chain. Ship it.
3. **Andreas validates what.** Tests against success criteria only. Pass or fail.
4. **A scope is done when all criteria pass.** Not when code is merged. When it works.

## What's NOT in this workflow

- FRDs (killed)
- Mandatory code review pipeline
- Jake reviewing implementation approach
- Sprint ceremonies or standups beyond the daily check-in
- Compound engineering pipeline for individual devs

## Scope Status Labels

| Label | Meaning |
|-------|---------|
| `not-started` | Spec exists but no dev has picked it up |
| `in-progress` | Dev is building |
| `ready-qa` | Dev says criteria are met, waiting on Andreas |
| `failing` | QA found failures, back to dev |
| `done` | All criteria pass |
