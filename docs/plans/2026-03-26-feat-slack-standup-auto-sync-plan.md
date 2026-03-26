---
title: "Slack Standup Auto-Sync"
type: feat
date: 2026-03-26
status: ready-to-execute
---

# Slack Standup Auto-Sync

## Overview

Replace git-push standups with Slack-native Q&A. Marty posts questions to the right channels, people reply in threads, Marty auto-updates the standup doc and pushes to main. No one touches git except Marty.

## Architecture

```
Marty generates standup doc (8 PM ET, existing cron)
        │
        ▼
Marty posts questions to Slack (next morning, NEW)
  ├── #martybrand → Sean's questions + Jake's brand questions
  └── #martydev   → Asif/Rizwan/Nadeem questions + Jake's dev/product questions
        │
        ▼
People reply in threads (throughout the day)
        │
        ▼
Marty polls for thread replies (every 5 min, NEW)
  ├── Reads thread replies via Slack API
  ├── Maps reply → person → question number
  ├── Cleans up answer for readability
  └── Replaces "[Dev answers here]" / "[Sean answers here]" / "[Jake answers here]"
        │
        ▼
Marty commits + pushes to main
  commit: "standup: update {name}'s answers from Slack (2026-03-26)"
        │
        ▼
Jake watches file update live in Obsidian / editor
```

## Channel Routing

| Channel | ID | Who Gets Questions | Jake's Role |
|---------|-----|-------------------|-------------|
| #martybrand | (get ID — just created) | Sean (5 brand Qs) | Jake gets 5 brand-focused Qs |
| #martydev | C0AKS98Q5K5 | Asif (5), Rizwan (5), Nadeem (5) | Jake gets 5 product/strategy Qs |

## Slack IDs (for @mentions)

| Name | Slack ID |
|------|----------|
| Jake | U0AK8FANGNM |
| Asif | U0AJZ6H8WBE |
| Nadeem | U0AK8FPKK41 |
| Rizwan | U0AMUGX6F5X |
| Sean | (needs Slack invite — not currently on workspace) |
| Warda | (needs Slack invite + ID) |

## Prerequisite

Sean and Warda need Slack workspace invites before this works for them. Jake to handle.

## Message Format

Each person's questions are posted as **one message** (not individual messages per question). Questions are numbered. People reply in a **thread** on that message.

Marty's tone: direct, specific, asking on behalf of the team — not "Jake says to ask you." Just Marty doing its job.

## Answer Extraction Logic

When Marty reads a thread reply:

1. **Identify the replier** — match Slack user ID to team member name
2. **Identify which question(s)** — if reply starts with "1." or "Q1" or references a specific question, map it. If it's a single block of text answering all questions, split by question markers or treat as sequential
3. **Clean up** — fix typos, remove filler ("um", "so basically"), tighten prose. Keep substance and voice
4. **Replace placeholder** — find the correct `[Dev answers here]` / `[Sean answers here]` / `[Jake answers here]` in the standup doc and replace it
5. **Commit + push** — one commit per person's answers (not per question)

## Today's Proof of Concept

### What happens today:

1. Jake gets #martybrand channel ID and invites Sean + Marty
2. Jake hands Marty the prompt below
3. Marty posts questions to #martybrand and #martydev
4. People reply throughout the day
5. Marty watches for replies, updates standup doc, pushes
6. Jake watches ~/tryps-docs/standups/2026-03-26-standup.md update live

### Success criteria:

- [ ] Marty posts questions to both channels
- [ ] At least one person replies in a thread
- [ ] Marty detects the reply and updates the standup doc
- [ ] Jake sees the file update without anyone git-pushing manually

---

## Marty Prompt

**Copy-paste this entire prompt to Marty. Replace MARTYBRAND_CHANNEL_ID with the actual ID once you have it.**

````
You have a new workflow: Slack Standup Auto-Sync. Post standup questions to Slack channels, watch for thread replies, and auto-update the standup doc.

## Step 1: Post questions to Slack

Post these messages to the specified channels. Each is a SINGLE message (all questions for that channel in one post). Post as yourself (Marty), not on behalf of Jake.

### Post to #martybrand (channel ID: MARTYBRAND_CHANNEL_ID)

Message 1 — for Sean:

@sean — standup questions, March 26. April 2 is 7 days away (M1 deadline). Reply in a thread:

1. *Brand book:* Where is the Figma file right now? How many screens are designed vs. total needed? What's blocking you from finishing this week?
2. *Socials:* Are all accounts set up (X, TikTok, IG, LinkedIn)? Bios updated? Profile photos current? If not — what's left?
3. *UGC program:* You need a 300-creator target list and a 4-page outreach strategy by April 2. How far along are you? Have you started the list? What segments are you targeting?
4. *Giveaways:* Do you have a concept locked? What's the mechanic — how do people enter, how are winners chosen, what's the prize?
5. *Blockers:* What do you need from Jake or the team this week to hit April 2? Be specific — access, decisions, assets, time on a call.

Message 2 — for Jake (brand):

@jake — your brand questions for today. Reply in a thread:

1. *Agent voice:* The agent sounds generic right now — "Got it! Before we lock in flight details..." That's not group chat energy. What should the agent sound like? Give 3 example responses in the right voice.
2. *Brand book priorities:* Sean's designing the brand book. What are the 5 most important pages/sections that MUST be in it by April 2?
3. *Tagline:* Any candidates? What direction are you leaning — funny, aspirational, matter-of-fact?
4. *Physical presence:* Stickers, wallpaper, film cameras — which one first? What's the budget ceiling?
5. *Website:* jointryps.com is about to go live as the trip landing page. Beyond the functional trip view, what should the brand feel be?

### Post to #martydev (channel ID: C0AKS98Q5K5)

Message 1 — for Asif:

@asif.raza1013 — standup questions, March 26. Reply in a thread:

1. Jake tested the agent in a real group chat this morning. Three problems: (a) duplicate intro message, (b) forgot info already given (trip name, location), (c) ignored Alex's flight details and kept asking. See the bug report in #martyasif. What's causing this? Root-cause it today.
2. When someone calls the Tryps phone number, what happens right now? What needs to happen to make inbound calls work?
3. Walk me through the full first-touch flow: someone receives a Tryps iMessage link → taps it → what do they see? What pieces are working vs. broken?
4. The vCard / contact card — you said you'd ship it yesterday. Did you?
5. PR #304 from Rizwan (wire memory into agent-router) touches your linq-worker path. Review and merge today — it's related to the context-loss bug.

Message 2 — for Rizwan:

@rizwanatta — standup questions, March 26. Reply in a thread:

1. Travel booking is at 0/58 criteria. Payments is "not started." Be honest: what is the shortest realistic path from today to a user searching a flight and paying for it through Tryps? What exists, what's missing, how many days?
2. Agent intelligence is at 55/61. What are the remaining 6 SCs and how long to close them?
3. PR #304 (wire memory into agent-router) is still open. This is blocking the iMessage context-loss fix. What's the blocker? Get it merged today.
4. PR #299 (font scaling) has been open since March 19. Merge or close today.
5. Convert the 20-message classification taxonomy into testable cases (promptfoo YAML or equivalent) today.

Message 3 — for Nadeem:

@engineernadeemkhan120 — standup questions, March 26. Reply in a thread:

1. You have 78 open bugs. Today is bug fix day. List the 10 you're fixing today by ClickUp ID, ordered by severity. Prioritize core flows: creating a trip, viewing a trip, inviting people.
2. What are the top 3 most embarrassing bugs? The ones where a new user would open the app and immediately think "this is broken."
3. PR #302 (Stay Tab) merged yesterday with Google Places API. Has Andreas tested the full flow? Any regressions?
4. Andreas has 5 items in "for testing" — Travel DNA and Post-Trip Review. Status?
5. Overview tab — how many of the 48 SCs are done? But today, bugs come first.

Message 4 — for Jake (dev/product):

@jake — your product questions for today. Reply in a thread:

1. *Release gate:* What are the 3 things that MUST work before you send another Tryps link to a friend? This becomes the release gate.
2. *April 2 done:* What does "done" realistically look like on April 2? Write the one-paragraph description.
3. *Travel booking priority:* If Rizwan says travel booking is weeks away, is that okay? Or does April 2 need flight search? Decide now.
4. *Spec work:* You have 5 scopes in needs-spec. Which one are you speccing this week?
5. *Next 3 users:* Who are the next 3 people getting a Tryps link? Name them.

## Step 2: Record message timestamps

After posting each message, save the channel ID and message timestamp (ts) for each post. You need these to poll for thread replies.

Store them like this:
```
MESSAGES = {
  "martybrand_sean": { channel: "MARTYBRAND_CHANNEL_ID", ts: "..." },
  "martybrand_jake": { channel: "MARTYBRAND_CHANNEL_ID", ts: "..." },
  "martydev_asif": { channel: "C0AKS98Q5K5", ts: "..." },
  "martydev_rizwan": { channel: "C0AKS98Q5K5", ts: "..." },
  "martydev_nadeem": { channel: "C0AKS98Q5K5", ts: "..." },
  "martydev_jake": { channel: "C0AKS98Q5K5", ts: "..." },
}
```

## Step 3: Poll for replies and update the standup doc

Every 5 minutes, check each message for thread replies using the Slack API (conversations.replies).

When you find a new reply:

1. Identify the replier by Slack user ID:
   - U0AK8FANGNM = Jake
   - U0AJZ6H8WBE = Asif
   - U0AJZ6EHVNG = Arslan
   - U0AK8FPKK41 = Nadeem
   - U0AMUGX6F5X = Rizwan
   - U0AJG90JHN3 = Andreas
   - Sean = (get his Slack ID once he joins)

2. Map the reply to the correct section in ~/tryps-docs/standups/2026-03-26-standup.md:
   - Sean's replies → "### Sean — Brand & GTM" section
   - Jake's replies in #martybrand → "### Jake — Brand & GTM" section
   - Jake's replies in #martydev → "### Jake — Product & Strategy" section
   - Asif's replies → "### Asif — Mission: Make the Link Work" section
   - Rizwan's replies → "### Rizwan — Mission: Travel Booking Reality Check" section
   - Nadeem's replies → "### Nadeem — Mission: Bug Fixes" section

3. Parse the reply: if they answered multiple questions (numbered), split and place each answer under the right question. If it's one block, place it under question 1 and note the rest.

4. Replace the placeholder text (e.g., "[Dev answers here]", "[Sean answers here]", "[Jake answers here]") with their cleaned-up answer. Clean up = fix typos, remove filler words, tighten for readability. Keep their voice and substance.

5. After updating all answers from that person, commit and push:
   ```
   cd ~/tryps-docs
   git add standups/2026-03-26-standup.md
   git commit -m "standup: update {name}'s answers from Slack (2026-03-26)"
   git push origin main
   ```

6. React to their Slack message with ✅ to confirm you captured their answer.

## Step 4: Keep polling

Continue checking every 5 minutes until:
- All answers are filled in (no more "[answers here]" placeholders), OR
- End of day (8 PM ET)

If someone hasn't replied by 2 PM ET, send a gentle reminder in the thread: "Still need your answers on this — reply when you can."

## Important rules
- Post as Marty. These are YOUR questions to the team, not Jake forwarding questions.
- Each channel gets its own set of messages. Don't cross-post.
- When updating the standup doc, ONLY replace the specific placeholder for the question answered. Don't modify any other part of the file.
- One commit per person's answers. Don't commit after every single question.
- If someone gives a long rambling Wispr Flow dump, clean it up but keep the substance.
- Never use the word "crew."
````

---

## Making It Permanent (After Today's POC)

Once the proof of concept works, add this as a Marty heartbeat task:

### New cron: `standup-slack-deliver`

```json
{
  "name": "standup-slack-deliver",
  "schedule": "0 14 * * *",
  "timezone": "Asia/Karachi",
  "action": "Post today's standup questions to #martybrand and #martydev. Use standup doc at ~/tryps-docs/standups/YYYY-MM-DD-standup.md as source. Then enter polling mode for replies.",
  "notes": "2 PM PKT = ~9 AM ET (when devs are starting their day and Jake is waking up)"
}
```

### New cron: `standup-slack-collect`

```json
{
  "name": "standup-slack-collect",
  "schedule": "*/5 * * * *",
  "timezone": "America/New_York",
  "action": "Check for new thread replies on today's standup messages. Update standup doc with answers. Commit and push.",
  "notes": "Runs every 5 min from 9 AM to 8 PM ET. Stops when all answers are collected."
}
```

### Update HEARTBEAT.md

Add to the daily routine:
```
9:00 AM ET  — Post standup questions to #martybrand + #martydev
9:00-8:00 PM ET — Poll for thread replies every 5 min, update standup doc
2:00 PM ET  — Nudge anyone who hasn't replied
```

## Standup Doc Changes

The standup doc needs a "Jake — Brand & GTM" section for #martybrand questions. Added to today's standup.

## Open Questions

1. **Sean's Slack access** — he's not on the workspace yet. Jake needs to invite him before #martybrand works for him.
2. **Warda's Slack access** — same situation. Her questions are currently posted to #martydev as a getting-started block, not Slack Q&A.
3. **#martybrand channel ID** — Jake just created it. Need the ID before Marty can post.
4. **Polling architecture** — should this be a persistent loop or a cron that runs every 5 min? Persistent loop is simpler for today's POC. Cron is better for production.
