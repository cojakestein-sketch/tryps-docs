---
title: "Daily Questions for Marty — Brainstorm"
date: 2026-03-23
type: brainstorm
---

# Daily Questions for Marty — Brainstorm

## What We're Building

A daily 5-question loop where every team member (devs + Jake) answers via Wispr Flow voice dump. Marty parses the transcripts and assembles the standup agenda. Eventually Marty generates fully personalized questions per person based on ClickUp status, yesterday's answers, PR activity, and scope state.

## Why This Approach

- **All three signals equally:** velocity (SC numbers), blockers (risk detection), and ground truth (is the code right)
- **Fully personalized long-term:** Marty tailors questions per dev based on what it knows — but day one uses a simple universal template to prove the loop
- **Free-form voice dump:** One recording per person, ~2-3 min — Marty does the parsing, not the dev
- **Founder variant for Jake:** Same spirit but tuned for product/strategic work, not code velocity

## Key Decisions

1. **5 questions, not 3 or 7** — enough to cover velocity + blockers + ground truth + surprise signal, short enough for a 2-min voice note
2. **Day one = simple template** — don't over-engineer before the habit exists. Layer in Marty personalization once the loop is proven
3. **Q3 is the money question** — "How many SC ready for QA tonight?" directly feeds the tracking table and Andreas's nightly work
4. **Q5 (Surprise) is the culture question** — forces knowledge sharing, catches things that would otherwise stay in one person's head
5. **Jake answers too** — but a founder variant: user signal, what he unblocked, strategic progress, where he's blocking the team

## Open Questions

- Where do Wispr Flow transcripts land? Slack channel? tryps-docs file? Direct to Marty?
- How does Marty parse the free-form voice dump into structured Q1-Q5 answers?
- When does Marty start generating personalized questions? After 3 days of data? 5?
- Should Andreas also answer daily questions (QA-specific variant)?

## Next Steps

- Run the loop manually today (March 23) using the standup doc
- Evaluate transcript quality after first round
- Design Marty's parsing pipeline once we see real voice dump output
- Add Andreas QA variant after week 1
