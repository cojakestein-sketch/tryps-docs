# Scope 7: Claude Connector — Spec

> **Status:** draft
> **Phase:** P1: Core App
> **Gantt ID:** `p1-claude-connector`
> **Date:** March 15, 2026

## Why & Intent

Tryps becomes a connector in Claude (claude.ai) so users can plan and manage group trips directly from conversation. Claude users could say "plan a 5-day trip to Barcelona for my friend group" and have it create a real trip in Tryps, add activities, invite people, track expenses — all through natural language.

This positions Tryps as an AI-native travel platform. Every other trip planning app requires you to open their app. Tryps meets users where they already are — in Claude.

**Strategic value:** Being in the Claude connector directory (alongside Gmail, Slack, Notion) is massive distribution. Users discover Tryps while already in an AI workflow. It also validates the Phase 3 agent layer thesis — if Claude can operate Tryps, so can our own agents.

## How It Works

Claude Connectors are **remote MCP (Model Context Protocol) servers** — JSON-RPC 2.0 over HTTPS with OAuth 2.1. You build a server that exposes "tools" (functions Claude can call on behalf of authenticated users). Anthropic reviews and lists approved connectors in their directory.

**Two paths:**
1. **Custom connector** — host the MCP server, add URL in Claude Settings. Private. No review needed. Good for testing.
2. **Directory listing** — submit to Anthropic review. Public. Listed alongside Gmail, Slack, etc.

## Acceptance Criteria

### MCP Server Infrastructure
- [ ] Remote MCP server deployed (Cloudflare Workers or standalone HTTPS)
- [ ] Streamable HTTP transport (JSON-RPC 2.0 over POST)
- [ ] CORS properly configured for browser clients
- [ ] Response limits respected (max 25,000 tokens per tool result)

### OAuth 2.1 Authentication
- [ ] Authorization code flow with PKCE against Supabase Auth
- [ ] Claude callback URLs allowlisted (`claude.ai/api/mcp/auth_callback`, `claude.com/api/mcp/auth_callback`)
- [ ] Per-user sessions — Claude acts on behalf of the authenticated Tryps user
- [ ] Token refresh working

### Read Tools (readOnlyHint: true)
- [ ] `get_trips` — list user's trips (upcoming, past, all)
- [ ] `get_trip_details` — full trip card (dates, destination, members, status)
- [ ] `get_trip_itinerary` — day-by-day itinerary
- [ ] `get_trip_activities` — activities list with vote counts
- [ ] `get_trip_members` — participants, RSVPs, flight info
- [ ] `get_trip_expenses` — expense breakdown, balances, who owes what
- [ ] `get_trip_stay` — accommodation details and voting status
- [ ] `search_trips` — search by destination, date, keyword

### Write Tools (destructiveHint: true)
- [ ] `create_trip` — create trip with destination, dates, vibe
- [ ] `add_activity` — add an activity to a trip
- [ ] `update_itinerary` — modify day-by-day plan
- [ ] `invite_member` — invite someone to a trip (by phone or Tryps username)
- [ ] `add_expense` — log an expense with split info
- [ ] `update_trip` — modify trip details

### Safety Annotations
- [ ] Every tool has `readOnlyHint` or `destructiveHint` annotation
- [ ] Write tools require explicit user confirmation in Claude

### Testing & Validation
- [ ] MCP Inspector validation passes
- [ ] Works as custom connector in claude.ai (Pro account)
- [ ] All tools callable from Claude conversation
- [ ] RLS enforced — users only see/modify their own trips

### Directory Submission (stretch)
- [ ] Documentation with 3+ example prompts
- [ ] Privacy policy link
- [ ] Support contact
- [ ] Test credentials for Anthropic reviewers
- [ ] Submit to Anthropic MCP Directory review form

## Constraints

- **Supabase RLS still applies** — MCP server calls Supabase as the authenticated user. No privilege escalation.
- **No new database tables** — the connector exposes existing data through existing RPCs/queries.
- **OAuth is the hard part** — wiring Supabase Auth to standard OAuth 2.1 authorization code flow is the main technical challenge.
- **Directory listing is not guaranteed** — Anthropic reviews on their timeline. Custom connector works immediately.
- **Max 25,000 tokens per tool response** — paginate or summarize large trip data.

## References

- Claude Connectors docs: `support.claude.com/en/articles/11697096-anthropic-mcp-directory-policy`
- MCP spec: `modelcontextprotocol.io`
- TypeScript SDK: `github.com/modelcontextprotocol/typescript-sdk`
- Cloudflare Workers MCP template: `github.com/cloudflare/ai/demos/remote-mcp-authless`
- Submission form: Google Form (linked from Anthropic docs)
