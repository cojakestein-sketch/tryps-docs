# Brand Book: Grid Setup + Figma Make Prompts

> All prompts ready for paste into Figma Make.
> Tryps library must be connected. Each prompt generates one 1920x1080 slide.
> After pasting into Figma, swap text "tryps" placeholder for real logo component.
> Created: 2026-03-19

---

## GRID SETUP — "Building the world" page

Do this manually in Figma before generating slides:

### Page setup
1. Go to the "Building the world" page in Figma
2. Set page background: `#1A1A1A`

### Section labels (text headers across top)
Create a text layer at the top of each column. Font: Plus Jakarta Sans Bold, 48px, color `#FFFFFF`.
Spacing: columns are ~2100px apart (1920px slide + 180px gap).

| Column | X Position | Label |
|--------|-----------|-------|
| 1 | 0 | Cover |
| 2 | 2100 | TOC |
| 3 | 4200 | 01 Brand Story |
| 4 | 6300 | 02 Mission & Vision |
| 5 | 8400 | 03 Brand Values |
| 6 | 10500 | 04 Brand Personality |
| 7 | 12600 | 05 Our Audience |
| 8 | 14700 | 06 Brand Essence |
| 9 | 16800 | 07 Visual Territory |
| 10 | 18900 | 08 Photography |
| 11 | 21000 | 09 Color System |
| 12 | 23100 | 10 Typography |
| 13 | 25200 | 11 Voice & Tone |
| 14 | 27300 | 12 Social Media |
| 15 | 29400 | 13 Logo |
| 16 | 31500 | 14 Applications |
| 17 | 33600 | 15 Brand in the Wild |
| 18 | 35700 | 16 Motion & Icons |
| 19 | 37800 | 17 App Design |
| 20 | 39900 | 18 Glimmers |
| 21 | 42000 | 19 Discover Tab |
| 22 | 44100 | 20 Assets & Contact |

### Slide frames
- Each slide: 1920x1080 frame
- Y position: 100 (below the label)
- Multiple slides in a column stack vertically: Y = 100, 1280, 2460, 3640...
- Name frames like: `03-Brand-Values-01`, `03-Brand-Values-02`, etc.

### Quick auto-layout shortcut
Select all 22 labels, then use Figma's auto-layout (Shift+A) with 2100px horizontal gap to align them perfectly. Or just place them manually.

---

## SLIDE PROMPTS

> Every prompt below is ready to paste into Figma Make.
> Key constraints baked into every prompt:
> - Fixed 1920x1080 presentation slide (not a website, no scrolling)
> - Background: white or very light gray (gray/50)
> - Tryps Red: #D9071C (brand accent, NOT for errors)
> - Text: deep warm charcoal
> - Font: Plus Jakarta Sans for all text, Space Mono for numbers
> - Use "tryps" as text placeholder where logo would go (top-right corner)
> - Film camera / disposable camera warmth as visual motif where appropriate
>
> **TODO (post-lunch 2026-03-24):** Update all prompts to reflect concierge/agent positioning.
> See `brand-and-gtm/01-brand-book/spec.md` for the new direction.

---

### COVER (Screen 01) — already exists, skip or regenerate

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A bold cover page for the Tryps brand book. Centered layout.

- Background: white
- Large text "tryps" in Plus Jakarta Sans Bold, lowercase, centered, color #D9071C
- Below it in smaller text: "Brand Book" in Plus Jakarta Sans SemiBold, dark charcoal
- Below that: "Less planning. More going." in Plus Jakarta Sans Regular, medium gray
- At the very bottom: "2026 | Confidential" in small text, light gray
- Subtle warm grain texture overlay at very low opacity
- Clean, minimal, confident. No illustrations or photos.
```

---

### TOC (Screen 02) — already exists, skip or regenerate

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A clean table of contents for a brand book. Left-aligned layout with generous whitespace.

- Background: white
- Top-right: small text "tryps" in #D9071C as logo placeholder
- Title: "Contents" in Plus Jakarta Sans Bold, 48px, dark charcoal, top-left
- Below: numbered section list in two columns, Plus Jakarta Sans Regular, 18px

Left column:
01  Brand Story
02  Mission & Vision
03  Brand Values
04  Brand Personality
05  Our Audience
06  Brand Essence
07  Visual Territory
08  Photography
09  Color System
10  Typography

Right column:
11  Voice & Tone
12  Social Media
13  Logo
14  Applications
15  Brand in the Wild
16  Motion & Icons
17  App Design
18  Glimmers
19  Discover Tab
20  Assets & Contact

- Section numbers in Space Mono, #D9071C
- Section names in Plus Jakarta Sans Regular, dark charcoal
- Generous line spacing (2x)
- Clean, editorial, minimal
```

---

### 01 BRAND STORY

**Screen 03-Brand-Story-01 — The Problem**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A dramatic opening slide for a brand book section about the problem being solved.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "01 Brand Story" in Plus Jakarta Sans Medium, medium gray
- Center of slide, large quote in Plus Jakarta Sans Bold, 44px, dark charcoal:
  "Everyone wants the trip to be amazing. But people have wildly different levels of effort they want to put into planning."
- Below the quote, smaller text in Plus Jakarta Sans Regular, 18px, medium gray:
  "Some want to control every detail. Some want to show up and be surprised. Everyone wants their viewpoint heard -- they just don't all want to do the work."
- Generous whitespace. No images. Let the words breathe.
- Bottom-left: thin horizontal line accent in #D9071C, about 80px wide
```

**Screen 03-Brand-Story-02 — Origin Story**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A brand origin story slide. Split layout: text on the left (60%), warm atmospheric image area on the right (40%).

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "01 Brand Story" in Plus Jakarta Sans Medium, medium gray
- Left side heading: "How it started" in Plus Jakarta Sans Bold, 32px, dark charcoal
- Left side body text in Plus Jakarta Sans Regular, 18px, dark charcoal, with comfortable line height:
  "Planning a trip to Chile with my roommate Quinn. Quinn wanted to plan every detail -- Google Docs, Notion, AI research scattered everywhere. I wanted to show up spontaneously.

  There was no way to consolidate everything, and no easy way for me to engage with what Quinn was trying to get the group to do.

  I saw the Partiful playbook and thought: nobody's done this for trips."
- Right side: a warm, film-grain-textured placeholder area with a subtle warm gradient (light beige to white), suggesting a photo would go here. Maybe a faint airplane or passport motif.
- Attribution at bottom-left: "-- Jake Stein, Founder" in Plus Jakarta Sans Medium italic, medium gray
```

**Screen 03-Brand-Story-03 — The Shift**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A bold statement slide showing a transformation. Large text, high impact.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "01 Brand Story" in Plus Jakarta Sans Medium, medium gray
- Two-part layout stacked vertically, centered:

Top half: crossed-out old way
  "One person carries the burden" in Plus Jakarta Sans Regular, 36px, medium gray, with a subtle strikethrough line

Bottom half: the new way
  "Everyone contributes a little" in Plus Jakarta Sans Bold, 48px, #D9071C

- A subtle arrow or visual transition between the two lines
- Below both: "That single shift is worth the download alone." in Plus Jakarta Sans Regular, 18px, dark charcoal
- Clean, bold, minimal. This is the thesis of the company.
```

---

### 02 MISSION & VISION

**Screen 04-Mission-Vision-01 — Mission**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A mission statement slide. Centered, powerful, minimal.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "02 Mission & Vision" in Plus Jakarta Sans Medium, medium gray
- Small label above the main text: "Our Mission" in Plus Jakarta Sans SemiBold, 14px, #D9071C, uppercase, letter-spaced
- Main text centered: "Make group trip planning effortless by democratizing the process -- so planning becomes the group's shared experience, not one person's burden." in Plus Jakarta Sans Bold, 36px, dark charcoal
- Maximum width of text block: 900px equivalent, centered
- Nothing else. Pure statement. Whitespace is the design.
```

**Screen 04-Mission-Vision-02 — Vision**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A vision statement slide. Aspirational, bold.

- Background: #D9071C (Tryps Red — full bleed color)
- Top-right: small text "tryps" in white
- Top-left: small section label "02 Mission & Vision" in Plus Jakarta Sans Medium, white at 60% opacity
- Center of slide:
  "Tryps is the one-stop shop for all things travel. Anything relating to you leaving your hometown and going somewhere else goes through Tryps." in Plus Jakarta Sans Bold, 40px, white
- Below: "Logo on the side of a plane." in Plus Jakarta Sans Regular italic, 20px, white at 80% opacity
- This is the only red-background slide in the book. It should feel bold and confident.
```

---

### 03 BRAND VALUES

**Screen 05-Brand-Values-01 — Overview**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A brand values overview slide showing 4 core values in a 2x2 grid layout.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "03 Brand Values" in Plus Jakarta Sans Medium, medium gray
- Heading: "What we stand for" in Plus Jakarta Sans Bold, 36px, dark charcoal
- Subheading: "These are real operating principles, not wall art." in Plus Jakarta Sans Regular, 18px, medium gray
- Below: 2x2 grid of value cards, each with:
  - A large number in Space Mono Bold, 64px, #D9071C (01, 02, 03, 04)
  - Value name in Plus Jakarta Sans Bold, 24px, dark charcoal
  - One-line description in Plus Jakarta Sans Regular, 16px, medium gray

Grid content:
01 — Sexy & Clean — "Looks so good your coolest friends want to be seen using it."
02 — Shareworthy — "You feel cool sending it. Sharing Tryps is a flex, not an ask."
03 — Obvious — "A five-year-old and a grandmother both get it instantly."
04 — Come Correct — "Every touchpoint is intentional. Nothing half-assed."

- Cards have very subtle borders or light gray backgrounds to define them
- Clean, structured, editorial layout
```

**Screen 05-Brand-Values-02 — Deep Dive**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A detailed brand values slide expanding on two values. Left-right split layout.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "03 Brand Values" in Plus Jakarta Sans Medium, medium gray

Left half — Value 1:
- "01" in Space Mono Bold, 48px, #D9071C
- "Sexy & Clean" in Plus Jakarta Sans Bold, 28px, dark charcoal
- Body: "The app looks so good your coolest friends want to be seen using it. If it doesn't look like something you'd screenshot, it's not done." in Plus Jakarta Sans Regular, 16px, dark charcoal

Right half — Value 2:
- "02" in Space Mono Bold, 48px, #D9071C
- "Shareworthy" in Plus Jakarta Sans Bold, 28px, dark charcoal
- Body: "You feel cool sending it. Sharing Tryps is a flex, not an ask. The trip card is the viral hook -- you HAVE to get on Tryps because you want to go on that trip." in Plus Jakarta Sans Regular, 16px, dark charcoal

- Thin vertical divider line between the two halves, light gray
- Generous padding and whitespace within each half
```

**Screen 05-Brand-Values-03 — What We'd Never Compromise**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A bold guardrail statement slide. Single powerful message.

- Background: very light gray (almost white)
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "03 Brand Values" in Plus Jakarta Sans Medium, medium gray
- Small label: "What we'd never compromise" in Plus Jakarta Sans SemiBold, 14px, #D9071C, uppercase, letter-spaced
- Large centered text: "Everyone uses Tryps for free. Always." in Plus Jakarta Sans Bold, 48px, dark charcoal
- Below: "A pro plan may exist eventually, but the core experience -- planning, vibing, coordinating with your people -- is never paywalled. Getting someone into Tryps has zero friction, zero cost." in Plus Jakarta Sans Regular, 18px, medium gray
- Maximum text width ~800px, centered
- Bottom accent: small horizontal line in #D9071C
```

---

### 04 BRAND PERSONALITY

**Screen 06-Brand-Personality-01 — We Are / We Are Not**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A brand personality slide with two columns: "We Are" and "We Are Not."

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "04 Brand Personality" in Plus Jakarta Sans Medium, medium gray

Left column — "We Are" heading in Plus Jakarta Sans Bold, 28px, dark charcoal:
- Effortless — makes hard things feel easy
- Inviting — warm, never exclusive
- Obvious — of course this exists
- Undeniable — this is clearly the way to do it
- Real — authentic, never performing

Right column — "We Are Not" heading in Plus Jakarta Sans Bold, 28px, medium gray:
- Corporate — no enterprise energy, no jargon
- Difficult — if it feels like work, we failed
- Gimmicky — not "look at this trick"
- Precious — not a luxury brand, not aspirational travel porn
- Pushy — never spammy, never desperate

Each item: trait in Plus Jakarta Sans SemiBold, 18px + description in Regular, 16px
- "We Are" items have a small #D9071C dot or dash before each
- "We Are Not" items have a small gray dot or dash
- Thin vertical divider between columns
```

**Screen 06-Brand-Personality-02 — If Tryps Were a Person**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A brand personality description slide. Atmospheric, storytelling feel.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "04 Brand Personality" in Plus Jakarta Sans Medium, medium gray
- Heading: "If Tryps were a person at a party" in Plus Jakarta Sans Bold, 32px, dark charcoal
- Large body text, Plus Jakarta Sans Regular, 20px, dark charcoal, left-aligned with max width ~700px:

"The most social person there. Friendly -- that's the big thing.

Dressed sleek, looks good, but not gaudy or designer. More utility-chic -- Arc'teryx, Patagonia vibe. Not trying to show off.

Just wants connection, wants to see their friends.

Talks in a way that's inviting. You walk away thinking 'I want to hang out with that person again.'"

- Generous line spacing (1.6x or 1.8x)
- Right side: a warm-toned abstract shape or gradient area (no photo), suggesting warmth
```

**Screen 06-Brand-Personality-03 — Celebrity Analog**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A bold reference slide naming the brand's celebrity analog. High impact.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "04 Brand Personality" in Plus Jakarta Sans Medium, medium gray
- Small label: "Celebrity Analog" in Plus Jakarta Sans SemiBold, 14px, #D9071C, uppercase, letter-spaced
- Large name: "Anthony Bourdain" in Plus Jakarta Sans Bold, 64px, dark charcoal, centered
- Below: description in Plus Jakarta Sans Regular, 20px, medium gray, centered, max width ~700px:
  "Traveled everywhere, genuinely curious, warm, no pretense, loved connection over luxury. Made you want to go places and meet people -- not because the places were fancy, but because the people were interesting."
- Minimal. The name is the hero. Let it breathe.
```

---

### 05 OUR AUDIENCE

**Screen 07-Our-Audience-01 — Primary Persona**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A target audience persona slide. Editorial, magazine-like layout.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "05 Our Audience" in Plus Jakarta Sans Medium, medium gray
- Heading: "The Group Chat CEO" in Plus Jakarta Sans Bold, 40px, dark charcoal
- Subheading: "Our primary persona" in Plus Jakarta Sans Regular, 18px, medium gray

Left side (55%):
- Demographics card with light gray background:
  "24-30 years old, post-grad
  Has some money after college, not wealthy
  More social than average, travels 2-4x/year
  Has friends who do NOT live in the same city"
  All in Plus Jakarta Sans Regular, 16px

- Below: "Already the planner -- organizes dinners, creates shared albums, sends the 'okay so here's the plan' text" in Plus Jakarta Sans Regular italic, 18px

Right side (45%):
- "Apps on their home screen" label in Plus Jakarta Sans SemiBold, 14px, #D9071C
- Grid of app names: Instagram, Pinterest, TikTok, Twitter, Partiful, Canva, Kayak, Expedia
  Each in a small rounded pill/chip, light gray background, dark text

- "Brands they identify with" label
- Two columns of brand names: Aritzia, ALD, Patagonia, New Balance, Sweetgreen, Blue Bottle, A24, Strava
```

**Screen 07-Our-Audience-02 — Role Cards**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A persona role cards slide showing three trip participant types in a row.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "05 Our Audience" in Plus Jakarta Sans Medium, medium gray
- Heading: "Everyone in the group chat" in Plus Jakarta Sans Bold, 32px, dark charcoal

Three cards in a horizontal row, equal width, each with very subtle light gray background and rounded corners:

Card 1:
- Icon area: a small warm-toned circle with a subtle relaxed/chill motif
- "The Reluctant Participant" in Plus Jakarta Sans Bold, 20px
- "Happy to be invited, wants to contribute without doing work" in Regular, 16px
- What they need: "Zero-friction engagement. Say the vibe, done." in Regular italic, 14px, medium gray

Card 2:
- "The Happy Joiner" in Plus Jakarta Sans Bold, 20px
- "Excited to be there, goes with the flow" in Regular, 16px
- What they need: "Easy access to the plan. 'Where am I supposed to be?'" in Regular italic, 14px, medium gray

Card 3:
- "The Co-Planner" in Plus Jakarta Sans Bold, 20px
- "Didn't start the trip but secretly wants to help plan everything" in Regular, 16px
- What they need: "Tools to contribute without stepping on the planner's toes." in Regular italic, 14px, medium gray

- Even spacing between cards, generous padding within each
```

**Screen 07-Our-Audience-03 — Positioning**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A brand positioning statement slide. Clean, strategic.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "05 Our Audience" in Plus Jakarta Sans Medium, medium gray
- Small label: "Positioning Statement" in Plus Jakarta Sans SemiBold, 14px, #D9071C, uppercase, letter-spaced
- Main text in Plus Jakarta Sans Bold, 28px, dark charcoal, centered, max width ~900px:
  "For the post-grad who just wants to see her friends back home, Tryps is the way she gets to see them all --"
- Continued below in Plus Jakarta Sans Regular, 22px, medium gray:
  "unlike Expedia or Kayak, which are inherently not social, and unlike group chats, where plans get buried and nothing gets done."
- At the bottom, a simple horizontal competitive positioning bar:
  Left end: "Not social" (with Expedia, Kayak labels)
  Right end: "Social but no action" (with iMessage, WhatsApp labels)
  Center-right, highlighted in #D9071C: "Tryps" in the sweet spot
```

---

### 06 BRAND ESSENCE

**Screen 08-Brand-Essence-01 — Welcome**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A dramatic brand essence reveal slide. The most impactful single word.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "06 Brand Essence" in Plus Jakarta Sans Medium, medium gray
- Small text above center: "When people hear 'Tryps,' they think:" in Plus Jakarta Sans Regular, 18px, medium gray
- Center of slide, massive: "Welcome." in Plus Jakarta Sans Bold, 120px, #D9071C
- Below: "The brand essence is the feeling of being invited somewhere you want to be, by someone who wants you there." in Plus Jakarta Sans Regular, 18px, dark charcoal, max width ~600px, centered
- Nothing else. This slide should hit hard. Maximum whitespace.
```

**Screen 08-Brand-Essence-02 — Archetype**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A brand archetype slide showing the primary and secondary archetypes.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "06 Brand Essence" in Plus Jakarta Sans Medium, medium gray
- Heading: "Brand Archetype" in Plus Jakarta Sans Bold, 32px, dark charcoal

Two-column layout:

Left column (larger, ~60%):
- Large "70%" in Space Mono Bold, 48px, #D9071C
- "The Host" in Plus Jakarta Sans Bold, 32px, dark charcoal
- "Warm, inviting, makes everyone feel welcome. Creates the space where the magic happens. Not the center of attention -- the reason attention gathers." in Plus Jakarta Sans Regular, 18px, dark charcoal

Right column (smaller, ~40%):
- "30%" in Space Mono Bold, 48px, medium gray
- "The Magician" in Plus Jakarta Sans Bold, 28px, dark charcoal
- "Makes the complex feel effortless. 'I just texted my friends and all of a sudden we're on a trip together.' Logistics disappear, connection appears." in Plus Jakarta Sans Regular, 16px, dark charcoal

- Subtle divider between columns
- Clean proportional layout showing the 70/30 split visually
```

---

### 07 VISUAL TERRITORY

**Screen 09-Visual-Territory-01 — Moodboard**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A visual territory / moodboard slide. Atmospheric, warm, collage-like.

- Background: very light warm gray
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "07 Visual Territory" in Plus Jakarta Sans Medium, medium gray
- Heading: "Visual Territory" in Plus Jakarta Sans Bold, 36px, dark charcoal

A grid/collage of 6-8 mood-evoking placeholder rectangles arranged asymmetrically:
- Various warm-toned gradient rectangles suggesting photos (beige, warm gray, soft red tint, sandy tones)
- Some with subtle film grain texture overlay
- Some slightly rotated (2-3 degrees) for a candid, pinned-to-wall feel
- One rectangle could have "film camera" text inside as a placeholder

Below the grid:
"Disposable camera energy. Candid, warm, real moments. Grain, texture, friends being friends." in Plus Jakarta Sans Regular italic, 16px, medium gray

- The layout should feel like a designer's inspiration board, not a rigid grid
```

**Screen 09-Visual-Territory-02 — Film Camera Anchor**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A photography direction slide establishing the film camera aesthetic as the visual anchor.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "07 Visual Territory" in Plus Jakarta Sans Medium, medium gray
- Heading: "The Film Camera Is Our Anchor" in Plus Jakarta Sans Bold, 36px, dark charcoal

Three-column layout showing the aesthetic pillars:

Column 1:
- "Grain" in Plus Jakarta Sans Bold, 24px, dark charcoal
- "Natural film grain, not digital noise. Warmth and texture that says 'this moment was real.'" in Regular, 16px

Column 2:
- "Warmth" in Plus Jakarta Sans Bold, 24px, dark charcoal
- "Warm color temperature throughout. Golden hour energy. Never cool-toned or clinical." in Regular, 16px

Column 3:
- "Candid" in Plus Jakarta Sans Bold, 24px, dark charcoal
- "Real friends in real moments. Motion blur is okay. Imperfection is the aesthetic." in Regular, 16px

Below all three: a horizontal strip placeholder area with warm beige gradient, suggesting a filmstrip or contact sheet, with a subtle sprocket hole motif at edges
```

**Screen 09-Visual-Territory-03 — Brand References**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A brand references / inspiration slide showing the brands Tryps admires.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "07 Visual Territory" in Plus Jakarta Sans Medium, medium gray
- Heading: "Brands We Admire" in Plus Jakarta Sans Bold, 32px, dark charcoal
- Subheading: "Design references, not competitors" in Plus Jakarta Sans Regular, 16px, medium gray

A 2x3 grid of reference cards, each with:
- Brand name in Plus Jakarta Sans SemiBold, 20px
- What we take from them in Regular, 14px, medium gray

Grid:
Partiful — "Social event energy, card-first design"
Wispr Flow — "Editorial typography, serif + sans pairing"
Venmo — "Social utility, friend-feed as product"
Airbnb — "Warm photography, belonging as design principle"
A24 — "Cultural taste without pretension"
Strava — "Activity as social identity"

- Each card has a very subtle border and generous padding
- Arranged in a clean 3-across, 2-down grid
```

---

### 08 PHOTOGRAPHY

**Screen 10-Photography-01 — Philosophy**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A photography philosophy slide. Atmospheric and editorial.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "08 Photography" in Plus Jakarta Sans Medium, medium gray
- Small label: "Photography Direction" in Plus Jakarta Sans SemiBold, 14px, #D9071C, uppercase, letter-spaced
- Large quote: "More relatable than aspirational. Real friends, real chaos." in Plus Jakarta Sans Bold, 40px, dark charcoal, max width ~800px
- Below: two bullet points in Plus Jakarta Sans Regular, 18px, dark charcoal:
  "Both photography and illustration, but film photography is the core identity."
  "Core demo in imagery: social people in their 20s, just graduated, authentic."
- Right side: large warm-toned placeholder rectangle with film grain texture, slightly rotated, suggesting a photo
```

**Screen 10-Photography-02 — Do's**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A photography do's slide with positive examples. Grid layout.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "08 Photography" in Plus Jakarta Sans Medium, medium gray
- Heading: "Yes" in Plus Jakarta Sans Bold, 36px, #D9071C with a checkmark

Six placeholder rectangles in a 3x2 grid, each with a warm-toned gradient and a descriptive label below:

Row 1:
- "Natural light, golden hour" — warm golden gradient placeholder
- "Real friends laughing" — warm beige gradient placeholder
- "Motion blur, candid action" — slightly blurred warm gradient

Row 2:
- "Local spots, not landmarks" — earthy warm gradient
- "Imperfect framing" — slightly off-center warm placeholder
- "Film grain warmth" — grainy textured warm placeholder

Each label in Plus Jakarta Sans Regular, 14px, dark charcoal
- Placeholders have rounded corners (14px) and subtle warm shadows
```

**Screen 10-Photography-03 — Don'ts**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A photography don'ts slide with negative examples. Grid layout with X marks.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "08 Photography" in Plus Jakarta Sans Medium, medium gray
- Heading: "Never" in Plus Jakarta Sans Bold, 36px, medium gray with an X mark

Six placeholder rectangles in a 3x2 grid, each with a cool/sterile gradient and a red X overlay, with labels:

Row 1:
- "Stock photography" — cold blue-gray gradient, red X
- "Luxury resort porn" — cold teal gradient, red X
- "Posed studio shots" — flat gray gradient, red X

Row 2:
- "Instagram influencer filters" — oversaturated gradient, red X
- "Empty landscapes (no people)" — cold green gradient, red X
- "Corporate/professional headshots" — neutral gray gradient, red X

Each label in Plus Jakarta Sans Regular, 14px, medium gray
- These placeholders intentionally feel cold and sterile compared to the warm "Yes" slide
```

---

### 09 COLOR SYSTEM

**Screen 11-Color-System-01 — Primary Palette**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A primary color palette slide showing the core brand colors with large swatches.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "09 Color System" in Plus Jakarta Sans Medium, medium gray
- Heading: "Primary Palette" in Plus Jakarta Sans Bold, 36px, dark charcoal

Three large color swatch rectangles in a row, each about 400px wide and 350px tall with rounded corners:

Swatch 1: #D9071C (Tryps Red)
- Large filled rectangle in #D9071C
- Below: "Tryps Red" in Plus Jakarta Sans SemiBold, 20px, dark charcoal
- Below: "#D9071C" in Space Mono, 14px, medium gray
- Below: "Primary brand color, CTAs. Never for errors." in Regular, 14px, medium gray

Swatch 2: #FFFFFF with subtle border (White / Light Background)
- White rectangle with light gray border
- Below: "White" in SemiBold
- Below: "#FFFFFF"
- Below: "Default background"

Swatch 3: #3D3530 (Deep Slate)
- Dark charcoal rectangle
- Below: "Deep Slate" in SemiBold
- Below: "#3D3530"
- Below: "Primary text color"

Clean, minimal, lots of breathing room
```

**Screen 11-Color-System-02 — Extended Palette**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

An extended color palette slide showing semantic and accent colors.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "09 Color System" in Plus Jakarta Sans Medium, medium gray
- Heading: "Extended Palette" in Plus Jakarta Sans Bold, 32px, dark charcoal

Two rows of smaller color swatches (about 200px x 150px each):

Row 1 — Semantic Colors:
- #2D6B4F "Tropical Green" — Success
- #E8913A "Sunset Gold" — Warning
- #D14343 "Error Red" — Errors (distinct from brand red)
- #2B5F83 "Ocean Blue" — Info, accent

Row 2 — Neutrals:
- #F5EADB "Warm Cream" — Card backgrounds
- #FFFDF8 "Warm Cream Light" — Elevated surfaces
- #EDE4D8 "Mist" — Subtle backgrounds
- #B00618 "Tryps Red Dark" — Pressed/hover states

Each swatch: filled rectangle, color name below in SemiBold 16px, hex in Space Mono 12px, usage in Regular 12px
```

**Screen 11-Color-System-03 — Usage Proportions**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A color usage proportions slide showing recommended ratios.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "09 Color System" in Plus Jakarta Sans Medium, medium gray
- Heading: "Color Usage" in Plus Jakarta Sans Bold, 32px, dark charcoal
- Subheading: "How much of each color in any given composition" in Regular, 16px, medium gray

A large horizontal stacked bar across the middle of the slide showing proportional color usage:
- 60% section in white (with "60% White / Light Gray" label) — largest section
- 25% section in #3D3530 (Deep Slate) — "25% Deep Slate"
- 10% section in #D9071C (Tryps Red) — "10% Tryps Red"
- 5% section split between accent colors — "5% Accents"

Below the bar, three rules in Plus Jakarta Sans Regular, 16px:
"Tryps Red is an accent, not a background. Use sparingly for maximum impact."
"Deep Slate replaces pure black. Warmer and more inviting."
"White dominates. Confidence lives in whitespace."

Labels use Space Mono for percentages, Plus Jakarta Sans for names
```

**Screen 11-Color-System-04 — Dark Mode**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A dark mode palette slide. The background of THIS slide is dark to demonstrate.

- Background: #1E1B19 (warm dark, NOT pure black)
- Top-right: small text "tryps" in #E84040 (shifted red for dark mode contrast)
- Top-left: small section label "09 Color System" in Plus Jakarta Sans Medium, white at 50% opacity
- Heading: "Dark Mode" in Plus Jakarta Sans Bold, 36px, white
- Subheading: "Warm. Never cool. Never pure black." in Regular, 18px, white at 70% opacity

Three color swatches on the dark background:

Swatch 1: #1E1B19 (current background)
- "Warm Dark" / "#1E1B19" / "Background"

Swatch 2: #28241F
- "Card Surface" / "#28241F" / "Cards, elevated surfaces"

Swatch 3: #E84040
- "Primary (Dark)" / "#E84040" / "Shifted for contrast"

Below: "All colors maintain warm undertones. No cool grays, no blue-gray. Even in darkness, Tryps feels warm." in Plus Jakarta Sans Regular, 16px, white at 60% opacity
```

---

### 10 TYPOGRAPHY

**Screen 12-Typography-01 — Type System**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A typography overview slide showing the two font families.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "10 Typography" in Plus Jakarta Sans Medium, medium gray
- Heading: "Type System" in Plus Jakarta Sans Bold, 36px, dark charcoal

Two-column layout:

Left column (primary font):
- "Plus Jakarta Sans" in Plus Jakarta Sans Bold, 48px, dark charcoal
- Below: specimen showing all weights:
  "Bold 700" in Bold
  "SemiBold 600" in SemiBold
  "Medium 500" in Medium
  "Regular 400" in Regular
  All at 24px, dark charcoal
- Below: "Headlines, body text, buttons, everything" in Regular, 14px, medium gray

Right column (secondary font):
- "Space Mono" in Space Mono Regular, 48px, dark charcoal
- Below: "0123456789" in Space Mono, 32px, dark charcoal
- Below: "$127.50 | Mar 24-31 | 4:30pm" in Space Mono, 20px, dark charcoal
- Below: "Numbers, dates, prices, data" in Plus Jakarta Sans Regular, 14px, medium gray

Clean separation between the two. The contrast between the humanist sans and the monospace should be visible.
```

**Screen 12-Typography-02 — Type Scale**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A type scale slide showing the full hierarchy from Display to XS.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "10 Typography" in Plus Jakarta Sans Medium, medium gray
- Heading: "Type Scale" in Plus Jakarta Sans Bold, 28px, dark charcoal

Left-aligned type specimens, each on its own line, actual size:

"Display" — Plus Jakarta Sans Bold, 48px — "Aa" sample + "48px / Bold"
"Title" — Plus Jakarta Sans Bold, 28px — "Aa" sample + "28px / Bold"
"H1" — Plus Jakarta Sans SemiBold, 22px — "Aa" sample + "22px / SemiBold"
"H2" — Plus Jakarta Sans SemiBold, 18px — "Aa" sample + "18px / SemiBold"
"Body" — Plus Jakarta Sans Regular, 16px — "Aa" sample + "16px / Regular"
"Caption" — Plus Jakarta Sans Regular, 13px — "Aa" sample + "13px / Regular"
"Small" — Plus Jakarta Sans Medium, 12px — "Aa" sample + "12px / Medium"
"XS" — Plus Jakarta Sans Regular, 11px — "Aa" sample + "11px / Regular"

Each line shows: token name (left, in Space Mono, #D9071C), then the specimen in actual size (center), then size/weight spec (right, in Space Mono, medium gray)
- Descending size creates a natural visual hierarchy on the slide
```

**Screen 12-Typography-03 — Type in Context**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A typography in context slide showing how type works in real UI compositions.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "10 Typography" in Plus Jakarta Sans Medium, medium gray
- Heading: "Type in Context" in Plus Jakarta Sans Bold, 28px, dark charcoal

Three mini UI mockup cards arranged horizontally:

Card 1 — "Trip Card" (light gray background, rounded corners):
- "Bali 2026" in Plus Jakarta Sans Bold, 24px
- "Mar 24 - Mar 31" in Space Mono, 14px, medium gray
- "Jake + 4 others" in Plus Jakarta Sans Regular, 14px

Card 2 — "Notification" (light gray background):
- "beach day won" in Plus Jakarta Sans SemiBold, 16px
- "4 votes to 1 -- what day should we plan it for?" in Regular, 14px
- "2m ago" in Space Mono, 12px, medium gray

Card 3 — "Expense" (light gray background):
- "Airbnb Deposit" in Plus Jakarta Sans SemiBold, 18px
- "$127.50" in Space Mono Bold, 24px, #D9071C
- "Split 5 ways" in Regular, 14px, medium gray

Each card has realistic padding and spacing. Shows the type system working in practice.
```

---

### 11 VOICE & TONE

**Screen 13-Voice-Tone-01 — Voice Principles**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A voice principles slide. Editorial and warm.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "11 Voice & Tone" in Plus Jakarta Sans Medium, medium gray
- Large quote at top: "Tryps sounds like a text from your most organized friend -- the one who's somehow fun AND has their shit together." in Plus Jakarta Sans Bold, 32px, dark charcoal, max width ~900px
- Below, three principles in a horizontal row:

Principle 1:
- "Lowercase Energy" in SemiBold, 20px
- "Short sentences. Group chat rhythm. Never stuffy." in Regular, 16px, medium gray

Principle 2:
- "Warm & Direct" in SemiBold, 20px
- "Say it like a friend would. No corporate speak." in Regular, 16px, medium gray

Principle 3:
- "Funny, Never Mean" in SemiBold, 20px
- "Humor serves warmth and relatability, not entertainment." in Regular, 16px, medium gray
```

**Screen 13-Voice-Tone-02 — Tone Spectrum**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A tone spectrum visualization slide with four slider bars.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "11 Voice & Tone" in Plus Jakarta Sans Medium, medium gray
- Heading: "Tone Spectrum" in Plus Jakarta Sans Bold, 32px, dark charcoal

Four horizontal slider bars stacked vertically with generous spacing:

Bar 1: "Formal" on left — "Casual" on right
  Dot positioned at 80% toward Casual. Fill: #D9071C

Bar 2: "Serious" on left — "Playful" on right
  Dot positioned at 75% toward Playful. Fill: #D9071C

Bar 3: "Respectful" on left — "Irreverent" on right
  Dot positioned at 35% toward Irreverent. Fill: #D9071C

Bar 4: "Enthusiastic" on left — "Matter-of-fact" on right
  Dot positioned at 30% toward Matter-of-fact. Fill: #D9071C

- Labels at each end in Plus Jakarta Sans Regular, 16px
- Bars are long (about 800px), thin, light gray track with #D9071C dot indicator
- Below all bars: "Leans casual and playful, stays respectful and enthusiastic." in Regular, 16px, medium gray
```

**Screen 13-Voice-Tone-03 — Tone by Context**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A tone modulation slide showing how voice shifts by context.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "11 Voice & Tone" in Plus Jakarta Sans Medium, medium gray
- Heading: "Tone Shifts by Context" in Plus Jakarta Sans Bold, 32px, dark charcoal

Five rows, each with context label, tone description, and an example:

1. "Social / In-App" — Most playful
   Example: "beach day won (4 votes to 1) -- what day should we plan it for?"

2. "Onboarding" — Warmest
   Example: "welcome -- what do you want this trip to feel like?"

3. "Payments" — More trustworthy
   Example: "your card was charged $127.50 for the Airbnb deposit"

4. "Errors" — Lighthearted
   Example: "that didn't work. try again?"

5. "Notifications" — Functional + personality
   Example: "Quinn added Sunset Cliffs to the itinerary"

Each row: context in SemiBold 18px #D9071C, tone in Regular 16px dark charcoal, example in Regular italic 16px medium gray (styled like actual app copy)
```

**Screen 13-Voice-Tone-04 — We Say / We Don't Say**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A word list slide with two columns: words we use and words we never use.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "11 Voice & Tone" in Plus Jakarta Sans Medium, medium gray
- Heading: "Word List" in Plus Jakarta Sans Bold, 32px, dark charcoal

Two columns:

Left — "We Say" (heading in SemiBold 24px, #D9071C):
- your friends — personal, warm
- your people — inclusive alternative
- trip — simple, universal
- vibe — captures the low-effort input
- welcome — brand essence word
- easy / effortless — core value prop
- obvious — how it should feel

Right — "We Never Say" (heading in SemiBold 24px, medium gray):
- journey — too precious
- adventure — over-romanticized
- users — they're people
- travelers — too formal
- explore — every travel brand says this
- unlock — growth-hack energy
- seamless — overused, says nothing
- curated — pretentious

Each word in SemiBold 18px, rationale in Regular 14px medium gray
- Thin vertical divider between columns
```

---

### 12 SOCIAL MEDIA

**Screen 14-Social-Media-01 — Strategy**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A social media strategy overview slide.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "12 Social Media" in Plus Jakarta Sans Medium, medium gray
- Heading: "Social Playbook" in Plus Jakarta Sans Bold, 36px, dark charcoal
- Subheading: "Brand-led, not founder-led. Follow the Wispr Flow playbook." in Regular, 18px, medium gray

Left side — Channel Priority (numbered list):
1. Twitter — more tech-focused tone
2. Instagram — more polished
3. TikTok — more raw
4. Pinterest
Numbers in Space Mono Bold, #D9071C. Channel names in SemiBold 20px. Descriptions in Regular 14px medium gray.

Right side — Content Rules:
- "Instagram grid stays pristine -- only Tryps-produced content. UGC goes in story highlights." in Regular, 16px
- "Organic posts: trip-first, Tryps-second. Product is embedded in the story, not the headline." in Regular, 16px
- "Content ratio: ~50/50 product and lifestyle." in Regular, 16px
- "No emojis or slang in agent/system copy." in Regular, 16px

Each rule has a small #D9071C bullet
```

**Screen 14-Social-Media-02 — Content Pillars**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A content pillars slide with four content categories.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "12 Social Media" in Plus Jakarta Sans Medium, medium gray
- Heading: "Content Pillars" in Plus Jakarta Sans Bold, 32px, dark charcoal

Four cards in a horizontal row:

Card 1: "User Stories"
- Number "01" in Space Mono Bold, 36px, #D9071C
- "Real people, real trips, real reconnections" in Regular, 16px

Card 2: "Normal People, Amazing Things"
- "02" in Space Mono Bold, 36px, #D9071C
- "Pulled off incredible trips because the app made it easy" in Regular, 16px

Card 3: "Trip Inspiration"
- "03" in Space Mono Bold, 36px, #D9071C
- "Framed as 'bringing people together,' not aspirational travel porn" in Regular, 16px

Card 4: "Destination Guides"
- "04" in Space Mono Bold, 36px, #D9071C
- "Lighter touch, practical, friend-recommended energy" in Regular, 16px

Each card: light gray background, rounded corners, generous padding
```

**Screen 14-Social-Media-03 — Voice North Star**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A bold statement slide with the voice north star for social content.

- Background: very light gray
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "12 Social Media" in Plus Jakarta Sans Medium, medium gray
- Center of slide, large text in Plus Jakarta Sans Bold, 36px, dark charcoal, max width ~900px:
  "Every piece of Tryps copy should make the reader feel: 'This is not some tacky gimmicky service. This is the way everybody is planning their trip this summer.'"
- Below in smaller text: "Legitimacy + inevitability." in Plus Jakarta Sans Bold, 24px, #D9071C
- Generous whitespace. Let this statement breathe.
```

---

### 13 LOGO

**Screen 15-Logo-01 — Primary Logo**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A logo presentation slide showing the primary logo. Clean and centered.

- Background: white
- Top-left: small section label "13 Logo" in Plus Jakarta Sans Medium, medium gray
- Center of slide: large text "tryps" in Plus Jakarta Sans Bold, 80px, #D9071C as a placeholder for the actual logo
  (Note: this text will be replaced with the real logo component after pasting into Figma)
- Below: "Primary Logo" in Plus Jakarta Sans Regular, 18px, medium gray
- Below: "Always use the official logo file. Never recreate from type." in Regular, 14px, medium gray
- Massive whitespace around the logo. Nothing else competes for attention.
```

**Screen 15-Logo-02 — Variations**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A logo variations slide showing the logo on different backgrounds.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "13 Logo" in Plus Jakarta Sans Medium, medium gray
- Heading: "Logo Variations" in Plus Jakarta Sans Bold, 28px, dark charcoal

A 2x2 grid of logo presentation boxes:

Box 1 (top-left): White background
- "tryps" text in #D9071C (placeholder for red logo on white)
- Label below: "Full Color on Light"

Box 2 (top-right): #3D3530 (Deep Slate) background
- "tryps" text in white (placeholder for white logo on dark)
- Label below: "White on Dark"

Box 3 (bottom-left): #D9071C background
- "tryps" text in white (placeholder for white logo on red)
- Label below: "White on Brand"

Box 4 (bottom-right): #1E1B19 (Dark Mode) background
- "tryps" text in #E84040 (placeholder for dark mode logo)
- Label below: "Dark Mode"

Each box is about 750x350px with rounded corners. Labels in Regular 14px medium gray.
```

**Screen 15-Logo-03 — Clear Space**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A logo clear space and minimum size rules slide.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "13 Logo" in Plus Jakarta Sans Medium, medium gray
- Heading: "Clear Space & Minimum Size" in Plus Jakarta Sans Bold, 28px, dark charcoal

Left half — Clear Space:
- Center "tryps" text in #D9071C (placeholder)
- Dashed lines around it showing the exclusion zone
- Label: "Minimum clear space = height of the 't' on all sides" in Regular, 14px
- Small arrows indicating the spacing

Right half — Minimum Size:
- Three sizes of "tryps" text getting smaller:
  - "Digital: 70px wide minimum" with a small logo
  - "Print: 20mm wide minimum" with a smaller logo
  - "Icon only: 24px minimum" with just a "t"
- Each with measurement annotations

Clean, technical, precise. This is the rules page.
```

**Screen 15-Logo-04 — Don'ts**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A logo misuse / don'ts slide showing what NOT to do with the logo.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "13 Logo" in Plus Jakarta Sans Medium, medium gray
- Heading: "Logo Don'ts" in Plus Jakarta Sans Bold, 28px, dark charcoal

A 3x2 grid of "don't" examples, each with a red X mark:

1. "tryps" text stretched horizontally — "Don't stretch or distort"
2. "tryps" text in blue/purple — "Don't change the color"
3. "tryps" text rotated 45 degrees — "Don't rotate"
4. "tryps" text with drop shadow — "Don't add effects"
5. "tryps" text on a busy/patterned background — "Don't place on busy backgrounds"
6. "TRYPS" in all caps — "Don't change the case"

Each example: small box with the misuse shown, red X in corner, label below in Regular 14px
- Red X marks are small circles with X in #D14343 (error red, not brand red)
```

---

### 14 APPLICATIONS

**Screen 16-Applications-01 — Trip Card**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A brand application slide showing the Trip Card as the hero design artifact.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "14 Applications" in Plus Jakarta Sans Medium, medium gray
- Heading: "The Trip Card" in Plus Jakarta Sans Bold, 32px, dark charcoal
- Subheading: "The single most polished design element in the app." in Regular, 16px, medium gray

Center: a large vertical card mockup (roughly 360x640px, 9:16 ratio):
- Warm gradient background (beige to soft gold) with film grain texture — placeholder for destination photo
- Bottom section with warm cream overlay:
  - "Bali 2026" in Plus Jakarta Sans Bold, 28px, dark charcoal
  - "Mar 24 - 31" in Space Mono, 14px
  - Row of 5 small circles (avatar placeholders) + "+3 more"
  - Small "tryps" text in bottom corner (like a film date stamp)
- The card has rounded corners (14px) and a subtle warm shadow

Right side: annotation callouts pointing to card elements:
- "Destination photo with film grain"
- "Trip name in display type"
- "Dates in Space Mono"
- "Friend avatars as social proof"
- "Logo watermark like a camera date stamp"
```

**Screen 16-Applications-02 — Email & Notifications**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A brand application slide showing email and notification design.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "14 Applications" in Plus Jakarta Sans Medium, medium gray
- Heading: "Email & Notifications" in Plus Jakarta Sans Bold, 28px, dark charcoal

Two mockups side by side:

Left — Push Notification mockup (phone notification style):
- "tryps" app icon placeholder (small red square)
- "Quinn added Sunset Cliffs to the itinerary" in SemiBold, 16px
- "2m ago" in Space Mono, 12px, medium gray
- Clean, minimal notification card style

Right — Email mockup (simplified):
- Header: "tryps" text in #D9071C
- Subject line: "You're going to Bali"
- Body preview: warm cream card showing trip details
- "Join the trip" button in #D9071C with white text
- Footer in small gray text

Below both: "Notifications blend functional and personality. Never spammy. Always sounds like a text from a friend." in Regular, 14px, medium gray
```

**Screen 16-Applications-03 — Merch & Physical**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A brand application slide showing merchandise and physical brand touchpoints.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "14 Applications" in Plus Jakarta Sans Medium, medium gray
- Heading: "Physical Touchpoints" in Plus Jakarta Sans Bold, 28px, dark charcoal

Four mockup placeholder areas arranged in a 2x2 grid:

1. T-shirt mockup area — warm gray placeholder rectangle
   Label: "Tee — minimal 'tryps' wordmark, left chest"

2. Sticker mockup area — small rounded rectangle placeholder
   Label: "Sticker — die-cut logo, matte finish"

3. Disposable camera mockup area — warm beige placeholder
   Label: "Tryps-branded disposable camera — first 100 trips"

4. Luggage tag mockup area — small vertical rectangle placeholder
   Label: "Luggage tag — warm cream, red logo, Space Mono flight number"

Below: "Do things that don't scale. The disposable camera program: we mail cameras to early trips, they shoot film, we develop it. Real photos for real trips." in Regular italic, 16px, dark charcoal
```

---

### 15 BRAND IN THE WILD

**Screen 17-Brand-Wild-01 — App Store**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A brand in the wild slide showing the app as it appears in the App Store.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "15 Brand in the Wild" in Plus Jakarta Sans Medium, medium gray
- Heading: "App Store Presence" in Plus Jakarta Sans Bold, 28px, dark charcoal

Center: a simplified App Store listing mockup:
- App icon placeholder (rounded square, #D9071C background with white "t")
- "Tryps" in bold, dark text
- "Less planning. More going." as subtitle
- Star rating placeholder: 4.9 stars
- "GET" button in #D9071C
- Below: three screenshot placeholder rectangles side by side (phone-shaped, warm-toned gradients)

Below the mockup: "The App Store listing is often the first brand impression. Every word, every screenshot, every detail matters." in Regular, 14px, medium gray
```

**Screen 17-Brand-Wild-02 — iMessage**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A brand in the wild slide showing Tryps in an iMessage conversation.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "15 Brand in the Wild" in Plus Jakarta Sans Medium, medium gray
- Heading: "In the Group Chat" in Plus Jakarta Sans Bold, 28px, dark charcoal

Center: a simplified iMessage conversation mockup:
- Blue bubble (right): "we should do something for spring break"
- Gray bubble (left): "yes please. where?"
- Blue bubble (right): "i made a trip on tryps, everyone join"
- Below: a rich link preview card with warm gradient and:
  - "Jake invited you to Spring Break 2026"
  - "jointr.yps/bali-2026"
  - Warm placeholder image area

Right side annotation: "The Open Graph preview IS the first impression. The iMessage bubble is the invitation for 80% of recipients." in Regular, 14px, medium gray

Below: "This moment -- a friend texting a link that looks beautiful -- is how Tryps grows." in Regular italic, 16px, dark charcoal
```

**Screen 17-Brand-Wild-03 — Social Posts**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A brand in the wild slide showing social media post templates.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "15 Brand in the Wild" in Plus Jakarta Sans Medium, medium gray
- Heading: "Social Templates" in Plus Jakarta Sans Bold, 28px, dark charcoal

Three social post mockup frames side by side:

1. Instagram Post (square):
   - Warm gradient placeholder for photo
   - Small "tryps" text overlay in bottom corner
   - Below: heart, comment, share icons
   - Caption preview: "less planning. more going." in small text

2. Instagram Story (vertical):
   - Full warm gradient background
   - "we should totally do that." in Plus Jakarta Sans Bold, white, centered
   - Small "tryps" logo text at bottom

3. Twitter/X Post:
   - Profile pic placeholder + "tryps" username
   - "For every 'we should totally do that.'" as tweet text
   - Warm trip card image preview below

Clean layout, realistic proportions
```

---

### 16 MOTION & ICONS

**Screen 18-Motion-Icons-01 — Motion Principles**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A motion design principles slide.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "16 Motion & Icons" in Plus Jakarta Sans Medium, medium gray
- Heading: "Motion Principles" in Plus Jakarta Sans Bold, 32px, dark charcoal

Three principle cards in a row:

Card 1: "Snappy"
- Specs in Space Mono, 14px: "damping: 20, stiffness: 300"
- "Quick, responsive, confident. The app reacts the instant you touch it." in Regular, 16px

Card 2: "Bouncy"
- Specs: "damping: 12, stiffness: 180"
- "Playful micro-interactions. Voting chips, friend avatars, celebration moments." in Regular, 16px

Card 3: "Subtle"
- Specs: "max shadow opacity: 0.1"
- "Shadows barely there. UI feels flat-ish with just enough depth. Wink, don't throw confetti." in Regular, 16px

Below all three:
"Transitions: 100ms instant | 150ms fast | 200ms normal | 300ms slow" in Space Mono, 14px, medium gray
```

**Screen 18-Motion-Icons-02 — Timing**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A motion timing reference slide with specific values.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "16 Motion & Icons" in Plus Jakarta Sans Medium, medium gray
- Heading: "Timing & Easing" in Plus Jakarta Sans Bold, 28px, dark charcoal

Four horizontal bars visualizing different timing values:

Bar 1: "100ms — Instant"
  Very short bar, #D9071C fill
  "Button taps, toggles, instant feedback" in Regular, 14px

Bar 2: "150ms — Fast"
  Short bar, #D9071C fill
  "Hover states, small transitions" in Regular, 14px

Bar 3: "200ms — Normal"
  Medium bar, #D9071C fill
  "Card transitions, navigation slides" in Regular, 14px

Bar 4: "300ms — Slow"
  Longer bar, #D9071C fill
  "Modal entries, page transitions" in Regular, 14px

Below: "Use spring animations for interactive elements. Use timed transitions for navigation. Never animate just because you can." in Regular, 16px, medium gray
```

**Screen 18-Motion-Icons-03 — Iconography**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

An iconography overview slide showing icon style principles.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "16 Motion & Icons" in Plus Jakarta Sans Medium, medium gray
- Heading: "Iconography" in Plus Jakarta Sans Bold, 28px, dark charcoal

A grid of 12 placeholder icon boxes (small rounded squares, light gray background) arranged in 2 rows of 6:
Row 1: home, search, calendar, map-pin, users, heart
Row 2: plane, camera, vote, split-bill, settings, bell

(Each box shows a simplified geometric placeholder for the icon)

Below the grid, three rules:
- "Consistent stroke weight: 1.5px at 24px size" in Regular, 16px
- "Rounded caps and joins — matches Plus Jakarta Sans curves" in Regular, 16px
- "Two tiers: UI icons (24px) and spot illustrations (48px)" in Regular, 16px

Right side: a larger icon construction example showing a 24px grid with a simplified icon placeholder and alignment guides
```

---

### 17 APP DESIGN

**Screen 19-App-Design-01 — Design Principles**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

An app design principles slide.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "17 App Design" in Plus Jakarta Sans Medium, medium gray
- Heading: "App Design Principles" in Plus Jakarta Sans Bold, 32px, dark charcoal

Four principles stacked vertically with numbers:

"01" (Space Mono, #D9071C) — "The trip card is the hero"
"Every screen revolves around the trip. The card is the artifact everyone shares." in Regular, 16px

"02" — "Social proof everywhere"
"Friend faces, activity feeds, who's-voted indicators. Humans are the interface." in Regular, 16px

"03" — "Zero-friction engagement"
"One tap to vote, one tap to join, one tap to RSVP. If it takes two taps, question it." in Regular, 16px

"04" — "Value before commitment"
"See the trip before logging in. Experience the plan before downloading. Show, then ask." in Regular, 16px

Clean, editorial, generous spacing between each principle
```

**Screen 19-App-Design-02 — Spacing & Radius**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A design tokens slide showing spacing scale and border radius values.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "17 App Design" in Plus Jakarta Sans Medium, medium gray
- Heading: "Spacing & Radius" in Plus Jakarta Sans Bold, 28px, dark charcoal

Left half — Spacing Scale:
Visual representation of spacing tokens as colored bars of increasing width:
- xs: 4px (tiny bar)
- sm: 8px
- base: 12px
- md: 16px
- lg: 20px
- xl: 24px
- xxl: 32px
- xxxl: 48px (largest bar)
Each bar in light #D9071C, token name and value in Space Mono, 14px

Right half — Border Radius:
Four example shapes showing different radii:
- Button: 10px radius (rounded rectangle)
- Input: 12px radius
- Card: 14px radius
- Pill: 999px radius (fully rounded)
Each with label and value in Space Mono, 14px
```

**Screen 19-App-Design-03 — Component Preview**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A component library preview slide showing key UI components.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "17 App Design" in Plus Jakarta Sans Medium, medium gray
- Heading: "Component Library" in Plus Jakarta Sans Bold, 28px, dark charcoal
- Subheading: "Full component library lives in the Figma design system file." in Regular, 14px, medium gray

A showcase grid of simplified UI components:

Row 1:
- Primary button: #D9071C background, white text "Join Trip", rounded 10px
- Secondary button: white background, #D9071C border, "Maybe Later"
- Text button: "Skip" in #D9071C, no background

Row 2:
- Input field: light gray border, "Enter destination" placeholder, rounded 12px
- Vote chip: light gray pill with "Beach day" text, rounded 999px
- Badge: small #D9071C circle with white number "3"

Row 3:
- Card: light gray background, rounded 14px, with trip info preview
- Avatar group: overlapping circles (3-4 friend placeholders)
- Toggle: #D9071C when on, gray when off

Clean, organized, showing the design system at a glance
```

---

### 18 GLIMMERS

**Screen 20-Glimmers-01 — The Trip Card Moment**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A "glimmer" slide highlighting the Trip Card as a key brand moment.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "18 Glimmers" in Plus Jakarta Sans Medium, medium gray
- Small label: "Aha Moment #1" in Plus Jakarta Sans SemiBold, 14px, #D9071C, uppercase, letter-spaced
- Heading: "The Trip Card" in Plus Jakarta Sans Bold, 36px, dark charcoal

Center-left: a vertical trip card mockup (same as screen 16 but slightly smaller)

Center-right: description text:
"A beautiful card that says 'so-and-so wants to go on a trip to New York' and you're like 'oh, I want in.'" in Plus Jakarta Sans Regular, 20px, dark charcoal

Below: "The card is the viral hook -- shareworthy, beautiful, makes you HAVE to get on Tryps." in Regular italic, 16px, medium gray

- Film grain texture accent in a corner
```

**Screen 20-Glimmers-02 — The iMessage Agent**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A "glimmer" slide highlighting the iMessage agent as a key brand moment.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "18 Glimmers" in Plus Jakarta Sans Medium, medium gray
- Small label: "Aha Moment #2" in Plus Jakarta Sans SemiBold, 14px, #D9071C, uppercase, letter-spaced
- Heading: "The iMessage Agent" in Plus Jakarta Sans Bold, 36px, dark charcoal

Center: a simplified iMessage mockup showing:
- Gray bubble: "where should we eat tonight?"
- A "Tryps" agent response bubble (distinct styling): "Based on everyone's votes, here are the top 3 spots near your hotel..."

Right side: description:
"You add this agent to iMessage and it's actually your travel agent. That's the 'holy shit this is real' moment." in Plus Jakarta Sans Regular, 20px, dark charcoal

Below: "The tech disappears -- you're just texting, and a trip is forming." in Regular italic, 16px, medium gray
```

**Screen 20-Glimmers-03 — The Voting Moment**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A "glimmer" slide highlighting the group voting experience.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "18 Glimmers" in Plus Jakarta Sans Medium, medium gray
- Small label: "Aha Moment #3" in Plus Jakarta Sans SemiBold, 14px, #D9071C, uppercase, letter-spaced
- Heading: "The Group Vote" in Plus Jakarta Sans Bold, 36px, dark charcoal

Center: two side-by-side vote card mockups:
Card 1: "Sunset Cliffs" — warm placeholder image area, progress bar at 75% (#D9071C fill), "4 votes"
Card 2: "La Jolla Cove" — warm placeholder image area, progress bar at 25% (gray fill), "1 vote"

Below the cards: "Your group picked Sunset Cliffs" in Plus Jakarta Sans SemiBold, 20px, #D9071C — with a subtle celebration indicator

Right side: "Visual cards with photos, not text lists. One tap to vote. Real-time tally. The winning option gets a warm celebration." in Regular, 16px, dark charcoal
```

**Screen 20-Glimmers-04 — The Emotional Payoff**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A powerful emotional quote slide. The deeper outcome.

- Background: very light warm gray
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "18 Glimmers" in Plus Jakarta Sans Medium, medium gray
- Small label: "The Deeper Outcome" in Plus Jakarta Sans SemiBold, 14px, #D9071C, uppercase, letter-spaced
- Large quote in Plus Jakarta Sans Regular italic, 28px, dark charcoal, centered, max width ~800px:
  "I have a group chat from college -- I haven't seen these boys in a year or two. If I could just send a Tryps link, it would probably get a lot of people to actually fly to a specific location. I'd get to see them more often. I miss these boys. Tryps helps me do that."
- Attribution: "-- Jake Stein" in Regular, 16px, medium gray
- This is the most emotional slide in the brand book. Maximum whitespace. Let the words do all the work.
```

---

### 19 DISCOVER TAB

**Screen 21-Discover-01 — Concept**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A Discover Tab concept slide showing the social trip discovery feature.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "19 Discover Tab" in Plus Jakarta Sans Medium, medium gray
- Heading: "Discover" in Plus Jakarta Sans Bold, 36px, dark charcoal
- Subheading: "Where trips find you" in Regular, 18px, medium gray

Left side: a simplified phone screen mockup showing:
- "Discover" header at top
- A vertical scrolling feed of trip card previews:
  - Card 1: "Bali 2026" — warm placeholder, "3 friends going"
  - Card 2: "Austin SXSW" — warm placeholder, "Quinn is organizing"
  - Card 3: "Spring Break Cabo" — warm placeholder, "7 people joined"
- Each card has friend avatars and a "Join" pill button in #D9071C

Right side: description text:
"Trip inspiration framed as 'your friends are doing this' — not aspirational travel porn.

The Discover feed surfaces trips from your extended network. You see a trip, you see friends already in it, you join." in Regular, 16px, dark charcoal
```

**Screen 21-Discover-02 — Recommendations**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A recommendations concept slide showing AI-powered trip suggestions.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "19 Discover Tab" in Plus Jakarta Sans Medium, medium gray
- Heading: "Recommendations" in Plus Jakarta Sans Bold, 32px, dark charcoal
- Subheading: "Powered by Travel DNA + friend activity" in Regular, 16px, medium gray

Center: a simplified recommendation card mockup:
- "Based on your Travel DNA" label in small text, #D9071C
- Large card: "Weekend in Joshua Tree" with warm desert-toned gradient placeholder
- "3 friends interested" with small avatar circles
- "Matches your vibe: outdoors, small group, spontaneous" in Regular italic, 14px

Below: two more recommendation reasons in a row:
- "Because Quinn went and loved it" — friend-based recommendation
- "Popular with Curators like you" — DNA-based recommendation

Each as a small card with warm styling
```

---

### 20 ASSETS & CONTACT

**Screen 22-Assets-Contact-01 — Resources**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

An assets and resources slide for brand book users.

- Background: white
- Top-right: small text "tryps" in #D9071C
- Top-left: small section label "20 Assets & Contact" in Plus Jakarta Sans Medium, medium gray
- Heading: "Brand Assets" in Plus Jakarta Sans Bold, 36px, dark charcoal

A clean list of downloadable assets:

"Logo Files" — SVG, PNG, PDF formats — "Available in Figma library"
"Color Tokens" — "theme.ts in the t4 codebase"
"Font Files" — Plus Jakarta Sans + Space Mono — "Google Fonts"
"Icon Set" — "Figma component library"
"Photography" — "Brand-approved photo library (coming soon)"
"Templates" — Social media, email, slide deck — "Figma library"

Each item: asset name in SemiBold 20px, details in Regular 14px medium gray
Small #D9071C bullet before each item
```

**Screen 22-Assets-Contact-02 — Closing**

```
Fixed 1920x1080 presentation slide, not a website, no scrolling.

A closing / colophon slide. Warm, confident, final.

- Background: #D9071C (Tryps Red — matches the vision slide for bookend effect)
- Center: "tryps" in Plus Jakarta Sans Bold, 64px, white (placeholder for logo)
- Below: "Less planning. More going." in Plus Jakarta Sans Regular, 24px, white at 80% opacity
- Below that: "jointryps.com" in Space Mono, 16px, white at 60% opacity
- At the very bottom: "Brand Book v1.0 | 2026 | Confidential" in Regular, 12px, white at 40% opacity
- Clean, bold, bookend to the cover. Red background makes it feel like a closing statement.
```

---

## SUMMARY

| Section | Screens | Names |
|---------|---------|-------|
| Cover | 1 | 01-Cover |
| TOC | 1 | 02-TOC |
| 01 Brand Story | 3 | 03-Brand-Story-01 through -03 |
| 02 Mission & Vision | 2 | 04-Mission-Vision-01, -02 |
| 03 Brand Values | 3 | 05-Brand-Values-01 through -03 |
| 04 Brand Personality | 3 | 06-Brand-Personality-01 through -03 |
| 05 Our Audience | 3 | 07-Our-Audience-01 through -03 |
| 06 Brand Essence | 2 | 08-Brand-Essence-01, -02 |
| 07 Visual Territory | 3 | 09-Visual-Territory-01 through -03 |
| 08 Photography | 3 | 10-Photography-01 through -03 |
| 09 Color System | 4 | 11-Color-System-01 through -04 |
| 10 Typography | 3 | 12-Typography-01 through -03 |
| 11 Voice & Tone | 4 | 13-Voice-Tone-01 through -04 |
| 12 Social Media | 3 | 14-Social-Media-01 through -03 |
| 13 Logo | 4 | 15-Logo-01 through -04 |
| 14 Applications | 3 | 16-Applications-01 through -03 |
| 15 Brand in the Wild | 3 | 17-Brand-Wild-01 through -03 |
| 16 Motion & Icons | 3 | 18-Motion-Icons-01 through -03 |
| 17 App Design | 3 | 19-App-Design-01 through -03 |
| 18 Glimmers | 4 | 20-Glimmers-01 through -04 |
| 19 Discover Tab | 2 | 21-Discover-01, -02 |
| 20 Assets & Contact | 2 | 22-Assets-Contact-01, -02 |
| **TOTAL** | **62** | |

---

## WORKFLOW REMINDER

1. Jake sets up grid on "Building the world" page per instructions above
2. For each slide: copy the prompt text (between the triple backticks) into Figma Make
3. Make generates the slide using Tryps library tokens
4. Jake clicks "Copy design" and pastes into the correct column/position in Figma
5. Jake swaps text "tryps" placeholder for the real logo component (top-right corner)
6. Repeat for all 62 slides

Pro tip: batch by section. Do all 3 Brand Story slides, paste them all, then move to Mission & Vision.
