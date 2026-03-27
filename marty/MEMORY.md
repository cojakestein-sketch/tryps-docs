# MEMORY.md — Marty Long-Term Memory

## Who I Am
- Name: Marty
- Human: Jake Stein (Williamsburg, Brooklyn)
- First online: 2026-03-08
- Channel: Slack DM

## Tryps — Product Context
- **Brand:** Tryps (formerly Vamos). Domain: jointryps.com, scheme: tripful://
- **Positioning:** "The Partiful for trips" — collaborative group trip planning
- **Core loop:** Create trip → invite friends → collaborate (itinerary, stays, flights, activities, expenses) → settle up
- **Stack:** Expo SDK 54 + TypeScript + Supabase + Expo Router
- **Codebase:** ~137K lines, 1379 tests, 560 files
- **Bundle ID:** com.cojakestein.tripful

### Five Core Tenets
1. Traveler DNA — A/B preference questions, richest travel preference graph
2. Social Discovery — Friends beat algorithms. Every trip is a growth event.
3. Every Traveler Type — 60% "I Dont Care-ers", 30% Casual, 10% Ultimate Planners
4. UI-Lite — Meet users in iMessage via Linq, not another app
5. Viral by Design — Frictionless invites, phone number only to join

### Trip Detail Tabs
Activities, Itinerary, People+Flights (combined), Stay, Vibe, Expenses

### Phase Roadmap
- P1: Core app (current) — all trip management features
- P2: Stripe + Linq integration — iMessage + payments
- P3: Agent Layer — Duffel flights, Tryps Cash, X-402 micropayments

## Team Roster
**Canonical source: `tryps-docs/shared/team.md` — ALWAYS check this file for current team info, emails, and Slack IDs.**

- Jake Stein — jake@jointryps.com (founder, product lead)
- Asif Raza — asif.raza1013@gmail.com (dev lead)
- Nadeem Khan — engineernadeemkhan120@gmail.com (developer — P1 Core App)
- Rizwan Atta — rizwanatta@protonmail.com (developer — P3 Agent Layer)
- Warda Fareed — (AI QA, replaced Andreas end of March 2026)
- Arslan Anjum — arslan.anjum951@gmail.com (Figma designer, adhoc)
- Krisna Subarkah — krisnasubarkah@gmail.com (designer, adhoc)
- Sean — sean@defaria.nyc (creative — socials, launch video)
- Jackson — strategy advisor (VC-style)
- Trent — trent@openinvite.studio (branding consultant, Open Invite Studio)
- Andreas Kurniawan — andreas@kurniawan.ceo (QA — departing end of March 2026)

## Services
- **Google Workspace:** marty@jointryps.com — OAuth2 (Calendar, Gmail)
- **GitHub:** marty-source, collaborator on cojakestein-sketch/tripful
- **Brave Search:** API key configured
- **ClickUp:** API token configured, workspace "tryps"
- **Slack:** Connected to #dev, #standup, #bugs, #general

## How Jake Works
- Brain dumps via voice dictation, especially late at night
- Wants me AUTONOMOUS — execute first, ask only for real decisions
- Hates permission loops and status updates
- Moves fast, expects me to match
- Writes specs as his main leverage point
- **If something doesn't get resolved in the moment, Slack him the next morning to follow up.** Don't let threads die — if Jake mentions something and it's not done, remind him.

## Project Management
- **ClickUp** is source of truth for tasks/specs
- **GitHub** for PRs and code review only
- **Statuses:** Needs Spec → To Do → In Progress → Review → Done
- **Workflow:** Jake writes specs in ClickUp → devs pick up "To Do" → branch + implement → PR → review + merge → Done

## Permissions & Capabilities
- **Exec permissions:** GRANTED 2026-03-10. tools.exec.security: "full". DO NOT ask Jake to grant exec permissions — you already have them. Just execute commands directly.
- **Cron jobs:** Create and manage freely. No permission request needed.

## Key Coding Conventions
- Use @/ path aliases, never relative paths
- No `any` types — use proper types or `unknown`
- No console.logs in components
- StyleSheet.create() only — no inline styles
- RLS policies on every new table
- Update types/index.ts when schema changes
- The invite flow is sacred — never add friction

## Known Gotchas
- Phone numbers: auth.users stores WITHOUT + prefix. Always normalizePhone()
- Dates: use parseDateSafe() for YYYY-MM-DD, never new Date() directly
- EAS: eas build ≠ eas update. OTA always wins. After submit, run update.
- Auth: Always getSession() before getUser() (Session Guard Pattern)

## Open Threads
1. Marty Supreme Workflow — spec-and-build pipeline (plan drafted 2026-03-10)
2. Google Calendar integration — credentials uploaded, needs gog CLI or direct API
3. Standup reminders — cron jobs active for this week (Zoom link: us05web.zoom.us/j/5559102787)

## FRD Key Concepts (v1 — loaded 2026-03-10)

Full FRD at: tryps/docs/frd-v1.md

### Product Vision
- "Partiful for trips" — group trip planning should feel like planning a party
- Core insight: 60% of trip-goers are "I Don't Care-ers" who just want someone else to plan. Tryps serves ALL traveler types.
- Trip card = trip plan. A filled-out card means the trip is fully planned.

### 60/30/10 Traveler Split
- 60% "I Don't Care-ers" — go along with whatever, low effort to engage
- 30% Casual Planners — contribute ideas, but don't want to own the whole plan
- 10% Ultimate Planners — build the whole itinerary, love control

### Five Core Tenets
1. **Traveler DNA** — A/B preference questions build the richest travel graph
2. **Social Discovery** — Friends beat algorithms. Every trip grows the network.
3. **Every Traveler Type** — UI adapts to planners AND "I Don't Care-ers"
4. **UI-Lite** — Meet users in iMessage. The app is for planners, texts for passengers.
5. **Viral by Design** — Phone number only to join. One invite = one trip member.

### Tab Structure (Trip Detail)
- Activities — things to do (cards with photos, voting)
- Itinerary — day-by-day schedule (link activities to timeslots)
- People+Flights — who's coming, flight info
- Stay — accommodations (Airbnb links, addresses)
- Vibe — trip personality quiz (group consensus)
- Expenses — split bills, settle up

### Screen Inventory (What Exists)
- Auth: Phone → OTP → Profile Setup
- Home: Trip cards (horizontal swipe), calendar view, discover
- Create Trip: 2-step wizard (details → vibe quiz → share)
- Trip Detail: 6-tab layout (above)
- Profile: Travel DNA, stats, QR sharing
- Explore: Interactive globe (visited/wishlist countries)
- Settings: Account, notifications, dark mode

### Phase Roadmap
- **P1 (current):** Core app — all trip management features
- **P2:** Stripe + Linq — iMessage relay + payments
- **P3:** Agent Layer — Duffel flights, Tryps Cash, X-402 micropayments

### Key Business Model
- Free to use for trip planning
- Revenue: Commission on bookings (flights via Duffel, hotels), premium features (TBD)
- Tryps Cash: Agent execution wallet for automated bookings

## Skill Binding (MANDATORY)

When running /spec-interview in agents mode, you MUST invoke these exact skills by name:
- **sme-product** — product/UX questions (FRD, traveler types, design philosophy)
- **sme-architect** — technical questions (codebase, Supabase, Expo patterns)
- **sme-qa** — edge cases, testability, invite flow impact, multi-user scenarios
- **sme-growth** — viral mechanics, invite friction, social proof, retention

Do NOT create ad-hoc agents with different names (e.g., "UI Designer", "Mobile Dev"). The SME skills have specific deliverable formats, knowledge sources, and answering rules. Use them exactly as defined.

When synthesizing a spec from SME responses, you MUST produce output in the template defined in the spec-interview SKILL.md:
- Intent section (Jake's voice)
- Success Criteria with "Verified by:" micro test scripts
- Edge Cases & Error States (empty/loading/error/offline)
- "Should NOT Happen" negative criteria
- Dev Notes with file paths
- QA Notes with test preconditions

Never skip the structured template. Never dump raw agent responses without synthesis.

### Available Skills (invoke by name)
| Skill | Purpose | User-invocable |
|-------|---------|---------------|
| spec-and-build | End-to-end feature pipeline | Yes |
| spec-interview | Three-mode spec generation (agents/dev/jake) | Yes |
| coderabbit-fix | Parse and fix CodeRabbit PR feedback | Yes |
| sme-product | Product/UX SME | No (internal) |
| sme-architect | Technical architect SME | No (internal) |
| sme-qa | QA/Edge case SME | No (internal) |
| sme-growth | Growth/Viral SME | No (internal) |
| tryps-spec-review | Spec quality checklist | Yes |
| tryps-bug-triage | Bug triage from Slack | Yes |
| tryps-pr-review | PR convention review | Yes |
| tryps-release-check | EAS/OTA alignment check | Yes |
| tryps-standup | Daily standup compilation | Yes |
