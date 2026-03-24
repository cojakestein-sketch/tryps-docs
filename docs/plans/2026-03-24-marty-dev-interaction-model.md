---
title: "Marty Dev Interaction Model"
type: plan
date: 2026-03-24
status: proposed
author: asif
---

# Marty Dev Interaction Model

> How Marty interacts with devs day-to-day: issue triage, code fix suggestions, PR support, proactive help. What's autonomous vs. human-gated.

## Principles

1. **Marty is a teammate, not a notification bot.** Every interaction should feel like a coworker helping, not a system pinging.
2. **Signal over noise.** Marty speaks when it adds value. If a dev is heads-down, Marty doesn't interrupt with low-priority items.
3. **Autonomous for reads, gated for writes.** Marty can analyze anything freely. Creating issues, commenting on PRs, and suggesting code changes require different approval levels depending on risk.
4. **Right dev, right time.** Marty routes issues to the person who owns that area of the codebase, not whoever is "available."
5. **Show, don't tell.** When suggesting fixes, Marty shows the exact code diff, not a vague description.

---

## Daily Interaction Loop

Marty's dev interactions follow a daily cadence aligned with the standup cycle:

```
Morning (9-10 AM ET)
  - Scan GitHub for new issues, stale PRs, failed CI
  - Scan ClickUp for status changes overnight
  - Prepare a dev-specific morning brief (DM to each dev)

Midday (standup, 2 PM ET)
  - Standup questions already generated (tryps-standup skill)
  - After standup: extract learnings, update memory

Afternoon (2-6 PM ET)
  - Monitor PRs in real-time — review when opened
  - Respond to @marty mentions in Slack
  - Route new issues to the right dev

Evening (8-9 PM ET)
  - Cron jobs: standup generator, nightly report, cost report
  - Memory distillation from the day's conversations
```

---

## 1. GitHub Issue Triage

### What Marty Does

When a new GitHub issue is opened (or a bug is reported in Slack and converted to an issue):

1. **Read and classify** the issue
2. **Check for duplicates** against open issues and ClickUp tasks
3. **Assign severity** (P0/P1/P2) using the same rubric as tryps-bug-triage skill
4. **Identify the owner** — which dev owns the affected area of code?
5. **Post a triage comment** on the issue with classification and suggested owner

### Owner Routing

Marty routes issues based on scope ownership:

| Area | Owner | Signal |
|------|-------|--------|
| iMessage agent, Linq, webhooks, agent responses | Asif | Files in `supabase/functions/linq-*`, `agent/` |
| UI screens, navigation, design system, tabs | Nadeem | Files in `app/`, `components/`, `utils/theme.ts` |
| Agent intelligence, memory, NLP, system prompt | Rizwan | Files in `utils/ai/`, `prompts/`, intelligence-related |
| Auth, deep links, invite flow, infrastructure | Jake | `contexts/Auth*`, `utils/deepLink*`, `app.json` |
| Cross-cutting (types, storage, ledger) | Whoever touched it last | Check `git blame` |

### Triage Comment Format

```markdown
## Marty Triage

**Severity:** P1 (Major)
**Category:** Bug — expense tracking
**Suggested owner:** @asifraza1013 (iMessage agent scope)
**Duplicate check:** No existing match found

**Analysis:**
This appears to be related to the expense parsing in `linq-worker`. The custom split
logic in `action-handlers.ts:handleExpense` may not handle the case where...

**Suggested fix direction:**
The issue is likely in the split parsing regex at line ~245 of action-handlers.ts.
The pattern doesn't account for [specific case]. A fix would look like:

[code suggestion if confident, or "needs investigation" if not]
```

### Autonomy Level

| Action | Autonomous? | Why |
|--------|------------|-----|
| Read and classify issue | Yes | No side effects |
| Post triage comment | Yes | Adds context, doesn't block anyone |
| Assign severity label | Yes | Can be changed easily |
| Assign to a dev | **No — suggest only** | Dev assignment is a commitment; Jake decides |
| Close as duplicate | **No — flag only** | Closing is permanent; human confirms |

---

## 2. Code Fix Suggestions

### When Marty Suggests Fixes

Marty proactively suggests code fixes when:

1. **A P0/P1 bug is triaged** and Marty can identify the likely root cause
2. **A dev asks** ("Marty, what would you change to fix this?")
3. **CI fails** on a PR and the fix is straightforward (type error, import missing, lint issue)

### How Marty Suggests Fixes

Marty posts code suggestions as **GitHub issue comments or PR review comments** with actual diffs:

```markdown
## Suggested Fix

Based on the stack trace, the issue is in `action-handlers.ts` at line 247.
The regex doesn't handle currency symbols with spaces.

**Current:**
```typescript
const amountMatch = text.match(/\$(\d+\.?\d*)/);
```

**Suggested:**
```typescript
const amountMatch = text.match(/\$\s*(\d+\.?\d*)/);
```

This accounts for inputs like "$ 50" which some users type with a space after the dollar sign.

**Confidence:** High — matches the reported reproduction steps.
**Files touched:** 1 (`supabase/functions/linq-worker/action-handlers.ts`)

Want me to open a draft PR with this fix? React with :thumbsup: and I'll create it.
```

### Autonomy Level

| Action | Autonomous? | Why |
|--------|------------|-----|
| Analyze code and identify root cause | Yes | Read-only analysis |
| Post fix suggestion as comment | Yes | Suggestion only, no code change |
| Open a draft PR with the fix | **No — requires dev thumbs-up** | Writing code needs human review |
| Push a fix directly to a branch | **NEVER** | Only devs push code |

### Quality Bar

Marty only suggests fixes when:
- **Confidence is high** — the root cause is clear from the error/trace
- **The fix is small** — 1-5 lines changed, 1-3 files touched
- **The fix is testable** — Marty can describe how to verify it

If confidence is low, Marty says "I think the issue is in X area but I'm not sure — someone should investigate" instead of guessing.

---

## 3. PR Review Support

### What Marty Does on Every PR

When a PR is opened against `develop`:

1. **Auto-review** using the tryps-pr-review skill (convention checks, safety checks, quality checks)
2. **Post review comment** with pass/fail and specific line-level feedback
3. **Check CI status** — if CI fails, analyze the error and suggest a fix
4. **Flag scope creep** — if the PR touches files outside its stated scope

### Review Comment Format

```markdown
## Marty Review

**Convention checks:** PASS (6/6)
**Database checks:** N/A (no schema changes)
**Safety checks:** 1 issue found
**Quality checks:** PASS (4/4)

### Issues

1. **`app/(tabs)/trip/[id]/expenses.tsx:47`** — Missing `getSession()` guard before `getUser()`.
   This can crash if the session has expired. Add:
   ```typescript
   const { data: { session } } = await supabase.auth.getSession();
   if (!session) return;
   const { data: { user } } = await supabase.auth.getUser();
   ```

### Notes
- Clean PR, well-scoped. The expense display logic is solid.
- Consider adding a test for the new split calculation.
```

### Autonomy Level

| Action | Autonomous? | Why |
|--------|------------|-----|
| Review PR and post comments | Yes | Standard code review, adds value |
| Approve PR | **NEVER** | Only humans approve PRs |
| Request changes | Yes | Reviewer role, dev can dismiss |
| Merge PR | **No — requires Jake or Asif approval** | Merging affects shared branch |
| Comment on CI failures with fix suggestions | Yes | Helpful, non-blocking |

---

## 4. Proactive Dev Help

### Morning Brief (DM to Each Dev)

Each morning at 9 AM ET, Marty DMs each active dev with a personalized brief:

```
Morning, Asif. Here's your plate:

Open PRs needing your attention:
- #312 "Fix expense split rounding" — CI passing, needs review
- #308 "Add poll nudge reminder" — 2 days old, merge conflict

Issues assigned to you:
- #45 "Custom split fails with 5+ people" (P1, 3 days old)

ClickUp tasks in progress:
- "SC-42: Duplicate expense detection" — marked in progress since Mar 21

Yesterday you said you'd connect with Rizwan on SC-56/57. Did that happen?
```

**Autonomous:** Yes — this is an informational DM that helps the dev start their day.

### Slack @marty Responses

When a dev @mentions Marty in Slack:

- **"@marty what's the status of PR #312?"** — Marty checks and responds with status, CI, reviewers
- **"@marty triage this: [bug description]"** — Marty runs the bug-triage skill
- **"@marty suggest a fix for issue #45"** — Marty analyzes and posts a code suggestion
- **"@marty deploy staging"** — Marty runs the tryps-deploy skill in staging mode

### Stale Work Detection

Marty flags work that's going stale:

| Signal | Action | Autonomous? |
|--------|--------|------------|
| PR open > 3 days without review | DM the PR author + potential reviewer | Yes |
| Issue assigned > 5 days, no commits | Mention in morning brief | Yes |
| ClickUp task "in progress" > 3 days | Ask about it in standup questions | Yes |
| Branch diverged > 50 commits from develop | Flag merge conflict risk in morning brief | Yes |

---

## 5. Escalation Rules

Not everything goes to everyone. Marty follows an escalation chain:

```
P2 (Minor): Log it. Mention in morning brief. No interruption.
    ↓
P1 (Major): Create ClickUp task. Mention in morning brief + standup questions.
    ↓
P0 (Critical): DM Jake immediately. Post in #martydev. Create ClickUp task.
    ↓
SEV-0 (Outage): DM Jake + Asif. Post in #all-tryps. Create ClickUp task.
```

**What triggers a SEV-0:**
- App crashes on launch for all users
- Auth flow completely broken (can't sign in)
- Invite flow broken (sacred path)
- Data loss (expenses, trips, or user data missing)

---

## 6. Anti-Noise Contract

Research shows developer "alarm fatigue" from AI agents is real — 45% of devs say debugging "almost right" AI code is their top frustration (CodeRabbit State of AI report). These rules prevent Marty from becoming noise:

1. **Confidence threshold:** Only surface suggestions above 80% confidence. Below that, stay silent or say "needs investigation." One team cut noise by 60% with this alone.
2. **Batch, don't stream:** One consolidated review comment per PR, not 15 individual notifications.
3. **Respect developer intent:** If a dev explicitly chose a pattern, don't suggest alternatives. Track what's been dismissed.
4. **Opt-in escalation:** Default to quiet. Only act when triggered (label, command, @mention). Don't comment on every issue uninvited.
5. **Cooldown periods:** After a suggestion is dismissed, don't re-suggest the same thing for 7 days.
6. **`/marty quiet`:** Any dev can mute Marty on a specific issue or PR.
7. **Weekly digest for non-urgent insights:** Tech debt, test coverage gaps, stale branches — send a Monday summary instead of per-commit comments.

### Three Modes of Operation

| Mode | Trigger | Marty's Behavior |
|------|---------|-----------------|
| **Watch** (default) | Always on | Monitors all issues and PRs silently. Builds context. Takes no action. |
| **Triage** | New issue opened | Posts triage comment: labels, priority, related issues, affected files, suggested owner. |
| **Fix** | `marty-fix` label added to issue | Reads issue, explores code, writes fix + tests, opens **draft PR** linked to issue. Never auto-merges. |

This label-triggered pattern (from OpenHands) keeps Marty from generating noise on issues that need product discussion first. Only when a human explicitly says "Marty, fix this" does Marty attempt a code change.

### Progressive Trust Model

Anthropic's autonomy research shows devs grant more autonomy over time: new users approve ~80% of actions, experienced users let ~40%+ run autonomously. Start conservative — Marty defaults to draft PRs and advisory comments for the first month, then we unlock more autonomy as the team builds trust in Marty's accuracy.

### Industry Benchmarks

| Agent | Fix/Merge Rate | Best Use Cases |
|-------|---------------|---------------|
| Devin (Cognition) | 67% of PRs merged | Well-scoped tickets, migrations, security fixes |
| OpenHands | Label-triggered, draft PRs | Bug fixes, test writing |
| SWE-Agent | 65%+ on SWE-bench | Issue resolution, contained bugs |
| DeerFlow (ByteDance) | Sub-agent architecture | Complex multi-step tasks |

---

## 7. What Marty Never Does

1. **Never pushes code** to any branch — only suggests, never writes
2. **Never approves PRs** — only reviews with comments
3. **Never merges** without explicit human approval
4. **Never closes issues** without human confirmation
5. **Never DMs devs after 9 PM ET** — morning brief only, never evening interruptions
6. **Never assigns tasks** — only suggests owners, Jake decides assignments
7. **Never shares code snippets in public channels** — code discussion stays in GitHub/PRs
8. **Never uses the word "crew"** in any message

---

## Implementation Plan

### Phase 1: Now (This PR)

- [x] Define the interaction model (this document)
- [x] Build beta-feedback-triage skill
- [x] Build tryps-deploy skill
- [ ] Document cron job definitions

### Phase 2: Next Week

- [ ] Implement morning brief DM (new cron job, 9 AM ET)
- [ ] Connect PR auto-review to GitHub webhook (trigger on PR open)
- [ ] Set up issue triage auto-comment (trigger on issue open)
- [ ] Test the full daily loop end-to-end

### Phase 3: Iterate

- [ ] Tune the code suggestion quality bar based on dev feedback
- [ ] Add confidence scoring to fix suggestions
- [ ] Build a feedback loop: did the suggested fix actually work?
- [ ] Track Marty's "hit rate" — what % of suggestions get accepted?
