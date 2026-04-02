---
name: tryps-standup
description: Generate tomorrow's standup document with 3 targeted questions per dev — what, how to verify, and Marty's question
user-invocable: true
---

# Daily Standup Generator

Generate tomorrow's standup document with 3 targeted questions per active dev. Questions are specific, scope-aware, and build on prior answers. The goal is to maximize what Marty learns from each dev's limited time while keeping the ask small enough that devs actually answer.

## Steps

### 1. Gather Context

**Yesterday's standup answers:**
- Read the most recent file in `tryps-docs/docs/standups/` that has answers (not just questions)
- Extract each dev's answers — what they said, what they committed to, what they flagged as blocked
- **Check if they said something would be done — did they do it?**

**ClickUp status (last 24 hours):**
- Fetch tasks from list `901711582339` (This Week) via curl:
  ```
  curl -s -H "Authorization: $CLICKUP_API_KEY" \
    "https://api.clickup.com/api/v2/list/901711582339/task?include_closed=true"
  ```
- Note status changes, new tasks, tasks stuck > 2 days
- Map tasks to assignees using ClickUp IDs:
  - Nadeem: `95375710`
  - Asif: `95375712`
  - Rizwan: `48611515`
  - Andreas: `95380391`

**GitHub activity (last 24 hours):**
- `gh pr list --repo cojakestein-sketch/tripful --state all --json number,title,author,state,createdAt,mergedAt,updatedAt`
- `gh api repos/cojakestein-sketch/tripful/commits --jq '.[0:20] | .[] | .commit.message + " (" + .commit.author.name + ")"'`
- Note: default branch is `develop`

**Scope specs:**
- Read each active dev's scope spec for success criteria counts and objectives
- Scopes live at `tryps-docs/scopes/{scope-name}/spec.md`
- Current assignments:
  - Nadeem → `output-backed-screen` (48 SC)
  - Asif → `imessage-agent` (57 SC)
  - Rizwan → `agent-intelligence` (61 SC)

**Bug & QA numbers (from Asif's nightly report):**
- Asif provides SC counts and bug counts the night before
- Pre-fill the SC & Bug Snapshot table with these numbers

### 2. Write Jake's Missions

Before generating questions, check if Jake has **pinned missions** in the standup doc:
- Look for `pinned_missions: true` in the frontmatter OR `<!-- JAKE-PINNED` comments in the file
- **If pinned missions exist: DO NOT overwrite them.** Keep Jake's missions section exactly as-is. Skip to Step 3.
- **If no pinned missions exist:** Generate missions as described below.

When generating missions (no pinned missions found), write **Jake's Missions for the Team Today** — 2-4 missions that define what Jake cares about that day. These come from:
- Yesterday's standup context
- What's most urgent based on ClickUp/GitHub
- Any strategic priorities from `tryps-docs/shared/priorities.md`

Missions should be specific and outcome-oriented. Example: "Connect every traveler's existing travel life to Tryps — Delta, Marriott, Airbnb, Uber" not "work on integrations."

### 3. Generate Questions — 3 Per Dev (NOT 5)

For each active dev, write exactly **3 questions**:

1. **What are you doing TODAY?** — Force specificity. Name SCs, PRs, bugs. No vague answers.
2. **How will Jake verify at 6PM that it's DONE?** — Must produce a testable artifact: merged PR number, screen recording, specific flow to tap through, deploy URL. Something Jake can check without asking.
3. **Marty's question** — The ONE question Marty needs answered to continue building his context, memory, and organizational brain. This could be about scope boundaries, architectural decisions, blockers, workflow changes, or anything that helps Marty track project state accurately.

**Question principles:**
- Never ask generic standup questions ("what did you do yesterday?")
- Reference specific SCs, PRs, ClickUp tasks, or yesterday's answers
- Q1 and Q2 are always the same structure — only the context changes per dev
- Q3 is unique to each dev and based on what Marty doesn't yet know
- Questions should be answerable in 2 minutes via Wispr Flow voice dump
- Be firm but not mean — no accusatory phrasing, no shaming

### 4. Generate the Hero Numbers & SC/Bug Snapshot

**Hero numbers go at the very top of the standup, right after the title.** These are the first thing everyone sees — big, impossible to ignore.

**How to calculate:**
- Sum all SC Done across devs (from Asif's nightly report + yesterday's answers + scope state.md frontmatter)
- Sum all Total SC across devs
- Get bugs fixed / total bugs from Asif's nightly report
- If a dev hasn't reported their SC count, show `???` and call them out

**Format in the document:**

```
# [SC_DONE] / [SC_TOTAL] SUCCESS CRITERIA DONE — [BUGS_FIXED] / [BUGS_TOTAL] BUGS FIXED

> **SC:** Asif [X]/57 | Rizwan [X]/61 | Nadeem [X]/48 *(call out anyone who hasn't reported)*
> **Bugs:** [X] fixed (waiting QA verify) | [X] remaining | [X] blocked
> *Source: Asif, [time/date of report]*
```

**Then the per-dev table:**

| Team Member | Scope | Total SC | SC Done (Dev) | SC Passed QA (Andreas) | Bugs Fixed / Total |
|-------------|-------|----------|---------------|------------------------|--------------------|

Pre-fill from Asif's nightly report. Leave unknown columns blank for devs to fill.

> **Note to Asif:** Provide SC counts + bug numbers the night before each standup so the hero numbers and table are pre-filled.

### 5. Write the Standup Document

Write to `tryps-docs/docs/standups/YYYY-MM-DD-standup.md` using this format:

```markdown
---
title: "Standup — [Month Day, Year]"
date: YYYY-MM-DD
type: standup
---

# Standup — [Month Day, Year]

> Generated by Marty at [time] ET. Questions based on yesterday's answers, ClickUp status, and GitHub activity.
> **3 questions per dev. Missions up top. Answer in 2 min via Wispr Flow.**

---

# [SC_DONE] / [SC_TOTAL] SUCCESS CRITERIA DONE — [BUGS_FIXED] / [BUGS_TOTAL] BUGS FIXED

> **SC:** Asif [X]/57 | Rizwan [X]/61 | Nadeem [X]/48 *(call out anyone who hasn't reported)*
> **Bugs:** [X] fixed (waiting QA verify) | [X] remaining | [X] blocked
> *Source: Asif, [time/date of report]*

---

## Jake's Missions for the Team Today

> These are the things Jake cares about TODAY. Everything you do should connect back to one of these.

### Mission 1: [Mission title]
[1-2 sentence description of what Jake wants to see progress on]

### Mission 2: [Mission title]
[1-2 sentence description]

[...add more missions as needed, typically 2-4]

---

## SC & Bug Snapshot

| Team Member | Scope | Total SC | SC Done (Dev) | SC Passed QA (Andreas) | Bugs Fixed / Total |
|-------------|-------|----------|---------------|------------------------|--------------------|
| [Dev] | [scope] | **[X]** | ___ / [X] | ___ / ___ | — |

> **Asif:** Provide SC + bug numbers the night before each standup so the hero numbers and this table are pre-filled.

---

## Today's Questions

**3 questions each. Answer in one Wispr Flow voice dump (~2 min). Edit your section, commit, push.**

### [Dev Name] — [scope-name] ([X] SC)

**1. What are you doing TODAY? [Add context from yesterday's commitments, ClickUp, GitHub]**

[Dev answers here]

**2. How will Jake verify at 6PM that what you said you'd do is DONE? [Ask for specific artifact]**

[Dev answers here]

**3. [Marty's question] [The ONE thing Marty needs to know to build better context about this dev's work]**

[Dev answers here]

### [Next Dev] — [scope-name] ([X] SC)

...

---

## Getting-Started Prompt

**Copy-paste the prompt for your name into Claude Code:**

### [Dev Name] — paste this:

\```
I'm [Dev Name]. Read the standup doc at ~/tryps-docs/docs/standups/YYYY-MM-DD-standup.md and help me answer my 3 questions. My scope is [scope-name]. The spec is at ~/tryps-docs/scopes/[scope-name]/spec.md. The codebase is at ~/t4.

Walk me through each question. If I don't know something, help me research it. Once I've answered all 3, edit the standup doc with my answers (only my section), commit, and push to main.
\```
```

### 5. Commit and Push

```bash
cd ~/tryps-docs
git add docs/standups/YYYY-MM-DD-standup.md
git commit -m "chore: generate standup questions for YYYY-MM-DD"
git push origin main
```

### 6. Post to Slack

Post to #martydev:
> "Tomorrow's standup is ready: [link to file on GitHub]. 3 questions each for [names]. Answer by 2pm standup."

### 7. Learn from Answers (Post-Standup)

After the standup meeting (after 2pm ET), re-read the answered document:
- Extract key facts, decisions, blockers, surprises
- Write a summary to `marty/memory/YYYY-MM-DD.md`
- If any answer reveals something important about the product, codebase, or team dynamics, update `marty/MEMORY.md`
- Track promises: if a dev says "I'll have X done by tomorrow," note it for tomorrow's questions
