#!/bin/sh
# Generate STATUS.md from spec.md frontmatter
# Run from tryps-docs root. Marty runs this after every git pull.
# Compatible with macOS sh (no bash 4+ required)

set -e
cd "$(dirname "$0")"

OUTPUT="STATUS.md"
NOW=$(date -u +"%Y-%m-%d %H:%M UTC")

# Parse YAML frontmatter value from a file
get_field() {
  sed -n '/^---$/,/^---$/p' "$1" | grep "^${2}:" | head -1 | sed "s/^${2}:[[:space:]]*//" | tr -d '"'
}

cat > "$OUTPUT" << HEADER
# Tryps Scope Tracker

> Auto-generated from spec.md frontmatter. Do not edit manually.
> Last updated: ${NOW}
> Run \`./generate-status.sh\` to refresh.

## All Scopes

| | ID | Title | Status | Assignee | Criteria | Blocked |
|---|-----|-------|--------|----------|----------|---------|
HEADER

for spec in scopes/p*/*/spec.md; do
  id=$(get_field "$spec" "id")
  title=$(get_field "$spec" "title")
  phase=$(get_field "$spec" "phase")
  status=$(get_field "$spec" "status")
  assignee=$(get_field "$spec" "assignee")
  blocked=$(get_field "$spec" "blocked")

  total=$(grep -cE '^\s*- \[(x| )\]' "$spec" 2>/dev/null | tr -d '[:space:]' || echo 0)
  done_count=$(grep -cE '^\s*- \[x\]' "$spec" 2>/dev/null | tr -d '[:space:]' || echo 0)
  [ -z "$total" ] && total=0
  [ -z "$done_count" ] && done_count=0

  if [ "$total" -eq 0 ]; then
    progress="NEEDS SPEC"
  else
    progress="${done_count}/${total}"
  fi

  block_display=""
  [ "$blocked" = "true" ] && block_display="BLOCKED"

  case "$status" in
    not-started)  icon="--" ;;
    in-progress)  icon="B" ;;
    ready-qa)     icon="QA" ;;
    failing)      icon="FAIL" ;;
    done)         icon="DONE" ;;
    *)            icon="?" ;;
  esac

  echo "| ${icon} | ${id} | ${title} | ${status} | ${assignee} | ${progress} | ${block_display} |" >> "$OUTPUT"
done

cat >> "$OUTPUT" << DIVIDER

---

## Success Criteria Detail

Scopes with testable criteria. Review daily in standup.

DIVIDER

for spec in scopes/p*/*/spec.md; do
  total=$(grep -cE '^\s*- \[(x| )\]' "$spec" 2>/dev/null | tr -d '[:space:]' || echo 0)
  [ -z "$total" ] && total=0
  [ "$total" -eq 0 ] && continue

  id=$(get_field "$spec" "id")
  title=$(get_field "$spec" "title")
  assignee=$(get_field "$spec" "assignee")
  done_count=$(grep -cE '^\s*- \[x\]' "$spec" 2>/dev/null | tr -d '[:space:]' || echo 0)
  [ -z "$done_count" ] && done_count=0

  echo "### ${title} (${id}) — ${assignee} — ${done_count}/${total}" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
  grep -E '^\s*- \[(x| )\]' "$spec" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
done

echo "STATUS.md generated ($(date -u +%H:%M))"
