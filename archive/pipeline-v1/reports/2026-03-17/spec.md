# Jake's Morning Report — 2026-03-17

> **Status:** Active
> **Type:** Daily Report
> **Gantt ID:** `reports-2026-03-17`
> **Date:** 2026-03-17

## Overview

Broad testing session across all main tabs (Home, Calendar, Explore, People, Trip Detail). Multiple bugs found — globe not loading, vibe not saving, flights can't be added. Several UX mismatches with Figma designs, especially Calendar tab. App health: functional but rough around the edges.

## Success Criteria

### Bugs Found

- [x] **Explorer globe not loading.** The globe visualization on the Explore tab fails to render. Verified by: open Explore tab → globe renders and is interactive.
- [x] **Explore tab background too dark in light mode.** Background should be lighter to match light mode palette. Verified by: toggle to light mode → Explore tab background matches the light theme bg color (#f5f7fa or equivalent).
- [x] **People tab has cream background.** Should match the app's standard background color, not cream. Verified by: open People tab → background color matches other tabs.
- [x] **Group vibe not saving.** When setting a vibe on the Group Vibe tab, the selection does not persist. Verified by: open Group Vibe tab → select a vibe → navigate away → return → vibe selection is still there.
- [ ] **Trending songs in NYC not working.** The "Trending in [City]" feature for songs returns no results or errors. Verified by: open Vibe tab for a NYC trip → trending songs section loads with actual results. [SKIPPED — backend issue, not a client fix]
- [x] **Unable to remove photos from mood board.** No delete/remove action available for photos added to the mood board. Verified by: add a photo to mood board → long press or swipe → delete option appears → photo is removed.
- [x] **Unable to add flights in the People tab.** The flight add flow is broken or missing from the People tab. Verified by: open People tab → tap add flight → flight entry form appears → flight saves successfully.
- [x] **App lands on Activities tab instead of Itinerary tab.** When opening trip detail, the default tab should be Itinerary, not Activities. Verified by: open any trip → first visible tab is Itinerary.

### UX Issues

- [x] **Trip card swipe navigation dots lag.** The little square indicators at the top lag behind when swiping between trips on the home screen. Verified by: swipe between 3+ trips → dot indicator updates in sync with the swipe gesture, no visible delay.
- [x] **Tab name says "My Trip" instead of "My Trips".** Should be plural — "My Trips" with a y. Verified by: check home tab label → reads "My Trips" (plural).
- [ ] **Calendar tab does not match Figma design.** No year toggle, unclear green vs gray highlighting, trip dates don't display correctly. The whole tab needs a redesign pass. Verified by: compare Calendar tab side-by-side with Figma → year toggle exists, highlight colors are clear, trips render correctly. [SKIPPED — needs Figma audit + design team review]
- [ ] **Itinerary tab left-hand slider not working.** The day/time slider on the left side of the Itinerary tab doesn't function properly. Verified by: open Itinerary tab → slide the left rail → itinerary scrolls to corresponding time. [SKIPPED — slider component not implemented, needs design spec]
- [x] **Itinerary date picker at top doesn't move.** When tapping dates at the top of the Itinerary tab, the view doesn't scroll to that date. Verified by: tap a date in the top date picker → itinerary view scrolls to that day's content.
- [x] **Share action should be a bottom sheet modal.** Currently share is not presented as a bottom pop-up modal. Verified by: tap Share on a trip → a bottom sheet modal slides up with share options (not a full screen or inline action).

### External Feedback

No external feedback today.

### Ideas & Improvements

- [ ] **Share trip directly from home screen.** Add ability to long-press or swipe up on a trip card on the home screen to share it without opening the trip first. Verified by: long press on trip card → share sheet appears with trip invite link.
- [ ] **Dress code feature needs a rework.** Current dress code UI/UX is not meeting expectations — needs a design rethink. Verified by: new dress code design spec created and implemented.
- [ ] **Drag activities between Discover and voting block.** Users should be able to drag activities from Discover into the voting block, and drag them back out to remove them. Verified by: in Activities tab → drag an activity card from Discover section into voting block → card appears in voting → drag it back → card returns to Discover and is removed from voting.

### Follow-ups

- [ ] **Audit Calendar tab against Figma.** Pull up Figma Calendar screens and do a pixel-level comparison to identify all discrepancies. Assigned to: design team review.
- [ ] **Investigate dress code feature scope.** Determine what the reworked dress code should look like — needs a brainstorm or spec. Assigned to: Jake + design.

---

## Kickoff Prompt

> Copy and paste this into any Claude Code terminal to run the autonomous scope pipeline for this morning report. Follow-ups have been routed to ClickUp.

```
Run the autonomous scope pipeline for "Morning Report 2026-03-17" (reports-2026-03-17), Steps 3→7.

## Variables

- FEATURE: morning-report-2026-03-17
- SCOPE_DIR: /Users/jakestein/tryps-docs/scopes/reports/2026-03-17
- BRANCH: fix/morning-report-0317
- WORKSTREAM_ID: reports-2026-03-17

## How It Works

Use the **Agent tool** to run each step. Each agent is a full Opus session with its own context.

For each step:
1. **Check if output already exists** and passes verification — if yes, skip to the next step
2. Construct the step prompt using the spec and variables above
3. Spawn an Agent with: `model: "opus"`, `mode: "bypassPermissions"`, the prompt
4. Wait for the agent to complete
5. Verify the output file exists
6. Update Mission Control, print status, move to next step

## Steps

| # | Name | Output | Skip If |
|---|------|--------|---------|
| 3 | Plan | /Users/jakestein/tryps-docs/scopes/reports/2026-03-17/plan.md | Exists and >300 bytes |
| 4 | Work | /Users/jakestein/tryps-docs/scopes/reports/2026-03-17/work-log.md | Exists and branch `fix/morning-report-0317` exists |
| 5 | Review | /Users/jakestein/tryps-docs/scopes/reports/2026-03-17/review.md | Exists and not a placeholder |
| 6 | Compound | /Users/jakestein/tryps-docs/scopes/reports/2026-03-17/compound-log.md | Exists and not a placeholder |
| 7 | Agent Ready | /Users/jakestein/tryps-docs/scopes/reports/2026-03-17/agent-ready.md | Contains a PR URL |

### Step 3 (Plan) Context
Read the spec at SCOPE_DIR/spec.md. Every unchecked criterion under "Bugs Found", "UX Issues", and "Ideas & Improvements" is a task. Skip items marked [NEEDS DESIGN]. Group related fixes by file/component. Write the plan to SCOPE_DIR/plan.md.

### Step 4 (Work) Context
Implement every task from the plan. Run `npm run typecheck` after each change. Commit after each fix with format "fix(report-0317): short description". Check off each criterion in the spec as it's completed. Write progress to SCOPE_DIR/work-log.md.

### Step 5 (Review) Context
Review all changes on BRANCH against the spec criteria. Flag anything that doesn't match the "Verified by:" test. Write SCOPE_DIR/review.md. If review says FAIL, re-run Steps 4→5. Max 2 retries.

### Step 6 (Compound) Context
Document any patterns, gotchas, or reusable solutions discovered during work. Write SCOPE_DIR/compound-log.md.

### Step 7 (Agent Ready) Context
Create PR targeting `develop` with title "[Report 0317] Fix bugs + improvements from Jake's morning report". Request review from `asifraza1013` and `Nadimkhan120`. Write SCOPE_DIR/agent-ready.md with PR URL and summary.

## After Each Step

```bash
curl -s -X PATCH -H "x-api-key: $(cat ~/.mission-control-api-key)" -H "Content-Type: application/json" "https://marty.jointryps.com/api/workstreams/reports-2026-03-17/pipeline/{step_key}" -d '{"status": "complete"}'
```

Print: `[pipeline] ✓ Step N: {name} complete` or `[pipeline] ✗ Step N: {name} FAILED`

## Rules

- Do NOT open files in Marked 2 during Steps 3-6. Only open agent-ready.md after Step 7.
- Do NOT ask me anything. Run all steps autonomously.
- Each agent prompt must include: "Do NOT open files with open -a. Write files only."
- Skip criteria marked [NEEDS DESIGN] — those require Figma work first.

## After Step 7

Print the final report with all artifact paths and PR URL.
Open /Users/jakestein/tryps-docs/scopes/reports/2026-03-17/agent-ready.md in Marked 2.
```
