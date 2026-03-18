# Designer Handoff: Flows 15-18 (Bottom Nav Tabs + Settings)

**Date:** March 11, 2026
**From:** Jake Stein
**For:** Krisna, Arslan

---

## TL;DR

Flows 15-18 cover the 4 bottom-nav tabs (Calendar, Explore, People, Profile/Settings) that **already exist in the app**. Your job:

1. **Open the app** and explore each tab
2. **Screenshot every screen/state** you encounter
3. **Redesign** with the Tryps visual language — you can reskin what's there AND propose layout/behavior improvements if you see a better approach
4. **Design empty states** (0 trips, 0 countries, 0 friends) — these don't exist yet

---

## What to Design

### Flow 15: Calendar Tab (10 screens)
Everything stays. Key screens:
- Calendar grid with trip bars spanning date ranges
- Trip countdown card
- Year stats (trips, days traveling, destinations)
- Timeline view (vertical chronological)
- Holiday suggestion panel (tap holiday emoji → destination cards) — **this stays**
- **Empty state** (0 trips) — **design this, it doesn't exist yet**

### Flow 16: Explore Tab (10 screens)
- 3D globe with visited/wishlist countries
- Country info card (the richest screen — hero, social proof, plan CTA, hot spots, trip history)
- Search, friends toggle, wishlist management, suggest a place
- **CUT: AI Chat Sheet + Chat FAB** — don't design these, they're Phase 2
- **Empty state** (first-time explorer) — **design this, it doesn't exist yet**

### Flow 17: People Tab (11 screens)
- **One unified screen** (the app currently has two overlapping views — treat People as a single screen with profile card + friends list + activity feed)
- Friend requests, activity feed, shared wishes, contact sync
- Profile share card (QR + link), user profile view, mutual friends
- **Empty state** (0 friends) — **design this, it doesn't exist yet**

### Flow 18: Profile & Settings (11 screens)
- Settings is ONE long scrollable screen with card/module sections
- Quick actions, DNA progress, payment accounts (Venmo/PayPal/Cash App), notifications, appearance, delete account
- Countries visited is the only separate full screen
- Profile completeness ring around avatar
- You can propose restructuring the layout if you see a better approach

---

## How to Work

1. **Install the app** via TestFlight (ask Jake for link if you don't have it)
2. **Create a test account** — you'll need trips, friends, and countries to see all states
3. **Screenshot everything** — every modal, sheet, overlay, empty state you can trigger
4. **Redesign in Figma** in the Official file, Design page
5. Use the existing Tryps design language (see `docs/figma/krisna-design-tokens.md` or reference existing Figma frames)

## What NOT to Design

- AI Chat / Chat FAB on Explore (cut)
- Tap-to-navigate handlers (dev handles these, no visual)
- Confetti animations (dev handles)
- The 3D globe itself (WebView/code-side — design the overlays and cards around it)

## Key Decisions from Jake

| Decision | Answer |
|----------|--------|
| Reskin only or propose changes? | **Both** — match functionality at minimum, propose improvements freely |
| Holiday suggestion panel? | **Stays** |
| AI Chat on Explore? | **Cut** — Phase 2 |
| People + Friends tabs? | **Merge into one screen** |
| Empty states? | **Design all of them** |

---

## Reference

Full screen-by-screen tables are in the FRD: `specs/frd-mar10.md`, Flows 15-18.
