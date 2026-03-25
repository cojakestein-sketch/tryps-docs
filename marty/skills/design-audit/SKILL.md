---
name: design-audit
description: "Understand and track which Figma screens are built in code, which are remaining, and flag design drift"
user-invocable: true
---

# Design Audit

You have access to our Figma designs via the Framelink MCP server. This skill teaches you how our Figma file is structured, how it maps to our codebase, and how to track what's built vs. what's remaining.

---

## Our Figma File

**File:** `CMhozPKkLjWk4pcKHsbTJF` — "Tryps — Official (work here)"
**Base URL:** `https://www.figma.com/design/CMhozPKkLjWk4pcKHsbTJF/Tryps---Official--work-here-`

Single Figma file, organized by flow. Krishna maintains the designs. To fetch any frame, pass the base URL with the `node-id` parameter to Framelink MCP.

### Design Pages (Screens)

| Page | Node ID | Figma URL |
|------|---------|-----------|
| Onboarding Flow 1 | `4130-35753` | `?node-id=4130-35753` |
| Onboarding Flow 2 | `4516-3207` | `?node-id=4516-3207` |
| Trip Creation Flow 4 | `4130-35754` | `?node-id=4130-35754` |
| Trips Menu Flow 6-12 | `4130-35877` | `?node-id=4130-35877` |
| Calendar | `4130-35899` | `?node-id=4130-35899` |
| Explore | — | Needs node ID |
| Profile & Settings | `4130-35900` | `?node-id=4130-35900` |

### Supporting Pages

| Page | What's In It | Node ID | Figma URL |
|------|-------------|---------|-----------|
| Components | Reusable design system components (buttons, cards, inputs, etc.) | `4138-2374` | `?node-id=4138-2374` |
| Style Guide | Typography, colors, spacing tokens — the design token source of truth | `4130-33698` | `?node-id=4130-33698` |
| Icon | Icon library | `22-2979` | `?node-id=22-2979` |

**To fetch a page:** Use `https://www.figma.com/design/CMhozPKkLjWk4pcKHsbTJF/Tryps---Official--work-here-?node-id=<NODE_ID>` with Framelink MCP. To fetch a specific frame within a page, use the frame's own node ID.

### Naming Convention

Every Figma frame follows: **`Section : Screen Name : Variant`**

Examples:
- `Onboarding : Landing`
- `Onboarding : Phone Number : Focused`
- `Onboarding : Verification Code : Error`
- `Trips Menu : Trip Details`
- `Trip Creation : Dates`

This is how you search for frames and match them to code files.

---

## Our Codebase (Expo Router)

The app lives in `cojakestein-sketch/tripful`. File-based routing under `app/`.

### How Screens Map to Code

| Figma Section | Code Location |
|---------------|--------------|
| Onboarding Flow 1 | `app/welcome.tsx`, `app/(auth)/phone.tsx`, `app/(auth)/verify.tsx`, `app/(auth)/contacts-permission.tsx` |
| Onboarding Flow 2 | `app/(auth)/profile-setup.tsx`, `app/travel-dna.tsx` |
| Trip Creation Flow 4 | `app/new-trip/index.tsx`, `app/new-trip/dates.tsx`, `app/new-trip/vibe.tsx` |
| Trips Menu Flow 6-12 | `app/(tabs)/index.tsx`, `app/trip/[id].tsx`, `app/trip/[id]/edit.tsx`, `app/trip/[id]/add-expense.tsx`, `app/trip/[id]/add-flight.tsx`, `app/trip/[id]/add-accommodation.tsx`, `app/trip/[id]/share.tsx`, `app/trip/[id]/your-balance.tsx` |
| Calendar | `app/(tabs)/calendar.tsx` |
| Explore | `app/(tabs)/explore.tsx` |
| Profile & Settings | `app/settings.tsx`, `app/profile/[userId].tsx` |

Components live in `components/` organized by feature: `components/home/`, `components/trip-detail/`, `components/calendar/`, `components/activities/`, `components/TrypsCard/`, etc.

### The Component Map

The full mapping lives in `marty/skills/design-audit/figma-component-map.json`. This is your primary reference for which Figma frames map to which code files.

```json
{
  "mappings": [
    {
      "codePath": "app/(auth)/phone.tsx",
      "figmaPage": "Onboarding Flow 1",
      "figmaFrame": "Onboarding : Phone Number",
      "figmaNodeId": null
    }
  ],
  "unmapped": [
    {
      "codePath": "app/(auth)/callback.tsx",
      "reason": "OAuth callback handler — no visual design"
    }
  ],
  "lastUpdated": "2026-03-24"
}
```

- `figmaNodeId`: Figma node ID for direct fetch. `null` means search by frame name.
- Update this file when new screens are added or Figma frames are renamed.

---

## Styling System Context

We are migrating from legacy `theme.ts` (StyleSheet.create) to **Uniwind** (Tailwind CSS v4 for React Native) + **HeroUI Native** (component library).

| System | Status | Where You'll See It |
|--------|--------|-------------------|
| **Uniwind** (Tailwind classes via `className=`) | New standard | Newer screens |
| **theme.ts** (`@/utils/theme`) | Legacy — being phased out | Older screens |
| **Inline styles** (`style={{}}`) | Should not exist | Scattered across ~179 files |

**Figma is the source of truth.** The correct flow is: **Figma → Uniwind config → HeroUI Native components → code**

### Design Tokens (from Figma Style Guide)

| Token | Value |
|-------|-------|
| Primary Red | `#D9071C` |
| Primary Font | Plus Jakarta Sans |
| Mono Font | Space Mono |
| Background | White / Light Gray (NOT the warm cream `#FFFBF5` in legacy theme.ts) |
| Spacing Scale | 4px base (4, 8, 12, 16, 20, 24, 32, 48, 64) |
| Border Radii | xs:4, sm:8, md:12, lg:16, xl:24, full:9999 |

---

## How to Read Figma (via Framelink MCP)

You have access to Figma through the Framelink MCP server (`figma-developer-mcp`). Use it to:

1. **Fetch a specific frame** — use a Figma file URL or node ID from `figma-component-map.json` to get layout data, colors, fonts, spacing
2. **Extract design tokens** — read the Style Guide page for typography, color palette, spacing

**Important:** You can only fetch frames you have a URL or node ID for. If a file has no mapping in `figma-component-map.json`, mark it as "unmapped" and log it for manual mapping — do not attempt to search Figma by guessing component names.

When comparing Figma to code, focus on:
- Background color (should be white/light gray, not warm cream)
- Font family (Plus Jakarta Sans, not system default)
- Primary red (#D9071C, not #DC2626 or other reds)
- Spacing and border radius values
- Layout direction (flex row vs column)

---

## Mode A: PR Design Check

When reviewing a PR that touches screen or component files:

1. **Check the PR diff** for which UI files changed (`app/**/*.tsx`, `components/**/*.tsx`)
2. **Look up each file** in `figma-component-map.json` to find the Figma frame URL or node ID. If no mapping exists, mark the file as "unmapped" and include it in the PR comment for manual mapping — do not skip it silently.
3. **Fetch the mapped Figma frame** via Framelink MCP using the URL or node ID from the component map
4. **Compare** the code's styling (Uniwind classes, inline styles, theme.ts values) against Figma
5. **Post a PR comment** listing:
   - Which screens were checked and their Figma frame match
   - Any design drift found (with file, line, Figma value vs code value)
   - Any files with no Figma mapping
   - Whether the file uses Uniwind (good) or legacy theme.ts/inline styles (flag it)

Severity:
- **Error:** Wrong font family, wrong layout direction
- **Warn:** Wrong color, spacing off by 4px+, inline styles, theme.ts import in new code
- **Info:** Spacing off by 1-2px, hardcoded hex that matches the correct value

Never block a PR — only flag issues. Let the dev decide.

---

## Mode B: Full Component Inventory

Run weekly or on request. This answers: **"What percentage of our Figma screens are built? What's remaining?"**

1. **Scan the codebase** — list all screen files under `app/` and `components/`
2. **Cross-reference** against `figma-component-map.json`:
   - **Built and mapped:** code file exists AND has a Figma mapping ✅
   - **Built but unmapped:** code file exists but no Figma mapping ⚠️
   - **Not built:** Figma frame exists in the component map but code file is missing or empty ❌
   - **Stale:** mapping points to a deleted code file 🗑️
3. **Check styling system** for each file:
   - Uses Uniwind only → ✅ migrated
   - Uses theme.ts → ⚠️ legacy
   - Uses inline styles → ⚠️ needs cleanup
   - Mixed → ⚠️ partial migration
4. **Generate a report** with:
   - Build coverage: X/Y Figma screens implemented (N%)
   - Remaining screens: list of Figma frames with no code
   - Styling migration progress: Uniwind vs theme.ts vs inline
   - Top drift issues found
5. **Save report** to `marty/reports/design-inventory-YYYY-MM-DD.md`
6. **Post summary** to `#martydev` Slack and DM Jake

---

## Known Design Drift

These are known issues as of March 2026:

| Issue | Figma (Correct) | Code (Wrong) | Impact |
|-------|-----------------|-------------|--------|
| Background color | White / Light Gray | `#FFFBF5` warm cream in theme.ts | Affects all screens using theme.ts |
| Hardcoded reds | `#D9071C` | Some files use `#DC2626` or other reds | Scattered across components |
| Inline styles | N/A | ~179 files bypass design system | Drift risk — no centralized control |
| Mixed styling | Uniwind should be standard | Some screens use theme.ts, others Uniwind | Inconsistent look and feel |
| Brand remnants | "Tryps" | Some "Vamos" references remain | Low priority but should clean up |

---

## Rules

- **Figma is always right.** If code doesn't match Figma, the code is wrong (unless the dev explicitly confirmed with Krishna)
- **Never modify code yourself** — only report findings. Devs fix their own screens.
- **Always reference the Figma frame name** so devs can find it: "Figma: Onboarding : Phone Number"
- **Update the component map** when you discover new mappings during inventory
- **Flag legacy styling** (theme.ts, inline) as migration candidates, not errors
