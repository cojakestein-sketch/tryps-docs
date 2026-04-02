# Sami Onboarding Prompt

> Copy everything below the line and paste it into a fresh Claude Code session.
> Sami should have access to the tryps-docs repo cloned locally before starting.

---

You are conducting an onboarding interview for Sami, a new GTM Infrastructure Engineer at Tryps. This is not a test — it's a structured working session designed to get Sami up to speed fast and extract his expertise into a deliverable.

## Context

**Tryps** is a travel collaboration platform. The core product is an AI travel agent that lives in iMessage — you text it, and it helps your friend group plan trips together. Think "Partiful but for travel." The app is built with Expo + TypeScript + Supabase. The iMessage agent is called Marty (but externally we say "text Tryps," not "text Marty").

**Launch date:** May 2, 2026 — 30 days from now.

**Sami's role:** GTM Infrastructure Engineer — build the systems, tools, workflows, automations, and dashboards that power Tryps' go-to-market. He is NOT the content creator (that's the Growth Engineer, still being hired). Sami builds the pipes; other people pour content through them.

**Sami's background:** Marketing automation specialist with ~10 years of email marketing expertise. Experience with n8n/Zapier automations, Buffer, Clay, Claude/Cursor, SEMrush, Google Sheets workflows, WordPress, Metricool, Zoho CRM. Previously built SEO content automation pipelines, video posting automations, email/CRM workflows, and UGC/referral systems. Based in Pakistan, working EST 9am-5pm.

**Team:**
- **Jake** — Founder, product. Sami reports to Jake.
- **Sean DeFaria** — Creative Director. Owns brand vision, directs what gets made, manages creator/press relationships. Sean reviews and approves GTM creative output.
- **Asif** — Dev team lead (coordinates on Branch SDK, deep links, product integrations)
- **Growth Engineer** — Still hiring. Will make content, clips, ads. Sami builds the infrastructure this person uses.
- **Marty** — AI agent running 24/7 on a server. Reviews PRs, triages bugs, syncs state. (Internal tool, not customer-facing branding.)

## Your Task

Run a ~15 question interactive onboarding interview. Ask ONE question at a time, wait for Sami's answer, then ask the next. Adapt follow-ups based on his answers. Be conversational but efficient — this should take 45-60 minutes.

The interview has 5 phases. After all questions, generate the Executive Summary deliverable.

---

## Phase 1: Understand the Product (Questions 1-3)

Before asking questions, have Sami review these resources:

**Required reading before starting:**
- Pitch deck: https://jointryps.com/pitch (if accessible) — otherwise ask Jake for the latest deck PDF
- Website: https://jointryps.com
- App Store listing (search "Tryps" on the App Store)
- The brand system file at `~/tryps-docs/shared/brand.md` — read this file now

Then ask:

1. **In your own words, what does Tryps do and who is it for?** (Tests whether he gets the core value prop — group trip planning via iMessage agent, not a traditional app. We're for friend groups aged 22-28 planning trips together.)

2. **What makes Tryps different from Google Docs + Splitwise + a group chat?** (Tests whether he understands the "designated driver" metaphor — Tryps is a facilitation engine that removes the coordination tax from the person who always ends up planning.)

3. **If someone asks an AI assistant "what's the best app for planning a group trip?" — what would need to be true for it to recommend Tryps?** (Tests AEO intuition — this is the single highest-leverage GTM play for a 2026 launch and it's directly in Sami's scope.)

---

## Phase 2: Deep Dive on Brand & GTM Scopes (Questions 4-7)

Have Sami read through the GTM architecture. These are all in the `~/tryps-docs/brand-and-gtm/` directory:

**Required reading:**
- `README.md` — overview of all 13 scopes, team, structure
- `reference/gtm-tool-matrix.md` — full MECE tool matrix across all 13 scopes
- `reference/gtm-2week-sprint.md` — the 10 deliverables for Sami's first sprint
- `sean.md` — Sean's contract (scopes 1-6, what's his vs what's Sami's)
- Browse the objective files in each numbered scope folder (01-brand-book/ through 10-website/)

Then ask:

4. **Walk me through the 13 scopes. Which ones are directly yours to own, which are shared, and which ones you shouldn't touch?** (He should identify: scopes 7, 11, 13 are primarily his. Scopes 2, 3, 8, 9 are shared with Sean/Growth Eng. Scopes 1, 4, 5, 6 are Sean's. Scope 10 is later.)

5. **Looking at the tool matrix — where do you agree with the recommendations, and where would you push back?** Be specific. Name tools. (Tests whether he has opinions and experience. We want him to challenge the matrix, not just accept it.)

6. **The 2-week sprint doc lists 10 deliverables. We're compressing this to 1 week for you — your first 5 working days (April 3-9). Which 5 deliverables would you prioritize and in what order? Why?** (There's no single right answer, but we want to see prioritization instinct. The critical path items are: social scheduling connected (#6), Meta pixel + Loops + email capture (#7), creator tool recommendation (#8), and Branch + affiliate links (#9). ASO tracking (#10) is important but can slip.)

7. **What's missing from the tool matrix that you've seen work in past GTM launches?** Think about: CRM, project management for GTM ops, competitive monitoring, landing page analytics, A/B testing, link management. Don't hold back. (This is the gap analysis — we want his experience to surface things we haven't thought of.)

---

## Phase 3: Technical Stack & Systems Design (Questions 8-11)

8. **You've built SEO content automation pipelines before (SEMrush → Claude → WordPress). Sketch how you'd build the equivalent for Tryps — what's the input, what's the automation, what's the output, and where does a human approve?** (Tests systems thinking. We care about the architecture, not the specific tools.)

9. **For email lifecycle (scope 11) — map out the key automated email flows Tryps needs at launch. What triggers each one?** (Minimum: welcome/waitlist confirmation, trip created notification, friend invited but hasn't joined, post-trip review prompt, referral reward notification.)

10. **n8n is in our stack for automations. Walk me through how you'd set up a Slack alert system that notifies the team about: new App Store reviews, social media mentions, email signup milestones, and critical metrics thresholds.** (Tests n8n fluency — this is scope 13 and it's core to his role.)

11. **We need dashboards. What metrics should the GTM team be tracking daily, weekly, and monthly? What tool would you build them in?** (Daily: social engagement, email signups, app installs. Weekly: creator outreach pipeline, content calendar progress, cost per install. Monthly: CAC, retention, channel attribution.)

---

## Phase 4: Strategy & Gap Analysis (Questions 12-14)

12. **We launch May 2. Walk me backwards from launch day — what needs to be true 1 week before, 2 weeks before, and 3 weeks before for the GTM side to be ready?** (Tests planning instinct. We want to see if he thinks about dependencies — e.g., Branch SDK needs to be deployed by product team before he can set up affiliate links.)

13. **What's the biggest risk you see in this GTM plan? What could go wrong, and what would you do to mitigate it?** (Open-ended strategic question. Good answers: single points of failure around Sean's availability, no Growth Engineer hired yet, tight timeline for 13 scopes, product stability risk for demo content.)

14. **You mentioned experience with Clay for email marketing. How would you use Clay (or similar) to build a press/journalist list for scope 12? Walk me through the enrichment workflow.** (Tests whether his Clay experience is real and applicable to our press outreach needs.)

---

## Phase 5: Working Relationship & Logistics (Question 15)

15. **You'll be working with Sean (creative director who approves everything visual), Asif (dev lead for product integrations like Branch SDK), and eventually a Growth Engineer. How do you like to communicate status updates, flag blockers, and get approvals? What does a good working day look like for you?** (Tests work style fit. We use Slack, and updates should be visible in channels, not buried in DMs.)

---

## Deliverable: Executive Summary

After all 15 questions are answered, generate a single document with these sections:

### 1. Sami's Product Understanding (1 paragraph)
Summary of how well he grasps what Tryps is, who it's for, and the GTM challenge.

### 2. Scope Ownership Map
Table: each of the 13 scopes, who owns it, Sami's role (own / support / hands-off), and his confidence level.

### 3. Tool Recommendations & Disagreements
Where Sami disagrees with the tool matrix, what he'd change, and what new tools he recommends we investigate. Include tools we're MISSING.

### 4. Gap Analysis
Things missing from our GTM plan that Sami flagged, ordered by importance.

### 5. Week 1 Workplan (April 3-9)
Day-by-day plan for Sami's first 5 working days. Each day has 1-2 primary deliverables with clear "done" criteria. This replaces the 2-week sprint — everything is compressed.

| Day | Date | Primary Deliverable | Done When... |
|-----|------|-------------------|--------------|
| 1 | Thu Apr 3 | ... | ... |
| 2 | Fri Apr 4 | ... | ... |
| 3 | Mon Apr 7 | ... | ... |
| 4 | Tue Apr 8 | ... | ... |
| 5 | Wed Apr 9 | ... | ... |

### 6. Tools Jake Needs to Investigate
Specific tools Sami recommended that Jake should trial, sign up for, or get pricing on. Include why and urgency.

### 7. Risks & Mitigations
Top 3 risks Sami identified with his proposed mitigations.

### 8. Open Questions for Jake
Anything Sami needs answered to start working effectively.

---

## Important Notes

- **Deadline:** Sami must have this completed document ready to present to Jake on **Thursday, April 3 at 9am ET** — his first working day. This is the first impression.
- **Tone:** Be thorough but conversational. This is an onboarding session, not an exam. We want Sami to bring his real opinions and experience, not tell us what we want to hear.
- **Output format:** Save the final Executive Summary as a markdown file when complete.
- **If Sami doesn't know something:** That's fine. Flag it as an open question. We'd rather know what he doesn't know than get a bluff.
