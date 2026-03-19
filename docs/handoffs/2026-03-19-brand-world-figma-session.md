# Pickup Prompt: Build the Tryps Brand World in Figma

> Copy everything below this line into a fresh Claude Code session.

---

## Context

I'm Jake, founder of Tryps — a group trip planning app (Expo + TypeScript + Supabase). I'm sitting with Sean (creative lead — socials, launch video) and we need to BUILD THE BRAND WORLD in Figma right now.

**The strategy work is DONE.** I answered 87 brand intake questions and wrote a full brand strategy doc. Now we need to turn that into ~50 Figma screens that define the Tryps world — visual identity, glimmers (key product moments), social presence, and applications.

### Repos & Key Files

| File | Path | What It Is |
|------|------|-----------|
| Brand Strategy Doc | `~/tryps-docs/shared/brand-strategy.md` | COMPLETED — mission, values, positioning, personality, voice, taglines, audience, visual direction |
| Brand Intake (87 Qs) | `~/tryps-docs/docs/brand-intake-questionnaire.md` | COMPLETED — all 56 must-answer questions filled out |
| Brand Tokens | `~/tryps-docs/shared/brand.md` | Color palette, typography, spacing — text source of truth |
| Screen Checklist | `~/tryps-docs/docs/brand-book-screen-checklist.md` | 46 screens mapped with status (7 exist, 39 new) |
| E2E Plan | `~/tryps-docs/docs/plans/2026-03-18-feat-brand-strategy-and-brand-book-plan.md` | Full 6-phase execution plan |
| Brainstorm | `~/tryps-docs/docs/brainstorms/2026-03-18-brand-book-brainstorm.md` | Discovery session, foundational answers |

### Figma File (WORK HERE)

**https://www.figma.com/design/CMhozPKkLjWk4pcKHsbTJF/Tryps---Official--work-here-?node-id=4130-536&p=f&t=EiLgnhc5V2meCgKk-0**

This file already has 7 screens: Logo (3 variants), Color palette grid, Typography overview, iOS App Icon (4 variants), Splash Screen (5 explorations), and Component Library. We are building ON TOP of this — not starting from scratch.

---

## Objective

Build ~50 Figma screens that define the Tryps brand world. This is the deliverable Sean and I are making today/this week. The brand strategy doc is the input — every visual choice traces back to a strategic decision already documented.

---

## Phase 1: Research Agents (Run in Parallel)

Before we start designing, spin up research agents to gather reference material. Run ALL of these in parallel:

### Agent 1: Best-in-Class Brand Books
Search for and fetch examples of the best startup/consumer app brand books. We need "build the world" deck structures — not just logo guidelines, but full brand worlds. Look for:
- **Airbnb** brand book / brand guidelines
- **Uber** brand guidelines
- **Slack** brand book
- **Partiful** (if any public brand assets exist)
- **Spotify** brand guidelines / design system
- **Figma Community** — search for "brand book template", "brand guidelines template", "brand world" templates
- **Dropbox** brand guidelines (known for excellent brand world)
- **Mailchimp** brand guidelines
- **Notion** brand guidelines
Return: screen-by-screen breakdown of what each brand book contains, with emphasis on sections beyond the basics (the "world-building" screens — moodboards, photography direction, motion principles, brand in context).

### Agent 2: Brand World / "Build the World" Decks
Search for what "building the world" means in brand design. Look for:
- Agency decks that show how to go from strategy → visual world
- Examples of "brand world" or "brand universe" presentations
- How top agencies (Pentagram, Collins, Koto, Ragged Edge) present brand work
- The structure of a direction deck vs a brand book
- What screens exist between "strategy" and "final guidelines" — the middle 60%
Return: a recommended screen structure for the "world-building" section that we can add to our Figma file.

### Agent 3: Social Media Brand Presence References
Search for the best social media brand presence examples for consumer apps targeting 20-30 year olds. Look at:
- **Wispr Flow** — their TikTok/Twitter/Instagram strategy (our north star for social)
- **Partiful** — social presence, grid aesthetic
- **Poke AI** — social presence
- **Beli** — social presence
- How these brands maintain visual consistency across Twitter, Instagram, TikTok
- Pinned tweet strategies for app launches
Return: screenshots/descriptions of profile layouts, grid aesthetics, pinned content, and bio copy patterns.

### Agent 4: Glimmer Design References
Search for the best examples of these specific product moments in other apps:
- Group chat invitation flows (Partiful, Luma, etc.)
- First-time app download / onboarding experiences (Duolingo, Headspace, Calm, Hinge)
- Voting/polling interfaces in apps
- Travel personality quiz UIs (BuzzFeed-style but elevated)
- Tooltip / teaching moment patterns in mobile apps
- Trip card / event card designs (Partiful cards, Apple Wallet passes)
Return: reference screenshots and descriptions of what makes each one work.

---

## Phase 2: The 50 Screens

Here is the full screen list organized into sections. Screens 1-46 are from the existing checklist. Screens 47-56 are the GLIMMERS — the 10 core moments that define how Tryps feels in the wild.

### A. Front Matter (3 screens)
| # | Screen | Status | Notes |
|---|--------|--------|-------|
| 1 | Cover | NEW | Logo on branded background, sets the tone for the whole deck |
| 2 | Table of Contents | NEW | Clickable section navigation |
| 3 | Brand Story / Introduction | NEW | Origin story (Chile trip with Quinn), what this doc is, who it's for |

### B. Brand Strategy (5 screens)
| # | Screen | Status | Notes |
|---|--------|--------|-------|
| 4 | Mission & Vision | NEW | "We exist to turn group chats into group trips." + 5yr vision |
| 5 | Brand Values | NEW | Sexy & Clean, Shareworthy, Obvious, Come Correct — with descriptions |
| 6 | Brand Personality | NEW | "We are / We are not" framework + Anthony Bourdain reference + party person |
| 7 | Target Audience / Persona | NEW | "The Group Chat CEO" — demographics, psychographics, brand affinities |
| 8 | Brand Positioning | NEW | Competitive landscape map, positioning statement, "what only Tryps does" |

### C. Logo (6 screens)
| # | Screen | Status | Notes |
|---|--------|--------|-------|
| 9 | Logo Primary | EXISTS | Already in Figma |
| 10 | Logo Variations | EXISTS | Already in Figma — light, dark bg, sizes |
| 11 | Logo Color Versions | EXISTS | Already in Figma — full color, white, dark |
| 12 | Clear Space & Minimum Size | NEW | Rules around existing logo assets |
| 13 | Logo Placement | NEW | How logo sits on photos, backgrounds, partner lockups |
| 14 | Logo Misuse / Don'ts | NEW | Stretch, recolor, effects — what NOT to do |

### D. Color (4 screens)
| # | Screen | Status | Notes |
|---|--------|--------|-------|
| 15 | Color Palette — Primary & Brand | EXISTS | Add hex/RGB, named roles, rationale to existing grid |
| 16 | Color Palette — Secondary & Semantic | NEW | Success (#2D6B4F), Warning (#E8913A), Error (#D14343), Info (#2B5F83) |
| 17 | Color Usage Rules | NEW | Approved combos, "Red is brand NOT error", contrast ratios |
| 18 | Dark Mode Palette | NEW | Warm dark (#1E1B19), how colors shift, no cool grays ever |

### E. Typography (3 screens)
| # | Screen | Status | Notes |
|---|--------|--------|-------|
| 19 | Typography Overview | EXISTS | Add "why these fonts" rationale. Note: exploring serif+sans departure (Wispr-inspired) |
| 20 | Type Scale & Hierarchy | NEW | display(48) → title(28) → h1(22) → h2(18) → body(16) → caption(13) → sm(12) → xs(11) |
| 21 | Typography Usage & Don'ts | NEW | Approved pairings, Space Mono for numbers/dates/prices |

### F. Imagery & Illustration (4 screens)
| # | Screen | Status | Notes |
|---|--------|--------|-------|
| 22 | Photography Style | NEW | Film camera aesthetic anchor — candid, grain, warmth, real friends, disposable camera energy |
| 23 | Photography Don'ts | NEW | No stock, no luxury influencer, no studio sets, no posed perfection |
| 24 | Illustration & Iconography | NEW | Icon style from existing Figma guide, stroke weight, grid |
| 25 | Patterns & Textures | NEW | Film grain, background textures, original Tryps motifs (not map pins/compasses) |

### G. Voice & Tone (4 screens)
| # | Screen | Status | Notes |
|---|--------|--------|-------|
| 26 | Brand Voice | NEW | Cheeky/knowing, spectrum mapping, lowercase energy |
| 27 | Tone by Context | NEW | Social=playful, Onboarding=warmest, Payments=trustworthy, Errors=quirky |
| 28 | Writing Guidelines & Word Lists | NEW | "we say/don't say", copy rules, NEVER use "crew" |
| 29 | Key Messaging | NEW | Tagline: "Less planning. More going." + campaign lines + elevator pitch |

### H. Social Media (4 screens)
| # | Screen | Status | Notes |
|---|--------|--------|-------|
| 30 | Platform Overview & Strategy | NEW | Twitter→IG→TikTok→Pinterest priority, distinct voice per platform |
| 31 | Profile Assets | NEW | Avatar, cover image, bio copy per platform |
| 32 | Instagram Grid & Content Style | NEW | Grid stays pristine (Tryps-produced only), UGC in highlights, trip-first storytelling |
| 33 | Post & Story Templates | NEW | Feed post, story, carousel, reel templates |

### I. Applications & Templates (4 screens)
| # | Screen | Status | Notes |
|---|--------|--------|-------|
| 34 | App Store Assets | NEW | Screenshots, description copy, feature graphics |
| 35 | Pitch Deck Template | NEW | Cover + content slides in brand |
| 36 | Email Signature | NEW | Team email template |
| 37 | Merch & Swag | NEW | T-shirts, stickers, hats, disposable cameras |

### J. App-Specific (8 screens)
| # | Screen | Status | Notes |
|---|--------|--------|-------|
| 38 | iOS App Icon | EXISTS | Light, Dark, White, Tinted — done |
| 39 | Splash Screen | EXISTS | 5 variations — pick winner, document |
| 40 | In-App Color Usage | NEW | Functional colors, status colors, brand palette → UI mapping |
| 41 | Component Library Overview | EXISTS | Inputs, pickers, alerts, badges, shadows, checkboxes |
| 42 | Motion & Animation | NEW | Springs (snappy/bouncy), transitions (100-300ms), micro-interactions |
| 43 | Onboarding Screens | NEW | First-screen-after-download — Trent flagged as #1 opportunity |
| 44 | Empty States & Errors | NEW | Branded zero-data states, lighthearted error pages |
| 45 | Dark Mode Showcase | NEW | Full dark mode with warm browns, never cool gray |

### K. Back Matter (1 screen)
| # | Screen | Status | Notes |
|---|--------|--------|-------|
| 46 | Asset Downloads & Contact | NEW | Where to find logos, fonts, templates. Who to ask. |

---

## GLIMMERS: 10 Core Moments to Perfect (Screens 47-56)

These are the moments where the brand comes alive. Each glimmer is a specific product/brand touchpoint that must feel unmistakably Tryps. Design these as hero screens in the brand book — they show the brand IN ACTION, not just the rules.

| # | Glimmer | What to Design | Strategic Reference |
|---|---------|---------------|-------------------|
| 47 | **Group Chat Invitation** | What the iMessage agent says when adding someone to a Tryps group chat. The first words someone hears from Tryps. Must feel like a text from a friend, not a system notification. | Brand strategy: "Welcome" is the brand essence. Voice: lowercase, warm, conversational. |
| 48 | **First App Download** | The screen someone sees after hearing about Tryps on social media and downloading it. Trent flagged this as the #1 highest-value real estate. Must communicate "you understand you've joined a trip and you're just communicating your vibe — and that's enough." | Intake Q61: "You understand you've joined a trip and you're just communicating your vibe." |
| 49 | **The Trip Card** | The Partiful-style card that says "so-and-so wants to go on a trip to New York." This IS the viral hook. Must be so beautiful you HAVE to get on Tryps. Shareworthy — a flex to send. | Aha moment #2. Brand value: Shareworthy. "The card is the viral hook." |
| 50 | **Activities & Voting** | The voting interface for trip decisions. Where democracy happens. Must feel effortless — say your vibe and you're done. Show the moment where "beach day won (4 votes to 1)." | Brand value: Obvious. Tone: playful. The reluctant participant just votes and they're done. |
| 51 | **Traveler DNA** | User identity and travel personality display. The "who you are" screen. One of the 3 most important screens in the app. Makes the between-trip experience compelling. | Intake Q62: Top 3 screens. "This or that" quiz building your travel personality. |
| 52 | **Vibe Quiz** | Onboarding experience when joining a trip. The bar to participate is as low as possible — just communicate your vibe. Not a form, not a survey — a vibe check. | First 30 seconds: "If you just have a vibe for what you want, you're done." |
| 53 | **Tooltips — First App Join** | Teaching moment when someone first opens the app. Must be encouraging, warm, not instructional or patronizing. Guide without overwhelming. | Brand personality: Obvious. "A five-year-old and a grandmother both get it instantly." |
| 54 | **Tooltips — First Trip Join / Profile Click / Explore Tab** | Teaching moments across key interactions. Each tooltip is a micro-brand moment — warm, short, group-chat energy copy. | Voice: "a text from your most organized friend." |
| 55 | **Twitter Profile** | Pinned content strategy, bio copy, header image, grid aesthetic. Twitter is platform #1 for launch (tech-focused tone). Must look legitimate and inevitable. | Social strategy: Twitter = more tech-focused. Brand-led, not founder-led. Wispr Flow playbook. |
| 56 | **Instagram Profile** | Grid aesthetic, bio copy, highlight covers, profile image. Grid stays pristine — only Tryps-produced content. Must look like the coolest travel brand your friend just discovered. | Social strategy: Instagram = more polished. UGC in highlights only. |

---

## Phase 3: Design the World

After research agents return, here's the workflow for Jake and Sean in Figma:

### Priority Order
1. **Glimmers first** (screens 47-56) — these define the FEELING before the rules
2. **Front Matter** (screens 1-3) — sets the tone
3. **Brand Strategy screens** (4-8) — visual version of the completed strategy
4. **Voice & Tone + Key Messaging** (26-29) — copy direction Sean needs for social/video
5. **Social Media** (30-33) — Sean's primary deliverable
6. **Everything else** — logo rules, color rules, typography, applications

### For Each Screen
1. Pull relevant content from `brand-strategy.md` (read the file — it has EVERYTHING)
2. Reference research agent findings for layout/structure inspiration
3. Design in the existing Figma file at the URL above
4. Keep it warm — Tryps Red (#D9071C), Warm Cream (#F5EADB), Plus Jakarta Sans (or serif+sans if exploring the Wispr-inspired direction)

### Key Brand Rules (Non-Negotiable)
- **Tryps Red (#D9071C)** is warm, not aggressive. NEVER use for error states.
- **Warm Cream (#F5EADB)** background = passport paper warmth, not random beige.
- **Dark mode stays warm.** No cool grays, no pure black. Background: #1E1B19.
- **Shadows barely there.** Max 0.1 opacity.
- **No emojis** in brand book copy.
- **NEVER** use the word "crew."
- **Film camera aesthetic** is art direction (grain, warmth, candid) — not the entire identity.
- **Anthony Bourdain** is the personality north star.
- **"Welcome"** is the brand essence word.

---

## What I Need From You

1. **Run all 4 research agents in parallel** — return findings before we start designing
2. **Read `~/tryps-docs/shared/brand-strategy.md`** — this is the source of truth for all content
3. **Read `~/tryps-docs/shared/brand.md`** — this has the exact color/type/spacing tokens
4. **Help us design each screen** — pull content from strategy, suggest layouts based on research, write copy in brand voice
5. **Update the screen checklist** (`~/tryps-docs/docs/brand-book-screen-checklist.md`) as we complete screens — add the glimmers section

Start with the research agents, then we'll dive into Figma together.
