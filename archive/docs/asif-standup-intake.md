# Asif Standup Intake — P2/P3 Ground Truth

**Purpose:** Get the real state of the world from Asif before aligning Jake's vision to scopes. These are standup-style questions — quick, direct, no fluff.

**When to use:** During the next sync with Asif (Slack or call). Jake or Claude asks, Asif answers.

---

## Current State

1. **What are you actively working on TODAY?**

2. **Linq / iMessage agent — it's `for testing` in ClickUp. What does that mean in reality?**
   - Is it deployed somewhere?
   - Can someone actually add the number to a group chat?
   - What works? What doesn't?
   - What's the Linq API status — are we on their sandbox, production, waitlist?

3. **What P2 specs have you read? Any questions or concerns?**

4. **Of the 3 P2 scopes (linq, stripe-payments, connectors), which order makes sense to you?**

## Blockers & Dependencies

5. **Are you blocked on anything from Nadeem?**
   - Specifically: p1-travel-dna (connectors depends on it) and p1-claude-connector (linq may depend on it)

6. **Is the p1-claude-connector actually a dependency for linq?**
   - Jake thinks no — they're architecturally separate (Claude MCP vs Linq iMessage API). Confirm?

7. **What's the status of your parked items? Are any of these still alive or all dead?**
   - Activity Sharing Opt-Out Toggle
   - Post-Trip Activity Ranking (Beli-Inspired)
   - Connections System (Replace Friend Graph)
   - Discover — Friend-Based Activity Recs
   - Fixed Screen Design for Trip Members
   - Bug: Temporary password not rotated

## Capacity & Timeline

8. **How many hours per day are you spending on Tryps right now?**

9. **What's your honest read on hitting April 2 for P2?**
   - All 3 scopes done?
   - Some done, some started?
   - Need to cut scope?

10. **Is there anything you need from Jake to start building faster?**

## Architecture & Technical State

11. **What's the current Stripe integration status?**
    - Do we have a Stripe account? Sandbox? Test keys?
    - Any existing payment code in the codebase?

12. **What's the current state of the travel profile / connector data model?**
    - Is there already a table for loyalty numbers, passport info, etc.?
    - Or does this need to be built from scratch?

13. **For the agent layer (P3) — any existing patterns in the codebase?**
    - Edge functions? Background jobs? Realtime subscriptions?
    - What's the current Supabase architecture that P3 would build on?

14. **Any technical concerns about the P2/P3 specs that you've seen?**
    - Anything that seems unrealistic, over-engineered, or missing?

---

## After This

Asif's answers get merged with Jake's strategy intake to produce the actual scope definitions. The goal: when Asif sits down to build, the scope is clean, the boundaries are clear, and there are no open questions.
