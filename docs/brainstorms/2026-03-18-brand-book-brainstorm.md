# Brand Book & Brand Strategy — Brainstorm

> **Date:** 2026-03-18
> **Context:** Post-meeting with Trent (Open Invite Studio). Jake drives brand development, Trent provides weekly paid consultation at omakase dinners.
> **Approach:** Strategy doc first, then direction deck, then brand book in Figma.

---

## What We're Building

A two-part brand system for Tryps:

1. **Brand Strategy Doc** (text, lives in tryps-docs) — answers the foundational "who are we" questions. Input for all design decisions.
2. **Brand Book in Figma** — 30-40 screens covering logo, color, typography, imagery, voice, social, and app-specific guidelines.

The strategy doc feeds the Figma brand book. Every visual choice has a "why" traced back to the strategy.

---

## Key Decisions

### 1. Brand Book Scope: 30-40 Screens

Based on research across agency guides, Figma Community templates, and real startup brand books (Uber, Slack, Airbnb), the right scope for Tryps at launch is **30-40 screens** organized into 10 sections:

| Section | Screens | Priority |
|---------|---------|----------|
| A. Front Matter (cover, TOC, intro, story) | 3-4 | Must |
| B. Brand Strategy (mission, vision, values, personality, audience, positioning) | 4-6 | Must |
| C. Logo (primary, variations, color versions, clear space, min size, placement, misuse, co-branding) | 6-8 | Must |
| D. Color (primary, secondary, extended, usage rules) | 3-4 | Must |
| E. Typography (overview, scale, usage, pairing, don'ts) | 3-5 | Must |
| F. Imagery & Illustration (photo style, don'ts, illustration, icons, patterns) | 3-5 | Phase 2 |
| G. Voice & Tone (voice, tone by context, writing guidelines, key messaging) | 2-4 | Must |
| H. Social Media (overview, profile assets, post templates, content style, tone, don'ts) | 4-6 | Phase 2 |
| I. Applications (business card, letterhead, presentations, email, signage, ads) | 4-6 | Phase 2 |
| J. Back Matter (asset downloads, contact) | 1-2 | Must |

**Minimum viable for launch: ~15 screens (sections A-E + G + J)**
**Full brand book target: 30-40 screens**

### 2. App-Specific Additions (5-8 extra screens)

Since Tryps is a mobile app, add these beyond a standard brand book:

- App icon & splash screen specs
- In-app color usage (functional colors, dark mode)
- Component library overview
- Motion & animation principles
- Onboarding screen style
- Empty states & error pages

### 3. Strategy Before Design

Trent's core philosophy: "never start designing until strategy is established." The process:

1. **Discovery** — Answer foundational questions (this week)
2. **Brand Strategy Doc** — Purpose, positioning, personality, voice (this week)
3. **Direction Deck** — 2-3 visual directions with moodboards (next week, review with Trent)
4. **Visual Identity** — Finalize logo, colors, type, imagery (week after)
5. **Brand Book** — Package into Figma (ongoing)

### 4. Figma ↔ Docs ↔ Code Bridge

The Figma bridge agent found **actual drift** between our systems:
- `t4/utils/theme.ts` uses Plus Jakarta Sans + `#D9071C` (Tryps Red)
- `tryps-docs/designs/tryps.pen` uses Space Grotesk + `#DC2626` (different red)
- Figma will be a third system entirely

**Solution — three sources of truth, connected:**

| Concern | Source of Truth |
|---------|----------------|
| Design tokens (colors, fonts, spacing) | `t4/utils/theme.ts` (what ships) |
| Visual brand book (logos, mockups, do/don't) | Figma |
| Brand narrative (voice, tone, mission, positioning) | `tryps-docs/shared/brand.md` (new file) |

**Sync flow:**
```
Figma (visual design)
  → brand.md (decisions extracted as text, auto-loaded via @import)
  → Claude Code sessions (all devs, all repos)
  → theme.ts (code implementation)
  → tryps.pen (slides stay in sync)
```

Manual "Brand Sync" ritual: whenever a brand decision is made in Figma, describe to Claude → Claude updates brand.md → Claude updates theme.ts if needed.

---

## Foundational Answers (Draft)

### Q1: Who is the core 1% power user?

**She's 24-30, already the "group chat CEO" — organizes dinners, creates shared albums, sends the "okay so here's the plan" text.** She plans 2-4 group trips/year using iMessage + Google Docs + Splitwise + willpower. She doesn't need to be sold on travel; she needs to be relieved of operational burden.

*Brand implication:* Make her feel seen, not marketed to. The brand should feel effortless and cool, not Type-A or productivity-oriented. She doesn't want a project management tool — she wants a tool that makes her look good at something she already does.

*Assumption to validate:* Female skew, mid-20s. Bucket's data (expected male adventure users, got female bachelorette planners) is the strongest signal but may not map 1:1.

### Q2: What specific pain points does the app solve?

**Coordination is unpaid, unappreciated labor that falls on one person, and current tools scatter information across 6 apps.** The real competitor isn't another travel app — it's the iMessage thread with 47 unread messages where someone asks "wait what hotel are we at" for the third time.

*Brand implication:* Tone should be knowing commiseration — "yeah, we know" energy. Not "planning is fun!" and not "planning is a nightmare." The film camera motif works here: capturing real moments, not performing perfection.

### Q3: Why do users return/engage repeatedly?

**Most users won't return on their own — they're pulled back by the power user creating the next trip.** Organizer retention loop: plan trip → trip is great → she gets social credit → plans next one, faster because the group already exists in Tryps. This is the Partiful model.

*Brand implication:* Serve two moments: the pull-in (participant gets a text, decides to engage — needs zero-friction) and the return (organizer uses Tryps again — needs to feel like coming home). The brand should feel like a living thing, not a one-time-use doc.

### Q4: What makes the experience feel good vs competitors?

**Competitors feel like work tools repurposed for fun. Tryps should feel like the trip has already started the moment you open it.** Other tools make you feel like a project manager; Tryps should make you feel like a host.

*Brand implication:* **Go cheeky/knowing, not inspirational.** Inspirational travel branding ("explore the world!") is what every airline does. Documentary is too earnest. Cheeky/knowing matches group chat energy — "we get it, planning with friends is hilarious and maddening and wonderful." Film camera motif works as visual texture (grain, warmth, candid framing) without dictating the tone.

### Brand World Summary

> Tryps is the tool for the person who already plans the trips. The brand should feel like the best group chat you've ever been in — warm, a little chaotic, funny, and real. The story isn't "travel is magical." The story is "your friends are magical, and getting them all in one place is the hard part. We handle that."

---

## Input Questions (87 total)

Full questionnaire saved at: `tryps-docs/docs/brand-intake-questionnaire.md`

**56 must-answer before design, 31 can refine later.** Organized by:
- Brand Purpose & Mission (8 questions)
- Target Audience & User Persona (13 questions)
- Brand Personality & Voice (10 questions)
- Visual Direction (16 questions)
- Competitive Positioning (9 questions)
- App-Specific Branding (12 questions)
- Social & Content Strategy (11 questions)
- Foundational / Cross-Cutting (8 questions)

---

## Open Questions

1. **Film camera motif — commit or explore alternatives?** It's being considered but not decided. The draft answers suggest using it as texture (grain, light leaks, candid framing) rather than a core identity element. Worth testing 2-3 directions.
2. **Red — keep or re-evaluate?** Current red `#D9071C` was chosen without systematic reasoning. The brand book process should either validate it with rationale or explore alternatives.
3. **Who designs the Figma brand book?** Jake + 2 adhoc Figma designers? Or ask Trent for the $3K sprint? Weekly consultation model was agreed but the actual Figma work needs a maker.
4. **First screen after download** — Trent flagged this as highest-value real estate. What goes here? Needs its own spec.
5. **Launch video vs brand book timing** — which comes first? The launch video needs brand direction, but the brand book needs user data. Current plan: enough brand foundation for the video, full brand book follows.

---

## Next Steps

1. **This week:** Jake answers the 56 must-answer questions from the intake questionnaire. React to the draft foundational answers — sharpen with Trent at next omakase.
2. **This week:** Create `tryps-docs/shared/brand.md` — extract tokens from theme.ts, add voice/tone notes, @import into global CLAUDE.md.
3. **Next week:** Direction deck with 2-3 visual directions (moodboards, color stories, type pairings). Review with Trent.
4. **Week after:** Begin Figma brand book — start with the 15 must-have screens.
5. **Ongoing:** Weekly Trent review of progress. Manual Brand Sync ritual to keep Figma ↔ docs ↔ code aligned.
