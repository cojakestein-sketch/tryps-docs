# notifications-voting — Implementation Plan

**FRD:** /Users/jakestein/tryps-docs/scopes/p1/notifications-voting/frd.md
**Branch:** feat/notifications-voting

## Codebase Scan Summary

### What Already Exists

| Component | Status | File | Notes |
|---|---|---|---|
| `push_tokens` table | Partial | `supabase/schema.sql:1092` | Has `user_id, token, platform`. Missing `device_id`, `is_active`. |
| `notification_preferences` table | Partial | `supabase/schema.sql:1123` | Global-only (no `trip_id`). Old category columns (`expense_added`, `dinner_rsvp`, etc.). No `push_tier`. |
| `send-push-notification` edge fn | Partial | `supabase/functions/send-push-notification/index.ts` | Basic push via Expo API. No `notification_log`, no deep_link routing, no category-based filtering (only `enabled` + `bestie_updates`). |
| Push token registration | Done | `utils/notifications.ts:45-93` | `registerForPushNotifications()` works. |
| Push permission nudge | Partial | `utils/pushPermissions.ts` | `requestPushAtValueMoment()` exists. No bottom sheet UI or 7-day cooldown. |
| Notification listeners | Done | `app/_layout.tsx:78-110` | Foreground handler + tap-to-navigate (`tripId` + `tab`). |
| Deep link parsing | Done | `utils/linking.ts` | Handles `tripful://` scheme. Missing vote, expenses/add, expenses/settle routes. |
| Voting tables | Done | Multiple migrations | `trip_activity_votes`, `trip_date_options`, `date_option_votes`, `destination_option_votes`, `accommodation_votes` |
| Activity vote UI | Done | `components/activities/ActivityVoteButtons.tsx` | 3-tier voting (Want/Fine/Skip) |
| Bottom tab badge | Partial | `components/BottomTabBar.tsx:201` | People tab has red dot badge. Extensible pattern. |
| Trip detail tabs | Done | `app/trip/[id].tsx:348` | Expenses tab renders `components/ExpensesTab.tsx` |
| `trip_invites` table | Done | `supabase/schema.sql:86` | Email-based invites with `accepted_at` |
| Trip type | Partial | `types/index.ts:105` | Missing `timezone`, `settleUpDeadline`, `conversationId` |
| Notification helpers | Partial | `utils/notifications.ts:303-496` | `notifyExpenseAdded()`, `notifyNewVote()`, etc. exist but use old copy/types |
| Settlement nudge | Partial | `utils/notifications.ts:579-648` | Client-side local notification. FRD wants server-side scheduled push. |
| `expo-calendar` | Installed | `package.json:59` | Available but unused |
| Settings screen | Exists | `app/settings.tsx` | No notification settings section yet. |

### What is Missing

- `notification_log` table
- `pending_notifications` table (for batching queue)
- Per-trip notification preferences (`push_tier`)
- FRD-aligned category columns (`push_trip_updates`, `push_voting`, `push_expenses`, `push_reminders`)
- `trip_members.last_viewed_expenses_at` column
- `trips.timezone` and `trips.settle_up_deadline` columns
- `send-group-chat-message` edge function
- `process-notification-batch` edge function
- `trigger-scheduled-notifications` edge function
- Notification trigger wiring for all 22 events
- Expense tab badge (trip detail tab bar)
- Trip notification settings screen
- Global notification settings UI
- Calendar sync prompt
- Push permission nudge bottom sheet with 7-day cooldown

---

## Task Breakdown

### Phase 1: Foundation (Database + Types)

| No | Task | Files | Est. Lines | Dependencies |
|---|---|---|---|---|
| 1.1 | Migration: Add `device_id` (TEXT), `is_active` (BOOLEAN DEFAULT true) to `push_tokens`. Add index on `is_active`. | `supabase/migrations/2026XXXXX_notifications_push_tokens_upgrade.sql` | ~15 | None |
| 1.2 | Migration: Evolve `notification_preferences` — add `trip_id` (UUID FK), `push_tier` (TEXT CHECK), `push_trip_updates`, `push_voting`, `push_expenses`, `push_reminders`. Drop UNIQUE on `user_id`, add UNIQUE on `(user_id, trip_id)`. | `supabase/migrations/2026XXXXX_notifications_preferences_upgrade.sql` | ~40 | None |
| 1.3 | Migration: Create `notification_log` table with RLS | `supabase/migrations/2026XXXXX_notifications_log_table.sql` | ~30 | None |
| 1.4 | Migration: Create `pending_notifications` queue table | `supabase/migrations/2026XXXXX_notifications_pending_queue.sql` | ~25 | None |
| 1.5 | Migration: Add `last_viewed_expenses_at` to `trip_members` | `supabase/migrations/2026XXXXX_trip_members_expense_badge.sql` | ~5 | None |
| 1.6 | Migration: Add `timezone` and `settle_up_deadline` to `trips` | `supabase/migrations/2026XXXXX_trips_timezone_settle_deadline.sql` | ~10 | None |
| 1.7 | Update `types/index.ts` — expand `NotificationType` (all 22 keys), add `PushTier`, update `Trip` interface (`timezone?`, `settleUpDeadline?`, `conversationId?`), add `NotificationPreferencesV2` | `types/index.ts` | ~50 | None |

### Phase 2: Core Push Infrastructure

| No | Task | Files | Est. Lines | Dependencies |
|---|---|---|---|---|
| 2.1 | Upgrade `send-push-notification` edge fn — accept `notification_key` + `deep_link`, add per-trip tier + category filtering, log to `notification_log`, filter by `is_active` tokens | `supabase/functions/send-push-notification/index.ts` | ~80 (net) | 1.1, 1.2, 1.3 |
| 2.2 | Create `send-group-chat-message` edge fn — stub that checks `trips.conversation_id`, falls back to push when null (always in P1), logs to `notification_log` | `supabase/functions/send-group-chat-message/index.ts` | ~90 | 1.3, 2.1 |
| 2.3 | Update `utils/notifications.ts` — update `savePushTokenToServer()` to include `device_id` + `is_active`, update payload to include `notification_key` + `deep_link` | `utils/notifications.ts` | ~30 (net) | 1.1, 1.7 |
| 2.4 | Add `NOTIFICATION_CATEGORY_MAP` to `utils/notifications.ts` — maps each key to FRD category and importance level | `utils/notifications.ts` | ~40 | 1.7 |
| 2.5 | Create `hooks/useNotificationPreferences.ts` — read/write prefs from Supabase (global + per-trip) | `hooks/useNotificationPreferences.ts` | ~60 | 1.2, 1.7 |

### Phase 3: Event-Triggered Notifications

| No | Task | Files | Est. Lines | Dependencies |
|---|---|---|---|---|
| 3.1 | Create `utils/notificationTriggers.ts` — central dispatch: `triggerNotification(key, tripId, data)` routes to push, group chat, or batching queue. Handles dual-channel (notifications 7, 12, 17). | `utils/notificationTriggers.ts` | ~80 | 2.1, 2.2, 2.4 |
| 3.2 | Wire notification 1 (Trip Invite) — call `triggerNotification('invite', ...)` in invite creation flow | `utils/notificationTriggers.ts`, invite code | ~25 | 3.1 |
| 3.3 | Wire notification 2 (Member Joined) — queue to `pending_notifications` with 5min batch window | `utils/notificationTriggers.ts`, join flow | ~20 | 3.1, 1.4 |
| 3.4 | Wire notification 6 (Vote Created) — on new vote/poll creation | `utils/notificationTriggers.ts`, vote creation | ~20 | 3.1 |
| 3.5 | Wire notification 7 (Dates Locked) — dual channel with `calendar_prompt: true` | `utils/notificationTriggers.ts`, finalization | ~25 | 3.1 |
| 3.6 | Wire notification 8 (Activity Added) — 15min batch window | `utils/notificationTriggers.ts`, activity creation | ~20 | 3.1, 1.4 |
| 3.7 | Wire notification 9 (Flight Booked) — 15min batch window | `utils/notificationTriggers.ts`, flight creation | ~20 | 3.1, 1.4 |
| 3.8 | Wire notification 19 (Settle Up Amounts) — personalized push per member | `utils/notificationTriggers.ts`, settle-up flow | ~30 | 3.1 |
| 3.9 | Wire notification 20 (Payment Received) — push to payee | `utils/notificationTriggers.ts`, payment code | ~15 | 3.1 |
| 3.10 | Wire notification 21 (All Settled) — group chat when all balances = $0 | `utils/notificationTriggers.ts`, payment code | ~20 | 3.1 |

### Phase 4: Scheduled and Batched Notifications

| No | Task | Files | Est. Lines | Dependencies |
|---|---|---|---|---|
| 4.1 | Create `process-notification-batch` edge fn — query queue, group by `(trip_id, key)`, compose batched copy, send, mark sent | `supabase/functions/process-notification-batch/index.ts` | ~120 | 1.4, 2.1, 2.2 |
| 4.2 | Create `trigger-scheduled-notifications` edge fn — hourly cron for: 3, 5, 10, 11, 12, 13, 15, 16, 17, 18, 22, 23 | `supabase/functions/trigger-scheduled-notifications/index.ts` | ~250 | 1.3, 1.6, 2.1, 2.2 |
| 4.3 | Migration: pg_cron schedules — batch every 1 min, scheduled every 1 hour | `supabase/migrations/2026XXXXX_notifications_cron_schedules.sql` | ~15 | 4.1, 4.2 |
| 4.4 | Wire notification 4 (Invite Link Opened) — queue in-app notification for 24hr later | `supabase/functions/trigger-scheduled-notifications/index.ts` | ~20 | 4.2 |

### Phase 5: Client UI — Badge and Settings

| No | Task | Files | Est. Lines | Dependencies |
|---|---|---|---|---|
| 5.1 | Create `hooks/useExpenseBadge.ts` — query expense count since `last_viewed_expenses_at`, return `{ badgeCount, clearBadge }` | `hooks/useExpenseBadge.ts` | ~45 | 1.5 |
| 5.2 | Add expense badge to trip detail tab bar — render count on Expenses tab, clear on tab focus | `app/trip/[id].tsx` | ~25 (net) | 5.1 |
| 5.3 | Create trip notification settings screen — segmented control (All / Important Only / Muted) | `app/trip/[id]/notification-settings.tsx` | ~90 | 2.5 |
| 5.4 | Register notification-settings route + overflow menu entry | `app/_layout.tsx`, `app/trip/[id].tsx` | ~10 | 5.3 |
| 5.5 | Add global notification toggles to settings — 4 category switches | `app/settings.tsx` | ~60 | 2.5 |
| 5.6 | Create push permission nudge bottom sheet — Enable + Not now, 7-day cooldown, max 2 shows | `components/PushPermissionNudge.tsx` | ~80 | None |
| 5.7 | Wire nudge — show after joining trip or first vote | `app/join/[tripId].tsx`, vote code | ~15 | 5.6 |

### Phase 6: Calendar Sync and Deep Link Polish

| No | Task | Files | Est. Lines | Dependencies |
|---|---|---|---|---|
| 6.1 | Create `utils/calendarSync.ts` — add trip to calendar via `expo-calendar`, track skip per trip | `utils/calendarSync.ts` | ~70 | None |
| 6.2 | Create calendar sync bottom sheet — "Add to Calendar" + "Skip" | `components/CalendarSyncSheet.tsx` | ~75 | 6.1 |
| 6.3 | Wire calendar sync — detect `calendar_prompt: true` in notification tap handler | `app/_layout.tsx` | ~15 | 6.2 |
| 6.4 | Expand deep link parser — add vote, expenses/add, expenses/settle, activities, flights, itinerary, transport routes | `utils/linking.ts` | ~30 | None |
| 6.5 | Update notification tap handler — use `deep_link` from data instead of `tripId` + `tab` | `app/_layout.tsx` | ~20 | 6.4 |

---

## Files to Create

| File | Purpose |
|---|---|
| `supabase/migrations/2026XXXXX_notifications_push_tokens_upgrade.sql` | Add `device_id`, `is_active` to push_tokens |
| `supabase/migrations/2026XXXXX_notifications_preferences_upgrade.sql` | Add trip-level prefs, push_tier, new categories |
| `supabase/migrations/2026XXXXX_notifications_log_table.sql` | Create notification_log table |
| `supabase/migrations/2026XXXXX_notifications_pending_queue.sql` | Create pending_notifications queue table |
| `supabase/migrations/2026XXXXX_trip_members_expense_badge.sql` | Add last_viewed_expenses_at to trip_members |
| `supabase/migrations/2026XXXXX_trips_timezone_settle_deadline.sql` | Add timezone, settle_up_deadline to trips |
| `supabase/migrations/2026XXXXX_notifications_cron_schedules.sql` | pg_cron schedule setup |
| `supabase/functions/send-group-chat-message/index.ts` | Group chat delivery (stub with push fallback) |
| `supabase/functions/process-notification-batch/index.ts` | Batching engine (1-min cron) |
| `supabase/functions/trigger-scheduled-notifications/index.ts` | Hourly cron for time-based notifications |
| `utils/notificationTriggers.ts` | Central dispatch: triggerNotification(key, tripId, data) |
| `utils/calendarSync.ts` | Calendar sync logic via expo-calendar |
| `hooks/useNotificationPreferences.ts` | Read/write notification prefs from Supabase |
| `hooks/useExpenseBadge.ts` | Expense badge count + clear |
| `components/PushPermissionNudge.tsx` | Bottom sheet for push permission ask |
| `components/CalendarSyncSheet.tsx` | Bottom sheet for calendar add prompt |
| `app/trip/[id]/notification-settings.tsx` | Per-trip notification settings screen |

## Files to Modify

| File | Changes |
|---|---|
| `types/index.ts` | Add notification key types, PushTier, update Trip interface, NotificationPreferencesV2 |
| `supabase/functions/send-push-notification/index.ts` | notification_key handling, per-trip tier + category filtering, notification_log writes, is_active check |
| `utils/notifications.ts` | Update token save (device_id, is_active), update NotificationType, add notification_key to payloads, add NOTIFICATION_CATEGORY_MAP |
| `utils/linking.ts` | Add new deep link routes (vote, expenses/add, expenses/settle, activities, flights, etc.) |
| `app/_layout.tsx` | Update notification tap handler for deep_link, wire calendar sync, register notification-settings route |
| `app/trip/[id].tsx` | Add expense badge to tab bar, wire useExpenseBadge, add notification settings to overflow menu |
| `app/settings.tsx` | Add Notifications section with 4 category toggles |
| `app/join/[tripId].tsx` | Wire push permission nudge after joining |
| `utils/pushPermissions.ts` | Add 7-day cooldown logic, max 2 shows tracking |

---

## Migration Plan

All migrations deploy before client/edge function code ships.

### Migration 1: Push Tokens Upgrade
```sql
ALTER TABLE push_tokens ADD COLUMN IF NOT EXISTS device_id TEXT;
ALTER TABLE push_tokens ADD COLUMN IF NOT EXISTS is_active BOOLEAN NOT NULL DEFAULT true;
CREATE INDEX IF NOT EXISTS idx_push_tokens_active ON push_tokens(user_id) WHERE is_active = true;
```

### Migration 2: Notification Preferences Upgrade
```sql
-- Deduplicate existing rows (keep latest per user_id)
DELETE FROM notification_preferences a USING notification_preferences b
  WHERE a.user_id = b.user_id AND a.created_at < b.created_at;

ALTER TABLE notification_preferences DROP CONSTRAINT IF EXISTS notification_preferences_user_id_key;
ALTER TABLE notification_preferences ADD COLUMN IF NOT EXISTS trip_id UUID REFERENCES trips(id) ON DELETE CASCADE;
ALTER TABLE notification_preferences ADD COLUMN IF NOT EXISTS push_tier TEXT CHECK (push_tier IN ('all', 'important_only', 'muted')) DEFAULT 'all';
ALTER TABLE notification_preferences ADD COLUMN IF NOT EXISTS push_trip_updates BOOLEAN DEFAULT true;
ALTER TABLE notification_preferences ADD COLUMN IF NOT EXISTS push_voting BOOLEAN DEFAULT true;
ALTER TABLE notification_preferences ADD COLUMN IF NOT EXISTS push_expenses BOOLEAN DEFAULT true;
ALTER TABLE notification_preferences ADD COLUMN IF NOT EXISTS push_reminders BOOLEAN DEFAULT true;
ALTER TABLE notification_preferences ADD CONSTRAINT notification_preferences_user_trip_unique UNIQUE(user_id, trip_id);
```

### Migration 3: Notification Log
```sql
CREATE TABLE notification_log (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  notification_key TEXT NOT NULL,
  trip_id UUID REFERENCES trips(id),
  recipient_user_id UUID REFERENCES auth.users(id),
  channel TEXT NOT NULL CHECK (channel IN ('push', 'group_chat', 'sms', 'badge', 'in_app')),
  title TEXT,
  body TEXT,
  deep_link TEXT,
  sent_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  batch_id UUID
);
ALTER TABLE notification_log ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users read own logs" ON notification_log
  FOR SELECT USING (auth.uid() = recipient_user_id);
CREATE INDEX idx_notification_log_recipient ON notification_log(recipient_user_id);
CREATE INDEX idx_notification_log_trip ON notification_log(trip_id);
CREATE INDEX idx_notification_log_key ON notification_log(notification_key);
```

### Migration 4: Pending Notifications Queue
```sql
CREATE TABLE pending_notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  notification_key TEXT NOT NULL,
  trip_id UUID NOT NULL REFERENCES trips(id) ON DELETE CASCADE,
  triggered_by_user_id UUID REFERENCES auth.users(id),
  channel TEXT NOT NULL CHECK (channel IN ('push', 'group_chat')),
  data JSONB NOT NULL DEFAULT '{}',
  batch_window_minutes INT NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  sent_at TIMESTAMPTZ
);
ALTER TABLE pending_notifications ENABLE ROW LEVEL SECURITY;
CREATE INDEX idx_pending_notifications_unsent ON pending_notifications(notification_key, trip_id) WHERE sent_at IS NULL;
```

### Migration 5: Expense Badge Tracking
```sql
ALTER TABLE trip_members ADD COLUMN IF NOT EXISTS last_viewed_expenses_at TIMESTAMPTZ;
```

### Migration 6: Trip Timezone and Settle-Up Deadline
```sql
ALTER TABLE trips ADD COLUMN IF NOT EXISTS timezone TEXT;
ALTER TABLE trips ADD COLUMN IF NOT EXISTS settle_up_deadline TIMESTAMPTZ;
```

---

## Risk Areas

| Risk | Impact | Mitigation |
|---|---|---|
| `notification_preferences` unique constraint change | Migration fails if duplicate `(user_id, NULL)` rows | Deduplicate first in migration |
| pg_cron not enabled on project | Scheduled notifications will not fire | Verify extension. Fallback: Supabase cron webhooks |
| Expo push token churn | Stale tokens = delivery failure | `is_active` flag + `DeviceNotRegistered` cleanup |
| Batching race conditions | Duplicate sends | Atomic claim: `UPDATE ... SET sent_at = now() WHERE sent_at IS NULL RETURNING *` |
| Missing `trips.timezone` | Wrong scheduled notification times | Fallback: creator TZ then UTC |
| FRD says `invite_trips`, code has `trip_invites` | Wrong table reference | Use `trip_invites` (actual) |
| Old notification helpers | Stale copy/types | Deprecate, replace with `triggerNotification()` |
| Calendar permission denied | Silent failure | Catch error, do not re-prompt for that trip |

---

## Implementation Order

```
1.1-1.6  (all migrations -- single deploy)
  |
 1.7     (types update)
  |
 2.1-2.5 (push infra -- edge fns + client utils + prefs hook)
  |
 3.1     (notification dispatch module)
  |
 3.2-3.10  |  5.1-5.7  |  6.1-6.5   (three parallel streams)
  |
 4.1-4.4   (scheduled + batched -- after event wiring)
```

Three parallelizable streams after Phase 2:
- **Stream A:** Event wiring (3.x) then Scheduled (4.x)
- **Stream B:** Client UI -- badge, settings, nudge (5.x)
- **Stream C:** Calendar sync + deep links (6.x)

---

## Verification Checkpoints

| After Tasks | Check |
|---|---|
| 1.1-1.6 | Deploy migrations, verify tables |
| 1.7 | `npm run typecheck` |
| 2.1 | Deploy edge fn, curl test, verify notification_log row |
| 2.3-2.4 | `npm run typecheck` |
| 3.1 | `npm run typecheck` |
| 3.2-3.10 | `npm test` -- no regressions |
| 4.1-4.2 | Deploy, manual queue test |
| 5.1-5.2 | Manual: expense badge appears + clears |
| 5.3-5.5 | Manual: settings persist to DB |
| 6.1-6.3 | Manual: calendar prompt on dates-locked tap |
| 6.4-6.5 | Manual: deep link navigation works |
| ALL | `npm run typecheck` + `npm test` |
