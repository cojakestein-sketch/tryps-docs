# P2 Linq iMessage — Agent Ready

> **Status:** Ready for developer review
> **PR:** https://github.com/cojakestein-sketch/tryps/pull/286
> **Branch:** feat/linq-imessage (pushed to origin)
> **Date:** 2026-03-17

## Summary

Adds a Linq-powered iMessage agent for collaborative trip planning in group chats. The agent handles expenses, polls, itinerary management, link capture, balance queries, and participant sync -- all via natural language text messages. Users without the Tryps app are created as "phantom" participants and seamlessly linked when they sign up.

**Key stats:** 1 commit (`ba4faed0`), 15 shared modules, 4 edge functions, 1 DB migration (6 new tables), 40 success criteria evaluated -- 28 pass, 7 partial, 0 fail. Typecheck passes clean.

## Artifacts

- Plan: scopes/p2/linq-imessage/plan.md
- Work log: scopes/p2/linq-imessage/work-log.md
- Review: scopes/p2/linq-imessage/review.md
- Compound log: scopes/p2/linq-imessage/compound-log.md

## PR

https://github.com/cojakestein-sketch/tryps/pull/286

Reviewers: @asifraza1013, @Nadimkhan120

## Next Steps

### Human attention required (7 partial items)

1. **SC-6 (Vibe quiz):** Wire `generateVibeQuizPrompt()` to trigger after welcome message during onboarding
2. **SC-10 (Receipt photo):** Add `message.mediaUrl` detection in `intent-router.ts` before NLP classification; call `parse-image` and set `receipt_split` pending action
3. **SC-20 (Arrival reminder):** Wire `checkArrivalReminders()` into a cron invocation (add to `close-polls` or create separate cron)
4. **SC-21 (Poll reminder):** Wire `checkPollReminders()` into same cron invocation as SC-20
5. **SC-26 (2-person chat):** Add special-case logic for Linq's 3+ group requirement; route 2-person chats via 1:1 messages
6. **SC-34 (Personal assistant):** Implement cross-trip balance query in 1:1 DM mode
7. **SC-40 (Bidirectional sync):** Add DB trigger or app-side hook to notify Linq group when a participant is removed in-app

### Additional issues

- Verify `outbound_sms_queue` table exists from a prior migration (referenced by `notify_linq_expense_added` trigger)
- Create missing RPCs: `linq_add_conversation_to_pending` and `increment_linq_message_count`
- Refactor webhook handler to use `transport.parseInbound()` instead of manual destructuring
- Add unit tests for intent processor regex layer and duplicate detector (pure functions, high ROI)

### Integration testing

- Requires live Linq API credentials (HMAC keys, webhook registration)
- End-to-end testing: send messages to a Linq-connected group, verify webhook -> intent -> action -> response pipeline
- Test phantom participant linking by signing up with a phone number that was in a Linq group
