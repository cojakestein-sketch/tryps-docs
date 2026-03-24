---
name: design-audit
description: Compare code against Figma designs — PR-level checks and full component inventory
user-invocable: true
---

# Design Audit

Two modes: **PR Design Check** (runs per-PR) and **Full Component Inventory** (runs weekly).

Requires: Framelink Figma MCP server (`figma-developer-mcp`) with a Figma PAT.

---

## Mode A: PR Design Check

**Trigger:** Marty reviews a PR that touches screen or component files.

### Steps

1. **Identify changed screens:**
   - Read the PR diff. Extract file paths that match `app/**/*.tsx` or `components/**/*.tsx`.
   - Filter to files that render UI (skip utils, hooks, types, contexts).

2. **Look up Figma mapping:**
   - Read `marty/skills/design-audit/figma-component-map.json`.
   - For each changed file, find the matching Figma page, frame name, and node ID.
   - If no mapping found, search Figma via Framelink MCP by component/screen name as fallback.
   - If still no match, note it as "unmapped" in the report.

3. **Fetch Figma design tokens:**
   - Use Framelink MCP to fetch the mapped Figma frame.
   - Extract: colors, font family, font size, font weight, spacing (padding/margin/gap), border radius, layout direction, background color.

4. **Compare against code:**
   - Read the changed file's Uniwind/Tailwind classes and any inline styles.
   - Check each token against Figma:

   | Token | What to Check |
   |-------|--------------|
   | Colors | Background, text, border colors match Figma hex values |
   | Typography | Font family (Plus Jakarta Sans), size, weight match |
   | Spacing | Padding, margin, gap values match Figma spacing |
   | Border radius | Corner radius values match |
   | Layout | Flex direction, alignment, justify match Figma auto-layout |

5. **Report findings as PR comment:**

   ```
   ## Design Audit — [PR Title]

   ### Screens Checked
   - `app/(tabs)/explore.tsx` → Figma: "Explore : Home" ✅ Match
   - `components/home/MainTripCard.tsx` → Figma: "Trips Menu : Trip Card" ⚠️ 2 issues

   ### Issues Found
   1. **MainTripCard.tsx:42** — Background `#FFFBF5` should be `#FFFFFF` per Figma
   2. **MainTripCard.tsx:67** — Border radius `12` should be `16` per Figma

   ### Unmapped Files
   - `components/home/ThumbnailStrip.tsx` — no Figma mapping found

   ### Summary
   2 design drift issues found. 1 file unmapped.
   ```

6. **Severity rules:**
   - Color mismatch: **warn** (flag but don't block)
   - Font family wrong: **error** (must fix)
   - Spacing off by 1-2px: **info** (note only)
   - Spacing off by 4px+: **warn**
   - Layout direction wrong: **error**
   - Inline styles used instead of Uniwind: **warn**

---

## Mode B: Full Component Inventory

**Trigger:** Weekly (suggested: Monday morning), or manually via "run design inventory".

### Steps

1. **Scan all screen files:**
   - Glob `app/**/*.tsx` and `components/**/*.tsx` in the codebase.
   - Build a list of all screen and component files.

2. **Load component map:**
   - Read `marty/skills/design-audit/figma-component-map.json`.
   - Identify: mapped files, unmapped files, stale mappings (Figma frame changed/deleted).

3. **For each mapped file, audit design tokens:**
   - Same token comparison as Mode A (colors, typography, spacing, radii, layout).
   - Record drift per file.

4. **Check for styling system consistency:**
   - Flag files still using `theme.ts` imports (legacy — should migrate to Uniwind).
   - Flag files with inline `style={{}}` props (should use Uniwind classes).
   - Flag hardcoded hex colors (should use Uniwind tokens or CSS variables).
   - Count files per styling system: Uniwind vs theme.ts vs inline vs mixed.

5. **Generate inventory report:**

   ```
   ## Design Inventory — Week of [Date]

   ### Coverage
   - Total screen/component files: 142
   - Mapped to Figma: 89 (63%)
   - Unmapped: 53 (37%)

   ### Styling System Migration
   - Uniwind only: 45 files (32%)
   - theme.ts only: 62 files (44%)
   - Mixed (both): 18 files (13%)
   - Inline styles only: 17 files (12%)

   ### Design Drift Summary
   - Color mismatches: 23 files
   - Typography mismatches: 8 files
   - Spacing mismatches: 15 files
   - Border radius mismatches: 6 files

   ### Top Priority Fixes
   1. Background color (#FFFBF5 → #FFFFFF): 34 files
   2. Hardcoded reds (various → #D9071C): 12 files
   3. Missing Plus Jakarta Sans: 5 files

   ### Newly Unmapped
   - [files added since last inventory with no Figma mapping]
   ```

6. **Post report:**
   - Post summary to `#martydev` Slack channel.
   - Save full report to `marty/reports/design-inventory-YYYY-MM-DD.md`.

---

## Component Map Format

The mapping file lives at `marty/skills/design-audit/figma-component-map.json`:

```json
{
  "mappings": [
    {
      "codePath": "app/(auth)/phone.tsx",
      "figmaPage": "Onboarding Flow 1",
      "figmaFrame": "Onboarding : Phone Number",
      "figmaNodeId": null,
      "notes": ""
    }
  ],
  "unmapped": [
    {
      "codePath": "components/home/ThumbnailStrip.tsx",
      "reason": "No Figma equivalent — code-only component"
    }
  ],
  "lastUpdated": "2026-03-24"
}
```

- `figmaNodeId`: Set to the Figma node ID if known (enables direct fetch). Set `null` to use frame name search.
- Update this file when new screens are added or Figma frames change.

---

## Dependencies

- **Framelink Figma MCP** (`figma-developer-mcp`): Required for fetching Figma design data
- **Figma PAT**: Stored in `secrets.env` as `FIGMA_PERSONAL_ACCESS_TOKEN`
- **figma-component-map.json**: Maintained manually, updated when screens are added
- **tryps-pr-review skill**: Mode A integrates into the existing PR review pipeline — design audit runs alongside convention checks
