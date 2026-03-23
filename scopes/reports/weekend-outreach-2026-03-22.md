# Weekend Outreach Campaign

> Owner: Jake
> Target: 25 groups, March 22-23, 2026
> Goal: iMessage onboarding + app downloads + beta feedback

## Playbook (Per Group)

### Step 1: Create Group iMessage
- Open iMessage, create new group
- Add friends + Tryps phone number
- Note: Friends will get "I don't recognize this number" if they text the bot before downloading. That's expected.

### Step 2: Send Opening Message
Fill in the template below and send:

```
hey [personal touch] — I've been building this group trip planning app
called Tryps and you guys are my guinea pigs. [trip hook]. I added a bot
to this chat — just text it links or flight numbers and it organizes
everything.

download to see the trip: [TESTFLIGHT LINK]

be brutally honest, we're in beta
```

**Variables:**
- `[personal touch]` — 1 sentence callback to something real ("haven't seen you guys since [event]", "was just thinking about [shared memory]")
- `[trip hook]` — the trip that makes this feel organic ("perfect timing since we keep talking about doing austin", "we need to actually lock in that ski trip")
- `[TESTFLIGHT LINK]` — your TestFlight URL

### Step 3: Follow Up (Day 1)
After initial engagement:
- Answer questions about the app
- If someone sends a link/flight to the Tryps number → the bot handles it
- Remind anyone who hasn't downloaded yet

### Step 4: Feedback Ask (Day 2)
Send a follow-up in the group:

```
hey quick ask — there's a feedback button on the home screen in the app.
tap it and tell us what you think. bugs, things that are confusing,
whatever. takes 30 seconds and it helps a ton
```

---

## Tracking

| # | Group Name | Size | Category | Trip Hook | Status | Downloads | Feedback | Notes |
|---|-----------|------|----------|-----------|--------|-----------|----------|-------|
| 1 | | | | | not sent | 0/ | 0/ | |
| 2 | | | | | not sent | 0/ | 0/ | |
| 3 | | | | | not sent | 0/ | 0/ | |
| 4 | | | | | not sent | 0/ | 0/ | |
| 5 | | | | | not sent | 0/ | 0/ | |
| 6 | | | | | not sent | 0/ | 0/ | |
| 7 | | | | | not sent | 0/ | 0/ | |
| 8 | | | | | not sent | 0/ | 0/ | |
| 9 | | | | | not sent | 0/ | 0/ | |
| 10 | | | | | not sent | 0/ | 0/ | |
| 11 | | | | | not sent | 0/ | 0/ | |
| 12 | | | | | not sent | 0/ | 0/ | |
| 13 | | | | | not sent | 0/ | 0/ | |
| 14 | | | | | not sent | 0/ | 0/ | |
| 15 | | | | | not sent | 0/ | 0/ | |
| 16 | | | | | not sent | 0/ | 0/ | |
| 17 | | | | | not sent | 0/ | 0/ | |
| 18 | | | | | not sent | 0/ | 0/ | |
| 19 | | | | | not sent | 0/ | 0/ | |
| 20 | | | | | not sent | 0/ | 0/ | |
| 21 | | | | | not sent | 0/ | 0/ | |
| 22 | | | | | not sent | 0/ | 0/ | |
| 23 | | | | | not sent | 0/ | 0/ | |
| 24 | | | | | not sent | 0/ | 0/ | |
| 25 | | | | | not sent | 0/ | 0/ | |

**Status values:** `not sent` → `sent` → `engaged` → `downloading` → `downloaded` → `feedback`

## Categories (fill in per group)
- city/friends (Dallas, NYC, Boston, etc.)
- college
- work
- family
- couple friends
- hobby/activity group

---

## Current Limitations (Honest Assessment)

1. **Bot says "I don't recognize this number"** to anyone not already in Tryps. Friends need to download + sign up first before the bot recognizes them.
2. **Bot is template-based** — responds to links and flight numbers, but doesn't have conversational ability yet. "Got it! Working on it..." for anything it doesn't understand.
3. **No auto trip creation from chat** — trips need to be created in the app, not via text.
4. **No LLM personality** — the bot is functional, not charming.

**Your job this weekend is to be the personality.** The bot handles the data entry (links, flights), you handle the selling and follow-up.

---

## Metrics (End of Weekend)

- Groups messaged: ___ / 25
- People reached: ___ (total across all groups)
- TestFlight downloads: ___
- Feedback submissions: ___
- Groups that engaged with the bot: ___ / 25

---

## Agent Upgrade Spec (For Devs — Post-Weekend)

### What the agent SHOULD do (future state):

**First message in new group:**
> Hey! I'm the Tryps bot — I help organize group trips. Looks like you're
> thinking about [destination]. I set up a trip for you — send me links,
> flight numbers, or photos of confirmations and I'll keep everything
> organized. Download Tryps to see the full itinerary and vote on stuff:
> [link]

**Tone:** Helpful concierge — warm, natural, slightly polished. Like a really good travel agent who texts.

**Capabilities needed:**
1. Detect new group chat (no existing trip for these phone numbers)
2. Extract destination from conversational context
3. Auto-create a trip with participants
4. Introduce itself with personality
5. Drop app download link naturally
6. After 3-5 interactions, ask for beta feedback
7. Work for any group (not just Jake's)

**Architecture:** Add Claude API call to `inbound-sms` edge function for conversational cases. Template responses still handle links/flights.

**Files to modify:**
- `supabase/functions/inbound-sms/index.ts` — add LLM fallback for unknown intents + new group detection
- `utils/smsResponses.ts` — add intro template as fallback
- New: system prompt config (either inline or separate file)
