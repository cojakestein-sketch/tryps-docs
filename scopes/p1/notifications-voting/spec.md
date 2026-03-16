---
feature: Notifications & Voting
date: 2026-03-14
status: ready
---

# P1 Scope 3: Notifications & Voting — Spec

> **Phase:** P1: Core App
> **Gantt ID:** `p1-notifications-voting`
> **Comp:** [Partiful](https://partiful.com/) — push + SMS reminders for events. Similar channel-routing decisions but for parties, not trips.

## What

Push notification infrastructure, channel routing (push vs group chat vs badge), and all 22 notification triggers across the trip lifecycle.

## Why

Groups need to stay informed without opening the app. The Tryps agent lives in the iMessage group chat — most social/collaborative notifications go there. Push notifications are reserved for private, actionable items (votes, expense deadlines, payment amounts). This scope builds the delivery layer on top of the already-built voting mechanics.

## Intent

> "The group chat is the notification layer. Push is for the private stuff — what you owe, your vote deadline, your payment. Everything social stays in the thread where the trip lives."
>
> "No notification center, no activity feed. If it's important enough to tell you, it goes to your lock screen or the group chat. That's it."

## Success Criteria

### Push Notification Infrastructure

- [ ] **SC-1.** Expo push token registered on app launch and sign-in, stored in Supabase linked to user_id + device. Verified by: user signs in on two devices -> both push tokens stored -> sending a notification delivers to both devices.

- [ ] **SC-2.** Supabase edge function sends push notifications accepting user_ids, title, body, and data/deep_link. Verified by: call edge function with user_id, title "Vote closes soon", body, and deep link -> user receives push -> tapping it opens the correct screen.

- [ ] **SC-3.** Deep links from push notifications resolve to the correct screen. Verified by: push notification with deep link to expense tab -> tap notification -> app opens directly to expenses for that trip.

### Group Chat Delivery (via Tryps Agent)

- [ ] **SC-4.** Agent can send messages to a trip's iMessage group thread. Verified by: trigger a group-chat notification -> message appears in the iMessage group within 5 seconds.

- [ ] **SC-5.** Agent messages batched per batching rules (5min for joins, 15min for activities/flights). Verified by: 3 people join within 2 minutes -> single batched message "Jake, Sarah, and Tom joined" instead of 3 separate messages.

- [ ] **SC-6.** Agent messages include deep links back to the app where relevant. Verified by: agent sends "New activity added: Nobu on Friday" -> message includes a tap-to-open link -> tapping opens the activity in the app.

- [ ] **SC-7.** When Linq is not yet live, group chat notifications fall back to push. Verified by: trigger a group-chat notification with no Linq integration -> notification delivered as push to all trip members instead.

### Notification Triggers — Phase 1: Invite

- [ ] **SC-8.** #1 Invite sent — recipient receives push/SMS. Verified by: Jake invites Sarah -> Sarah gets a push (if app installed) or SMS (if not) with trip name and invite link.

- [ ] **SC-9.** #2 Member joined — group chat message. Verified by: Sarah joins trip -> group chat shows "Sarah joined the trip."

- [ ] **SC-10.** #3 Pending invite 48hr reminder — push to inviter. Verified by: invite sent, no response after 48hrs -> inviter gets push "Sarah hasn't joined yet — nudge them?"

- [ ] **SC-11.** #4 Invite link opened — push to trip creator. Verified by: invitee opens link but doesn't join -> creator gets push "Someone opened your invite link."

### Notification Triggers — Phase 2: Planning

- [ ] **SC-12.** #5 Vote deadline approaching — push to voters who haven't voted. Verified by: vote closing in 6hrs, Tom hasn't voted -> Tom gets push "Vote closes in 6 hours — cast your vote."

- [ ] **SC-13.** #6 New vote created — group chat message. Verified by: Jake creates a vote for dinner spot -> group chat shows "Jake started a vote: Where should we eat?"

- [ ] **SC-14.** #7 Dates locked — dual-channel (push + group chat). Verified by: dates finalized -> all members get push AND group chat message "Trip dates locked: Mar 20-24."

- [ ] **SC-15.** #8 Activity added — group chat message (batched 15min). Verified by: 2 activities added within 10 minutes -> single batched group chat message listing both.

- [ ] **SC-16.** #9 Flight booked — group chat message (batched 15min). Verified by: Sarah adds her flight -> group chat shows "Sarah added a flight: JFK → MIA, Mar 20."

- [ ] **SC-17.** #10 7-day countdown — group chat message. Verified by: 7 days before trip start -> group chat shows "7 days until Miami!"

- [ ] **SC-18.** #11 1-day countdown — group chat message. Verified by: 1 day before trip start -> group chat shows "Tomorrow! Final check — everyone packed?"

### Notification Triggers — Phase 3: During Trip

- [ ] **SC-19.** #12 Day 1 — dual-channel (push + group chat). Verified by: trip start date arrives -> all members get push AND group chat message "Day 1 — let's go!"

- [ ] **SC-20.** #13 Flight landed — group chat message. Verified by: Sarah's flight lands (detected via flight tracking) -> group chat shows "Sarah just landed!"

- [ ] **SC-21.** #14 Expense badge — in-app badge, not a notification. Verified by: new expense added -> Expenses tab shows red dot with count -> no push sent.

- [ ] **SC-22.** #15 Upcoming activity — push to trip members. Verified by: activity starts in 1 hour -> all members get push "Nobu dinner in 1 hour."

- [ ] **SC-23.** #16 Daily digest — group chat message. Verified by: each morning during trip -> group chat shows today's itinerary summary.

### Notification Triggers — Phase 4: Settle Up

- [ ] **SC-24.** #17 24hr expense deadline — dual-channel (push + group chat). Verified by: 24hrs after trip ends -> all members get push AND group chat "Last call — add any remaining expenses by tomorrow."

- [ ] **SC-25.** #18 1hr expense deadline — push to all members. Verified by: 1hr before expense window closes -> push "Expense window closes in 1 hour."

- [ ] **SC-26.** #19 Settle up amounts — push to each debtor with their specific amount. Verified by: expenses finalized -> Tom gets push "You owe Jake $45 and Sarah $30."

- [ ] **SC-27.** #20 Payment received — push to payee. Verified by: Tom pays Jake -> Jake gets push "Tom sent you $45."

- [ ] **SC-28.** #21 All settled — group chat message. Verified by: all debts resolved -> group chat shows "Everyone's settled up! Trip complete."

- [ ] **SC-29.** #22 Overdue payment — push to debtor. Verified by: 7 days past settle-up with outstanding balance -> debtor gets push "You still owe Jake $45."

- [ ] **SC-30.** #23 Debtor nudge — push to debtor when payee nudges. Verified by: Jake taps "Nudge" on Tom's balance -> Tom gets push "Jake is waiting on $45."

### Expense Tab Badge

- [ ] **SC-31.** Red dot with count ("3 new") on Expenses tab when new expenses added since last viewed. Verified by: 3 expenses added while user is on another tab -> Expenses tab shows red dot with "3 new" -> user opens Expenses tab -> badge clears.

- [ ] **SC-32.** Badge appears anytime, not just during trip. Verified by: pre-trip expense added -> badge shows on Expenses tab.

### Settings

- [ ] **SC-33.** Per-trip push tier: All / Important Only / Muted (default: All). Verified by: user sets trip to "Important Only" -> only milestone notifications (#7, #12, #17) are delivered as push -> others suppressed.

- [ ] **SC-34.** Global push category toggles: Trip Updates, Voting & Polls, Expenses, Trip Reminders. Verified by: user disables "Voting & Polls" -> vote-related pushes stop -> other categories still deliver.

- [ ] **SC-35.** Calendar sync prompt when dates finalize. Verified by: dates locked (#7) -> prompt to add trip dates to Apple/Google Calendar -> user confirms -> calendar event created.

### Push Permission

- [ ] **SC-36.** Nudge to enable push notifications after first meaningful action (joining a trip, casting a vote). Verified by: user joins a trip without push permission -> prompt appears "Enable notifications to stay in the loop" -> user grants permission -> token registered.

### Should NOT Happen

- [ ] **SC-37.** Push and SMS are never sent for the same notification. SMS is only for inviting non-app users. Verified by: trigger all 22 notifications for a user with the app installed -> none arrive via SMS.

- [ ] **SC-38.** No notification center or in-app activity feed exists. Push and group chat are the only delivery channels; badge is the only in-app indicator. Verified by: inspect all app screens -> no notification inbox, bell icon, or activity feed.

- [ ] **SC-39.** Agent does not send individual messages when batching rules apply. Verified by: 4 activities added within 15 minutes -> exactly 1 batched group chat message, not 4.

- [ ] **SC-40.** Non-trip members do not receive any trip notifications. Verified by: user not in trip -> no push, group chat, or badge for that trip's events.

### Out of Scope

- **Voting mechanics** — 48hr windows, up/down votes on dates/location/activities, auto-close are already built. This scope only adds notification triggers on top.
- **Group chat depends on Linq (P2)** — for P1, group chat notifications fall back to push. When Linq ships, they route through iMessage automatically.
- **Notification copy changes** — all 22 notification strings are finalized in the notification matrix (v4). Dev implements as-is.
- **Batching is server-side** — the edge function holds notifications for the batch window before sending. No client-side batching logic.

### Regression Risk

| Area | Why | Risk |
|------|-----|------|
| Push token management | Token registration on every launch could conflict with existing auth flow | Medium |
| Expense tab | Badge state management adds new reactive layer to existing tab | Medium |
| Voting system | Adding notification triggers on top of existing vote lifecycle | Low |
| Trip settings | New per-trip and global toggles add settings surface area | Low |

## References

- Notification Matrix v4: `_private/notes/notification-matrix.html`
- Competitor analyses: `_private/notes/{splitwise,airbnb,strava,partiful,beli}-notification-analysis.md`
- Linq FRD (group chat architecture): `scopes/p2/linq-imessage/frd.md`

- [ ] Typecheck passes
