# Slack Standup Auto-Sync

> Marty prompt. Post standup questions to Slack, watch for replies, update the standup doc automatically.
> Run this each morning after the standup doc exists at `~/tryps-docs/docs/standups/YYYY-MM-DD-standup.md`
> Slack `/mission` intake is a separate flow. Route that to the `tryps-mission-sync` skill, not this prompt.

## TODAY ONLY (March 26)

The #brand questions (Jake + Sean) were already posted by @tryps. Do NOT re-post to #brand.
You still need to:
1. Post dev questions to #martydev
2. Start watching ALL threads (both #brand and #martydev) for replies
3. Update the standup doc with answers

The #brand message timestamps you need to watch:
- Jake's brand questions: channel C0AP2B9J5PU, ts 1774537026.227939
- Sean's questions: channel C0AP2B9J5PU, ts 1774537069.042919

Skip to Step 1b (post to #martydev only), then go to Step 2.

---

## Full Flow (Normal Days)

### Step 1a: Post to #brand (C0AP2B9J5PU)

Read today's standup doc at `~/tryps-docs/docs/standups/YYYY-MM-DD-standup.md`. Find the sections for:
- "Jake — Brand & GTM" — post Jake's brand questions
- "Sean — Brand & GTM" — post Sean's questions

Post TWO messages (one per person). Format:

```
Standup questions — [Month Day]. [Deadline context if relevant].

@[person] — reply in a thread:

1. *[Topic]:* [Question]
2. *[Topic]:* [Question]
...
```

Tag using Slack user IDs:
- Jake: <@U0AK8FANGNM>
- Sean: <@U0ANN485UUT>

Save the channel ID + message timestamp (ts) for each post. You need these to poll for replies.

### Step 1b: Post to #martydev (C0AKS98Q5K5)

Find the sections for:
- "Asif — Mission: ..."
- "Rizwan — Mission: ..."
- "Nadeem — Mission: ..."
- "Jake — Product & Strategy"

Post FOUR messages (one per person). Same format as above.

Tag using Slack user IDs:
- Asif: <@U0AJZ6H8WBE>
- Rizwan: <@U0AMUGX6F5X>
- Nadeem: <@U0AK8FPKK41>
- Jake: <@U0AK8FANGNM>

Save the channel ID + message timestamp (ts) for each post.

### Step 2: Poll for thread replies

Every 5 minutes, check each posted message for thread replies using conversations.replies (or equivalent Slack API).

When you find a new reply from someone other than yourself:

1. **Identify the replier** by Slack user ID:
   - U0AK8FANGNM → Jake
   - U0ANN485UUT → Sean
   - U0AJZ6H8WBE → Asif
   - U0AMUGX6F5X → Rizwan
   - U0AK8FPKK41 → Nadeem
   - U0AJG90JHN3 → Andreas
   - U0ANSCQPJFQ → Warda

2. **Map the reply to the correct standup section:**
   - Sean's replies in #brand → "### Sean — Brand & GTM"
   - Jake's replies in #brand → "### Jake — Brand & GTM"
   - Asif's replies in #martydev → "### Asif — Mission: ..."
   - Rizwan's replies in #martydev → "### Rizwan — Mission: ..."
   - Nadeem's replies in #martydev → "### Nadeem — Mission: ..."
   - Jake's replies in #martydev → "### Jake — Product & Strategy"
   - Warda's replies in #martydev → "### Warda — QA Testing"

3. **Parse the reply:**
   - If they numbered their answers (1. 2. 3.), split and place each under the right question
   - If it's one block of text, use context to figure out which question(s) it answers
   - If they only answered some questions, only replace those placeholders

4. **Clean up the answer:**
   - Fix obvious typos
   - Remove filler ("um", "so basically", "yeah so")
   - Tighten for readability
   - Keep their voice, substance, and specifics — don't sanitize or corporate-ify it

5. **Update the standup doc:**
   - Open `~/tryps-docs/docs/standups/YYYY-MM-DD-standup.md`
   - Find the exact placeholder: `[Dev answers here]` or `[Sean answers here]` or `[Jake answers here]`
   - Replace ONLY that placeholder with their answer
   - Do NOT touch any other part of the file

6. **Commit and push:**
   ```bash
   cd ~/tryps-docs
   git pull origin main
   git add docs/standups/YYYY-MM-DD-standup.md
   git commit -m "standup: update [name]'s answers from Slack ([date])"
   git push origin main
   ```

7. **React to their Slack thread reply** with a checkmark (✅) so they know it was captured.

### Step 3: Keep polling

Continue every 5 minutes until:
- All "[answers here]" placeholders are filled, OR
- 8 PM ET (end of day)

If someone hasn't replied by 2 PM ET, send a reminder in the thread:
"Hey — still need your standup answers. Reply here when you can."

### Step 4: Post completion summary

Once all answers are in (or at end of day), post to #martydev:

```
Standup sync complete for [date].
- [X]/[total] people answered
- Doc updated: `~/tryps-docs/docs/standups/YYYY-MM-DD-standup.md`
- [Names who haven't answered yet, if any]
```

---

## Channel Reference

| Channel | ID | Who |
|---------|-----|-----|
| #brand | C0AP2B9J5PU | Jake (brand Qs) + Sean |
| #martydev | C0AKS98Q5K5 | Asif, Rizwan, Nadeem, Jake (dev Qs), Warda |
| #martyasif | C0AKH79E1F1 | Bug reports, Asif-specific |

## Rules

- Post as MARTY (your own Slack identity). Not @tryps, not on behalf of Jake.
- These are YOUR questions to the team. You're the project manager. Own it.
- Never say "Jake wants to know" or "Jake asked me to ask" — just ask directly.
- Never use the word "crew."
- One commit per person's answers (not per individual question).
- Always git pull before editing to avoid conflicts.
- If the standup doc doesn't exist yet, don't post — wait for it to be generated first.
