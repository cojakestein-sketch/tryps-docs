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

## Questions to Discuss at Lunch

### The Concierge Identity
1. Does the concierge have a name, or is it just "Tryps"? If someone texts the group chat, does the agent respond as "Tryps" or something else?
2. What's the concierge's personality? Is it the same as the brand voice (cheeky, warm, Bourdain-ish), or does it have its own distinct character?
3. How does the concierge introduce itself when added to a group chat for the first time? What's that first message?
4. The brand archetype is 70% Host / 30% Magician — the concierge IS both of these. Does this change how we describe the archetype in the brand book?

### Positioning & Tagline
5. "Text your trip into existence" — is this THE tagline, or one of several? Does "Less planning. More going." still have a role?
6. The Partiful comparison ("Partiful for travel") — still useful for explaining to investors/press, or does "travel concierge" make it irrelevant?
7. Should the brand book explicitly position against ChatGPT/AI assistants? ("Unlike ChatGPT, Tryps lives in your group chat and can actually take action")
8. What's the one sentence Jake says when someone asks "what's Tryps?" Is it "it's a travel concierge you text" or something else?

### Brand Story
9. Does the Chile/Quinn origin story still lead, or does it need a new ending? Something like: "We realized the answer wasn't a better planning app — it was a concierge you text."
10. When did the concierge positioning click? What was the specific moment or beta conversation where you thought "this is it"?
11. Is there a single beta user conversation that perfectly demonstrates the concierge in action — something we could reference or screenshot for the brand book?

### Visual Direction
12. The iMessage screenshots — real beta conversations, or idealized demo conversations crafted for the brand book?
13. How prominent is the app (trip card, explore, profile) vs. the iMessage experience in the brand book? 70/30 agent/app? 50/50?
14. Should there be a "Meet your concierge" screen — like introducing a character or a persona for the agent?
15. The film camera / disposable camera motif — still the visual anchor, or does iMessage conversation UI become the primary visual language?
16. What are the 3 hero iMessage conversations you'd want to showcase? (e.g., "plan a ski trip for 6 people in March," "find flights under $300," "what should we do in Tulum?")

### Scope & Priority
17. The screen checklist says 13 MUST + 26 LATER + 10 Glimmers = 49 new screens. What's Sean actually building by April 2?
18. Do the Glimmer screens (product moments) belong in the brand book, or are they a separate deliverable?
19. Any screens to CUT? If the hero is iMessage, some screens lose relevance (email signature, pitch deck template, merch mockups).
20. Should we ADD screens? Candidates:
    - "The Concierge in Action" — a full-page iMessage conversation showcase
    - "How It Works" — 3-step visual (add to group chat → text your vibe → trip happens)
    - "Agent Personality Guide" — how the concierge talks, responds, handles edge cases
    - "Before/After" — the old way (5 apps, spreadsheets, chaos) vs. the Tryps way (one text)

### The Brand Book's Audience
21. Who is this brand book for? Investors seeing Tryps for the first time? Designers who need to build screens? Sean building the launch video? All three?
22. If an investor opens this brand book, what's the one thing they should walk away thinking?
23. If a UGC creator opens this brand book, what do they need to understand about the brand to make good content?

### Cross-Scope Connections
24. The launch video (scope 04) — should it literally show someone texting the concierge and a trip materializing? How tightly is the brand book tied to the video treatment?
25. UGC creators (scope 03) — can they screen-record themselves texting the concierge? Is that a format we want?
26. App Store screenshots (screen 37 on checklist) — the first screenshot is the most important. Is it an iMessage conversation, a trip card, or both?
27. Social content (scope 02) — does the social strategy lead with concierge screenshots, or is that too product-y for social?

### Working Model with Sean
28. Review cadence — daily check-ins, or Sean builds a section and reviews in batches?
29. Does Sean have Figma Make access? Need a walkthrough?
30. Does Sean work better from the spec + reference docs, or does he want a live walkthrough of the brand strategy?

---

## Deliverable Checklist (Milestone 1 — April 2)

- [ ] All MUST screens designed in Figma (13 new + 7 existing polished)
- [ ] Concierge/agent framing consistent across every screen
- [ ] "Text your trip into existence" as hero tagline
- [ ] iMessage agent featured prominently in product screenshots
- [ ] Brand book reviewed with Jake before finalization
- [ ] Aligned with updated brand strategy doc

---

## Reference Materials

All in `brand-and-gtm/reference/INDEX.md`:

| Doc | What Sean needs it for |
|-----|----------------------|
| Brand Strategy (`shared/brand-strategy.md`) | Positioning, values, voice, personality — THE source of truth |
| Intake Questionnaire (`docs/brand-intake-questionnaire.md`) | 87 answered questions — every brand decision traced back |
| Screen Checklist (`docs/brand-book-screen-checklist.md`) | What screens to build, priority, status |
| Make Prompts (`designs/brand-book-make-prompts.md`) | Copy-paste into Figma Make (updated with concierge framing) |
| Brand Book Grid (`designs/brand-book-grid.html`) | Grid layout for Figma page |
| Glimmers Research (`designs/glimmers-research.md`) | Product moment inspiration |
| Competitive Research (`docs/research/2026-03-19-brand-book-research.md`) | How other brands built their books |
