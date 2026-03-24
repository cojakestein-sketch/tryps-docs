---
id: brand-book-spec
title: "Brand Book — Spec for Sean"
owner: jake
executor: sean
created: 2026-03-24
milestone_1_deadline: 2026-04-02
status: draft
---

# Brand Book Spec — Print & Review with Sean

> Jake + Sean lunch session, March 24 2026.
> This is the handoff doc. Everything Sean needs to build the brand book.

---

## The Big Shift

The brand book needs to center on one idea:

**Tryps is your group's travel concierge. You text it, and it plans your entire trip.**

The hero of the product is the **iMessage agent**. Not an app. Not a dashboard. A travel agent that lives in your group chat. You text it your vibe, it handles the rest.

**"Text your trip into existence."**

Every screen in the brand book should make the reader feel: this is a concierge I text, not a tool I use.

---

## What Exists Today

| Asset | Status | Location |
|-------|--------|----------|
| 7 Figma screens | Done | Logo x3, Color x1, Typography x1, iOS Icon x1, Splash x1 |
| Brand strategy doc | Updated (today) | `shared/brand-strategy.md` |
| 87-question intake questionnaire | Complete | `docs/brand-intake-questionnaire.md` |
| 70KB of Figma Make prompts | Updated framing (today) | `designs/brand-book-make-prompts.md` |
| Screen checklist (46 + 10 Glimmers) | Complete | `docs/brand-book-screen-checklist.md` |
| Grid layout for Figma | Done | `designs/brand-book-grid.html` |
| Competitive research (10+ brands) | Done | `docs/research/2026-03-19-brand-book-research.md` |
| Glimmers research | Done | `designs/glimmers-research.md` |

---

## 56 Screens — The Full Brand Book

### Phase 1: MUST for launch (13 new + 7 existing = 20 screens)

These are due by April 2.

| # | Screen | Section | Notes |
|---|--------|---------|-------|
| 1 | Cover | Front Matter | Updated tagline: "Text your trip into existence." |
| 2 | Table of Contents | Front Matter | |
| 3 | Brand Story | Front Matter | Chile origin story. But NOW: center on the moment you realize you can just text a concierge. |
| 4 | Mission & Vision | Strategy | "Logo on the side of a plane" — but the path there is via the concierge |
| 5 | Brand Values | Strategy | Sexy & Clean, Shareworthy, Obvious, Come Correct |
| 6 | Brand Personality | Strategy | "We are / We are not" + Anthony Bourdain analog |
| 7 | Target Audience | Strategy | Group Chat CEO persona |
| 8 | Clear Space & Min Size | Logo | Rules around existing logo assets |
| 9 | Logo Don'ts | Logo | Misuse examples |
| 10 | Secondary & Semantic Colors | Color | Success, warning, error + accent palette |
| 11 | Color Usage Rules | Color | "Red is brand, not error" |
| 12 | Type Scale & Hierarchy | Typography | Display → body → caption with sizes |
| 13 | Photography Style | Imagery | Candid, warm, real friends, film texture |
| 14-20 | 7 existing screens | Various | Logo x3, Color, Typography, iOS Icon, Splash |

### Phase 2: LATER (26 screens)

Post-launch additions: positioning, dark mode, voice/tone details, social templates, applications, app-specific, patterns, motion, onboarding, empty states.

### Glimmers (10 screens, 47-56)

Hero product moments — these showcase the agent/concierge in action:
- Group chat invitation moment
- First app download
- Voting/polling UX
- Travel personality quiz
- Tooltips/teaching
- Trip card designs

**KEY CHANGE: Glimmers should heavily feature the iMessage concierge experience.** Show the agent texting back, handling requests, building the itinerary in real-time.

---

## Architecture Change: What Needs to Be Different

### Old framing (in current prompts)
- "Group trip planning tool"
- "Turn group chats into group trips"
- "Partiful for travel"
- The app is the hero

### New framing (update all prompts)
- "Travel concierge you text"
- "Text your trip into existence"
- "Your group's travel agent lives in iMessage"
- The **agent** is the hero

### Screens that need the most rework

| Screen | What changes |
|--------|-------------|
| Cover | Tagline → "Text your trip into existence." |
| Brand Story | Origin story reframed: the concierge is the breakthrough |
| Mission & Vision | Vision includes the agent as the core product |
| Brand Personality | The brand IS the concierge — warm, capable, effortless |
| Value Prop / Positioning | If included: concierge framing front and center |
| Photography Style | Show iMessage screenshots, texting the agent |
| All Glimmer screens | Agent-first: show the conversation, then the result |
| App Store Assets | Hero screenshot = iMessage conversation with the concierge |

---

## Figma Make Workflow for Sean

1. Open the Figma file: "Tryps — Official (work here)"
2. Go to "Building the world" page
3. Grid is already set up (22 columns, 1920x1080 frames)
4. Prompts live in `designs/brand-book-make-prompts.md` — **will be updated after this lunch session**
5. Swap "tryps" text placeholder for real logo component after generation
6. Review with Jake after each section

---

## Decisions (Answered 2026-03-24 — Jake + Sean Lunch Session)

### The Agent Identity
1. **Name:** Martin. Contact saves as "Martin from Tryps" with profile picture. People should never know it's AI — Martin feels like a person.
2. **Personality:** Same as brand voice (Jennifer Test — the aunt who planned all the group trips). Handles logistics AND shepherds people. Youth-inspired, not travel agent formality. Don't over-define in the brand book — devs are nailing it in the product.
3. **First message:** No canned intro. Martin reacts to whatever you text — "Vegas" gets a different response than "help me plan a trip." First-message behavior is a dev scope (AI tester), not a branding decision.
4. **Archetype:** No change. 70% Host / 30% Magician stands.

### Positioning & Tagline
5. **Tagline:** "Text your trip into existence" is one of several candidates, not locked. Will emerge as brand develops.
6. **Partiful comparison:** Still useful as a case study for virality (invite mechanic). But the pitch is "travel agent in your iMessage."
7. **vs. AI assistants:** No. Not positioning against ChatGPT/Claude. Tryps is a service for one use case, not competing with them. Ideally they integrate with Tryps via MCP.
8. **One sentence:** "It's a travel agent in your iMessage." Travel agent > concierge (hits harder, more concrete).

### Brand Story
9. **Origin story:** Chile/Quinn still leads. New ending: "We realized the answer wasn't a better planning app — it was a travel agent you text."
10. **When it clicked:** When Jake started demoing it and it just worked. Five minutes, trip booked, flights and hotels handled.
11. **Hero demo:** Text Martin → 10 seconds → "Got everything. $2K. Want me to charge your card? Already have it on file." → "Done." That's the showcase moment for the brand book, launch video, every demo.

### Visual Direction
12. **Screenshots:** Idealized demo conversations, inspired by real ones but crafted for the brand book.
13. **Agent vs. app:** 70/30 iMessage agent to app. Brand book highlights iMessage first, then links to app visualization.
14. **"Meet Martin" screen:** No. Martin just is. Don't index on the character — focus on how Martin helps you book the trip.
15. **Film camera:** It's a campaign, not the visual anchor. iMessage conversation UI is the primary visual language. Disposable camera program happens at launch.
16. **Three hero conversations:** (a) "I know exactly what I want" — Vegas, specific dates, penthouse, Martin books in 5 min. (b) "I have no idea" — want to see college friends, no idea when/where/who, Martin helps ideate. (c) "Find flights under $300" — budget-conscious, practical power.

### Scope & Priority
17. **What Sean builds:** Potentially the entire brand book by April 2 with the right Figma workflow.
18. **Glimmers:** Yes, belong in the brand book. Sean best effort, product designer polishes later.
19. **Cuts:** None.
20. **Adds:** Two screens — "How It Works" (3-step) and "Before/After" (old way vs. Tryps way).

### The Brand Book's Audience
21. **Who it's for:** Internal team alignment. Forces Jake and Sean to put the vision on paper. Reference doc when anyone asks "how should this feel?" Also bringing to Trent for review.
22-23. **Not investor/UGC facing.** Maybe select slides shared for collaboration. This is the internal source of truth for the Tryps world.

### Cross-Scope Connections
24. **Launch video:** Separate scope. Sean handles later.
25. **UGC screen recording Martin:** Yes, that's a format. Separate scope.
26. **App Store screenshots:** Two-beat flow — iMessage conversation with Martin first, then app visualization. Sean first pass, Figma designer polishes.
27. **Social leading with Martin screenshots:** Yes, plus other stuff. Sean's scope.

### Working Model with Sean
28-30. Sean has Figma. Sits next to Jake. They'll figure out cadence. On the milestone.

---

## Deliverable Checklist (Milestone 1 — April 2)

- [ ] All MUST screens designed in Figma (15 new + 7 existing polished = 22 screens)
- [ ] Martin / travel agent framing consistent across every screen (never disclosed as AI)
- [ ] "Travel agent in your iMessage" as core positioning (tagline still evolving)
- [ ] iMessage agent featured prominently in product screenshots
- [ ] Brand book reviewed with Jake before finalization
- [ ] Aligned with updated brand strategy doc

---

## Sean's Workflow

1. Open the Figma file: "Tryps — Official (work here)" > "Building the world" page
2. Grid is already set up (22 columns, 1920x1080 frames)
3. Open `designs/brand-book-make-prompts.md` — all 64 prompts are ready to copy-paste
4. For each slide: copy the prompt text (between triple backticks) into Figma Make
5. Figma Make generates the slide using Tryps library tokens
6. Click "Copy design" and paste into the correct column/position
7. Swap text "tryps" placeholder for the real logo component (top-right corner)
8. Batch by section — do all Brand Story slides, paste them all, then move to Mission & Vision
9. Review with Jake after each section
10. Glimmer screens: give your best effort, product designer polishes later

---

## Reference Materials

All in `brand-and-gtm/reference/INDEX.md`:

| Doc | What Sean needs it for |
|-----|----------------------|
| Brand Strategy (`shared/brand-strategy.md`) | Positioning, values, voice, personality — THE source of truth |
| Intake Questionnaire (`docs/brand-intake-questionnaire.md`) | 87 answered questions — every brand decision traced back |
| Screen Checklist (`docs/brand-book-screen-checklist.md`) | What screens to build, priority, status |
| Make Prompts (`designs/brand-book-make-prompts.md`) | Copy-paste into Figma Make (updated with Martin/travel agent framing) |
| Brand Book Grid (`designs/brand-book-grid.html`) | Grid layout for Figma page |
| Glimmers Research (`designs/glimmers-research.md`) | Product moment inspiration |
| Competitive Research (`docs/research/2026-03-19-brand-book-research.md`) | How other brands built their books |
| Sean Handoff (`brand-and-gtm/01-brand-book/sean-handoff.md`) | Clean handoff doc with everything Sean needs |
