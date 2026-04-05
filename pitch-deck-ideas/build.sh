#!/bin/bash
# Tryps Pitch Deck Builder
# Usage:
#   ./build.sh          — build all formats (HTML, PDF, editable PPTX)
#   ./build.sh watch     — live preview with auto-reload
#   ./build.sh html      — HTML only
#   ./build.sh pdf       — PDF only
#   ./build.sh pptx      — editable PPTX via pandoc

set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
SLIDES_DIR="$DIR/slides"
THEME="$DIR/theme/tryps.css"
OUT_DIR="$DIR/output"
COMBINED="/tmp/tryps-deck-combined.md"

mkdir -p "$OUT_DIR"

# Concatenate all slide files in order with proper separator
build_combined() {
  # Start with Marp frontmatter
  cat > "$COMBINED" << 'FRONTMATTER'
---
marp: true
theme: tryps
paginate: true
size: 16:9
---

FRONTMATTER

  # Append each slide file, ensuring --- between files
  first=true
  for f in "$SLIDES_DIR"/*.md; do
    if [ "$first" = true ]; then
      first=false
    else
      printf "\n---\n\n" >> "$COMBINED"
    fi
    cat "$f" >> "$COMBINED"
  done

  echo "Combined $(ls "$SLIDES_DIR"/*.md | wc -l | tr -d ' ') slide files → $COMBINED"
}

build_html() {
  build_combined
  marp "$COMBINED" --theme "$THEME" --html -o "$OUT_DIR/tryps-deck.html"
  echo "✓ HTML → $OUT_DIR/tryps-deck.html"
}

build_pdf() {
  build_combined
  marp "$COMBINED" --theme "$THEME" --html --pdf -o "$OUT_DIR/tryps-deck.pdf"
  echo "✓ PDF  → $OUT_DIR/tryps-deck.pdf"
}

build_pptx() {
  # Use pandoc for real editable PPTX
  local ref_doc="$DIR/tryps-template.pptx"
  if [ -f "$ref_doc" ]; then
    pandoc "$SLIDES_DIR"/*.md --reference-doc="$ref_doc" --slide-level=2 -o "$OUT_DIR/tryps-deck.pptx"
  else
    pandoc "$SLIDES_DIR"/*.md --slide-level=2 -o "$OUT_DIR/tryps-deck.pptx"
    echo "  (tip: create tryps-template.pptx for branded PPTX output)"
  fi
  echo "✓ PPTX → $OUT_DIR/tryps-deck.pptx (editable via pandoc)"
}

watch_mode() {
  build_combined
  echo "Starting live preview... (Ctrl+C to stop)"
  marp "$COMBINED" --theme "$THEME" --html -w -o "$OUT_DIR/tryps-deck.html"
}

case "${1:-all}" in
  watch)  watch_mode ;;
  html)   build_html ;;
  pdf)    build_pdf ;;
  pptx)   build_pptx ;;
  all)
    build_html
    build_pdf
    build_pptx
    echo ""
    echo "All formats built in $OUT_DIR/"
    ls -lh "$OUT_DIR"/tryps-deck.*
    ;;
  *)
    echo "Usage: $0 [watch|html|pdf|pptx|all]"
    exit 1
    ;;
esac
