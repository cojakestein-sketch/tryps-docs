# P2/P3 Strategy Intake

**Purpose:** Before defining scopes, define the vision. Once every question below is answered, we have enough signal to decide which scopes exist, which merge, and which die. Same format as the brand intake — vibe first, structure later.

**How to use:** Jake dictates answers stream-of-consciousness. Claude structures and probes. After this + Asif's current-state answers, we align vision to scopes.

**Priority Key:**
- **[MUST]** = Must answer before scopes can be defined
- **[REFINE]** = Sharpens the work but doesn't block

---

## 1. The Big Picture

These answers establish what P2/P3 IS — the narrative arc from "the app works" to "the agent books your trip."

### The Story

1. **Right now, Tryps does [X]. After P2/P3, Tryps does [Y]. Describe X and Y in plain English.**
   What this decides: Whether P2/P3 is an incremental upgrade or a phase shift
   Priority: **[MUST]**

   > **ANSWERED:** Right now, Tryps lets users interact with an agent in iMessage that funnels them back to the app for any decisions. After P2/P3, the Tryps agent in iMessage actually feels like your own travel agent — it can book flights, source and book Airbnbs, book hotels, book activities with tickets. Anything a travel agent would do, Tryps can now do, directly from iMessage.

2. **What's the single moment in the P2/P3 future that makes someone say "holy shit" about Tryps?**
   Think about the brand intake — the trip card and iMessage agent were the two aha moments. What's the P2/P3 equivalent?
   Priority: **[MUST]**

   > **ANSWERED:** You text your friends AJ and Shane that you're coming and you should all go to Vegas next month. They say "I'm down." You say "Okay Tryps, get us all flights." Tryps already knows AJ and Shane because they're users — it knows they're from Denver and you're from New York because it knows home airports. It recommends flights for everyone that land within 90 minutes of each other and says "Do you all want to book?" Everyone says yes. Tryps books it. Flights appear in everyone's flight apps. That's the holy shit moment.

3. **If you could only ship ONE thing from all of P2/P3, what would it be?**
   Not which scope — which capability. What's the thing that changes the game?
   Priority: **[MUST]**

   > **ANSWERED:** The ability to book flights and Airbnbs directly with just natural language.

4. **How does P2/P3 change the way someone describes Tryps to a friend?**
   Today: "It's like Partiful but for trips." After P2/P3: "It's like ________."
   Priority: **[MUST]**

   > **ANSWERED:** "It's like having a travel agent in your iMessage — your entire group gets a travel agent literally for free."

---

## 2. The iMessage Agent

Linq is already in testing. These questions are about where it's GOING, not where it is.

### Feel

5. **When someone adds the Tryps agent to their group chat, what should that first 60 seconds feel like?**
   Not what it does — how it FEELS. Exciting? Calm? Funny? Like adding a friend vs. adding a bot?
   Priority: **[MUST]**

   > **ANSWERED:** People immediately get it. Right off the bat: "Oh, this is an agent that's gonna book the trip on my behalf." Two things need to click instantly: (1) There's a visualization behind it — you can download the app and the app shows everything the agent is doing, and those things are connected. That needs to be really obvious. (2) All they need to do is communicate the vibe they want for the trip. If they did nothing else but answer the ten vibe questions, they'd be fine. The feeling is: "Oh I get it — Jake is texting me this because he wants to go on a trip with me and this agent is just going to handle it for me."

6. **The agent is in the group chat for a week. What does it feel like to have it there? Is it always present or does it disappear until needed?**
   Priority: **[MUST]**

   > **ANSWERED:** Only present when relevant. Ideally after a week, you forget the agent is even in the chat. It disappears until there's a moment — like someone says "Yo we should go to the club at midnight." Then the agent surfaces: "Hey, I can source tickets for you — they're going for $100 each. Want me to just book them?" And then it does it. The rest of the time, it's invisible.

7. **What's the agent's personality? Is it the same as the Tryps brand voice (warm, casual, group chat energy) or something different?**
   Priority: **[MUST]**

   > **ANSWERED:** Matches the brand voice. Warm, casual, inviting. It's in the group chat and it's helpful. That's it.

8. **What should the agent NEVER do in the group chat? What would make someone say "this is annoying, remove it"?**
   Priority: **[MUST]**

   > **ANSWERED:** Never spam the group chat. Sending a bunch of messages at once — no. Super long messages — no. Error messages or random code — absolutely not. The Turing test is: if you told your grandmother this was a human travel agent named Jennifer, she would 1000% believe it. If grandma can't tell it's AI, we win. Anything that breaks that illusion is a failure.

### Ambition

9. **Where does the iMessage agent end and the app begin? What lives in chat vs. what pulls you into the app?**
   e.g., Can you plan an entire trip without ever opening the app? Or is the chat a funnel into the app?
   Priority: **[MUST]**

   > **ANSWERED:** Both. You can plan the entire trip without ever opening the app. For people who don't want to be bothered, they never need to install Tryps — they can still go on the trip successfully through iMessage alone. But the chat is also a funnel into the app for people who love the visual. They see the visual and want more. It's not either/or — it's two tiers of engagement.

10. **Is the iMessage agent the PRIMARY way people use Tryps, or a secondary channel that feeds the app?**
    This is a huge strategic call. It shapes everything.
    Priority: **[MUST]**

    > **ANSWERED:** iMessage is the primary way people get introduced to Tryps. The flow: someone gets added to a group chat where the Tryps agent is already involved → they experience it → they download the app because they want the visual layer. iMessage is the acquisition channel. The app is the retention/power-user layer.

---

## 3. Payments & Booking

These questions decide what "Tryps handles money" means — which could be one scope or three depending on the answers.

### Feel

11. **What does paying for something through Tryps feel like? Walk me through the moment.**
    Not the technical flow — the emotional experience. Is it like Apple Pay (tap and done)? Like Venmo (social and visible)? Like a concierge (someone handles it for you)?
    Priority: **[MUST]**

    > **ANSWERED:** All three — Apple Pay, Venmo, concierge — somehow rolled into one. The feeling is: somebody's handling this for you. But there's a trust ramp. First time: nobody's going to believe a concierge can just book for them. So the first payment is explicit — agent says "Hey it's $800 to book this flight, can you confirm?" User pays via Apple Pay/Apple Cash directly in iMessage, or clicks a Stripe link and enters card details. First payment gets the user set up: we capture their card and suggest we remember it for next time. After that, subsequent payments can be progressively more concierge-like because we already have the card on file.

12. **When the group needs to pay for something (hotel, flights, dinner), who pays? One person? Everyone? Tryps?**
    This is a product philosophy question, not a technical one.
    Priority: **[MUST]**

    > **ANSWERED:** Default: individuals pay for their own stuff individually (flights especially). But for shared things like hotels/Airbnbs, one person takes the onus — they're the "owner" who pays, and everyone else owes them. That gets auto-logged as an expense. There's also always the option for one person to pay on behalf of the whole group and log it as a group expense automatically. Future state could involve moving cash/credits around, but for now it's: (1) pay for yourself, or (2) one person pays for the group and Tryps tracks who owes what.

13. **How visible is money in the Tryps experience? Is it front-and-center (prices everywhere, budget tracking) or hidden until needed (the agent handles it, you barely notice)?**
    Priority: **[MUST]**

    > **ANSWERED:** Hidden until needed, but available if you want it.

14. **What's the relationship between expenses (tracking who paid what) and payments (actually booking stuff)?**
    Today Tryps tracks expenses. P2 adds real payments. Do these feel like the same feature or separate worlds?
    Priority: **[MUST]**

    > **ANSWERED:** They're connected — booking feeds expenses automatically. Three scenarios: (1) Jake books his own flight, not split — it can optionally be tracked as "Jake's flight cost $X" just to track trip cost. (2) Jake books the Airbnb on behalf of 15 people — automatically logged as a group expense, everyone owes Jake their share. (3) Individual bookings through the agent — each person's payment is their own. The key insight: if you book something through Tryps on behalf of the group, it should auto-log as an expense. Booking and expense tracking are the same flow, not separate features.

### Trust

15. **How much do you trust the agent to spend money? What's the line between "book it" and "show me first"?**
    Not a dollar amount — a principle. When does the agent act vs. ask?
    Priority: **[MUST]**

    > **ANSWERED:** At the beginning, not much trust. The agent must always get explicit confirmation before charging a credit card — it has to be super confident the user has confirmed. The principle: agent never spends money without clear user approval. Trust builds over time but the default is always "show me first, then I confirm."

16. **When a booking goes wrong (flight cancelled, hotel overbooked, card declined), what does the recovery feel like?**
    Stressful or handled? Does the agent fix it or does the user scramble?
    Priority: **[REFINE]**

    > **ANSWERED:** Ideally seamless — the agent handles it and keeps the user updated as it goes. But realistically, we need customer support for edge cases and that's undefined right now. For v1, the agent should do its best to resolve issues and escalate to support when it can't. What "support" looks like TBD.

### Business Model

17. **How does Tryps make money from payments? Commission on bookings? Subscription? Free forever with premium features? Or is this not decided yet?**
    Priority: **[MUST]**

    > **ANSWERED:** Not decided yet. Probably no revenue at first — mission is to get users. Eventually likely commission on bookings. Maybe free forever with premium features. But this is not designed. Get users first, monetize later.

18. **You mentioned Stripe MPP — what's your current thinking on the payment infrastructure? Stripe Connect? MPP? Something else?**
    Priority: **[REFINE]**

    > **ANSWERED:** Stripe end-to-end. People charge their credit card through Stripe — they already trust it. Tryps stores the card via Stripe, then can act on the user's behalf as needed. Stripe is the whole payment layer.

---

## 4. The Agent Layer

This is P3 territory — the AI that acts on your behalf. These questions decide whether P3 is 4 scopes, 2 scopes, or 1 scope.

### Feel

19. **Close your eyes. It's 6 months from now. The Tryps agent is fully working. Describe what it does for you on a real trip with your friends.**
    Stream of consciousness. What does a day look like?
    Priority: **[MUST]**

    > **ANSWERED:** The agent handles everything end-to-end — flights, every step, all the logistics. It reaches out to people in the group who have similar vibes and gets them contributing to the trip. In reality, you don't even know everything the agent did because it knows you so well. You have a really satisfying trip and you're surprised by how smooth it was. Other people in the group feel like the planning just... happened.

20. **What's the difference between Tryps with an agent and Tryps without one? If the agent disappeared, what would users miss most?**
    Priority: **[MUST]**

    > **ANSWERED:** Without the agent, Tryps is the customization and design layer — you can build and visualize your trip, but you do everything manually. With the agent, it does the thinking and actual execution for you. The agent is the difference between a planning tool and a travel agent.

21. **Is the agent a concierge (reactive — you ask, it answers), a planner (proactive — it suggests and organizes), or a doer (autonomous — it books, pays, and executes)?**
    It can be all three — but which one FIRST?
    Priority: **[MUST]**

    > **ANSWERED:** All three, but the core identity is **facilitator**. Think designated driver — responsible for the trip ACTUALLY happening, but doesn't pick the location or the party. It suggests the plan, facilitates options, steers the group toward alignment through voting and execution. The humans (and their individual agents based on their vibes) decide. The agent executes once the group has decided.

### Autonomy

22. **The agent can vote on your behalf when you don't respond. How does that feel? Exciting ("it knows me") or creepy ("it decided for me")?**
    Priority: **[MUST]**

    > **ANSWERED:** Exciting — "it knows me."

23. **The agent can spend money on your behalf. What's the maximum it should spend without asking? $0? $20? $100? "Whatever the group approved"?**
    Priority: **[MUST]**

    > **ANSWERED:** $0 by default — the agent should not spend any money on your behalf unless a user explicitly opts in. That's further on the roadmap. However, API calls charged to Tryps (like x402 calls for search/sourcing) are fine — that's Tryps' cost of doing business. Open question: might need something like AgentCash or self-hosted x402 for the search/sourcing layer. The key differentiator for why people search through Tryps instead of Google or Claude directly: Tryps accumulates trip-specific data and user preference data that other models don't have organically.

24. **The agent can book a restaurant, cancel a reservation, change a flight. Which of these feel safe to automate and which MUST have human approval?**
    Priority: **[MUST]**

    > **ANSWERED:** Safe to automate: booking restaurants (especially no-card-required), cancelling reservations. Needs human approval: changing a flight. The principle: low-cost, easily reversible actions can be automated. High-cost or hard-to-reverse actions need explicit approval.

25. **When the agent does something wrong — books the wrong restaurant, votes for something you hate — how do you undo it? How does it feel?**
    Priority: **[REFINE]**

    > **ANSWERED:** It should feel seamless and obvious WHAT the agent did. Troubleshooting needs to be easy. The agent LISTENS to the user — if you say "that's wrong" or "undo that," it responds and fixes it. Transparency + responsiveness.

### Architecture (Light Touch)

26. **Is the agent one brain or many? Is there one "Tryps agent" that does everything, or specialized agents (a booking agent, a voting agent, a logistics agent)?**
    From the user's perspective, not the technical side.
    Priority: **[MUST]**

    > **ANSWERED:** From the user's perspective, one unified travel service. One agent, one brain, one relationship.

27. **Does the agent live in iMessage, in the app, or both? If both, is it the same agent with the same context?**
    Priority: **[MUST]**

    > **ANSWERED:** Both — same agent, same context. Will need heavy work on memory architecture: both per-user memory (preferences, history, travel DNA) AND per-trip memory (what's been decided, who's confirmed what, group context).

---

## 5. Travel Identity & Connectors

These questions decide whether "connectors" is its own scope or folds into something else.

### Feel

28. **When you open your Tryps profile and see all your connected accounts (airlines, hotels, Airbnb, passport), how does that feel?**
    Like a wallet? A passport? A status symbol? A chore?
    Priority: **[MUST]**

    > **ANSWERED:** Like a wallet/passport. It needs to be OBVIOUS — unconnected services are greyed out as recommendations, connected ones are checked. Visual reference (Jake's notebook sketch): a vertical list of connector categories on the profile, each with specific services:
    > - **Airlines:** Southwest, Delta, American
    > - **Booking Stays:** Airbnb, VRBO, Bonvoy
    > - **Restaurants:** Resy, OpenTable
    > - **Payment:** Stripe, Link, CC
    > - **ID:** Passport, DL
    >
    > Each service shows connected (checked) or not (greyed out). Easy to see what's missing, easy to connect. Front and center on the profile.

29. **Is connecting your loyalty accounts a wow moment ("Tryps knows everything about me") or table stakes ("of course it needs my airline info")?**
    Priority: **[MUST]**

    > **ANSWERED:** Wow moment. It's so nice to SEE visually on your profile, front and center, that your existing travel life is connected in. The visual representation of "my travel identity" is the wow.

30. **When Tryps auto-applies your AAdvantage number to a booking, do you want to SEE that happen (satisfying, transparent) or just have it happen silently?**
    Priority: **[REFINE]**

    > **ANSWERED:** Need to see it. Users should see that their loyalty info was applied — transparency and satisfaction.

### Priority

31. **If Tryps could only connect to ONE external service, which one matters most? (airlines, hotels, Airbnb, rideshare, restaurants)**
    Priority: **[MUST]**

    > **ANSWERED:** Airlines.

32. **Is passport/travel document storage a launch feature or a "nice to have later"? How important is international travel in v1?**
    Priority: **[MUST]**

    > **ANSWERED:** Yes, needs it in v1. International travel is supported from launch.

---

## 6. The Whole Picture

These questions zoom back out to make sure all the pieces fit together.

### Sequencing

33. **What's the order of importance? Rank these capabilities 1-5:**
    - [ ] iMessage agent in group chats
    - [ ] Booking and paying for travel
    - [ ] Agent that researches and recommends options
    - [ ] Agent that votes/acts on your behalf
    - [ ] Travel identity (loyalty accounts, passport, preferences)
    Priority: **[MUST]**

    > **ANSWERED:**
    > 1. iMessage agent in group chats
    > 2. Agent that votes/acts on your behalf
    > 3. Travel identity (loyalty accounts, passport, preferences)
    > 4. Agent that researches and recommends options
    > 5. Booking and paying for travel

34. **Which of these capabilities need each other? Which are independent?**
    e.g., "You can't book without connectors" or "Voting agent is totally independent"
    Priority: **[MUST]**

    > **ANSWERED:**
    > - **iMessage agent:** Totally independent — no dependencies
    > - **Voting/acting agent:** Needs user to fill out trip Vibe and/or Travel DNA first
    > - **Travel identity:** Totally independent
    > - **Recommendations agent:** Reliant on friends network + recommendation algorithm architecture being built out
    > - **Booking & paying:** Reliant on others (connectors, payment infra, agent layer)

35. **Is there anything in the current P2/P3 scope list that feels wrong, unnecessary, or premature?**
    Be ruthless. What would you kill?
    Priority: **[MUST]**

    > **ANSWERED:** No — nothing to kill.

36. **Is there anything NOT in the current scopes that should be? Something we're missing?**
    Priority: **[REFINE]**

    > **ANSWERED:** Yes — four things missing:
    >
    > **1. Trip card customization.** Way more customization over the trip cards on the home tab. Currently under-invested.
    >
    > **2. Rewards program.** Need a loyalty/rewards program established — "Tryps Miles" or similar. Needs its own scope.
    >
    > **3. Guided planning cadence (the facilitation engine).** The owner picks a cadence for how fast the group plans the trip. The app guides the group through a structured timeline:
    > - **7-day plan:** Day 1: everyone sets vibe (vibe quiz) → Day 2: finalize destination/dates → Day 3: flights → Day 4: stay → Day 5: activities → etc.
    > - **3-day plan:** Day 1: vibe + dates + destination → Day 2: flights + stay → Day 3: activities → etc.
    >
    > Visual at top of trip: a tracker/workplan showing "7-day plan to get this trip planned" with progress. This is CORE to what Tryps is — the facilitation engine that guides groups to make decisions. Currently way under-invested. Needs visual design.
    >
    > **4. Role cards (Mario-style character select).** Each person picks their role on THIS trip — like choosing a character in Mario. Four roles that map to engagement level:
    > - **The Planner** (Mario/red) — does all the work, picks dates, books the spot, sends 14 texts nobody replies to. What they need: help.
    > - **The Silent Co-Planner** (Luigi/green) — didn't start the trip but has opinions about everything, secretly wants to help. What they need: a way in without stepping on toes.
    > - **The "Down for Whatever"** (Toad/yellow) — shows up, has a great time, contributed nothing to making it happen. What they need: a way to contribute without actual work. Agent votes for them.
    > - **The Last Minute Add** (Toadette/pink) — wasn't in the original chat, heard about it Thursday, flying in Saturday. What they need: instant access to the plan, no "scroll up" needed.
    >
    > These roles coincide with the vibe quiz — "who are you going to be on this one?" Your role selection tells YOUR agent how engaged you'll be in the planning process. A Planner wants to vote on everything; a Toad wants the agent to handle it. Needs a full spec but the direction is set.

### The April 2 Question

37. **You said April 2 applies to P3. What does "done" mean for P3 by April 2? Specs done? Code shipped? Something in between?**
    Priority: **[MUST]**

    > **ANSWERED:** Code shipped and tested.

38. **If you had to cut P2/P3 in half to hit April 2, what stays and what goes?**
    Priority: **[MUST]**

    > **ANSWERED:** Booking travel goes. (It's ranked #5 and has the most dependencies — it's the first thing to cut.)

---

## After This Questionnaire

Once Jake's answers are in:

1. **Merge with Asif's standup answers** (current state, what's built, what's blocked)
2. **Map vision to scopes** — some current scopes may merge, split, or die
3. **Define the actual scope list** with clean boundaries
4. **Run `/spec` sessions** only for scopes that survived the alignment

This questionnaire replaces Phase 0-3 of the old consolidation plan. The scopes come FROM the answers, not before them.
