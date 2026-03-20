---
id: p1-claude-connector
title: "Claude Connector"
phase: p1
status: not-started
assignee: nadeem
priority: 7
dependencies: []
blocked: false
blocked_reason: ""
---

# P1 Scope 7: Claude Connector — Spec

> **Phase:** P1: Core App
> **Gantt ID:** `p1-claude-connector`
> **Comp:** [ChatGPT Plugins](https://openai.com/index/chatgpt-plugins/) — third-party tools inside an AI conversation. Users say what they want, the AI calls your API. Tryps does this via Claude's MCP connector directory.

## What

Remote MCP server that lets Claude users plan and manage group trips directly from conversation — create trips, add activities, invite people, track expenses — all through natural language in claude.ai.

## Why

Every other trip planning app requires you to open their app. Tryps meets users where they already are — in Claude. Being in the Claude connector directory (alongside Gmail, Slack, Notion) is massive distribution. It also validates the Phase 3 agent layer thesis — if Claude can operate Tryps, so can our own agents.

## Intent

> "Tryps becomes a connector in Claude so users can plan and manage group trips directly from conversation. Someone says 'plan a 5-day trip to Barcelona for my friend group' and it creates a real trip in Tryps, adds activities, invites people, tracks expenses."
>
> "This positions Tryps as an AI-native travel platform. Every other trip planning app requires you to open their app. Tryps meets users where they already are — in Claude."
>
> "Being in the Claude connector directory alongside Gmail, Slack, Notion is massive distribution. Users discover Tryps while already in an AI workflow."

## Success Criteria

### MCP Server Infrastructure

- [ ] **P1.S7.C01.** Remote MCP server is deployed and reachable over HTTPS. Verified by: send a JSON-RPC 2.0 `initialize` request to the server URL -> server responds with `serverInfo` and supported capabilities within 2 seconds.

- [ ] **P1.S7.C02.** Server uses Streamable HTTP transport (JSON-RPC 2.0 over POST). Verified by: send a POST request with `Content-Type: application/json` containing a valid MCP `tools/list` method -> server responds with a JSON-RPC result containing the tool list.

- [ ] **P1.S7.C03.** CORS headers allow requests from Claude browser clients. Verified by: send an OPTIONS preflight request with `Origin: https://claude.ai` -> response includes `Access-Control-Allow-Origin` matching the origin.

- [ ] **P1.S7.C04.** Tool responses stay under 25,000 tokens. Verified by: call `get_trip_itinerary` on a trip with 14 days and 5+ activities per day -> response is under 25,000 tokens -> if data exceeds limit, response is paginated or summarized.

### OAuth 2.1 Authentication

- [ ] **P1.S7.C05.** Authorization code flow with PKCE authenticates against Supabase Auth. Verified by: initiate OAuth flow from Claude -> redirected to Tryps login -> enter credentials -> redirected back to Claude with access token -> Claude can call tools as the authenticated user.

- [ ] **P1.S7.C06.** Claude callback URLs are allowlisted. Verified by: OAuth redirect uses `https://claude.ai/api/mcp/auth_callback` -> redirect completes without error -> repeat with `https://claude.com/api/mcp/auth_callback` -> both succeed.

- [ ] **P1.S7.C07.** Each Claude session acts on behalf of the authenticated Tryps user. Verified by: User A authenticates -> calls `get_trips` -> sees only User A's trips -> User B authenticates in a separate Claude session -> sees only User B's trips.

- [ ] **P1.S7.C08.** Token refresh works without re-authentication. Verified by: authenticate -> wait for access token to expire -> call a tool -> server refreshes the token automatically -> tool call succeeds without prompting login again.

### Read Tools

- [ ] **P1.S7.C09.** `get_trips` returns the user's trips filtered by status. Verified by: user has 3 upcoming and 2 past trips -> call `get_trips` with filter "upcoming" -> response contains exactly the 3 upcoming trips with name, destination, dates, and member count.

- [ ] **P1.S7.C10.** `get_trip_details` returns the full trip card. Verified by: call with a valid trip ID -> response includes destination, start/end dates, member list, trip status, and vibe description.

- [ ] **P1.S7.C11.** `get_trip_itinerary` returns the day-by-day plan. Verified by: call on a trip with a 3-day itinerary -> response lists each day with its scheduled activities, times, and locations.

- [ ] **P1.S7.C12.** `get_trip_activities` returns activities with vote counts. Verified by: trip has 5 activities, 2 with votes -> response lists all 5 activities with names, descriptions, and vote tallies for the voted ones.

- [ ] **P1.S7.C13.** `get_trip_members` returns participants with RSVP and flight info. Verified by: trip has 4 members (2 confirmed, 1 pending, 1 with flight added) -> response shows all 4 with correct RSVP status and flight details where present.

- [ ] **P1.S7.C14.** `get_trip_expenses` returns expense breakdown and balances. Verified by: trip has 3 expenses totaling $300 split among 3 people -> response shows each expense, the split, and per-person balances (who owes whom).

- [ ] **P1.S7.C15.** `get_trip_stay` returns accommodation details and voting status. Verified by: trip has 2 stay options, one with 3 votes -> response lists both options with details and vote counts.

- [ ] **P1.S7.C16.** `search_trips` finds trips by destination, date, or keyword. Verified by: user has trips to "Barcelona" and "Tokyo" -> search for "Barcelona" -> response returns only the Barcelona trip.

### Write Tools

- [ ] **P1.S7.C17.** `create_trip` creates a trip with destination, dates, and vibe. Verified by: call with destination "Lisbon", dates Mar 20-25, vibe "chill beach vibes" -> trip appears in the user's trip list in the Tryps app with all provided details.

- [ ] **P1.S7.C18.** `add_activity` adds an activity to a trip. Verified by: call with trip ID and activity "Sunset boat tour" -> activity appears on the trip's Activities tab in the app.

- [ ] **P1.S7.C19.** `update_itinerary` modifies the day-by-day plan. Verified by: call to move "Boat tour" from Day 2 to Day 3 -> open trip's Itinerary tab in app -> boat tour is now on Day 3.

- [ ] **P1.S7.C20.** `invite_member` invites someone to a trip by phone number or Tryps username. Verified by: call with a phone number -> invitee receives an invite -> invitee joins the trip -> they appear on the trip's People tab.

- [ ] **P1.S7.C21.** `add_expense` logs an expense with split info. Verified by: call with "Dinner at Nobu, $200, split equally 4 ways" -> expense appears on Expenses tab with $50 per person.

- [ ] **P1.S7.C22.** `update_trip` modifies trip details. Verified by: call to change trip dates from Mar 20-25 to Mar 22-27 -> trip card in app shows updated dates.

### Safety Annotations

- [ ] **P1.S7.C23.** Every read tool has `readOnlyHint: true` annotation. Verified by: call `tools/list` -> inspect each read tool's annotations -> all 8 read tools include `readOnlyHint: true`.

- [ ] **P1.S7.C24.** Every write tool has `destructiveHint: true` annotation. Verified by: call `tools/list` -> inspect each write tool's annotations -> all 6 write tools include `destructiveHint: true`.

- [ ] **P1.S7.C25.** Write tools prompt Claude to confirm with the user before executing. Verified by: ask Claude to "create a trip to Tokyo" -> Claude describes what it will do and asks for confirmation -> user confirms -> tool is called.

### End-to-End Validation

- [ ] **P1.S7.C26.** MCP Inspector validation passes for all tools. Verified by: point MCP Inspector at the server URL -> run full validation suite -> all tools pass schema validation, auth checks, and response format checks.

- [ ] **P1.S7.C27.** Server works as a custom connector in claude.ai. Verified by: add the server URL in Claude Settings under "Connected MCP Servers" -> start a new conversation -> ask Claude "What trips do I have?" -> Claude calls `get_trips` and returns results from the user's Tryps account.

- [ ] **P1.S7.C28.** All 14 tools are callable from a Claude conversation. Verified by: in a single Claude conversation, call each of the 8 read tools and 6 write tools -> all return valid responses or successfully execute the action.

- [ ] **P1.S7.C29.** Row-Level Security enforced — users only see and modify their own trips. Verified by: User A creates a trip -> User B authenticates and calls `get_trips` -> User B's response does not include User A's trip -> User B calls `get_trip_details` with User A's trip ID -> error returned, not the trip data.

### Directory Submission (Stretch)

- [ ] **P1.S7.C30.** Documentation includes 3+ example prompts showing what users can do. Verified by: review documentation page -> at least 3 example prompts shown (e.g., "Plan a 5-day trip to Barcelona," "Add a sunset boat tour to my Miami trip," "How much do I owe on the Tokyo trip?").

- [ ] **P1.S7.C31.** Privacy policy and support contact are publicly accessible. Verified by: click the privacy policy link from the connector listing -> page loads -> support email or contact form is visible.

- [ ] **P1.S7.C32.** Test credentials provided for Anthropic reviewers. Verified by: Anthropic reviewer uses the test account -> can authenticate, list trips, and call all tools against a seeded test dataset.

### Should NOT Happen

- [ ] **P1.S7.C33.** MCP server never bypasses Supabase Row-Level Security. Verified by: attempt to call `get_trip_details` with another user's trip ID from an authenticated session -> server returns an authorization error, not the trip data.

- [ ] **P1.S7.C34.** No new database tables are created for the connector. Verified by: compare database schema before and after deploying the MCP server -> no new tables added -> connector uses only existing RPCs and queries.

- [ ] **P1.S7.C35.** Tool responses never leak data from other users' trips. Verified by: call every read tool as User A -> inspect all response payloads -> no trip IDs, member names, or expense data belonging to other users appears.

### Out of Scope

- **Booking or payment tools** — the connector exposes planning and coordination. Booking flights (Phase 3/Duffel) and processing payments (Phase 2/Stripe) are separate scopes.
- **Agent-to-agent communication** — this connector is for human Claude users. Agent-layer integrations (Phase 3) will build on this foundation but are scoped separately.
- **Push notifications from Claude** — Claude calls Tryps tools; Tryps doesn't push back to Claude conversations.
- **Directory listing approval** — Anthropic reviews on their timeline. Custom connector works immediately. Directory submission is a stretch goal.

### Regression Risk

| Area | Why | Risk |
|------|-----|------|
| Supabase Auth | Wiring OAuth 2.1 PKCE flow on top of existing phone/Apple auth | High |
| Existing RPCs | Read tools rely on existing Supabase RPCs — changes to those RPCs break the connector | Medium |
| RLS policies | Connector introduces a new access pattern (server-side on behalf of user) that must respect all existing RLS | Medium |

## References

- Claude Connectors docs: `support.claude.com/en/articles/11697096-anthropic-mcp-directory-policy`
- MCP spec: `modelcontextprotocol.io`
- TypeScript SDK: `github.com/modelcontextprotocol/typescript-sdk`
- Cloudflare Workers MCP template: `github.com/cloudflare/ai/demos/remote-mcp-authless`
- Submission form: Google Form (linked from Anthropic docs)

- [ ] Typecheck passes
