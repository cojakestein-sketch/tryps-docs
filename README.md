# Tryps Docs

Shared documentation for the Tryps team — specs, FRDs, designs, and the 10-step scope pipeline.

## Structure

```
scopes/              ← Canonical source of truth (mirrors Gantt)
  p1/                ← Phase 1: Core App
    core-flows/      ← Each scope has 10 pipeline docs
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

1. **Spec** → 2. **FRD** → 3. **Plan** → 4. **Work** → 5. **Review** → 6. **Compound Learnings** → 7. **Agent Ready** → 8. **Dev Feedback** → 9. **Fixes & Learnings** → 10. **Merged?**

See [scopes/README.md](scopes/README.md) for full details.
