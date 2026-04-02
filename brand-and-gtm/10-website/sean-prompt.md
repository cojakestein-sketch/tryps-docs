# jointryps.com Landing Page Redesign — Sean's Session

> Paste this entire file into a Claude Code session. It will guide you through the spec.
> Estimated time: 45–60 minutes.
> When you're done, Claude will write the spec and post in Slack that devs can take over.

---

## Context

We're redesigning jointryps.com to be Partiful-level quality. Right now the site is a basic landing page with a waitlist form. We need it to come correct — bold, confident, instantly communicates what Tryps is.

**Two things are happening in parallel:**
1. **This scope (you):** Landing page creative — hero, copy, product demo, animation, visual direction
2. **Eng scope (devs):** Full web client where people can manage their trips in the browser (like how Partiful lets you do everything on web)

Your job is the brand/creative side. The devs will build what you spec.

## The Reference

**Go look at [partiful.com](https://partiful.com) right now.** Use `/browse` to visit it. Study:
- The hero section (bold headline, subhead, one CTA)
- The phone mockup with a real event inside it
- The animated 3D elements (balloons, gems, confetti)
- The social proof ("100k+ ratings")
- The category nav (Easter, Birthdays, Dinners...)
- How the whole thing FEELS — confident, fun, not trying too hard

We want that energy but for group trips. Not a copy — a Tryps-flavored version.

## Brand Constraints

Read these files before you start:
- @~/tryps-docs/shared/brand.md — colors, fonts, voice, everything
- @~/tryps-docs/brand-and-gtm/10-website/objective.md — scope boundaries

Key rules:
- Font: Plus Jakarta Sans (NOT DM Sans, NOT Space Grotesk)
- Primary color: Tryps Red `#D9071C`
- Background: white/light gray (`gray-50`), NOT warm cream
- Tone: Cheeky, warm, group chat energy. NOT corporate, NOT travel magazine.
- Never say "AI." Martin is a travel agent you text, not an AI.
- Never use the word "crew"
- Visual motif: Film camera texture, disposable camera energy, passport warmth

## Your Task

### Step 1: Get grilled

Run `/grill-me` with this context:

> Redesigning the jointryps.com landing page to Partiful-level quality. Tryps is a group trip planning app — "Partiful but for travel." The hero of the product is Martin, a travel agent that lives in your iMessage. You text Martin, he plans your entire trip. The landing page needs to instantly communicate this and drive downloads/signups. Reference: partiful.com. The page lives in a Next.js app at ~/t4/website-tryps/.

The grill should force you to make decisions about:
- Headline and subhead copy
- What screen shows in the phone mockup (which trip? which conversation?)
- What the animated/3D elements are (Partiful has balloons — what does Tryps have?)
- Social proof strategy (what numbers do we have?)
- CTA copy and where it goes
- Category navigation (trip types? use cases?)
- Below-the-fold sections (features, how it works, testimonials?)
- Mobile responsiveness approach

### Step 2: Write the spec

After the grill, write the spec to this exact path:

```
~/tryps-docs/brand-and-gtm/10-website/spec.md
```

Use this frontmatter:

```yaml
---
id: website-redesign-spec
title: "jointryps.com Landing Page Redesign — Spec"
owner: sean
executor: dev-team
created: 2026-03-31
status: ready-for-dev
---
```

The spec must include:
1. **Hero section** — headline, subhead, CTA, visual concept (what's in the phone mockup, what's animated around it)
2. **Section-by-section breakdown** — every section below the fold, in order, with copy direction and visual direction
3. **Phone mockup brief** — exactly which screen/conversation to show, with the actual text content
4. **Animation/motion brief** — what moves, how, reference videos if possible
5. **Social proof strategy** — what numbers/badges/quotes to show
6. **Mobile layout** — how each section adapts
7. **Copy document** — actual headline candidates, subhead candidates, CTA text, section headers (at least 3 options each)
8. **Visual references** — screenshots or links to specific things you're drawing from

### Step 3: Signal "done"

When the spec is written, also create a handoff file at:

```
~/tryps-docs/brand-and-gtm/10-website/dev-handoff.md
```

This file should contain:
- One-paragraph summary of the creative direction
- Link to the spec: `brand-and-gtm/10-website/spec.md`
- What the devs need to build (section by section, in priority order)
- What assets Sean will provide separately (mockups, images, animations)
- What decisions are final vs. what devs can freestyle on

Then post in #alltryps:

> Landing page spec is done. Spec: `brand-and-gtm/10-website/spec.md` — Handoff: `brand-and-gtm/10-website/dev-handoff.md`. Ready for dev team to build. :partying_face:

---

## Files You'll Create

| File | What | Who reads it |
|------|------|-------------|
| `spec.md` | Full creative spec | Dev team builds from this |
| `dev-handoff.md` | Quick-reference handoff | Dev team reads first |

## Questions?

Ask Jake (he's around). Or just make the call — you know the brand.
