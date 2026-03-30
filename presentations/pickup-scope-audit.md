# Pickup Prompt: Scope Audit & Strategy Alignment

## Context

We just built a pitch presentation for the Martin Trust Center at MIT (file: `~/tryps-docs/presentations/martin-trust-center-2026-03-30.html`). The pitch crystallized our strategy into a clear narrative:

**The pitch says:**
- Three-layer architecture: iMessage → Mobile App → Agentic Layer
- 9 active scopes (see below)
- 1% booking fee business model
- Brand launch May 2 with UGC (80 creators) + 4 ambassadors + giveaway + launch video
- Right to win: first to market with native iMessage polling, data moat, three-layer integration

**The problem:** The MECE scope list in `~/tryps-docs/scopes/` may be drifted from this strategy. Some scopes may need to be collapsed, renamed, or re-prioritized to match what we're actually presenting to investors and advisors.

## Your Task

1. **Read the current scope state:**
   - @~/tryps-docs/shared/state.md (auto-generated scope status)
   - @~/tryps-docs/scopes/INDEX.md (scope index)
   - @~/tryps-docs/docs/plans/2026-03-20-feat-strategic-roadmap-mece-scope-plan.md (canonical roadmap)

2. **Read the pitch presentation** at `~/tryps-docs/presentations/martin-trust-center-2026-03-30.html` — specifically slides 6 (architecture), 7 (scopes), and 8 (GTM).

3. **Audit for alignment gaps:**
   - Are there scopes that don't map to anything in the pitch? (candidates for removal/deferral)
   - Are there things in the pitch that don't have a scope? (missing scopes)
   - Should any scopes be collapsed together? (Jake already collapsed Payments Infrastructure under Travel Booking for the pitch)
   - Are the assignees and statuses still accurate?
   - Does the MECE structure still hold, or has the strategy evolved past it?

4. **Produce a recommendation doc** at `~/tryps-docs/shared/scope-audit-2026-03-30.md` with:
   - Table comparing pitch scopes vs. current repo scopes
   - Specific recommendations (keep, collapse, defer, rename, create)
   - Updated scope list that matches the strategy
   - Any questions for Jake where the right answer isn't obvious

5. **Update `~/tryps-docs/shared/state.md`** if any scopes need status changes based on what you find.

## Key Constraints
- Default branch in tryps-docs is `main`
- The pitch is the SOURCE OF TRUTH for strategy — scopes should align to it, not the other way around
- Don't create new spec files — just the audit doc and state updates
- Brand/GTM scopes live in `~/tryps-docs/brand-and-gtm/`, NOT in `~/tryps-docs/scopes/`
