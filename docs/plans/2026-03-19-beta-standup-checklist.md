---
title: "Beta Standup Checklist — Mar 19, 2pm TestFlight"
type: feat
date: 2026-03-19
---

# Beta Standup Checklist

> Goal: New TestFlight build pushed by 2pm. Jake onboards ~25 real users this weekend.
> Two flows must work. One new feature (feedback banner) must be added.

---

## The Two Flows That Must Work

### Flow A: "Forrest at Lunch" — Group Chat → Trip → App

```
Jake texts Forrest's number + Tryps number in a group chat
  → Jake says "Plan us a trip to NYC this weekend"
  → Tryps agent responds: "I've created your trip to NYC —
     you can tell me what your vibe is in iMessage,
     or see your trip here: [TestFlight link]"
  → Forrest taps the link
  → Downloads TestFlight → installs Tryps → opens app
  → Joins the NYC trip (already a member from the group chat)
  → Immediately prompted to take 10-question vibe quiz
  → Finishes quiz → lands in trip detail screen with tabs
  → Plays around → sees yellow feedback banner → gives feedback
```

### Flow B: "Cold TestFlight Link" — Direct Download → Create Trip

```
Jake texts someone just the TestFlight link — no group chat, no Tryps number
  → Person downloads → opens Tryps for the first time
  → OTP phone verification
  → Prompted to create their first trip
  → Goes through trip creation flow
  → Takes vibe quiz
  → Can invite/share with others
  → Sees yellow feedback banner → gives feedback
```

---

## What Needs to Be BUILT Today (new)

1. **Yellow feedback banner** — Giant yellow box on the home screen above "My Trips" and Discover. Reads: "We are in beta — please click here to give us honest feedback on Tryps." Links to a feedback form (Google Form? Typeform? Decide at standup).

---

## What Needs to Be VERIFIED at Standup (existing)

Test each of these on the CURRENT TestFlight build. For each one, answer: works / broken / partially works.

### Auth & Onboarding
- [ ] 1. Can a new user enter a US phone number and receive OTP?
- [ ] 2. Can they verify the OTP and complete sign-up?
- [ ] 3. Does profile setup work (name, photo)?
- [ ] 4. After sign-up, does the user land in the right place?

### Trip Creation (Flow B)
- [ ] 5. Can a new user create a trip (name, dates, destination)?
- [ ] 6. After creation, do they land on the trip detail screen?
- [ ] 7. Do all tabs load without crashing (itinerary, activities, people)?

### Invite / Join (Flow A)
- [ ] 8. Does the Tryps iMessage agent respond in a group chat?
- [ ] 9. Does the agent create a trip and send back a link?
- [ ] 10. When an invited person taps the link, do they end up in the right trip after sign-up?
- [ ] 11. Can you add people to a trip from inside the app (phone number / share link)?

### Vibe Quiz
- [ ] 12. Is the 10-question A/B vibe quiz prompted after joining/creating a trip?
- [ ] 13. Does the quiz complete and save results?
- [ ] 14. Can you see your vibe results after finishing?

### General Polish
- [ ] 15. Does dark mode work throughout the app (no white screens)?
- [ ] 16. Does the app crash at any point during either flow?
- [ ] 17. Is there any placeholder text or obviously broken UI visible?

---

## Questions for the Team at Standup

### For Asif (closest to the pin — start here)

1. **Current state:** What does the app actually look like right now on the latest TestFlight? Walk us through both flows — what works, what's broken?
2. **iMessage agent:** Is the Tryps number responding in group chats? Can you demo it live?
3. **Deep links / join flow:** When someone taps a TestFlight link from a text, do they land in the right trip? Has this been tested recently?
4. **Feedback banner:** How long to add the yellow banner with a link to a feedback form? Can this be done by 2pm?
5. **What's blocking a 2pm build?** What are the top 3 things that need to be fixed for a clean TestFlight push?

### After Asif's walkthrough — assign work live

Based on what Asif reports, Jake assigns each broken item to a specific dev with a 2pm deadline. No pre-assignment — we decide in the meeting based on what's actually broken.

---

## Standup Format

1. **Asif walks through current app state** (5 min) — screen share or demo on phone
2. **Go through checklist items 1-17 live** (10 min) — mark each as works/broken/partial
3. **Identify gaps** — what's broken that must work by 2pm?
4. **Jake assigns each gap to a dev** — live during standup
5. **Confirm: who pushes the TestFlight build and by when?**
6. **Feedback banner:** Decide what it links to, Asif builds it

---

## After Standup: Jake's Prep for Jackson (Mar 20)

- [ ] Working TestFlight on phone (from 2pm build)
- [ ] Brand direction materials (from brand.md + brand strategy work)
- [ ] Social media footprint (Sean delivers today)
- [ ] Roadmap / scope timeline (can print from ClickUp or generate from scopes)
- [ ] User onboarding plan — "we started onboarding 25 users this weekend, here's how"
- [ ] Rehearse the live demo: create trip → invite Jackson → he downloads → he's in
