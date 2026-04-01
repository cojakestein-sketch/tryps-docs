---
title: "Customer Interview Pipeline"
type: feat
date: 2026-04-01
owner: jake + asif
status: execute-today
---

# Customer Interview Pipeline

> 5 interviews TODAY. 25 total. Automated end-to-end.

## Overview

An automated pipeline where Jake provides a name + phone number, the system researches who they are, texts them via Tryps to set up an interview, preps tailored questions, makes the call, and logs everything as structured markdown. The interview doubles as product exposure — the interviewee experiences Tryps group chat and mobile app firsthand.

## Why This Matters

- **Product feedback:** Real people testing Tryps and telling us what they think
- **Market research:** What makes a great travel booking experience? What do people use today?
- **Custom insights:** Tailored questions based on each person's expertise (payments CEO gets payments questions, linguist gets cultural recommendation questions, influencer gets GTM questions)
- **Pipeline for 25 interviews:** Build it once, run it 25 times

---

## Architecture

```
Jake provides name + phone
         |
         v
  [AgentCash / stableenrich.dev]
  Scrape public profile (LinkedIn, web)
         |
         v
  [Question Prep]
  3-4 stock questions + 3 custom questions
         |
         v
  [Tryps iMessage Agent]                    [Mobile App Link]
  Creates group chat:                       TestFlight invite
  Jake (+15163761117) + interviewee         sent in group chat
  "Hey, I'm Trip from Jake's company..."
         |
         v
  [Retell AI Voice Call]
  Marty triggers outbound call
  Runs interview conversationally
  Records + transcribes
         |
         v
  [Markdown Logging]
  tryps-docs/customer-interviews/{name}.md
  Questions, answers, key insights, follow-ups
         |
         v
  [Jake Reviews]
  End of day: read all interview files
```

---

## Phase 1: TODAY (April 1) — Manual + Semi-Automated

### Step 1: Person Research (Jake via Claude Code + AgentCash)

Jake provides a name + phone number. Claude Code uses AgentCash to call stableenrich.dev:

```
1. mcp__agentcash__discover_api_endpoints (origin: https://stableenrich.dev)
2. mcp__agentcash__fetch — people search by name
3. mcp__agentcash__fetch — LinkedIn data lookup
4. mcp__agentcash__fetch — Exa web search for additional context
```

**Output:** A person profile saved to `tryps-docs/customer-interviews/prep/{name}-profile.md`:
```markdown
# {Name} — Interview Prep

## Public Profile
- Role: {title} at {company}
- LinkedIn: {url}
- Key background: {2-3 sentences}

## Why They're Valuable to Tryps
- {What unique perspective they bring}

## Custom Questions (3)
1. {Tailored to their expertise}
2. {Tailored to their background}
3. {Tailored to their industry}
```

### Step 2: iMessage Outreach (Asif triggers via Supabase)

Use the existing `LinqTransport.createGroup()` at `/Users/jakestein/t4/supabase/functions/_shared/linq-transport.ts:252`:

```typescript
const transport = createLinqTransport();
const result = await transport.createGroup(
  ["+15163761117", "+1XXXXXXXXXX"],  // Jake + interviewee
  "Hey! I'm Trip, from Jake Stein's company Tryps. We're building a travel app and Jake thought you'd have great perspective. We're doing quick customer interviews — would you be open to a 15-min call? No pressure at all. Also feel free to try the app while you're here: [TestFlight link]",
  "Tryps x {Name}"  // group display name
);
```

**Asif's task:** Create a new Supabase Edge Function `interview-outreach/index.ts` that:
1. Accepts `{ name, phone, profile_summary }` as input
2. Calls `createGroup()` with Jake + the person
3. Sends the outreach message
4. Logs the outreach to `interview_outreach_log` table (or just a local file for today)

**For today (fast path):** Asif can trigger `createGroup()` manually from a test script or the Supabase dashboard. No need for a full edge function on day one.

### Step 3: Voice Call Setup (Asif — Retell AI)

**Why Retell AI:**
- Best voice quality for 15-20 min interviews (sub-700ms interruption handling)
- $10 free credits = ~4-6 interviews before needing a card
- Dashboard agent creation (no code for the agent itself)
- TypeScript SDK for triggering calls
- Recording + transcript included automatically

**Setup (30 minutes):**

1. Sign up at retellai.com
2. Create an Agent in the dashboard:
   - **System prompt:** The interview script (see Step 4 below)
   - **Voice:** Warm, professional (e.g., "Rachel" or "Josh")
   - **LLM:** GPT-4.1 or Claude Sonnet
3. Buy a phone number ($2/month) — or use the Tryps number if Retell supports BYO number
4. Test with a call to Jake's number
5. Write the outbound trigger:

```typescript
import Retell from 'retell-sdk';

const retell = new Retell({ apiKey: process.env.RETELL_API_KEY });

async function startInterview(toNumber: string, agentId: string) {
  const call = await retell.call.createPhoneCall({
    from_number: RETELL_PHONE_NUMBER,
    to_number: toNumber,
    override_agent_id: agentId,
  });
  return call;
}
```

6. After call completes, retrieve transcript:

```typescript
const callDetails = await retell.call.retrieve(callId);
// callDetails.transcript contains the full conversation
// callDetails.recording_url contains the audio
```

### Step 4: Interview Script

The Retell agent's system prompt:

```
You are Trip, a friendly interviewer from Tryps — a group travel planning app.
You're calling on behalf of Jake Stein, the founder.

TONE: Warm, conversational, genuinely curious. Like a friend asking about
their travel experiences. NOT corporate, NOT scripted-sounding.

STRUCTURE:
1. Introduction (30 sec): "Hey {name}, this is Trip from Tryps — Jake's
   travel app. Thanks so much for taking the time. This'll be super quick,
   maybe 15 minutes. I just want to hear about how you travel and get your
   honest take on what we're building. Sound good?"

2. Stock Questions (everyone gets these):
   a. "What makes a great trip for you? Like, when you think back on your
      best trips, what made them special?"
   b. "Walk me through how you actually plan and book travel right now.
      What apps, sites, group chats — the whole messy process."
   c. "What's the most annoying part of that process? The thing that makes
      you want to pull your hair out?"
   d. "We just sent you a link to try Tryps — if you've had a chance to
      look at it, what's your first impression? If not, no worries."

3. Custom Questions (3, tailored to this person):
   {INJECT CUSTOM QUESTIONS FROM PREP FILE}

4. Wrap-up (30 sec): "This was incredibly helpful. Anything else you think
   we should know? And would you be open to trying the app for a real trip
   and giving us feedback after?"

RULES:
- Listen more than you talk. Let them ramble — that's where the gold is.
- Ask follow-up questions when something is interesting. Don't just go
  down the list robotically.
- If they go off-topic in an interesting direction, follow it.
- Keep it under 20 minutes total.
- End warmly: "Jake really appreciates this. He'll follow up personally."
```

### Step 5: Logging & Review

After each call, create a markdown file:

**Path:** `tryps-docs/customer-interviews/{yyyy-mm-dd}-{name-kebab}.md`

```markdown
---
name: {Full Name}
date: {YYYY-MM-DD}
phone: {phone}
duration: {X min}
interviewer: trip (retell)
---

# Customer Interview: {Full Name}

## Profile
- {Role} at {Company}
- {Key background in 1-2 lines}

## Stock Questions

### What makes a great trip?
> {verbatim answer}

### How do you plan and book travel?
> {verbatim answer}

### Most annoying part?
> {verbatim answer}

### First impression of Tryps?
> {verbatim answer}

## Custom Questions

### {Custom Q1}
> {verbatim answer}

### {Custom Q2}
> {verbatim answer}

### {Custom Q3}
> {verbatim answer}

## Key Insights
- {Insight 1}
- {Insight 2}
- {Insight 3}

## Follow-Up Actions
- [ ] {Action item}
- [ ] {Action item}

## Raw Transcript
<details>
<summary>Full call transcript</summary>

{Paste Retell transcript here}

</details>
```

---

## Phase 2: Automation (This Week)

Once the manual flow works for 5 interviews:

1. **Supabase Edge Function: `interview-pipeline/index.ts`**
   - Accepts `{ name, phone }` as input
   - Calls stableenrich.dev for profile
   - Generates custom questions via Claude
   - Creates iMessage group via Linq
   - Triggers Retell call with the right agent config
   - On call completion webhook, generates markdown file and commits to tryps-docs

2. **Marty Skill: `customer-interview`**
   - Jake says `/interview {name} {phone}` in Slack
   - Marty triggers the edge function
   - Posts summary to #martydev when complete

3. **Interview Dashboard**
   - Track: who's been contacted, who responded, who completed interview
   - Aggregate insights across all interviews

---

## Phase 3: Scale to 25 (Next Week)

- Batch mode: Jake provides a CSV of 20 names/phones
- Marty schedules calls across the week (not all at once)
- Auto-generate a weekly synthesis report: top themes, surprising insights, product implications

---

## Today's Execution Plan (Jake + Asif)

### Morning Block (9 AM - 12 PM)

| Time | Who | Task |
|------|-----|------|
| 9:00 | Asif | Sign up for Retell AI, create agent with interview script |
| 9:00 | Jake | Prepare list of 5 people (name, phone) for today |
| 9:30 | Asif | Buy Retell phone number, test call to Jake |
| 9:30 | Jake | Use AgentCash to research person #1, prep custom questions |
| 10:00 | Asif | Write outbound call trigger script (10 lines TypeScript) |
| 10:00 | Jake | Create iMessage group with person #1 via Linq (Asif helps trigger) |
| 10:30 | Together | First interview call — monitor in Retell dashboard |
| 11:00 | Jake | Research + prep persons #2-5 while Asif handles call infrastructure |
| 11:30 | Together | Interviews #2-5 (back to back, 15-20 min each) |

### Afternoon Block (2 PM - 4 PM)

| Time | Who | Task |
|------|-----|------|
| 2:00 | Jake | Review all 5 transcripts, create markdown files |
| 3:00 | Jake | Synthesize: top 3 themes, biggest surprises, product implications |
| 3:30 | Asif | Document what worked / what broke for Phase 2 automation |

### Asif's Deliverables Today

1. Retell AI account + agent configured with interview script
2. Outbound call trigger working (test call to Jake successful)
3. iMessage group creation tested (manual trigger of `createGroup()`)
4. 5 calls made and transcripts retrieved
5. Post-mortem: what to automate in Phase 2

### Jake's Deliverables Today

1. List of 5 people with phone numbers
2. AgentCash research profile for each person
3. Custom questions for each person
4. 5 markdown interview files in `tryps-docs/customer-interviews/`
5. Synthesis doc: themes + product implications

---

## File Structure

```
tryps-docs/
  customer-interviews/
    README.md                          # Overview + process
    prep/
      hikmet-ersek-profile.md          # Pre-interview research
      gianna-brudico-profile.md
      ...
    2026-04-01-hikmet-ersek.md         # Completed interview
    2026-04-01-gianna-brudico.md
    ...
    synthesis/
      2026-04-01-weekly-synthesis.md   # Cross-interview themes
```

---

## Dependencies & Risks

| Risk | Mitigation |
|------|-----------|
| Retell AI signup takes too long | Fallback: Bland AI (single curl command, worse voice quality) |
| Person doesn't answer the call | Leave voicemail via Retell, follow up in iMessage group |
| AgentCash balance insufficient | Check balance first, fund if needed |
| Linq rate limiting on group creation | Space out group creation, max 5 today |
| Interview runs long (>20 min) | Agent script has a 20-min soft cap with graceful wrap-up |
| Interviewee uncomfortable with AI caller | Jake can take over manually — the group chat is already set up |

---

## Success Criteria

- [ ] 5 people contacted via iMessage group chat today
- [ ] 5 outbound interview calls made via Retell AI today
- [ ] 5 markdown interview files created with questions + answers
- [ ] Synthesis doc with top themes written
- [ ] Asif documents Phase 2 automation requirements
- [ ] Process is repeatable: Jake can say "interview this person" and it happens

---

## Asif Getting-Started Prompt

```
I'm Asif. Jake and I are executing the customer interview pipeline TODAY.

Read the full plan at ~/tryps-docs/docs/plans/2026-04-01-feat-customer-interview-pipeline-plan.md

My morning tasks:
1. Sign up for Retell AI (retellai.com) — create an account
2. Create a voice agent with the interview script from the plan
3. Buy a phone number on Retell ($2/month)
4. Test a call to Jake (+15163761117) — verify it works
5. Write a small TypeScript script to trigger outbound calls
6. Help Jake trigger iMessage group creation via LinqTransport.createGroup()
   (code is at ~/t4/supabase/functions/_shared/linq-transport.ts:252)
7. Run 5 interview calls back-to-back
8. Retrieve transcripts from Retell API after each call

Start with Retell signup. Walk me through each step.
```

---

## References

- Retell AI docs: https://docs.retellai.com
- Retell outbound calls: https://docs.retellai.com/deploy/outbound-call
- Retell TypeScript SDK: https://github.com/RetellAI/retell-typescript-sdk
- LinqTransport.createGroup(): `/Users/jakestein/t4/supabase/functions/_shared/linq-transport.ts:252`
- QA interview precedent: `/Users/jakestein/tryps-docs/QA/jake-qa-interview.md`
- AgentCash person research: stableenrich.dev (via MCP tools)
- Voice calls spec (future scope): `/Users/jakestein/tryps-docs/scopes/voice-calls/spec.md`
