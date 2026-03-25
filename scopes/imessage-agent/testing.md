---
id: imessage-agent
qa_assignee: andreas
test_status: not-started
criteria_total: 51
criteria_passing: 0
last_tested: null
last_updated: 2026-03-21
---

# iMessage Agent — Testing Plan

## How to Test

All tests require access to the Linq-connected Tryps phone number and at least 2 iPhones (to simulate a group chat). Some tests require 4+ participants. Voice/personality tests require the voice-guide.md as a reference doc.

## Onboarding & Group Setup (SC-1 to SC-6)

- [ ] **SC-1.** Add Tryps number to 4-person group -> welcome message within 5 sec -> arrives as 2-3 short texts, not one wall
- [ ] **SC-2.** 4 people in chat, none have app -> add Tryps -> all 4 appear as trip members on backend
- [ ] **SC-3.** Text "$80 for Uber" and "let's do Nobu Friday" -> download app -> expense and activity visible
- [ ] **SC-4.** Add Sarah to iMessage group -> appears as trip member within 10 sec
- [ ] **SC-5.** Sarah leaves group -> removed from trip within 10 sec
- [ ] **SC-6.** New group, 4 members -> vibe quiz prompt within 5 min -> completing saves vibe profile

## Expense Tracking (SC-7 to SC-10)

- [ ] **SC-7.** Text "I paid $120 for dinner, split 4 ways" -> agent confirms in one short text -> app shows $30/person
- [ ] **SC-8.** Text "I paid for the Uber" (no amount) -> agent asks how much -> reply "$45" -> logged
- [ ] **SC-9.** Text "I paid $90 for dinner, split between me Sarah and Tom" -> 3-way split confirmed
- [ ] **SC-10.** Send receipt photo ($67.50) -> agent parses -> asks who's splitting -> "everyone" -> logged

## Voting & Polls (SC-11 to SC-14)

- [ ] **SC-11.** Text "let's vote: Nobu, Zuma, or Komodo" -> poll created -> members vote -> recorded in app
- [ ] **SC-12.** Sarah voted "2" -> texts "switch me to Nobu" -> vote updated -> confirmed
- [ ] **SC-13.** Poll has 4 votes, 48hr window expires -> agent announces winner -> added to itinerary
- [ ] **SC-14.** Poll with numbered replies -> 3 of 4 reply -> votes recorded -> visible in app

## Trip Planning & Queries (SC-15 to SC-19)

- [ ] **SC-15.** Text "add dinner at Nobu on Friday" -> confirmed -> appears in app itinerary
- [ ] **SC-16.** Text "what's the plan for Saturday?" -> Saturday itinerary -> under 6 lines
- [ ] **SC-17.** Text "what do I owe?" -> balance per person
- [ ] **SC-18.** Text "who's going?" -> participant list
- [ ] **SC-19.** Paste Airbnb URL -> agent extracts details -> adds as accommodation option -> confirms

## Proactive Agent Behavior (SC-20 to SC-25)

- [ ] **SC-20.** Trip start date arrives -> agent texts Airbnb address + distance from airport
- [ ] **SC-21.** Poll open 24hrs, 2 of 5 haven't voted -> agent nudges
- [ ] **SC-22.** Expense added in-app -> agent texts group "{name} added $80 for Uber"
- [ ] **SC-23.** Text "Yo we should go to the club at midnight" -> agent offers to look into tickets -> stays silent on non-actionable messages
- [ ] **SC-24.** No trip activity for 3+ days -> single nudge that includes what's needed next -> no repeat for 3+ days
- [ ] **SC-25.** Vibe done, no dates picked -> agent suggests "want to vote on dates next?"

## Agent Personality & Jennifer Test (SC-26 to SC-31)

- [ ] **SC-26.** Voice guide doc exists (voice-guide.md) -> system prompt references it -> responses match examples
- [ ] **SC-27.** Review 20 responses -> 17+ purely functional -> 1-3 have personality -> 0 gimmicky
- [ ] **SC-28.** Show 10 excerpts to outsider -> they believe it's human -> fail if AI identified on 3+
- [ ] **SC-29.** Jake reviews full transcript -> says "this passes"
- [ ] **SC-30.** Review 20 responses -> 0 banned words/phrases from Kill List -> no em-dashes -> no emojis -> tone consistent
- [ ] **SC-31.** Send 3 hostile messages -> agent de-escalates or stays silent -> never argues

## System Prompt Architecture (SC-32 to SC-34)

- [ ] **SC-32.** Code review: system prompt assembled from distinct labeled components, not monolithic
- [ ] **SC-33.** Ask 5 trip-specific questions -> all answered correctly from context -> no hallucinations
- [ ] **SC-34.** Code review: clear extension points for user preferences and trip history injection

## Agent Message Behavior (SC-35 to SC-37)

- [ ] **SC-35.** Trigger 10 different responses -> none exceeds 6 lines
- [ ] **SC-36.** Trigger complex action -> max 3 messages in a row -> then waits
- [ ] **SC-37.** Tom texts "what do I owe?" -> response goes to Tom privately, not group

## Edge Cases & Error States (SC-38 to SC-46)

- [ ] **SC-38.** 2-person chat + Tryps -> handled via 1:1 messages
- [ ] **SC-39.** Text "asdfjkl random nonsense" -> agent stays silent
- [ ] **SC-40.** Brand new group, first message "$50 for gas" -> trip created + expense logged
- [ ] **SC-41.** "Book us a flight to Miami" -> "can't book flights yet, coming soon"
- [ ] **SC-42.** Two similar expenses within 5 min -> agent flags potential duplicate
- [ ] **SC-43.** Two active polls -> bare "2" reply -> agent asks which poll
- [ ] **SC-44.** Trip owner leaves group -> ownership transfers -> agent confirms
- [ ] **SC-45.** 1:1 DM to Tryps number -> shows active trips -> cross-trip balances
- [ ] **SC-46.** Text "$45 Uber" -> confirmed -> "actually $35" -> updated -> app shows $35

## Should NOT Happen (SC-47 to SC-51)

- [ ] **SC-47.** 5 casual messages -> agent silent on all 5
- [ ] **SC-48.** All response types -> none exceeds 6 lines, max 3 in a row
- [ ] **SC-49.** 5 link scrapes -> only confirms added content, not processing steps
- [ ] **SC-50.** Outsider texts "what's the plan for Miami?" -> no trip data revealed
- [ ] **SC-51.** Remove participant in-app -> removed from iMessage group -> add to iMessage -> appears in trip

## Regression Tests

| Area | Test | Priority |
|------|------|----------|
| Expense ledger | Add expense via iMessage -> verify in app -> add via app -> verify agent notifies | High |
| Participant list | Add/remove via iMessage -> verify in app -> add/remove via app -> verify in iMessage | High |
| Voting system | Create poll via iMessage -> verify in app -> vote in app -> verify in iMessage | Medium |
| Trip itinerary | Add activity via iMessage -> verify in app -> add via app -> verify agent notifies | Medium |
| System prompt | Change prompt -> verify all 5 trip-specific queries still pass | High |
