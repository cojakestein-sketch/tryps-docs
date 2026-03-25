# Tryps Docs

Shared documentation and state for the Tryps team. Source of truth for specs, plans, standups, and brand.

## Structure

```
standups/                Standups (daily, newest first)
scopes/                  Active scopes — 12 MECE capability areas
  INDEX.md               Scope manifest (start here)
  {scope-name}/          Per-scope: objective.md, spec.md, state.md, etc.
docs/
  plans/                 Strategic roadmap + feature plans
  brainstorms/           Brainstorm session outputs
  handoffs/              Session handoff docs
  research/              Research notes
brand-and-gtm/           Brand, GTM, and Sean's creative workspace
  designs/               Pencil .pen files, Figma assets, design prompts
  01-brand-book/ … 08-referrals/
shared/                  Agent context (auto-loaded by CLAUDE.md into every session)
  state.md               Scope statuses
  priorities.md          Current sprint focus
  brand.md               Brand tokens
  clickup.md             ClickUp workspace reference
  team.md                Roster + assignments
  decisions.md           Strategic decisions log
  observations.md        Agent observations
marty/                   Marty (AI agent) — crons, skills, memory, templates
pitch-deck-ideas/        Pitch materials and investor prep
archive/                 Old/stale files — DO NOT REFERENCE (see archive/AGENT_WARNING.md)
```

## Key Files

| File | What |
|------|------|
| `scopes/INDEX.md` | Active scope list with status + assignees |
| `docs/plans/2026-03-20-feat-strategic-roadmap-mece-scope-plan.md` | MECE strategic roadmap |
| `shared/clickup.md` | ClickUp workspace IDs, CLI usage, task mapping |
| `shared/brand.md` | Color palette, typography, spacing, voice & tone |

## Workflow

**Spec (Jake) -> Build (Dev) -> Validate (QA)**

Each scope has one spec with numbered success criteria. Devs build from the spec. Andreas validates criteria.

## For Agents

1. Read `scopes/INDEX.md` first
2. Then `shared/state.md` for current status
3. Then the specific scope's `objective.md` -> `spec.md`
4. **Never read from `archive/`** — that content is stale
