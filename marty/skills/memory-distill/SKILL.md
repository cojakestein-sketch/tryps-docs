---
name: memory-distill
description: Extract learnings from standup answers and distill into daily memory and MEMORY.md
user-invocable: true
---

# Memory Distillation

Run after reading answered standup documents. Extracts organizational knowledge and feeds Marty's long-term memory.

## When to Run

- After the 2pm standup (when devs have answered their questions)
- During heartbeat checks if answered standups haven't been processed yet
- Manually when Jake asks Marty to "update your memory"

## Steps

### 1. Read the Answered Standup

Read today's standup from `tryps-docs/docs/standups/YYYY-MM-DD-standup.md`. For each dev's answers, extract:

- **Facts:** Concrete statements about what's done, what's not, what changed
- **Decisions:** Any technical or product decisions mentioned
- **Blockers:** What's stuck and why
- **Promises:** "I'll have X done by Y" — track these for tomorrow's questions
- **Surprises:** Anything unexpected (bugs, workarounds, scope changes)
- **Contradictions:** Did a dev say something different from what they said yesterday?

### 2. Write Daily Memory

Write to `marty/memory/YYYY-MM-DD.md`:

```markdown
# Memory — [Date]

## Key Facts
- [fact 1]
- [fact 2]

## Decisions Made
- [decision and context]

## Active Blockers
- [blocker]: [who] blocked on [what], since [when]

## Promises to Track
- [dev] said they'd have [X] done by [date]

## Surprises / Learnings
- [unexpected thing and why it matters]

## Contradictions from Yesterday
- [dev] said [X] yesterday but today said [Y]
```

### 3. Update MEMORY.md (Selectively)

Only promote to `marty/MEMORY.md` if the information is:
- A lasting pattern (not a one-day thing)
- A key product/architecture decision
- A team dynamic insight (how someone works, what they struggle with)
- A process lesson (what worked, what didn't)

DO NOT add ephemeral status updates to MEMORY.md. That's what daily files are for.

### 4. Update Standup Questions

Note anything that should inform tomorrow's questions:
- Follow up on promises
- Probe deeper on surprises
- Check if blockers are resolved
- Challenge contradictions
