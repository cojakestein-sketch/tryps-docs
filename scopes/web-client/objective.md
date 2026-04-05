---
id: web-client
title: "Web Client — Full Trip Management on jointryps.com"
owner: jake
assignee: TBD
created: 2026-03-31
status: needs-spec
---

# Web Client — Full Trip Management on jointryps.com

> Make jointryps.com a first-class product experience. Anyone with a link can view a trip. Logged-in users can do everything they can do in the mobile app.

## The Vision

Partiful model: one URL does everything. `jointryps.com/trip/bali-2026` works for everyone — logged out users see a rich preview, logged in users get the full interactive trip. Same account as mobile (phone number auth). No app download required to participate.

## What's In Scope

### Web Client (Next.js, in `website-tryps/`)
- **Auth:** Phone OTP login/signup via Supabase (same account as mobile)
- **Home tab:** Your trips list, create trip
- **Trip detail — all core tabs:** Overview, Activities, Itinerary, People, Stay, Expenses, Packing
- **Travel DNA / Profile:** Your travel identity, settings
- **Public/gated data split:** Rich read-only view for anon visitors, full interactivity behind auth

### URL Structure
- Unified domain — no subdomain split
- `jointryps.com/` = marketing landing page (logged out) or dashboard (logged in)
- `jointryps.com/trip/[id]` = trip detail (preview if anon, full if authenticated)
- Same Next.js app serves both marketing and product

### Public vs. Gated Data

**Public (anyone with link):**
- Trip name, dates, locations, cover image
- Itinerary (day-by-day activities)
- Activity names + voting scores
- Participant first names + avatars
- Expense totals (per-person average)
- Accommodation name + link (NOT address)
- RSVP / Join button

**Gated (logged in + joined trip):**
- Participant full profiles / contact info
- Expense details (who owes whom), personal balance
- Accommodation address
- Flight details
- Packing list
- Comments / chat
- All write actions (vote, add expense, edit itinerary, etc.)

## What's NOT In Scope
- Calendar tab, Explore tab
- Legacy tabs (Vibe, Transport, Concerts, Photos)
- Landing page creative (separate scope: `brand-and-gtm/10-website/`)
- Programmatic SEO pages
- MCP server / AI distribution
- Travel DNA shareable card (separate scope, post-launch)

## Related Scopes

- [[core-trip-experience/objective|Core Trip Experience]] — web mirrors the mobile trip experience
- [[onboarding-teaching/objective|Onboarding & Teaching]] — web is an onboarding channel for non-app users
- [[travel-identity/objective|Travel Identity]] — Travel DNA / profile accessible on web
- [[brand-and-gtm/README|Brand & GTM]] — landing page creative lives in brand-and-gtm

## Dependencies
- Landing page spec from Sean (`brand-and-gtm/10-website/spec.md`) — for the marketing shell
- Supabase RPC expansion — `get_trip_preview()` currently returns counts only, needs full read-only data
- New RLS policies for anon access to trip detail data

## Technical Notes
- Existing site: `~/t4/website-tryps/` — Next.js 15, React 19, Tailwind, Supabase JS, deployed on Vercel
- Existing trip page: `/trip/[id]` already has server-rendered preview with dynamic OG images
- Expo app web config exists (`npm run web`) but is NOT the path — Next.js is the web client
- Current website fonts are wrong (DM Sans/Fredoka/Bebas Neue) — must be Plus Jakarta Sans per brand

## Reference
- [partiful.com](https://partiful.com) — the gold standard for web + mobile parity
- [partiful.com/events](https://partiful.com/events) — logged-in dashboard reference
