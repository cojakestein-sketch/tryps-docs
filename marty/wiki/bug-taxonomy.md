# Bug Taxonomy

> Categorized bug patterns by scope, root cause, and frequency.
> Updated by Marty after QA sessions. Compiled weekly.
> Last compiled: 2026-04-05 (initial)

## Summary

- **Total tracked:** 78
- **Fixed:** 68
- **Remaining:** 10

## By Scope

| Scope | Bugs Found | Fixed | Remaining |
|-------|-----------|-------|-----------|
| iMessage Agent | 13 (Apr 3 batch) | In progress | TBD |
| Core Trip Experience | — | — | In testing |
| Other | — | — | — |

## Common Root Causes

- **Agent response formatting** — Agent replies not matching expected format in group chats
- **Voting logic** — Edge cases in poll creation and vote counting
- **Trip creation** — Issues surfaced during iMessage-initiated trip flow
- **Real-time sync** — Data not updating without manual refresh (activities, expenses, people, itinerary)

## QA Process

- QA team: Aman Khan, Sarfaraz Ahmed, Zain Waheed
- Bugs filed in batches after testing sessions
- Asif handles iMessage bugs, Nadeem handles app bugs
