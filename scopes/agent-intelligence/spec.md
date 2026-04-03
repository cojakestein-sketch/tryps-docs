---
id: agent-intelligence
title: "Agent Intelligence"
status: specced
assignee: rizwan
wave: 2
dependencies: [travel-identity]
clickup_ids: ["86e05v28h", "86e0ajhte"]
criteria_count: 61
criteria_done: 0
last_updated: 2026-03-22
links:
  design: ./design.md
  testing: ./testing.md
  objective: ./objective.md
  state: ./state.md
  memory_architecture: ./memory-architecture.md
---

> Parent: [[agent-intelligence/objective|Agent Intelligence Objective]]

# Agent Intelligence — Spec

## What

The AI brain that powers Tryps. Three tightly coupled sub-systems: memory architecture (per-user, per-trip, and cross-trip learning), vote-on-behalf (agent proxy voting from Travel DNA + behavioral history), and a recommendations engine (activity database + personalized ranking powered by a feedback loop). Memory is the foundation that feeds everything.

## Why

Without intelligence, Tryps is a trip organizer. With it, Tryps is a travel agent that knows your friends, your vibe, and what you loved last time. Memory is the moat — the more you use Tryps, the better it gets. No competitor can replicate your trip history, vote patterns, and friend graph.

## Intent

> "Travel DNA is the seed; memory is the growth. The lightest user just answers the vibe quiz. The most sophisticated user is describing in natural language things they want out of their travel experience directly to their agent, in their own one-on-one DMs."
>
> "Your group has six activities on the voting block. I voted yes on these and no on these on your behalf because I believe that this is how you would vote. If you want to change these votes, click here. That's how I want it to feel. I don't want the user to get ten texts in a row about these."
>
> "We need a full recommendation algorithm architecture end to end in the same way that Instagram or Facebook does this. This has been done before; we should not reinvent the wheel."
>
> "Once users actually come in and start creating activities themselves, those activities end up being user-generated and those have higher priority in the recommendation algorithm. It starts out with a seed dataset and then it ends up being all your friends' recommendations."

## Key Concepts

**Travel DNA is the Seed, Memory is the Growth:** Users enter at different engagement tiers. Tier 1 answers the vibe quiz. Tier 4 has an ongoing 1:1 DM relationship with the agent. Each tier produces richer memory. The agent works at every tier but gets better with more signal.

**Engagement Tiers:**
- **Tier 0:** Ghost user — barely interacts (avoid this)
- **Tier 1:** Vibe quiz only — 6-10 A/B questions, lightest signal
- **Tier 2:** Natural language trip intent — "I want a chill beach trip with good food"
- **Tier 3:** Full Travel DNA quiz — deeper A/B tested preferences
- **Tier 4:** Ongoing 1:1 DM relationship — "always call me Sir Stein," explicit preference curation

**One Agent, One Brain:** Memory is shared across iMessage and the app. Same context everywhere.

**Batch, Don't Spam:** Vote-on-behalf notifications always arrive as a single batched DM covering all pending polls. Never one-per-poll.

**User Data > Seed Data:** User-generated activities from other Tryps users rank higher than scraped defaults. The social graph is derived from shared trip history and contact book sync — "other Tryps users did X, you could too." Connected users (travel companions, contacts) rank highest.

**Facilitator, Not Dictator:** The agent infers and acts, but explicit human choices always override.

---

## Success Criteria

### Memory Architecture

- [ ] **SC-1.** Per-user memory exists as a Supabase table storing preference signals, interaction patterns, and behavioral data linked to a user ID. Verified by: query the memory table for a user who has completed the vibe quiz and voted on 3 polls -> table contains structured records for quiz answers and vote history.

- [ ] **SC-2.** Per-trip memory exists as a Supabase table storing trip-specific decisions, group dynamics, and outcomes linked to a trip ID. Verified by: query the trip memory table for a completed trip -> table contains records for decisions made, activities added, votes cast, and post-trip favorites.

- [ ] **SC-3.** Cross-trip memory aggregates anonymized patterns across trips by destination. Verified by: 5 different groups have completed trips to Barcelona -> query cross-trip patterns for Barcelona -> aggregated data shows activity popularity (e.g., "beach day was added by 4/5 groups").

- [ ] **SC-4.** Memory persists across app sessions. Verified by: user completes vibe quiz and votes on 2 polls -> closes app entirely -> reopens app -> agent recommendations and vote inferences still reflect all prior data.

- [ ] **SC-5.** Memory persists across channels — iMessage and app share the same memory for a user. Verified by: user tells the agent in iMessage "I hate nightclubs" -> open the app -> agent recommendations exclude nightlife activities for this user.

- [ ] **SC-6.** Vibe quiz answers are stored as the initial memory seed (Tier 1). Verified by: user completes vibe quiz selecting "beach", "relaxed", "mid-budget" -> memory table contains these as structured preference signals with source "vibe_quiz".

- [ ] **SC-7.** Natural language trip intent is captured and stored as structured memory signals (Tier 2). Verified by: user texts "I want a chill beach trip with good food and no hiking" -> memory table contains structured signals: positive(beach, food), negative(hiking), with source "trip_intent".

- [ ] **SC-8.** Full Travel DNA quiz answers extend memory beyond vibe quiz (Tier 3). Verified by: user completes both vibe quiz and Travel DNA -> memory table contains both signal sets -> Travel DNA signals have higher weight than vibe quiz when they overlap.

- [ ] **SC-9.** 1:1 DM conversations with the agent capture structured memory signals (Tier 4). Verified by: user texts agent in 1:1 DM "always call me Sir Stein and I prefer boutique hotels over chains" -> memory table contains: display_preference("Sir Stein"), accommodation_preference("boutique"), with source "dm_conversation".

- [ ] **SC-10.** Agent learns from vote overrides — when a user changes an inferred vote, the correction is stored as a learning signal. Verified by: agent infers "yes" on a nightclub activity -> user overrides to "no" -> memory stores the correction -> on the next trip, agent infers "no" on nightclub activities.

- [ ] **SC-11.** Agent learns from activity adoption — when a user adds a recommended activity, it is stored as a positive signal. Verified by: agent recommends 5 activities -> user adds 3 of them -> memory stores positive signals for those 3 activity categories -> on the next trip, similar activity types rank higher in recommendations.

- [ ] **SC-12.** Agent learns from post-trip favorites — marking an activity as a top-3 favorite is a strong positive signal. Verified by: user marks "sunset boat tour" as a top-3 favorite post-trip -> memory stores a strong positive signal for water/sunset activities -> on the next trip, water activities rank higher.

- [ ] **SC-13.** Memory data injects into the iMessage agent's system prompt via the extension points defined in SC-34 of the iMessage Agent spec. Verified by: user has rich memory (10+ signals from quiz, votes, and DMs) -> iMessage agent receives a message -> system prompt includes a user context section populated with the user's preferences, vote history, and behavioral patterns from memory.

- [ ] **SC-14.** Memory is per-user scoped — one user's memory is never accessible to or influenced by another user's data. Verified by: User A has memory signal "hates nightclubs" -> log in as User B -> query User B's memory -> User A's signal does not appear -> User B's recommendations are unaffected by User A's preferences.

- [x] **SC-15.** Users can view what the agent remembers about them via a screen in the app (behind Travel DNA). Verified by: navigate to agent memory screen -> screen shows structured list of what the agent knows: explicit preferences, learned behaviors, and trip history summary.

- [ ] **SC-16.** More engagement produces richer memory — a Tier 4 user gets noticeably better recommendations and vote inference than a Tier 1 user. Verified by: Tier 1 user (vibe quiz only) and Tier 4 user (vibe + DNA + DM history + 3 past trips) both go to Barcelona -> compare recommendations -> Tier 4 user's recommendations are more specific and personalized.

- [ ] **SC-17.** Memory architecture is documented in memory-architecture.md defining the data model, signal types, memory flows, and integration points. Verified by: document exists, covers all three memory layers (per-user, per-trip, cross-trip), and is sufficient for Rizwan to build from.

### Vote-on-Behalf

- [ ] **SC-18.** Agent infers and immediately casts a vote on every open poll based on available memory signals. Verified by: trip has 3 open polls (destination, dinner spot, activity) -> agent generates and casts inferred votes for all 3 based on the user's memory -> votes appear in the poll results.

- [ ] **SC-19.** Vibe quiz answers alone are sufficient to infer a vote (Tier 1 minimum). Verified by: user has completed only the vibe quiz (no other memory) -> poll for "beach day vs museum day" -> agent infers "beach day" based on quiz answer -> inference is reasonable given the data.

- [ ] **SC-20.** When polls are pending, the agent sends a single batched DM to the user summarizing all inferred picks with brief reasoning and how to change them. Verified by: 6 activities on the voting block -> agent casts votes -> sends ONE DM: "your group has 6 activities up for vote. I voted yes on [A, B, C] and no on [D, E, F] based on your vibe. reply here to change any of these or tap [link] to review in the app" -> user receives exactly 1 message, not 6.

- [ ] **SC-21.** The batch DM includes a way to change votes — either by replying in-chat ("switch D to yes") or via deep link to the app's vote review screen. Verified by: user receives batch DM -> replies "switch D to yes" -> vote updated -> agent confirms in DM -> OR user taps deep link -> app opens to vote review screen showing all inferred votes.

- [ ] **SC-22.** If the user doesn't override any inferred votes before the poll closes, the inferred votes stand as final. Verified by: agent casts inferred votes and sends batch DM -> user doesn't respond -> poll's 48hr deadline passes -> inferred votes are counted in the final tally.

- [ ] **SC-23.** User can override any inferred vote at any time before the poll closes. Verified by: agent inferred "yes" on activity A -> user texts "change A to no" 30 minutes before deadline -> vote updated -> agent confirms -> poll results reflect the override.

- [ ] **SC-24.** Vote overrides are stored as correction signals in memory, improving future inference. Verified by: user overrides 3 nightlife votes from "yes" to "no" across 2 trips -> on the next trip, agent infers "no" on nightlife activities without being told.

- [ ] **SC-25.** Vote-on-behalf is on by default for all users — no opt-in required. Verified by: brand new user joins a trip -> completes vibe quiz -> first poll opens -> agent infers and casts a vote without the user having enabled any setting.

- [ ] **SC-26.** Vote-on-behalf works for destination votes. Verified by: poll with 3 destination options (beach town, ski resort, city break) -> user's vibe quiz says "beach" -> agent infers beach town -> vote is reasonable.

- [ ] **SC-27.** Vote-on-behalf works for date votes. Verified by: poll with 3 date options -> agent infers based on any known constraints or defaults to no strong preference -> vote is cast.

- [ ] **SC-28.** Vote-on-behalf works for activity votes. Verified by: poll with 3 activity options (surfing, museum, cooking class) -> user's memory includes positive signals for adventure and water activities -> agent infers surfing.

- [ ] **SC-29.** Vote-on-behalf works for accommodation votes. Verified by: poll with 3 stay options (hostel, boutique hotel, resort) -> user's memory includes "prefers boutique hotels" -> agent infers boutique hotel.

- [ ] **SC-30.** Internal confidence scoring (high/medium/low) is tracked per inference but never displayed to the user. Verified by: agent infers votes -> each inference has an internal confidence score stored in the database -> no confidence indicator appears in the batch DM, app, or any user-facing surface.

- [ ] **SC-31.** Agent uses all available memory signals for inference: vibe quiz, Travel DNA, vote history, vote overrides, post-trip favorites, and activity adoption patterns. Verified by: user has data across all signal types -> agent inference for a new poll draws from all of them -> changing any one signal type produces a different inference.

- [ ] **SC-32.** Inference accuracy improves across trips — the agent gets better at predicting votes over time. Verified by: user completes Trip 1 (5 vote overrides out of 8 inferred votes) -> Trip 2 (2 overrides out of 8) -> Trip 3 (0-1 overrides out of 8) -> trending toward fewer corrections.

### Recommendations Engine

- [ ] **SC-33.** Activity database exists in Supabase with globally seeded data covering ALL destinations. Generic activity templates (beach day, museum visit, shopping, dining, nightlife, hiking, etc.) apply everywhere via applicability rules, so no destination has zero recommendations. Specific activities (named places) exist for popular destinations. Verified by: query activity database for any destination (popular or obscure) -> returns at least generic template matches -> popular destinations (50+) also have specific named activities -> total specific activity count exceeds 1,000.

- [ ] **SC-34.** Two tiers of activities exist in the database: generic templates ("beach day", "museum visit", "go shopping") that apply broadly, and specific activities ("Bondi Beach", "Louvre Museum", "Grand Bazaar") tied to individual locations. Verified by: query activities -> results include both generic templates with broad applicability AND specific activities with location coordinates and addresses.

- [ ] **SC-35.** Generic activity templates automatically apply to matching destinations based on applicability rules. Verified by: "beach day" template has rule "coastal city" -> user creates trip to Miami -> "beach day" appears in recommendations -> user creates trip to landlocked Denver -> "beach day" does not appear.

- [ ] **SC-36.** Specific activities are tied to a location with structured metadata: name, description, category, source, and source URL. Verified by: query specific activities for Barcelona -> each has: name ("La Boqueria Market"), description, category ("food & markets"), source ("Reddit r/Barcelona"), and source URL.

- [ ] **SC-37.** Activities are categorized by type. Categories include at minimum: museums, beaches, shopping, nightlife, dining, adventure, cultural, relaxation, outdoor, tours, and entertainment. Verified by: query activity categories -> all listed categories exist -> each activity belongs to at least one category.

- [ ] **SC-38.** Seed data is scraped from proprietary sources including Reddit, travel blogs, and review sites. Verified by: activity records include source attribution -> sources include Reddit threads, travel blog URLs, and review site listings -> no single source accounts for more than 50% of activities.

- [ ] **SC-39.** Comprehensive museum coverage — every major museum globally is catalogued as a specific activity. Verified by: query museums -> results span all continents -> major cities (New York, London, Paris, Tokyo, Mexico City, Cairo, Sydney) each have 10+ museums listed.

- [ ] **SC-40.** Group vibe quiz answers filter and rank activities for the trip's destination. Verified by: 4-person group, 3 answered "adventure" and 1 answered "relaxation" -> recommendations for Costa Rica prioritize adventure activities (zip-lining, white water rafting) over relaxation (spa day) -> ranking reflects the group majority.

- [ ] **SC-41.** Recommendations surface in both the app AND iMessage — one brain, both channels. In-app: "Suggested for your group" section on the Activities tab shows 5-8 ranked activity cards. In iMessage: when contextually relevant (user asks, or daily check-in calls for it), the agent serves 2-3 top recommendations with brief reasons. Verified by: open trip -> Activities tab shows ranked recommendations -> separately, text "what should we do?" in iMessage -> agent responds with personalized suggestions that match the app's top picks.

- [ ] **SC-42.** Different groups going to the same destination get different recommendations. Verified by: Group A (adventure vibe) and Group B (relaxation vibe) both create trips to Bali -> Group A sees surfing, volcano hike, waterfall trek -> Group B sees spa day, beach club, sunset yoga -> top 5 lists have minimal overlap.

- [ ] **SC-43.** Track whether a user adds a recommended activity (adoption signal). Verified by: agent recommends 8 activities -> user adds 3 -> adoption event stored in memory for all 3 -> adoption rate (3/8) is trackable.

- [ ] **SC-44.** Track post-trip favorites against recommendations — was a favorited activity originally recommended by Tryps? Verified by: user marks "sunset boat tour" as a top-3 favorite -> system checks if it was a Tryps recommendation -> if yes, recommendation quality signal stored.

- [ ] **SC-45.** Feedback loop: adoption and favorites data improves the ranking algorithm over time. Verified by: 100 groups have visited Barcelona -> activities with high adoption rates rank higher for new Barcelona groups -> activities that were never adopted rank lower or drop out of recommendations.

- [ ] **SC-46.** User-generated activities from past trips become recommendations for future trips to the same destination. Verified by: Group A creates custom activity "Hidden rooftop bar on Calle de Blai" in Barcelona -> Group B creates a trip to Barcelona -> the rooftop bar appears in Group B's recommendations as "other Tryps users loved this."

- [ ] **SC-47.** User-generated activities rank higher than seed data in recommendations. Verified by: seed data includes "La Boqueria Market" (scraped from travel blog) -> another Tryps user created "Secret tapas spot near La Boqueria" (user-generated) -> user-generated activity ranks above seed data in recommendations. The framing is "other Tryps users did X, you could too."

- [ ] **SC-48.** Social graph is derived from two sources: (1) shared trip history (people who've been on a trip together are connected), and (2) contact book sync (with user permission). Activities from connected users rank higher than general population data. Verified by: recommendation ranking for Barcelona -> activity from someone you've traveled with ranks above activity from a stranger who also used Tryps -> both rank above seed data.

- [ ] **SC-49.** Recommendation algorithm follows established patterns: content-based filtering (matching activity tags to user preferences) combined with collaborative filtering (what similar users liked). Verified by: architecture review confirms two components: content-based matching (vibe -> activity tags) and collaborative filtering (similar users liked similar activities) -> both contribute to final ranking with documented weights.

- [ ] **SC-50.** Algorithm architecture is documented in memory-architecture.md with data flow, ranking logic, signal weights, and how the feedback loop closes. Verified by: document contains a recommendations section with inputs, ranking formula, signal weight table, and feedback loop diagram.

### Should NOT Happen

- [ ] **SC-51.** The agent never casts inferred votes without notifying the user via batch DM. Verified by: 3 polls open -> agent casts inferred votes -> batch DM is sent within 1 minute -> if DM delivery fails, agent retries delivery, votes remain cast but user is always notified.

- [ ] **SC-52.** One user's memory data is never visible to another user — not in the app, not in recommendations, not in system prompt injection. Verified by: User A has memory "hates nightclubs" -> log in as User B -> no reference to User A's preference appears anywhere in User B's experience.

- [ ] **SC-53.** The agent never overrides a user's explicit vote with an inferred one. Explicit always beats inferred. Verified by: user manually votes "yes" on activity A -> agent's inference would have been "no" -> user's explicit "yes" stands unchanged -> agent does not modify it.

- [ ] **SC-54.** Recommendations never surface activities that the group has explicitly voted down on the current trip. Verified by: group voted down "nightclub crawl" on this trip -> recommendations tab does not show nightclub crawl for the remainder of this trip.

- [ ] **SC-55.** Memory never stores raw conversation transcripts — only structured signals extracted from conversations. Verified by: query memory table for a user with 50+ iMessage interactions -> no raw message text stored -> only structured signals (preference tags, sentiment indicators, override records).

- [ ] **SC-56.** Vote-on-behalf never sends individual DMs per poll — always batched into a single message covering all pending polls. Verified by: 8 polls open simultaneously -> user receives exactly 1 DM covering all 8 -> not 8 separate DMs.

### Open Technical Design Decisions

- [ ] **SC-57.** ⚠️ **DESIGN DECISION: NLP extraction pipeline.** A documented approach exists for how free-text natural language (Tier 2 trip intents and Tier 4 DM conversations) gets turned into structured memory signals. This is the core pipeline for half of Agent Intelligence and must be intentionally designed before implementation. Verified by: document in memory-architecture.md describes the extraction approach (e.g., Claude function calling with a schema, structured output prompt, dedicated extraction agent), includes example inputs/outputs for at least 10 message types, and Rizwan confirms it's buildable. Options to evaluate: (a) Claude function calling with a defined signal schema, (b) a dedicated extraction prompt that runs per-message, (c) batch processing with a periodic extraction agent.

- [ ] **SC-58.** ⚠️ **DESIGN DECISION: Routing logic.** A routing logic design doc exists (shared with iMessage Agent scope 7, see SC-52) defining when the agent speaks vs. stays silent, with at least 20 example messages, edge cases, and "gotchas." This is the hardest judgment call in the product — the line between "casual" and "actionable travel intent." Verified by: document exists, is reviewed by Jake, and includes a classification rubric the system prompt can reference.

### Cross-Scope Coordination

- [ ] **SC-59.** ⚠️ **COORDINATION REQUIRED (scope 7).** The DM delivery pipeline — how Agent Intelligence triggers sending a batch DM through the iMessage Agent's Linq infrastructure — must be designed jointly by Asif (scope 7) and Rizwan (scope 8) before either side implements. Verified by: a shared interface spec exists defining the API contract (e.g., Agent Intelligence calls a `sendDM(userId, message)` function, or writes to a message queue that iMessage Agent drains), and both teams have signed off.

- [ ] **SC-60.** ⚠️ **COORDINATION REQUIRED (scope 7).** When a user replies to a vote-on-behalf batch DM with a vote change (e.g., "switch D to yes"), the iMessage Agent must route it to Agent Intelligence's vote engine. The parsing logic and routing contract must be defined jointly. Verified by: shared spec exists defining how vote override messages are identified and routed.

- [ ] **SC-61.** ⚠️ **COORDINATION REQUIRED (scope 7).** A shared rate limiter or message coordination mechanism prevents Agent Intelligence (batch DMs) and iMessage Agent (daily check-ins, proactive nudges) from spamming users with overlapping proactive messages. Verified by: mechanism exists (shared queue, rate limit, or scheduling coordination), and a user never receives more than one proactive outbound message in a 4-hour window.

---

## Out of Scope

- **Claude Connector / AI platform connectors** — moved to new scope 14 (post-April 2). MCP remote server for Claude, OpenAI, and other AI platforms. Totally separate from the agent brain.
- **Logistics Agent / autonomous booking orchestration** — moved to its own scope (post-April 2). The agent researching, booking, and recovering from failures. Built last after intelligence and booking infrastructure exist.
- **Role cards (Mario-style character select)** — post-April 2. Engagement tiers inform the agent today; formalized role selection is a future feature.
- **Actual booking execution** — scope 10 (Travel Booking). Agent Intelligence recommends; Travel Booking executes.
- **Payment processing** — scope 9 (Payments Infrastructure). No money flows through this scope.
- **iMessage agent rendering** — scope 7 (iMessage Agent). This scope produces data and decisions; scope 7 renders them in iMessage.
- **Daily/morning trip summaries** — cut from April 2.
- **Agent spending money on behalf of users** — post-April 2 (per strategy intake Q23: $0 default, API costs only).

## Regression Risk

| Area | Why | Risk |
|------|-----|------|
| Voting system | Agent writes inferred votes to the same poll tables | High |
| Activity feed | Recommendations write to activities data model | Medium |
| System prompt | Memory injection changes agent behavior across all responses | High |
| Travel DNA | Memory extends DNA data — schema changes could break quiz flow | Medium |
| User profile | Agent memory screen is a new surface on the profile | Low |

## Dependencies

| Scope | What's Needed | Blocks |
|-------|--------------|--------|
| [[travel-identity/objective|travel-identity]] (#4) | Vibe quiz data (already built). Full Travel DNA enriches memory but not required. | SC-6, SC-8, SC-19 (vibe quiz as minimum signal) |
| [[imessage-agent/objective|imessage-agent]] (#7) | System prompt extension points (SC-34). Memory injects into those slots. DM delivery pipeline for batch DMs. Vote override routing. Recommendation serving in iMessage. | SC-13 (memory injection), SC-41 (recs in iMessage), SC-59 (DM pipeline), SC-60 (vote override routing), SC-61 (rate limiting). **Asif and Rizwan must define the shared interface before implementation.** |
| brand-design-system (#11) | Voice guide rules apply to vote-on-behalf DM copy | SC-20 (batch DM format) |

## References

### Migrated
- Old spec: `archive/scopes-deprecated/p1/recommendations/spec.md` — intent only (5 sub-scopes, 0 criteria). All 5 sub-scope concepts absorbed. Activity and accommodation recommendations are in-scope. Flight, trip, and discovery recommendations deferred to post-April 2 alongside Travel Booking and Logistics Agent.
- Old spec: `archive/scopes-deprecated/p3/vote-on-behalf/spec.md` — intent only (0 criteria). Fully specced now as SC-18 through SC-32. Key areas from the intent doc (inference engine, pre-deadline nudge, confidence scoring, opt-in/opt-out) all addressed. Opt-in/opt-out replaced with "on by default."

### Moved to New Scopes
- Old spec: `archive/scopes-deprecated/p1/claude-connector/spec.md` — 36 criteria, fully specced. Moved to new scope 14 (AI Platform Connectors), post-April 2. Expanded from Claude-only to multi-platform (Claude, OpenAI, etc.).
- Old spec: `archive/scopes-deprecated/p3/logistics-agent/spec.md` — 26 criteria, fully specced. Moved to its own scope, post-April 2. Built last after intelligence + booking infrastructure.

### Context
- Strategy intake: `docs/p2-p3-strategy-intake.md` — Q19-Q27 (agent layer vision), Q33-Q38 (sequencing, cut decisions)
- iMessage Agent: [[imessage-agent/spec|scopes/imessage-agent/spec.md]] — SC-34 (extension points for memory injection)
- Memory architecture: `scopes/agent-intelligence/memory-architecture.md` — technical reference for data model and algorithm
- Brand voice: `scopes/imessage-agent/voice-guide.md` — rules for vote-on-behalf DM copy
