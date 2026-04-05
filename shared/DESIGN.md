# Design System: Tryps

## 1. Visual Theme & Atmosphere

Tryps is a group trip planning app that lives in your iMessage. The design language walks a specific line: warm enough to feel like a friend's recommendation, polished enough to feel like a product you trust with your money. Think Anthony Bourdain's travel show, not a luxury travel magazine. The UI should feel like opening a well-worn passport, not checking into a hotel lobby.

The foundation is Warm Cream (`#F5EADB`) — a passport-paper warmth that immediately separates Tryps from the cold whites and blue-grays of fintech and travel apps. This isn't beige by accident. It's the color of a stamped passport page, a paper boarding pass, a postcard. Against this warm canvas, Tryps Red (`#D9071C`) appears sparingly — logo, primary CTAs, and active states only. The red is warm and confident, pulled directly from the logo. It never appears in error states (that's `#D14343`), and it never overwhelms. One red element per screen maximum.

The typography is Plus Jakarta Sans throughout — a geometric sans-serif with rounded terminals that reads as friendly and modern without being childish. Weight 600 (SemiBold) is the workhorse for headings, creating confident but approachable hierarchy. Weight 400 (Regular) for body text, weight 500 (Medium) for emphasis. Space Mono handles all numbers, prices, dates, and data — giving financial and scheduling information a distinct, trustworthy voice. This dual-font system creates a clear separation: Jakarta speaks the brand, Space Mono speaks the facts.

Shadows are barely there. Maximum 0.1 opacity, always warm-toned. The UI feels flat-ish with just enough depth to separate layers — cards lift slightly off the cream canvas, modals dim the background, but nothing floats dramatically. This restraint is intentional: the content (your friends' photos, your trip itinerary, your group's votes) is the hero, not the chrome around it.

**Key Characteristics:**
- Warm Cream (`#F5EADB`) canvas — passport-paper warmth, never cold white
- Tryps Red (`#D9071C`) used sparingly — logo, primary CTAs, active states. One red element per screen max.
- Plus Jakarta Sans (400/500/600/700) for all UI text; Space Mono (400/700) for numbers, prices, dates
- Deep Slate (`#3D3530`) for text — warm charcoal, never pure black, never cool gray
- Shadows max 0.1 opacity — flat-ish with barely-there depth
- Border radius: 10px buttons, 12px inputs, 14px cards, 999px pills/chips
- Photography-forward — user photos and trip imagery are the primary visual content
- Film camera aesthetic — warmth, grain, candid energy. Not stock-photo polished.
- Dark mode stays warm: `#1E1B19` background, `#28241F` cards, warm browns throughout. Never cool gray.

## 2. Color Palette & Roles

### Brand
- **Tryps Red** (`#D9071C`): Primary brand color, CTAs, logo. Warm, confident, from the logo. NEVER for error states.
- **Tryps Red Dark** (`#B00618`): Pressed/hover states on primary buttons.
- **Tryps Red Light** (`#E85050`): Light variant, subtle highlights.
- **Primary Muted** (`rgba(217, 7, 28, 0.12)`): Selected states, light tints, subtle brand presence.

### Surface & Background (Light Mode)
- **Warm Cream** (`#F5EADB`): Page background — the passport-paper canvas. This IS the brand.
- **Warm Cream Light** (`#FFFDF8`): Cards, elevated surfaces, input backgrounds.
- **Mist** (`#EDE4D8`): Subtle background variant, secondary surfaces.
- **Background Wash** (`rgba(245, 234, 219, 0.95)`): Overlay tint, maintaining warmth.

### Surface & Background (Dark Mode)
- **Dark Warm** (`#1E1B19`): Page background — warm dark, not pure black. Brown undertone.
- **Dark Card** (`#28241F`): Cards, elevated surfaces.
- **Dark Elevated** (`#322D27`): Higher elevation surfaces, inputs.
- **Dark Primary** (`#E84040`): Red shifts lighter for contrast on dark backgrounds.

### Text
- **Deep Slate** (`#3D3530`): Primary text on light — warm charcoal with brown undertone. Never `#000000`.
- **Secondary** (`#7A6E63`): Descriptions, secondary information.
- **Muted** (`#A09588`): Placeholders, tertiary info, timestamps.
- **On Dark — Primary** (`#F5EFE7`): Primary text on dark surfaces — warm off-white.
- **On Dark — Secondary** (`#C4BAA8`): Secondary text on dark surfaces.
- **On Dark — Muted** (`#8A7F73`): Muted text on dark surfaces.
- **On Primary** (`#FFFFFF`): Text on red/brand backgrounds.

### Semantic
- **Tropical Green** (`#2D6B4F`): Success states. Muted, sophisticated — not neon.
- **Sunset Gold** (`#E8913A`): Warnings, accent. Warm and on-brand.
- **Error Red** (`#D14343`): Error states. Distinct from brand red — critical difference.
- **Ocean Blue** (`#2B5F83`): Info states, secondary accent.

### Segment Colors (Multi-city timelines, charts, group member assignment)
- Sky Blue `#4A90D9` / Emerald `#34D399` / Amber `#F59E0B` / Pink `#EC4899` / Violet `#8B5CF6` / Cyan `#06B6D4`
- Dark mode: brighten by ~10% for contrast (`#5AA0E9`, `#44E3A9`, `#FFAE1B`, `#FC59A9`, `#9B6CF6`, `#16C6E4`)

### Borders
- **Light Mode** (`#E0D6C8`): Card borders, dividers — warm, never cool gray.
- **Dark Mode** (`#3D3530`): Card borders on dark surfaces.
- **Focus Ring** (`rgba(217, 7, 28, 0.3)`): Focus state — subtle red glow.
- **Input Border** (`#E5E7EB`): Form inputs — slightly cooler for form contexts.

### Shadows
- **Small**: offset 0,1 / opacity 0.05 / radius 2 — barely perceptible lift
- **Medium**: offset 0,2 / opacity 0.06 / radius 4 — card elevation
- **Large**: offset 0,4 / opacity 0.08 / radius 8 — modal, dropdown elevation
- **XL**: offset 0,8 / opacity 0.1 / radius 16 — maximum elevation (use rarely)
- **Glow**: colored shadow using brand/semantic colors at 0.2 opacity — for active/selected states
- All shadows use `#000` base. Max opacity is 0.1. Warm surfaces make even neutral shadows feel warm.

### Gradients
- **Primary**: `#D9071C` → `#B00618` — subtle red deepening for hero CTAs
- **Accent**: `#D9071C` → `#2D6B4F` — red to green for trip progress, completion
- **Warm**: `#E8913A` → `#D07B2E` — gold deepening for highlights
- **Cool**: `#2B5F83` → `#3D3530` — blue to charcoal for info sections
- Dark mode variants shift lighter: `#E84040` → `#D93030`, etc.

## 3. Typography Rules

### Font Families
- **UI Text**: `Plus Jakarta Sans` — all headings, body, labels, navigation. Geometric with rounded terminals. Friendly, modern, never childish.
- **Data Text**: `Space Mono` — all numbers, prices, dates, times, currencies, scores. Monospace creates trust and precision for financial/scheduling data.
- **Fallbacks**: `system-ui, -apple-system, Segoe UI, Roboto, Helvetica Neue, sans-serif`

### Hierarchy

| Role | Font | Size | Weight | Line Height | Letter Spacing | Usage |
|------|------|------|--------|-------------|----------------|-------|
| Hero | Plus Jakarta Sans | 48px | 700 Bold | 1.1 (tight) | -0.5px | App hero text, splash screens. Rare — one per screen max. |
| Display | Plus Jakarta Sans | 36px | 700 Bold | 1.1 (tight) | -0.5px | Large display headings |
| Title | Plus Jakarta Sans | 28px | 700 Bold | 1.21 | -0.25px | Screen titles, primary headings |
| H1 | Plus Jakarta Sans | 22px | 600 SemiBold | 1.27 | -0.25px | Section headers within screens |
| H2 | Plus Jakarta Sans | 18px | 600 SemiBold | 1.33 | 0px | Subsection headers, card titles |
| Body | Plus Jakarta Sans | 16px | 400 Regular | 1.375 | 0px | Standard reading text, descriptions |
| Body Medium | Plus Jakarta Sans | 16px | 500 Medium | 1.375 | 0px | Emphasized body text, labels |
| Caption | Plus Jakarta Sans | 13px | 400 Regular | 1.38 | 0px | Secondary information, metadata |
| Small | Plus Jakarta Sans | 12px | 400–600 | 1.33 | 0px | Labels, tags, chips |
| XS | Plus Jakarta Sans | 11px | 400 Regular | 1.25 | 0px | Fine print, legal |
| Price/Number | Space Mono | 16px | 400 Regular | 1.375 | 0px | Prices, amounts, dates, times |
| Price Large | Space Mono | 22px | 700 Bold | 1.27 | 0px | Total amounts, hero numbers |
| Data Label | Space Mono | 12px | 400 Regular | 1.33 | 0.25px | Data labels, timestamps |

### Typography Principles
- **Negative letter-spacing on display sizes only.** -0.5px at 36px+, -0.25px at 22px+, 0 below. Tight headlines, breathing body.
- **SemiBold (600) is the heading workhorse.** Bold (700) reserved for hero/display/title only. Prevents weight inflation.
- **Space Mono for all data.** Any number a user needs to read precisely (prices, dates, flight times, expense splits) gets Space Mono. This isn't decoration — it's a trust signal.
- **No weight below 400.** Tryps is confident. Light/thin weights read as tentative.

## 4. Component Patterns

### Buttons

**Primary (Red)**
- Background: `#D9071C` (light) / `#E84040` (dark)
- Text: `#FFFFFF`, 16px, weight 600
- Padding: 14px vertical, 24px horizontal
- Border radius: 10px
- Pressed: `#B00618` (light) / `#D93030` (dark)
- Disabled: `#E8A8A8` (light) / `#4D3030` (dark) — muted, not grayed out
- Shadow: none at rest. Subtle glow (`rgba(217, 7, 28, 0.25)`) on press.
- One primary button per screen section. If you need two actions, the second is secondary.

**Secondary**
- Background: transparent
- Border: 1px solid `#E0D6C8` (light) / `#3D3530` (dark)
- Text: `#3D3530` (light) / `#F5EFE7` (dark), 16px, weight 500
- Hover/Press: background fills to `rgba(61, 53, 48, 0.05)` (light) / `rgba(245, 239, 231, 0.05)` (dark)
- Border radius: 10px

**Pill / Chip**
- Background: `#F5EADB` (light) / `#322D27` (dark)
- Text: `#3D3530` (light) / `#C4BAA8` (dark), 12–13px, weight 500
- Border radius: 999px
- Selected state: background `rgba(217, 7, 28, 0.12)`, text `#D9071C`, border `#F3B2B9`

### Cards
- Background: `#FFFDF8` (light) / `#28241F` (dark)
- Border: 1px solid `#E0D6C8` (light) / `#3D3530` (dark)
- Border radius: 14px
- Shadow: `sm` (offset 0,1 / opacity 0.05 / radius 2) — barely there
- Padding: 16px
- No card should have more than one visual "hero" element (photo, map, chart). Let it breathe.

### Inputs
- Background: `#FFFFFF` (light) / `#322D27` (dark)
- Border: 1px solid `#E5E7EB` (light) / `#4B5563` (dark)
- Border radius: 12px
- Focus: border shifts to `rgba(217, 7, 28, 0.5)`, outer ring `rgba(217, 7, 28, 0.3)`
- Placeholder: `#A09588` (light) / `#6B7280` (dark)
- Label: 14px, weight 500, `#4B5563` (light) / `#C4BAA8` (dark)

### Navigation
- Tab bar background matches page background with 0.95 opacity wash
- Active tab: Tryps Red icon + label
- Inactive: `#A09588` (light) / `#8A7F73` (dark)
- No borders on tab bar — it floats with the background wash

### Lists & Rows
- Row height: 56px minimum for tappable rows
- Divider: 1px `#E0D6C8` (light) / `#3D3530` (dark), inset 16px from leading edge
- Row padding: 16px horizontal
- Chevron/arrow: `#A09588` (light) / `#8A7F73` (dark)

### Modals & Sheets
- Background: `#FFFDF8` (light) / `#28241F` (dark)
- Overlay: `rgba(0, 0, 0, 0.5)` (light) / `rgba(0, 0, 0, 0.7)` (dark)
- Border radius: 20px top corners
- Handle: 36px wide, 4px tall, `#E0D6C8` (light) / `#3D3530` (dark)

### Avatars & Group Indicators
- Border radius: 999px (always circular)
- Sizes: 24px (inline), 32px (list), 40px (card), 56px (profile)
- Border: 2px solid `#FFFDF8` (light) / `#28241F` (dark) — matches card background for stacking
- Stacked avatars overlap by 25% with white border ring
- Group count badge: Tryps Red background, white text, 12px, weight 700

### Trip Card (Core Component)
- Full-width hero photo, 16:9 or 3:2 aspect ratio
- Photo has subtle warm overlay: `rgba(61, 53, 48, 0.03)` — just enough to unify varied photo temperatures
- Title: 22px, weight 600
- Date range: Space Mono, 13px, weight 400
- Location: 14px, weight 400, secondary text color
- People count: avatar stack + Space Mono count
- Card border radius: 14px
- The photo IS the card. Minimal chrome around it.

## 5. Spacing Scale

| Token | Value | Usage |
|-------|-------|-------|
| xs | 4px | Tight internal gaps, icon-to-text |
| sm | 8px | Related element spacing, chip padding |
| base | 12px | Default internal padding |
| md | 16px | Card padding, row padding, section gaps |
| lg | 20px | Between distinct groups within a section |
| xl | 24px | Section padding, major element gaps |
| xxl | 32px | Between screen sections |
| xxxl | 48px | Major section breaks, screen-level breathing room |
| huge | 64px | Hero spacing, top-of-screen padding |

### Spacing Principles
- **16px is the grid unit.** Most horizontal padding, card padding, and row spacing aligns to 16px.
- **Vertical rhythm doubles up.** If elements within a group are 8px apart, groups are 16px apart. Sections are 32px apart.
- **Breathing room scales with importance.** A trip card gets 32px below it. A list row gets 0px (divider only). Hero content gets 48–64px.
- **Never less than 44px tap target.** Buttons, rows, and interactive elements have minimum 44px touch height per iOS HIG.

## 6. Animation & Motion

| Token | Duration | Usage |
|-------|----------|-------|
| instant | 100ms | Immediate feedback (button press, toggle) |
| fast | 150ms | Quick transitions (color change, opacity) |
| normal | 200ms | Standard transitions (card expand, slide) |
| slow | 300ms | Deliberate transitions (modal appear, screen transition) |
| slower | 500ms | Dramatic transitions (onboarding, celebrations) |

### Spring Configs
- **Snappy**: damping 20, stiffness 300 — buttons, toggles, small interactions
- **Bouncy**: damping 12, stiffness 180 — card expansions, playful moments
- **Gentle**: damping 20, stiffness 120 — modals, sheets, large surfaces
- **Stiff**: damping 30, stiffness 400 — precise movements, snapping

### Motion Principles
- **Everything is interruptible.** Springs, not timings, for physical interactions. Users can grab, drag, release mid-animation.
- **Travel-themed celebrations only.** Confetti for trip creation, not for every action. Plane icon for booking confirmation. Keep celebrations rare and meaningful.
- **No loading spinners.** Skeleton screens with warm cream shimmer (`rgba(255, 255, 255, 0.8)` sweep). The app should feel alive even while loading.

## 7. Photography & Imagery

- **User photos are heroes.** Trip photos, destination imagery, and friend avatars are the primary visual content. The UI exists to frame them.
- **Warm photo treatment.** Subtle warm overlay on all user photos: `rgba(61, 53, 48, 0.03)` — unifies different photo temperatures into the brand palette without being noticeable.
- **Film camera energy.** The brand aesthetic references disposable cameras — warmth, grain, candid framing. When generating placeholder/marketing imagery, lean into this. Not HDR landscapes. Real moments.
- **No stock photos in the product.** Empty states use illustrations or iconography, never generic travel stock photography.
- **Photo aspect ratios.** Trip cards: 16:9 or 3:2. Avatars: 1:1 circular. Destination previews: 4:3. Story-style: 9:16.

## 8. Iconography

- **Style:** Line icons, 1.5px stroke weight, rounded caps and joins.
- **Size:** 20px default, 24px for navigation, 16px for inline/compact.
- **Color:** Inherits text color. Active/selected icons use Tryps Red.
- **No filled icons** except for active navigation tab state.
- **Travel-specific icons** should feel hand-drawn-ish, not corporate. A plane should have personality, not look like a airport wayfinding sign.

## 9. Voice & Tone in UI Copy

- **Short, punchy copy.** Group chat energy, not travel magazine prose.
- **"Your friends" or "your people."** Never "your crew" (forbidden), never "users" or "travelers."
- **"Trip" not "journey" or "adventure."** Keep it real, not precious.
- **No emojis in system copy.** Looks tacky. Users can use emojis. The app doesn't.
- **Notifications blend function and personality.** "Sarah voted for Barcelona" not "A vote has been cast."
- **Error messages are helpful, not cute.** "Couldn't load your trip. Pull to retry." not "Oops! Something went wrong."
- **North star:** Every piece of copy should make the reader feel: "This is not some tacky gimmicky service. This is the way everybody is planning their trip this summer."

## 10. Platform Notes (Expo / React Native)

- **StyleSheet.create() always.** No inline styles. Every component has a structured stylesheet.
- **`@/` path aliases.** Never relative paths like `../../`.
- **Theme tokens imported from `utils/theme.ts`.** Never hardcode color/spacing values. Always reference the theme.
- **Safe area handling.** All screens respect safe area insets. Navigation bars, tab bars, and bottom sheets account for home indicator.
- **Haptic feedback.** Light impact on button press, medium on toggle, heavy on destructive actions. Subtle, never annoying.
- **Platform-specific radius.** iOS gets the standard radius scale. Android gets the same values — no platform-specific overrides. Consistency across platforms.
