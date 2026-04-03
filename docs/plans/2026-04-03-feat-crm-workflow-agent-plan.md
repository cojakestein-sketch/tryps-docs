# CRM Workflow & Networking Agent Plan

> Created: 2026-04-03
> Owner: Jake
> Status: In progress (Step 1 — contact ingestion)
> Source: Team call 2026-04-02, Granola transcript

---

## Problem

Jake needs a system to answer: "Who do I know — or who could I reach — to accomplish [goal]?" Examples:
- "Get Instagram @tryps" → find someone at Instagram in my network
- "Land Airbnb partnership" → find the right person, ideally via mutual connection

Currently: contacts scattered across phone, LinkedIn, McKinsey alumni portal, MIT directory. No single queryable place. No agent can help.

## Decision: Folk CRM ($20/mo)

**Chosen tool:** [Folk](https://folk.app) — lightweight CRM for founders/VCs.

| Feature | Folk |
|---------|------|
| API (agent-queryable) | REST API, full CRUD |
| Email sending | Built-in, Gmail-connected |
| Meeting booking | Native scheduler (folkx.com) |
| Enrichment | Built-in with credits |
| LinkedIn import | Chrome extension |
| Tags/filtering | Custom fields, groups, pipelines |

**Rejected alternatives:**
- DenchClaw (fka Ironclaw, YC S24) — sales/outbound CRM, not personal
- Attio — better API but no LinkedIn extension, no native scheduler, $34/mo
- Go High Level — agency whitelabel tool, massive overkill
- Supabase custom table — Jake wants off-the-shelf UI
- Clay — enterprise GTM ($149+/mo), wrong category
- Dex — no API, dealbreaker

## Architecture: Three-Tier Contact Lookup

```
User prompt: "Land an Airbnb partnership"
         │
         ▼
┌─────────────────────────┐
│   Agent (Marty + CLI)   │  Claude with function calling
│   Plans → Tools → Synth │
└────────┬────────────────┘
         │
    ┌────┼──────────────┐
    ▼    ▼              ▼
 Tier 1  Tier 2       Tier 3
 Folk    PDL Search   AgentCash
 API     + Proxycurl  stableenrich
 (own    (find people  (scrape +
 contacts) by company)  enrich bios)
    │        │            │
    └────────┼────────────┘
             ▼
    Response Filter (Claude)
    → Top 3-5 contacts
    → Mutual connection angle
    → Draft outreach email
    → Write new contacts back to Folk
```

**Agent interface:** Option C — Marty (Slack) for quick lookups, Claude Code CLI for deep research sessions.

**Key insight:** The agent needs to *reason* about connections ("Sarah was at Booking.com → travel execs know each other → ask for Airbnb intro"). This requires Claude function calling, not a pipeline tool like n8n or LangGraph.

## Contact Ingestion Plan

| Source | Records | Method | Status |
|--------|---------|--------|--------|
| LinkedIn export | ~250+ | CSV download → import to Folk | TODO |
| iPhone contacts | ~100+ | vCard export → import to Folk | TODO |
| McKinsey alumni | ~30-50 | Manual browse + add (can't scrape — ToS) | TODO |
| MIT directory | ~20-30 | Manual browse + add | TODO |
| Enrichment | All | AgentCash/StableEnrich (~$0.05/contact) | After import |

**CU Boulder:** Not an import source — it's a *search priority tag*. When agent finds someone at Instagram who's CU Boulder, they rank higher.

## Outreach Stack

| Layer | Tool |
|-------|------|
| Drafting | Claude (with 5-10 example emails as voice library) |
| Sending | Gmail API via Folk or n8n |
| Booking | Folk native scheduler or Calendly |
| Tracking | Folk (sent/replied/meeting booked per contact) |
| Orchestration | n8n (deterministic automation only) |

**NOT using:** Instantly, Lemlist, Loops, Resend, stableemail.dev — all wrong for 10-20 personalized emails/day.

## Three-Step Execution

### Step 1 — Jake (this week) ← CURRENT
1. ✅ Sign up for Folk ($20/mo)
2. ✅ Install Folk Chrome extension
3. Export LinkedIn connections CSV → import into Folk
4. Export iPhone contacts vCard → import into Folk
5. Tag by source: `linkedin`, `phone`, `mckinsey`, `mit`
6. Manually add 30-50 McKinsey + MIT contacts
7. Write 5-10 example outreach emails (voice library)

### Step 2 — Spec for team (next week)
1. Spec the agent: Claude function calling + Folk API + PDL + Proxycurl + AgentCash
2. Define tool interfaces: `search_folk_contacts`, `search_pdl_people`, `enrich_contact`, `draft_email`, `update_folk_contact`
3. Define response filter: mutual connections > same school > same company > cold
4. Assign to Rizwan (agent layer) or Enej (automation)

### Step 3 — Enej builds automation (week after)
1. n8n instance (self-hosted on Hetzner or cloud)
2. Enrichment webhook: new contact in Folk → auto-enrich via StableEnrich → write back
3. Outreach workflow: agent drafts → Jake approves in Slack → Gmail sends → log to Folk
4. Calendly/Folk webhook: meeting booked → update contact status

## Enrichment API Stack

| API | Purpose | Cost |
|-----|---------|------|
| People Data Labs (PDL) | Primary person search + enrichment | ~$0.01-0.10/record |
| Proxycurl | LinkedIn profile data | ~$0.01/profile |
| AgentCash / StableEnrich | Social enrichment (Instagram, Twitter) | Variable |
| Apollo.io (free tier) | Email finding backup | Free (250 credits/mo) |

## Kickoff Prompt

```
@~/tryps-docs/docs/plans/2026-04-03-feat-crm-workflow-agent-plan.md

## Context
Jake's personal CRM workflow — a three-tier contact lookup agent that queries
Folk CRM, external databases (PDL, Proxycurl), and AgentCash to find the right
person for any networking/partnership goal.

## Your Task
[Step 2] Spec the agent tool interfaces for the CRM workflow. Define:
1. Folk API tool wrappers (search, read, create, update contacts)
2. PDL person search tool
3. Proxycurl LinkedIn enrichment tool
4. AgentCash social enrichment tool
5. Response filter prompt (ranking logic)
6. Email drafting prompt (with voice library)
7. Write-back flow (agent saves new contacts to Folk)
```
