# Tryps Scope Tracker

> Auto-generated from spec.md frontmatter. Do not edit manually.
> Last updated: 2026-03-18 14:30 UTC
> Run `./generate-status.sh` to refresh.

## All Scopes

| | ID | Title | Status | Assignee | Criteria | Blocked |
|---|-----|-------|--------|----------|----------|---------|
| -- | p1-claude-connector | Claude Connector | not-started | krisna | 0/36 |  |
| -- | p1-core-flows | Core Flows | not-started | asif | NEEDS SPEC |  |
| -- | p1-notifications-voting | Notifications & Voting | not-started | nadeem | 0/41 |  |
| -- | p1-post-trip-review | Post-Trip Review | not-started | unassigned | 0/39 |  |
| -- | p1-recommendations | Recommendations | not-started | unassigned | NEEDS SPEC |  |
| -- | p1-tooltips-teaching | Tooltips & Teaching | not-started | unassigned | NEEDS SPEC |  |
| -- | p1-travel-dna | Travel DNA | not-started | arslan | 0/25 |  |
| -- | p2-booking-links | Booking Links | not-started | unassigned | NEEDS SPEC |  |
| -- | p2-connectors | Travel Life Connectors | not-started | arslan | 0/25 |  |
| -- | p2-linq-imessage | iMessage via Linq | not-started | krisna | 0/41 |  |
| -- | p2-stripe-payments | Stripe Payments | not-started | unassigned | 0/12 |  |
| -- | p3-duffel-apis | Duffel APIs | not-started | unassigned | NEEDS SPEC | BLOCKED |
| -- | p3-logistics-agent | Logistics Agent | not-started | unassigned | 0/26 | BLOCKED |
| -- | p3-pay-on-behalf | Pay on My Behalf | not-started | unassigned | NEEDS SPEC | BLOCKED |
| -- | p3-vote-on-behalf | Vote on My Behalf | not-started | unassigned | NEEDS SPEC | BLOCKED |
| -- | p4-giveaways | Giveaways | not-started | unassigned | NEEDS SPEC |  |
| -- | p4-launch-video | Launch Video | not-started | jake | 0/15 |  |
| -- | p4-referral-incentives | Referral Incentives | not-started | unassigned | NEEDS SPEC |  |
| -- | p4-socials-presence | Socials & Presence | not-started | jake | NEEDS SPEC |  |
| -- | p4-wispr-playbook | Wispr Flow Playbook | not-started | jake | NEEDS SPEC |  |
| -- | p5-friends-family | Friends & Family Testing | not-started | unassigned | NEEDS SPEC |  |
| -- | p5-strangers-review | Strangers Review | not-started | unassigned | NEEDS SPEC |  |

---

## Success Criteria Detail

Scopes with testable criteria. Review daily in standup.

### Claude Connector (p1-claude-connector) — krisna — 0/36

- [ ] **P1.S7.C01.** Remote MCP server is deployed and reachable over HTTPS. Verified by: send a JSON-RPC 2.0 `initialize` request to the server URL -> server responds with `serverInfo` and supported capabilities within 2 seconds.
- [ ] **P1.S7.C02.** Server uses Streamable HTTP transport (JSON-RPC 2.0 over POST). Verified by: send a POST request with `Content-Type: application/json` containing a valid MCP `tools/list` method -> server responds with a JSON-RPC result containing the tool list.
- [ ] **P1.S7.C03.** CORS headers allow requests from Claude browser clients. Verified by: send an OPTIONS preflight request with `Origin: https://claude.ai` -> response includes `Access-Control-Allow-Origin` matching the origin.
- [ ] **P1.S7.C04.** Tool responses stay under 25,000 tokens. Verified by: call `get_trip_itinerary` on a trip with 14 days and 5+ activities per day -> response is under 25,000 tokens -> if data exceeds limit, response is paginated or summarized.
- [ ] **P1.S7.C05.** Authorization code flow with PKCE authenticates against Supabase Auth. Verified by: initiate OAuth flow from Claude -> redirected to Tryps login -> enter credentials -> redirected back to Claude with access token -> Claude can call tools as the authenticated user.
- [ ] **P1.S7.C06.** Claude callback URLs are allowlisted. Verified by: OAuth redirect uses `https://claude.ai/api/mcp/auth_callback` -> redirect completes without error -> repeat with `https://claude.com/api/mcp/auth_callback` -> both succeed.
- [ ] **P1.S7.C07.** Each Claude session acts on behalf of the authenticated Tryps user. Verified by: User A authenticates -> calls `get_trips` -> sees only User A's trips -> User B authenticates in a separate Claude session -> sees only User B's trips.
- [ ] **P1.S7.C08.** Token refresh works without re-authentication. Verified by: authenticate -> wait for access token to expire -> call a tool -> server refreshes the token automatically -> tool call succeeds without prompting login again.
- [ ] **P1.S7.C09.** `get_trips` returns the user's trips filtered by status. Verified by: user has 3 upcoming and 2 past trips -> call `get_trips` with filter "upcoming" -> response contains exactly the 3 upcoming trips with name, destination, dates, and member count.
- [ ] **P1.S7.C10.** `get_trip_details` returns the full trip card. Verified by: call with a valid trip ID -> response includes destination, start/end dates, member list, trip status, and vibe description.
- [ ] **P1.S7.C11.** `get_trip_itinerary` returns the day-by-day plan. Verified by: call on a trip with a 3-day itinerary -> response lists each day with its scheduled activities, times, and locations.
- [ ] **P1.S7.C12.** `get_trip_activities` returns activities with vote counts. Verified by: trip has 5 activities, 2 with votes -> response lists all 5 activities with names, descriptions, and vote tallies for the voted ones.
- [ ] **P1.S7.C13.** `get_trip_members` returns participants with RSVP and flight info. Verified by: trip has 4 members (2 confirmed, 1 pending, 1 with flight added) -> response shows all 4 with correct RSVP status and flight details where present.
- [ ] **P1.S7.C14.** `get_trip_expenses` returns expense breakdown and balances. Verified by: trip has 3 expenses totaling $300 split among 3 people -> response shows each expense, the split, and per-person balances (who owes whom).
- [ ] **P1.S7.C15.** `get_trip_stay` returns accommodation details and voting status. Verified by: trip has 2 stay options, one with 3 votes -> response lists both options with details and vote counts.
- [ ] **P1.S7.C16.** `search_trips` finds trips by destination, date, or keyword. Verified by: user has trips to "Barcelona" and "Tokyo" -> search for "Barcelona" -> response returns only the Barcelona trip.
- [ ] **P1.S7.C17.** `create_trip` creates a trip with destination, dates, and vibe. Verified by: call with destination "Lisbon", dates Mar 20-25, vibe "chill beach vibes" -> trip appears in the user's trip list in the Tryps app with all provided details.
- [ ] **P1.S7.C18.** `add_activity` adds an activity to a trip. Verified by: call with trip ID and activity "Sunset boat tour" -> activity appears on the trip's Activities tab in the app.
- [ ] **P1.S7.C19.** `update_itinerary` modifies the day-by-day plan. Verified by: call to move "Boat tour" from Day 2 to Day 3 -> open trip's Itinerary tab in app -> boat tour is now on Day 3.
- [ ] **P1.S7.C20.** `invite_member` invites someone to a trip by phone number or Tryps username. Verified by: call with a phone number -> invitee receives an invite -> invitee joins the trip -> they appear on the trip's People tab.
- [ ] **P1.S7.C21.** `add_expense` logs an expense with split info. Verified by: call with "Dinner at Nobu, $200, split equally 4 ways" -> expense appears on Expenses tab with $50 per person.
- [ ] **P1.S7.C22.** `update_trip` modifies trip details. Verified by: call to change trip dates from Mar 20-25 to Mar 22-27 -> trip card in app shows updated dates.
- [ ] **P1.S7.C23.** Every read tool has `readOnlyHint: true` annotation. Verified by: call `tools/list` -> inspect each read tool's annotations -> all 8 read tools include `readOnlyHint: true`.
- [ ] **P1.S7.C24.** Every write tool has `destructiveHint: true` annotation. Verified by: call `tools/list` -> inspect each write tool's annotations -> all 6 write tools include `destructiveHint: true`.
- [ ] **P1.S7.C25.** Write tools prompt Claude to confirm with the user before executing. Verified by: ask Claude to "create a trip to Tokyo" -> Claude describes what it will do and asks for confirmation -> user confirms -> tool is called.
- [ ] **P1.S7.C26.** MCP Inspector validation passes for all tools. Verified by: point MCP Inspector at the server URL -> run full validation suite -> all tools pass schema validation, auth checks, and response format checks.
- [ ] **P1.S7.C27.** Server works as a custom connector in claude.ai. Verified by: add the server URL in Claude Settings under "Connected MCP Servers" -> start a new conversation -> ask Claude "What trips do I have?" -> Claude calls `get_trips` and returns results from the user's Tryps account.
- [ ] **P1.S7.C28.** All 14 tools are callable from a Claude conversation. Verified by: in a single Claude conversation, call each of the 8 read tools and 6 write tools -> all return valid responses or successfully execute the action.
- [ ] **P1.S7.C29.** Row-Level Security enforced — users only see and modify their own trips. Verified by: User A creates a trip -> User B authenticates and calls `get_trips` -> User B's response does not include User A's trip -> User B calls `get_trip_details` with User A's trip ID -> error returned, not the trip data.
- [ ] **P1.S7.C30.** Documentation includes 3+ example prompts showing what users can do. Verified by: review documentation page -> at least 3 example prompts shown (e.g., "Plan a 5-day trip to Barcelona," "Add a sunset boat tour to my Miami trip," "How much do I owe on the Tokyo trip?").
- [ ] **P1.S7.C31.** Privacy policy and support contact are publicly accessible. Verified by: click the privacy policy link from the connector listing -> page loads -> support email or contact form is visible.
- [ ] **P1.S7.C32.** Test credentials provided for Anthropic reviewers. Verified by: Anthropic reviewer uses the test account -> can authenticate, list trips, and call all tools against a seeded test dataset.
- [ ] **P1.S7.C33.** MCP server never bypasses Supabase Row-Level Security. Verified by: attempt to call `get_trip_details` with another user's trip ID from an authenticated session -> server returns an authorization error, not the trip data.
- [ ] **P1.S7.C34.** No new database tables are created for the connector. Verified by: compare database schema before and after deploying the MCP server -> no new tables added -> connector uses only existing RPCs and queries.
- [ ] **P1.S7.C35.** Tool responses never leak data from other users' trips. Verified by: call every read tool as User A -> inspect all response payloads -> no trip IDs, member names, or expense data belonging to other users appears.
- [ ] Typecheck passes

### Notifications & Voting (p1-notifications-voting) — nadeem — 0/41

- [ ] **SC-1.** Expo push token registered on app launch and sign-in, stored in Supabase linked to user_id + device. Verified by: user signs in on two devices -> both push tokens stored -> sending a notification delivers to both devices.
- [ ] **SC-2.** Supabase edge function sends push notifications accepting user_ids, title, body, and data/deep_link. Verified by: call edge function with user_id, title "Vote closes soon", body, and deep link -> user receives push -> tapping it opens the correct screen.
- [ ] **SC-3.** Deep links from push notifications resolve to the correct screen. Verified by: push notification with deep link to expense tab -> tap notification -> app opens directly to expenses for that trip.
- [ ] **SC-4.** Agent can send messages to a trip's iMessage group thread. Verified by: trigger a group-chat notification -> message appears in the iMessage group within 5 seconds.
- [ ] **SC-5.** Agent messages batched per batching rules (5min for joins, 15min for activities/flights). Verified by: 3 people join within 2 minutes -> single batched message "Jake, Sarah, and Tom joined" instead of 3 separate messages.
- [ ] **SC-6.** Agent messages include deep links back to the app where relevant. Verified by: agent sends "New activity added: Nobu on Friday" -> message includes a tap-to-open link -> tapping opens the activity in the app.
- [ ] **SC-7.** When Linq is not yet live, group chat notifications fall back to push. Verified by: trigger a group-chat notification with no Linq integration -> notification delivered as push to all trip members instead.
- [ ] **SC-8.** #1 Invite sent — recipient receives push/SMS. Verified by: Jake invites Sarah -> Sarah gets a push (if app installed) or SMS (if not) with trip name and invite link.
- [ ] **SC-9.** #2 Member joined — group chat message. Verified by: Sarah joins trip -> group chat shows "Sarah joined the trip."
- [ ] **SC-10.** #3 Pending invite 48hr reminder — push to inviter. Verified by: invite sent, no response after 48hrs -> inviter gets push "Sarah hasn't joined yet — nudge them?"
- [ ] **SC-11.** #4 Invite link opened — push to trip creator. Verified by: invitee opens link but doesn't join -> creator gets push "Someone opened your invite link."
- [ ] **SC-12.** #5 Vote deadline approaching — push to voters who haven't voted. Verified by: vote closing in 6hrs, Tom hasn't voted -> Tom gets push "Vote closes in 6 hours — cast your vote."
- [ ] **SC-13.** #6 New vote created — group chat message. Verified by: Jake creates a vote for dinner spot -> group chat shows "Jake started a vote: Where should we eat?"
- [ ] **SC-14.** #7 Dates locked — dual-channel (push + group chat). Verified by: dates finalized -> all members get push AND group chat message "Trip dates locked: Mar 20-24."
- [ ] **SC-15.** #8 Activity added — group chat message (batched 15min). Verified by: 2 activities added within 10 minutes -> single batched group chat message listing both.
- [ ] **SC-16.** #9 Flight booked — group chat message (batched 15min). Verified by: Sarah adds her flight -> group chat shows "Sarah added a flight: JFK → MIA, Mar 20."
- [ ] **SC-17.** #10 7-day countdown — group chat message. Verified by: 7 days before trip start -> group chat shows "7 days until Miami!"
- [ ] **SC-18.** #11 1-day countdown — group chat message. Verified by: 1 day before trip start -> group chat shows "Tomorrow! Final check — everyone packed?"
- [ ] **SC-19.** #12 Day 1 — dual-channel (push + group chat). Verified by: trip start date arrives -> all members get push AND group chat message "Day 1 — let's go!"
- [ ] **SC-20.** #13 Flight landed — group chat message. Verified by: Sarah's flight lands (detected via flight tracking) -> group chat shows "Sarah just landed!"
- [ ] **SC-21.** #14 Expense badge — in-app badge, not a notification. Verified by: new expense added -> Expenses tab shows red dot with count -> no push sent.
- [ ] **SC-22.** #15 Upcoming activity — push to trip members. Verified by: activity starts in 1 hour -> all members get push "Nobu dinner in 1 hour."
- [ ] **SC-23.** #16 Daily digest — group chat message. Verified by: each morning during trip -> group chat shows today's itinerary summary.
- [ ] **SC-24.** #17 24hr expense deadline — dual-channel (push + group chat). Verified by: 24hrs after trip ends -> all members get push AND group chat "Last call — add any remaining expenses by tomorrow."
- [ ] **SC-25.** #18 1hr expense deadline — push to all members. Verified by: 1hr before expense window closes -> push "Expense window closes in 1 hour."
- [ ] **SC-26.** #19 Settle up amounts — push to each debtor with their specific amount. Verified by: expenses finalized -> Tom gets push "You owe Jake $45 and Sarah $30."
- [ ] **SC-27.** #20 Payment received — push to payee. Verified by: Tom pays Jake -> Jake gets push "Tom sent you $45."
- [ ] **SC-28.** #21 All settled — group chat message. Verified by: all debts resolved -> group chat shows "Everyone's settled up! Trip complete."
- [ ] **SC-29.** #22 Overdue payment — push to debtor. Verified by: 7 days past settle-up with outstanding balance -> debtor gets push "You still owe Jake $45."
- [ ] **SC-30.** #23 Debtor nudge — push to debtor when payee nudges. Verified by: Jake taps "Nudge" on Tom's balance -> Tom gets push "Jake is waiting on $45."
- [ ] **SC-31.** Red dot with count ("3 new") on Expenses tab when new expenses added since last viewed. Verified by: 3 expenses added while user is on another tab -> Expenses tab shows red dot with "3 new" -> user opens Expenses tab -> badge clears.
- [ ] **SC-32.** Badge appears anytime, not just during trip. Verified by: pre-trip expense added -> badge shows on Expenses tab.
- [ ] **SC-33.** Per-trip push tier: All / Important Only / Muted (default: All). Verified by: user sets trip to "Important Only" -> only milestone notifications (#7, #12, #17) are delivered as push -> others suppressed.
- [ ] **SC-34.** Global push category toggles: Trip Updates, Voting & Polls, Expenses, Trip Reminders. Verified by: user disables "Voting & Polls" -> vote-related pushes stop -> other categories still deliver.
- [ ] **SC-35.** Calendar sync prompt when dates finalize. Verified by: dates locked (#7) -> prompt to add trip dates to Apple/Google Calendar -> user confirms -> calendar event created.
- [ ] **SC-36.** Nudge to enable push notifications after first meaningful action (joining a trip, casting a vote). Verified by: user joins a trip without push permission -> prompt appears "Enable notifications to stay in the loop" -> user grants permission -> token registered.
- [ ] **SC-37.** Push and SMS are never sent for the same notification. SMS is only for inviting non-app users. Verified by: trigger all 22 notifications for a user with the app installed -> none arrive via SMS.
- [ ] **SC-38.** No notification center or in-app activity feed exists. Push and group chat are the only delivery channels; badge is the only in-app indicator. Verified by: inspect all app screens -> no notification inbox, bell icon, or activity feed.
- [ ] **SC-39.** Agent does not send individual messages when batching rules apply. Verified by: 4 activities added within 15 minutes -> exactly 1 batched group chat message, not 4.
- [ ] **SC-40.** Non-trip members do not receive any trip notifications. Verified by: user not in trip -> no push, group chat, or badge for that trip's events.
- [ ] Typecheck passes

### Post-Trip Review (p1-post-trip-review) — unassigned — 0/39

- [ ] `P1.S4.C01` — Trip Complete bottom sheet appears automatically for each member after trip end date. Verified by: trip end date passes → member opens app → bottom sheet overlay appears on the trip detail screen.
- [ ] `P1.S4.C02` — Trip stats bar shows accurate Days, People, Places, Spent totals. Verified by: trip with 5 days, 4 people, 3 places, $1200 spent → bottom sheet shows "5 Days · 4 People · 3 Places · $1,200 Spent".
- [ ] `P1.S4.C03` — Post-trip flow works independently of expense settlement status. Verified by: trip with unsettled expenses ends → bottom sheet still appears → top 3 and time capsule flows are not blocked.
- [ ] `P1.S4.C04` — Each user can select exactly 3 favorite activities from the trip's activity list. Verified by: trip with 6 activities → user taps 3 activity cards → counter shows 3/3 → submit button enables.
- [ ] `P1.S4.C05` — Activity selection persists per-user and feeds into the recommendation data store. Verified by: Alice picks activities A, B, C → Bob picks B, D, E → each user's selections are stored independently → recommendation data updated.
- [ ] `P1.S4.C06` — Dismissed users see a persistent blinking banner on the past trip card prompting them to complete top 3. Verified by: user dismisses bottom sheet without selecting → trip card on home screen shows blinking "Mark your top 3 favorites" banner.
- [ ] `P1.S4.C07` — Dismissed users receive a push notification reminding them to complete top 3. Verified by: user dismisses bottom sheet → push notification arrives within 24 hours → tapping it opens the top 3 selection screen.
- [ ] `P1.S4.C08` — Banner disappears only after top 3 is submitted. Verified by: user submits 3 favorites → navigate to home → trip card no longer shows the blinking banner.
- [ ] `P1.S4.C09` — During active trips, users can record and submit 6-second video clips to the time capsule. Verified by: active trip → open Vibe tab → tap capture → record 6-second clip → submit → confirmation shown.
- [ ] `P1.S4.C10` — Submitted clips are blind — not viewable by sender or any group member. Verified by: Alice submits a clip → Alice navigates time capsule section → no playback option for any clip → Bob checks → same result.
- [ ] `P1.S4.C11` — Users can delete their own submitted clip. Verified by: user submits clip → sees "You submitted 1 clip" with delete option → taps delete → confirmation → clip count decrements.
- [ ] `P1.S4.C12` — Clip capture UI exists on the Vibe tab with clear affordance. Verified by: open trip during active dates → navigate to Vibe tab → capture button/section is visible without scrolling.
- [ ] `P1.S4.C13` — Time capsule accepts both photos and 6-second video clips. Verified by: user submits a photo → user submits a video → both count toward time capsule total.
- [ ] `P1.S4.C14` — When joining a trip, user sees a message about the time capsule. Verified by: new member joins trip → notification or onboarding message includes "This trip has a time capsule — add moments!"
- [ ] `P1.S4.C15` — Mid-trip nudge reminds users to add clips. Verified by: 3 days before trip end → push notification: "3 days left — add a moment to the time capsule. Send a push notification on the very last day fo the trip to remind members to add their memories."
- [ ] `P1.S4.C16` — Low-participation feedback shown post-trip. Verified by: trip with only 1 clip submitted by group → post-trip screen shows "Submit more videos next time!"
- [ ] `P1.S4.C17` — AI generates a 60-second montage from all submitted clips and photos. Verified by: trip ends with 8 clips + 4 photos → montage generated → duration is 60 seconds or less → photos appear as 2-3 second stills with disposable camera filter.
- [ ] `P1.S4.C18` — Simultaneous push notification triggers montage reveal for all group members. Verified by: montage ready → all 4 trip members receive push notification at the same time → tapping opens montage player.
- [ ] `P1.S4.C19` — Disposable camera visual aesthetic applied to all montage content. Verified by: watch montage → video clips and photos show grain, warm tones, and slight imperfection.
- [ ] `P1.S4.C20` — Montage includes music from trip's Spotify playlist (if linked) or default ambient track. Verified by: trip with linked Spotify playlist → montage plays with playlist track. Trip without playlist → montage plays with ambient default.
- [ ] `P1.S4.C21` — Montage is permanently re-watchable and downloadable from the completed trip detail screen. Verified by: after initial reveal → navigate to completed trip → montage player is accessible → plays the full montage.
- [ ] `P1.S4.C22` — Share button on montage player opens native share sheet with the video file. Verified by: open montage player → tap Share → iOS share sheet appears with video file → shareable to iMessage, Instagram Stories, TikTok.
- [ ] `P1.S4.C23` — Group Top 3 aggregation view shows ranked activities by vote count. Verified by: 4 of 6 members submit top 3 → Group Favorites view shows activities ranked by number of picks → "4 of 6 people loved this" label on top activity.
- [ ] `P1.S4.C24` — Group Favorites visible to all trip members after submissions. Verified by: majority submits → any member opens the completed trip → Group Favorites section is visible.
- [ ] `P1.S4.C25` — Trip card on home screen reflects "completed" state with re-engagement prompts. Verified by: trip ends → home screen trip card shows completed visual state → if top 3 not submitted, shows blinking prompt.
- [ ] `P1.S4.C26` — Non-trip members cannot access or submit to the time capsule. Verified by: user not in the trip → no capture UI visible → API rejects clip submission.
- [ ] `P1.S4.C27` — Users cannot view submitted clips before the reveal — no preview, no gallery, no thumbnails. Verified by: during active trip → no UI path shows any submitted clip content.
- [ ] `P1.S4.C28` — Trip with fewer than 3 activities allows user to pick all available. Verified by: trip with 2 activities → user picks both → submit enables at 2/2 instead of requiring 3.
- [ ] `P1.S4.C29` — Trip with 0 time capsule submissions handles post-trip gracefully. Verified by: trip ends with no clips → no montage generated → post-trip flow skips reveal and shows top 3 only.
- [ ] `P1.S4.C30` — Montage generation handles async processing. Verified by: trip ends → user sees "Your time capsule is being created" loading state → montage appears when ready (minutes, not instant).
- [ ] `P1.S4.C31` — Typecheck passes
- [ ] Exact placement of time capsule capture UI on Vibe tab — dedicated section or floating action?
- [ ] What AI/ML tooling for montage generation? (FFmpeg + open-source video editing models?)
- [ ] Video storage strategy — Supabase Storage? S3? CDN for playback?
- [ ] Should the montage have music? If so, from the trip's Vibe playlist?
- [ ] Max clips per person? Per trip? (prevents storage abuse)
- [ ] What if a trip has 0 video submissions — skip the time capsule entirely or show an empty state?
- [ ] Default ambient track for montages without a Spotify playlist — what vibe/genre?
- [ ] Photo aspect ratio handling — crop to 16:9 for montage, or letterbox?

### Travel DNA (p1-travel-dna) — arslan — 0/25

- [ ] **P1.S5.C01.** User can generate a shareable image of their travel personality from the My DNA tab. Verified by: user who completed the core 10 questions -> taps Share on the My DNA tab -> image generated showing persona name, top trait pills, radar chart, and Tryps branding -> native share sheet opens with the image ready to send.
- [ ] **P1.S5.C02.** Sharing card displays the user's current persona archetype, their strongest trait pills, and the 10-dimension radar chart. Verified by: user with "Adventurous Explorer" persona and 4 strong traits -> generates card -> card shows "Adventurous Explorer" title, all 4 trait pills, radar chart with 10 axes, and Tryps logo.
- [ ] **P1.S5.C03.** Shared card image renders correctly at standard social media dimensions. Verified by: generate card -> save to camera roll -> open in Photos -> image is clear, text is legible, no cropping of persona name or chart on a standard phone screen.
- [ ] **P1.S5.C04.** Each trip has a free-text field on the Vibe tab where users describe special considerations for that trip. Verified by: user opens Vibe tab for a trip -> scrolls to free-text field -> types "I tore my ACL — no hiking or long walks" -> text saves -> reopening the Vibe tab shows the saved text.
- [ ] **P1.S5.C05.** The same free-text field appears at the bottom of the 10-question core quiz when a user joins a trip. Verified by: user joins a new trip -> completes the 10 core DNA questions -> free-text field appears below the last question with placeholder like "Anything special for this trip?" -> user types preferences -> text saves to that trip.
- [ ] **P1.S5.C06.** Free-text preferences are per-trip, not global. Verified by: user writes "I'm injured" on Trip A -> opens Trip B -> free-text field for Trip B is empty -> Trip A still shows "I'm injured."
- [ ] **P1.S5.C07.** Free-text preferences are private to the user who wrote them. Verified by: user writes preferences on Trip A -> another trip member opens the same trip's Vibe tab -> they do not see the first user's free-text content.
- [ ] **P1.S5.C08.** After completing signup, users who have not taken the DNA quiz see a prompt to discover their travel personality. Verified by: new user completes signup with zero DNA answers -> prompt appears (e.g., "Discover your travel personality — takes 2 minutes") -> tapping it opens the DNA quiz.
- [ ] **P1.S5.C09.** Post-onboarding nudge does not reappear after the user completes the core 10 questions. Verified by: user completes all 10 core questions -> navigates back to home -> onboarding nudge no longer appears.
- [ ] **P1.S5.C10.** When a user creates a trip and has not completed the core DNA quiz, a prompt appears during trip creation. Verified by: user with zero DNA answers taps "Create Trip" -> during the creation flow, a nudge appears (e.g., "Complete your Travel DNA for smarter trip suggestions") -> user can dismiss or tap to take the quiz.
- [ ] **P1.S5.C11.** Trip creation nudge does not block trip creation. Verified by: user sees the DNA nudge during trip creation -> dismisses it -> trip is still created successfully.
- [ ] **P1.S5.C12.** On a trip's People tab, a status indicator shows how many members have completed their DNA. Verified by: trip with 5 members, 3 have completed DNA -> People tab shows "3 of 5 completed Travel DNA" or equivalent visual.
- [ ] **P1.S5.C13.** Members who have not completed DNA are visually distinguishable from those who have, without revealing anyone's answers. Verified by: People tab shows member avatars -> completed members have a checkmark or filled indicator -> incomplete members show a prompt or unfilled indicator -> no scores, traits, or answers are visible for any member.
- [ ] **P1.S5.C14.** User's profile card shows DNA completion progress when the core quiz is partially complete. Verified by: user answers 7 of 10 core questions -> profile card shows a progress indicator (e.g., "7/10") -> completing all 10 replaces the progress bar with their persona name.
- [ ] **P1.S5.C15.** The Tryps agent sends a contextual message to the group chat when DNA data would improve a recommendation but members haven't completed it. Verified by: trip has 4 members, 2 incomplete -> agent is generating activity recommendations -> agent sends a message tied to the moment (e.g., "I'd give you better activity picks if everyone filled out their Travel DNA — 2 people haven't yet") -> message appears in the trip's group chat.
- [ ] **P1.S5.C16.** Agent DNA nudge fires at most once per trip. Verified by: agent sends DNA nudge for a trip -> same trip triggers recommendation generation again later -> no second nudge message is sent.
- [ ] **P1.S5.C17.** When enough trip members complete DNA, the trip displays a group vibe summary showing approximately three commonalities about the group. Verified by: 4 of 5 members complete DNA, all lean toward adventure and early mornings -> trip shows a group vibe section with ~3 commonalities like "Adventure seekers," "Early risers," "Budget-conscious."
- [ ] **P1.S5.C18.** Group vibe summary does not expose any individual's scores, answers, or dimension positions. Verified by: inspect the group vibe summary for a trip -> only aggregate traits visible (e.g., "Your group likes adventure") -> no individual names linked to specific preferences -> no numerical scores shown.
- [ ] **P1.S5.C19.** Group vibe summary updates when a new member completes their DNA. Verified by: trip shows "Adventure seekers, Early risers" with 3 members -> 4th member completes DNA with luxury and nightlife preferences -> group vibe summary recalculates and may shift (e.g., adds "Mixed on nightlife").
- [ ] **P1.S5.C20.** Individual DNA answers, dimension scores, persona, and radar chart are never visible to other trip members anywhere in the app. Verified by: inspect all trip screens (People tab, Vibe tab, group vibe summary, activity recommendations) -> no individual DNA data from other members is displayed.
- [ ] **P1.S5.C21.** The sharing card is the only way another person sees your DNA details, and it requires the user to explicitly tap Share. Verified by: user does not tap Share -> their persona, traits, and radar are not visible to anyone else in any context -> user taps Share and sends via iMessage -> recipient sees the card image.
- [ ] **P1.S5.C22.** Individual DNA answers or scores are never included in API responses to other users. Verified by: inspect network requests on the People tab and group vibe summary -> responses contain only aggregate data and completion booleans, never another user's raw answers or dimension scores.
- [ ] **P1.S5.C23.** Nudges never block or interrupt core app flows. Verified by: trigger each of the 5 nudge touchpoints -> in every case, the user can dismiss the nudge and continue their original task (signup, trip creation, browsing People tab) without completing the quiz.
- [ ] **P1.S5.C24.** The app never labels the group output as a "compatibility score" or shows a numerical compatibility percentage to users. Verified by: search all user-facing text in the trip -> no "compatibility score," "match percentage," or numerical group rating appears.
- [ ] Typecheck passes

### Travel Life Connectors (p2-connectors) — arslan — 0/25

- [ ] **P2.S4.C01.** User can open a "Connected Accounts" screen from their profile settings. Verified by: user taps profile icon → taps "Connected Accounts" → screen displays a list of supported travel services (airlines, hotels, rideshare, vacation rentals) grouped by category, each showing "Connected" or "Not connected."
- [ ] **P2.S4.C02.** User can connect an airline loyalty account by selecting an airline (e.g., American Airlines, Delta, United) and entering their frequent flyer number. Verified by: user taps "American Airlines" → enters AAdvantage number → taps Save → screen shows American Airlines as "Connected" with the last 4 digits of the number visible.
- [ ] **P2.S4.C03.** User can connect a hotel rewards account by selecting a hotel chain (e.g., Marriott Bonvoy, Hilton Honors) and entering their rewards number. Verified by: user taps "Marriott" → enters Bonvoy number → taps Save → screen shows Marriott as "Connected."
- [ ] **P2.S4.C04.** For services that support OAuth login (e.g., Airbnb, Uber, Lyft), tapping "Connect" opens the service's login page and links the account after the user authenticates. Verified by: user taps "Connect" on Airbnb → Airbnb login page opens in a browser → user signs in and authorizes → redirected back to Tryps → Airbnb shows as "Connected."
- [ ] **P2.S4.C05.** Loyalty and rewards numbers are validated before saving. If a number does not match the provider's expected format, the user sees an error and the number is not saved. Verified by: user enters "XYZ" as an American Airlines AAdvantage number → error message appears (e.g., "That doesn't look like a valid AAdvantage number") → number is not saved → user enters a correctly formatted number → saves successfully.
- [ ] **P2.S4.C06.** Connected accounts are linked to the user's profile and persist across all trips — not per-trip. Verified by: user connects American Airlines → creates Trip A → creates Trip B → both trips can access the same AA loyalty number without re-entering it.
- [ ] **P2.S4.C07.** User can disconnect a previously linked account and the stored data is permanently deleted. Verified by: user opens Connected Accounts → taps American Airlines (connected) → taps "Disconnect" → confirms → American Airlines shows "Not connected" → reconnecting later requires re-entering the number.
- [ ] **P2.S4.C08.** The Connected Accounts screen shows a progress indicator encouraging users to link more services. Verified by: user with 2 of 8 supported services connected → screen shows "2 of 8 connected" with a progress bar or ring and text encouraging more connections.
- [ ] **P2.S4.C09.** User can store passport details including full legal name, passport number, nationality, date of birth, issue date, and expiration date. Verified by: user opens "Travel Documents" from profile → taps "Add Passport" → fills all fields → saves → passport details appear on the Travel Documents screen with the passport number partially masked.
- [ ] **P2.S4.C10.** User can store a Known Traveler Number (Global Entry / TSA PreCheck). Verified by: user opens Travel Documents → taps "Add Known Traveler Number" → enters number → saves → number appears on the Travel Documents screen.
- [ ] **P2.S4.C11.** Passport and travel document data is encrypted at rest in the database — never stored as plaintext. Verified by: query the database table storing passport data → values in the passport number and Known Traveler Number columns are encrypted and unreadable without the decryption key.
- [ ] **P2.S4.C12.** Travel document data is accessible only to the user who owns it and to the booking system at the moment of booking. No other user or trip member can view it. Verified by: User A stores passport details → User B (same trip) inspects all app screens and API responses → no trace of User A's passport number, nationality, or date of birth appears.
- [ ] **P2.S4.C13.** The app warns the user when their stored passport expiration date is within 6 months of today. Verified by: user stores a passport expiring in 4 months → Travel Documents screen shows a warning badge (e.g., "Expires in 4 months — some countries require 6+ months validity") → user updates passport with later expiration → warning disappears.
- [ ] **P2.S4.C14.** Viewing or editing travel documents requires re-authentication via device biometrics (Face ID / Touch ID) or device PIN. Verified by: user taps "Travel Documents" → device biometric prompt appears → only after successful authentication are document details revealed → canceling authentication returns to profile without showing data.
- [ ] **P2.S4.C15.** When a user books a flight through Tryps, their stored frequent flyer number for that airline is automatically included in the booking request. Verified by: user with a stored AA AAdvantage number books an American Airlines flight → booking confirmation references the frequent flyer number → miles are credited to the user's loyalty account.
- [ ] **P2.S4.C16.** When one user books flights for the entire group, each group member's individual frequent flyer number is attached to their respective booking. Verified by: trip with 4 members, 3 have AA numbers stored → group AA flight booked → the 3 members' individual AA numbers appear on their respective booking confirmations → the 4th member's booking proceeds without a loyalty number.
- [ ] **P2.S4.C17.** When a user books a hotel through Tryps, their stored hotel rewards number is included in the booking request. Verified by: user with a Marriott Bonvoy number books a Marriott hotel → booking confirmation references the Bonvoy number → points are credited.
- [ ] **P2.S4.C18.** When booking an international flight, stored passport details (legal name, number, nationality, date of birth, expiration) are passed to the booking API so the user does not re-enter them. Verified by: user with stored passport books an international flight → booking API receives passport data → no manual passport entry screen appears during checkout.
- [ ] **P2.S4.C19.** If a group member has no loyalty number for the booking provider, that member's booking proceeds normally without a loyalty number — no error or blocking prompt. Verified by: user with no Delta SkyMiles number books a Delta flight → booking completes successfully → user simply does not earn miles for that flight.
- [ ] **P2.S4.C20.** On a trip's People tab, small provider logo badges appear next to each member's name showing which travel services they have connected. Verified by: trip People tab → "Quinn" shows an American Airlines logo badge and a Marriott logo badge → "Jake" shows Delta and Hilton badges → a member with no connections shows no badges.
- [ ] **P2.S4.C21.** Tapping a member's connection badge does not reveal their loyalty number, account details, or any personal data — only that they are connected to that service. Verified by: user taps Quinn's AA badge → no account number, loyalty details, or personal information is displayed → at most a label like "Quinn is connected to American Airlines."
- [ ] **P2.S4.C22.** Passport numbers, travel document details, and full loyalty account numbers are never visible to other trip members anywhere in the app. Verified by: inspect the People tab, trip details, group chat, and all visible screens for a trip → no other member's passport data or full loyalty numbers appear.
- [ ] **P2.S4.C23.** Travel document and loyalty data is never included in API responses to other users. Verified by: call the trip members API authenticated as User B → response for User A contains only connection status (connected/not connected per service), never passport numbers or loyalty account numbers.
- [ ] **P2.S4.C24.** Disconnecting an account permanently deletes the stored number — no soft-delete, no retention. Verified by: user disconnects AA → query the database for that user's AA entry → no record or remnant exists.
- [ ] Typecheck passes

### iMessage via Linq (p2-linq-imessage) — krisna — 0/41

- [ ] **SC-1.** A user adds the Tryps number to an existing iMessage group chat. The agent sends a welcome message within 5 seconds — who it is, one example of what to ask, and an App Store link. Verified by: add Tryps number to a 4-person group chat -> agent responds with welcome -> message is under 6 lines.
- [ ] **SC-2.** Everyone in the group chat is automatically part of the trip. No signup, no app download, no email. Verified by: 4 people in group chat, none have the app -> add Tryps number -> all 4 appear as trip members on the backend, linked by phone number.
- [ ] **SC-3.** If someone downloads the app later, all the data from the group chat is already there — expenses, activities, flights, everything. Verified by: Jake texts "$80 for Uber" and "let's do Nobu Friday" in group chat -> downloads app -> opens trip -> sees the expense and the activity.
- [ ] **SC-4.** A person added to the iMessage group joins the trip automatically. Verified by: trip has 4 members -> add Sarah to iMessage group -> Sarah appears as trip member within 10 seconds.
- [ ] **SC-5.** A person who leaves the iMessage group leaves the trip. Verified by: Sarah leaves group chat -> Sarah removed from trip members within 10 seconds.
- [ ] **SC-6.** Early in onboarding, the agent prompts each person to take the trip vibe quiz. If Linq supports native polling, the vibe quiz runs directly in iMessage. If not, the agent sends a deep link into the app or asks the vibe questions as individual text prompts (e.g., "Beach or mountains?" -> user replies "beach"). Verified by: new group with 4 members -> within first 5 minutes, each member receives a vibe quiz prompt -> completing it (in-chat or via app) saves their vibe profile to the trip.
- [ ] **SC-7.** A user texts an expense and the agent logs it. Verified by: Jake texts "I paid $120 for dinner, split 4 ways" -> agent responds "Confirmed, added to expenses" (one line) -> expense shows in app with $30 per person.
- [ ] **SC-8.** The agent asks clarifying questions when the expense is ambiguous. Verified by: Jake texts "I paid for the Uber" (no amount) -> agent asks "How much was it?" -> Jake replies "$45" -> expense logged.
- [ ] **SC-9.** A user texts a custom split and the agent handles it. Verified by: Jake texts "I paid $90 for dinner, split between me Sarah and Tom" -> agent confirms -> expense split 3 ways at $30 each, other group members excluded.
- [ ] **SC-10.** A user sends a receipt photo and the agent extracts the expense. Verified by: Jake sends a photo of a $67.50 restaurant receipt -> agent parses total -> confirms "Got it — $67.50. Who's splitting?" -> Jake replies "everyone" -> expense logged split equally.
- [ ] **SC-11.** A user starts a vote in the group chat. The agent creates a poll and sends numbered options. If Linq supports native polling, the poll uses iMessage's native format. If not, the agent sends a numbered text list and members reply with a number. Verified by: Jake texts "let's vote: Nobu, Zuma, or Komodo" -> agent creates poll -> sends options -> members vote -> votes recorded in app.
- [ ] **SC-12.** A user changes their vote. Verified by: Sarah voted "2" for Zuma -> texts "switch me to Nobu" -> vote updated -> agent confirms.
- [ ] **SC-13.** The agent announces results when a poll closes. Verified by: poll has 4 votes, 48hr window expires -> agent texts group "Zuma won with 3 votes. Added to the itinerary."
- [ ] **SC-14.** Voting works without native polling support. The numbered-reply pattern ("Reply 1, 2, or 3") is the baseline. Architecture is built so native Linq polling plugs in when available — same data, better UX. Verified by: poll created -> agent sends numbered text options -> 3 of 4 members reply with numbers -> votes recorded correctly -> same poll visible in app.
- [ ] **SC-15.** A user adds an activity via text. Verified by: Jake texts "add dinner at Nobu on Friday" -> agent confirms "Added — Nobu, Friday" -> activity appears in app itinerary.
- [ ] **SC-16.** A user asks about the plan and gets a concise answer. Verified by: Sarah texts "what's the plan for Saturday?" -> agent responds with Saturday's itinerary, under 6 lines.
- [ ] **SC-17.** A user asks about balances. Verified by: Tom texts "what do I owe?" -> agent responds with Tom's balance per person (e.g., "You owe Jake $30, Sarah $15").
- [ ] **SC-18.** A user asks who's going. Verified by: Sarah texts "who's going?" -> agent responds with the participant list.
- [ ] **SC-19.** A user pastes a link and the agent captures it. Verified by: Jake pastes an Airbnb listing URL -> agent extracts name, dates, price -> adds to trip as accommodation option -> confirms in chat.
- [ ] **SC-20.** The agent sends a reminder when arriving at the destination. Verified by: trip start date arrives -> agent texts group "Hey, here's the Airbnb address. It's 45 minutes from the airport." with the actual address.
- [ ] **SC-21.** The agent reminds the group about open votes. Verified by: poll has been open 24hrs with 2 of 5 people not voted -> agent nudges group "2 people still haven't voted on dinner spot — poll closes tomorrow."
- [ ] **SC-22.** The agent sends notifications about trip updates to the group. Verified by: a new expense is added in-app -> agent texts group "{name} added $80 for Uber."
- [ ] **SC-23.** Every agent message is 6 lines or fewer. Verified by: trigger 10 different agent responses (expense confirm, vote prompt, itinerary query, etc.) -> none exceeds 6 lines.
- [ ] **SC-24.** The agent sends at most 3 messages in a row before waiting for user input. Verified by: trigger a complex action that could generate multiple responses -> agent sends no more than 3 messages -> waits.
- [ ] **SC-25.** The agent uses 1:1 DMs for private info instead of the group. Verified by: Tom texts "what do I owe?" -> balance response goes to Tom privately, not the group chat.
- [ ] **SC-26.** A group chat with only 2 people (plus the Tryps number). Verified by: add Tryps number to a 2-person chat -> agent handles it via 1:1 messages to each person (Linq requires 3+ for groups).
- [ ] **SC-27.** The agent can't parse what someone said. Verified by: Jake texts "asdfjkl random nonsense" -> agent does NOT respond. It stays quiet on messages it doesn't understand.
- [ ] **SC-28.** A user texts an expense with no trip context (first message ever). Verified by: brand new group, first message is "$50 for gas" -> agent creates the trip first, then logs the expense, confirms both.
- [ ] **SC-29.** The agent is asked something outside its scope. Verified by: Sarah texts "book us a flight to Miami" -> agent responds "I can't book flights yet — coming soon. For now, paste your flight confirmation and I'll track it."
- [ ] **SC-30.** The welcome message names who added the agent and gives everyone a way to remove it. Any group member — not just the person who added it — can text "remove" to kick the agent. Verified by: Jake adds Tryps number -> welcome message includes "Jake added me" and "text REMOVE to kick me out" -> Tom texts "remove" -> agent sends goodbye message and stops responding to this group.
- [ ] **SC-31.** When two expenses with similar descriptions and amounts are logged within 5 minutes, the agent flags the potential duplicate: "Heads up — Jake and Tom both logged ~$120 for dinner. Is this one expense or two?" Verified by: Jake texts "$120 for dinner" -> Tom texts "$120 for dinner" within 2 minutes -> agent asks group to confirm duplicate.
- [ ] **SC-32.** When multiple polls are active, a bare number reply like "2" triggers disambiguation: "Which poll — dinner spot or hotel?" The agent uses labeled prefixes (e.g., "DINNER: Reply D1, D2, D3 / HOTEL: Reply H1, H2, H3") when polls overlap. Verified by: create two polls -> user replies "2" -> agent asks which poll -> user clarifies -> vote recorded correctly.
- [ ] **SC-33.** If the trip owner leaves the iMessage group, trip ownership transfers to another member automatically. Verified by: trip owner Jake leaves group chat -> ownership transfers to the next member (e.g., Sarah) -> Sarah can now manage the trip -> agent confirms ownership transfer to the group.
- [ ] **SC-34.** A user texts the Tryps number in a 1:1 DM (no group). The agent responds as a personal assistant — shows their active trips, lets them query balances across all trips, and offers to create a new trip ("Add me to a group chat with your friends to get started"). Verified by: Jake texts "hey" to Tryps number directly -> agent shows Jake's 3 active trips -> Jake texts "what do I owe across everything?" -> agent responds with balances per trip.
- [ ] **SC-35.** A user can undo or correct the last agent action via text. "Actually $35 not $45" updates the amount. "Delete last expense" removes it. "Change Nobu to Saturday" edits the activity. Verified by: Jake texts "$45 Uber" -> agent confirms -> Jake texts "actually $35" -> agent updates expense to $35 -> confirms new amount -> app shows $35.
- [ ] **SC-36.** The agent does NOT respond to every message in the group. Normal conversation between friends gets no response. Verified by: send 5 casual messages ("lol", "see you there", "can't wait", a meme, "haha") -> agent stays silent on all 5.
- [ ] **SC-37.** The agent does NOT send walls of text. No message exceeds 6 lines. No more than 3 messages in a row. Verified by: run through all agent response types -> check line counts and message counts.
- [ ] **SC-38.** The agent does NOT announce every background action. If it's silently logging or processing, it stays quiet unless confirmation is needed. Verified by: agent processes 5 link scrapes in a row -> only confirms the ones that resulted in added content, not the processing steps.
- [ ] **SC-39.** Non-trip-members do NOT see trip data. A phone number not in the iMessage group cannot query trip info. Verified by: outsider texts the Tryps number asking "what's the plan for Miami?" -> agent does not reveal trip details.
- [ ] **SC-40.** The iMessage group and the trip membership are always in sync. A user cannot be in the trip but not in the group, or in the group but not in the trip. They move together. Verified by: remove a participant in-app -> they are also removed from the iMessage group (or if Linq can't remove, agent stops tracking them and DMs explanation) -> add someone to iMessage group -> they appear in the trip.
- [ ] Typecheck passes

### Stripe Payments (p2-stripe-payments) — unassigned — 0/12

- [ ] **P2.S2.C01** — A user can confirm a travel booking (flight, hotel, or Airbnb) and their saved card is charged immediately. Verified by: Given a user with a card on file viewing a flight option → user confirms "book it" → card is charged and a booking reference number is returned within 30 seconds.
- [ ] **P2.S2.C02** — Booking confirmation appears in the same channel the user booked from. Verified by: Given a user who confirms a booking via iMessage → a confirmation message with booking details appears in that iMessage thread. Given a user who confirms in-app → a confirmation screen displays in the app.
- [ ] **P2.S2.C03** — One user can book travel for multiple members of the same trip. Verified by: Given a trip with 4 members and all members have travel profiles set up → one user selects "book for everyone" on a flight → 4 separate bookings are created and the booking user's card is charged for the total amount.
- [ ] **P2.S2.C04** — The booking agent applies stored travel preferences (e.g., aisle seat) when suggesting options. Verified by: Given a user whose travel profile specifies "aisle seat" → agent presents flight options → suggested flights highlight aisle seat availability and pre-select it.
- [ ] **P2.S2.C05** — A user can save a payment method (credit/debit card) to their account for future bookings. Verified by: Given a user on the payment settings screen → user enters card details → card is saved and appears as their default payment method on the next booking attempt.
- [ ] **P2.S2.C06** — A user with no saved payment method is prompted to add one before completing a booking. Verified by: Given a user with no card on file who confirms a booking → a payment method entry screen appears before the charge is attempted → after adding a card, the booking completes.
- [ ] **P2.S2.C07** — When a card is declined, the user sees a plain-language reason. Verified by: Given a user whose card is declined for insufficient funds → the message displays "Your card was declined — insufficient funds. Try a different card." (not a Stripe error code).
- [ ] **P2.S2.C08** — When a booking fails on the supplier side (airline, hotel), the user sees what went wrong and is not charged. Verified by: Given a flight that becomes unavailable after the user confirms → the user sees "This flight is no longer available — you were not charged" → no charge appears on the card.
- [ ] **P2.S2.C09** — When a user books for a group and one member's profile is incomplete (missing passport or preferences), the booking flow surfaces which member needs attention. Verified by: Given a group booking where 1 of 4 members has no passport info → the flow pauses and displays "[Member name] is missing passport information" before charging.
- [ ] **P2.S2.C10** — A payment must never be charged without the user explicitly confirming the booking. No auto-charge on browse or selection.
- [ ] **P2.S2.C11** — Completing a booking must not create, modify, or remove any entries in the trip's expense log. Stripe bookings and expense logging are separate features.
- [ ] **P2.S2.C12** — Typecheck passes.

### Logistics Agent (p3-logistics-agent) — unassigned — 0/26

- [ ] Tapping a section button (e.g. "Find Flights" on the Flights section of the trip card) creates an agent task tied to that trip and category. Verified by: Trip with 3 members -> Alice taps "Find Flights" on trip card -> agent task appears in chat thread within 3 seconds with a "Searching..." status.
- [ ] Empty state prompts trigger the agent. Verified by: Trip with no dinner planned -> Activities section shows "No dinner yet — want me to find one?" -> Alice taps it -> agent task starts for the dinner category.
- [ ] Free-text chat triggers the agent. Verified by: Alice types "find a hotel in Rome under $200/night for March 18-22" in trip chat -> agent parses intent and starts a hotel search task.
- [ ] Agent returns ranked options in both the chat thread and the activity feed. Verified by: Agent completes a flight search -> 3-5 options appear in chat thread ranked by cost + time -> same options appear in the activity feed on the trip card.
- [ ] Each option shows cost, time/duration, and key details at a glance (like Citymapper). Verified by: Flight options show airline, departure/arrival times, duration, price per person, and total group price. Restaurant options show cuisine, rating, price range, and available time slots.
- [ ] Group votes on options. Majority wins within a 48-hour voting window. Verified by: 5-member trip -> agent presents 3 dinner options -> Alice, Bob, Carol vote for Option B -> Option B is marked "Selected" and moves to booking confirmation.
- [ ] Non-voters get a push notification reminder at the 24-hour mark. Verified by: 48-hour vote starts at 2pm Monday -> at 2pm Tuesday, Dave and Eve (who haven't voted) each receive a push: "Vote on dinner — 24 hours left."
- [ ] If no majority after 48 hours, the proposer's preference wins. Verified by: 4-member trip -> 2 vote Option A, 2 vote Option B, tie after 48h -> Alice (who triggered the search) picks Option A -> Option A moves to booking.
- [ ] Booking confirmation updates the trip card section and sends a push to all members. Verified by: Hotel booking confirmed -> Stay section on trip card shows hotel name, dates, and confirmation number -> all 4 members get push: "Hotel booked: Grand Roma, March 18-22."
- [ ] Duplicate requests get deduplicated. Verified by: Alice triggers "Find dinner in Rome for March 20" -> 10 minutes later Bob triggers the same request -> Bob sees "Alice already started this search — results coming soon" -> only one agent task runs.
- [ ] Agent can contact external parties to gather info. Verified by: Alice asks "Can you email the event organizer for ticket availability?" -> agent sends an outbound email -> response from organizer appears in the chat thread.
- [ ] First agent task on a trip shows an onboarding message. Verified by: New trip with no prior agent tasks -> Alice taps "Find Flights" -> chat thread shows a one-time intro: "I'm your trip concierge. I'll search, you decide."
- [ ] Selected option sells out before booking. Agent auto-recovers with alternatives ranked by cost + time. Verified by: Group votes for Flight Option A -> agent attempts booking -> flight sold out -> agent returns 3 alternative flights ranked by cost and departure time within 30 seconds -> group sees "Option A sold out — here are alternatives."
- [ ] Alternatives also fail. Agent escalates to the group. Verified by: Original option sold out -> 3 alternatives also unavailable -> agent posts: "All similar options are gone. Want me to search again with different dates or a bigger budget?"
- [ ] Price changes between recommendation and booking. Agent flags the delta. Verified by: Option B quoted at $450 -> at booking time price is $490 -> agent shows: "Price changed from $450 to $490 (+$40). Confirm or pick another?"
- [ ] API is down. Agent notifies and retries. Verified by: Duffel API returns 500 -> agent shows "Flight search temporarily unavailable. Retrying..." -> retries 3 times over 5 minutes -> if still down: "Flight search is down. I'll try again in 30 minutes."
- [ ] Solo trip (1 member). No voting phase — skip straight to confirmation. Verified by: Trip with 1 member -> Alice triggers "Find Flights" -> options appear -> Alice taps "Book This" -> booking proceeds immediately, no vote timer.
- [ ] Free-text input the agent can't parse. Verified by: Alice types "do the thing for the stuff" -> agent responds: "I didn't catch that. Try something like 'Find flights from NYC to Rome on March 18.'"
- [ ] Agent NEVER books anything without explicit human confirmation (unless the user has enabled auto-book in trip settings).
- [ ] Agent NEVER charges real user money in v1. All costs are Tryps-subsidized and logged internally.
- [ ] Group bookings (2+ members) NEVER proceed without group approval, even if auto-book is enabled for the proposer. Auto-book only applies to solo actions.
- [ ] Agent NEVER sends push notifications for intermediate steps (searching, processing, comparing). Push only fires for: options ready, 24h vote reminder, booking confirmed, booking failed.
- [ ] Trip settings include an "Auto-book" toggle, off by default. Verified by: Trip settings screen -> "Agent Booking" section -> toggle labeled "Let agent book without asking" -> default is off.
- [ ] With auto-book on, solo agent tasks skip the vote and book the top option immediately. Verified by: Alice enables auto-book -> triggers "Find dinner for 1" -> agent finds options -> books the top-ranked option -> Alice gets push: "Dinner booked: Trattoria Luca, 8pm."
- [ ] Auto-book does NOT apply to group tasks. Verified by: Alice has auto-book on -> triggers "Find dinner for 4" on a group trip -> options still go to group vote with 48-hour window.
- [ ] Typecheck passes

### Launch Video (p4-launch-video) — jake — 0/15

- [ ] **P4.LV.C01** — A written treatment document exists that any filmmaker or creative director can pick up and understand the full video concept cold. Verified by: Hand the treatment to someone who has never heard of Tryps → they describe the video's story, shot sequence, and tone back to you within 5 minutes of reading.
- [ ] **P4.LV.C02** — The treatment includes a shot-by-shot breakdown where every scene has a description, approximate duration, and camera/framing note. Verified by: Open the treatment → each scene has all three elements → scene durations add up to the hero cut target length (90–150 seconds).
- [ ] **P4.LV.C03** — A production game plan exists covering crew roles, shooting schedule, location, equipment, and post-production timeline. Verified by: Open the game plan → it names specific roles (director/DP, editor, on-screen talent), a shoot date window, location, gear needs, and post-production milestones → all dates land before the April 2026 launch.
- [ ] **P4.LV.C04** — The hero video cut runs between 90 and 150 seconds. Verified by: Play the final hero video → check runtime → it falls between 1:30 and 2:30.
- [ ] **P4.LV.C05** — At least two shorter social cuts exist — one under 30 seconds and one under 60 seconds — each telling a coherent micro-story. Verified by: Play each social cut → one is ≤30s, one is ≤60s → each has a beginning, middle, and end (not a choppy trim of the hero).
- [ ] **P4.LV.C06** — The video features real people in a real travel setting — no actors, no stock footage, no studio sets. Verified by: Watch the video → the people on screen are real friends/acquaintances → the setting is a real destination.
- [ ] **P4.LV.C07** — The Tryps mobile app appears on screen multiple times throughout the video but never becomes a dedicated demo sequence. Verified by: Watch the video → app appears naturally in the story (checking the itinerary while walking, texting the group, splitting a bill at dinner) → no single app moment exceeds 5 seconds of pure screen recording.
- [ ] **P4.LV.C08** — Total production cost (crew, equipment, travel, editing, music licensing) stays at or under $7,000. Verified by: Sum all invoices and expenses → total ≤ $7,000.
- [ ] **P4.LV.C09** — The treatment opens with a 3–5 sentence summary that captures concept, tone, and format — so a busy creative friend can decide "I'm in" or "not for me" without reading the full shot list. Verified by: Open the treatment → the first section is a standalone overview → a reader understands what the video is about from that paragraph alone.
- [ ] **P4.LV.C10** — The video communicates its core message on mute (how most people first encounter videos on social feeds). Verified by: Watch the hero video with sound off → you can tell it's about a group of friends planning and taking a trip together using an app → the story arc is followable without audio.
- [ ] **P4.LV.C11** — Video exports exist in platform-native aspect ratios: landscape (16:9) for X and YouTube, vertical (9:16) for Instagram Reels and TikTok. Verified by: Check the export folder → hero cut exists in 16:9 → at least one social cut exists in 9:16.
- [ ] **P4.LV.C12** — No stock footage, B-roll libraries, or AI-generated imagery anywhere in the video.
- [ ] **P4.LV.C13** — No voiceover narration listing features. No "download Tryps today" call-to-action interrupting the story. The end card can include a URL or QR code, but the story itself stays clean.
- [ ] **P4.LV.C14** — No solo-traveler or luxury-resort imagery. Every scene with people includes 2+ friends. Settings are casual adventure (hiking, exploring streets, beach hangs) — not hotel lobbies or rooftop bars.
- [ ] **P4.LV.C15** — The video's visual style aligns with the Tryps brand: clean white aesthetic with red accent pops, modern and minimal, bright and airy, groups of friends in casual outfits, candid energy. Verified by: Watch the video → the overall tone is clean, bright, and modern → any on-screen app moments show the Tryps red brand color → no moody/dark tones, no posed editorial shots.

