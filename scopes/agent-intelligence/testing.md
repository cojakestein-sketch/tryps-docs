---
id: agent-intelligence
qa_assignee: andreas
test_status: not-started
criteria_total: 56
criteria_passing: 0
last_tested: null
last_updated: 2026-03-22
---

# Agent Intelligence — Testing Plan

## How to Test

Memory and vote-on-behalf tests require multiple user accounts, completed vibe quizzes, and at least 2 trips with voting history. Recommendations tests require the activity database to be seeded. Some tests require cross-trip data (3+ completed trips). All memory persistence tests require closing and reopening the app or switching between iMessage and the app.

## Memory Architecture (SC-1 to SC-17)

- [ ] **SC-1.** Query per-user memory table for a user with vibe quiz + 3 poll votes -> structured records exist for quiz answers and vote history
- [ ] **SC-2.** Query per-trip memory table for a completed trip -> records for decisions, activities, votes, and post-trip favorites exist
- [ ] **SC-3.** 5 groups complete Barcelona trips -> query cross-trip patterns -> aggregated activity popularity data exists
- [ ] **SC-4.** User completes vibe quiz + votes -> closes app -> reopens -> recommendations still reflect prior data
- [ ] **SC-5.** User tells agent in iMessage "I hate nightclubs" -> open app -> recommendations exclude nightlife
- [ ] **SC-6.** User completes vibe quiz ("beach", "relaxed", "mid-budget") -> memory table contains signals with source "vibe_quiz"
- [ ] **SC-7.** User texts "chill beach trip with good food and no hiking" -> memory table contains positive(beach, food), negative(hiking)
- [ ] **SC-8.** User completes both vibe quiz and Travel DNA -> memory has both signal sets -> Travel DNA weighted higher on overlap
- [ ] **SC-9.** User texts agent "always call me Sir Stein, I prefer boutique hotels" -> memory contains display_preference and accommodation_preference
- [ ] **SC-10.** Agent infers "yes" on nightclub -> user overrides to "no" -> next trip agent infers "no" on nightclubs
- [ ] **SC-11.** Agent recommends 5 activities -> user adds 3 -> next trip similar types rank higher
- [ ] **SC-12.** User marks "sunset boat tour" as top-3 favorite -> next trip water activities rank higher
- [ ] **SC-13.** User has 10+ memory signals -> iMessage agent's system prompt includes [USER CONTEXT] section populated from memory
- [ ] **SC-14.** User A has "hates nightclubs" -> log in as User B -> User A's signal does not appear in User B's data
- [ ] **SC-15.** Navigate to agent memory screen (behind Travel DNA) -> shows preferences, learned behaviors, trip history summary
- [ ] **SC-16.** Tier 1 and Tier 4 users both go to Barcelona -> Tier 4 gets more specific/personalized recommendations
- [ ] **SC-17.** memory-architecture.md exists, covers all three memory layers, Rizwan confirms buildable

## Vote-on-Behalf (SC-18 to SC-32)

- [ ] **SC-18.** Trip has 3 open polls -> agent casts inferred votes on all 3 -> votes appear in poll results
- [ ] **SC-19.** User has vibe quiz only (Tier 1) -> poll: "beach day vs museum day" -> agent infers beach day -> reasonable given quiz
- [ ] **SC-20.** 6 activities on voting block -> agent sends ONE batch DM with all picks and reasoning -> exactly 1 message received
- [ ] **SC-21.** User receives batch DM -> replies "switch D to yes" -> vote updated -> confirmed; OR taps deep link -> app opens to vote review
- [ ] **SC-22.** Agent casts votes + sends DM -> user doesn't respond -> 48hr deadline passes -> inferred votes counted in final tally
- [ ] **SC-23.** Agent inferred "yes" on A -> user texts "change A to no" 30 min before deadline -> vote updated -> confirmed
- [ ] **SC-24.** User overrides 3 nightlife votes across 2 trips -> trip 3 agent infers "no" on nightlife without being told
- [ ] **SC-25.** New user joins trip -> completes vibe quiz -> first poll opens -> agent votes without user having enabled anything
- [ ] **SC-26.** Destination poll (beach town, ski resort, city break) -> user's vibe says "beach" -> agent infers beach town
- [ ] **SC-27.** Date poll with 3 options -> agent infers based on known constraints or no strong preference -> vote cast
- [ ] **SC-28.** Activity poll (surfing, museum, cooking class) -> memory has adventure + water signals -> agent infers surfing
- [ ] **SC-29.** Accommodation poll (hostel, boutique, resort) -> memory has "boutique" preference -> agent infers boutique
- [ ] **SC-30.** Agent infers votes -> confidence scores stored in database -> no confidence shown in DM or app
- [ ] **SC-31.** User has all signal types -> change one signal -> inference changes -> all signals contribute
- [ ] **SC-32.** Trip 1: 5/8 overrides -> Trip 2: 2/8 -> Trip 3: 0-1/8 -> trending toward fewer corrections

## Recommendations Engine (SC-33 to SC-50)

- [ ] **SC-33.** Query activity database -> activities across 50+ destinations, all continents -> total count > 1,000
- [ ] **SC-34.** Query activities -> results include generic templates (broad applicability) AND specific activities (location-tied with coordinates)
- [ ] **SC-35.** "Beach day" template (coastal rule) -> Miami trip shows it -> Denver trip does not
- [ ] **SC-36.** Query Barcelona activities -> each has name, description, category, source, source URL
- [ ] **SC-37.** Query categories -> museums, beaches, shopping, nightlife, dining, adventure, cultural, relaxation, outdoor, tours, entertainment all exist
- [ ] **SC-38.** Activity source attribution -> includes Reddit, travel blogs, review sites -> no single source > 50%
- [ ] **SC-39.** Query museums -> results span all continents -> NYC/London/Paris/Tokyo/Mexico City each have 10+ museums
- [ ] **SC-40.** 4-person group (3 adventure, 1 relaxation) -> Costa Rica recs prioritize adventure over relaxation
- [ ] **SC-41.** Open trip -> Activities tab -> "Suggested for your group" section shows 5-8 ranked cards with name, reason, add button
- [ ] **SC-42.** Group A (adventure) and Group B (relaxation) both go to Bali -> top 5 lists differ significantly
- [ ] **SC-43.** Agent recommends 8 activities -> user adds 3 -> adoption events stored -> rate trackable
- [ ] **SC-44.** User favorites "sunset boat tour" post-trip -> system checks if it was a Tryps recommendation -> quality signal stored if yes
- [ ] **SC-45.** 100 Barcelona groups -> high-adoption activities rank higher for new groups -> never-adopted rank lower
- [ ] **SC-46.** Group A creates "Hidden rooftop bar" in Barcelona -> Group B (friends of A) goes to Barcelona -> bar appears in recs
- [ ] **SC-47.** Friend Quinn's "secret tapas spot" ranks above seed data "La Boqueria Market" in recommendations
- [ ] **SC-48.** Ranking: Quinn's activity (direct friend) > Marcus's activity (friend-of-friend) > seed data
- [ ] **SC-49.** Architecture review: content-based + collaborative filtering components both present with documented weights
- [ ] **SC-50.** memory-architecture.md has recommendations section with inputs, ranking logic, weights, feedback loop

## Should NOT Happen (SC-51 to SC-56)

- [ ] **SC-51.** 3 polls open -> votes cast -> batch DM sent within 1 minute -> DM always sent (retries on failure)
- [ ] **SC-52.** User A has "hates nightclubs" -> User B sees no reference to User A's preference anywhere
- [ ] **SC-53.** User manually votes "yes" on A -> agent's inference was "no" -> user's explicit "yes" stands unchanged
- [ ] **SC-54.** Group voted down "nightclub crawl" -> recommendations tab does not show it for remainder of trip
- [ ] **SC-55.** User has 50+ iMessage interactions -> memory table has no raw message text -> only structured signals
- [ ] **SC-56.** 8 polls open -> user receives exactly 1 DM covering all 8 -> not 8 separate DMs

## Regression Tests

| Area | Test | Priority |
|------|------|----------|
| Voting system | Cast inferred vote -> verify in poll results -> override via DM -> verify update in app | High |
| Activity feed | Add recommended activity -> verify in trip's Activities tab -> verify adoption signal in memory | Medium |
| System prompt | Inject memory -> verify agent responses reflect user preferences -> change memory -> verify agent updates | High |
| Travel DNA | Complete vibe quiz -> verify memory seed -> complete full DNA -> verify memory extension -> quiz still works | Medium |
| Cross-channel | Set preference in iMessage -> verify in app -> set preference in app -> verify in iMessage | High |
| User isolation | Create 2 users with opposite preferences -> verify recommendations differ -> verify no data leakage | High |
