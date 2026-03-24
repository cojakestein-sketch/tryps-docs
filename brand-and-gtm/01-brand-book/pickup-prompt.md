# Brand Book Interview + Implementation — Pickup Prompt

> Copy-paste this entire prompt into a new Claude Code session.
> It will run the interview, capture answers, and implement all changes.

---

## Context

You are helping Jake Stein finalize the Tryps brand book spec. Jake and Sean DeFaria (creative lead) have been scoping the brand & GTM work. The brand book is Scope 01 with a Milestone 1 deadline of April 2, 2026.

**The big positioning shift:** Tryps is no longer positioned as a "group trip planning tool" or "Partiful for travel." It is now positioned as:

> **Your group's travel concierge — just text it.**
> Hero tagline: **"Text your trip into existence."**

The core product is an iMessage agent (travel concierge) that lives in your group chat. You text it your vibe, it plans the entire trip. The brand book needs to center every screen on this concierge framing.

## Your Job

### Phase 1: Interview (ask Jake all 30 questions)

Read the questions from `brand-and-gtm/01-brand-book/spec.md` under "Questions to Discuss at Lunch." Ask them one section at a time:

1. The Concierge Identity (Q1-4)
2. Positioning & Tagline (Q5-8)
3. Brand Story (Q9-11)
4. Visual Direction (Q12-16)
5. Scope & Priority (Q17-20)
6. The Brand Book's Audience (Q21-23)
7. Cross-Scope Connections (Q24-27)
8. Working Model with Sean (Q28-30)

After each section, summarize the answers back to Jake for confirmation before moving on. If Jake gives short answers, push for specifics — these answers directly feed the Figma Make prompts.

### Phase 2: Update Strategy Doc

After all questions are answered, update `shared/brand-strategy.md` with:
- Any new positioning language
- Updated brand archetype (if concierge changes Host/Magician split)
- Updated voice & tone (concierge personality)
- New tagline decisions
- Any word list changes

### Phase 3: Update Screen Checklist

Update `docs/brand-book-screen-checklist.md`:
- Cut screens Jake said to remove
- Add new screens discussed (e.g., "Meet the Concierge," "How It Works," "Before/After")
- Update priority (MUST/LATER) based on answers
- Recalculate totals

### Phase 4: Rewrite All Figma Make Prompts

This is the big one. `designs/brand-book-make-prompts.md` has 62 individual prompts across 22 sections. Every prompt that references the old "group trip planning" framing needs to be rewritten with:

- Concierge/agent as the hero
- "Text your trip into existence" as the tagline
- iMessage conversation screenshots as the primary visual
- The concierge's personality and voice (from Q1-4 answers)
- The visual direction decisions (from Q12-16 answers)

**Key rules for prompt rewriting:**
- Keep the technical constraints (1920x1080, white/gray bg, Tryps Red #D9071C, Plus Jakarta Sans, Space Mono for numbers)
- Update content and framing to concierge positioning
- Add new prompts for any added screens
- Remove prompts for any cut screens
- Each prompt must be copy-pasteable into Figma Make

### Phase 5: Update Brand Book Spec

Update `brand-and-gtm/01-brand-book/spec.md`:
- Replace questions section with answered decisions
- Update screen list with final cut
- Update deliverable checklist
- Add "Sean's Workflow" section with clear step-by-step instructions

### Phase 6: Package for Sean

Create `brand-and-gtm/01-brand-book/sean-handoff.md` — a clean handoff doc that contains:
- The positioning in 3 sentences
- The final screen list with priority order
- Link to the make prompts file
- Step-by-step Figma workflow
- Review cadence and contact info
- What "done" looks like

### Phase 7: Commit and Push

Commit everything to tryps-docs main branch with a clear commit message.

## Files to Read First

Before starting the interview, read these files to have full context:

1. `brand-and-gtm/01-brand-book/spec.md` — the current spec with all 30 questions
2. `brand-and-gtm/sean.md` — the contract with Sean (milestones, deliverables)
3. `shared/brand-strategy.md` — current brand strategy (already updated with concierge framing)
4. `docs/brand-book-screen-checklist.md` — all 56 screens mapped
5. `designs/brand-book-make-prompts.md` — all 62 Figma Make prompts (70KB)
6. `shared/brand.md` — design tokens (colors, fonts, spacing)
7. `brand-and-gtm/01-brand-book/objective.md` — milestone checklist
8. `brand-and-gtm/reference/INDEX.md` — index of all reference materials

## Success Criteria

When you're done:
- [ ] All 30 questions have documented answers
- [ ] Brand strategy doc reflects final decisions
- [ ] Screen checklist updated with adds/cuts
- [ ] All 62+ Figma Make prompts rewritten with concierge framing
- [ ] Brand book spec updated with decisions (not questions)
- [ ] Sean handoff doc created
- [ ] Everything committed and pushed
- [ ] Sean can open the make prompts file, copy-paste into Figma Make, and build the brand book without needing to ask Jake anything
