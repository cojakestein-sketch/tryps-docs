# Agent Ready: notifications-voting

**PR:** https://github.com/cojakestein-sketch/tryps/pull/277
**PR Number:** 277
**ClickUp Task:** manual
**Assigned Dev:** Asif
**Date:** 2026-03-15

## Dev Briefing

### What Was Built
Push notification infrastructure for Tryps — token registration, 4 Supabase edge functions for delivery (direct push, group chat with push fallback, batching engine, scheduled triggers), preference filtering at both per-trip and global levels, and client-side UI including expense tab badges, notification settings screens, push permission nudges, and deep link routing. This covers 18 of 22 planned notifications; the remaining 4 are deferred pending schema dependencies (vote close times, flight arrival times, itinerary start times).

### What to Look For
1. **Security (highest priority):** RLS policies on `notification_log` (INSERT restricted to own user), `pending_notifications` (INSERT-only, scoped to triggering user). Verify no authenticated user can read or modify other users' notification data.
2. **Preference filtering logic** in `send-push-notification/index.ts`: muted tier allows expense-category notifications through, important-only tier allows votes + expenses + settle-up. Verify the category map and filtering are correct.
3. **Scheduled notifications** in `trigger-scheduled-notifications/index.ts` (578 lines): per-debtor amount queries for payment overdue and debtor nudge, timezone handling for Day 1 and countdowns. This is the most complex file.
4. **Client triggers** in `utils/notificationTriggers.ts`: 10 typed convenience functions that dispatch notifications from app events. Verify channel routing matches the FRD notification matrix.
5. **pg_cron schedules** are commented out in migration 000007 — this is intentional and needs manual enabling after deployment.

### Success Criteria to Verify

**Push Notification Infrastructure**
- [ ] Expo push token registration on app launch / sign-in
- [ ] Push token stored in Supabase (linked to user_id + device)
- [ ] Supabase edge function to send push notifications (accepts: user_ids, title, body, data/deep_link)
- [ ] Deep links work from push notifications (tap -> correct screen in app)
- [ ] Multi-device support (user gets push on all registered devices)

**Group Chat Delivery**
- [ ] Agent can send messages to a trip's iMessage group thread (stub with push fallback until Linq P2)
- [ ] Agent messages include deep links back to the app where relevant

**Notification Triggers**
- [ ] Phase 1 — Invite: #1 invite, #2 join, #3 pending 48hr, #4 link opened
- [ ] Phase 2 — Planning: #6 vote created, #7 dates locked, #8 activity added, #9 flight booked, #10 7-day countdown, #11 1-day countdown
- [ ] Phase 3 — During Trip: #12 Day 1, #14 expense badge
- [ ] Phase 4 — Settle Up: #17-#23 (all 7 settle-up notifications)

**Expense Tab Badge**
- [ ] Red dot with count on Expenses tab when new expenses added since last viewed
- [ ] Badge clears when user opens the Expenses tab

**Settings**
- [ ] Per-trip push tier: All / Important Only / Muted
- [ ] Global push category toggles: Trip Updates, Voting & Polls, Expenses, Trip Reminders

**Push Permission**
- [ ] Nudge after first meaningful action (joining a trip)

### Known Limitations
1. **4 notification types deferred:** #5 vote_deadline (needs `votes.closes_at`), #13 flight_landed (needs `arrival_time`), #15 upcoming_activity (needs itinerary `start_time`), #16 daily_digest (needs itinerary query structure). Scheduled function skeletons are ready.
2. **CalendarSyncSheet built but not wired** to notification tap handler — needs end-to-end testing with actual push delivery to verify `calendar_prompt: true` data payload forwarding.
3. **pg_cron schedules commented out** in migration 000007 — must be manually enabled in Supabase dashboard after deployment.
4. **`device_id` column lacks NOT NULL constraint** — needs backfill migration for existing rows before constraint can be applied.
5. **3 pre-existing test failures** (TripCountdown x2, TripListModal x1) unrelated to this feature — fail on main branch too.

## Pipeline Status
- Spec: ready
- FRD: ready
- Plan: complete
- Work: complete
- Review: pass
- Compound: complete
- Agent Ready: pr_open
