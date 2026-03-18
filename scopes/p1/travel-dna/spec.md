---
id: p1-travel-dna
title: "Travel DNA"
phase: p1
status: not-started
assignee: arslan
priority: 5
dependencies: []
blocked: false
blocked_reason: ""
---

# P1 Scope 5: Travel DNA — Spec

> **Phase:** P1: Core App
> **Gantt ID:** `p1-travel-dna`
> **Comp:** [Spotify Wrapped](https://spotify.com/wrapped) — personal, shareable, identity-forming. Your travel personality as a moment of self-discovery.

## What

Shareable DNA profile card, per-trip free-text preferences on the Vibe tab (and at the end of the core quiz), five nudge touchpoints to drive DNA completion, and a privacy-first group vibe summary that powers recommendations without exposing individual answers.

## Why

Travel DNA is only useful if people complete it and the group data feeds recommendations. Right now the quiz exists but nothing drives completion, there's no way to share your results, and per-trip context (injuries, must-dos, dealbreakers) has nowhere to live. This scope closes those gaps so DNA data actually flows into the recommendation engine.

## Intent

> "It's not a compatibility score. We're seeing how people want to spend their time and tailoring recommendations based on how the group wants to allocate the trip. If 90% want early mornings and no nightlife, we don't suggest clubs. If everyone wants to party, we suggest clubs."
>
> "Your DNA should be private to you. Even with trip vibe questions, nobody should see what other people said. They should just see that they completed it. Privacy is baked into the entire thesis."
>
> "Spotify Wrapped vibes. Personal, shareable, identity-forming — 'this is who I am as a traveler.'"

## Success Criteria

### Sharing Card

- [ ] **P1.S5.C01.** User can generate a shareable image of their travel personality from the My DNA tab. Verified by: user who completed the core 10 questions -> taps Share on the My DNA tab -> image generated showing persona name, top trait pills, radar chart, and Tryps branding -> native share sheet opens with the image ready to send.

- [ ] **P1.S5.C02.** Sharing card displays the user's current persona archetype, their strongest trait pills, and the 10-dimension radar chart. Verified by: user with "Adventurous Explorer" persona and 4 strong traits -> generates card -> card shows "Adventurous Explorer" title, all 4 trait pills, radar chart with 10 axes, and Tryps logo.

- [ ] **P1.S5.C03.** Shared card image renders correctly at standard social media dimensions. Verified by: generate card -> save to camera roll -> open in Photos -> image is clear, text is legible, no cropping of persona name or chart on a standard phone screen.

### Per-Trip Free-Text Preferences

- [ ] **P1.S5.C04.** Each trip has a free-text field on the Vibe tab where users describe special considerations for that trip. Verified by: user opens Vibe tab for a trip -> scrolls to free-text field -> types "I tore my ACL — no hiking or long walks" -> text saves -> reopening the Vibe tab shows the saved text.

- [ ] **P1.S5.C05.** The same free-text field appears at the bottom of the 10-question core quiz when a user joins a trip. Verified by: user joins a new trip -> completes the 10 core DNA questions -> free-text field appears below the last question with placeholder like "Anything special for this trip?" -> user types preferences -> text saves to that trip.

- [ ] **P1.S5.C06.** Free-text preferences are per-trip, not global. Verified by: user writes "I'm injured" on Trip A -> opens Trip B -> free-text field for Trip B is empty -> Trip A still shows "I'm injured."

- [ ] **P1.S5.C07.** Free-text preferences are private to the user who wrote them. Verified by: user writes preferences on Trip A -> another trip member opens the same trip's Vibe tab -> they do not see the first user's free-text content.

### Nudge: Post-Onboarding

- [ ] **P1.S5.C08.** After completing signup, users who have not taken the DNA quiz see a prompt to discover their travel personality. Verified by: new user completes signup with zero DNA answers -> prompt appears (e.g., "Discover your travel personality — takes 2 minutes") -> tapping it opens the DNA quiz.

- [ ] **P1.S5.C09.** Post-onboarding nudge does not reappear after the user completes the core 10 questions. Verified by: user completes all 10 core questions -> navigates back to home -> onboarding nudge no longer appears.

### Nudge: Trip Creation

- [ ] **P1.S5.C10.** When a user creates a trip and has not completed the core DNA quiz, a prompt appears during trip creation. Verified by: user with zero DNA answers taps "Create Trip" -> during the creation flow, a nudge appears (e.g., "Complete your Travel DNA for smarter trip suggestions") -> user can dismiss or tap to take the quiz.

- [ ] **P1.S5.C11.** Trip creation nudge does not block trip creation. Verified by: user sees the DNA nudge during trip creation -> dismisses it -> trip is still created successfully.

### Nudge: People Tab

- [ ] **P1.S5.C12.** On a trip's People tab, a status indicator shows how many members have completed their DNA. Verified by: trip with 5 members, 3 have completed DNA -> People tab shows "3 of 5 completed Travel DNA" or equivalent visual.

- [ ] **P1.S5.C13.** Members who have not completed DNA are visually distinguishable from those who have, without revealing anyone's answers. Verified by: People tab shows member avatars -> completed members have a checkmark or filled indicator -> incomplete members show a prompt or unfilled indicator -> no scores, traits, or answers are visible for any member.

### Nudge: Profile Card

- [ ] **P1.S5.C14.** User's profile card shows DNA completion progress when the core quiz is partially complete. Verified by: user answers 7 of 10 core questions -> profile card shows a progress indicator (e.g., "7/10") -> completing all 10 replaces the progress bar with their persona name.

### Nudge: Agent in Group Chat

- [ ] **P1.S5.C15.** The Tryps agent sends a contextual message to the group chat when DNA data would improve a recommendation but members haven't completed it. Verified by: trip has 4 members, 2 incomplete -> agent is generating activity recommendations -> agent sends a message tied to the moment (e.g., "I'd give you better activity picks if everyone filled out their Travel DNA — 2 people haven't yet") -> message appears in the trip's group chat.

- [ ] **P1.S5.C16.** Agent DNA nudge fires at most once per trip. Verified by: agent sends DNA nudge for a trip -> same trip triggers recommendation generation again later -> no second nudge message is sent.

### Group Vibe Summary

- [ ] **P1.S5.C17.** When enough trip members complete DNA, the trip displays a group vibe summary showing approximately three commonalities about the group. Verified by: 4 of 5 members complete DNA, all lean toward adventure and early mornings -> trip shows a group vibe section with ~3 commonalities like "Adventure seekers," "Early risers," "Budget-conscious."

- [ ] **P1.S5.C18.** Group vibe summary does not expose any individual's scores, answers, or dimension positions. Verified by: inspect the group vibe summary for a trip -> only aggregate traits visible (e.g., "Your group likes adventure") -> no individual names linked to specific preferences -> no numerical scores shown.

- [ ] **P1.S5.C19.** Group vibe summary updates when a new member completes their DNA. Verified by: trip shows "Adventure seekers, Early risers" with 3 members -> 4th member completes DNA with luxury and nightlife preferences -> group vibe summary recalculates and may shift (e.g., adds "Mixed on nightlife").

### Privacy

- [ ] **P1.S5.C20.** Individual DNA answers, dimension scores, persona, and radar chart are never visible to other trip members anywhere in the app. Verified by: inspect all trip screens (People tab, Vibe tab, group vibe summary, activity recommendations) -> no individual DNA data from other members is displayed.

- [ ] **P1.S5.C21.** The sharing card is the only way another person sees your DNA details, and it requires the user to explicitly tap Share. Verified by: user does not tap Share -> their persona, traits, and radar are not visible to anyone else in any context -> user taps Share and sends via iMessage -> recipient sees the card image.

### Should NOT Happen

- [ ] **P1.S5.C22.** Individual DNA answers or scores are never included in API responses to other users. Verified by: inspect network requests on the People tab and group vibe summary -> responses contain only aggregate data and completion booleans, never another user's raw answers or dimension scores.

- [ ] **P1.S5.C23.** Nudges never block or interrupt core app flows. Verified by: trigger each of the 5 nudge touchpoints -> in every case, the user can dismiss the nudge and continue their original task (signup, trip creation, browsing People tab) without completing the quiz.

- [ ] **P1.S5.C24.** The app never labels the group output as a "compatibility score" or shows a numerical compatibility percentage to users. Verified by: search all user-facing text in the trip -> no "compatibility score," "match percentage," or numerical group rating appears.

### Out of Scope

- **Recommendation engine** — DNA data powers recommendations, but the recommendation algorithm itself is a separate scope (p1-recommendations). This scope ensures DNA data is collected and aggregated; the recs scope consumes it.
- **Quiz redesign** — The existing A/B choice quiz with 220+ questions across 4 tiers is shipped. No changes to quiz mechanics, question format, or scoring algorithm.
- **Group chat infrastructure** — Agent nudge depends on the existing messaging layer. Building or fixing group chat delivery is in notifications (p1-notifications-voting) and Linq (p2-linq-imessage).
- **DNA onboarding flow redesign** — The existing first-time empty state and quiz entry point are already designed and built. This scope adds nudges, not a new onboarding experience.

### Regression Risk

| Area | Why | Risk |
|------|-----|------|
| Vibe tab | Adding free-text field to existing tab layout | Medium |
| Core quiz flow | Appending free-text field after 10th question | Medium |
| People tab | Adding completion indicators alongside existing member list | Low |
| Profile card | Adding progress indicator to existing card component | Low |
| Group chat agent | New nudge message type in existing agent pipeline | Low |

## References

- Existing DNA code: `/t4/constants/travelDna/`, `/t4/utils/travelDnaScoring.ts`, `/t4/utils/travelDnaPersona.ts`
- Existing DNA docs: `/t4/docs/TRAVEL_DNA_V2_INDEX.md`
- Group vibe Figma: refer to existing Figma designs for group vibe summary layout

- [ ] Typecheck passes

---

## Kickoff Prompt

> Copy and paste this into any Claude Code terminal to run the autonomous scope pipeline for Travel DNA. Follow-ups have been routed to ClickUp.

```
Run the autonomous scope pipeline for "Travel DNA" (p1-travel-dna), Steps 3→7.

## Variables

- FEATURE: travel-dna
- SCOPE_DIR: /Users/jakestein/tryps-docs/scopes/p1/travel-dna
- BRANCH: feat/travel-dna
- WORKSTREAM_ID: p1-travel-dna

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
| 3 | Plan | /Users/jakestein/tryps-docs/scopes/p1/travel-dna/plan.md | Exists and >300 bytes |
| 4 | Work | /Users/jakestein/tryps-docs/scopes/p1/travel-dna/work-log.md | Exists and branch `feat/travel-dna` exists |
| 5 | Review | /Users/jakestein/tryps-docs/scopes/p1/travel-dna/review.md | Exists and not a placeholder |
| 6 | Compound | /Users/jakestein/tryps-docs/scopes/p1/travel-dna/compound-log.md | Exists and not a placeholder |
| 7 | Agent Ready | /Users/jakestein/tryps-docs/scopes/p1/travel-dna/agent-ready.md | Contains a PR URL |

### Step 3 (Plan) Context
Read the spec at SCOPE_DIR/spec.md. Every unchecked success criterion (P1.S5.C01 through P1.S5.C24) is a task. Skip items marked [NEEDS DESIGN]. Group related criteria by subsystem (sharing card, per-trip free-text preferences, nudge touchpoints, group vibe summary, privacy). Reference existing DNA code at `/t4/constants/travelDna/`, `/t4/utils/travelDnaScoring.ts`, `/t4/utils/travelDnaPersona.ts`. Write the plan to SCOPE_DIR/plan.md.

### Step 4 (Work) Context
Implement every task from the plan. Run `npm run typecheck` after each change. Commit after each fix with format "feat(travel-dna): short description". Check off each criterion in the spec as it's completed. Write progress to SCOPE_DIR/work-log.md.

### Step 5 (Review) Context
Review all changes on BRANCH against the spec criteria. Flag anything that doesn't match the "Verified by:" test. Write SCOPE_DIR/review.md. If review says FAIL, re-run Steps 4→5. Max 2 retries.

### Step 6 (Compound) Context
Document any patterns, gotchas, or reusable solutions discovered during work. Write SCOPE_DIR/compound-log.md.

### Step 7 (Agent Ready) Context
Create PR targeting `develop` with title "[P1] Travel DNA — sharing card, per-trip preferences, nudges, group vibe". Request review from `asifraza1013` and `Nadimkhan120`. Write SCOPE_DIR/agent-ready.md with PR URL and summary.

## After Each Step

```bash
curl -s -X PATCH -H "x-api-key: $(cat ~/.mission-control-api-key)" -H "Content-Type: application/json" "https://marty.jointryps.com/api/workstreams/p1-travel-dna/pipeline/{step_key}" -d '{"status": "complete"}'
```

Print: `[pipeline] ✓ Step N: {name} complete` or `[pipeline] ✗ Step N: {name} FAILED`

## Rules

- Do NOT open files in Marked 2 during Steps 3-6. Only open agent-ready.md after Step 7.
- Do NOT ask me anything. Run all steps autonomously.
- Each agent prompt must include: "Do NOT open files with open -a. Write files only."
- Skip criteria marked [NEEDS DESIGN] — those require Figma work first.

## After Step 7

Print the final report with all artifact paths and PR URL.
Open /Users/jakestein/tryps-docs/scopes/p1/travel-dna/agent-ready.md in Marked 2.
```
