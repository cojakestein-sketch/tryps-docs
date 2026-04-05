# Process Learnings

> What's working and what's not in the team workflow.
> Updated by Marty weekly. Sources: standups, retros, Jake observations.
> Last compiled: 2026-04-05 (initial)

## What's Working

- **State pipeline:** Auto-generating shared/state.md from scope frontmatter — single source of truth for SC counts
- **QA team onboarded:** Aman, Sarfaraz, Zain finding real bugs. Batch filing after sessions is productive.
- **Shake-to-feedback:** In-app feedback mechanism shipped. First channel of user feedback.
- **Async standups:** Devs answer questions in docs, Marty syncs state. No blocking meetings.
- **Spec-first workflow:** spec.md with kickoff prompt enables autonomous pipeline execution

## What's Not Working

- **PR backlog:** 14 open PRs, many with failing CI. Merge queue growing.
- **Mission tracking gaps:** Dashboard deployed but missions don't auto-sync from shared/missions.md yet.
- **Cross-scope coordination:** Asif + Rizwan design sessions keep getting deferred. SC-59/60/61 unresolved.
- **Feedback loop incomplete:** Shake-to-feedback works, but text-to-agent and agent-proactive channels not live yet.

## Process Changes to Consider

- Daily PR triage: merge or close stale PRs every morning
- Explicit "interface session" calendar blocks for cross-scope work
- Bug severity tiers: P0 (blocks testing) vs P1 (fix this sprint) vs P2 (backlog)
