# Tryps Brand System

> Source of truth for brand decisions. Visual brand book lives in Figma.
> Code tokens live in `t4/utils/theme.ts`. This file bridges both.
> See also: [[brand-strategy]] | [[brand-and-gtm/README|Brand & GTM workspace]]
> Last updated: 2026-03-18

## Identity

- **Name:** Tryps
- **Domain:** jointryps.com
- **Tagline:** TBD (in development)
- **One-liner:** "Partiful but for travel" — group trip planning that replaces the scattered mess of iMessage + Google Docs + Splitwise

## Brand Direction (Draft — Pending Trent Review)

- **Tone:** Cheeky/knowing — group chat energy, not travel magazine
- **We are:** Warm, real, a little chaotic, funny, effortless
- **We are not:** Corporate, productivity-obsessed, luxury influencer, stock-photo polished
- **Brand essence:** Welcome.
- **Brand world:** "Your friends are magical, and getting them all in one place is the hard part. We handle that."
- **Brand personality:** Anthony Bourdain — traveled everywhere, genuinely curious, warm, no pretense, loved connection over luxury
- **Brand references:** Partiful, Poke AI, Venmo, Beli, Wispr Flow
- **Visual motif:** Film camera texture — grain, warmth, candid framing. Disposable camera energy is the anchor.

## Color Palette

Source: `t4/utils/theme.ts`

### Brand Colors
| Name | Hex | Usage |
|------|-----|-------|
| Tryps Red | `#D9071C` | Primary brand color, CTAs, logo. NOT for error states. |
| Tryps Red Dark | `#B00618` | Pressed/hover states |
| Tryps Red Light | `#E85050` | Light variant |
| Warm Cream | `#F5EADB` | Light mode background — passport-paper warmth |
| Warm Cream Light | `#FFFDF8` | Cards, elevated surfaces |
| Deep Slate | `#3D3530` | Warm charcoal, primary text color |
| Mist | `#EDE4D8` | Subtle background variant |

### Semantic Colors
| Name | Hex | Usage |
|------|-----|-------|
| Tropical Green | `#2D6B4F` | Success states |
| Sunset Gold | `#E8913A` | Warnings, accent |
| Error Red | `#D14343` | Error states (distinct from brand red) |
| Ocean Blue | `#2B5F83` | Info, accent |

### Dark Mode
- Background: `#1E1B19` (warm dark, not pure black)
- Cards: `#28241F`
- Primary shifts to `#E84040` for contrast on dark backgrounds
- All colors maintain warm undertones — never cool/blue-gray

## Typography

Source: `t4/utils/theme.ts`

| Role | Font | Weight |
|------|------|--------|
| Logo | Plus Jakarta Sans | 700 Bold |
| Display / Headlines | Plus Jakarta Sans | 700 Bold |
| Headings | Plus Jakarta Sans | 600 SemiBold |
| Body | Plus Jakarta Sans | 400 Regular |
| Medium emphasis | Plus Jakarta Sans | 500 Medium |
| Numbers / Dates / Prices | Space Mono | 400 Regular |

### Type Scale
| Token | Size | Use |
|-------|------|-----|
| display | 48px | Hero text |
| title / xxl | 28px | Screen titles |
| h1 / xl | 22px | Section headers |
| h2 | 18px | Subsections |
| body / base | 16px | Body text |
| caption | 13px | Secondary info |
| sm | 12px | Labels, metadata |
| xs | 11px | Fine print |

## Spacing Scale

| Token | Value |
|-------|-------|
| xs | 4px |
| sm | 8px |
| base | 12px |
| md | 16px |
| lg | 20px |
| xl | 24px |
| xxl | 32px |
| xxxl | 48px |

## Border Radius

| Token | Value | Use |
|-------|-------|-----|
| button | 10px | Buttons |
| input | 12px | Form inputs |
| card | 14px | Cards |
| pill | 999px | Chips, tags |

## Animation

- Transitions: 100ms (instant), 150ms (fast), 200ms (normal), 300ms (slow)
- Springs: snappy (damping 20, stiffness 300), bouncy (damping 12, stiffness 180)
- Shadows: very subtle — max 0.1 opacity, warm tone

## Voice & Tone

- **Formal ←→ Casual:** Leans casual (but not sloppy)
- **Serious ←→ Playful:** Leans playful (but not childish)
- **Respectful ←→ Irreverent:** Stays respectful (warm, not edgy)
- **Enthusiastic ←→ Matter-of-fact:** Stays enthusiastic (but grounded)

### Tone Modulation
- **Social:** Playful
- **Payments/billing:** More trustworthy
- **Onboarding:** Warmer

### Voice North Star
Every piece of Tryps copy should make the reader feel: "This is not some tacky gimmicky service. This is the way everybody is planning their trip this summer." Legitimacy + inevitability.

### We say / We don't say
- "your friends" or "your people" — NOT "your crew" (never use "crew")
- "trip" not "journey" or "adventure" (too precious)
- NOT "users" or "travelers"
- Short, punchy copy — group chat energy
- Okay to be funny, never mean
- No emojis or slang in agent/system copy — looks tacky
- Notifications: blend of functional and personality, NEVER spammy

## Key Rules

1. **Tryps Red is warm, not aggressive.** It comes from the logo. Never use it for error states — use `#D14343` instead.
2. **Warm Cream background conveys passport/travel paper.** This is intentional brand warmth, not a random beige.
3. **Plus Jakarta Sans everywhere.** The .pen file currently uses Space Grotesk — that's wrong and needs to be reconciled.
4. **Dark mode stays warm.** No cool grays, no pure black. Warm browns and creams even in dark.
5. **Shadows are barely there.** Max 0.1 opacity. The UI should feel flat-ish with just enough depth.

## Known Drift (To Resolve)

| System | Font | Red | Status |
|--------|------|-----|--------|
| theme.ts (code) | Plus Jakarta Sans | `#D9071C` | SOURCE OF TRUTH |
| tryps.pen (slides) | Space Grotesk | `#DC2626` | NEEDS FIX |
| Figma (brand book) | TBD | TBD | IN PROGRESS |

## Brand Strategy Status

- [ ] Foundational questions answered (in progress — see `docs/brand-intake-questionnaire.md`)
- [ ] Brand strategy doc written (not started — see `docs/plans/2026-03-18-feat-brand-strategy-and-brand-book-plan.md`)
- [ ] Direction deck created (not started)
- [ ] Brand book in Figma (not started — target: 30-40 screens)
- [ ] Trent review #1 (scheduled: next omakase)
