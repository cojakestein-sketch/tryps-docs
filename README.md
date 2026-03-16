# Tryps Docs

Shared documentation for the Tryps team — specs, designs, and the 9-step scope pipeline.

## Structure

```
scopes/              ← Canonical source of truth (mirrors Gantt)
  p1/                ← Phase 1: Core App
    core-flows/      ← Each scope has 9 pipeline docs
    tooltips-teaching/
    notifications-voting/
    post-trip-review/
    travel-dna/
    recommendations/
  p2/                ← Phase 2: Stripe + Linq
  p3/                ← Phase 3: Agent Layer
  p4/                ← Phase 4: Brand & Go-to-Market
  p5/                ← Phase 5: V2 Beta
designs/             ← Pencil .pen design files
tracker/             ← Flow tracker (GitHub Pages)
user-flows/          ← User flow diagrams + exec summary
```

## Pipeline (per scope)

Every scope folder contains documents for each step of the [Gantt pipeline](https://marty.jointryps.com/gantt):

1. **Spec** → 2. **Plan** → 3. **Work** → 4. **Review** → 5. **Compound Learnings** → 6. **Agent Ready** → 7. **Dev Feedback** → 8. **Fixes & Learnings** → 9. **Merged?**

See [scopes/README.md](scopes/README.md) for full details.
