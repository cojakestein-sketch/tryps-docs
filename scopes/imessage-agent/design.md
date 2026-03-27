---
id: imessage-agent
needs_figma: false
designer: unassigned
design_status: in-progress
copy_doc_needed: true
copy_doc_status: drafted
screens: []
last_updated: 2026-03-21
---

> Parent: [[imessage-agent/objective|iMessage Agent Objective]]

# iMessage Agent — Design Needs

This scope has NO Figma screen needs, everything lives in iMessage. The critical design deliverable is a **copy doc**: the voice & tone guide for the agent.

## 1. Voice & Tone Guide (Copy Doc)

**Status:** Drafted (see `voice-guide.md` in this folder)

**What:** A document defining the agent's personality, phrasing patterns, example responses, and boundaries. This becomes the foundation of the system prompt's persona section.

**What it covers:**
- Messaging-native rules (multiple short messages, lowercase, no periods at end of single texts)
- The 85/15 rule with examples of each
- Phrasing patterns for every scenario (confirmations, questions, suggestions, nudges, de-escalation, options, errors)
- The Kill List: banned AI words, phrases, and structural patterns
- Uncanny valley avoidance (no claimed emotions, imperfection > polish, consistency)
- Escalating nudge patterns for non-responders (private DMs, never public shaming)
- Full scenario examples showing the voice in action
- Litmus tests for QA'ing agent responses

**Constraints from brand docs:**
- Matches brand voice (Section 6 of brand-strategy.md)
- Uses word list / avoids banned words (Section 7)
- Lowercase in conversational UI
- No emojis or slang in agent copy

**Blocks:** SC-26 through SC-31 (Agent Personality & Jennifer Test). Draft unblocks dev work; final review needed before Jennifer Test validation.

## 2. Welcome Message Copy

**Status:** Drafted in voice-guide.md (see scenario examples)

**What:** The first message the agent sends when added to a group chat. Must nail the first impression.

**Current draft:**
```
hey, Jake added me. I'm Tryps, your travel agent for this trip

ask me anything about the plan, or text an expense and I'll track it

first things first, what kind of trip are we thinking?
```

**Blocks:** SC-1

## 3. Trip Completeness Level System

**Status:** Not started — needs design

**What:** A leveling system that tracks where a trip is in the planning process. The agent uses this to drive its daily check-ins. Users can see their level in the app. Each level represents a concrete planning milestone.

**Jake's initial thinking:**
- Level 1: Location + dates + trip name
- Level 2: Flights aligned (when people are getting in)
- Level 3: Stay picked
- Level 4: Activities on the voting block
- Level 5: Decided on what to do
- Level 6: Rough itinerary building
- Level 7+: Vibe tab, playlist, packing, etc.
- Level 10: Fully planned trip end-to-end

**Design questions:**
- How many levels? Jake suggested ~10 but the exact breakdown needs work.
- What milestones map to each level? Some trips may skip levels (e.g., no flights needed for a road trip).
- How is the level displayed in the app? Progress bar? Numbered badge? Checklist?
- Can a trip go backward (e.g., stay falls through, drops from level 3 to level 2)?
- How does the agent reference levels in daily check-ins? Does it say "you're at level 3" or just describe what's needed without the number?

**Blocks:** SC-53 (trip completeness system), SC-25 (daily check-ins driven by levels)

## 4. Routing Logic Design Doc

**Status:** Not started — needs intentional design before implementation

**What:** A document defining when the agent speaks vs. stays silent. This is the hardest technical problem in the scope. Needs at least 20 example messages with expected behavior, edge cases that could go either way, and "gotchas" from testing. The system prompt's routing section will reference this directly.

**Example edge cases to resolve:**
- "Yo we should go to the club" — actionable? Depends on context.
- "I can't wait for this trip" — casual enthusiasm or a prompt for agent engagement?
- "What about that restaurant Sarah mentioned?" — is this directed at the agent?
- Someone shares a location pin — should the agent acknowledge?
- "lol" in response to the agent's message — should it reply?

**Blocks:** SC-52 (routing logic design doc), SC-47 (agent stays silent on casual messages), SC-23 (agent detects opportunities)
