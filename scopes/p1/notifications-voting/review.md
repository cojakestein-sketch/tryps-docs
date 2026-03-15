# Code Review: notifications-voting

**Branch:** feat/notifications-voting
**Files Changed:** 27
**Lines Added/Removed:** +2936 / -153

## Verdict: FAIL

Two P1 issues must be fixed before merge: overly-permissive RLS policies on `notification_log` and `pending_notifications`, and the muted-tier filtering logic that blocks payment reminders it should allow.

## P1 — Must Fix Before Merge

| #   | File | Line | Issue | Fix |
| --- | ---- | ---- | ----- | --- |
| 1   | `supabase/migrations/20260315000003_notifications_log_table.sql` | 23-24 | **RLS too permissive on notification_log.** `FOR INSERT WITH CHECK (true)` lets any authenticated user insert fake log entries, which can poison the deduplication checks in `trigger-scheduled-notifications` (e.g., inserting a fake `invite_pending` log prevents the real reminder from firing). Comment says "service role" but service role bypasses RLS entirely -- this policy affects anon/authenticated users. | Remove the INSERT policy. Edge functions use service role key which bypasses RLS. If client-side inserts are needed (e.g., `notificationTriggers.ts` badge/in_app logging), restrict to `auth.uid() = recipient_user_id`. |
| 2   | `supabase/migrations/20260315000004_notifications_pending_queue.sql` | 19-20 | **RLS too permissive on pending_notifications.** `FOR ALL USING (true) WITH CHECK (true)` lets any authenticated user read the entire queue and insert arbitrary notifications. A malicious user could enqueue spam notifications to all trips. | Remove the ALL policy. Edge functions and the batch processor use service role which bypasses RLS. Client-side inserts from `notificationTriggers.ts` need a restricted policy: `auth.uid() = triggered_by_user_id` for INSERT, no SELECT/UPDATE/DELETE for authenticated users. |
| 3   | `supabase/functions/send-push-notification/index.ts` | 175-181 | **Muted tier blocks payment notifications.** Code: `if (tier === "muted" && meta.importance !== "critical")` -- only `settle_up_amounts` is marked "critical". FRD says muted should allow all settle-up category notifications (payment_received, payment_overdue, debtor_nudge, all_settled are all "important"/"normal"). A user who mutes a trip will stop receiving payment reminders and overdue notices. | Change the muted check to: `if (tier === 'muted' && meta.category !== 'expenses')` to allow all expense-category notifications through. Or reclassify all expense notifications as "critical". |

## P2 — Should Fix

| #   | File | Line | Issue | Fix |
| --- | ---- | ---- | ----- | --- |
| 1   | `supabase/functions/trigger-scheduled-notifications/index.ts` | (entire) | **Missing #5 vote_deadline and #16 daily_digest implementations.** Work-log acknowledges these are missing. The scheduled function has the skeleton but no query logic for vote close times or itinerary items. These are FRD-required notifications. | Implement vote_deadline (query votes closing in ~1hr) and daily_digest (query itinerary items for today at 8am local). Can be a follow-up PR if schema context for votes/itinerary is complex. |
| 2   | `supabase/functions/trigger-scheduled-notifications/index.ts` | (entire) | **Missing #13 flight_landed and #15 upcoming_activity.** Work-log acknowledges. These require flight arrival times and itinerary start_time data. | Implement when flight/itinerary schema provides the required timestamps. |
| 3   | `supabase/functions/trigger-scheduled-notifications/index.ts` | 462-470 | **Debtor nudge sends generic "remaining balance" instead of specific dollar amount.** FRD #23 specifies: `"Settle up: $[amount] remaining for [Trip]"`. Code sends: `"Settle up: remaining balance for ${trip.name}"`. | Query the actual owed amount from the ledger for each member and include it in the message. |
| 4   | `supabase/functions/trigger-scheduled-notifications/index.ts` | 388-403 | **Payment overdue (#22) sends generic message instead of per-debtor amounts.** FRD specifies: `"[Name] still owes $[amount] for [Trip]"` with one notification per debtor, sent only to the creator. Code sends a single generic "Some members still have outstanding balances." | Query individual outstanding balances and send one push per debtor to the trip creator with the specific name and amount. |
| 5   | `supabase/migrations/20260315000001_notifications_push_tokens_upgrade.sql` | 4 | **`device_id` column added without NOT NULL constraint.** FRD schema specifies `device_id TEXT NOT NULL`. Existing rows will have NULL device_id, and the upsert in `savePushTokenToServer` only sets it for new saves. | Add a follow-up migration to backfill device_id for existing rows, then add NOT NULL constraint. |
| 6   | `components/CalendarSyncSheet.tsx` | (entire) | **CalendarSyncSheet not wired to notification tap handler.** Component built but never triggered from `_layout.tsx` when a dates_locked notification with `calendar_prompt: true` arrives. Work-log acknowledges this. | Wire the tap handler to detect `calendar_prompt: true` in notification data and show the sheet. |
| 7   | `utils/notificationTriggers.ts` | 88-98 | **`sendPushNotification` called with hardcoded `type: "trip_invite"` for all notification types.** The legacy `type` field is always set to `"trip_invite"` regardless of the actual notification. This could confuse legacy clients that check `data.type`. | Pass the `notificationKey` as the legacy `type` field, or at minimum use a more generic default. |
| 8   | `supabase/migrations/20260315000002_notifications_preferences_upgrade.sql` | 4-5 | **Dedup DELETE is non-deterministic.** `DELETE FROM notification_preferences a USING notification_preferences b WHERE a.user_id = b.user_id AND a.created_at < b.created_at` could fail if two rows have identical `created_at` values. | Add a tiebreaker: `AND (a.created_at < b.created_at OR (a.created_at = b.created_at AND a.id < b.id))`. |

## P3 — Nice to Have

| #   | Issue | Suggestion |
| --- | ----- | ---------- |
| 1   | Edge function catch blocks use `error.message` without `instanceof Error` check (`send-group-chat-message`, `process-notification-batch`, `trigger-scheduled-notifications`). | Use `error instanceof Error ? error.message : "Unknown error"` for safety, matching the pattern in other edge functions like `scrape-accommodation`. |
| 2   | `process-notification-batch` fetches ALL unsent pending notifications at once (`select * ... is null`). At scale, this could be a large result set. | Add a `LIMIT` (e.g., 1000) and process in pages, or use cursor-based pagination. |
| 3   | `trigger-scheduled-notifications` makes N+1 queries per trip (one per invite, one per member, etc.). | Batch where possible -- e.g., fetch all pending invites with their notification_log status in a single join query. |
| 4   | The `debtor_nudge` implementation (#23) sends to ALL trip members, not just members with outstanding balances. | Query the ledger for members with non-zero balances before sending nudges. |

## Completeness vs FRD

| FRD Requirement | Status | Notes |
| --- | --- | --- |
| **2.1 push_tokens** -- device_id, is_active, UNIQUE(user_id, device_id) | ⚠ Partial | Columns added, but no UNIQUE constraint on (user_id, device_id). Existing UNIQUE(user_id, token) works functionally. |
| **2.2 notification_preferences** -- trip_id, push_tier, category toggles, UNIQUE(user_id, trip_id) | ✓ Done | All columns and constraint added via upgrade migration. |
| **2.3 notification_log** -- table with RLS | ⚠ Partial | Table created with correct schema. RLS INSERT policy is too permissive (P1). |
| **2.4 expense_tab_badge** -- last_viewed_expenses_at on trip_members | ✓ Done | Column added, hook + UI badge implemented. |
| **3.1 send-push-notification** -- V2 with pref filtering + logging | ⚠ Partial | Implemented but muted-tier logic is wrong (P1 #3). |
| **3.2 send-group-chat-message** -- stub with push fallback | ✓ Done | Correct P1 behavior with Linq stub. |
| **3.3 process-notification-batch** -- batching engine | ✓ Done | Correct batch window logic, composeBatchedCopy for 3 types. |
| **3.4 trigger-scheduled-notifications** -- hourly cron | ⚠ Partial | Handles #3, #10, #11, #12, #17, #18, #22, #23. Missing #5, #13, #15, #16. |
| **4. Notification Catalog (22 triggers)** | ⚠ Partial | Type definitions for all 22 keys. Client triggers for #1, #2, #6, #7, #8, #9, #19, #20, #21. Scheduled triggers for #3, #10, #11, #12, #17, #18, #22, #23. Missing triggers: #4, #5, #13, #14 (UI-only -- done), #15, #16. |
| **5.1 Push token registration** -- registerForPushNotifications | ✓ Done | Updated with device_id and is_active. |
| **5.2 Push permission nudge** -- bottom sheet | ✓ Done | PushPermissionNudge with 7-day cooldown and max 2 shows. |
| **5.3 Deep link handling** -- notification tap handler | ✓ Done | V2 deep_link support added to _layout.tsx with V1 fallback. |
| **5.4 Expense tab badge** -- red dot with count | ✓ Done | useExpenseBadge hook + badge UI on tab bar. Clears on tap/swipe. |
| **5.5 Calendar sync** -- expo-calendar integration | ⚠ Partial | CalendarSyncSheet and calendarSync utility built. Not wired to notification tap handler. |
| **6.1 Trip notification settings** -- per-trip tier | ✓ Done | notification-settings.tsx with All/Important/Muted radio buttons. |
| **6.2 Global notification settings** -- category toggles | ✓ Done | Settings screen updated with 4 FRD-aligned category toggles. |
| **Database: timezone + settle_up_deadline on trips** | ✓ Done | Migration adds both columns. |
| **Database: pending_notifications queue** | ⚠ Partial | Table created but RLS too permissive (P1 #2). |
| **Database: pg_cron schedules** | ⚠ Partial | Commented out in migration (expected -- needs manual pg_cron setup). |
| **Types: NotificationKey, etc.** | ✓ Done | All 22 keys + supporting types added to types/index.ts. |
| **Trip interface expansion** | ✓ Done | timezone, settleUpDeadline, conversationId added. |

## Security Checklist

- [x] RLS on all new tables (notification_log, pending_notifications -- enabled but policies need tightening, see P1 #1-2)
- [x] No exposed secrets (edge functions use env vars properly)
- [ ] Input validation present (edge functions validate required fields; RLS policies are overly permissive -- P1)
- [x] No injection vectors (all queries use parameterized Supabase client, no raw SQL)

## Summary

The implementation covers the core notification infrastructure well: push token V2, preference filtering with per-trip tiers and global category toggles, batching engine, group chat stub with push fallback, expense badge, deep link handling, settings screens, and typed convenience functions for 9 of the 22 event-triggered notifications. The architecture is clean with a central dispatch pattern (`triggerNotification`) and a clear NOTIFICATION_CATEGORY_MAP.

The two P1 blockers are: (1) overly permissive RLS policies on `notification_log` and `pending_notifications` that allow any authenticated user to manipulate the notification queue and poison deduplication checks, and (2) the muted-tier filtering bug that incorrectly blocks payment-related notifications (payment_received, payment_overdue, debtor_nudge) when a user mutes a trip. Both are straightforward fixes.

Notable gaps from the FRD: #5 vote_deadline, #13 flight_landed, #15 upcoming_activity, and #16 daily_digest are not implemented in the scheduled function. The work-log acknowledges these as requiring additional schema context. The calendar sync component is built but not wired to the notification tap handler.
