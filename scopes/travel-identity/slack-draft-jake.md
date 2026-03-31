# Slack Draft — To Jake

> Do not send. Review and adjust.

---

**"Connecting travel life to Tryps" — where we are and what's next**

**What exists today:** Duffel flight search+booking, Amadeus hotel search, accommodation URL scraping, full Travel DNA quiz (220+ questions), agent memory system with context injection — the agent already knows your vibe, home airport, and preferences from conversations. What it does NOT know: your loyalty numbers, seat preferences, or anything about accounts you have elsewhere.

**What's missing:** No loyalty number storage, no connected accounts UI, no booking passthrough (Duffel supports loyalty numbers but we don't pass them), no email parsing, no calendar sync, no OAuth connectors. The travel-identity scope (50 SC, Nadeem) is specced but 0% started.

**What I recommend building first:** (1) This week — `travel_connectors` table + wire loyalty numbers into agent context + wire into Duffel booking passthrough. ~200 lines, no UI needed. The agent can collect loyalty numbers via DM conversation. (2) Next week — email forwarding pipeline. Forward your confirmation emails to Tryps, Claude parses them, auto-creates trip items. Highest leverage "connector" because it works with every airline/hotel without partnerships. (3) Week 2-3 — Google Calendar sync.

**Key insight:** Airlines and hotels have zero public APIs. "Connect your Delta account" will always mean "type your SkyMiles number." OAuth only works for Uber, Lyft, and Airbnb. Email parsing is the real connector — it's how TripIt and Google Travel solve this. We should build both: be the booking layer (Duffel/Amadeus) AND import from elsewhere (email + manual entry).

**Timeline:** Loyalty passthrough shipping this week. Email parsing next week. Full connected accounts UI when Nadeem starts travel-identity scope. Architecture doc at `tryps-docs/scopes/travel-identity/connecting-travel-life.md`.
