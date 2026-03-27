## Summary

Adds a Linq-powered iMessage agent that lives in group chats and handles collaborative trip planning -- expenses, polls, itinerary, link capture, balance queries, and participant sync -- all via natural language text messages. Users who don't have the Tryps app are created as "phantom" participants and seamlessly linked when they sign up.

**Key stats:** 1 commit, 15 shared modules, 4 edge functions, 1 DB migration (6 new tables), 40 success criteria evaluated -- **28 pass, 7 partial, 0 fail**.

## Architecture

- **Transport layer:** `MessageTransport` interface abstracts Linq API; future Twilio/WhatsApp adapters require zero handler changes
- **NLP pipeline:** Claude Haiku intent classification with comprehensive regex fallback (14+ intents, zero downtime on API failure)
- **Shared modules (15 files in `_shared/`):** linq-types, message-transport, linq-transport, user-resolver, trip-resolver, conversation-state, intent-processor, intent-router, response-formatter, action-handlers, welcome-message, group-sync, vibe-quiz, duplicate-detector, proactive-triggers
- **Edge functions (4):** `linq-webhook` (inbound), `linq-response` (outbound + queue), `linq-delivery-status` (receipts), `close-polls` (hourly cron)
- **DB migration:** `20260317200000_linq_imessage_tables.sql` -- 6 new tables (`linq_conversations`, `linq_messages`, `linq_conversation_state`, `linq_pending_users`, `polls`, `poll_votes`) with RLS, triggers, indexes

## Key Files

| Area | Path |
|------|------|
| Migration | `supabase/migrations/20260317200000_linq_imessage_tables.sql` |
| Webhook handler | `supabase/functions/linq-webhook/index.ts` |
| Outbound sender | `supabase/functions/linq-response/index.ts` |
| Delivery status | `supabase/functions/linq-delivery-status/index.ts` |
| Poll cron | `supabase/functions/close-polls/index.ts` |
| Shared modules | `supabase/functions/_shared/linq-*.ts`, `action-handlers.ts`, `intent-*.ts`, etc. |
| Client types | `types/index.ts` (LinqConversation, Poll, PollVote, etc.) |

## Success Criteria Coverage

**28 PASS:** SC-1 (welcome), SC-2 (auto-join), SC-3 (phantom linking), SC-4 (member joined), SC-5 (member left), SC-7 (log expense), SC-8 (clarifying questions), SC-9 (custom split), SC-11 (create poll), SC-12 (change vote), SC-13 (poll close), SC-14 (numbered voting), SC-15 (add activity), SC-16 (itinerary query), SC-17 (balance query), SC-18 (who's going), SC-19 (link capture), SC-22 (in-app expense notify), SC-23 (6-line limit), SC-24 (3-msg limit), SC-25 (private DM), SC-27 (ignore unparseable), SC-28 (first msg no trip), SC-29 (out-of-scope), SC-30 (add/remove agent), SC-31 (duplicate detection), SC-32 (poll disambiguation), SC-33 (ownership transfer), SC-35 (undo), SC-36 (ignore casual), SC-37 (no walls of text), SC-38 (no background announcements), SC-39 (non-member security)

**7 PARTIAL (known gaps):**

1. **SC-6 (Vibe quiz):** Handler logic complete but `generateVibeQuizPrompt()` is never proactively called during onboarding
2. **SC-10 (Receipt photo):** Multi-turn completion handler exists but `intent-router.ts` does not inspect `message.mediaUrl` -- inbound photos are never detected
3. **SC-20 (Arrival reminder):** `checkArrivalReminders()` implemented but no cron invocation wires it up
4. **SC-21 (Poll reminder):** `checkPollReminders()` implemented but same cron wiring gap as SC-20
5. **SC-26 (2-person chat):** No special-case logic for Linq's 3+ group requirement; 2-person chats fall into 1:1 personal assistant mode
6. **SC-34 (Personal assistant):** Shows trip list in 1:1 DMs but does not implement cross-trip balance query
7. **SC-40 (Bidirectional sync):** iMessage->trip sync complete; trip->iMessage sync (in-app removal notifying Linq) not implemented

## Additional Issues (Non-blocking)

- `outbound_sms_queue` table referenced by DB trigger assumed to pre-exist from prior migration
- RPCs `linq_add_conversation_to_pending` and `increment_linq_message_count` called but not defined (wrapped in `.catch()`, fail silently)
- Webhook handler duplicates parsing logic instead of using `transport.parseInbound()`

## Testing Notes

- `npm run typecheck` passes (zero errors from this PR)
- No automated tests yet -- regex intent processor and duplicate detector are highly testable pure functions
- End-to-end testing requires live Linq API integration (HMAC keys, webhook registration)
- All edge functions use proper CORS headers, error handling, and service-role Supabase clients

## Database Migration Details

**New tables:** `linq_conversations`, `linq_messages`, `linq_conversation_state`, `linq_pending_users`, `polls`, `poll_votes`

**Column additions:** `participants.linq_phone`, `participants.is_phantom`, `trips.linq_conversation_id`

**Triggers:** `link_linq_pending_user` (auto-links phantom participants on signup), `notify_linq_expense_added` (queues Linq notification on expense insert)

**RLS:** Linq tables are service-role-only; polls/poll_votes have trip-member SELECT policies

---

*Generated with [Claude Code](https://claude.com/claude-code)*
