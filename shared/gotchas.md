# Gotchas

> Compiled behavioral rules for all agents and sessions.
> Auto-maintained by /brain-lint. Manual edits will be overwritten.
> Source: ~/.claude/projects/-Users-jakestein/memory/feedback_*.md
> Last compiled: 2026-04-05

## Naming & Language

- Never use "crew" — Jake hates it. Say "your friends" or "your people"
- App is Tryps (not Tripful, not Vamos)
- Don't lead with "Martin" character in pitches — just say "Tryps"
- "Trip" not "journey" or "adventure" (too precious)
- No emojis or slang in agent/system copy

## Workflow & Process

- Default branch is `develop`, not `main` — always branch from develop
- Every spec.md must end with a copy/paste kickoff prompt for the pipeline
- FRD step removed — everything lives in spec.md only, no frd.md
- All slash commands at global level (`~/.claude/commands/`), not project-level
- Devs pursue API partnerships organically first; only escalate to Jake if blocked
- Don't ask for ClickUp API key — it's in `~/.zshrc`, just `source ~/.zshrc`

## Communication & Tone

- Standup questions: firm but not mean — no accusatory phrasing or shaming
- PR review requests go in #martydev (not DM), always include spec link
- Handoff prompts: @file refs at top, ## headers, explicit ## Your Task section
- Don't reveal expected answers in verification questions for Marty

## Technical

- Always use absolute file paths so Jake can command-click to open
- Background is white/light gray (gray/50), NOT warm cream — Figma overrides brand.md
- When debugging config, check ALL settings and present full diagnosis at once
- Design tokens come from Figma, never from .pen files

## Agent-Specific

- If Marty says "no exec access", nuke DM session transcript and restart gateway
- Always add Zoom link (no password, no waiting room) to every calendar event
- Zoom PMR: https://us05web.zoom.us/j/5559102787?pwd=IFVhuwj1bI1iONfWLAwmOew8LbVgca.1

## Tools & Environment

- Upwork: import cookies first (`/setup-browser-cookies`), then browse — Cloudflare blocks headless
- Auto-peek deliverable docs in cmux split pane after writing (`peek /path/to/file`)
- Don't auto-peek code files, config files, memory files, or minor edits
