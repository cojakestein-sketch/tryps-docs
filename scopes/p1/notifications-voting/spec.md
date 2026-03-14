# Scope 3: Notifications & Voting — Spec

> **Status:** ready
> **Phase:** P1: Core App
> **Gantt ID:** `p1-notifications-voting`
> **Date:** March 14, 2026

## Intent

Build the notification delivery layer that keeps trip groups informed without being annoying. The Tryps agent lives in the iMessage group chat — most social/collaborative notifications go there. Push notifications are reserved for private, actionable items (votes, expense deadlines, payment amounts). Voting mechanics (48hr windows, up/down, auto-close) are already built — this scope adds the notification and channel-routing infrastructure on top.

## Key Decisions (Already Made)

- **22 notifications** across 4 lifecycle phases (Invite, Planning, During Trip, Post-Trip)
- **Group Chat is primary channel** — 9 of 22 notifications route through the Tryps agent in iMessage
- **Dual-channel only for milestones** — 3 of 22 (13%) fire on both group chat + push: dates locked, Day 1, 24hr expense deadline
- **Push + SMS never paired** — SMS only for inviting non-app users
- **No text blast** — the group chat IS the text blast
- **No quiet hours** — send whenever
- **Expense badge** — red dot + count ("3 new") on Expenses tab, not a notification
- **Full notification matrix**: `_private/notes/notification-matrix.html` (v4)

## Acceptance Criteria

### Push Notification Infrastructure
- [ ] Expo push token registration on app launch / sign-in
- [ ] Push token stored in Supabase (linked to user_id + device)
- [ ] Supabase edge function to send push notifications (accepts: user_ids, title, body, data/deep_link)
- [ ] Deep links work from push notifications (tap → correct screen in app)
- [ ] Multi-device support (user gets push on all registered devices)

### Group Chat Delivery (via Tryps Agent)
- [ ] Agent can send messages to a trip's iMessage group thread
- [ ] Agent messages batched per batching rules (5min joins, 15min activities/flights)
- [ ] Agent messages include deep links back to the app where relevant
- [ ] Dependency: Linq integration (P2) — stub with push fallback until Linq is live

### Notification Triggers (all 22)
- [ ] Phase 1 — Invite: #1 invite, #2 join, #3 pending 48hr, #4 link opened
- [ ] Phase 2 — Planning: #5 vote deadline, #6 vote created, #7 dates locked, #8 activity added, #9 flight booked, #10 7-day countdown, #11 1-day countdown
- [ ] Phase 3 — During Trip: #12 Day 1, #13 flight landed, #14 expense badge, #15 upcoming activity, #16 daily digest
- [ ] Phase 4 — Settle Up: #17 24hr expense deadline, #18 1hr expense deadline, #19 settle up amounts, #20 payment received, #21 all settled, #22 overdue, #23 debtor nudge

### Expense Tab Badge
- [ ] Red dot with count ("3 new") on Expenses tab when new expenses added since last viewed
- [ ] Badge clears when user opens the Expenses tab
- [ ] Badge appears anytime (not just during trip)

### Settings
- [ ] Per-trip push tier: All / Important Only / Muted (default: All)
- [ ] Global push category toggles: Trip Updates, Voting & Polls, Expenses, Trip Reminders
- [ ] Calendar sync: when dates finalize (#7), prompt to add single event to Apple/Google Calendar

### Push Permission
- [ ] Nudge to enable push notifications if user hasn't granted permission
- [ ] Nudge timing: after first meaningful action (e.g., joining a trip, casting a vote)

## Constraints

- **Voting mechanics are already built** — 48hr windows, up/down votes on dates/location/activities, auto-close. No changes needed. This scope only adds notification triggers on top.
- **Group chat depends on Linq (P2)** — for P1, group chat notifications fall back to push. When Linq ships, they route through iMessage automatically.
- **No notification center / activity feed** — not building an in-app notification list. Push and group chat are the delivery channels. Badge is the only in-app indicator.
- **Copy is locked** — all 22 notification strings are finalized in the notification matrix (v4). Dev implements as-is.
- **Batching is server-side** — the edge function holds notifications for the batch window before sending.

## References

- Notification Matrix v4: `_private/notes/notification-matrix.html`
- Competitor analyses: `_private/notes/{splitwise,airbnb,strava,partiful,beli}-notification-analysis.md`
- Linq FRD (group chat architecture): `scopes/p2/linq-imessage/frd.md`
