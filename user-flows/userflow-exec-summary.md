# Tryps User Flows — Executive Summary

**Date:** 2026-03-06
**For review with:** Asif (Dev Lead)
**Status:** Entry flows defined (A-D) + Trip Creation (E). Feature flows (F-T) in progress.

## User Types (5)

| # | Type | Description |
|---|------|-------------|
| 1 | New User (via invite) | Clicks invite link, no account |
| 2 | New User (organic) | Downloads from App Store, no invite context |
| 3 | Returning User | Has account, opens app normally |
| 4 | Trip Owner | Created a trip — full control including delete |
| 5 | Trip Member | Joined a trip — co-hosts noted as variant with elevated permissions |

**Rule:** Phone number required for all users. No anonymous browsing. No viewer role.

---

## Entry Flows (A-D)

### Flow A: Organic New User
Download -> Welcome -> Phone Auth -> Contacts Permission -> Onboarding Opt-in -> (Optional Tour) -> Empty Home

- **Welcome screen:** Static lighthouse photo, "Your Next Adventure Starts Here", "Start Planning" CTA
- **Auth:** Phone entry with country picker -> OTP (6-digit SMS code)
- **Contacts permission:** System prompt after auth
- **Onboarding tour:** 4 template screens (Create a Trip, Travel DNA, Invite People, Plan Together). Always opt-in with skip option. Designed last after all features built.
- **Lands on:** Home (empty state, no trips)

### Flow B: Invited New User
Receive Link -> (Web Preview if no app) -> In-App Invite Preview -> Phone Auth -> Contacts Permission -> Auto-Join -> Vibe Quiz (full) -> Onboarding Opt-in -> Activities Tab

- **Web preview (no app installed):** Mini trip card on jointryps.com with "Get Tryps" App Store link. Preserves deep link for post-install routing.
- **In-app invite preview:** Trip name, location, dates, participant avatars, activity count. "Join This Trip" button.
- **Auth context:** Phone entry screen shows InviteTripCard ("Sign in to join [Trip Name]")
- **Auto-join:** Atomic operation — trip_members + participants created, push permission requested at value moment
- **Vibe Quiz:** Full 10 questions (first time, no defaults)
- **Onboarding:** Opt-in screen after quiz — "Show me how to use Tryps" / "Skip"
- **Lands on:** Trip Detail -> Activities tab

### Flow C: Invited Existing User
Tap Link -> In-App Invite Preview -> Join -> Vibe Defaults Screen -> Activities Tab

- **Shortest flow:** Already authenticated, 3 screens to get in
- **Vibe Defaults:** Shows pre-filled answers from previous trip's Travel DNA. Two CTAs:
  - "Go with my defaults" (big) -> apply existing DNA, skip quiz
  - "Edit my preferences for this trip" (small) -> quiz with answers pre-filled
- **Lands on:** Trip Detail -> Activities tab

### Flow D: Returning User
Open App -> Splash -> Home OR Active Trip Itinerary

- **Cold launch, no active trip:** Home (My Trips, upcoming)
- **Cold launch, active trip today** (today between start/end dates): Trip Detail -> Itinerary tab
- **Backgrounded (still in memory):** Exactly where they left off
- **No interstitials:** No "what's new", no update banners. Instant.

---

## Flow E: Trip Creation

### Wizard Steps
1. **Trip Title** — manual text entry (only hard requirement)
2. **Destinations** — 5 possible paths (see matrix below)
3. **Dates** — 4 possible paths (see matrix below)
4. **Cover Image** — auto from destination / manual upload / stock picker
5. **Card Customization** — font (7 options) + theme (10 options), swipeable preview
6. **Next -> Vibe Quiz** — 6 dimensions
7. **Create -> Success Modal** — share options (copy link, share sheet)

### Destination Paths (5)

| Code | Path | Description |
|------|------|-------------|
| D1 | Single destination | 1 chip selected, locked |
| D2 | Multi-city (visit all) | 2+ chips, sequential itinerary, max 6 cities, draggable timeline for day allocation |
| D3 | Group votes (seeded) | 2+ chips, group picks. Owner configures: deadline (24h/48h/1wk), max winners (1/2/3), group can suggest toggle |
| D4 | Group suggests (no seeds) | 0-1 chips, group proposes + votes post-creation |
| D5 | No destination | Skipped, "Destination TBD" |

### Date Paths (4)

| Code | Path | Description |
|------|------|-------------|
| T1 | Exact dates | Start + end picked on calendar |
| T2 | Group votes (seeded) | Flexible mode, weekend chips selected from smart suggestions |
| T3 | Flexible/TBD (no seeds) | Flexible mode, nothing selected, group suggests post-creation |
| T4 | No dates | Skipped, "Dates flexible" |

### Combination Matrix (5 x 4 = 20 combos)

Destinations and dates combine independently. Key combos:

| Combo | Name | Notes |
|-------|------|-------|
| D1 x T1 | "Fully planned" | Simplest. Everything decided. |
| D2 x T1 | "Full itinerary" | Multi-city + dates -> draggable timeline for per-city day allocation |
| D3 x T2 | "Everything votes" | Both destination + date voting cards active simultaneously |
| D4 x T3 | "Blank canvas" | Maximum openness — group suggests everything |
| D5 x T4 | "Just a title" | Pure placeholder. Only name required to create. |

### Voting Mechanics
- **Who votes:** Trip members only (RLS enforced)
- **Deadline:** 24h / 48h / 1 week (configurable). NOT auto-enforced — owner must manually "Lock it in"
- **Ties:** Owner is tiebreaker, can pick any option
- **Unlock:** Owner can reopen voting after finalizing
- **Parallel:** Destination + date votes run simultaneously, single deadline

### Post-Creation
- Success modal with share options -> Invite & Share flow
- Trip is immediately visible on Home screen
- Members who join see voting cards if voting is active

---

## Remaining Flows (In Progress)

| # | Flow | Status |
|---|------|--------|
| F | Invite & Share | Research complete (link previews, Partiful analysis). Locked. |
| G | Activities Tab | Already in development — skip |
| H | Itinerary Tab | Already in development — skip |
| I | People + Flights | Brainstorm started, research complete. Next up. |
| J | Stay Tab | Not started |
| K | Vibe Tab | Not started |
| L | Expenses Tab | Not started |
| M | Trip Edit / Settings | Not started |
| N | Explore / Globe | Not started |
| O | People Tab (main) | Not started |
| P | Calendar | Not started |
| Q | Settings & Profile | Not started |
| R | Text-to-Tryps + Text Blast | Not started |
| S | Notifications | Not started |
| T | Booking Integration | Not started |

---

## Key Decisions Made

1. **Phone number required** — no anonymous access, no viewer role
2. **Onboarding tour is always opt-in** — skip-able for everyone, designed last
3. **Invited users skip straight to trip** — no forced onboarding, vibe quiz is the first interactive moment
4. **Returning users with active trip** -> land on Itinerary tab (not Home)
5. **Trip creation minimum** — just a title. Everything else optional.
6. **Voting is owner-finalized** — no auto-resolution, owner is always the tiebreaker
7. **Text blast is NOT part of invite** — it's in-trip communication (separate flow)
8. **Link previews** — dynamic OG image per trip, "Jake invited you" in description, Tryps-branded card in iMessage
