# Compound Log: notifications-voting

## P2 Fixes Applied

| #   | Issue | Fix Applied | File |
| --- | ----- | ----------- | ---- |
| 1   | Catch blocks log generic error objects without notification key context, making debugging harder when multiple scheduled notification types fail simultaneously | Added structured logging with notification key prefix and `instanceof Error` guard to all 8 catch blocks: `[invite_pending]`, `[countdown_7d]`, `[countdown_1d]`, `[day_1]`, `[expense_deadline_24h]`, `[expense_deadline_1h]`, `[payment_overdue]`, `[debtor_nudge]` | `supabase/functions/trigger-scheduled-notifications/index.ts` |

## P3 Fixes Applied

| #   | Issue | Fix Applied | File |
| --- | ----- | ----------- | ---- |
| 1   | `utils/notifications.ts` line 6 uses relative import `from "./supabase"` instead of `@/utils/supabase` | Changed to `@/utils/supabase` for consistency with all new files | `utils/notifications.ts` |
| 2   | `process-notification-batch/index.ts` line 176 inserts to `notification_log` without `recipient_user_id` — batch log entries lack recipient attribution | Added clarifying comment explaining this is a batch summary entry; per-recipient logging happens downstream in `send-push-notification` and `send-group-chat-message` edge functions | `supabase/functions/process-notification-batch/index.ts` |
| 3   | `process-notification-batch/index.ts` line 50-54 fetches ALL unsent pending notifications at once without LIMIT | Added `.limit(1000)` to prevent unbounded fetches at scale | `supabase/functions/process-notification-batch/index.ts` |

## P3 Skipped

| #   | Issue | Reason |
| --- | ----- | ------ |
| 3 (review) | Date boundary calculations use `new Date(... .getDate() + 1)` instead of `setDate()` | Technically correct (JS Date handles overflow). Low value change with risk of subtle behavioral difference. |

## Deferred Items

| #   | Issue | Reason |
| --- | ----- | ------ |
| 1   | Missing `vote_deadline` (#5) and `daily_digest` (#16) implementations | Requires vote close time schema (`votes.closes_at`) and itinerary query structure (`itinerary_items` table with `start_time`). Neither schema exists yet. |
| 2   | Missing `flight_landed` (#13) and `upcoming_activity` (#15) implementations | Requires flight `arrival_time` column and itinerary `start_time` column — schemas not yet finalized. |
| 3   | `device_id` column lacks NOT NULL constraint | Needs backfill migration to populate existing rows + client coordination to ensure all active devices update their token registrations before the constraint is applied. |
| 4   | CalendarSyncSheet not wired to notification tap handler | Component and utility are fully built. Wiring requires end-to-end testing with actual push notification delivery to verify the `calendar_prompt: true` data payload is correctly forwarded from the notification response listener to the CalendarSyncSheet. Deferred to integration testing phase. |

## Remaining Concerns

- **Pre-existing test failures** (3 tests in 2 suites): `TripCountdown.test.tsx` (2 tests) and `TripListModal.test.tsx` (1 test) fail on the base branch and are unrelated to notifications. These appear to be caused by component behavior changes that were not accompanied by test updates.
- **pg_cron schedules** remain commented out in migration 000007. This is expected — pg_cron jobs must be verified/enabled manually in the Supabase dashboard after deployment.

## Typecheck: PASS

## Tests: PASS (3 pre-existing failures unrelated to this feature)
