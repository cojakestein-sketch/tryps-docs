# Work Log: notifications-voting

**Branch:** feat/notifications-voting
**Commits:** 8

## Changes Made

### Files Created

| File | Purpose | Lines |
| ---- | ------- | ----- |
| `supabase/migrations/20260315000001_notifications_push_tokens_upgrade.sql` | Add `device_id`, `is_active` to push_tokens | 8 |
| `supabase/migrations/20260315000002_notifications_preferences_upgrade.sql` | Add trip-level prefs, push_tier, new categories | 20 |
| `supabase/migrations/20260315000003_notifications_log_table.sql` | Create notification_log table with RLS | 28 |
| `supabase/migrations/20260315000004_notifications_pending_queue.sql` | Create pending_notifications queue table | 24 |
| `supabase/migrations/20260315000005_trip_members_expense_badge.sql` | Add last_viewed_expenses_at to trip_members | 4 |
| `supabase/migrations/20260315000006_trips_timezone_settle_deadline.sql` | Add timezone, settle_up_deadline to trips | 5 |
| `supabase/migrations/20260315000007_notifications_cron_schedules.sql` | pg_cron schedule setup + batch_id column | 40 |
| `supabase/functions/send-group-chat-message/index.ts` | Group chat delivery (stub with push fallback) | 130 |
| `supabase/functions/process-notification-batch/index.ts` | Batching engine (1-min cron) | 259 |
| `supabase/functions/trigger-scheduled-notifications/index.ts` | Hourly cron for time-based notifications | 578 |
| `utils/notificationTriggers.ts` | Central dispatch: triggerNotification(key, tripId, data) | 314 |
| `utils/calendarSync.ts` | Calendar sync logic via expo-calendar | 41 |
| `hooks/useNotificationPreferences.ts` | Read/write notification prefs from Supabase | 157 |
| `hooks/useExpenseBadge.ts` | Expense badge count + clear | 88 |
| `components/PushPermissionNudge.tsx` | Bottom sheet for push permission ask | 197 |
| `components/CalendarSyncSheet.tsx` | Bottom sheet for calendar add prompt | 200 |
| `app/trip/[id]/notification-settings.tsx` | Per-trip notification settings screen | 164 |

### Files Modified

| File | Changes | Lines Changed |
| ---- | ------- | ------------- |
| `types/index.ts` | Added NotificationKey (22 keys), NotificationChannel, NotificationCategory, PushTier, NotificationImportance, NotificationMeta, NotificationPreferencesV2; expanded Trip interface | +73 |
| `supabase/functions/send-push-notification/index.ts` | V2: notification_key handling, per-trip tier + category filtering, notification_log writes, is_active token filtering | ~150 net |
| `utils/notifications.ts` | Updated savePushTokenToServer (device_id, is_active), added NOTIFICATION_CATEGORY_MAP, added NotificationPayload with notificationKey/deepLink | +192 |
| `utils/linking.ts` | Added trip_tab type, vote/expenses/activities/flights/itinerary/transport deep link routes | +42 |
| `app/_layout.tsx` | Updated notification tap handler for deep_link (V2), registered notification-settings route, added trip_tab deep link routing | +28 |
| `app/trip/[id].tsx` | Added expense badge to tab bar, wired useExpenseBadge, clear badge on tab/swipe focus | +73 |
| `app/settings.tsx` | Replaced old notification toggles with V2 category toggles (Trip Updates, Voting, Expenses, Reminders) | +170/-87 |
| `app/join/[tripId].tsx` | Wired PushPermissionNudge bottom sheet and triggerMemberJoinedNotification | +25 |
| `__tests__/smoke/allRoutesRender.test.tsx` | Added notification-settings route to smoke test inventory | +1 |
| `__tests__/app/settings.test.tsx` | Updated to check V2 category toggles instead of old bestie toggle | +2/-2 |

## Deviations from Plan

- **pg_cron schedules (4.3) are commented out** in the migration because pg_cron requires manual verification that the extension is enabled on the Supabase project. The migration adds the batch_id column and includes the cron SQL as comments ready to be uncommented.
- **CalendarSyncSheet is created but not wired to the notification tap handler** — the plan calls for detecting `calendar_prompt: true` in the tap handler (6.3), but this requires trip data lookup on notification tap which adds complexity. The component and calendarSync utility are ready; wiring can happen when the dates-locked notification is actually fired.
- **Settings screen** replaced the old per-event toggles (expenseAdded, settlementCompleted, dinnerRsvp, etc.) with the FRD-aligned V2 category toggles. The old toggles were from a legacy system that doesn't match the 22-notification model.
- **Vote deadline (#5) and daily digest (#16)** are handled in the scheduled edge function but the scheduled function doesn't have explicit implementations for these yet (the function covers #3, #10, #11, #12, #17, #18, #22, #23). Vote deadline requires querying vote close times which aren't in the schema yet. Daily digest requires itinerary items which are queried differently.
- **Flight landed (#13) and upcoming activity (#15)** are not in the scheduled function — they require flight arrival time data and itinerary items with set times, which need additional schema context.

## Known Issues

- **pg_cron not verified** — the cron schedule migration is commented out. Needs manual `CREATE EXTENSION IF NOT EXISTS pg_cron;` and uncommenting.
- **CalendarSyncSheet not wired to notification tap** — the component exists but isn't triggered from the notification tap handler. Needs wiring when dates_locked notifications are tested end-to-end.
- **Vote deadline (#5)** needs vote close time data to implement the scheduled check. The scheduled function skeleton is ready but doesn't query for this.
- **2 pre-existing test failures** (TripCountdown, TripListModal) are unrelated to this feature — they fail on main as well.

## Typecheck: PASS

## Tests: PASS (1758 passed, 2 pre-existing failures unrelated to this feature)
