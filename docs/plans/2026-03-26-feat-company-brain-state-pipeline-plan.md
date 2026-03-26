---
title: "Company Brain: State Pipeline, Feedback Loop, and Graph Connectivity"
type: feat
date: 2026-03-26
---

# Company Brain: State Pipeline, Feedback Loop, and Graph Connectivity

## Overview

Turn tryps-docs from a document repo into an operational brain. Three moves: (1) populate the empty shared/state.md from scope data, (2) create a feedback loop where standup answers flow back into state, (3) connect the remaining orphan files in the Obsidian graph.

## Problem Statement

We just wired ~150 wiki links across 47 files to make the Obsidian graph useful. The graph is more connected, but three structural gaps remain:

1. **shared/state.md is empty.** It's @imported into every Claude session via CLAUDE.md, so every session starts with "0 scopes." The header says "auto-generated from spec.md frontmatter" but no generator exists.
2. **Standup answers are a dead end.** Devs answer 5 questions daily with rich detail (SC counts, PR numbers, blockers) but that data dies in the standup file. Nothing updates scope state.md files. Marty re-asks the same questions because no system recorded the answer.
3. **55+ files still orphaned in the Obsidian graph.** Plans, shared files, and some scope siblings aren't linked.

## Move 1: Fix the State Pipeline

### 1a. Create missing state.md

Only `customer-service-triaging` is missing a state.md. Create it with the canonical frontmatter schema:

```yaml
---
id: customer-service-triaging
status: needs-spec
assignee: jake
clickup_ids: []
criteria: 0/0
blockers: ["Needs spec session"]
last_updated: 2026-03-26
updated_by: jake
review_status: un-reviewed
---
```

### 1b. Refresh all 12 scope state.md frontmatter

Update each scope's state.md frontmatter to reflect current reality from standups + ClickUp. Key updates based on standup data from March 23-26:

| Scope | Current `status` | Correct `status` | Key data to update |
|-------|-----------------|-------------------|-------------------|
| agent-intelligence | specced | in-progress | criteria: 55/61 (per Mar 26 standup table), assignee: rizwan |
| imessage-agent | specced | in-progress | criteria: 34/57 (per Mar 26 Q2), assignee: asif |
| output-backed-screen | specced | in-progress | criteria: 7/48 implemented (per Mar 25 standup), assignee: nadeem |
| travel-booking | specced | in-progress | assignee: asif, rizwan |
| core-trip-experience | built | testing | criteria: 15/16 built, assignee: nadeem/andreas |
| beta-user-feedback | in-progress | in-progress | (no change needed) |
| group-decision-making | partial | needs-spec | (no change needed) |
| travel-identity | partial | needs-spec | (no change needed) |
| onboarding-teaching | partial | needs-spec | (no change needed) |
| post-trip-retention | partial | specced | criteria: 0/39 |
| payments-infrastructure | not-started | not-started | (no change needed) |
| customer-service-triaging | (new) | needs-spec | (new file) |

Also normalize `last_updated` to bare date format (`2026-03-26`) across all files for consistency.

### 1c. Populate shared/state.md

Aggregate all 12 scope state.md frontmatter values into the table:

```markdown
# Tryps State

> Auto-generated from scope state.md frontmatter. Do not edit manually.
> Last updated: 2026-03-26 20:00 UTC

## Scope Status

| ID | Title | Status | Assignee | Criteria | Notes |
|----|-------|--------|----------|----------|-------|
| beta-user-feedback | Beta & User Feedback | in-progress | jake | — | Ongoing, no spec needed |
| core-trip-experience | Core Trip Experience | testing | nadeem / andreas | 15/16 | Bug testing in progress |
| group-decision-making | Group Decision-Making | needs-spec | — | 0/0 | Jake to spec |
| travel-identity | Travel Identity | needs-spec | — | 0/0 | Jake to spec |
| onboarding-teaching | Onboarding & Teaching | needs-spec | — | 0/0 | Jake to spec |
| post-trip-retention | Post-Trip & Retention | specced | nadeem | 0/39 | Spec exists, not started |
| imessage-agent | iMessage Agent | in-progress | asif | 34/57 | 34 QA passing |
| agent-intelligence | Agent Intelligence | in-progress | rizwan | 55/61 | 55 ready for QA |
| payments-infrastructure | Payments Infrastructure | not-started | rizwan | 0/0 | Blocked on scope 7+8 |
| travel-booking | Travel Booking | in-progress | asif, rizwan | 0/58 | API integrations ongoing |
| output-backed-screen | Output-Backed Screen | in-progress | nadeem | 7/48 | Overview tab started |
| customer-service-triaging | Customer Service & Triaging | needs-spec | jake | 0/0 | Added 2026-03-24 |

## Summary

- **12 scopes** total: 0 done, 4 in-progress, 1 testing, 1 specced, 4 needs-spec, 1 not-started
- **5 with criteria**, 3 need spec
- **8 assigned**, 0 blocked
```

### 1d. Update priorities.md

`shared/priorities.md` is stale (still references P1/P2/P3 model from March 18). Update to reflect MECE scopes and current assignments:

```markdown
# Current Priorities

> Updated: 2026-03-26

## This Week

- **Nadeem** — Output-Backed Screen (48 SC, overview tab in progress) + bug fixes (78 open)
- **Asif** — iMessage Agent (57 SC, 34/57 QA passing) + Vercel deploy + vCard
- **Rizwan** — Agent Intelligence (61 SC, 55/61 ready for QA) + cross-scope interfaces with Asif

## Cross-Scope Coordination

- **Asif + Rizwan** — SC-59/60/61 interface session (DM delivery, vote override routing, rate limiter)
- **Nadeem + Rizwan** — Maestro E2E test ownership (who writes which YAML flows)

## Jake's Focus

- Spec sessions for: group-decision-making, travel-identity, onboarding-teaching, customer-service-triaging
- Company brain / state pipeline (this plan)
- Brand & GTM with Sean
```

## Move 2: Standup Answer Feedback Loop

### The Loop

```
Marty generates standup questions (8 PM cron)
         ↓
Devs answer questions in standup doc (next day)
         ↓
Marty reads answers after standup commit (NEW)
         ↓
Marty updates scope state.md frontmatter (NEW)
         ↓
Marty regenerates shared/state.md (NEW)
         ↓
Next session loads fresh state via CLAUDE.md @import
         ↓
Marty generates better questions (8 PM cron) — loop closes
```

### 2a. Add state update instructions to Marty's standup skill

Add a new section to `marty/skills/tryps-standup` (or create a new `tryps-state-sync` skill) with these instructions:

**After devs commit standup answers (trigger: new commit to standups/ on main):**

1. Read the standup doc
2. For each dev's answers, extract:
   - SC counts (e.g., "34 out of 57 are done" → `criteria: 34/57`)
   - Status changes (e.g., "started implementation" → `status: in-progress`)
   - New blockers mentioned
   - PRs merged (cross-reference with GitHub)
3. Update the corresponding `scopes/{scope}/state.md` frontmatter fields:
   - `criteria` — update done/total count
   - `status` — update if changed
   - `blockers` — add/remove based on answers
   - `last_updated` — set to today
   - `updated_by` — set to `marty`
4. Regenerate `shared/state.md` by reading all 12 scope state.md frontmatter values
5. Commit and push with message: `chore: sync state from standup answers (YYYY-MM-DD)`

### 2b. Add state sync to Marty's heartbeat

Add to `marty/HEARTBEAT.md` as a new scheduled task:

```
### Post-Standup State Sync (after standup commits land, ~3:00 PM ET)

1. Detect new commits to standups/ since last check
2. Run state extraction from standup answers
3. Update scope state.md files
4. Regenerate shared/state.md
5. Commit and push
```

### 2c. Manual fallback

Until Marty's automation is running, Jake or any session can run this manually:

```
Read the latest standup at ~/tryps-docs/standups/2026-03-26-standup.md.
Extract SC counts, status changes, and blockers from each dev's answers.
Update the corresponding scopes/*/state.md frontmatter.
Then regenerate shared/state.md by aggregating all 12 scope state.md files.
Commit and push.
```

## Move 3: Connect Remaining Orphans

### 3a. Create docs/plans/INDEX.md

Index all 17 plan files:

```markdown
# Plans Index

Strategic plans, feature plans, and operational plans. Newest first.

| Date | Plan | Type | Status |
|------|------|------|--------|
| 2026-03-26 | [[2026-03-26-feat-company-brain-state-pipeline-plan|Company Brain: State Pipeline]] | feat | active |
| 2026-03-25 | [[2026-03-25-refactor-tryps-docs-file-structure-plan|File Structure Refactor]] | refactor | done |
| 2026-03-25 | [[2026-03-25-feat-obsidian-wiki-links-plan|Obsidian Wiki Links]] | feat | done |
| 2026-03-25 | [[2026-03-25-feat-obsidian-github-sync-plan|Obsidian-GitHub Sync]] | feat | done |
| 2026-03-24 | [[2026-03-24-marty-dev-interaction-model|Marty Dev Interaction Model]] | feat | proposed |
| 2026-03-24 | [[2026-03-24-feat-marty-improvement-day-plan|Marty Improvement Day]] | feat | done |
| 2026-03-24 | [[2026-03-24-feat-figma-mcp-setup-plan|Figma MCP Setup]] | feat | done |
| 2026-03-24 | [[2026-03-24-feat-brand-and-gtm-workspace-setup-plan|Brand & GTM Workspace Setup]] | feat | done |
| 2026-03-23 | [[2026-03-23-marty-revamp-plan|Marty Revamp]] | feat | in-progress |
| 2026-03-23 | [[2026-03-23-marty-revamp-kickoff|Marty Revamp Kickoff]] | feat | done |
| 2026-03-22 | [[2026-03-22-feat-rd-council-autonomous-meetings-plan|R&D Council Autonomous Meetings]] | feat | proposed |
| 2026-03-20 | [[2026-03-20-feat-strategic-roadmap-mece-scope-plan|Strategic Roadmap (MECE)]] | feat | canonical |
| 2026-03-19 | [[2026-03-19-feat-beta-launch-sprint-and-jackson-prep-plan|Beta Launch Sprint]] | feat | superseded |
| 2026-03-19 | [[2026-03-19-fix-beta-polish-nadeem-ticket|Beta Polish (Nadeem)]] | fix | done |
| 2026-03-19 | [[2026-03-19-beta-standup-checklist|Beta Standup Checklist]] | feat | superseded |
| 2026-03-18 | [[2026-03-18-feat-brand-strategy-and-brand-book-plan|Brand Strategy & Brand Book]] | feat | in-progress |
| 2026-03-18 | [[2026-03-18-feat-p2-p3-scope-consolidation-and-spec-pipeline-plan|P2/P3 Scope Consolidation]] | feat | superseded |
```

### 3b. Add wiki links from README to missing shared files

Update README.md Key Files table to include all shared files:

```markdown
| [[decisions|shared/decisions.md]] | Strategic decisions log |
| [[team|shared/team.md]] | Team roster, org chart, contacts |
| [[observations|shared/observations.md]] | Agent observations for Jake review |
| [[priorities|shared/priorities.md]] | Current sprint focus |
| [[brand-strategy|shared/brand-strategy.md]] | Brand strategy (pending Trent review) |
```

Also add Plans Index to Key Files:

```markdown
| [[docs/plans/INDEX|docs/plans/INDEX.md]] | All strategic and feature plans |
```

### 3c. Add parent backlinks to scope state.md files without them

The Tier 3 wiki links exercise added `> Parent:` backlinks to sibling files in 4 scopes. The remaining 8 scope state.md files also need this:

- beta-user-feedback, core-trip-experience, group-decision-making, onboarding-teaching, post-trip-retention, payments-infrastructure, travel-identity, customer-service-triaging

Add `> Parent: [[{scope}/objective|{Scope Name} Objective]]` after the frontmatter.

## Standup Update

Add this paragraph to the top of today's standup (`standups/2026-03-26-standup.md`), before the questions section:

```markdown
## Knowledge Graph Update (Jake)

Last night we added ~150 wiki links across 47 files in tryps-docs and set up Obsidian as a graph view over the repo. Every scope now links to its siblings (spec, state, design, testing) and cross-references dependencies. Standups link to their scopes. The hub files (INDEX.md, README, strategic roadmap) are the central nodes. We also fixed all broken URL-encoded links in standups, created a plans index, and connected shared files. The graph is live — open Obsidian and hit Cmd+G to see it. Rizwan: if you notice any broken links or missing connections while working in tryps-docs, flag them in #dev. The next step is wiring up the state pipeline so shared/state.md auto-populates from scope data and standup answers feed back into state — that work is happening today.
```

## Acceptance Criteria

- [ ] `customer-service-triaging/state.md` exists with correct frontmatter
- [ ] All 12 scope state.md files have up-to-date frontmatter (status, criteria, assignee, last_updated)
- [ ] `shared/state.md` has 12 rows with current data (not empty)
- [ ] `shared/priorities.md` reflects MECE scopes and current assignments (not P1/P2/P3)
- [ ] `docs/plans/INDEX.md` exists with wiki links to all 17 plans
- [ ] README.md Key Files table includes all shared files + plans index
- [ ] All 12 scope state.md files have `> Parent:` backlinks
- [ ] Standup update paragraph added to `2026-03-26-standup.md`
- [ ] Marty state sync process documented in tryps-docs (skill or HEARTBEAT update)
- [ ] shared/state.md is committed and pushed — next session loads real data

## References

- Wiki links plan: `docs/plans/2026-03-25-feat-obsidian-wiki-links-plan.md`
- Memory architecture brainstorm: `docs/brainstorms/2026-03-18-memory-architecture-brainstorm.md`
- Marty revamp plan: `docs/plans/2026-03-23-marty-revamp-plan.md`
- Marty dev interaction model: `docs/plans/2026-03-24-marty-dev-interaction-model.md`
- Scope INDEX: `scopes/INDEX.md`
