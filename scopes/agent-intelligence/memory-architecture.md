---
id: agent-intelligence
type: technical-reference
status: draft
blocks: [SC-13, SC-17, SC-49, SC-50]
last_updated: 2026-03-22
---

> Parent: [[agent-intelligence/objective|Agent Intelligence Objective]]

# Agent Intelligence — Memory Architecture

Technical reference for how Tryps memory works. This is the build document — Rizwan starts here.

## 1. Overview

Memory is the foundation that powers both vote-on-behalf and recommendations. It has three layers:

1. **Per-user memory** — who you are as a traveler (preferences, interaction style, behavioral patterns)
2. **Per-trip memory** — what happened on this trip (decisions, votes, activities, outcomes)
3. **Cross-trip memory** — what we've learned across all trips (destination patterns, popular activities, group dynamics)

Travel DNA is the seed. Memory is the growth. The more a user engages, the richer the memory, the better the agent.

## 2. Data Model

### 2.1 Per-User Memory (`user_memory`)

Stores preference signals linked to a user. Each signal has a source (which tier it came from), a type, and a weight.

```
user_memory
├── id (uuid, PK)
├── user_id (uuid, FK -> profiles)
├── signal_type (enum: preference, behavior, interaction_style, correction)
├── category (text: accommodation, activities, dining, nightlife, budget, travel_style, etc.)
├── key (text: e.g., "boutique_hotels", "nightclubs", "display_name")
├── value (text: e.g., "positive", "negative", "Sir Stein")
├── weight (float: 0.0 - 1.0, higher = stronger signal)
├── source (enum: vibe_quiz, trip_intent, travel_dna, dm_conversation, vote_override, activity_adoption, post_trip_favorite)
├── source_trip_id (uuid, nullable, FK -> trips — which trip generated this signal)
├── created_at (timestamptz)
├── updated_at (timestamptz)
```

**Weight rules:**
- Vibe quiz signals: 0.3 (lightest — broad, explicit)
- Trip intent (NL): 0.4 (slightly more specific)
- Travel DNA: 0.5 (deeper explicit preferences)
- DM conversation: 0.6 (explicit and specific)
- Vote override (correction): 0.8 (strong signal — user actively corrected the agent)
- Post-trip favorite: 0.9 (strongest — validated by actual experience)
- Activity adoption: 0.5 (medium — user added it, but didn't necessarily love it)

**Compounding:** When the same signal appears from multiple sources, weights combine (capped at 1.0). Example: vibe quiz says "beach" (0.3) + vote override confirms "beach" (0.8) = effective weight 1.0.

### 2.2 Per-Trip Memory (`trip_memory`)

Stores what happened on a specific trip.

```
trip_memory
├── id (uuid, PK)
├── trip_id (uuid, FK -> trips)
├── event_type (enum: vote_cast, vote_override, activity_added, activity_removed, expense_logged, recommendation_adopted, recommendation_ignored, favorite_marked)
├── category (text: same categories as user_memory)
├── details (jsonb: event-specific data)
├── user_id (uuid, FK -> profiles — who did this)
├── created_at (timestamptz)
```

**What gets stored:**
- Every vote cast (including inferred votes and overrides)
- Every activity added or removed (including whether it was a recommendation)
- Every post-trip favorite selection
- Group vibe quiz aggregate results
- Not stored: raw messages, expense amounts, personal data unrelated to preferences

### 2.3 Cross-Trip Memory (`destination_patterns`)

Aggregated, anonymized patterns across all trips to a destination.

```
destination_patterns
├── id (uuid, PK)
├── destination (text: city or region)
├── activity_id (uuid, FK -> activities)
├── adoption_count (int: how many groups added this activity)
├── favorite_count (int: how many times favorited post-trip)
├── total_groups (int: how many groups visited this destination)
├── adoption_rate (float: adoption_count / total_groups)
├── favorite_rate (float: favorite_count / adoption_count)
├── last_updated (timestamptz)
```

This table is rebuilt periodically (daily or on-demand) from trip_memory data. It's a materialized view, not a primary data source.

## 3. NLP Extraction Pipeline (DESIGN DECISION — SC-57)

⚠️ **This section is a placeholder. The approach must be designed and documented before implementation.**

Free-text messages (Tier 2 trip intents and Tier 4 DM conversations) must be converted into structured memory signals. This is the core pipeline for half of Agent Intelligence.

**The problem:** A user texts "I want a chill beach trip with good food and no hiking." This needs to become:
- `preference(beach, positive, 0.4, trip_intent)`
- `preference(food, positive, 0.4, trip_intent)`
- `preference(hiking, negative, 0.4, trip_intent)`

**Options to evaluate:**

| Approach | Pros | Cons |
|----------|------|------|
| **(a) Claude function calling with signal schema** | Structured output, reliable, uses existing Claude integration | Cost per message, latency, requires well-defined schema |
| **(b) Dedicated extraction prompt per message** | Flexible, can handle nuance | Needs careful prompt engineering, may produce inconsistent schemas |
| **(c) Batch extraction agent (periodic)** | Lower cost, can process in bulk | Delay between message and memory, more complex architecture |

**What needs to be decided:**
1. Which approach (or hybrid)?
2. What is the signal schema the extraction targets?
3. How are conflicting signals from the same message handled?
4. What's the latency budget? (Does memory need to be updated before the next agent response, or can it lag?)
5. How are ambiguous messages handled? (e.g., "I like the beach" — is this a preference or a casual statement?)

**Example inputs/outputs needed:** At least 10 message types with expected structured signal output, covering: trip intents, explicit preferences, implicit preferences, corrections/contradictions, interaction style requests, and ambiguous messages.

**Rizwan to design this before starting Tier 2/4 memory implementation.**

## 4. Signal Types

### Explicit Signals (user tells us directly)
| Signal | Source | Weight | Example |
|--------|--------|--------|---------|
| Vibe quiz answer | vibe_quiz | 0.3 | "I prefer beaches" |
| Trip intent | trip_intent | 0.4 | "chill trip, good food, no hiking" |
| Travel DNA answer | travel_dna | 0.5 | "boutique hotels over chains" |
| DM preference | dm_conversation | 0.6 | "always call me Sir Stein" |

### Implicit Signals (we infer from behavior)
| Signal | Source | Weight | Example |
|--------|--------|--------|---------|
| Activity adoption | activity_adoption | 0.5 | User added "surfing" recommendation |
| Post-trip favorite | post_trip_favorite | 0.9 | User marked "sunset boat tour" top 3 |
| Vote override | vote_override | 0.8 | User changed inferred "yes" on nightclub to "no" |

### Signal Decay

Signals do not decay by default — a preference stated 6 months ago is still valid. However:
- If a user explicitly contradicts a prior signal (DM: "actually I like nightclubs now"), the old signal is superseded (weight set to 0).
- Vote overrides in the same category compound (3 nightlife overrides > 1 nightlife override).
- Recency breaks ties: if two signals have equal weight and conflict, the newer one wins.

## 5. Engagement Tiers

| Tier | What the user does | What we know | Memory quality |
|------|-------------------|--------------|----------------|
| 0 | Nothing — barely interacts | Almost nothing (just phone number and group membership) | Minimal — agent guesses |
| 1 | Answers 6-10 vibe quiz questions | Broad preferences (beach/mountain, adventure/relaxation, budget range) | Basic — enough for coarse recommendations and weak vote inference |
| 2 | Communicates trip intent in natural language | Specific trip desires + broad preferences | Good — NLP extracts structured signals |
| 3 | Answers full Travel DNA quiz | Deep preference profile across 15+ dimensions | Strong — rich enough for reliable vote inference |
| 4 | Ongoing 1:1 DMs with agent | Explicit preferences + interaction style + evolving tastes | Best — agent feels like it truly knows you |

The agent works at every tier. It just gets better.

## 6. Integration Points

### 6.1 System Prompt Injection (iMessage Agent SC-34)

Memory data is serialized into the iMessage agent's system prompt at the `[USER CONTEXT]` extension point. Format:

```
[USER CONTEXT: Jake]
- Preferences: beaches (strong), outdoor activities (strong), nightlife (negative), boutique hotels (strong)
- Interaction style: prefers to be called "Sir Stein"
- Trip history: 3 past trips, favorites were sunset tours and local food markets
- Vote patterns: consistently votes for outdoor/adventure, consistently votes against nightlife
- Adoption rate: added 65% of recommended activities (above average)
```

This section is regenerated on every system prompt build — it always reflects current memory state.

**Size constraint:** User context must stay under 500 tokens to avoid bloating the system prompt. If a user has extensive memory, summarize and prioritize by weight.

### 6.2 Vote-on-Behalf Engine

When polls open, the vote engine:

1. Loads user's memory signals (all sources, all weights)
2. For each poll option, calculates a preference score:
   - Match option tags against user preference signals
   - Weight by signal strength
   - Apply cross-trip destination patterns as a secondary signal
3. Infers the top-scoring option as the vote
4. Assigns internal confidence: high (score > 0.7), medium (0.4-0.7), low (< 0.4)
5. Casts the vote and queues the batch DM

**Batch DM timing:** When polls open (or new polls are detected), the engine waits 5 minutes to batch any simultaneous polls, then sends a single DM.

### 6.3 Recommendations Engine

Recommendations combine three ranking components:

**Component 1: Content-Based Filtering (tag matching)**
- Match activity category tags against the group's aggregate vibe quiz answers
- Weight: 40% of final score
- Example: group vibe is "adventure" → surfing (adventure tag) scores high

**Component 2: Collaborative Filtering (what similar groups did)**
- Find groups with similar vibe profiles who visited the same destination
- Recommend activities those groups adopted and favorited
- Weight: 30% of final score
- Example: 8/10 similar adventure groups in Bali added "volcano hike" → high score

**Component 3: Social Graph (what friends did)**
- Find activities created or adopted by the user's direct friends at this destination
- Apply friend-of-friend as a weaker signal
- Weight: 30% of final score
- Example: Quinn (direct friend) created "hidden rooftop bar" in Barcelona → high score

**Final ranking:** `score = (0.4 * content_score) + (0.3 * collaborative_score) + (0.3 * social_score)`

Activities below a minimum threshold (score < 0.2) are excluded. Activities the group has already added or voted down are filtered out.

**Feedback loop:**
```
Vibe quiz answers
      ↓
Filter & rank activities (content + collaborative + social)
      ↓
Surface on Activities tab ("Suggested for your group")
      ↓
Track adoption (did they add it?)
      ↓
Track post-trip favorites (was it top 3?)
      ↓
Feed adoption + favorites back into:
  - User memory (per-user signals)
  - Destination patterns (cross-trip aggregation)
  - Collaborative filtering model (what similar groups liked)
      ↓
Better rankings next time
```

## 7. Activity Database Architecture

### Two-Tier Activity Model

**Generic Templates (`activity_templates`)**

Activities that apply to many locations based on rules.

```
activity_templates
├── id (uuid, PK)
├── name (text: "Beach Day", "Museum Visit", "Go Shopping")
├── description (text)
├── category (text: beaches, museums, shopping, nightlife, etc.)
├── applicability_rule (jsonb: e.g., {"requires": "coastal"}, {"requires": "has_museums"}, {"global": true})
├── tags (text[]: for content-based filtering)
├── created_at (timestamptz)
```

**Specific Activities (`activities`)**

Activities tied to a specific location.

```
activities
├── id (uuid, PK)
├── template_id (uuid, nullable, FK -> activity_templates — if this is an instance of a template)
├── name (text: "Bondi Beach", "Louvre Museum")
├── description (text)
├── category (text)
├── location_city (text)
├── location_country (text)
├── location_coordinates (point, nullable)
├── tags (text[])
├── source (enum: seed_scrape, user_generated, friend_activity)
├── source_url (text, nullable)
├── source_attribution (text, nullable: "Reddit r/Barcelona", "Created by Quinn")
├── created_by_user_id (uuid, nullable, FK -> profiles)
├── adoption_count (int, default 0)
├── favorite_count (int, default 0)
├── created_at (timestamptz)
├── updated_at (timestamptz)
```

### How Templates and Specifics Interact

When a user creates a trip to Miami:
1. Find all generic templates whose applicability rules match Miami (coastal → beach day, has_nightlife → go clubbing, global → go shopping)
2. Find all specific activities with location_city = "Miami"
3. Find all friend-generated activities for Miami
4. Rank all of them using the recommendation algorithm
5. Surface the top 5-8 on the Activities tab

### Seed Data Strategy

**Phase 1 (April 2):** Scrape a baseline dataset:
- Every major museum globally (target: all museums with Wikipedia articles)
- Top activities per popular destination from Reddit travel subreddits (r/travel, r/solotravel, r/[city] subreddits)
- Category templates that apply everywhere (beach day, shopping, dining out, nightlife, hiking, cultural tour, local market, cooking class, spa day, walking tour)

**Phase 2 (post-April 2):** Expand with:
- Travel blog scraping (broader coverage)
- Review site integration (TripAdvisor, Google Places)
- User-generated activities (highest priority source once users start creating)

## 8. Social Graph Model

The social graph powers recommendation ranking (SC-46-48). It comes from two sources:

**Source 1: Shared trip history.** Anyone who's been on a Tryps trip with you is a connection. Stored implicitly — derived from trip membership data. No new table needed; query trips for shared participants.

**Source 2: Contact book sync (with permission).** If a user syncs their contacts and another contact is also a Tryps user, they're connected. Requires a contact sync feature (may be post-April 2 if not already built).

**Ranking tiers:**
1. **Travel companions** (shared trip history) — highest weight in recommendations
2. **Contacts** (phone book match, both are Tryps users) — medium weight
3. **General Tryps users** (no connection) — lowest weight, still above seed data

**Framing for users:** "Other Tryps users loved this" or "people who traveled to X also did Y." Not "your friend Quinn did this" unless Quinn is a direct travel companion.

## 9. Privacy Model

- Per-user memory is scoped to the user's ID. RLS policies enforce that users can only read/write their own memory.
- Cross-trip patterns are anonymized — they show activity popularity, not which users did what.
- Memory screen shows users exactly what the agent knows about them. No hidden data.
- Raw conversation text is never stored — only structured signals extracted via NLP.
- Users can correct or remove individual memory signals from the memory screen.
- Memory is not shared with third parties. It exists solely to improve the user's Tryps experience.

## 10. Future Extensions (Post-April 2)

- **Location intelligence:** cross-trip patterns enriched with seasonal data (Barcelona in summer vs winter)
- **Group chemistry memory:** how specific friend combinations interact (this group always picks adventure, that group always picks relaxation)
- **Role cards integration:** formal engagement roles (Planner, Down for Whatever) replace informal tier detection
- **Logistics Agent integration:** memory feeds autonomous booking decisions
- **Claude Connector integration:** memory available to Claude users via MCP tools
- **Memory export:** users can download their travel profile data
