---
title: "Add Wiki Links Across tryps-docs for Obsidian Graph View"
type: feat
date: 2026-03-25
---

# Add Wiki Links Across tryps-docs for Obsidian Graph View

## Rules

1. **DO NOT change any content.** No rewording, no restructuring, no adding/removing sections. Only add `[[wiki links]]` and fix broken links.
2. **DO NOT change file/folder structure.** Everything stays where it is.
3. **DO NOT link to anything in `archive/`.** Those files are deprecated. Fix any existing links that point to deprecated/archived paths.
4. **Fix broken links.** Several standups have broken URL-encoded paths pointing to the old `scopes - refined 3-20` folder. Fix these to point to `scopes/`.

## Scope

~150 wiki links across ~47 files, organized in 4 tiers. Execute all tiers.

---

## Tier 1: Hub Files (3 files, ~40 links)

### 1a. `scopes/INDEX.md`

In the scope table, make each scope ID a wiki link to its objective.md:

```markdown
| 2 | [[core-trip-experience/objective|core-trip-experience]] | Core Trip Experience | **testing** | nadeem / andreas | Bug testing in progress |
```

Do this for all 12 active scopes:
- `[[beta-user-feedback/objective|beta-user-feedback]]`
- `[[core-trip-experience/objective|core-trip-experience]]`
- `[[group-decision-making/objective|group-decision-making]]`
- `[[travel-identity/objective|travel-identity]]`
- `[[onboarding-teaching/objective|onboarding-teaching]]`
- `[[post-trip-retention/objective|post-trip-retention]]`
- `[[imessage-agent/objective|imessage-agent]]`
- `[[agent-intelligence/objective|agent-intelligence]]`
- `[[payments-infrastructure/objective|payments-infrastructure]]`
- `[[travel-booking/objective|travel-booking]]`
- `[[output-backed-screen/objective|output-backed-screen]]`
- `[[customer-service-triaging/objective|customer-service-triaging]]`

Also add a link after the table note about Brand & GTM:
- `See [[brand-and-gtm/README|Brand & GTM]] for brand/launch scopes.`

### 1b. `docs/plans/2026-03-20-feat-strategic-roadmap-mece-scope-plan.md`

In the MECE Scope List table (Section 2), make each scope name a wiki link:

```markdown
| 2 | **[[core-trip-experience/objective|Core Trip Experience]]** | ... |
```

In the Dependency Chain section, link each `#N` reference:

```markdown
[[travel-identity/objective|#4 Travel Identity]] ---feeds---> [[agent-intelligence/objective|#8 Agent Intelligence]]
```

In Appendix B Sources, add wiki links:
- `shared/brand.md` -> `[[brand]]`
- `shared/brand-strategy.md` -> `[[brand-strategy]]`
- `shared/state.md` -> `[[state]]`
- `shared/clickup.md` -> `[[clickup]]`

### 1c. `README.md`

In the Key Files table:
- `scopes/INDEX.md` -> `[[scopes/INDEX|scopes/INDEX.md]]`
- Strategic roadmap path -> `[[2026-03-20-feat-strategic-roadmap-mece-scope-plan|Strategic Roadmap]]`
- `shared/clickup.md` -> `[[clickup|shared/clickup.md]]`
- `shared/brand.md` -> `[[brand|shared/brand.md]]`

In the "For Agents" section:
- "Read `scopes/INDEX.md` first" -> `[[scopes/INDEX|scopes/INDEX.md]]`
- "Then `shared/state.md`" -> `[[state|shared/state.md]]`

---

## Tier 2: Scope-to-Scope Dependencies (~20 links across 10 files)

Add wiki links in each scope's `objective.md` where dependencies or related scopes are mentioned by name. DO NOT add new dependency sections — only link text that already mentions another scope.

### `scopes/agent-intelligence/objective.md`
Where it mentions:
- "Travel Identity (scope 4)" -> `[[travel-identity/objective|Travel Identity]]`
- "iMessage Agent (scope 7)" -> `[[imessage-agent/objective|iMessage Agent]]`

### `scopes/agent-intelligence/spec.md`
Where it mentions cross-scope interfaces or dependencies:
- References to iMessage Agent -> `[[imessage-agent/spec|iMessage Agent spec]]`
- References to Travel Identity -> `[[travel-identity/objective|Travel Identity]]`
- DO NOT link to `archive/scopes-deprecated/` paths — leave those as plain text breadcrumbs

### `scopes/imessage-agent/objective.md`
- "Agent Intelligence (scope 8)" -> `[[agent-intelligence/objective|Agent Intelligence]]`
- "Brand & Design System" -> `[[brand-and-gtm/README|Brand & GTM]]`

### `scopes/output-backed-screen/objective.md`
- "iMessage Agent (scope 7)" -> `[[imessage-agent/objective|iMessage Agent]]`
- "Core Trip Experience (scope 2)" -> `[[core-trip-experience/objective|Core Trip Experience]]`
- "Agent Intelligence (scope 8)" -> `[[agent-intelligence/objective|Agent Intelligence]]`
- "Post-Trip & Retention (scope 6)" -> `[[post-trip-retention/objective|Post-Trip & Retention]]`

### `scopes/travel-booking/objective.md`
- "Payments Infrastructure (scope 9)" -> `[[payments-infrastructure/objective|Payments Infrastructure]]`
- "iMessage Agent (scope 7)" -> `[[imessage-agent/objective|iMessage Agent]]`

### `scopes/customer-service-triaging/objective.md`
- "Cancellation flows" context -> `[[travel-booking/objective|Travel Booking]]`
- "Refund/dispute handling (Stripe)" -> `[[payments-infrastructure/objective|Payments Infrastructure]]`

### `scopes/group-decision-making/objective.md`
- If it mentions iMessage or voting facilitation -> `[[imessage-agent/objective|iMessage Agent]]`

### `scopes/onboarding-teaching/objective.md`
- If it mentions iMessage or first experience -> `[[imessage-agent/objective|iMessage Agent]]`

### `scopes/core-trip-experience/objective.md`
- If it mentions output-backed-screen -> `[[output-backed-screen/objective|Output-Backed Screen]]`

### `scopes/post-trip-retention/objective.md`
- If it mentions output-backed-screen -> `[[output-backed-screen/objective|Output-Backed Screen]]`

---

## Tier 3: Within-Scope Sibling Links (~20 links across 16 files)

For each scope that has multiple files, add a `## Scope Files` section at the BOTTOM of `objective.md` linking to siblings. Only add links to files that actually exist in that folder.

### `scopes/agent-intelligence/objective.md`
```markdown
## Scope Files
- [[agent-intelligence/spec|Spec (61 SC)]]
- [[agent-intelligence/state|Current State]]
- [[agent-intelligence/design|Design Brief]]
- [[agent-intelligence/testing|QA Criteria]]
- [[agent-intelligence/memory-architecture|Memory Architecture]]
```

### `scopes/imessage-agent/objective.md`
```markdown
## Scope Files
- [[imessage-agent/spec|Spec (57 SC)]]
- [[imessage-agent/state|Current State]]
- [[imessage-agent/design|Design Brief]]
- [[imessage-agent/testing|QA Criteria]]
- [[imessage-agent/voice-guide|Voice & Tone Guide]]
```

### `scopes/output-backed-screen/objective.md`
```markdown
## Scope Files
- [[output-backed-screen/spec|Spec (48 SC)]]
- [[output-backed-screen/state|Current State]]
- [[output-backed-screen/design|Design Brief]]
- [[output-backed-screen/testing|QA Criteria]]
- [[output-backed-screen/completeness-levels|Completeness Levels]]
```

### `scopes/travel-booking/objective.md`
```markdown
## Scope Files
- [[travel-booking/spec|Spec]]
- [[travel-booking/state|Current State]]
- [[travel-booking/design|Design Brief]]
- [[travel-booking/testing|QA Criteria]]
- [[travel-booking/services|Service Layer]]
```

Also add a backlink in each `spec.md`, `state.md`, `design.md`, `testing.md` — a single line at the top or bottom:
```markdown
> Parent: [[{scope}/objective|{Scope Name} Objective]]
```

---

## Tier 4: Standups, Plans, Shared State (~60 links across ~18 files)

### 4a. Standups (4 files)

**Fix broken links first.** All standups have URL-encoded links like:
```markdown
[objective.md](../../scopes%20-%20refined%203-20/output-backed-screen/objective.md)
```
Replace with wiki links:
```markdown
[[output-backed-screen/objective]]
```

In the SC Tracking Table headers and question section headers, add wiki links:
```markdown
### Nadeem — [[output-backed-screen/objective|output-backed-screen]] (48 SC) + Bug Fixes
```

Do this for all 4 standups:
- `standups/2026-03-23-standup.md`
- `standups/2026-03-24-standup.md`
- `standups/2026-03-25-standup.md`
- `standups/2026-03-26-standup.md`

### 4b. Plans (5 key files)

Add wiki links where plans reference scopes by name:

- `docs/plans/2026-03-18-feat-brand-strategy-and-brand-book-plan.md` -> link to `[[brand]]`, `[[brand-strategy]]`, `[[brand-and-gtm/01-brand-book/objective|Brand Book]]`
- `docs/plans/2026-03-23-marty-revamp-plan.md` -> link to `[[marty/IDENTITY]]`, `[[marty/MEMORY]]`, `[[marty/TOOLS]]` (if those files exist)
- `docs/plans/2026-03-19-feat-beta-launch-sprint-and-jackson-prep-plan.md` -> link to `[[core-trip-experience/objective]]`, `[[beta-user-feedback/objective]]`
- `docs/plans/2026-03-24-feat-brand-and-gtm-workspace-setup-plan.md` -> link to `[[brand-and-gtm/README]]`
- `docs/plans/2026-03-25-refactor-tryps-docs-file-structure-plan.md` -> link to `[[scopes/INDEX]]`

### 4c. Shared Files (6 files)

**`shared/clickup.md`** — In the Scope-to-ClickUp Mapping table, make each scope ID a wiki link:
```markdown
| [[imessage-agent/objective|p2-linq-imessage]] | P2 | Asif | ... |
```

**`shared/brand.md`** — Add at top:
```markdown
> See also: [[brand-strategy]] | [[brand-and-gtm/README|Brand & GTM workspace]]
```

**`shared/brand-strategy.md`** — Add at top:
```markdown
> See also: [[brand]] | [[brand-and-gtm/01-brand-book/objective|Brand Book]]
```

**`shared/team.md`** — In Current Focus column, link to scopes:
- Asif: `[[imessage-agent/objective|iMessage Agent]]`
- Nadeem: `[[output-backed-screen/objective|Output-Backed Screen]]`
- Rizwan: `[[agent-intelligence/objective|Agent Intelligence]]`

**`shared/priorities.md`** — Link each person's scope focus to their scope objective.

**`shared/decisions.md`** — Link "memory architecture" to `[[agent-intelligence/objective]]`.

### 4d. Brand-and-GTM (3 files)

**`brand-and-gtm/README.md`** — Make scope paths wiki links:
```markdown
| `brand-book/` | Sean | ... | -> | [[brand-and-gtm/01-brand-book/objective|brand-book/]] |
```
Link to `[[brand|shared/brand.md]]` and `[[brand-strategy|shared/brand-strategy.md]]`.

**`brand-and-gtm/sean.md`** — Link to each scope objective.

**`brand-and-gtm/reference/INDEX.md`** — Link to `[[brand]]` and `[[brand-strategy]]`.

---

## Cleanup

- [ ] Delete empty file at repo root: `2026-03-25.md` (0 bytes)
- [ ] Fix all broken `scopes%20-%20refined%203-20` links in standups (replaced by wiki links above)
- [ ] Verify no wiki links point into `archive/` — all deprecated spec references should be plain text, not links

---

## Verification

After all links are added:
1. Open Obsidian graph view (`Cmd+G`)
2. Verify INDEX.md is the central hub with 12+ connections
3. Verify scope clusters show internal sibling links
4. Verify standups fan out to their referenced scopes
5. Verify no links point to archive/ or non-existent files
6. Screenshot the graph view and compare to the "before" screenshot

## Expected Graph Shape

```
                    README
                      |
           shared/ ---+--- plans/
          (ring)       |      |
                    INDEX.md
                   /  |   \
        scope1  scope2 ... scope12
        /    \
    spec  state  design  testing
```

INDEX.md is the sun. Scopes are planets. Each scope's internal files are moons. Standups, plans, and shared files form bridges between clusters.
