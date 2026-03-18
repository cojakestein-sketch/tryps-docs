---
title: "feat: Marty Pipeline Feedback Skills"
type: feat
date: 2026-03-15
---

# Marty Pipeline Feedback Skills

## Overview

Build 3 OpenClaw skills that make Marty an active participant in the scope pipeline — not just a passive observer. Instead of "here's a PR, go review it," Marty reads the pipeline artifacts, generates specific questions, posts them to Slack, collects dev responses, writes them back to the scope folder, and the pipeline continues informed.

## Problem Statement

The 10-step pipeline has two human touchpoints (Step 8: Dev Feedback, Step 10: Merge) but they're passive. Devs get a PR link and a wall of code with no guidance on what to focus on. There's also no pre-Plan sanity check — Claude might plan an entire implementation on wrong assumptions that a 30-second Slack reply from Asif would have caught.

## Three Skills

### 1. `pipeline-feasibility-check` (Step 2→3 Gate)

**When:** FRD is complete (`frd.status = "ready"`), before Plan begins.

**What Marty does:**
1. Read `scopes/{phase}/{scope}/frd.md` and `codebase-scan.md`
2. Extract technical decisions: new tables, schema changes, edge functions, RLS policies, external API deps
3. Generate 3-5 **specific** feasibility questions
4. Post to `#dev` channel as a threaded message, tagging `@Asif` (architecture) and `@Nadeem` (implementation)
5. Create a follow-up reminder: if no response in 4 hours, DM Jake
6. When devs respond (in-thread), capture responses
7. Write `dev-input-plan.md` to scope folder with Q&A pairs
8. If no response after timeout: proceed with assumptions documented in `dev-input-plan.md`

**Question generation rules:**
- Read the FRD for NEW database tables, edge functions, and RLS policies
- Cross-reference `codebase-scan.md` to find existing patterns that might conflict
- Questions must be answerable in 1-2 sentences — not "thoughts on the FRD?"
- Always include: "Any ongoing work touching this area?"
- If FRD adds a migration: "Is this safe to run on prod with current data volume?"
- If FRD touches auth/invite flow: flag with high priority

**Example output (Slack):**

```
**Feasibility Check — Notifications & Voting (P1/Scope 3)**

The FRD is ready. Before I plan implementation, want your input on:

1. @Asif — FRD adds a `trip_votes` table. Should the primary key be composite `(trip_id, user_id)` or a separate `id` column? Current pattern in `trip_expenses` uses composite.
2. @Nadeem — This scope modifies the notification edge function (`handle-push-notification`). Any in-progress work there?
3. @Asif — RLS policy uses `auth.uid() = user_id`. Do we also need trip membership check (`EXISTS (SELECT 1 FROM trip_participants...)`)?
4. The FRD estimates this as **medium complexity**. Does that feel right?

Reply in-thread. If I don't hear back by 2pm ET, I'll proceed with assumptions and note them in the plan.
```

**Output file:** `scopes/{phase}/{scope}/dev-input-plan.md`

```markdown
# Dev Input — Pre-Plan Feasibility Check
**Scope:** {scope-name}
**Posted:** {timestamp}
**Responded:** {timestamp} | No response (timeout — proceeded with assumptions)

## Questions & Responses

### 1. Primary key pattern for trip_votes
**Asked:** @Asif
**Response:** "Use composite — matches our pattern. No surrogate needed."
**Impact on plan:** Use composite PK (trip_id, user_id)

### 2. Notification edge function conflicts
**Asked:** @Nadeem
**Response:** No response (timeout)
**Assumption:** No conflicts. Will check git blame before modifying.

...
```

---

### 2. `pipeline-active-review` (Step 7→8 Active PR Review)

**When:** Agent Ready step completes (`mergePr.status = "pr_open"`), PR exists.

**What Marty does:**
1. Read `scopes/{phase}/{scope}/review.md` — extract findings, warnings, uncertain areas
2. Read `scopes/{phase}/{scope}/compound-learnings.md` — extract "what to watch for"
3. Read `scopes/{phase}/{scope}/agent-ready.md` — get PR URL, files changed
4. Read the PR diff via GitHub MCP
5. Generate 3-5 **pointed review questions** focused on what Claude was uncertain about
6. Post to `#dev` as a threaded message with the PR link
7. Create follow-up reminder: if no response in 24 hours, DM Jake
8. When devs respond (in-thread), capture each answer
9. Write responses to `scopes/{phase}/{scope}/dev-feedback.md`
10. Update Mission Control: `devFeedback.status = "submitted"`

**Question generation rules:**
- Prioritize items from `review.md` marked as warnings or uncertain
- Prioritize items from `compound-learnings.md` under "gotchas" or "watch for"
- Always include: one question about RLS/security, one about migration safety (if applicable)
- Link to specific files/lines in the PR
- If review found 0 issues: still ask 2-3 questions about the riskiest code paths

**Example output (Slack):**

```
**PR Review — #312: Notifications & Voting** (link)

This scope adds push notifications for trip votes and a new voting system. Here's what I'd like your eyes on:

1. **RLS Policy** (migrations/20260315_trip_votes.sql:14) — `auth.uid() = user_id` is the only check. Should we also verify trip membership? The `trip_expenses` table does both.
2. **Edge Function** (supabase/functions/handle-vote/index.ts:47) — I'm sending notifications to ALL trip participants when a vote is cast. Should we exclude the voter? Current `handle-push-notification` excludes the actor.
3. **Migration safety** — Adding composite index on `(trip_id, created_at)`. Any concern with current prod data volume?
4. **Test coverage** — I added 6 tests for the voting RPC but none for the notification edge function. Should I add those before merge?

@Asif — questions 1, 3 are for you
@Nadeem — questions 2, 4 are for you

Reply in-thread. I'll implement any feedback and push to the same PR.
```

**Output file:** `scopes/{phase}/{scope}/dev-feedback.md`

```markdown
# Dev Feedback — PR Review
**Scope:** {scope-name}
**PR:** #{number} — {title}
**Posted:** {timestamp}
**Status:** Awaiting | Partial | Complete

## Review Questions & Responses

### 1. RLS policy — trip membership check
**Reviewer:** @Asif
**Response:** "Yes, add the trip membership check. Match the pattern in trip_expenses."
**Action:** Add `EXISTS (SELECT 1 FROM trip_participants WHERE trip_id = trip_votes.trip_id AND user_id = auth.uid())` to RLS policy
**Priority:** Must-fix

### 2. Notification — exclude voter
**Reviewer:** @Nadeem
**Response:** "Good catch. Exclude the voter, same as expenses."
**Action:** Filter out `auth.uid()` from notification recipients
**Priority:** Must-fix

...

## Summary
- **Must-fix:** 2 items
- **Nice-to-have:** 1 item
- **No action needed:** 1 item
```

---

### 3. `pipeline-merge-confirm` (Step 9→10 Gate)

**When:** Fixes & Learnings step completes (`postDevFixes.status = "complete"`).

**What Marty does:**
1. Read `scopes/{phase}/{scope}/fixes-learnings.md` — get list of fixes applied
2. Read `scopes/{phase}/{scope}/dev-feedback.md` — get original feedback items
3. Cross-reference: for each feedback item, confirm it was addressed
4. Read the latest PR diff (post-fix commits only)
5. Generate a concise summary: what was fixed, what was unchanged (with reason)
6. Post to `#dev` tagging the original reviewers
7. Create follow-up reminder: if no approval in 4 hours, DM Jake
8. When dev approves (thumbs up, "LGTM", or "approved"): note in scope folder

**Example output (Slack):**

```
**Fixes Complete — PR #312: Notifications & Voting**

Dev feedback addressed. Here's what changed:

1. **RLS policy** — Added trip membership check to `trip_votes`. Matches `trip_expenses` pattern. ✅
2. **Notification exclusion** — Voter now excluded from push recipients. ✅
3. **Edge function tests** — Added 3 tests for notification delivery. ✅
4. **Index concern** — No change (Asif confirmed prod volume is fine). ℹ️

All 3 must-fix items resolved. 1 item confirmed no-action.

@Asif — ready for final approval and merge?
```

**Output file:** `scopes/{phase}/{scope}/merge-confirm.md`

```markdown
# Merge Confirmation
**Scope:** {scope-name}
**PR:** #{number}
**Fixes pushed:** {timestamp}
**Approval status:** Awaiting | Approved | Changes requested

## Feedback Resolution

| # | Feedback Item | Status | Commit |
|---|--------------|--------|--------|
| 1 | RLS trip membership check | Fixed | abc123 |
| 2 | Exclude voter from notifications | Fixed | abc123 |
| 3 | Edge function tests | Fixed | def456 |
| 4 | Index concern | No action (confirmed OK) | — |

## Final Approval
**Approver:** (pending)
**Date:** (pending)
**Notes:** (pending)
```

---

## Shared Patterns Across All 3 Skills

### Invocation

Each skill is invoked with a scope path parameter:

```
Run pipeline-feasibility-check for scope p1/notifications-voting
```

Marty resolves this to: `scopes/p1/notifications-voting/` in the tryps-docs repo (or local filesystem clone at `/home/openclaw/tryps-docs/`).

### Thread-Based Response Collection

All 3 skills post to Slack as a **parent message** and expect **in-thread replies**. Marty monitors the thread using Slack MCP's `get_thread_replies`. The follow-up cron checks the thread at timeout.

**Response parsing:**
- If a dev replies with a number prefix ("1. Yes, do the composite key"), match to the original question
- If a dev replies without a number, use context to match to the most relevant question
- If a dev replies with just a reaction (thumbs up), treat as approval for the parent message
- If a dev says "LGTM" or "looks good", treat as blanket approval

### Timeout Behavior

| Skill | Timeout | On timeout |
|-------|---------|------------|
| feasibility-check | 4 hours | Proceed with assumptions documented. DM Jake. |
| active-review | 24 hours | DM Jake with "no dev feedback received." |
| merge-confirm | 4 hours | DM Jake with "awaiting merge approval." |

Timeout is implemented via OpenClaw's `cron add --at` (one-shot). The cron payload tells Marty to check the Slack thread and report status.

### Slack Channel & Tagging

- **Primary channel:** `#dev` (get channel ID on first run via `slack_list_channels`)
- **Tagging:** Use Slack user IDs: Asif `U0AJZ6H8WBE`, Nadeem `U0AK8FPKK41`, Jake `U0AK8FANGNM`
- **Format:** `<@U0AJZ6H8WBE>` for Slack mentions

### Mission Control Integration

After collecting responses (or on timeout), update Mission Control via API:

```bash
API_KEY=$(cat ~/.mission-control-api-key)
curl -X PATCH "https://mc-api.jointryps.com/api/workstreams/{id}/pipeline/{step}" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"status": "submitted", "content": "..."}'
```

---

## Implementation Plan

### Phase 1: Skill Files (deploy to Marty)

Create 3 SKILL.md files following the existing pattern:

| File | Location (on Hetzner) |
|------|----------------------|
| `pipeline-feasibility-check/SKILL.md` | `~/.openclaw/workspace/skills/pipeline-feasibility-check/` |
| `pipeline-active-review/SKILL.md` | `~/.openclaw/workspace/skills/pipeline-active-review/` |
| `pipeline-merge-confirm/SKILL.md` | `~/.openclaw/workspace/skills/pipeline-merge-confirm/` |

**Also prepare locally** in `_private/planning/marty-workspace/skills/` for version control.

### Phase 2: HEARTBEAT Integration

Add pipeline monitoring to `HEARTBEAT.md`:

```
## Pipeline Monitor (Every 30 Minutes)

- Check Mission Control API for scope status changes
- If frd.status just changed to "ready" → trigger pipeline-feasibility-check
- If mergePr.status just changed to "pr_open" → trigger pipeline-active-review
- If postDevFixes.status just changed to "complete" → trigger pipeline-merge-confirm
```

This makes the skills trigger **automatically** when pipeline steps complete, not just on manual invocation.

### Phase 3: Test with Live Scope

1. Use the current `p1/notifications-voting` scope (FRD is ready per the screenshot)
2. Manually trigger `pipeline-feasibility-check`
3. Verify: Slack message appears in `#dev`, questions are specific, timeout cron created
4. Have Asif/Nadeem respond in-thread
5. Verify: `dev-input-plan.md` written correctly, Mission Control updated

### Phase 4: Scope Pipeline Prompt Updates

Update `next-prompt.txt` templates in `scope-pipeline-design-v2.md`:

- Step 2 completion: add "Marty will post feasibility questions to #dev. Check `dev-input-plan.md` before starting Step 3."
- Step 7 completion: add "Marty will post review questions. Monitor `dev-feedback.md` for responses."
- Step 9 completion: add "Marty will post merge confirmation. Await dev approval."

---

## Dependencies

- **Slack MCP working** — Marty can already post/read Slack (confirmed working)
- **GitHub MCP working** — Marty can read PRs (confirmed working)
- **Filesystem MCP working** — Marty can read/write files (confirmed working)
- **tryps-docs on Hetzner** — Already cloned at `/home/openclaw/tryps-docs` (needs `git pull`)
- **Mission Control API** — Scoped API key exists at `~/.mission-control-api-key`
- **Cron system** — Phase 2 of improvement plan fixes crons. These skills need working crons for timeout behavior. Can work without crons (manual timeout check), but automated is better.

## Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| Cron system still broken | Timeout reminders won't fire | Skills still work manually — just no auto-follow-up. Fix crons first (improvement plan Phase 2) |
| Dev channel ID unknown | Can't post to #dev | Resolve on first run via `slack_list_channels` and save to MEMORY.md |
| tryps-docs out of sync on Hetzner | Marty reads stale scope files | Add `git pull` to skill preamble |
| Question quality poor | Devs ignore generic questions | Question generation rules are specific to FRD/review content — not generic |
| Dev doesn't reply in-thread | Response parsing fails | Also check for direct replies to Marty, fall back to DM |

## Files Changed

```
_private/planning/marty-workspace/skills/pipeline-feasibility-check/SKILL.md  (new)
_private/planning/marty-workspace/skills/pipeline-active-review/SKILL.md      (new)
_private/planning/marty-workspace/skills/pipeline-merge-confirm/SKILL.md      (new)
_private/planning/marty-workspace/HEARTBEAT.md                                 (updated)
_private/notes/scope-pipeline-design-v2.md                                     (updated)
```

## Success Criteria

- [ ] All 3 skills deployed to Marty's workspace on Hetzner
- [ ] `pipeline-feasibility-check` posts specific questions (not generic) when triggered with a scope path
- [ ] `pipeline-active-review` reads review.md and generates pointed PR questions
- [ ] `pipeline-merge-confirm` cross-references feedback items with fixes
- [ ] Timeout behavior works (proceed with assumptions or DM Jake)
- [ ] Dev responses captured in structured markdown files
- [ ] Mission Control updated after each skill completes
- [ ] HEARTBEAT monitors pipeline status and auto-triggers skills

## References

- Existing skills: `_private/planning/marty-workspace/skills/` (pattern reference)
- Pipeline design: `_private/notes/scope-pipeline-design-v2.md`
- Marty improvement plan: `_private/planning/marty-improvement-plan.md`
- Marty tools: `_private/planning/marty-workspace/TOOLS.md`
- Team Slack IDs: Jake `U0AK8FANGNM`, Asif `U0AJZ6H8WBE`, Nadeem `U0AK8FPKK41`
