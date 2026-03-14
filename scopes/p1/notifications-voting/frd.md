# Scope 3: Notifications & Voting — FRD

> **Status:** ready
> **Phase:** P1: Core App
> **Gantt ID:** `p1-notifications-voting`
> **Assignee:** Muneeb
> **Date:** March 14, 2026
> **Parent:** [Spec](spec.md) | [Notification Matrix v4](/_private/notes/notification-matrix.html)

---

## 1. Overview

This FRD covers the notification delivery system for Tryps — 22 notifications across 4 trip lifecycle phases, routed through 5 channels (Group Chat, Push, Badge, In-App, SMS). Voting mechanics (48hr windows, up/down, auto-close) are already built; this scope adds notification triggers and delivery infrastructure.

### Channel Architecture

| Channel | Delivery Mechanism | Count | Use Case |
|---|---|---|---|
| Group Chat | Tryps agent → iMessage group thread (via Linq) | 9 | Social/collaborative moments |
| Push | Expo push notification → device | 7 | Private/actionable items |
| Badge | Red dot + count on Expenses tab | 1 | Passive new-content indicator |
| In-App | Feed item visible on app open | 1 | Low-priority analytics |
| Push OR SMS | Conditional on app install status | 1 | Invite to non-app users |
| Group Chat + Push | Dual-channel (milestone/money) | 3 | Can't-miss moments |

**Dual-channel rate:** 13% (3 of 22). Only fires for: dates locked (#7), Day 1 (#12), 24hr expense deadline (#17).

---

## 2. Database Schema

### 2.1 `push_tokens` table

Stores Expo push tokens per user per device.

```sql
CREATE TABLE push_tokens (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  expo_push_token TEXT NOT NULL,
  device_id TEXT NOT NULL,
  platform TEXT NOT NULL CHECK (platform IN ('ios', 'android')),
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(user_id, device_id)
);

-- RLS: users can only read/write their own tokens
ALTER TABLE push_tokens ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own tokens" ON push_tokens
  FOR ALL USING (auth.uid() = user_id);
```

### 2.2 `notification_preferences` table

Per-trip and global notification settings.

```sql
CREATE TABLE notification_preferences (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  trip_id UUID REFERENCES trips(id) ON DELETE CASCADE,  -- NULL = global setting
  -- Per-trip tier (only when trip_id is set)
  push_tier TEXT CHECK (push_tier IN ('all', 'important_only', 'muted')) DEFAULT 'all',
  -- Global category toggles (only when trip_id is NULL)
  push_trip_updates BOOLEAN DEFAULT true,
  push_voting BOOLEAN DEFAULT true,
  push_expenses BOOLEAN DEFAULT true,
  push_reminders BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(user_id, trip_id)
);

-- RLS
ALTER TABLE notification_preferences ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users manage own prefs" ON notification_preferences
  FOR ALL USING (auth.uid() = user_id);
```

### 2.3 `notification_log` table

Audit log of all sent notifications for debugging and analytics.

```sql
CREATE TABLE notification_log (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  notification_key TEXT NOT NULL,  -- e.g., 'invite', 'vote_created', 'day_1'
  trip_id UUID REFERENCES trips(id),
  recipient_user_id UUID REFERENCES auth.users(id),
  channel TEXT NOT NULL CHECK (channel IN ('push', 'group_chat', 'sms', 'badge', 'in_app')),
  title TEXT,
  body TEXT,
  deep_link TEXT,
  sent_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  batch_id UUID  -- groups batched notifications together
);

-- RLS: users can read their own log entries
ALTER TABLE notification_log ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users read own logs" ON notification_log
  FOR SELECT USING (auth.uid() = recipient_user_id);
```

### 2.4 `expense_tab_badge` tracking

No separate table. Track via a `last_viewed_expenses_at` column on the existing `trip_members` table:

```sql
ALTER TABLE trip_members ADD COLUMN last_viewed_expenses_at TIMESTAMPTZ;
```

Badge count = `SELECT COUNT(*) FROM expenses WHERE trip_id = $1 AND created_at > $2` (where `$2` is `last_viewed_expenses_at`).

---

## 3. Edge Functions

### 3.1 `send-push-notification`

Core push delivery function. All other functions call this.

**Endpoint:** `POST /functions/v1/send-push-notification`

**Request:**
```json
{
  "user_ids": ["uuid-1", "uuid-2"],
  "title": "Vote closes in 1 hour!",
  "body": "Pick your dates for Cabo 2026",
  "data": {
    "deep_link": "tripful://trip/abc123/vote",
    "notification_key": "vote_deadline",
    "trip_id": "abc123"
  }
}
```

**Logic:**
1. Look up active `push_tokens` for all `user_ids`
2. Check each user's `notification_preferences` — skip if muted for this category/trip
3. Build Expo push messages (one per token — users may have multiple devices)
4. Send via Expo Push API (`https://exp.host/--/api/v2/push/send`)
5. Log to `notification_log`
6. Handle Expo receipts — deactivate tokens that return `DeviceNotRegistered`

**Preference filtering logic:**
- If user has per-trip `push_tier = 'muted'` → only send if `notification_key` is in settle-up category
- If user has per-trip `push_tier = 'important_only'` → only send if `notification_key` is non-negotiable, vote, or settle-up
- If user has global category toggled off → skip that category

### 3.2 `send-group-chat-message`

Routes a message through the Tryps agent to the trip's iMessage group.

**Endpoint:** `POST /functions/v1/send-group-chat-message`

**Request:**
```json
{
  "trip_id": "abc123",
  "message": "Sarah is in for Cabo 2026!",
  "deep_link": "tripful://trip/abc123",
  "notification_key": "member_joined"
}
```

**Logic:**
1. Look up the trip's Linq `conversation_id` (stored on `trips` table)
2. If no `conversation_id` → **fallback to push** (Linq not yet connected for this trip)
3. Send via Linq outbound API (`POST /send` with `conversation_id`)
4. Log to `notification_log` with `channel = 'group_chat'`

**P1 behavior:** Until Linq ships (P2), ALL group chat notifications fall back to push. The edge function is built and ready — it just always hits the fallback path.

### 3.3 `process-notification-batch`

Batching engine. Called by a Supabase cron or pg_cron.

**Endpoint:** `POST /functions/v1/process-notification-batch`

**Logic:**
1. Query a `pending_notifications` queue table for unbatched items
2. Group by `(trip_id, notification_key, batch_window)`
3. For each group where the oldest item exceeds the batch window:
   - If count = 1 → send as individual notification
   - If count > 1 → compose batched copy (e.g., "Sarah and 3 others are in for Cabo")
   - Send via appropriate channel
   - Mark items as sent

**Batch windows:**
| Notification | Window |
|---|---|
| Member joins (#2) | 5 min |
| Activities added (#8) | 15 min |
| Flights booked (#9) | 15 min |

**Cron schedule:** Every 1 minute (`* * * * *`). Checks for batches that have exceeded their window.

### 3.4 `trigger-scheduled-notifications`

Handles time-based notifications (countdowns, deadlines, daily digest).

**Endpoint:** Called by pg_cron, not HTTP.

**Schedule:** Every hour (`0 * * * *`).

**Logic:**
1. **7-day countdown (#10):** Query trips starting in exactly 7 days → send group chat message with flight booking stats
2. **1-day countdown (#11):** Query trips starting tomorrow → send group chat message with itinerary link
3. **Day 1 (#12):** Query trips starting today, 9am local → send group chat + push (dual)
4. **Daily digest (#16):** Query active trips, 8am local → send group chat with day's itinerary summary (only if itinerary has items)
5. **24hr expense deadline (#17):** Query trips with settle-up deadline in 24hr → send group chat + push (dual)
6. **1hr expense deadline (#18):** Query trips with settle-up deadline in 1hr → send push only
7. **Payment overdue (#22):** Query unsettled balances 48hr+ after settle-up → push to creator
8. **Debtor nudge (#23):** Query unsettled balances at 72hr, then weekly (max 3) → push to debtor

**Timezone handling:** Use the trip's destination timezone for "9am local" / "8am local" calculations. Stored on `trips.timezone`.

---

## 4. Notification Catalog (All 22)

Each notification specifies: trigger, channel, copy template, deep link, batching, and preference category.

### Phase 1: Invite & Onboarding

#### #1 — Trip Invite
- **Trigger:** `invite_trips` row created
- **Channel:** Push (if invitee has app) OR SMS (if not)
- **Copy:** `"[Name] invited you to [Trip]!"`
- **Example:** `"Jake invited you to Cabo 2026!"`
- **Deep link:** `tripful://trip/{trip_id}/join`
- **SMS variant:** Include app download link + trip join URL
- **Category:** Trip Updates
- **Batching:** None

#### #2 — Member Joined
- **Trigger:** `trip_members` row inserted with `status = 'accepted'`
- **Channel:** Group Chat
- **Copy:** `"[Name] is in for [Trip]!"`
- **Batched copy:** `"[Name] and [N] others are in for [Trip]!"`
- **Example:** `"Sarah is in for Cabo 2026!"`
- **Deep link:** `tripful://trip/{trip_id}/people`
- **Category:** Trip Updates
- **Batching:** 5 min window

#### #3 — Invite Pending (48hr)
- **Trigger:** Scheduled check — `invite_trips` row with `status = 'pending'` older than 48hr
- **Channel:** Push
- **Copy:** `"[Name] hasn't responded to your [Trip] invite yet"`
- **Example:** `"Mike hasn't responded to your Cabo invite yet"`
- **Deep link:** `tripful://trip/{trip_id}/people`
- **Who:** Trip creator only
- **Category:** Trip Updates
- **Constraint:** Max 1 per invitee. Never send a second reminder.

#### #4 — Invite Link Opened
- **Trigger:** Invite link HTTP request logged (analytics event)
- **Channel:** In-App
- **Copy:** `"[Name] checked out your [Trip] invite — nudge them?"`
- **Example:** `"Mike checked out your Cabo invite — nudge them?"`
- **Who:** Trip creator only
- **Category:** Trip Updates
- **Timing:** 24hr after link opened

### Phase 2: Planning (Pre-Trip)

#### #5 — Vote Deadline (1hr)
- **Trigger:** Scheduled — vote closes in 1hr
- **Channel:** Push
- **Copy:** `"Vote closes in 1 hour! Pick your dates for [Trip]"`
- **Example:** `"Vote closes in 1 hour! Pick your dates for Cabo 2026"`
- **Deep link:** `tripful://trip/{trip_id}/vote/{vote_id}`
- **Who:** Members who haven't voted only
- **Category:** Voting & Polls
- **Batching:** None

#### #6 — Vote Created
- **Trigger:** New vote/poll created (dates, location, or activity)
- **Channel:** Group Chat
- **Copy:** `"[Name] started a vote: [question]"`
- **Example:** `"Jake started a vote: When should we go?"`
- **Deep link:** `tripful://trip/{trip_id}/vote/{vote_id}`
- **Category:** Voting & Polls
- **Batching:** None

#### #7 — Dates Locked ⚡ DUAL
- **Trigger:** Creator finalizes vote / locks dates
- **Channel:** Group Chat + Push
- **Copy:** `"It's official! [Trip] is [dates] in [location]"`
- **Example:** `"It's official! Cabo 2026 is Mar 15-20 in Cabo San Lucas"`
- **Deep link:** `tripful://trip/{trip_id}`
- **Push data:** Include `calendar_prompt: true` to trigger calendar sync prompt on open
- **Category:** Trip Updates
- **Batching:** None

#### #8 — Activity Added
- **Trigger:** Activity/restaurant/event added to trip itinerary
- **Channel:** Group Chat
- **Copy:** `"[Name] added [item] to [Trip]"`
- **Batched copy:** `"[Name] added [N] activities to [Trip]"`
- **Example:** `"Sarah added Flora Farms dinner to Cabo 2026"`
- **Deep link:** `tripful://trip/{trip_id}/activities`
- **Category:** Trip Updates
- **Batching:** 15 min window

#### #9 — Flight Booked
- **Trigger:** Flight record added to trip
- **Channel:** Group Chat
- **Copy:** `"[Name] booked their flight for [Trip]"`
- **Batched copy:** `"[Name] and [Name] booked their flights for [Trip]"`
- **Example:** `"Mike booked his flight for Cabo 2026"`
- **Deep link:** `tripful://trip/{trip_id}/flights`
- **Category:** Trip Updates
- **Batching:** 15 min window

#### #10 — 7-Day Countdown
- **Trigger:** Scheduled — 7 days before `trip.start_date`
- **Channel:** Group Chat
- **Copy:** `"1 week until [Trip]! [X] of [Y] have booked flights"`
- **Example:** `"1 week until Cabo! 4 of 6 have booked flights"`
- **Deep link:** `tripful://trip/{trip_id}`
- **Category:** Trip Reminders
- **Batching:** None

#### #11 — 1-Day Countdown
- **Trigger:** Scheduled — 1 day before `trip.start_date`
- **Channel:** Group Chat
- **Copy:** `"[Trip] is tomorrow — check your itinerary"`
- **Example:** `"Cabo 2026 is tomorrow — check your itinerary"`
- **Deep link:** `tripful://trip/{trip_id}/itinerary`
- **Category:** Trip Reminders
- **Batching:** None

### Phase 3: During Trip (Active)

#### #12 — Day 1 ⚡ DUAL
- **Trigger:** Scheduled — morning of `trip.start_date`, 9am destination timezone
- **Channel:** Group Chat + Push
- **Copy:** `"Day 1 of [Trip]! Let's go 🎉"`
- **Example:** `"Day 1 of Cabo 2026! Let's go 🎉"`
- **Deep link:** `tripful://trip/{trip_id}`
- **Category:** Trip Reminders
- **Batching:** None

#### #13 — Flight Landed
- **Trigger:** Scheduled — at flight's `arrival_time` + 30min buffer
- **Channel:** Push
- **Copy:** `"Welcome to [City]! Need a ride to [Stay Address]?"`
- **Example:** `"Welcome to Cabo! Need a ride to 123 Marina Blvd?"`
- **Deep link:** `tripful://trip/{trip_id}/transport`
- **Who:** Only the user whose flight landed
- **Requires:** Flight data with arrival time + stay address on file
- **Category:** Trip Reminders
- **Batching:** None

#### #14 — Expense Badge
- **Trigger:** Any expense added to a trip where user is a member
- **Channel:** Badge (Expenses tab)
- **Copy:** No notification copy — badge shows count (e.g., "3")
- **Logic:** `COUNT(expenses WHERE created_at > trip_members.last_viewed_expenses_at)`
- **Clears:** When user opens Expenses tab → update `last_viewed_expenses_at = now()`
- **Active:** Anytime (during trip and post-trip)
- **Category:** N/A (not a notification, UI-only)

#### #15 — Upcoming Activity (1hr)
- **Trigger:** Scheduled — 1hr before itinerary item with a set time
- **Channel:** Group Chat
- **Copy:** `"[Activity] in 1 hour at [Location]"`
- **Example:** `"Sunset sail in 1 hour at Marina Dock B"`
- **Deep link:** `tripful://trip/{trip_id}/itinerary`
- **Requires:** Itinerary item with `start_time` set
- **Category:** Trip Reminders
- **Batching:** None

#### #16 — Daily Morning Digest
- **Trigger:** Scheduled — 8am destination timezone, active trip days only
- **Channel:** Group Chat
- **Copy:** `"Today in [Trip]: [X] activities planned"`
- **Example:** `"Today in Cabo: 3 activities planned. First up: beach yoga at 9am"`
- **Requires:** At least 1 itinerary item for the day. Skip if empty.
- **Deep link:** `tripful://trip/{trip_id}/itinerary`
- **Category:** Trip Reminders
- **Batching:** None

### Phase 4: Expenses & Settle Up

#### #17 — 24hr Expense Deadline ⚡ DUAL
- **Trigger:** Scheduled — 24hr before `trip.settle_up_deadline`
- **Channel:** Group Chat + Push
- **Copy:** `"Expenses close tomorrow for [Trip] — add yours now"`
- **Example:** `"Expenses close tomorrow for Cabo 2026 — add yours now"`
- **Deep link:** `tripful://trip/{trip_id}/expenses/add`
- **Default deadline:** 48hr after trip end date (auto-set, creator can change)
- **Category:** Expenses
- **Batching:** None

#### #18 — 1hr Expense Deadline
- **Trigger:** Scheduled — 1hr before `trip.settle_up_deadline`
- **Channel:** Push
- **Copy:** `"Last call! Expenses lock in 1 hour for [Trip]"`
- **Example:** `"Last call! Expenses lock in 1 hour for Cabo 2026"`
- **Deep link:** `tripful://trip/{trip_id}/expenses/add`
- **Category:** Expenses
- **Batching:** None

#### #19 — Settle Up Amounts
- **Trigger:** Trip creator clicks "Settle Up" → expenses locked
- **Channel:** Push
- **Copy:** `"[Trip] expenses are locked. You owe [Name] $[amount]"`
- **Example:** `"Cabo expenses are locked. You owe Jake $142.50"`
- **Deep link:** `tripful://trip/{trip_id}/expenses/settle`
- **Who:** Each member gets personalized amount. Members who owe nothing get: `"[Trip] expenses are locked. You're all good — $0 owed!"`
- **Category:** Expenses
- **Batching:** None

#### #20 — Payment Received
- **Trigger:** Payment recorded (manual or via payment provider)
- **Channel:** Push
- **Copy:** `"[Name] paid you $[amount] for [Trip]"`
- **Example:** `"Mike paid you $85.00 for Cabo 2026"`
- **Deep link:** `tripful://trip/{trip_id}/expenses`
- **Who:** The person who was paid
- **Category:** Expenses
- **Batching:** None

#### #21 — All Settled
- **Trigger:** All balances for trip reach $0
- **Channel:** Group Chat
- **Copy:** `"All squared away! [Trip] expenses: $0 owed 🎉"`
- **Example:** `"All squared away! Cabo expenses: $0 owed 🎉"`
- **Deep link:** `tripful://trip/{trip_id}/expenses`
- **Category:** Expenses
- **Batching:** None

#### #22 — Payment Overdue (Creator)
- **Trigger:** Scheduled — 48hr after settle-up with outstanding balances
- **Channel:** Push
- **Copy:** `"[Name] still owes $[amount] for [Trip]"`
- **Example:** `"Mike still owes $85.00 for Cabo 2026"`
- **Deep link:** `tripful://trip/{trip_id}/expenses`
- **Who:** Trip creator only. Never in group chat.
- **Category:** Expenses
- **Batching:** None

#### #23 — Debtor Nudge
- **Trigger:** Scheduled — 72hr after settle-up, then weekly
- **Channel:** Push
- **Copy:** `"Settle up: $[amount] remaining for [Trip]"`
- **Example:** `"Settle up: $85.00 remaining for Cabo"`
- **Deep link:** `tripful://trip/{trip_id}/expenses/settle`
- **Who:** The member who owes. System-sent, not from a person.
- **Constraint:** Max 3 nudges total, then stop permanently.
- **Category:** Expenses
- **Batching:** None

---

## 5. Client-Side Implementation

### 5.1 Push Token Registration

**File:** `utils/notifications.ts` (new)

```typescript
import * as Notifications from 'expo-notifications';
import { supabase } from '@/utils/supabase';
import * as Device from 'expo-device';

export async function registerForPushNotifications(): Promise<string | null> {
  if (!Device.isDevice) return null;

  const { status: existing } = await Notifications.getPermissionsAsync();
  let finalStatus = existing;

  if (existing !== 'granted') {
    const { status } = await Notifications.requestPermissionsAsync();
    finalStatus = status;
  }

  if (finalStatus !== 'granted') return null;

  const token = (await Notifications.getExpoPushTokenAsync({
    projectId: 'your-expo-project-id',
  })).data;

  // Upsert token to Supabase
  const { data: { user } } = await supabase.auth.getUser();
  if (user) {
    await supabase.from('push_tokens').upsert({
      user_id: user.id,
      expo_push_token: token,
      device_id: Device.modelId ?? 'unknown',
      platform: Device.osName?.toLowerCase() === 'ios' ? 'ios' : 'android',
      is_active: true,
    }, { onConflict: 'user_id,device_id' });
  }

  return token;
}
```

**Call on:** App launch (in `AuthContext` after `SIGNED_IN` event) and after profile setup.

### 5.2 Push Permission Nudge

If user hasn't granted push permission, show a nudge after their first meaningful action:

**Trigger points:**
1. After joining a trip (accepting an invite)
2. After casting their first vote

**UI:** Bottom sheet or modal: "Turn on notifications so you don't miss votes, trip updates, and when it's time to settle up." with "Enable" and "Not now" buttons.

**"Not now" behavior:** Don't show again for 7 days. After 7 days, show once more on next meaningful action. After second dismissal, never show again.

### 5.3 Deep Link Handling

**File:** `app/_layout.tsx` (extend existing)

Register a notification response listener:

```typescript
Notifications.addNotificationResponseReceivedListener(response => {
  const deepLink = response.notification.request.content.data?.deep_link;
  if (deepLink) {
    router.push(deepLink.replace('tripful://', '/'));
  }
});
```

### 5.4 Expense Tab Badge

**File:** `app/(tabs)/_layout.tsx` (modify existing tab bar)

- Query `last_viewed_expenses_at` from `trip_members` for the current trip
- Count expenses newer than that timestamp
- Render badge on Expenses tab icon: red dot with white count text
- On Expenses tab focus → `UPDATE trip_members SET last_viewed_expenses_at = now()`

### 5.5 Calendar Sync

**Trigger:** When push notification #7 (dates locked) arrives with `calendar_prompt: true`

**UI flow:**
1. App opens to trip detail
2. Bottom sheet appears: "Add [Trip] to your calendar?" with trip name, dates, location
3. "Add to Calendar" → create single calendar event via `expo-calendar`
4. "Skip" → dismiss, don't ask again for this trip

**Calendar event:**
- Title: `[Trip Name]`
- Start: `trip.start_date` (all-day)
- End: `trip.end_date` (all-day)
- Location: `trip.location`
- Notes: `"Planned with Tryps — tripful://trip/{trip_id}"`

---

## 6. Settings Screens

### 6.1 Trip Notification Settings

**Location:** Trip detail → overflow menu → "Notifications"

**UI:**
- Segmented control: **All** | **Important Only** | **Muted**
- Description text below:
  - All: "Get notified about everything in this trip"
  - Important Only: "Only votes, deadlines, and payments"
  - Muted: "Only payment notifications"
- Note: "Group chat messages are managed in iMessage settings"

### 6.2 Global Notification Settings

**Location:** Profile → Settings → "Notifications"

**UI:**
- Section header: "Push Notification Categories"
- Toggle rows:
  - Trip Updates (joins, activities, dates) — default ON
  - Voting & Polls — default ON
  - Expenses — default ON
  - Trip Reminders (countdowns, daily digest) — default ON
- Note at bottom: "Per-trip settings override these. Group chat messages are managed in iMessage."

---

## 7. Edge Cases

1. **User has no push token** — they never granted permission. Group chat notifications still reach them via iMessage. Push-only notifications are silently dropped (logged but not delivered). Badge still works.

2. **Trip has no Linq conversation** — all group chat notifications fall back to push. The same copy, just delivered as push instead of iMessage.

3. **User is in multiple trips** — notifications always include the trip name. Deep links go to the specific trip. Badge counts are per-trip on the Expenses tab (only visible when viewing that trip).

4. **Batch window has only 1 item** — send as individual notification, not batched. No "Jake and 0 others" bugs.

5. **User removes the app** — Expo push token returns `DeviceNotRegistered`. Edge function marks token as `is_active = false`. No retry.

6. **Creator doesn't set settle-up deadline** — auto-set to 48hr after `trip.end_date`. Notifications #17 and #18 fire based on this default.

7. **Flight data missing for #13** — skip the notification. Don't send "Welcome to [City]!" without a stay address. Both fields required.

8. **Trip has no itinerary items for daily digest (#16)** — skip that day's digest. Don't send "Today in Cabo: 0 activities planned."

9. **Debtor nudge (#23) max reached** — after 3 nudges, mark as `nudge_exhausted` in notification_log. Never send again. Creator can still see outstanding balance in #22.

10. **Timezone edge cases** — "9am local" and "8am local" use `trip.timezone`. If timezone is null, fall back to trip creator's timezone. If that's null, use UTC.

---

## 8. Dependencies

| Dependency | Status | Impact if not ready |
|---|---|---|
| Expo Notifications SDK | Available | None — core infrastructure |
| Supabase Edge Functions | Available | None — already using them |
| Linq integration (P2) | Not started | Group chat → push fallback. No iMessage delivery until P2. |
| Voting mechanics | Already built | None — triggers hook into existing vote events |
| Expenses system | Already built | None — triggers hook into existing expense events |
| `expo-calendar` | Available | Calendar sync feature only |

---

## 9. Implementation Order

1. **Database tables** — `push_tokens`, `notification_preferences`, `notification_log`, `last_viewed_expenses_at` column
2. **Push token registration** — client-side `registerForPushNotifications()` + upsert to Supabase
3. **`send-push-notification` edge function** — core delivery with preference filtering
4. **Event-triggered notifications** — #1 (invite), #2 (join), #6 (vote), #7 (dates locked), #8 (activity), #9 (flight), #19 (settle up), #20 (payment), #21 (all settled)
5. **Expense badge** — `last_viewed_expenses_at` tracking + badge on tab
6. **Scheduled notifications** — cron for countdowns, deadlines, daily digest, overdue/nudge
7. **`send-group-chat-message` edge function** — stub with push fallback (wired to Linq in P2)
8. **Batching engine** — `process-notification-batch` edge function + cron
9. **Settings screens** — per-trip tier + global toggles
10. **Calendar sync** — `expo-calendar` integration on dates-locked event
11. **Push permission nudge** — bottom sheet after first meaningful action

---

## 10. What's NOT in This Scope

- **Notification center / activity feed** — no in-app notification list. Push and group chat are the channels.
- **Email notifications** — not a channel for Tryps. Push, group chat, SMS (invite only).
- **Voting UI changes** — voting mechanics are already built. This scope only adds notification triggers.
- **Rich push notifications** — no images, no action buttons beyond tap-to-open. Keep it simple for P1.
- **Analytics dashboard for notifications** — `notification_log` exists for debugging but no UI to view it.
