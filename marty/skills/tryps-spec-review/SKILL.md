---
name: tryps-spec-review
description: Review specs for clear acceptance criteria, missing edge cases, and invite flow impact
user-invocable: true
---

When reviewing a spec (from ClickUp task or shared document):

### Completeness Checks
- [ ] Clear "Why" — Problem statement or user need
- [ ] Acceptance criteria — Testable, specific conditions for "done"
- [ ] Edge cases listed — What happens when things go wrong?
- [ ] Error states — How does the UI handle failures?
- [ ] Empty states — What does the user see with no data?
- [ ] Loading states — What happens during network requests?

### Collaboration Impact
- [ ] **Invite flow impact:** Does this change affect invite → join → collaborate? If yes, flag immediately.
- [ ] **Multi-user scenario:** How does this work when 5+ people are using it simultaneously?
- [ ] **Real-time sync:** Does this need realtime updates? Is useRealtimeTrip sufficient?
- [ ] **Permissions:** Owner vs collaborative mode implications?

### Technical Feasibility
- [ ] Can this be built with current stack (Expo + Supabase)?
- [ ] Database changes needed? (New tables, migrations, RLS)
- [ ] New Edge Functions needed?
- [ ] Third-party API dependencies?
- [ ] Estimated complexity (S/M/L/XL)

### Response Format
```
**Spec Review — [spec name]**

**Verdict:** ✅ Ready / ⚠️ Needs work / ❌ Missing critical info

**Strong points:**
- ...

**Missing or unclear:**
- [Issue] — [Suggestion]
- ...

**Invite flow impact:** [None / Low / High — explain]

**Estimated complexity:** [S/M/L/XL]
```
