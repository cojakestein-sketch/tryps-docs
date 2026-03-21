# Weekend Outreach Campaign: 25 Groups in 48 Hours

> Brainstorm date: 2026-03-20
> Status: Finalized — ready for execution weekend of March 22

## What We're Building

A systematized weekend outreach campaign to onboard 25 groups of Jake's real contacts onto Tryps via iMessage + app download. Three conversion goals per group:

1. **iMessage onboarding** — Group interacts with the Tryps bot in a group chat
2. **App download** — Friends download Tryps via TestFlight
3. **Beta feedback** — Friends submit feedback via in-app mechanisms

## Reality Check: What Works NOW vs LATER

### This Weekend (Manual — Jake is the personality)
- Bot handles: links, flight numbers, forwarded emails, MMS photos → functional template responses
- Bot does NOT: introduce itself, create trips from chat, have personality, or know who anyone is until they download + sign up
- Jake's job: sell it, follow up, handle the feedback ask manually

### For Devs (Post-Weekend Spec)
- LLM-powered agent intro + conversational responses
- Auto trip creation from chat context
- New group detection
- Proactive feedback ask after N interactions

## The System (Weekend Version)

### Flow Per Group

```
Jake creates new GC (friends + Tryps phone number)
  → Jake sends Version B message with TestFlight link
  → Friends download via TestFlight, sign up with phone number
  → Once signed up, friends can text links/flights → bot handles functionally
  → Jake follows up Day 2 with feedback ask
```

**Known friction:** If friends text the Tryps number before downloading, they get "I don't recognize this number." Jake handles this manually ("yeah download first, then it'll know who you are").

### Message Template (Version B — Builder-forward)

```
hey [personal touch] — I've been building this group trip planning app
called Tryps and you guys are my guinea pigs. [trip hook]. I added a bot
to this chat — just text it links or flight numbers and it organizes
everything.

download to see the trip: [TESTFLIGHT LINK]

be brutally honest, we're in beta
```

**Variables:**
- `[personal touch]` — 1 sentence, reference something real
- `[trip hook]` — the trip idea that makes this organic ("perfect timing since we keep talking about doing austin")
- `[TESTFLIGHT LINK]` — TestFlight URL

### Day 2 Follow-up Message

```
hey quick ask — there's a feedback button on the home screen in the app.
tap it and tell us what you think. bugs, things that are confusing,
whatever. takes 30 seconds and it helps a ton
```

### Feedback Collection (Three Touchpoints — Phased)

1. **Jake in chat** (this weekend) — Manual follow-up message Day 2
2. **Home screen banner** (dev work, post-weekend) — Persistent beta banner
3. **Push notification** (dev work, post-weekend) — 24hr delay after first use

### Tracking

Location: `tryps-docs/scopes/reports/weekend-outreach-2026-03-22.md`

**Status values:** `not sent` → `sent` → `engaged` → `downloading` → `downloaded` → `feedback`

## Key Decisions

1. **New group chats** — don't add Tryps to existing GCs (keeps existing convos clean)
2. **Template + swap** — not fully custom, not fully generic (Version B: builder-forward)
3. **Jake is the personality this weekend** — bot handles data, Jake handles selling
4. **TestFlight distribution** — direct link in the message
5. **Concierge tone** (for dev spec) — warm and polished, not bro-y, not robotic
6. **Track in tryps-docs markdown** — stays in the repo, easy to update from terminal
7. **No code changes this weekend** — agent LLM upgrade is a dev task

## Resolved Questions

1. Download link: **TestFlight**
2. Auto trip creation: **Not yet — dev work**
3. New group detection: **Not yet — dev work**
4. "I don't recognize" for new users: **Acceptable for now — Jake handles manually**

## Open Questions (For Dev Spec)

1. Push notification infrastructure — is this already set up?
2. Home screen banner — how prominent? Dismissible or persistent?
3. Which LLM for agent responses? (Claude API is the natural choice)

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

## Deliverables

- [x] Message template finalized (Version B)
- [x] Tracking doc created (`scopes/reports/weekend-outreach-2026-03-22.md`)
- [x] Playbook written (step-by-step per group)
- [x] Agent upgrade spec captured (for devs, post-weekend)
- [ ] Jake fills in 25 groups (name, size, category, trip hook)
- [ ] Test flow end-to-end with one group before blasting all 25
