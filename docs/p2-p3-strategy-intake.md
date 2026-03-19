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

2. **What's the single moment in the P2/P3 future that makes someone say "holy shit" about Tryps?**
   Think about the brand intake — the trip card and iMessage agent were the two aha moments. What's the P2/P3 equivalent?
   Priority: **[MUST]**

3. **If you could only ship ONE thing from all of P2/P3, what would it be?**
   Not which scope — which capability. What's the thing that changes the game?
   Priority: **[MUST]**

4. **How does P2/P3 change the way someone describes Tryps to a friend?**
   Today: "It's like Partiful but for trips." After P2/P3: "It's like ________."
   Priority: **[MUST]**

---

## 2. The iMessage Agent

Linq is already in testing. These questions are about where it's GOING, not where it is.

### Feel

5. **When someone adds the Tryps agent to their group chat, what should that first 60 seconds feel like?**
   Not what it does — how it FEELS. Exciting? Calm? Funny? Like adding a friend vs. adding a bot?
   Priority: **[MUST]**

6. **The agent is in the group chat for a week. What does it feel like to have it there? Is it always present or does it disappear until needed?**
   Priority: **[MUST]**

7. **What's the agent's personality? Is it the same as the Tryps brand voice (warm, casual, group chat energy) or something different?**
   Priority: **[MUST]**

8. **What should the agent NEVER do in the group chat? What would make someone say "this is annoying, remove it"?**
   Priority: **[MUST]**

### Ambition

9. **Where does the iMessage agent end and the app begin? What lives in chat vs. what pulls you into the app?**
   e.g., Can you plan an entire trip without ever opening the app? Or is the chat a funnel into the app?
   Priority: **[MUST]**

10. **Is the iMessage agent the PRIMARY way people use Tryps, or a secondary channel that feeds the app?**
    This is a huge strategic call. It shapes everything.
    Priority: **[MUST]**

---

## 3. Payments & Booking

These questions decide what "Tryps handles money" means — which could be one scope or three depending on the answers.

### Feel

11. **What does paying for something through Tryps feel like? Walk me through the moment.**
    Not the technical flow — the emotional experience. Is it like Apple Pay (tap and done)? Like Venmo (social and visible)? Like a concierge (someone handles it for you)?
    Priority: **[MUST]**

12. **When the group needs to pay for something (hotel, flights, dinner), who pays? One person? Everyone? Tryps?**
    This is a product philosophy question, not a technical one.
    Priority: **[MUST]**

13. **How visible is money in the Tryps experience? Is it front-and-center (prices everywhere, budget tracking) or hidden until needed (the agent handles it, you barely notice)?**
    Priority: **[MUST]**

14. **What's the relationship between expenses (tracking who paid what) and payments (actually booking stuff)?**
    Today Tryps tracks expenses. P2 adds real payments. Do these feel like the same feature or separate worlds?
    Priority: **[MUST]**

### Trust

15. **How much do you trust the agent to spend money? What's the line between "book it" and "show me first"?**
    Not a dollar amount — a principle. When does the agent act vs. ask?
    Priority: **[MUST]**

16. **When a booking goes wrong (flight cancelled, hotel overbooked, card declined), what does the recovery feel like?**
    Stressful or handled? Does the agent fix it or does the user scramble?
    Priority: **[REFINE]**

### Business Model

17. **How does Tryps make money from payments? Commission on bookings? Subscription? Free forever with premium features? Or is this not decided yet?**
    Priority: **[MUST]**

18. **You mentioned Stripe MPP — what's your current thinking on the payment infrastructure? Stripe Connect? MPP? Something else?**
    Priority: **[REFINE]**

---

## 4. The Agent Layer

This is P3 territory — the AI that acts on your behalf. These questions decide whether P3 is 4 scopes, 2 scopes, or 1 scope.

### Feel

19. **Close your eyes. It's 6 months from now. The Tryps agent is fully working. Describe what it does for you on a real trip with your friends.**
    Stream of consciousness. What does a day look like?
    Priority: **[MUST]**

20. **What's the difference between Tryps with an agent and Tryps without one? If the agent disappeared, what would users miss most?**
    Priority: **[MUST]**

21. **Is the agent a concierge (reactive — you ask, it answers), a planner (proactive — it suggests and organizes), or a doer (autonomous — it books, pays, and executes)?**
    It can be all three — but which one FIRST?
    Priority: **[MUST]**

### Autonomy

22. **The agent can vote on your behalf when you don't respond. How does that feel? Exciting ("it knows me") or creepy ("it decided for me")?**
    Priority: **[MUST]**

23. **The agent can spend money on your behalf. What's the maximum it should spend without asking? $0? $20? $100? "Whatever the group approved"?**
    Priority: **[MUST]**

24. **The agent can book a restaurant, cancel a reservation, change a flight. Which of these feel safe to automate and which MUST have human approval?**
    Priority: **[MUST]**

25. **When the agent does something wrong — books the wrong restaurant, votes for something you hate — how do you undo it? How does it feel?**
    Priority: **[REFINE]**

### Architecture (Light Touch)

26. **Is the agent one brain or many? Is there one "Tryps agent" that does everything, or specialized agents (a booking agent, a voting agent, a logistics agent)?**
    From the user's perspective, not the technical side.
    Priority: **[MUST]**

27. **Does the agent live in iMessage, in the app, or both? If both, is it the same agent with the same context?**
    Priority: **[MUST]**

---

## 5. Travel Identity & Connectors

These questions decide whether "connectors" is its own scope or folds into something else.

### Feel

28. **When you open your Tryps profile and see all your connected accounts (airlines, hotels, Airbnb, passport), how does that feel?**
    Like a wallet? A passport? A status symbol? A chore?
    Priority: **[MUST]**

29. **Is connecting your loyalty accounts a wow moment ("Tryps knows everything about me") or table stakes ("of course it needs my airline info")?**
    Priority: **[MUST]**

30. **When Tryps auto-applies your AAdvantage number to a booking, do you want to SEE that happen (satisfying, transparent) or just have it happen silently?**
    Priority: **[REFINE]**

### Priority

31. **If Tryps could only connect to ONE external service, which one matters most? (airlines, hotels, Airbnb, rideshare, restaurants)**
    Priority: **[MUST]**

32. **Is passport/travel document storage a launch feature or a "nice to have later"? How important is international travel in v1?**
    Priority: **[MUST]**

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

34. **Which of these capabilities need each other? Which are independent?**
    e.g., "You can't book without connectors" or "Voting agent is totally independent"
    Priority: **[MUST]**

35. **Is there anything in the current P2/P3 scope list that feels wrong, unnecessary, or premature?**
    Be ruthless. What would you kill?
    Priority: **[MUST]**

36. **Is there anything NOT in the current scopes that should be? Something we're missing?**
    Priority: **[REFINE]**

### The April 2 Question

37. **You said April 2 applies to P3. What does "done" mean for P3 by April 2? Specs done? Code shipped? Something in between?**
    Priority: **[MUST]**

38. **If you had to cut P2/P3 in half to hit April 2, what stays and what goes?**
    Priority: **[MUST]**

---

## After This Questionnaire

Once Jake's answers are in:

1. **Merge with Asif's standup answers** (current state, what's built, what's blocked)
2. **Map vision to scopes** — some current scopes may merge, split, or die
3. **Define the actual scope list** with clean boundaries
4. **Run `/spec` sessions** only for scopes that survived the alignment

This questionnaire replaces Phase 0-3 of the old consolidation plan. The scopes come FROM the answers, not before them.
