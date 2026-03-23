---
id: agent-intelligence
needs_figma: true
designer: unassigned
design_status: not-started
screens:
  - agent-memory-screen
  - recommended-activities-section
last_updated: 2026-03-22
---

# Agent Intelligence — Design Needs

This scope has two UI surfaces that need design, plus a message format for vote-on-behalf DMs.

## 1. Agent Memory Screen

**Status:** Not started — needs design

**What:** A screen accessible from behind the Travel DNA section in the user's profile. Shows what the agent knows about you and how it uses that data.

**Proposed content:**

```
Your Travel Agent
─────────────────

What I know about you

  Preferences
  ├── Beaches over mountains
  ├── Boutique hotels over chains
  ├── Nightlife: not interested
  └── Budget: mid-range

  Learned from your trips
  ├── You usually vote for outdoor activities
  ├── You added 4/6 restaurant recommendations (high adoption)
  └── Top favorites: sunset tours, local food markets

  Interaction style
  └── "Call me Sir Stein"

The more you use Tryps, the better I get at
knowing what you want.
```

**Design questions:**
- Does this live as a sub-screen of Travel DNA, or a separate tab/section on the profile?
- Should users be able to edit/remove individual memories? (e.g., "I don't hate nightclubs anymore")
- How do we visually distinguish between explicit preferences (from quiz) and learned behaviors (from usage)?
- Should there be a "reset memory" option?

**Blocks:** SC-15 (users can view what the agent remembers)

## 2. Recommended Activities Section

**Status:** Not started — needs design

**What:** A "Suggested for your group" section on the Activities tab within a trip. Shows ranked activity recommendations personalized to the group's vibe quiz answers and memory.

**Proposed layout:**

```
Activities Tab
─────────────────

Your Activities
  [existing activities the group has added]

Suggested for your group
  ┌─────────────────────────┐
  │ 🏄 Surfing at Kuta Beach │
  │ Based on your group's   │
  │ adventure vibe           │
  │              [+ Add]     │
  └─────────────────────────┘
  ┌─────────────────────────┐
  │ 🍜 Warung Babi Guling    │
  │ Quinn loved this spot    │
  │              [+ Add]     │
  └─────────────────────────┘
  ┌─────────────────────────┐
  │ 🌅 Uluwatu Temple        │
  │ Popular with groups      │
  │ like yours               │
  │              [+ Add]     │
  └─────────────────────────┘
```

**Design questions:**
- How many recommendations to show initially? (Proposed: 5-8, with "show more")
- Do we show WHY each activity is recommended? ("Based on your vibe", "Quinn loved this", "Popular with similar groups")
- Card format: how much detail per recommendation? Name + one-line reason + add button?
- How do friend-generated activities look different from seed data?
- Does adding a recommendation animate/move it to "Your Activities"?

**Blocks:** SC-41 (recommendations surface on Activities tab)

## 3. Vote-on-Behalf Batch DM Format

**Status:** Not started — needs copy/format specification

**What:** The format of the batch DM the agent sends when it votes on a user's behalf. This is an iMessage text, not an app screen, but the copy and structure need specification.

**Proposed format:**

```
hey, your group has 6 activities up for vote

I voted yes on:
- sunset boat tour
- beach day at Seminyak
- dinner at La Lucciola

I voted no on:
- nightclub crawl
- temple tour at 6am
- shopping mall trip

based on your vibe. reply here to change
any of these or tap [link] to review in the app
```

**Copy considerations:**
- Must follow voice-guide.md rules (lowercase, no emojis, no walls of text)
- Brief reasoning ("based on your vibe") — not per-activity justification
- Clear call-to-action for overrides
- Deep link to app for visual review
- If only 1-2 polls, adjust format (no header needed for a single vote)

**Blocks:** SC-20, SC-21 (batch DM format and change mechanism)
