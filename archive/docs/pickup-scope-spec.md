# Pickup Prompt: Scope Spec Process

> Paste everything below the line into a fresh Claude Code session.
> Replace `SCOPE_ID` with the scope you're working on (e.g., `imessage-agent`).
> This runs the full interview → spec → design → testing pipeline for one scope.

---

```
I'm Jake, founder of Tryps — a group travel app (Expo + TypeScript + Supabase). I need to finalize the spec for a scope so my dev team can build it Monday.

## The Scope

SCOPE_ID: imessage-agent
SCOPE_NUMBER: 7
SCOPE_TITLE: iMessage Agent
DEV_ASSIGNEE: asif
WAVE: 1 (Mon Mar 23 - Wed Mar 25)

## Your Job

Run me through a structured process to produce 4 files for this scope. You are my product co-pilot — you've read all the reference material, you know the strategy, and your job is to interview me to fill gaps and then produce clean deliverables.

## The Process

### Phase 1: Load Context (do this silently, don't dump it back at me)

Read these files in this order:

1. Strategy & vision:
   - ~/tryps-docs/docs/plans/2026-03-20-feat-strategic-roadmap-mece-scope-plan.md (the MECE roadmap — Section 2 has the scope gap cards, Section 3 has sequencing)
   - ~/tryps-docs/docs/p2-p3-strategy-intake.md (38 questions answered by Jake — THIS IS THE VOICE OF THE FOUNDER)
   - ~/tryps-docs/shared/brand-strategy.md (brand strategy — voice, tone, personality, Jennifer Test origin)

2. Current scope state:
   - ~/tryps-docs/scopes - refined 3-20/SCOPE_ID/objective.md
   - ~/tryps-docs/scopes - refined 3-20/SCOPE_ID/state.md

3. Old spec(s) that feed this scope (check the cross-reference table in the roadmap Section 2 to find which old specs map to this MECE scope):
   - ~/tryps-docs/scopes - deprecated/p*/*/spec.md (read the ones that map to this scope)

4. Already-completed scope specs (CRITICAL — read ALL of these for consistency):
   - ~/tryps-docs/scopes - refined 3-20/*/spec.md (read every spec.md that exists in sibling scope folders)
   - ~/tryps-docs/scopes - refined 3-20/*/objective.md (skim objectives of all other scopes)
   - These represent guidance Jake has already given. Any interdependencies, shared concepts (like the Jennifer Test), or cross-scope references must be consistent with what's already been specced.
   - If another scope's spec references THIS scope (e.g., "depends on agent-intelligence"), note that — it's a constraint.

5. Supporting docs:
   - ~/tryps-docs/shared/brand.md (brand tokens, voice rules)
   - ~/tryps-docs/shared/clickup.md (ClickUp task mapping — find the clickup_ids for this scope)
   - ~/tryps-docs/docs/2026-03-20-tryps-week3-current-state.md (timeline, current state summary)

After reading, give me a 5-line summary: what this scope IS, what's built, what's not built, what the old spec covers, and what's MISSING from the old spec that the new MECE scope now includes. Then add a 6th line: "Cross-scope notes:" listing any references to this scope found in already-completed specs, or any consistency points to maintain.

### Phase 2: Interview Jake (5-8 targeted questions)

Based on the gaps you found, interview me. Rules:
- Ask ONE question at a time. Wait for my answer before the next.
- Don't ask me things that are already answered in the strategy intake or old spec.
- Focus on: what does "done" look like for April 2? What's in/out? What's changed since the old spec?
- For the iMessage Agent scope specifically, I need to be asked about:
  - The Jennifer Test (defined in strategy intake Q8: "if you told your grandmother this was a human travel agent named Jennifer, she would 1000% believe it")
  - Agent personality specifics that go beyond brand voice
  - What "system prompt architecture" means to me
  - Which of the 40 old criteria are still accurate vs. need updating
  - What's new that wasn't in the old spec (personality, proactive behavior details)

### Phase 3: Write Deliverables

After the interview, produce 4 files. Show me each one for review before writing.

#### 3a. objective.md (refined)
- Explain key concepts (like the Jennifer Test) so anyone reading understands
- Clear What / Why / Success Looks Like
- Add "Wave Assignment" section: what happens in Wave 1 vs Wave 2 vs Wave 3
- Add "Key Concepts" section for anything that needs explaining
- Under 40 lines

#### 3b. spec.md (the main deliverable)
Structure:
```yaml
---
id: SCOPE_ID
title: "SCOPE_TITLE"
status: specced
assignee: DEV_ASSIGNEE
wave: 1
dependencies: []
clickup_ids: []  # from clickup.md
criteria_count: N
criteria_done: 0
last_updated: 2026-03-21
links:
  design: ./design.md
  testing: ./testing.md
  objective: ./objective.md
  state: ./state.md
---
```

Content:
- **What** — 2-3 sentences
- **Why** — 2-3 sentences connecting to strategic principles
- **Intent** — Jake's voice (pull from strategy intake answers)
- **Key Concepts** — explain Jennifer Test, any scope-specific concepts
- **Success Criteria** — numbered SC-1 through SC-N, each with:
  - [ ] **SC-N.** Description. Verified by: concrete test scenario.
  - Group by functional area (same structure as old spec)
  - Migrate valid criteria from old spec, add new ones from interview
  - Mark any that need design with [NEEDS DESIGN]
- **Should NOT Happen** — anti-criteria (what the feature must NOT do)
- **Out of Scope** — what's explicitly deferred past April 2
- **Regression Risk** — what existing features could break
- **Dependencies** — what must be done before/after, referencing other scope IDs
- **References** — links to old specs, strategy docs, brand docs

End with a kickoff prompt block (same format as old specs but updated paths).

#### 3c. design.md
Only if this scope has design needs. Structure:
```yaml
---
id: SCOPE_ID
needs_figma: true/false
designer: unassigned
design_status: not-started
screens: []
last_updated: 2026-03-21
---
```
- List each screen/asset needed
- For each: what it is, what it needs to convey, any constraints from brand.md
- Reference which spec criteria are blocked by this design ([NEEDS DESIGN] items)

#### 3d. testing.md
Structure:
```yaml
---
id: SCOPE_ID
qa_assignee: andreas
test_status: not-started
criteria_total: N
criteria_passing: 0
last_tested: null
---
```
- Extract every SC-N "Verified by:" into a test step
- Group by functional area
- Add pass/fail checkboxes
- Include regression tests from the spec

### Phase 4: Review & Write

Show me all 4 files. I'll review. Once I approve:
1. Write them to ~/tryps-docs/scopes - refined 3-20/SCOPE_ID/
2. Update the state.md in the same folder (status → specced)
3. Update ~/tryps-docs/scopes - refined 3-20/INDEX.md if needed

### Phase 5: Handoff Summary

After files are written, produce a 10-line handoff that I can paste into Slack/ClickUp:
- What this scope is (1 line)
- What's built vs remaining (2 lines)
- Wave assignment (1 line)
- Key concepts the dev needs to understand (2 lines)
- First task to start Monday (1 line)
- Where to find the spec (1 line)
- What's blocked on design (1 line)
- Link to testing criteria (1 line)

## Key Strategic Context (so you don't have to re-derive this)

- **Jennifer Test:** If you told your grandmother the agent was a human travel agent named Jennifer, she would 100% believe it. If grandma can't tell it's AI, we win.
- **Facilitator, not dictator:** The agent steers the group toward decisions but doesn't make taste choices.
- **iMessage first, app second:** iMessage is acquisition. App is retention. Never force someone into the app.
- **Spectrum of engagement:** Ultra-planners to "just tell me when to show up" — the product supports all.
- **The funnel:** vibe → needs → facilitation → booking. Don't jump to the end.
- **One agent, one brain:** Users experience one unified travel service across iMessage and app.
- **Trust ramp for money:** First payment explicit. Progressive autonomy after that.
- **Hard deadline:** April 2, 2026. Code shipped and tested.
- **The word "crew" is banned.** Jake hates it.

## Rules

- Be concise. Don't repeat my own strategy back to me.
- Ask questions one at a time.
- Don't write anything until the interview is done.
- Reference the old spec criteria by number (SC-1 etc.) when discussing what to keep/change.
- Every criterion must have a "Verified by:" with a concrete test scenario.
- The spec is the contract between Jake (product) and the dev. It must be unambiguous.
- **Cross-scope consistency is mandatory.** If a sibling scope's spec.md mentions this scope, references a shared concept, or defines a dependency — this spec must be consistent with that. Flag any conflicts during the interview ("the iMessage Agent spec says X about this scope — is that still accurate?").
- **Shared concepts use the same definitions.** If the Jennifer Test is defined in imessage-agent/spec.md, reference it the same way here — don't redefine it differently.
- **Dependencies go both ways.** If this scope depends on another, say so. If another scope depends on this one (found by reading sibling specs), note that in the Dependencies section so the dev knows what downstream work their scope unblocks.
```
