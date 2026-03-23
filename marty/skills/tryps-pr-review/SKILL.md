---
name: tryps-pr-review
description: Full convention and quality review for PRs on cojakestein-sketch/tripful
user-invocable: true
---

When reviewing a PR:

### Convention Checks (Auto-fail)
- [ ] Uses @/ path aliases (no relative imports like ../../)
- [ ] No `any` types (use proper types or `unknown`)
- [ ] No console.log in components (utils OK for debugging)
- [ ] Uses StyleSheet.create() (no inline styles)
- [ ] Import order: React/RN → Expo → @/contexts → @/hooks → @/components → @/utils → @/types
- [ ] No unused imports or dead code

### Database Checks (if applicable)
- [ ] RLS policies on new tables
- [ ] types/index.ts updated on schema changes
- [ ] SECURITY INVOKER on RPCs (not DEFINER)
- [ ] COALESCE json_agg with '[]'::json

### Safety Checks
- [ ] No .env files or API keys committed
- [ ] getSession() guard before getUser()
- [ ] parseDateSafe() for date strings (not new Date() on YYYY-MM-DD)
- [ ] router.canGoBack() fallback on navigation
- [ ] Deep link targets stored before auth redirects
- [ ] Phone numbers normalized (strip + prefix)

### Quality Checks
- [ ] Error severity correct (error vs warn vs log)
- [ ] Tests added or updated for the change
- [ ] TypeScript compiles clean (npm run typecheck)
- [ ] No unnecessary scope expansion

### Response Format
Post a review comment:
- **Pass:** "LGTM ✓ — [brief note on what looks good]"
- **Issues found:** List each issue with file:line, what's wrong, and how to fix
- **Questions:** Flag anything unclear as a question, not a demand
