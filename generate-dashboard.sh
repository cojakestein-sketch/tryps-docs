#!/bin/sh
# Generate tracker/index.html from spec.md frontmatter and criteria
# Run from tryps-docs root. Produces a static HTML dashboard for GitHub Pages.
# Compatible with macOS sh (no bash 4+ required)

set -e
cd "$(dirname "$0")"

OUTPUT="tracker/index.html"
NOW=$(date -u +"%Y-%m-%d %H:%M UTC")
NOW_DISPLAY=$(date +"%b %d, %Y — %I:%M %p")

mkdir -p tracker

# Parse YAML frontmatter value from a file
get_field() {
  sed -n '/^---$/,/^---$/p' "$1" | grep "^${2}:" | head -1 | sed "s/^${2}:[[:space:]]*//" | tr -d '"'
}

# Phase labels
phase_label() {
  case "$1" in
    p1) echo "Phase 1: Core App" ;;
    p2) echo "Phase 2: Connectors & Payments" ;;
    p3) echo "Phase 3: Agent Intelligence" ;;
    p4) echo "Phase 4: Brand & GTM" ;;
    p5) echo "Phase 5: V2 Beta Testing" ;;
    *)  echo "Phase: $1" ;;
  esac
}

# Phase lead
phase_lead() {
  case "$1" in
    p1) echo "Nadim" ;;
    p2) echo "Asif" ;;
    p3) echo "TBD (hiring)" ;;
    p4) echo "Jake" ;;
    p5) echo "Team" ;;
    *)  echo "" ;;
  esac
}

# Count scopes by status
count_not_started=0
count_in_progress=0
count_ready_qa=0
count_failing=0
count_done=0
count_blocked=0
count_total=0

for spec in scopes/p*/*/spec.md; do
  status=$(get_field "$spec" "status")
  blocked=$(get_field "$spec" "blocked")
  count_total=$((count_total + 1))
  if [ "$blocked" = "true" ]; then
    count_blocked=$((count_blocked + 1))
  else
    case "$status" in
      not-started)  count_not_started=$((count_not_started + 1)) ;;
      in-progress)  count_in_progress=$((count_in_progress + 1)) ;;
      ready-qa)     count_ready_qa=$((count_ready_qa + 1)) ;;
      failing)      count_failing=$((count_failing + 1)) ;;
      done)         count_done=$((count_done + 1)) ;;
      *)            count_not_started=$((count_not_started + 1)) ;;
    esac
  fi
done

# Calculate overall progress bar widths
pct_not_started=0
pct_in_progress=0
pct_ready_qa=0
pct_failing=0
pct_done=0
pct_blocked=0
if [ "$count_total" -gt 0 ]; then
  # Use awk for floating point
  pct_not_started=$(echo "$count_not_started $count_total" | awk '{printf "%.1f", ($1/$2)*100}')
  pct_in_progress=$(echo "$count_in_progress $count_total" | awk '{printf "%.1f", ($1/$2)*100}')
  pct_ready_qa=$(echo "$count_ready_qa $count_total" | awk '{printf "%.1f", ($1/$2)*100}')
  pct_failing=$(echo "$count_failing $count_total" | awk '{printf "%.1f", ($1/$2)*100}')
  pct_done=$(echo "$count_done $count_total" | awk '{printf "%.1f", ($1/$2)*100}')
  pct_blocked=$(echo "$count_blocked $count_total" | awk '{printf "%.1f", ($1/$2)*100}')
fi

# Start writing HTML
cat > "$OUTPUT" << 'HTMLHEAD'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tryps Scope Tracker</title>
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    background: #f5f7fa;
    color: #1a1a2e;
    padding: 32px;
    max-width: 1200px;
    margin: 0 auto;
  }

  .header {
    background: #1a1a2e;
    color: #fff;
    padding: 24px 32px;
    border-radius: 16px;
    margin-bottom: 24px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 8px;
  }
  .header h1 { font-size: 22px; font-weight: 700; letter-spacing: -0.3px; }
  .header .date { font-size: 13px; color: #94a3b8; }

  .summary-bar {
    display: flex;
    gap: 12px;
    margin-bottom: 24px;
    flex-wrap: wrap;
  }
  .summary-card {
    background: #fff;
    border-radius: 12px;
    padding: 14px 20px;
    flex: 1;
    min-width: 90px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.06);
    text-align: center;
  }
  .summary-card .number {
    font-size: 28px;
    font-weight: 700;
    line-height: 1;
  }
  .summary-card .label {
    font-size: 10px;
    color: #888;
    margin-top: 4px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }
  .summary-card.total .number { color: #1a1a2e; }
  .summary-card.not-started .number { color: #94a3b8; }
  .summary-card.in-progress .number { color: #f59e0b; }
  .summary-card.ready-qa .number { color: #3b82f6; }
  .summary-card.failing .number { color: #ef4444; }
  .summary-card.done .number { color: #22c55e; }
  .summary-card.blocked .number { color: #94a3b8; }

  .progress-bar-container {
    margin-bottom: 24px;
    background: #fff;
    border-radius: 12px;
    padding: 20px 24px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.06);
  }
  .progress-bar-label {
    font-size: 13px;
    font-weight: 600;
    color: #555;
    margin-bottom: 8px;
  }
  .progress-bar {
    display: flex;
    height: 28px;
    border-radius: 8px;
    overflow: hidden;
    background: #f1f5f9;
  }
  .progress-bar .segment {
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 11px;
    font-weight: 700;
    color: #fff;
    transition: width 0.3s ease;
    min-width: 0;
  }
  .progress-bar .segment.done { background: #22c55e; }
  .progress-bar .segment.in-progress { background: #f59e0b; }
  .progress-bar .segment.ready-qa { background: #3b82f6; }
  .progress-bar .segment.failing { background: #ef4444; }
  .progress-bar .segment.blocked { background: #94a3b8; }
  .progress-bar .segment.not-started { background: #e2e8f0; color: #94a3b8; }

  .legend {
    display: flex;
    gap: 20px;
    margin-bottom: 24px;
    font-size: 13px;
    color: #666;
    flex-wrap: wrap;
  }
  .legend-item { display: flex; align-items: center; gap: 6px; }
  .legend-dot {
    width: 12px; height: 12px; border-radius: 3px;
  }
  .legend-dot.not-started { background: #e2e8f0; }
  .legend-dot.in-progress { background: #f59e0b; }
  .legend-dot.ready-qa { background: #3b82f6; }
  .legend-dot.failing { background: #ef4444; }
  .legend-dot.done { background: #22c55e; }
  .legend-dot.blocked { background: #94a3b8; }

  .phase-section {
    margin-bottom: 28px;
  }
  .phase-header {
    font-size: 16px;
    font-weight: 700;
    color: #1a1a2e;
    margin-bottom: 12px;
    padding-left: 4px;
    display: flex;
    align-items: center;
    gap: 10px;
  }
  .phase-lead {
    font-size: 12px;
    font-weight: 500;
    color: #94a3b8;
    text-transform: uppercase;
    letter-spacing: 0.3px;
  }

  table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    background: #fff;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 1px 3px rgba(0,0,0,0.06);
    margin-bottom: 4px;
  }
  thead th {
    background: #1a1a2e;
    color: #fff;
    font-size: 11px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    padding: 10px 12px;
    text-align: left;
  }
  thead th:first-child { padding-left: 16px; }
  tbody td {
    padding: 12px 12px;
    font-size: 13px;
    border-bottom: 1px solid #f0f0f5;
    vertical-align: middle;
  }
  tbody td:first-child { padding-left: 16px; }
  tbody tr:last-child td { border-bottom: none; }
  tbody tr:hover { background: #fafbfd; }
  tbody tr.is-blocked { opacity: 0.55; }
  tbody tr.is-blocked .scope-name { text-decoration: line-through; }

  .scope-name { font-weight: 600; }
  .assignee { color: #666; font-size: 12px; }

  .pill {
    display: inline-block;
    padding: 3px 10px;
    border-radius: 999px;
    font-size: 11px;
    font-weight: 600;
    white-space: nowrap;
  }
  .pill.not-started { background: #f1f5f9; color: #94a3b8; }
  .pill.in-progress { background: #fef3c7; color: #92400e; }
  .pill.ready-qa { background: #dbeafe; color: #1e40af; }
  .pill.failing { background: #fee2e2; color: #991b1b; }
  .pill.done { background: #dcfce7; color: #166534; }
  .pill.blocked { background: #f1f5f9; color: #94a3b8; border: 1px dashed #94a3b8; }

  .criteria-col {
    font-size: 12px;
    font-weight: 600;
    color: #555;
    white-space: nowrap;
  }
  .criteria-col.needs-spec { color: #94a3b8; font-style: italic; font-weight: 400; }

  .mini-bar {
    display: flex;
    height: 6px;
    border-radius: 3px;
    overflow: hidden;
    background: #f1f5f9;
    min-width: 60px;
    max-width: 120px;
    margin-top: 4px;
  }
  .mini-bar .fill {
    background: #22c55e;
    border-radius: 3px 0 0 3px;
    transition: width 0.3s ease;
  }

  .notes-col {
    font-size: 12px;
    color: #888;
    max-width: 200px;
  }

  /* Criteria detail sections */
  .criteria-detail {
    margin-bottom: 24px;
  }
  .criteria-detail details {
    background: #fff;
    border-radius: 10px;
    margin-bottom: 6px;
    box-shadow: 0 1px 2px rgba(0,0,0,0.04);
    overflow: hidden;
  }
  .criteria-detail summary {
    padding: 12px 16px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    color: #1a1a2e;
    display: flex;
    align-items: center;
    gap: 10px;
    user-select: none;
    list-style: none;
  }
  .criteria-detail summary::-webkit-details-marker { display: none; }
  .criteria-detail summary::before {
    content: "\25B6";
    font-size: 10px;
    color: #94a3b8;
    transition: transform 0.2s ease;
  }
  .criteria-detail details[open] summary::before {
    transform: rotate(90deg);
  }
  .criteria-detail .summary-meta {
    font-size: 12px;
    font-weight: 400;
    color: #94a3b8;
    margin-left: auto;
  }
  .criteria-detail .criteria-list {
    padding: 0 16px 16px 16px;
    border-top: 1px solid #f0f0f5;
  }
  .criteria-item {
    display: flex;
    align-items: flex-start;
    gap: 8px;
    padding: 8px 0;
    font-size: 13px;
    line-height: 1.5;
    border-bottom: 1px solid #f8f9fb;
  }
  .criteria-item:last-child { border-bottom: none; }
  .criteria-check {
    flex-shrink: 0;
    width: 18px;
    height: 18px;
    border-radius: 4px;
    border: 2px solid #d1d5db;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-top: 2px;
    font-size: 12px;
  }
  .criteria-check.checked {
    background: #22c55e;
    border-color: #22c55e;
    color: #fff;
  }
  .criteria-check.unchecked {
    background: #fff;
    border-color: #d1d5db;
  }
  .criteria-text { color: #444; }
  .criteria-text.is-done { color: #94a3b8; text-decoration: line-through; }
  .criteria-text code {
    background: #f1f5f9;
    padding: 1px 5px;
    border-radius: 4px;
    font-size: 12px;
    font-family: 'SF Mono', Menlo, monospace;
  }
  .criteria-text strong { font-weight: 600; color: #1a1a2e; }

  .section-title {
    font-size: 18px;
    font-weight: 700;
    color: #1a1a2e;
    margin-top: 40px;
    margin-bottom: 16px;
    padding-left: 4px;
  }

  .footer {
    margin-top: 32px;
    font-size: 12px;
    color: #aaa;
    text-align: center;
    padding: 16px 0;
  }

  @media (max-width: 768px) {
    body { padding: 12px; }
    .header { padding: 16px 20px; border-radius: 12px; }
    .header h1 { font-size: 18px; }
    .summary-bar { gap: 8px; }
    .summary-card { min-width: 65px; padding: 10px 8px; }
    .summary-card .number { font-size: 22px; }
    .summary-card .label { font-size: 9px; }
    table { font-size: 12px; }
    thead th, tbody td { padding: 8px 6px; }
    thead th:first-child, tbody td:first-child { padding-left: 10px; }
    .pill { font-size: 10px; padding: 2px 8px; }
    .notes-col { max-width: 100px; }
    .criteria-detail summary { font-size: 13px; padding: 10px 12px; }
    .criteria-item { font-size: 12px; }
    .phase-header { font-size: 15px; }
  }

  @media (max-width: 480px) {
    .summary-bar { display: grid; grid-template-columns: repeat(3, 1fr); }
    .notes-col { display: none; }
    .mini-bar { max-width: 80px; }
  }
</style>
</head>
<body>
HTMLHEAD

# Header
cat >> "$OUTPUT" << HEADER_END
<div class="header">
  <h1>Tryps Scope Tracker</h1>
  <span class="date">Updated: ${NOW_DISPLAY}</span>
</div>
HEADER_END

# Summary cards
cat >> "$OUTPUT" << SUMMARY_END
<div class="summary-bar">
  <div class="summary-card total">
    <div class="number">${count_total}</div>
    <div class="label">Total Scopes</div>
  </div>
  <div class="summary-card not-started">
    <div class="number">${count_not_started}</div>
    <div class="label">Not Started</div>
  </div>
  <div class="summary-card in-progress">
    <div class="number">${count_in_progress}</div>
    <div class="label">Building</div>
  </div>
  <div class="summary-card ready-qa">
    <div class="number">${count_ready_qa}</div>
    <div class="label">In QA</div>
  </div>
  <div class="summary-card failing">
    <div class="number">${count_failing}</div>
    <div class="label">Failing</div>
  </div>
  <div class="summary-card done">
    <div class="number">${count_done}</div>
    <div class="label">Done</div>
  </div>
  <div class="summary-card blocked">
    <div class="number">${count_blocked}</div>
    <div class="label">Blocked</div>
  </div>
</div>
SUMMARY_END

# Overall progress bar
cat >> "$OUTPUT" << PROGRESS_END
<div class="progress-bar-container">
  <div class="progress-bar-label">Overall Pipeline — ${count_total} scopes</div>
  <div class="progress-bar">
PROGRESS_END

# Only render segments that have non-zero width
for seg_name in done in-progress ready-qa failing blocked not-started; do
  case "$seg_name" in
    done)         seg_count=$count_done;        seg_pct=$pct_done ;;
    in-progress)  seg_count=$count_in_progress;  seg_pct=$pct_in_progress ;;
    ready-qa)     seg_count=$count_ready_qa;     seg_pct=$pct_ready_qa ;;
    failing)      seg_count=$count_failing;      seg_pct=$pct_failing ;;
    blocked)      seg_count=$count_blocked;      seg_pct=$pct_blocked ;;
    not-started)  seg_count=$count_not_started;  seg_pct=$pct_not_started ;;
  esac
  is_zero=$(echo "$seg_pct" | awk '{print ($1 == 0) ? "yes" : "no"}')
  if [ "$is_zero" = "no" ]; then
    echo "    <div class=\"segment ${seg_name}\" style=\"width: ${seg_pct}%;\">${seg_count}</div>" >> "$OUTPUT"
  fi
done

cat >> "$OUTPUT" << 'PROGRESS_END2'
  </div>
</div>
PROGRESS_END2

# Legend
cat >> "$OUTPUT" << 'LEGEND_END'
<div class="legend">
  <div class="legend-item"><div class="legend-dot not-started"></div> Not Started</div>
  <div class="legend-item"><div class="legend-dot in-progress"></div> Building</div>
  <div class="legend-item"><div class="legend-dot ready-qa"></div> In QA</div>
  <div class="legend-item"><div class="legend-dot failing"></div> Failing</div>
  <div class="legend-item"><div class="legend-dot done"></div> Done</div>
  <div class="legend-item"><div class="legend-dot blocked"></div> Blocked</div>
</div>
LEGEND_END

# Phase sections with tables
for phase in p1 p2 p3 p4 p5; do
  plabel=$(phase_label "$phase")
  plead=$(phase_lead "$phase")

  cat >> "$OUTPUT" << PHASE_HDR
<div class="phase-section">
  <div class="phase-header">${plabel} <span class="phase-lead">${plead}</span></div>
  <table>
    <thead>
      <tr>
        <th>Status</th>
        <th>Scope</th>
        <th>Assignee</th>
        <th>Criteria</th>
        <th>Notes</th>
      </tr>
    </thead>
    <tbody>
PHASE_HDR

  # Sort specs by priority within this phase
  specs_in_phase=""
  for spec in scopes/${phase}/*/spec.md; do
    [ -f "$spec" ] || continue
    priority=$(get_field "$spec" "priority")
    [ -z "$priority" ] && priority=99
    specs_in_phase="${specs_in_phase}${priority}|${spec}
"
  done

  sorted_specs=$(echo "$specs_in_phase" | sort -t'|' -k1 -n)

  echo "$sorted_specs" | while IFS='|' read -r priority spec; do
    [ -z "$spec" ] && continue
    [ -f "$spec" ] || continue

    id=$(get_field "$spec" "id")
    title=$(get_field "$spec" "title")
    status=$(get_field "$spec" "status")
    assignee=$(get_field "$spec" "assignee")
    blocked=$(get_field "$spec" "blocked")
    blocked_reason=$(get_field "$spec" "blocked_reason")

    total=$(grep -cE '^\s*- \[(x| )\]' "$spec" 2>/dev/null | tr -d '[:space:]' || echo 0)
    done_count=$(grep -cE '^\s*- \[x\]' "$spec" 2>/dev/null | tr -d '[:space:]' || echo 0)
    [ -z "$total" ] && total=0
    [ -z "$done_count" ] && done_count=0

    # Status pill
    if [ "$blocked" = "true" ]; then
      pill_class="blocked"
      pill_text="Blocked"
      row_class="is-blocked"
    else
      pill_class="$status"
      row_class=""
      case "$status" in
        not-started)  pill_text="Not Started" ;;
        in-progress)  pill_text="Building" ;;
        ready-qa)     pill_text="In QA" ;;
        failing)      pill_text="Failing" ;;
        done)         pill_text="Done" ;;
        *)            pill_text="$status" ;;
      esac
    fi

    # Criteria display
    if [ "$total" -eq 0 ]; then
      criteria_html="<span class=\"criteria-col needs-spec\">needs spec</span>"
    else
      if [ "$total" -gt 0 ]; then
        fill_pct=$(echo "$done_count $total" | awk '{printf "%.0f", ($1/$2)*100}')
      else
        fill_pct=0
      fi
      criteria_html="<span class=\"criteria-col\">${done_count}/${total}</span><div class=\"mini-bar\"><div class=\"fill\" style=\"width: ${fill_pct}%;\"></div></div>"
    fi

    # Notes
    notes=""
    if [ "$blocked" = "true" ] && [ -n "$blocked_reason" ]; then
      notes="$blocked_reason"
    fi

    cat >> "$OUTPUT" << ROW_END
      <tr class="${row_class}">
        <td><span class="pill ${pill_class}">${pill_text}</span></td>
        <td class="scope-name">${title}</td>
        <td class="assignee">${assignee}</td>
        <td>${criteria_html}</td>
        <td class="notes-col">${notes}</td>
      </tr>
ROW_END
  done

  cat >> "$OUTPUT" << 'TABLE_END'
    </tbody>
  </table>
</div>
TABLE_END
done

# Criteria detail section
cat >> "$OUTPUT" << 'DETAIL_HDR'
<div class="section-title">Success Criteria Detail</div>
<div class="criteria-detail">
DETAIL_HDR

for spec in scopes/p*/*/spec.md; do
  total=$(grep -cE '^\s*- \[(x| )\]' "$spec" 2>/dev/null | tr -d '[:space:]' || echo 0)
  [ -z "$total" ] && total=0
  [ "$total" -eq 0 ] && continue

  id=$(get_field "$spec" "id")
  title=$(get_field "$spec" "title")
  assignee=$(get_field "$spec" "assignee")
  done_count=$(grep -cE '^\s*- \[x\]' "$spec" 2>/dev/null | tr -d '[:space:]' || echo 0)
  [ -z "$done_count" ] && done_count=0

  cat >> "$OUTPUT" << DETAIL_OPEN
<details>
  <summary>${title} <span class="summary-meta">${assignee} &mdash; ${done_count}/${total}</span></summary>
  <div class="criteria-list">
DETAIL_OPEN

  # Extract criteria lines and generate HTML
  grep -E '^\s*- \[(x| )\]' "$spec" | while IFS= read -r line; do
    # Check if done or not
    is_checked=$(echo "$line" | grep -c '\[x\]' || true)

    # Extract the text after the checkbox
    text=$(echo "$line" | sed 's/^[[:space:]]*- \[[x ]\][[:space:]]*//')
    # Escape HTML special chars, then convert markdown bold and inline code
    text=$(echo "$text" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')
    text=$(echo "$text" | sed 's/\*\*\([^*]*\)\*\*/<strong>\1<\/strong>/g')
    text=$(echo "$text" | sed 's/`\([^`]*\)`/<code>\1<\/code>/g')

    if [ "$is_checked" -gt 0 ]; then
      cat >> "$OUTPUT" << ITEM_DONE
    <div class="criteria-item">
      <div class="criteria-check checked">&#10003;</div>
      <div class="criteria-text is-done">${text}</div>
    </div>
ITEM_DONE
    else
      cat >> "$OUTPUT" << ITEM_TODO
    <div class="criteria-item">
      <div class="criteria-check unchecked"></div>
      <div class="criteria-text">${text}</div>
    </div>
ITEM_TODO
    fi
  done

  cat >> "$OUTPUT" << 'DETAIL_CLOSE'
  </div>
</details>
DETAIL_CLOSE
done

cat >> "$OUTPUT" << 'DETAIL_FOOTER'
</div>
DETAIL_FOOTER

# Footer
cat >> "$OUTPUT" << FOOTER_END
<div class="footer">
  Auto-generated from spec.md frontmatter &middot; ${count_total} scopes across 5 phases &middot; Last updated: ${NOW}
</div>

</body>
</html>
FOOTER_END

# Also copy to root for GitHub Pages
cp tracker/index.html index.html
echo "tracker/index.html + index.html generated ($(date -u +%H:%M))"
