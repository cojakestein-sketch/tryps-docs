---
title: "Figma MCP Setup Plan"
type: feat
date: 2026-03-24
status: active
assignees: [nadeem, jake]
---

# Figma MCP Setup Plan

> Connect Marty to Figma so he can audit designs during PR reviews and run weekly component inventories.

---

## Why

Figma is our design source of truth. Right now there's no automated way to check if code matches Figma. Design drift accumulates silently — wrong colors, spacing, fonts — and we only catch it during manual reviews (if at all).

With a Figma MCP connection, Marty can:
- Check every PR against the actual Figma designs
- Run weekly audits to catch drift across the whole codebase
- Accelerate the Uniwind migration by flagging legacy `theme.ts` usage

---

## Architecture

```
Figma (source of truth)
    ↓ Figma REST API (PAT auth)
Framelink MCP Server (on Hetzner)
    ↓ MCP protocol
Marty / OpenClaw
    ↓ reads
figma-component-map.json (code ↔ Figma mapping)
    ↓ compares
Codebase (Uniwind classes, theme.ts, inline styles)
    ↓ reports
PR comments + Slack + weekly reports
```

---

## Why Framelink (Not Official Figma MCP)

| | Official Remote | Official Desktop | Framelink |
|---|---|---|---|
| Auth | OAuth (browser required) | Local app required | **PAT (headless)** |
| Works on Hetzner | No | No | **Yes** |
| Setup complexity | High (OAuth flow) | N/A (needs GUI) | **Low (one env var)** |
| GitHub stars | N/A | N/A | **13.9k** |
| Data format | Raw Figma API | Raw Figma API | **LLM-optimized** |

---

## Setup Steps

### Step 1: Jake Generates a Figma PAT

1. Go to **Figma.com → Settings → Security → Personal Access Tokens**
2. Click **"Create new token"**
3. Name: `marty-design-audit`
4. Scopes: **File content (Read only)** + **Dev resources (Read only)**
5. Expiry: **No expiration** (or 1 year)
6. Copy the token (starts with `figd_`)

**Requirement:** Jake needs a paid Figma plan with **Dev Mode seat** or **Full seat** for PAT access with dev resource scope.

### Step 2: Add Token to Hetzner

SSH into Marty's server and add the token:

```bash
ssh -i ~/.ssh/hetzner openclaw@178.156.176.44
echo 'FIGMA_PERSONAL_ACCESS_TOKEN=figd_xxxxx' >> ~/.openclaw/secrets.env
```

### Step 3: Install Framelink MCP

Add to Marty's OpenClaw MCP config (`~/.openclaw/openclaw.json`):

```json
{
  "mcpServers": {
    "figma": {
      "command": "npx",
      "args": ["-y", "figma-developer-mcp", "--figma-api-key=figd_xxxxx", "--stdio"]
    }
  }
}
```

Then restart the gateway:

```bash
systemctl --user restart openclaw-gateway.service
```

### Step 4: Verify Connection

Ask Marty to fetch a known Figma frame:

```
Marty, use the Figma MCP to fetch the "Onboarding : Landing" frame from our Figma file. Show me the design tokens (colors, fonts, spacing).
```

If it returns structured design data, the connection is working.

### Step 5: Deploy Component Map

The component map file (`marty/skills/design-audit/figma-component-map.json`) maps code files to Figma frames. It ships with this PR and syncs to Hetzner via the existing 30-minute sync script.

---

## What This Enables

| Capability | When | How |
|-----------|------|-----|
| **PR Design Check** | Every PR touching UI files | Marty compares changed files against mapped Figma frames, posts findings as PR comment |
| **Weekly Inventory** | Monday morning (cron) | Marty audits all mapped components, reports drift + migration progress to #martydev |
| **Design Token Sync** | On demand | Marty extracts Figma tokens and compares against Uniwind config |

---

## Timeline

| Step | Owner | ETA |
|------|-------|-----|
| Generate Figma PAT | Jake | 5 minutes |
| Add token + install Framelink on Hetzner | Jake or Nadeem (SSH access) | 10 minutes |
| Verify connection | Nadeem | 5 minutes |
| Initial component map (shipped in this PR) | Nadeem | Done |
| First PR design check | Automatic on next UI PR | — |
| Weekly inventory cron | Follow-up PR | Week of Mar 31 |

---

## Risks

| Risk | Mitigation |
|------|-----------|
| Figma PAT expires or gets revoked | Set no-expiration; Marty reports auth errors to #martydev |
| Framelink package breaks on update | Pin version in openclaw.json args: `figma-developer-mcp@0.x.x` |
| Component map goes stale | Weekly inventory flags unmapped files; devs update map when adding screens |
| Figma rate limits | Framelink caches responses; PR checks are infrequent enough to stay within limits |
