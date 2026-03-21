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
