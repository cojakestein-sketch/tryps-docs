# Decisions Log

> Significant decisions with context and rationale.
> Appended by /compound and /brain-compile. Never edited, only appended.
> Last updated: 2026-04-05 (initial)

## [2026-04-05] Brain 2.0 architecture adopted
Context: Knowledge was evaporating between sessions. 90% of learnings lost.
Decision: Implement Karpathy's LLM Wiki pattern — three layers (raw/wiki/schema), three operations (ingest/query/lint), index + log.
Rationale: Git-synced markdown, no database, gated write-back. Fits existing Obsidian workflow.

## [2026-03-18] ClickUp replaces Mission Control
Context: Mission Control Gantt was becoming maintenance overhead.
Decision: Move all project tracking to ClickUp. Specs stay in tryps-docs.
Rationale: ClickUp has API, better views, team already familiar.

## [2026-03-18] 13 MECE capability scopes
Context: Phase-based planning was creating artificial sequencing.
Decision: Restructure into 13 flat capability areas, sequence by dependency.
Rationale: Each scope independently testable, no artificial phase gates.

## [2026-03-27] Coordination/facilitation lives in Asif's scopes
Context: Jake defined April 2 gate — agent advances trip from creation to complete trip card.
Decision: Coordination layer is not a new scope — it lives inside Asif's existing iMessage agent scopes.
Rationale: The facilitation behavior (proactive sequencing, consensus building) extends the agent, not replaces it.

## [2026-03-27] Voice agent API evaluation started
Context: Jake wants concierge calling on the Tryps number — same capabilities as text, via voice.
Decision: Evaluate Vapi, Bland, Retell, Twilio Voice AI. Criteria: latency, tool calling, cost, integration with existing agent memory.
Rationale: Voice is a new modality for the same agent brain. Must plug into trip snapshot + memory system.
