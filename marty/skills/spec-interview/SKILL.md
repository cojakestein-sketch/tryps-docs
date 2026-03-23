---
name: spec-interview
description: "Three-mode spec generation: SME agents, dev interview, or Jake interview"
user-invocable: true
---

# Spec Interview — Three-Mode Spec Generation

Generate a complete feature spec through one of three interview modes.

## Input Parsing

Parse from Jake's message:
- **feature** — what to spec (required)
- **mode** — how to gather answers:
  - `agents` — "use the agents", "ask the team of agents", "agent interview", "SME mode", "consult the agents"
  - `asif` — "ask Asif", "have Asif answer"
  - `nadeem` — "ask Nadeem", "have Nadeem answer"
  - `jake` — "ask me", "interview me", "I'll answer", "I want to answer"
  - **unspecified** → ASK Jake: "Who should answer the spec questions? You, a dev (Asif/Nadeem), or should I consult my SME agents?"

Wait for Jake's response before proceeding. Do NOT default to self-answering.

---

## Pass 1 — Question Generation (All Modes)

Search memory for: FRD, MEMORY.md, relevant codebase docs, existing related features.

Generate 12-15 targeted interview questions following this flow:

**Phase 1 — Broad Context (2-3 questions):**
- What's the user story? (As a [role], I want [thing], so that [benefit])
- Which of the 3 traveler types (60% IDC, 30% Casual, 10% Ultimate) benefits most?
- How does this reinforce "Partiful for trips" positioning?

**Phase 2 — Narrowing (5-8 questions):**
- What screens are affected? (Trip detail tabs: Activities, Itinerary, People+Flights, Stay, Vibe, Expenses)
- What's the entry point? (Tab, button, push notification, etc.)
- Does this serve the group or the individual?
- What data model changes are needed? (Tables, columns, RLS policies)
- New Edge Functions or RPCs needed?
- Third-party API dependencies?
- Real-time sync requirements?
- What existing code can be reused?

**Phase 3 — Edge Cases (3-5 questions):**
- What are the edge cases?
- What's the invite flow impact? (SACRED — never add friction)
- What are the empty/loading/error/offline states?
- Is there a multi-user race condition scenario?
- What's explicitly out of scope?

**Phase 4 — Confirmation (2-3 questions):**
- What are the testable success criteria?
- What does "done" look like on-device?
- Estimated complexity? (S/M/L/XL)

---

## Pass 2 — Gather Answers (Mode-Dependent)

### Mode: agents

Route each question to the relevant SME skill(s) based on category:

| Question Category | Primary SME | Secondary SME |
|---|---|---|
| User story, traveler types, positioning, group vs individual | `sme-product` | — |
| Screens, entry points, UX flow | `sme-product` | `sme-growth` |
| Data model, schema, RLS, APIs, code reuse | `sme-architect` | — |
| Edge cases, empty/loading/error states, multi-user | `sme-qa` | — |
| Invite flow impact | `sme-qa` | `sme-growth` |
| Out of scope, complexity estimate | `sme-architect` | `sme-product` |
| Success criteria, testability | `sme-qa` | — |
| Viral mechanics, share triggers, retention | `sme-growth` | — |

For each question:
1. Invoke the primary SME skill with the question + feature context
2. If a secondary SME is listed, invoke it too
3. Collect the structured response from each SME

When multiple SMEs answer the same question:
- If they agree → use the consensus
- If they disagree → Product SME has tiebreaker on product questions, Architect SME on technical questions, QA SME on edge cases
- Note any disagreements in the spec's "Open Questions" section

After all SME responses are collected, proceed to Pass 3 (Synthesis).

### Mode: jake

1. Post all questions to Jake via Slack DM in a single message
2. Format: numbered list, grouped by phase
3. Add: "Answer as many as you want — I'll fill gaps from product context for anything you skip."
4. Wait for Jake's responses in the thread
5. For any questions Jake skips, self-answer using FRD + memory search (like agent mode but without SME skills)
6. After Jake responds, proceed to Pass 3 (Synthesis)

If Jake hasn't responded after 4 hours → remind in Slack.
If 24 hours → remind again.

### Mode: asif | nadeem

1. Post questions to the dev in Slack (DM or #dev with @mention)
2. Format: numbered list with context about the feature
3. Add: "These questions help shape the spec. Answer what you can — especially technical feasibility and complexity."
4. Wait for responses
5. For any questions the dev skips, self-answer using FRD + memory search
6. After dev responds, proceed to Pass 3 (Synthesis)

Same reminder cadence as Jake mode.

---

## Pass 3 — Synthesis

Take all answers (from SMEs, Jake, or a dev) and synthesize into a structured spec.

**Voice rules:**
- Preserve Jake's exact words when he answered directly
- Use plain language — no corporate speak
- Never use: certainly, leverage, ensure, robust, seamless, delve, transformative, unlock, compelling, paramount, navigate, multifaceted
- Keep sentences short and direct

**Spec template:**

```markdown
# [Feature Name]

**Owner:** Jake Stein | **Appetite:** [time box if mentioned] | **Interview Mode:** [agents/jake/dev name]

## Intent

> [Jake's voice — why this matters. If Jake answered, use his exact words.
> If agents answered, synthesize the Product SME's framing.]

## Summary
1-2 sentences. What and why.

## User Story
As a [trip member/creator], I want [thing], so that [benefit].

## Success Criteria

### Core Behavior
- [ ] [Behavior]. Verified by: [micro test script — exact steps + expected result]
- [ ] [Behavior]. Verified by: [micro test script]

### Edge Cases & Error States
- [ ] [Empty state]. Verified by: [steps]
- [ ] [Error state with specific input examples]. Verified by: [steps]
- [ ] [Boundary: 0 items, 1 item, max items]. Verified by: [steps]

### Should NOT Happen
- [ ] [Negative criterion — what must NOT occur]
- [ ] [Negative criterion]

## Screens Affected
- [Screen name] — [what changes]

## Data Model Changes
- [Table/column/RLS change] or "None"

## API / Edge Functions
- [New or modified] or "None"

## Out of Scope
- [Explicitly excluded item — reason]

## Invite Flow Impact
[None / Low / High — explain]

## Complexity Estimate
[S / M / L / XL] — [brief justification]

## Dev Notes
- [File paths, existing code to reuse, schema details]

## QA Notes
- [Platform-specific testing, test data preconditions, regression scope]

## Open Questions
- [ ] [Any unresolved items — blocks move to "To Do" until resolved]
```

## Quality Gate

Before outputting the spec, run these checks:

**Completeness:**
- [ ] Intent section preserves Jake's voice (or Product SME framing)
- [ ] Every success criterion has "Verified by:" with exact steps
- [ ] Edge cases cover: empty, loading, error, offline states
- [ ] Negative criteria included (what should NOT happen)
- [ ] Out of scope section is explicit

**Testability (for each criterion):**
- [ ] Can QA test without reading code?
- [ ] Trigger is explicit (not "when appropriate")?
- [ ] Expected result is observable on-screen or in DB?
- [ ] Two people could independently agree on pass/fail?
- [ ] Preconditions stated?

**Collaboration:**
- [ ] Invite flow impact assessed
- [ ] Multi-user scenario considered (5+ people)
- [ ] Real-time sync needs evaluated
- [ ] Permissions checked (creator vs member)

If any check fails, strengthen that section before outputting.

## Output

Return the full structured spec as markdown text. Do NOT create a ClickUp ticket — the caller (`/spec-and-build`) handles that.

If called standalone (not from spec-and-build), output the spec directly to the conversation.
