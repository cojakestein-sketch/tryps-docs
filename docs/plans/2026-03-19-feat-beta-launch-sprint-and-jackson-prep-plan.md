---
title: "Beta Launch Sprint & Jackson Prep"
type: feat
date: 2026-03-19
---

# Beta Launch Sprint & Jackson Prep

## Overview

4-hour sprint to get Tryps to a shareable TestFlight beta TODAY. The goal: Jake can text a friend a link, they download the app, sign up, join a trip, and it works. By end of day: new TestFlight build is live, first real users are onboarding, and Jake has printed materials for tomorrow's Jackson strategy session.

## Problem Statement / Motivation

Tryps needs to get into real hands this weekend. Not a perfect app — a working one. The core loop (create trip → invite friends → they join) must be bulletproof. Everything else can be rough but not broken. Jake meets Jackson tomorrow and needs:

1. **Live app demo on his phone** — create a trip, invite Jackson, he downloads and goes through onboarding
2. **Brand direction materials** — positioning, moodboards, visual identity
3. **Social media footprint preview** — what Tryps looks like on socials (Sean)
4. **User onboarding plan** — evidence that real users are being onboarded starting today

## Current App State (as of Mar 19)

### Ready for Production (should work)
- Trip Creation Flow ✅
- Itinerary Tab ✅
- Activities Tab ✅
- People Tab ✅
- Backend Auth QA ✅
- Phone input fixes (3 bugs fixed) ✅
- OTP expiration fix ✅

### For Testing (built, needs QA pass)
- Auth Flow UI Update (Nadeem)
- Expenses Tab (Nadeem)
- Vibe Tab (Nadeem)
- Trip Details Header & Overview (Nadeem)
- Trip Vibe + DNA Unify (Nadeem)
- Packing List (Asif)
- RLS: expense INSERT fix (Nadeem)
- RLS: trip UPDATE fix (Nadeem)
- Post-Trip Review (Nadeem)

### Known Bugs (open)
- **App crashes when verifying phone number** (Indonesian number — may affect other numbers too)
- **Dark Mode not applied during Trip Creation**
- Bug parent tickets open for: Itinerary, Activities, Auth, Trip Creation (subtasks unknown)

### Unknown / Needs Verification
- **Deep link / invite flow** — does texting someone a link actually work end-to-end?
- **TestFlight distribution** — is the current build on TestFlight? When was last upload?
- **Join flow** — when someone taps a link, do they land inside the right trip?

---

## The Sprint: Priority Stack

### P0 — Must Work Today (the core loop)

These are the flows that make or break the beta. If ANY of these fail, the beta is embarrassing.

**Flow 1: Sign Up**
```
New user taps TestFlight link → installs app → opens → enters phone number → gets OTP → verifies → creates profile → lands on home screen
```
- Known risk: crash on phone verify (at least for Indonesian numbers)
- Known risk: dark mode not applied during trip creation (visual, not functional)
- Needs: someone test US numbers end-to-end RIGHT NOW

**Flow 2: Create a Trip**
```
User taps "+" → enters trip name, dates, destination → trip is created → user lands on trip detail screen with all tabs visible
```
- ClickUp says "ready for production" but there's an open bug parent ticket
- Needs: someone verify this works on current build

**Flow 3: Invite People**
```
Trip creator adds people → invitees get SMS/text with link → they tap link → TestFlight download → open app → sign up → they're IN the trip
```
- This is the WOW moment — "I add you, you get a text, you're in"
- **HIGHEST RISK** — deep links, SMS delivery, join-by-link are complex and untested
- Needs: verify the entire chain works, not just individual pieces

**Flow 4: Trip Content Exists**
```
Once inside a trip → itinerary has dates → activities can be added/viewed → people tab shows members
```
- Individual tabs are "ready for production"
- Needs: one pass to confirm they work together in the same trip

### P1 — Should Work Today (impressive but not fatal if rough)

**Vibe / DNA Quiz**
- "For testing" status — built but unvalidated
- The personality quiz is a crowd-pleaser — people love taking it
- Needs: quick test that quiz loads, completes, and shows results

**Trip Details Header**
- "For testing" — the overview screen when you open a trip
- This is the first thing people see — should look good

### P2 — Nice to Have (don't break it, don't prioritize fixing it)

- Expenses Tab
- Packing List
- Post-Trip Review
- Any P2/P3 scope work

---

## Dev Assignments: The 4-Hour Sprint

### Hour 0 (first 15 min): Jake Kicks Off

- [ ] Open Tryps app on your phone and do a full walkthrough — sign up → create trip → invite someone → check every tab
- [ ] Write down every broken/ugly thing you see (voice memo to Claude is fine)
- [ ] Post in team Slack: "All hands on deck. Beta sprint for the next 4 hours. Drop everything else."
- [ ] Share this plan with Asif, Nadeem, Rizwan

### Dev 1: Nadeem — Auth + Core Flow Bugs

**Mission:** The sign-up and trip creation flows work perfectly on US phone numbers.

- [ ] Fix: App crash on phone number verification — test with US numbers, international numbers
- [ ] Verify: Auth UI Update (his "for testing" PR) is working correctly
- [ ] Verify: Trip Creation flow works end-to-end (create → lands on trip detail)
- [ ] Fix: Dark Mode not applied during Trip Creation
- [ ] Verify: RLS fixes are working (expense INSERT + trip UPDATE)
- [ ] Smoke test: Trip Details Header shows correctly after trip creation

**Exit criteria:** Jake can hand his phone to someone who has never used Tryps, and they can sign up and create a trip without hitting a bug.

### Dev 2: Asif — Invite Flow + Deep Links

**Mission:** The invite/join loop works end-to-end. This is the wow moment.

- [ ] Test: What happens when you add a person to a trip? Do they get a text?
- [ ] Test: Does the text contain a working deep link?
- [ ] Test: Does the deep link open TestFlight / the app?
- [ ] Test: After sign-up, does the new user land in the correct trip?
- [ ] Fix: Whatever is broken in this chain — this is P0
- [ ] Test: Share sheet / copy link — can you paste a trip link in iMessage and it works?
- [ ] Verify: People Tab shows all members correctly after join
- [ ] Coordinate with Nadeem: if backend/RLS is blocking invites, pair to fix

**Exit criteria:** Jake texts a link to a friend, the friend downloads TestFlight, opens the app, signs up, and is inside Jake's trip within 2 minutes.

### Dev 3: Rizwan — QA Sweep + Fix Anything Found

**Mission:** Full QA pass on every screen. Find bugs, fix them, repeat.

- [ ] Do a complete app walkthrough as a new user (fresh account)
- [ ] Document every bug with screenshot + steps to reproduce
- [ ] Fix visual bugs and minor issues as you find them (dark mode, layout, alignment)
- [ ] Test: Itinerary Tab — add dates, view calendar, no crashes
- [ ] Test: Activities Tab — add activity, view list, no crashes
- [ ] Test: Vibe/DNA quiz — complete the quiz, see results
- [ ] Test: Trip Details Header — looks correct, shows right info
- [ ] Escalate to Nadeem or Asif if you find P0 blockers
- [ ] After fixes: build and submit to TestFlight

**Exit criteria:** Rizwan has gone through every screen in the app as a fresh user and nothing crashes, looks broken, or shows placeholder content.

### Hour 3.5-4: TestFlight Build + Verify

- [ ] Rizwan submits new build to TestFlight
- [ ] Jake downloads the new build and does the full flow: sign up → create trip → invite friend → they join
- [ ] Jake verifies the wow moment works: "I added you to a trip" → friend is in
- [ ] If critical bugs remain: one more fix cycle + rebuild
- [ ] If build is good: start inviting real users

---

## Jackson Prep (parallel track, Jake + Sean)

### What Jake Needs to Walk Out With Tonight

| Deliverable | Owner | Format | Status |
|-------------|-------|--------|--------|
| Working app on phone | Jake + devs | Live TestFlight build | Sprint output |
| Brand direction materials | Jake + Claude | Printed PDF or deck slides | From brand strategy work |
| Social media footprint preview | Sean | Mockups / screenshots of social presence | Sean delivers today |
| Pitch deck (updated) | Jake + Sean | Printed/PDF | Needs update with current state |
| User onboarding plan | Jake | 1-pager showing the rollout plan | Write during/after sprint |
| Roadmap | Jake + Claude | Printed timeline of what ships when | Can generate from ClickUp/scopes |

### Sean's Assignment Today

- [ ] Prep social media footprint mockups — what does Tryps look like on Instagram, TikTok, Twitter?
- [ ] Update any pitch deck visuals with current brand direction
- [ ] Launch video status check — where is this and what can be shown to Jackson?
- [ ] Deliver materials to Jake by EOD for printing

### Jackson Meeting Prep (what Jake rehearses tonight)

The story for Jackson:

1. **Live demo:** Pull out phone, create a trip, invite Jackson. He downloads, signs up, he's in. "This is what your friends experience."
2. **Brand direction:** Show the brand strategy thinking — positioning ("Partiful for travel"), visual direction (film camera warmth, Tryps Red), voice (group chat energy, not corporate)
3. **User plan:** "We started onboarding real users today. Here's the plan: friends & family this weekend, strangers review in April, public launch by [date]."
4. **Roadmap:** Show the scope timeline — P1 core flows done, P2 payments + iMessage in progress, P3 agent layer designed
5. **The ask:** Whatever Jake wants from Jackson — intros, strategy feedback, funding advice

---

## Team Updates

### Add to team documentation:

**Sean** — Creative / Socials
- Role: Social media presence, launch video, creative assets
- Current focus: Social media footprint + launch video prep
- Delivers to: Jake (materials for investor/strategy meetings)

**Jackson** — Strategy Advisor
- Role: Traditional VC-style strategy advisor
- Current focus: Reviewing Tryps strategy, providing guidance on launch and growth
- Next touchpoint: In-person meeting March 20, 2026
- What he needs: Working app demo, brand direction, user onboarding plan

---

## After the Sprint: What Flows Into P2/P3

Once beta is shipping and Jackson meeting is done:

1. **Mar 20 (after Jackson):** Debrief Jackson feedback, adjust priorities if needed
2. **Mar 20-22:** Execute Phase 0-3 of P2/P3 Consolidation Plan:
   - Fix ClickUp drift
   - Resolve Stripe open questions
   - Run P3 spec sessions (agent intake questionnaire → /spec)
3. **Mar 24:** Asif starts P2, Rizwan starts P3
4. **Ongoing:** Beta users provide feedback → feeds into P1 polish

The beta sprint isn't separate from P2/P3 — it's the foundation. Once the core loop works, P2 (payments, iMessage, connectors) is the upgrade path. P3 (agent layer) makes it magical.

---

## Dependencies & Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| Deep link / invite flow doesn't work | No wow moment — the whole demo falls flat | Asif is dedicated to this. If deep links are broken, fall back to "add by phone number" + manual join |
| Auth crash affects US numbers (not just Indonesian) | Nobody can sign up | Nadeem fixes this first. If unfixable in 4 hours, test with workaround numbers |
| TestFlight build takes too long / fails | No new build to demo | Start build process by hour 3. Have a backup: demo on dev build if TestFlight isn't ready |
| Sean's materials aren't ready by EOD | Jackson meeting is missing visual polish | Jake can present brand direction verbally using brand.md + show the app. Deck is nice-to-have, app demo is must-have |
| Too many bugs found during QA sweep | Can't fix everything in 4 hours | Ruthless prioritization: P0 (core loop) gets fixed, everything else gets noted for tomorrow |
| Vibe/DNA quiz is broken | Lose a crowd-pleaser feature | Not fatal — trip creation + invites IS the beta. Quiz is impressive but not required |

## Timeline Summary

```
Mar 19 (TODAY):
├── 0:00  Jake does app walkthrough, posts sprint kickoff to team
├── 0:15  Devs start (Nadeem: auth, Asif: invites, Rizwan: QA sweep)
├── 1:00  First bug check-in — what's fixed, what's blocking?
├── 2:00  Midpoint — P0 flows should be working. Start testing end-to-end
├── 3:00  Sean delivers creative materials to Jake
├── 3:30  Rizwan starts TestFlight build
├── 4:00  Jake downloads new build, verifies wow moment works
├── 4:30  Start inviting real friends to TestFlight
├── Evening: Jake rehearses Jackson demo, prints materials

Mar 20 (TOMORROW):
├── Morning: Jackson meeting — live demo + brand + roadmap + user plan
├── Afternoon: Debrief Jackson feedback
└── Evening: Begin P2/P3 consolidation (Phase 0-1 from yesterday's plan)
```

## References

- `tryps-docs/docs/plans/2026-03-18-feat-p2-p3-scope-consolidation-and-spec-pipeline-plan.md` — P2/P3 plan (parked, executes after beta)
- `tryps-docs/shared/brand.md` — brand direction for Jackson materials
- `tryps-docs/shared/clickup.md` — ClickUp task IDs for all scope tickets
- `tryps-docs/docs/plans/2026-03-18-feat-brand-strategy-and-brand-book-plan.md` — brand strategy context for Jackson
