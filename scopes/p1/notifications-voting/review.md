# Code Review: notifications-voting (Retry 1)

**Branch:** feat/notifications-voting
**Files Changed:** 27
**Lines Added/Removed:** +2967 / -155

## Verdict: PASS

All P1 blockers from the initial review have been resolved. The 5 addressed P2s are correctly implemented. The 3 deferred P2s have valid justifications (schema dependencies and backfill coordination). Ready for compound step.

## P1 — Must Fix Before Merge

None remaining.

## P2 — Should Fix

| #   | File | Line | Issue | Fix |
| --- | ---- | ---- | ----- | --- |
| 1   | `supabase/functions/trigger-scheduled-notifications/index.ts` | 90, 160, 214, etc. | Catch blocks log generic error objects without notification key context. Makes debugging harder when multiple scheduled notification types fail simultaneously. | Add structured logging: `console.error("[invite_pending] error:", e instanceof Error ? e.message : e)` for each catch block. |
| 2   | (deferred) | — | Missing #5 `vote_deadline` and #16 `daily_digest` implementations | Requires vote close time schema and itinerary query structure. Scheduled function skeleton ready. |
| 3   | (deferred) | — | Missing #13 `flight_landed` and #15 `upcoming_activity` | Requires flight `arrival_time` and itinerary `start_time` schemas not yet finalized. |
| 4   | (deferred) | — | `device_id` column lacks NOT NULL constraint | Needs backfill migration + client coordination to ensure all devices update. |
| 5   | (deferred) | — | CalendarSyncSheet not wired to notification tap handler | Component built; wiring deferred to integration testing phase. |

## P3 — Nice to Have

| #   | Issue | Suggestion |
| --- | ----- | ---------- |
| 1   | `utils/notifications.ts` line 6 uses relative import `from "./supabase"` instead of `@/utils/supabase`. | Pre-existing code, but worth cleaning up for consistency since all new files use `@/` aliases. |
| 2   | `process-notification-batch/index.ts` line 176 inserts to `notification_log` without `recipient_user_id`. | Service role bypasses RLS so this works, but batch log entries lack recipient attribution. Consider logging per-recipient or adding context. |
| 3   | `trigger-scheduled-notifications/index.ts` — countdown day boundary calculations use `new Date(... .getDate() + 1)`. | Technically correct (JS Date handles overflow), but `setDate(getDate() + 1)` or a date library would be more readable. |
| 4   | `process-notification-batch/index.ts` line 50-54 fetches ALL unsent pending notifications at once (`select * ... where sent_at is null`). | At scale, add a `LIMIT` (e.g., 1000) and process in pages. |

## Previous P1 Fixes Verified

| #   | Original Issue | Status |
| --- | -------------- | ------ |
| 1   | `notification_log` RLS INSERT policy had `WITH CHECK (true)` — any authenticated user could insert fake log entries | Verified fixed — `supabase/migrations/20260315000003_notifications_log_table.sql` lines 26-27: `FOR INSERT WITH CHECK (auth.uid() = recipient_user_id)` |
| 2   | `pending_notifications` had permissive FOR ALL policy — any user could read/write entire queue | Verified fixed — `supabase/migrations/20260315000004_notifications_pending_queue.sql` lines 21-22: INSERT-only policy `WITH CHECK (auth.uid() = triggered_by_user_id)`, no SELECT/UPDATE/DELETE for authenticated users |
| 3   | Muted tier checked `meta.importance !== "critical"` — blocked payment_received, payment_overdue, debtor_nudge, all_settled | Verified fixed — `supabase/functions/send-push-notification/index.ts` line 161: `meta.category !== "expenses"` allows all expense-category notifications through when muted |

## Previous P2 Fixes Verified

| #   | Original Issue | Status |
| --- | -------------- | ------ |
| 3   | Debtor nudge sent generic "remaining balance" instead of `$[amount]` | Verified fixed — `trigger-scheduled-notifications/index.ts` lines 503-555: queries `ledger_balances` for per-user `amount_cents`, sends `"Settle up: $85.00 remaining for Cabo"` per debtor |
| 4   | Payment overdue sent single generic message instead of per-debtor amounts | Verified fixed — `trigger-scheduled-notifications/index.ts` lines 452-478: queries `ledger_balances` + `user_profiles`, sends one push per debtor to creator: `"Mike still owes $85.00 for Cabo 2026"` |
| 7   | `sendPushNotification` called with hardcoded `type: "trip_invite"` for all notifications | Verified fixed — `utils/notificationTriggers.ts` line 70: passes `type: key` (the actual `NotificationKey`). `NotificationPayload.type` updated to accept `NotificationKey \| NotificationType` |
| 8   | Dedup DELETE non-deterministic when `created_at` values are identical | Verified fixed — `supabase/migrations/20260315000002` line 8: `OR (a.created_at = b.created_at AND a.id < b.id)` |
| P3  | `error.message` without `instanceof Error` check in catch blocks | Verified fixed — all 4 edge functions (`send-push-notification` line 294, `send-group-chat-message` line 125, `process-notification-batch` line 201, `trigger-scheduled-notifications` line 574) use `error instanceof Error ? error.message : "Unknown error"` |

## Completeness vs FRD

| FRD Requirement | Status | Notes |
| --------------- | ------ | ----- |
| 2.1 push_tokens — device_id, is_active | Done | Migration 000001 adds columns; upsert with device_id and is_active in `savePushTokenToServer` |
| 2.2 notification_preferences — trip_id, push_tier, category toggles | Done | Migration 000002 with dedup tiebreaker, all columns, UNIQUE(user_id, trip_id) |
| 2.3 notification_log — table with secure RLS | Done | Migration 000003 with SELECT own + INSERT own policies |
| 2.4 expense_tab_badge — last_viewed_expenses_at | Done | Migration 000005 + useExpenseBadge hook + tab badge UI |
| 3.1 send-push-notification — V2 with pref filtering | Done | Per-trip tier, global category toggles, notification_log writes, token deactivation |
| 3.2 send-group-chat-message — stub with push fallback | Done | Correct P1 behavior with Linq stub ready |
| 3.3 process-notification-batch — batching engine | Done | Atomic claiming, composeBatchedCopy for member_joined/activity_added/flight_booked |
| 3.4 trigger-scheduled-notifications — hourly cron | Partial | #3, #10, #11, #12, #17, #18, #22, #23 implemented. #5, #13, #15, #16 deferred (schema deps) |
| 4. Notification Catalog (22 keys) | Done | All 22 + expense_badge in NotificationKey type union and NOTIFICATION_CATEGORY_MAP |
| 5.1 Push token registration | Done | registerForPushNotifications with device_id, platform, is_active |
| 5.2 Push permission nudge | Done | PushPermissionNudge with 7-day cooldown, max 2 shows, wired in join flow |
| 5.3 Deep link handling | Done | V2 deep_link support in _layout.tsx with V1 fallback; trip_tab routes in linking.ts |
| 5.4 Expense tab badge | Done | useExpenseBadge hook, badge on tab bar, clears on tab focus |
| 5.5 Calendar sync | Partial | CalendarSyncSheet + calendarSync utility built. Not wired to notification tap handler (deferred to integration testing) |
| 6.1 Per-trip notification settings | Done | notification-settings.tsx with All / Important Only / Muted |
| 6.2 Global notification settings | Done | Settings screen updated with 4 FRD-aligned V2 category toggles |
| Client triggers (#1-#2, #6-#9, #19-#21) | Done | 10 typed convenience functions in notificationTriggers.ts |
| Scheduled triggers (#3, #10-#12, #17-#18, #22-#23) | Done | Fully implemented in trigger-scheduled-notifications edge fn |
| Batching (5m joins, 15m activities/flights) | Done | Correctly configured in NOTIFICATION_CATEGORY_MAP |
| Dual-channel (#7 dates_locked, #12 day_1, #17 expense_deadline_24h) | Done | Both group_chat and push in channel arrays + scheduled fn sends both |
| pg_cron schedules | Partial | Commented out in migration 000007 (expected — needs manual pg_cron verification) |
| Types (NotificationKey, NotificationMeta, etc.) | Done | Full type definitions in types/index.ts |
| Trip interface expansion (timezone, settleUpDeadline) | Done | Added to Trip interface + migration 000006 |

## Security Checklist

- [x] RLS on all new tables — `notification_log` (SELECT own + INSERT own), `pending_notifications` (INSERT own only), `push_tokens` (pre-existing FOR ALL own policy)
- [x] No exposed secrets — service role keys accessed via `Deno.env.get()` in edge functions only
- [x] Input validation present — edge functions validate required fields (userIds, trip_id, message)
- [x] No injection vectors — all queries use parameterized Supabase client, no raw SQL in edge functions

## Summary

The notification infrastructure is well-architected across 27 files with clean separation between client triggers (`notificationTriggers.ts`), edge function delivery (4 functions), and scheduled cron processing. All 3 P1 security issues from the initial review are resolved: `notification_log` INSERT policy now restricts to `auth.uid() = recipient_user_id`, `pending_notifications` is INSERT-only scoped to the triggering user, and the muted-tier logic correctly checks `meta.category !== "expenses"`. The 5 fixed P2s (debtor nudge amounts, per-debtor payment overdue, NotificationKey type field, dedup tiebreaker, instanceof Error guards) are all correctly implemented. Code quality is solid — no `any` types, proper `@/` path aliases in all new files, `StyleSheet.create()` used throughout. The 4 deferred items (vote_deadline, flight_landed/upcoming_activity, device_id NOT NULL, CalendarSyncSheet wiring) are genuinely blocked on schema dependencies or require end-to-end testing. Ready for the compound step.
