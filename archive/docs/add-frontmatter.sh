#!/bin/bash
# Add standardized frontmatter to all spec.md files
# Run from tryps-docs root

set -e

add_frontmatter() {
  local file="$1" id="$2" title="$3" phase="$4" assignee="$5" priority="$6" blocked="$7" blocked_reason="$8"
  local deps="${9:-[]}"

  # Count criteria from checkbox lines
  local total=$(grep -cE '^\s*- \[(x| )\]' "$file" 2>/dev/null || echo 0)
  local done=$(grep -cE '^\s*- \[x\]' "$file" 2>/dev/null || echo 0)

  # Strip existing frontmatter (between --- and ---)
  local has_fm=$(head -1 "$file" | grep -c '^---' || true)
  if [ "$has_fm" -gt 0 ]; then
    # Remove old frontmatter
    local end_line=$(tail -n +2 "$file" | grep -n '^---' | head -1 | cut -d: -f1)
    if [ -n "$end_line" ]; then
      end_line=$((end_line + 1))
      local body=$(tail -n +$((end_line + 1)) "$file")
    else
      local body=$(cat "$file")
    fi
  else
    local body=$(cat "$file")
  fi

  # Write new frontmatter + body
  cat > "$file" << FRONTMATTER
---
id: ${id}
title: "${title}"
phase: ${phase}
status: not-started
assignee: ${assignee}
priority: ${priority}
dependencies: ${deps}
blocked: ${blocked}
blocked_reason: "${blocked_reason}"
---
FRONTMATTER

  echo "$body" >> "$file"
  echo "  Updated: $file (criteria: $total total, $done done)"
}

cd "$(dirname "$0")"

echo "Adding standardized frontmatter to all spec.md files..."
echo

# P1
add_frontmatter "scopes/p1/core-flows/spec.md"            "p1-core-flows"            "Core Flows"              p1 asif       1 false ""
add_frontmatter "scopes/p1/tooltips-teaching/spec.md"      "p1-tooltips-teaching"     "Tooltips & Teaching"     p1 unassigned 2 false ""
add_frontmatter "scopes/p1/notifications-voting/spec.md"   "p1-notifications-voting"  "Notifications & Voting"  p1 nadeem     3 false ""
add_frontmatter "scopes/p1/post-trip-review/spec.md"       "p1-post-trip-review"      "Post-Trip Review"        p1 unassigned 4 false ""
add_frontmatter "scopes/p1/travel-dna/spec.md"             "p1-travel-dna"            "Travel DNA"              p1 arslan     5 false ""
add_frontmatter "scopes/p1/recommendations/spec.md"        "p1-recommendations"       "Recommendations"         p1 unassigned 6 false ""
add_frontmatter "scopes/p1/claude-connector/spec.md"       "p1-claude-connector"      "Claude Connector"        p1 krisna     7 false ""

# P2
add_frontmatter "scopes/p2/linq-imessage/spec.md"          "p2-linq-imessage"         "iMessage via Linq"       p2 krisna     1 false "" "[p1-claude-connector]"
add_frontmatter "scopes/p2/stripe-payments/spec.md"        "p2-stripe-payments"       "Stripe Payments"         p2 unassigned 2 false "" "[p2-connectors]"
add_frontmatter "scopes/p2/booking-links/spec.md"          "p2-booking-links"         "Booking Links"           p2 unassigned 3 false ""
add_frontmatter "scopes/p2/connectors/spec.md"             "p2-connectors"            "Travel Life Connectors"  p2 arslan     4 false "" "[p1-travel-dna]"

# P3 — all blocked
add_frontmatter "scopes/p3/vote-on-behalf/spec.md"         "p3-vote-on-behalf"        "Vote on My Behalf"       p3 unassigned 1 true "P3 dev slot open — waiting on hire"
add_frontmatter "scopes/p3/pay-on-behalf/spec.md"          "p3-pay-on-behalf"         "Pay on My Behalf"        p3 unassigned 2 true "P3 dev slot open — waiting on hire"
add_frontmatter "scopes/p3/duffel-apis/spec.md"            "p3-duffel-apis"           "Duffel APIs"             p3 unassigned 3 true "P3 dev slot open — waiting on hire"
add_frontmatter "scopes/p3/logistics-agent/spec.md"        "p3-logistics-agent"       "Logistics Agent"         p3 unassigned 4 true "P3 dev slot open — waiting on hire"

# P4
add_frontmatter "scopes/p4/socials-presence/spec.md"       "p4-socials-presence"      "Socials & Presence"      p4 jake       1 false ""
add_frontmatter "scopes/p4/wispr-playbook/spec.md"         "p4-wispr-playbook"        "Wispr Flow Playbook"     p4 jake       2 false ""
add_frontmatter "scopes/p4/referral-incentives/spec.md"    "p4-referral-incentives"   "Referral Incentives"     p4 unassigned 3 false ""
add_frontmatter "scopes/p4/giveaways/spec.md"              "p4-giveaways"             "Giveaways"               p4 unassigned 4 false ""
add_frontmatter "scopes/p4/launch-video/spec.md"           "p4-launch-video"          "Launch Video"            p4 jake       5 false ""

# P5
add_frontmatter "scopes/p5/friends-family/spec.md"         "p5-friends-family"        "Friends & Family Testing" p5 unassigned 1 false ""
add_frontmatter "scopes/p5/strangers-review/spec.md"       "p5-strangers-review"      "Strangers Review"         p5 unassigned 2 false ""

echo
echo "Done! All 22 spec.md files have standardized frontmatter."
