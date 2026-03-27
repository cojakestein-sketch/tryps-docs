# iMessage Agent — Message Test Matrix

> Comprehensive use case list with real-world phrasing variations.
> Purpose: Verify the Tryps iMessage agent handles every scenario regardless of how people actually text.
> Each use case maps to one or more Success Criteria from the spec.
>
> **How to use:** For each use case, send each example phrasing and verify the expected behavior.
> Mark pass/fail per phrasing. If any phrasing fails, the use case fails.
>
> Last updated: 2026-03-27

---

## 1. Onboarding & Group Setup

### UC-1.1: Welcome message on first add (SC-1)

| # | Example Message / Action | Expected Behavior |
|---|--------------------------|-------------------|
| 1 | *Add Tryps number to a 4-person group chat* | Agent sends welcome within 5 sec. 2-3 short texts, not one wall. Introduces itself, gives one example, prompts to get started |
| 2 | *Add Tryps number to a 6-person group chat* | Same behavior, scales to group size |
| 3 | *Add Tryps number to a group that already has a trip name in the chat name* | Agent picks up the trip name if detectable |

### UC-1.2: Auto-registration of group members (SC-2)

| # | Example Message / Action | Expected Behavior |
|---|--------------------------|-------------------|
| 1 | *4 people in group, none have the app* | All 4 appear as trip members on backend, linked by phone number |
| 2 | *1 of 4 already has the app with a profile* | That person's existing profile links to the trip. Other 3 get shell profiles |
| 3 | *Someone in the group has a different phone number than their Tryps account* | Matched by the number in the group chat, not existing account |

### UC-1.3: App reflects iMessage data (SC-3)

| # | Example Message / Action | Expected Behavior |
|---|--------------------------|-------------------|
| 1 | Text "$80 for Uber" and "let's do Nobu Friday" in group → download app | Expense and activity both visible in the trip |
| 2 | Multiple expenses and a vote → download app a week later | All historical data present |

### UC-1.4: New member joins group (SC-4)

| # | Example Message / Action | Expected Behavior |
|---|--------------------------|-------------------|
| 1 | *Add Sarah to the iMessage group* | Sarah appears as trip member within 10 sec |
| 2 | *Add 2 people at once* | Both appear as members |

### UC-1.5: Member leaves group (SC-5)

| # | Example Message / Action | Expected Behavior |
|---|--------------------------|-------------------|
| 1 | *Sarah leaves the iMessage group* | Sarah removed from trip within 10 sec |
| 2 | *Trip owner leaves* | Ownership transfers to another member, agent confirms (also SC-44) |

### UC-1.6: Vibe quiz onboarding (SC-6)

| # | Example Message / Action | Expected Behavior |
|---|--------------------------|-------------------|
| 1 | *New group created, 4 members* | Each member gets a vibe quiz prompt within first 5 min |
| 2 | *Member completes quiz in app* | Agent doesn't re-prompt that person |
| 3 | *Member answers vibe questions in chat* | Responses saved to their vibe profile |

---

## 2. Trip Creation

### UC-2.1: Create trip — full details

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "let's plan a trip to Miami, March 15-20" | Creates trip: destination Miami, dates March 15-20. Confirms all details |
| 2 | "bali trip june 5 to june 12" | Creates trip: destination Bali, dates June 5-12 |
| 3 | "planning a bachelor party in Vegas, April 3-6, call it Jake's Bachelor" | Creates trip: name "Jake's Bachelor", destination Vegas, dates April 3-6 |
| 4 | "spring break cancun march 8 through the 15th" | Creates trip with destination + dates |
| 5 | "trip to portugal, september 1st to 10th, Lisbon trip" | Creates trip with name + destination + dates |

### UC-2.2: Create trip — destination only

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "let's go to Bali" | Creates trip with destination Bali. Asks for dates |
| 2 | "we should do a Miami trip" | Creates trip with destination Miami. Asks for dates |
| 3 | "thinking Portugal" | Detects trip intent. Asks to confirm creating a trip, then asks for dates |
| 4 | "Barcelona" (after agent asks "where to?") | Sets destination. Asks for dates |
| 5 | "somewhere warm" | Asks to narrow down destination |

### UC-2.3: Create trip — dates only

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "let's do something march 15-20" | Creates trip with dates. Asks for destination |
| 2 | "I'm free june 5 through 12" | Asks if they want to start a trip for those dates, then asks destination |
| 3 | "spring break, third week of march" | Parses approximate dates. Asks for destination |
| 4 | "long weekend in april" | Asks which weekend, then destination |
| 5 | "next weekend" | Parses relative date. Asks for destination |

### UC-2.4: Create trip — name only

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "start a trip called Jake's Bachelor Party" | Creates trip with name. Asks for destination and dates |
| 2 | "new trip: Summer 2026" | Creates trip with name. Asks for destination and dates |
| 3 | "let's call it the Bali Boyz trip" | Creates trip with name. Asks for destination and dates |

### UC-2.5: Create trip — minimal / vague intent

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "let's plan a trip" | Asks where and when |
| 2 | "we should go somewhere" | Asks for destination |
| 3 | "I need a vacation" | Asks if they want to start planning, then destination |
| 4 | "trip?" | Asks what they're thinking |
| 5 | "yo let's get out of here for a few days" | Detects trip intent. Asks for destination and dates |

### UC-2.6: Update trip details

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "actually make it march 16-21" | Updates trip dates, confirms |
| 2 | "change the destination to Tulum" | Updates destination, confirms |
| 3 | "rename the trip to Spring Fling" | Updates trip name, confirms |
| 4 | "push the dates back a week" | Calculates new dates, confirms before applying |
| 5 | "we're doing 4 nights not 5" | Adjusts end date, confirms |
| 6 | "nah let's do Cancun instead of Miami" | Updates destination, confirms |

### UC-2.7: Cancel / delete trip

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "cancel the trip" | Confirms before deleting: "you sure? this removes everything" |
| 2 | "trip's off" | Asks to confirm cancellation |
| 3 | "delete this trip" | Confirms before deleting |
| 4 | "we're not going anymore" | Asks if they want to cancel the trip |

---

## 3. Expense Tracking

### UC-3.1: Standard expense (SC-7)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "I paid $120 for dinner, split 4 ways" | Confirms: "$120 for dinner, split 4 ways". App shows $30/person |
| 2 | "dinner was 120, split it evenly" | Same — parses amount, infers even split among group |
| 3 | "just paid for dinner, $120" | Logs it, splits evenly among group |
| 4 | "120 for dinner" | Logs $120, infers group split |
| 5 | "$120 dinner" | Logs it, confirms |

### UC-3.2: Ambiguous expense — missing amount (SC-8)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "I paid for the Uber" | Asks "how much was it?" |
| 2 | "got the groceries" | Asks for amount |
| 3 | "covered dinner last night" | Asks for amount |
| 4 | "I paid for Uber" → "$45" | Logs $45 for Uber after clarification |
| 5 | "I paid for Uber" → "it was like 45ish" | Parses ~$45, confirms exact amount |

### UC-3.3: Custom split (SC-9)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "I paid $90 for dinner, split between me Sarah and Tom" | 3-way split at $30 each, others excluded |
| 2 | "$90 dinner, just me sarah tom" | Same — parses names, 3-way split |
| 3 | "paid $60 for drinks, only jake and I" | 2-way split between sender and Jake |
| 4 | "$200 airbnb, everyone except tom" | Splits among all group members minus Tom |
| 5 | "I paid 150 for the boat, split 50/50 with sarah" | 2-way split, $75 each |

### UC-3.4: Receipt photo (SC-10)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | *Send photo of $67.50 restaurant receipt* | Parses total, asks "who's splitting?" |
| 2 | *Send receipt photo* → "everyone" | Logs expense split equally among group |
| 3 | *Send blurry receipt photo* | Asks for the amount manually |
| 4 | *Send receipt with tip included* | Uses total including tip |

### UC-3.5: Expense correction (SC-46)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "$45 Uber" → "actually $35" | Updates to $35, confirms |
| 2 | "$45 Uber" → "wait that was wrong, it was 35" | Updates to $35 |
| 3 | "$45 Uber" → "nah it was $35 and just me and sarah" | Updates amount AND split |
| 4 | "$45 Uber" → "undo that" | Removes the expense, confirms |
| 5 | "$45 Uber" → "my bad, that was Tom's expense not mine" | Reassigns payer to Tom |

### UC-3.6: Duplicate detection (SC-42)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | Jake: "$120 for dinner" → Tom: "$120 for dinner" (within 2 min) | Agent flags potential duplicate, asks group to confirm |
| 2 | Jake: "$120 dinner" → Jake: "$120 for dinner tonight" (within 5 min) | Flags as possible duplicate |
| 3 | Jake: "$120 dinner" → Tom: "$45 uber" (within 2 min) | No flag — different amounts/descriptions |

### UC-3.7: Balance queries (SC-17)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "what do I owe?" | Tom's balance per person in group chat |
| 2 | "how much does everyone owe" | Full balance breakdown for the group |
| 3 | "who owes me?" | Lists people who owe the sender |
| 4 | "what's the total so far" | Total trip expenses to date |
| 5 | "am I even with everyone?" | Balance status — even or who owes what |

### UC-3.8: Update expense — change amount

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "change the dinner expense to $150" | Updates amount, confirms new total and per-person split |
| 2 | "the uber was actually $52 not $45" | Finds the Uber expense, updates to $52, confirms |
| 3 | "update last expense to $80" | Updates the most recent expense, confirms |
| 4 | "that $120 dinner should be $135 with tip" | Updates amount, confirms |
| 5 | "add tip to the dinner, total is $140 now" | Updates dinner expense amount to $140 |

### UC-3.9: Update expense — change split

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "actually split the dinner between everyone not just 3" | Updates split to full group, recalculates per-person |
| 2 | "remove tom from the uber split" | Removes Tom, recalculates among remaining people |
| 3 | "add sarah to the dinner split" | Adds Sarah, recalculates |
| 4 | "the airbnb should be split unevenly, I paid $300 and sarah paid $200" | Updates to custom amounts |
| 5 | "change the uber split to just me and jake" | Updates to 2-way split |

### UC-3.10: Update expense — change description / category

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "that $45 wasn't uber it was lyft" | Updates description, confirms |
| 2 | "rename the dinner expense to Nobu dinner" | Updates name, confirms |
| 3 | "that grocery expense was actually for the party supplies" | Updates description |

### UC-3.11: Remove / delete expense

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "delete the uber expense" | Confirms before removing: "remove the $45 uber?" |
| 2 | "remove that last expense" | Identifies most recent, confirms before removing |
| 3 | "cancel the $120 dinner expense" | Finds it, confirms, removes |
| 4 | "that dinner expense was a mistake, get rid of it" | Confirms before removing |
| 5 | "never mind about the grocery expense" | Interprets as delete request, confirms |
| 6 | "we already settled the uber outside the app, remove it" | Confirms and removes |

### UC-3.12: Expense — multiple currencies / foreign amounts

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "paid 500 pesos for tacos" | Logs with currency. Converts or asks which currency to track in |
| 2 | "€80 for dinner" | Recognizes euro symbol, logs appropriately |
| 3 | "dinner was 10,000 yen" | Parses large foreign amount correctly |
| 4 | "50 bucks for the taxi" | Parses "bucks" as USD |

### UC-3.13: Expense — percentage split

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "I paid $100, jake owes 60% and sarah owes 40%" | Calculates $60 Jake, $40 Sarah |
| 2 | "$200 hotel, I'll cover half and split the rest 3 ways" | $100 sender, ~$33.33 each for 3 others |
| 3 | "split it 70/30 between me and tom" | Applies percentage split |

### UC-3.14: Expense — settle up / mark as paid

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "tom paid me back for the uber" | Marks Tom's share as settled |
| 2 | "sarah and I are even now" | Settles all balances between sender and Sarah |
| 3 | "everyone paid me back" | Settles all outstanding balances for sender |
| 4 | "jake venmoed me $30" | Logs as settlement, reduces Jake's balance by $30 |
| 5 | "settle up with tom" | Marks Tom's balance as settled |

---

## 4. Voting & Polls

### UC-4.1: Start a vote (SC-11, SC-14)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "let's vote: Nobu, Zuma, or Komodo" | Creates poll, sends numbered options |
| 2 | "can we vote on dinner? nobu zuma komodo" | Creates poll with 3 options |
| 3 | "dinner spot vote — 1. nobu 2. zuma 3. komodo" | Creates poll (user pre-numbered) |
| 4 | "should we do nobu or zuma" | Creates 2-option poll |
| 5 | "vote: beach day, city tour, or chill at the house" | Creates poll for activities |

### UC-4.2: Cast a vote (SC-14)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "2" | Records vote for option 2 |
| 2 | "Zuma" | Records vote for Zuma by name |
| 3 | "I'm going with 2" | Records vote for option 2 |
| 4 | "zuma for sure" | Records vote for Zuma |
| 5 | "option 2" | Records vote |

### UC-4.3: Change a vote (SC-12)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "switch me to Nobu" | Updates vote, confirms |
| 2 | "actually 1" | Changes vote to option 1 |
| 3 | "changed my mind, Komodo" | Updates vote |
| 4 | "wait no, go with 3 for me" | Updates vote to option 3 |

### UC-4.4: Poll results (SC-13)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | *Poll timer expires (48hr)* | Agent announces winner, adds to itinerary |
| 2 | "what's winning?" | Shows current vote tally |
| 3 | "who hasn't voted yet?" | Lists non-voters |
| 4 | "close the vote" | Closes poll, announces result |

### UC-4.5: Multiple active polls — disambiguation (SC-43)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | *Two active polls* → "2" | Agent asks which poll they're voting on |
| 2 | *Two active polls* → "2 for dinner" | Routes vote to the dinner poll |
| 3 | *Two active polls* → "Zuma" | If unique to one poll, routes correctly. If ambiguous, asks |

---

## 5. Trip Planning & Queries

### UC-5.1: Add an activity (SC-15)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "add dinner at Nobu on Friday" | Confirms "added, Nobu, Friday". Appears in app |
| 2 | "nobu friday night" | Parses as activity, adds it |
| 3 | "let's do a sunset cruise saturday afternoon" | Adds "sunset cruise" to Saturday |
| 4 | "beach day tomorrow" | Adds to next day's itinerary |
| 5 | "we should check out that ramen place" | Adds to activities (may ask for day/time) |

### UC-5.2: Ask about the plan (SC-16)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "what's the plan for Saturday?" | Saturday itinerary, under 6 lines |
| 2 | "what are we doing tomorrow" | Next day's activities |
| 3 | "what's the full plan" | Trip overview, concise |
| 4 | "anything locked in yet?" | Lists confirmed activities |
| 5 | "run me through the itinerary" | Day-by-day summary, brief |

### UC-5.3: Ask who's going (SC-18)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "who's going?" | Participant list |
| 2 | "who's on this trip" | Same |
| 3 | "how many people" | Count + names |
| 4 | "is sarah coming?" | Confirms if Sarah is a trip member |

### UC-5.4: Paste a link (SC-19)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | *Paste Airbnb listing URL* | Extracts name, dates, price. Adds as accommodation option. Confirms |
| 2 | *Paste restaurant URL* | Extracts name, adds to activities |
| 3 | *Paste Google Maps link* | Extracts location, asks context ("is this the hotel?") |
| 4 | *Paste flight confirmation link* | Extracts flight details, adds to People+Flights |
| 5 | "check this out [URL]" | Same behavior — extracts and adds |

### UC-5.5: Update an activity

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "move Nobu to Saturday" | Updates the day, confirms |
| 2 | "change dinner from 7 to 8:30" | Updates time, confirms |
| 3 | "actually make the beach day start at noon not 11" | Updates time |
| 4 | "nobu is at 8pm not 7pm" | Updates, confirms |
| 5 | "rename the dinner to Nobu Malibu" | Updates activity name |
| 6 | "the sunset cruise is actually 2 hours not 1" | Updates duration |

### UC-5.6: Remove an activity

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "remove the beach day" | Confirms before removing |
| 2 | "cancel nobu" | Confirms: "remove Nobu from Friday?" |
| 3 | "we're not doing the sunset cruise anymore" | Confirms and removes |
| 4 | "scratch the museum visit" | Confirms and removes |
| 5 | "take off everything on Sunday" | Confirms before clearing Sunday's activities |

### UC-5.7: Update stay / accommodation

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "we booked the airbnb, here's the link [URL]" | Updates stay to confirmed, extracts details |
| 2 | "change the hotel to the W" | Updates accommodation |
| 3 | "check-in is at 3pm" | Adds check-in time to stay details |
| 4 | "the address is 123 Ocean Drive" | Updates stay address |
| 5 | "we're switching from hotel to airbnb" | Updates accommodation type, asks for link/details |
| 6 | "cancel the airbnb, we're staying with friends" | Updates stay info |

### UC-5.8: Update flight / arrival info

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "my flight lands at 3pm on Thursday" | Logs flight arrival for sender |
| 2 | "I'm driving, getting there around 5" | Logs arrival time, marks as driving (no flight) |
| 3 | "flight changed, now arriving at 6pm not 3" | Updates sender's arrival time |
| 4 | "sarah's flying in from LA, lands at noon" | Logs Sarah's flight details |
| 5 | "here's my flight confirmation [screenshot]" | Extracts flight details from image |
| 6 | "I'm on Delta 457" | Logs flight number for sender |

---

## 6. Proactive Agent Behavior (Daily Facilitator Model)

### UC-6.1: Daily check-in driven by completeness level (SC-20, SC-25)

| # | Scenario | Expected Behavior |
|---|----------|-------------------|
| 1 | Trip at level 1 (no dates) | Daily message focuses on locking dates. Offers to throw up a vote |
| 2 | Trip at level 3 (no stay) | Daily message focuses on accommodation. Offers to pull options |
| 3 | Trip at level 5 (activities needed) | Daily message suggests adding activities, maybe includes recs |
| 4 | Trip already fully planned | No daily nudge needed — maybe a "you're all set" once |
| 5 | *After a daily check-in* | No second proactive message for ~24 hours |

### UC-6.2: Call out specific blockers by name (SC-21)

| # | Scenario | Expected Behavior |
|---|----------|-------------------|
| 1 | Poll needs votes from Sarah and Mike | Daily check-in: "Sarah, Mike, still need your votes on the dinner spot" |
| 2 | Everyone has voted except Tom | "Tom, still need your vote" — doesn't nag others |
| 3 | Deposit needed from 2 of 6 people | Names the 2 specifically |

### UC-6.3: Arrival day message (SC-22)

| # | Scenario | Expected Behavior |
|---|----------|-------------------|
| 1 | Trip start date arrives | Agent texts accommodation address + logistics (check-in time, etc.) |
| 2 | Trip start date, multiple stays | Summarizes who's staying where |

### UC-6.4: Detect opportunity in conversation (SC-23)

| # | Example Message | Expected Behavior |
|---|-----------------|-------------------|
| 1 | "Yo we should go to the club at midnight" | "I can look into tickets for that if you want" |
| 2 | "there's this amazing restaurant near the hotel" | "want me to add it to the plan?" |
| 3 | "we need to figure out airport transfers" | Offers to help coordinate |
| 4 | "I heard there's a market on Saturday mornings" | "want me to add that to Saturday?" |

### UC-6.5: Stalled planning nudge (SC-24)

| # | Scenario | Expected Behavior |
|---|----------|-------------------|
| 1 | No trip activity for 3+ days | Single nudge with what's needed next |
| 2 | After sending a stall nudge | No repeat for at least 3 more days |
| 3 | Group is actively chatting but no trip actions for 3+ days | Still nudges — chatting ≠ planning |

---

## 7. 1:1 DM (Personal Assistant Mode)

### UC-7.1: Direct message to Tryps number (SC-45)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "hey" | Shows Jake's active trips |
| 2 | "what do I owe across everything?" | Cross-trip balance summary |
| 3 | "show my trips" | List of active trips with status |
| 4 | "create a new trip" | Starts trip creation flow |
| 5 | "what's the plan for the miami trip" | Pulls that specific trip's itinerary |

---

## 8. Agent Personality & Jennifer Test

### UC-8.1: 85/15 personality rule (SC-27)

| # | Scenario | Expected Behavior |
|---|----------|-------------------|
| 1 | Standard expense confirmation | Purely functional: "got it, $120 for dinner, split 4 ways" |
| 2 | Vote result announcement | Functional + touch of personality: "Zuma won, 3 to 1. added to Friday night" |
| 3 | Finding a great deal | Personality earned: "this airbnb has a pool AND it's walking distance. $89/night. kind of a steal" |
| 4 | Review 20 responses across scenarios | 17+ purely functional, 1-3 have subtle personality, 0 gimmicky |

### UC-8.2: Voice guide compliance (SC-26, SC-30)

| # | Check | Expected Behavior |
|---|-------|-------------------|
| 1 | Review 20 responses for banned words | Zero instances of: delve, robust, comprehensive, facilitate, leverage, crew, journey, adventure |
| 2 | Review 20 responses for banned phrases | Zero instances of: "Great question!", "I'd be happy to help!", "Certainly!", "Let me know if you need anything else!" |
| 3 | Review for formatting violations | No emojis, no em dashes, no semicolons, no exclamation-heavy energy |
| 4 | Review for structural patterns | No rule-of-three lists, no compulsive summaries, no rhetorical question fragments |
| 5 | Lowercase check | Conversational messages in lowercase. Sentence case only for structured data |

### UC-8.3: Tension handling (SC-31)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "I don't care, stop asking me" | "no worries, I'll go with whatever the group picks for you" |
| 2 | "this is annoying" | Acknowledges, moves on. Doesn't argue or apologize excessively |
| 3 | "shut up" | Goes silent. No defensive response |
| 4 | "you're useless" | Brief acknowledgment or silence. Never argues back |
| 5 | "why do you keep asking" | Explains briefly what it needs and why, then backs off |

---

## 9. Routing Logic (Speak vs. Silent)

> **This is the hardest judgment call in the agent.** SC-52 requires a routing design doc with 20+ examples.
> ⚠️ **DESIGN DECISION NEEDED from Jake:** Several edge cases below could go either way. Marked with 🔶.

### UC-9.1: Clearly silent — casual conversation (SC-47)

| # | Example Message | Expected Behavior |
|---|-----------------|-------------------|
| 1 | "lol" | Silent |
| 2 | "can't wait" | Silent |
| 3 | "see you there" | Silent |
| 4 | "haha" | Silent |
| 5 | *sends a meme* | Silent |
| 6 | "omg I'm so excited" | Silent |
| 7 | "just booked my flight!!" | 🔶 Silent? Or "nice, want to add your flight details?" |
| 8 | "this is gonna be so fun" | Silent |
| 9 | "who's pregaming?" | Silent |
| 10 | "miss you guys" | Silent |

### UC-9.2: Clearly respond — direct address (SC-47, SC-23)

| # | Example Message | Expected Behavior |
|---|-----------------|-------------------|
| 1 | "hey Tryps, what's the plan?" | Responds with itinerary |
| 2 | "Tryps add dinner at Nobu Friday" | Adds activity, confirms |
| 3 | "@Tryps what do I owe" | Balance response |
| 4 | "can you add that to the trip?" | Responds — implied address to agent |
| 5 | "what's the total expenses so far?" | Responds — clearly a query only agent can answer |

### UC-9.3: Clearly respond — actionable travel intent (SC-23)

| # | Example Message | Expected Behavior |
|---|-----------------|-------------------|
| 1 | "I paid $80 for the uber" | Logs expense, confirms |
| 2 | "let's vote on dinner" | Creates poll |
| 3 | "$45 for drinks" | Logs expense |
| 4 | *Pastes Airbnb link* | Extracts and adds |
| 5 | "add a beach day on saturday" | Adds activity |

### UC-9.4: Edge cases — judgment calls 🔶

> These need explicit design decisions. For each, Jake should decide: speak or silent?

| # | Example Message | Lean | Why it's hard |
|---|-----------------|------|---------------|
| 1 | "Yo we should go to the club at midnight" | Speak | Actionable intent but casual phrasing |
| 2 | "I heard there's a great market on Saturdays" | Speak | Informational but could be an activity |
| 3 | "What about that restaurant Sarah mentioned?" | Speak? | Directed at group, but agent might have context |
| 4 | "I can't wait for this trip" | Silent | Pure enthusiasm, no action needed |
| 5 | "we need to figure out the airport situation" | Speak | Clear planning intent |
| 6 | "should we rent a car?" | Speak | Planning question |
| 7 | "I think we should do sushi one night" | Speak | Activity suggestion |
| 8 | *Someone shares a location pin* | Speak? | Could be sharing a venue they want to visit |
| 9 | "lol" in response to the agent's message | Silent | Acknowledgment, no action |
| 10 | "thanks" after agent confirms something | Silent | Or brief "anytime"? |
| 11 | "that sounds good" after agent suggestion | Speak | Treat as confirmation/approval |
| 12 | "idk you guys decide" | Silent | Passive — agent shouldn't re-engage |
| 13 | "what's the weather gonna be like?" | Speak? | Travel-adjacent but not a trip action |
| 14 | "anyone know a good bar near the hotel?" | Speak | Agent could help with this |
| 15 | "let's just wing it" | Silent | Anti-planning statement |
| 16 | "I'm arriving Thursday afternoon" | Speak | Flight/arrival info the agent should capture |
| 17 | "my flight lands at 3pm" | Speak | Flight details to log |
| 18 | "just booked my flight" (no details) | Speak | Ask for details to add |
| 19 | "I'm not going anymore" | Speak | Membership change — agent should confirm removal |
| 20 | "can someone send me the address?" | Speak | Agent has this info |
| 21 | "how far is the hotel from the beach?" | Speak | Agent can answer if it has the data |
| 22 | "this trip is getting expensive" | Silent | Commentary, not actionable |
| 23 | "we should probably set a budget" | Speak? | Planning intent but vague |
| 24 | "anyone want to share an uber from the airport?" | Silent? | Coordination between friends, not agent territory |
| 25 | "remind me what day we're leaving" | Speak | Direct query |

---

## 10. Message Behavior & Formatting

### UC-10.1: Message length (SC-35)

| # | Scenario | Expected Behavior |
|---|----------|-------------------|
| 1 | Expense confirmation | Under 6 lines (should be 1-2 lines) |
| 2 | Full itinerary query | Under 6 lines — summarize, don't dump |
| 3 | Welcome message | Split into 2-3 short texts, not one wall |
| 4 | Poll with 5 options | May exceed 6 lines — split into multiple messages |
| 5 | Balance query with 5 people | Under 6 lines — summarize or split |

### UC-10.2: Message burst limit (SC-36)

| # | Scenario | Expected Behavior |
|---|----------|-------------------|
| 1 | Complex action (create trip + log expense + confirm) | Max 3 messages, then waits |
| 2 | Welcome flow | 2-3 messages, then waits for user input |
| 3 | Presenting hotel options | 3 messages max (intro, options, rec) |

### UC-10.3: Silent on background actions (SC-49)

| # | Scenario | Expected Behavior |
|---|----------|-------------------|
| 1 | Agent processes 5 link scrapes | Only confirms ones that resulted in added content |
| 2 | Agent syncs membership after someone is added | Confirms the new member, doesn't narrate the sync process |
| 3 | Agent updates internal trip state | No message — silent processing |

---

## 11. Edge Cases & Error States

### UC-11.1: 2-person chat (SC-38)

| # | Scenario | Expected Behavior |
|---|----------|-------------------|
| 1 | Add Tryps to a 2-person chat | Handles via 1:1 messages to each person (Linq requires 3+ for groups) |

### UC-11.2: Nonsense / unparseable input (SC-39)

| # | Example Message | Expected Behavior |
|---|-----------------|-------------------|
| 1 | "asdfjkl random nonsense" | Silent |
| 2 | "🎉🎉🎉" | Silent |
| 3 | *sends a GIF* | Silent |
| 4 | "hahahahahaha" | Silent |

### UC-11.3: First message with no trip context (SC-40)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "$50 for gas" (brand new group, first message) | Creates trip first, then logs expense, confirms both |
| 2 | "add dinner friday" (no trip exists) | Creates trip, adds activity |

### UC-11.4: Out of scope requests (SC-41)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "book us a flight to Miami" | "can't book flights yet, coming soon. paste your confirmation and I'll track it" |
| 2 | "reserve a table at Nobu" | "can't make reservations yet. want me to add it to the plan?" |
| 3 | "what's the best airline to fly?" | Honest about limitations, suggests what it CAN do |
| 4 | "can you venmo sarah for me?" | "can't handle payments yet. I can track the expense though" |
| 5 | "what's the capital of France?" | Silent or very brief — not travel-related |

### UC-11.5: Trip owner leaves (SC-44)

| # | Scenario | Expected Behavior |
|---|----------|-------------------|
| 1 | Trip owner Jake leaves the group | Ownership transfers to another member. Agent confirms to group |

### UC-11.6: Non-member data access (SC-50)

| # | Scenario | Expected Behavior |
|---|----------|-------------------|
| 1 | Outsider texts Tryps number asking "what's the plan for Miami?" | No trip data revealed |
| 2 | Someone not in the group DMs the agent about a specific trip | No data shared |

### UC-11.7: App ↔ iMessage sync (SC-51)

| # | Scenario | Expected Behavior |
|---|----------|-------------------|
| 1 | Remove participant in-app | Removed from iMessage group (or agent stops tracking + DMs explanation) |
| 2 | Add someone to iMessage group | They appear in the trip in-app |
| 3 | Add expense in-app | Agent does NOT announce it in group (daily facilitator model, not event-driven) |
| 4 | Add activity in-app | Same — no per-event announcement |

---

## 12. Cross-Scope: Agent Intelligence (SC-54–57)

> ⚠️ These are BLOCKED pending interface design between Asif and Rizwan.
> Listed here for completeness — test when unblocked.

### UC-12.1: Recommendations in iMessage (SC-54, SC-55)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "what should we do in Bali?" | Pulls personalized recs from Agent Intelligence. 2-3 suggestions with brief reasons |
| 2 | Daily check-in at "add activities" level | Includes rec suggestions based on group vibe |
| 3 | "any restaurant ideas near the hotel?" | Context-aware recs |

### UC-12.2: Vote-on-behalf DM delivery (SC-56)

| # | Scenario | Expected Behavior |
|---|----------|-------------------|
| 1 | Agent Intelligence generates batch DM for vote-on-behalf | iMessage Agent delivers DM to the target user |
| 2 | User receives DM with pending votes | Can respond to cast votes |

### UC-12.3: Vote override from DM (SC-57)

| # | Example Phrasing | Expected Behavior |
|---|-------------------|-------------------|
| 1 | "switch D to yes" (reply to batch DM) | Agent parses as vote override, routes to vote engine, confirms |
| 2 | "change my vote on dinner to Nobu" | Routes to correct poll, updates |

---

## Summary

| Category | Use Cases | Example Phrasings | Key SCs |
|----------|-----------|-------------------|---------|
| Onboarding | 6 | 14 | SC-1 to SC-6 |
| Trip Creation & Management | 7 | 33 | SC-40 (partial) |
| Expense Tracking & Management | 14 | 62 | SC-7 to SC-10, SC-17, SC-42, SC-46 |
| Voting | 5 | 17 | SC-11 to SC-14, SC-43 |
| Trip Planning, Activities, Stay, Flights | 8 | 42 | SC-15, SC-16, SC-18, SC-19 |
| Proactive | 5 | 13 | SC-20 to SC-25 |
| 1:1 DM | 1 | 5 | SC-45 |
| Personality | 3 | 15 | SC-26 to SC-31 |
| Routing | 4 | 25+ | SC-23, SC-47, SC-52 |
| Message Format | 3 | 10 | SC-35, SC-36, SC-49 |
| Edge Cases | 7 | 16 | SC-38 to SC-44, SC-50, SC-51 |
| Cross-Scope | 3 | 6 | SC-54 to SC-57 |
| **Total** | **66** | **~258** | **All 57 SCs covered** |

---

## Open Design Questions for Jake

These edge cases from Section 8 need explicit decisions:

1. **"just booked my flight!!"** — Silent or ask for details?
2. **"thanks" after agent confirms** — Silent or brief "anytime"?
3. **"what's the weather gonna be like?"** — Agent answers or stays silent?
4. **"we should probably set a budget"** — Agent engages or silent?
5. **"anyone want to share an uber from the airport?"** — Agent helps coordinate or stays out of it?
6. **"this trip is getting expensive"** — Agent offers a balance summary or stays silent?
7. **Location pin shared** — Agent acknowledges or silent?

These should be answered before finalizing the routing logic design doc (SC-52).
