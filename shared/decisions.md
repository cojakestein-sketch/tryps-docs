# Recent Decisions

> Strategic decisions and their reasoning. Jake writes. Newest first.

## 2026-03-18: Unified memory architecture ([[agent-intelligence/objective|Agent Intelligence]])

**Decision:** tryps-docs becomes the shared brain. Spec-only model with frontmatter status. Global CLAUDE.md with @import loads shared state into every session.
**Reason:** Memory was fragmented across 5 silos. Sessions started blind. 76% of tryps-docs files were empty scaffolding from the old 10-step pipeline.
**Impact:** tryps-docs restructured. Marty reads/writes shared/ directory. All Claude sessions auto-informed.

## 2026-03-18: Simplified to 3-step workflow

**Decision:** Spec (Jake) → Build (Dev) → Validate (QA). No FRDs, no code review pipeline, no approval chain.
**Reason:** Devs own HOW. Jake defines WHAT via success criteria. Andreas validates.
**Impact:** Dev workflow doc at scopes/workflow.md. Team briefed via standup one-pager.

## 2026-03-18: P3 on hold

**Decision:** All P3 (Agent Layer) scopes blocked until replacement hire starts.
**Reason:** Ken left. No bandwidth for agent development.
**Impact:** 4 scopes marked blocked.
