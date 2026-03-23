# Tryps Docs

Shared documentation and state for the Tryps team.

## Structure

```
scopes/              ← Scope specs (one spec.md per scope with frontmatter status)
  p1/                ← Phase 1: Core App (7 scopes)
  p2/                ← Phase 2: Stripe + Linq (4 scopes)
  p3/                ← Phase 3: Agent Layer (4 scopes)
  p4/                ← Phase 4: Brand & GTM (5 scopes)
  p5/                ← Phase 5: V2 Beta (2 scopes)
shared/              ← Shared state (auto-loaded by Claude sessions)
  state.md           ← All scope statuses (auto-generated)
  priorities.md      ← Current sprint focus
  decisions.md       ← Strategic decisions log
  team.md            ← Roster + assignments
  observations.md    ← Agent observations
STATUS.md            ← Unified tracker with criteria detail (auto-generated)
designs/             ← Pencil .pen design files
tracker/             ← Flow tracker (GitHub Pages)
user-flows/          ← User flow diagrams
```

## Workflow

**Spec → Build → Validate.** See [scopes/workflow.md](scopes/workflow.md).

Each scope has one file: `spec.md` with YAML frontmatter tracking status.
Statuses: `not-started` → `in-progress` → `ready-qa` → `done` (or `failing` → back to build).

Run `./generate-status.sh` to regenerate STATUS.md from spec frontmatter.
