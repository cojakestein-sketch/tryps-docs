# Team

> Source of truth for who works on Tryps, how to reach them, and who reports to whom.
> For Claude and Marty context — not a public doc.
> Updated: 2026-03-26

## Org Chart

```
Jake (Product / Founder)
├── Asif (Lead Dev)
│   ├── Nadeem (Dev — P1 Core App)
│   ├── Rizwan (Dev — P3 Agent Layer)
│   └── Warda (AI QA)
├── Sean (Creative — Brand & GTM)
├── Arslan (UI/UX Designer — adhoc)
├── Krisna (Designer — adhoc)
└── Marty (AI Agent — 24/7)

Friends / Advisors (no reporting line)
├── Jackson — Strategy (VC-style)
└── Trent — Branding
```

> Andreas (QA) leaves end of March 2026. Warda replaces QA function with AI-focused testing.

## Core Team

| Name | Role | Email | Slack | Timezone | Current Focus |
|------|------|-------|-------|----------|---------------|
| Jake Stein | Product / Founder | jake@jointryps.com | @jake | America/New_York (ET) | Specs, memory system, strategy, brand |
| Asif Raza | Lead Dev | asif.raza1013@gmail.com | @asif.raza1013 | Asia/Karachi (PKT) | [[imessage-agent/objective|iMessage Agent]], [[travel-booking/objective|Travel Booking]] |
| Nadeem Khan | Dev | engineernadeemkhan120@gmail.com | @engineernadeemkhan120 | Asia/Karachi (PKT) | [[output-backed-screen/objective|Output-Backed Screen]], [[core-trip-experience/objective|Core Trip Experience]] |
| Rizwan Atta | Dev | rizwanatta@protonmail.com | @rizwanatta | Asia/Karachi (PKT) | [[agent-intelligence/objective|Agent Intelligence]] |
| Andreas Kurniawan | QA | andreas@kurniawan.ceo | @andreas | Asia/Bangkok (ICT) | Validates scopes against criteria |

## Designers (Adhoc)

| Name | Role | Email | Slack | Timezone |
|------|------|-------|-------|----------|
| Arslan Anjum | UI/UX Designer | arslan.anjum951@gmail.com | @arslan.anjum951 | Asia/Karachi (PKT) |
| Krisna | Designer | krisnasubarkah@gmail.com | @krisnasubarkah | Asia/Bangkok (ICT) |

## Friends / Advisors

| Name | Role | Email | Notes |
|------|------|-------|-------|
| Jackson | Strategy consultant (VC-style) | TBD | Jake's friend, advises on fundraising and positioning |
| Trent | Branding consultant | trent@openinvite.studio | Jake's friend, Open Invite Studio — reviewing brand direction |
| Sean | Creative | sean@defaria.nyc | Jake's friend — socials, launch video |

## AI

| Name | Role | Slack | Notes |
|------|------|-------|-------|
| Marty | AI Agent (OpenClaw) | @marty | Runs 24/7 on Hetzner (178.156.176.44). PR reviews, state sync, standups. |

## Slack IDs (for API/automation)

| Name | Slack ID | ClickUp ID |
|------|----------|------------|
| Jake | U0AK8FANGNM | 95314133 |
| Asif | U0AJZ6H8WBE | 95375712 |
| Nadeem | U0AK8FPKK41 | 95375710 |
| Rizwan | U0AMUGX6F5X | 48611515 |
| Andreas | U0AJG90JHN3 | 95380391 |
| Arslan | U0AJZ6EHVNG | 102619517 |
| Krisna | U0AK8FSES6M | 84754219 |
| Sean | U0ANN485UUT | — |
| Warda | U0ANSCQPJFQ | — |
| Marty | U0AK97BBDTL | 95390289 |

## Working Profiles

> Used by the brain to tailor daily questions and interpret answers. See [[brain|brain.md]] for the full philosophy.

### Jake (Product / Founder)

- **Role in the brain:** The brain's counterpart. Jake sets strategy, the brain helps him think clearly about it.
- **Question strategy:** Help Jake delegate effectively. Questions should surface: what needs doing, how to spec it, who owns it, by when. Also: network activation — who in the McKinsey/MIT rolodex to cold-outreach, and what to ask them for.
- **What good looks like:** Jake leaves a brainscan session with clear missions for each person and 1-2 strategic actions for himself.
- **Push point:** Jake can get pulled into tactical details. Questions should pull him UP to strategic altitude.

### Asif (Lead Dev)

- **Strength:** Excellent at managing the team. Reliable executor. Good at coordinating across devs.
- **Push point:** Needs pushing on "art of the possible" — tends to manage what's in front of him rather than asking "what else could we build?" or "what tool would change this?"
- **Question strategy:** Challenge him to think bigger. Surface tools, APIs, and approaches the team hasn't considered. Ask about what's possible, not just what's in progress.
- **How to read his answers:** Generally accurate and honest. If he's vague, it usually means he's managing a blocker he hasn't escalated yet.

### Nadeem (Dev)

- **Strength:** Solid builder. Gets through scope work when focused.
- **Push point:** Needs accountability on process — setting self-deadlines and meeting them. Can report "done" at 80%.
- **Question strategy:** Always ask for proof: "demo it," "link the PR," "show the screen." Force concrete self-deadlines: "when will SC-X be done?" Follow up next day on missed deadlines.
- **How to read his answers:** If he says "almost done," ask what's left. If he gives a deadline, note it and follow up.

### Rizwan (Dev — Agent Layer)

- **Strength:** Very solid technically. Good instincts for bringing in the right tools. Autonomous worker.
- **Push point:** Minimal — he's reliable. Validate architecture decisions and integration points since agent layer touches everything.
- **Question strategy:** Architecture validation: are you using the right tools, have you tested end-to-end, what would break at scale. Cross-scope integration: how does this connect with Asif's work.
- **How to read his answers:** Generally trustworthy. If he flags a concern, take it seriously — he doesn't flag things lightly.

### Sean (Creative — Brand & GTM)

- **Strength:** Creative talent. Strong visual and social media instincts.
- **Push point:** NOT a business background. Needs concrete, deliverable-based direction. Will not self-organize toward business goals without explicit asks.
- **Question strategy:** Always frame as "we need X by Y." Force deadline commitments: "when will the socials be set up?" Follow up on every missed commitment. Questions should be about deliverable status, not open-ended creative exploration.
- **How to read his answers:** If he doesn't commit to a date, push again. Vague answers ("working on it") mean he hasn't started.

### Warda (AI QA)

- **Strength:** Talks to the Tryps agent all day. Best source of ground truth on agent behavior.
- **Push point:** New to the team — may need guidance on what to prioritize testing.
- **Question strategy:** Focus on agent QA: what broke in conversation, what edge cases surfaced, what does the agent get consistently wrong. Ask for specific examples and conversation logs.
- **How to read her answers:** Trust the specifics. If she says "the agent fails at X," it fails at X.

### Andreas (QA) — Departing end of March 2026

- **Strength:** Validates scopes against success criteria.
- **Note:** Leaving the team. Warda takes over QA function with AI-focused testing approach.

## Notes

- Dev team (Asif, Nadeem, Rizwan) and Warda are all PKT/ICT — 9-10 hours ahead of Jake (ET)
- The 3 daily standups accommodate the timezone gap: 10:00 AM ET, 2:00 PM ET, 5:45 PM ET
- Sean is in NYC (ET) — same timezone as Jake
- Jackson and Trent are advisors, not on daily standups
- Previous devs (Muhammad Mujtaba, Muneeb Rasheed) have been removed from Slack
- Previous QA (Andreas) departing end of March 2026
