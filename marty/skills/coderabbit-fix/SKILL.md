---
name: coderabbit-fix
description: "Parse CodeRabbit PR review comments and fix them iteratively"
user-invocable: true
---

# CodeRabbit Fix — Automated PR Review Resolution

Parse CodeRabbit automated review comments on a GitHub PR and fix them.

## Input

- `pr_number` — The PR number on `cojakestein-sketch/tripful`
- `repo` — defaults to `cojakestein-sketch/tripful`
- `max_iterations` — max fix cycles (default: 3)

## Process

### Step 1 — Fetch CodeRabbit Comments

```bash
gh pr view <pr_number> --repo <repo> --json reviews,comments
gh api repos/<repo>/pulls/<pr_number>/comments
```

Filter for CodeRabbit comments (author: `coderabbitai[bot]` or contains CodeRabbit markers).

### Step 2 — Categorize Issues

Sort comments by severity:
- **Critical:** Security issues, broken logic, data loss risk, RLS policy gaps
- **Major:** Missing error handling, type safety issues, performance problems
- **Minor:** Style, naming, documentation suggestions
- **Nitpick:** Formatting, optional improvements

### Step 3 — Fix Issues

For each issue (critical first, then major, then minor — skip nitpicks):

1. Read the file and surrounding context
2. Understand what CodeRabbit is asking for
3. Implement the fix
4. Verify the fix doesn't break related code

Use the coding agent pattern:
```bash
bash pty:true workdir:~/project command:"<agent> 'Fix CodeRabbit issue: [description]. File: [path], Line: [line]'"
```

Or if simple enough, edit files directly.

### Step 4 — Commit & Push

```bash
git add -A
git commit -m "fix: address CodeRabbit review feedback

- [Summary of fixes]

Co-Authored-By: Marty <marty@jointryps.com>"
git push
```

### Step 5 — Verify Re-Review

Wait for CodeRabbit to re-review (usually 1-3 minutes after push).

```bash
# Poll for new review
gh pr view <pr_number> --repo <repo> --json reviews --jq '.reviews[-1]'
```

If new issues found and iteration < max_iterations, go back to Step 1.

### Step 6 — Report

Post a summary comment on the PR:

```bash
gh pr comment <pr_number> --repo <repo> --body "**CodeRabbit fixes applied (iteration N/max)**

**Fixed:**
- [Issue] — [fix description]
- ...

**Skipped (nitpicks):**
- [Issue] — [reason]

**Status:** [All clear / N issues remaining]"
```

## Escalation

If after `max_iterations` cycles CodeRabbit still has critical/major issues:
1. Post summary of remaining issues as PR comment
2. DM Jake in Slack: "PR #N still has N CodeRabbit issues after 3 fix cycles. Need help: [link]"
3. Do NOT force-merge or dismiss reviews

## Rules

- Never dismiss CodeRabbit reviews
- Never skip critical or major issues
- Always run `npm run typecheck` after fixes
- Respect existing code patterns — don't refactor unrelated code
- Keep fix commits separate from feature commits for clean history
