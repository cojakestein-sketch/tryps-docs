# App Store Screenshots — Process Plan

> Owner: Jake + Sean
> Status: Not started
> Goal: 6 best-in-class App Store screenshots that tell the Tryps story and drive downloads
> Output: 6 Figma Make prompts → 6 final screenshot assets (iPhone 15 Pro Max, 1290x2796)

---

## Phase 1: Research — What does "best in class" look like?

**Method:** Auto-research with Claude (Karpathy-style deep dive)

Research questions:
- What do the highest-converting App Store screenshots have in common?
- What's the anatomy of a great screenshot (headline, device frame, background, callout)?
- What ratios of text-to-UI work best?
- How many screenshots do top apps use? What's the narrative arc across the set?
- What are the ASO (App Store Optimization) rules and constraints for screenshots?
- What do social/travel apps specifically do well (and badly)?
- What does Apple recommend in their Human Interface Guidelines for screenshots?

Deliverable: A research summary doc with principles and patterns to follow.

---

## Phase 2: Competitive Inspiration — Yes/No on real examples

**Method:** Jake browses App Store, Claude provides a curated list of brands to review

### Brands to evaluate (propose/debate this list):

**Travel & social apps:**
1. Partiful
2. Airbnb
3. Hopper
4. Flighty
5. Wanderlog
6. Splitwise
7. TripIt

**Consumer apps with great screenshot design:**
8. Arc Browser
9. Lemon8
10. BeReal
11. Retro (photo sharing)
12. Copilot (finance)
13. Artifact (was news, good design)
14. Poke AI
15. Venmo

**Wild cards (known for elite App Store presence):**
16. Notion
17. Linear
18. Raycast
19. Things 3
20. Halide

### Process:
1. Jake opens each app's App Store page
2. For each: **YES** (love the screenshots), **NO** (skip), or **STEAL THIS** (specific element to borrow)
3. For every YES/STEAL, note what specifically works — the headline copy? the color? the device framing? the story arc?

Deliverable: A filtered list of 5-8 approved references with annotations on what to steal.

---

## Phase 3: Strategy — Craft the 6-screen narrative

**Method:** Synthesize Phase 1 research + Phase 2 references into a Tryps-specific screenshot strategy

### The 6-screen story arc (draft — to be refined):

| # | Theme | Headline (draft) | What it shows |
|---|-------|-------------------|---------------|
| 1 | Hook / Hero | TBD | The "aha" moment — what is Tryps? |
| 2 | Group planning | TBD | Creating a trip, inviting friends |
| 3 | AI agent magic | TBD | Linq/agent doing the work for you |
| 4 | Coordination | TBD | Voting, decisions, itinerary |
| 5 | Money | TBD | Splitting costs, Settle Up |
| 6 | Social proof / emotion | TBD | The payoff — your trip, your people |

### Strategy decisions to make:
- Device frame style: floating device? full bleed? no device?
- Background treatment: solid color? gradient? lifestyle photo blur?
- Typography: Plus Jakarta Sans (brand) or something bolder for headlines?
- Color palette per screen: all Tryps Red? or vary by theme?
- Copy voice: punchy one-liners? questions? statements?
- Include real UI or stylized/simplified mockups?

Deliverable: A finalized shot list with headline copy, UI screen selection, and visual treatment per screenshot.

---

## Phase 4: Execution — Figma Make

**Method:** Sean and Jake use Figma Make to generate the screenshots

### Per screenshot:
1. Write a detailed Figma Make prompt informed by Phase 3 strategy
2. Include: exact headline text, background description, device frame style, which app screen to show, color tokens from brand.md
3. Generate in Figma Make
4. Review and iterate (2-3 rounds max per screen)
5. Export at 1290x2796 (iPhone 15 Pro Max)

### Prompt template:
```
Create an App Store screenshot for a travel app called Tryps.

Screen [N] of 6.
Headline: "[HEADLINE]"
Subheadline: "[SUBHEADLINE]" (optional)

Show: [description of the app UI to display]
Device: [frame style]
Background: [treatment]
Colors: Tryps Red (#D9071C), Warm Cream (#F5EADB), Deep Slate (#3D3530)
Font: Plus Jakarta Sans Bold for headline
Style: [reference notes from Phase 2]

This screenshot should make someone stop scrolling and think:
"[the feeling we want to evoke]"
```

Deliverable: 6 exported screenshot assets ready for App Store Connect upload.

---

## Timeline

| Phase | Who | When |
|-------|-----|------|
| Phase 1: Research | Claude | Day 1 |
| Phase 2: Yes/No | Jake | Day 1-2 |
| Phase 3: Strategy | Jake + Sean + Claude | Day 2-3 |
| Phase 4: Execution | Sean + Jake (Figma Make) | Day 3-5 |

---

## Notes

- Google Play screenshots are different dimensions (1080x1920) — do iPhone first, adapt later
- Consider a "preview video" as screenshot slot 1 (Apple allows 3 app preview videos)
- App Store allows up to 10 screenshots but 6 is the sweet spot — most users see 3 before swiping
