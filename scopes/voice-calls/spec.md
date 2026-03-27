---
id: voice-calls
title: "Voice Calls"
status: specced
assignee: asif
wave: 2
dependencies: [imessage-agent, agent-intelligence]
criteria_count: 14
criteria_done: 0
last_updated: 2026-03-27
links:
  objective: ./objective.md
  state: ./state.md
---

> Parent: [[voice-calls/objective|Voice Calls Objective]]

# Voice Calls — Spec

## What

Call the Tryps phone number and talk to an AI travel concierge. Same agent brain as iMessage and the app. Create trips, ask questions, get recommendations — all by voice. Everything syncs to the trip in real time.

## Why

Voice is the most natural way to talk to a travel agent. The Tryps number already handles text. Adding voice means anyone — including people who never download the app — can plan a trip the way they'd call a real agency. One number, every channel.

## Intent

> "It feels like a full-fledged travel agency when I call the Tryps number. There is somebody on the other line. People can call this number and it's like speaking to a travel agent. The agent is the same brain — the mobile app, the voice, and the text. Any way you interact with Tryps, it's all the same objective to build you towards your trip."
>
> Feel hierarchy: **fast first.** Speed over warmth. Get the info, create the trip, text the link. Still human-sounding — not robotic, not chatty. Like calling a great assistant who happens to be warm.

## Key Concepts

**One Brain, Every Channel:** The voice agent uses the same agent backend as iMessage and the app. Same tools, same trip state, same memory. Voice is a channel, not a separate product.

**Voice is Standalone:** A stranger can call the Tryps number and plan a trip without ever downloading the app. Voice onboards new users on the call: collect name, create account, create trip.

**Full State Sync:** Everything the voice agent does writes to the trip. Other trip members see flight searches, recommendations, and trip changes in-app and in iMessage. The call itself is private; the outcomes are shared.

**Fast-First Tone:** The agent is efficient. Short answers. Gets the job done. Warm but not chatty. Never monologues. Max ~25 seconds per speaking turn — if it's longer, text it instead.

---

## Success Criteria

### Inbound Call Handling

- [ ] **SC-1.** A user calls the Tryps phone number. The call connects to the AI voice agent within 3 seconds. The agent greets the caller and identifies itself as the Tryps travel concierge. Verified by: call the Tryps number from any phone -> call connects -> agent speaks a greeting within 3 seconds of pickup.

- [ ] **SC-2.** The agent identifies a known caller by matching their phone number to an existing Tryps account. It greets them by first name. Verified by: call from a phone number linked to a Tryps account with first name "Jake" -> agent says "Hey Jake" or equivalent within its greeting.

- [ ] **SC-3.** An unknown phone number calls the Tryps number. The agent greets them, asks for their name, and creates a new Tryps account linked to that phone number — entirely by voice. No app download required. Verified by: call from a phone number with no Tryps account -> agent asks for name -> provide a name -> agent confirms account created -> check database: new user record exists with that phone number and name.

### Trip Context

- [ ] **SC-4.** A caller with one active trip is automatically connected to that trip. The agent references the trip by name or destination without the caller needing to specify. Verified by: call from an account with one active trip "Barcelona" -> agent mentions "Barcelona" within the first two exchanges without being asked.

- [ ] **SC-5.** A caller with multiple active trips is asked which trip they want to discuss. The agent lists trip names and lets the caller pick by saying the name. Verified by: call from an account with 3 active trips -> agent asks "Which trip?" and lists all 3 by name -> say one name -> agent confirms and scopes the conversation to that trip.

- [ ] **SC-6.** A caller can switch trips mid-call by saying something like "actually, let's talk about the Barcelona trip." The agent confirms and switches context. Verified by: while discussing Trip A, say "let's switch to Trip B" -> agent confirms -> subsequent questions reference Trip B data correctly.

### Trip Creation by Voice

- [ ] **SC-7.** A caller (new or existing) can create a trip entirely by voice. The agent asks where, when, and who. After collecting answers, it creates the trip and sends a text message with a link to view it. Verified by: call and say "I want to plan a trip" -> agent asks destination, dates, group size -> provide answers -> agent confirms trip created -> check phone: text arrives with trip link -> check app/database: trip exists with correct destination and dates.

### Consulting & Recommendations

- [ ] **SC-8.** A caller can ask questions about their trip and get answers from the agent. Questions include: "What's the weather like?", "Any restaurant recommendations?", "What flights are available?" The agent responds with relevant information drawn from the same data the app and iMessage agent use. Verified by: call about an active trip to Barcelona -> ask "What restaurants should we try?" -> agent provides at least 2 specific recommendations.

- [ ] **SC-9.** When the agent finds results that are better viewed visually (flight options, lists of 4+ items, maps), it says "I'll text you the details" and sends a text message with the information instead of reading a long list. Verified by: ask "Show me flight options from JFK to Barcelona" -> agent acknowledges the request -> provides a brief verbal summary (top 1-2 options) -> sends a text with the full list -> check phone: text with structured flight info arrives within 30 seconds.

### State Sync

- [ ] **SC-10.** Actions taken during a voice call appear in the trip for all members. If the caller asks the agent to search for flights, other trip members see the flight search results in the app and/or iMessage thread. Verified by: User A calls and says "Find flights from JFK to Barcelona March 15" -> User B opens the trip in the app -> flight search results are visible in the trip activity.

### Error Handling & Graceful Degradation

- [ ] **SC-11.** When the agent cannot understand the caller after 2 attempts, it says something like "I'm having trouble hearing you — I'll text you so we can continue there." It then sends a text message to the caller's phone number to continue the conversation. Verified by: call and speak unintelligibly twice -> agent offers to text -> check phone: text message arrives continuing the conversation.

- [ ] **SC-12.** When a call drops unexpectedly, the agent sends a text summary of what was covered and any actions taken during the call. Verified by: start a call, create a trip, then disconnect abruptly -> check phone within 60 seconds: text arrives summarizing what happened on the call (e.g., "I created your Barcelona trip. Here's the link: [link]").

### Should NOT Happen

- [ ] **SC-13.** The agent never initiates outbound voice calls. All calls are inbound only. The agent may send text messages as follow-ups but never places a call. Verified by: create a trip by voice -> wait 24 hours -> confirm no outbound calls received from the Tryps number. Check call logs: zero outbound voice calls from the system.

- [ ] **SC-14.** The agent never exposes technical errors to the caller. No error codes, no stack traces, no "something went wrong with error 500." If an internal error occurs, the agent says "Let me look into that — I'll text you when I have an answer." Verified by: trigger a backend failure during a voice call (e.g., disconnect the recommendations API) -> listen to agent response -> agent does NOT mention any technical details -> agent offers to follow up by text.

### Out of Scope

- Booking (flights, stays, activities) by voice — deferred. Agent tells caller to use the app or text for booking.
- Outbound calls — agent never initiates voice calls.
- Payment collection by voice — no credit card info over the phone. Ever.
- Conference calls / multi-party voice — one caller at a time.
- Voice API selection — Asif researching (Vapi, Bland, Retell, Twilio Voice AI). Spec is API-agnostic.

### Open Questions

- **Permissions model:** Currently everyone on a trip has equal power (can modify via voice or any channel). The owner-vs-democratic permission model is an app-wide decision that needs its own spec. For V1 voice: all trip members can take any action.
- **Voice selection:** Which voice sounds the most human? Asif to evaluate APIs and present options to Jake for final pick.
- **Agent persona on voice vs. text:** Same personality, but should the voice agent be slightly more concise than text? (Current answer: yes — fast-first.)

### Regression Risk

| Area | Why | Risk |
|------|-----|------|
| iMessage agent | Shared agent brain — voice changes to routing/tools could affect text behavior | High |
| Agent Intelligence | Voice calls use the same recommendation/memory system | Med |
| Phone number auth | Voice relies on phone number matching, same as SMS login | Med |

- [ ] Typecheck passes
