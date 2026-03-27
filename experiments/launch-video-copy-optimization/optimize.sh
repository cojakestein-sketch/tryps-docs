#!/bin/bash
# Autoresearch: Launch Video Copy Optimization Loop
# Adapted from the Tryps agent prompt optimization loop.
#
# Usage:
#   ./optimize.sh hook              # Optimize hook.txt (default)
#   ./optimize.sh hook 30           # Run 30 experiments on hook
#   ./optimize.sh script 30         # Run 30 experiments on script
#   ./optimize.sh caption 30        # Run 30 experiments on caption
#
# Prerequisites:
#   - OPENAI_API_KEY in .env or environment
#   - python packages: openai (pip install openai)
#   - claude CLI installed

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# Load .env if it exists
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# Load from parent autoresearch .env as fallback
if [ -z "${OPENAI_API_KEY:-}" ] && [ -f "$HOME/autoresearch/.env" ]; then
    export $(grep -v '^#' "$HOME/autoresearch/.env" | xargs)
fi

# Check prerequisites
if [ -z "${OPENAI_API_KEY:-}" ]; then
    echo "ERROR: OPENAI_API_KEY not set. Add it to .env or export it."
    exit 1
fi

if ! command -v python3 &> /dev/null; then
    echo "ERROR: python3 not found"
    exit 1
fi

python3 -c "import openai" 2>/dev/null || {
    echo "Installing openai package..."
    pip install openai
}

# Parse arguments
ARTIFACT_TYPE=${1:-hook}
MAX_EXPERIMENTS=${2:-30}
MAX_CONSECUTIVE_REJECTS=5

export ARTIFACT_TYPE

ARTIFACT_FILE="${ARTIFACT_TYPE}.txt"

if [ ! -f "$ARTIFACT_FILE" ]; then
    echo "ERROR: $ARTIFACT_FILE not found."
    echo "Paste your baseline copy from the creative session into $ARTIFACT_FILE first."
    exit 1
fi

if [ ! -s "$ARTIFACT_FILE" ]; then
    echo "ERROR: $ARTIFACT_FILE is empty."
    echo "Paste your baseline copy from the creative session into $ARTIFACT_FILE first."
    exit 1
fi

EXPERIMENT=0
CONSECUTIVE_REJECTS=0

# Initialize results.tsv if it doesn't exist
if [ ! -f "results_${ARTIFACT_TYPE}.tsv" ]; then
    echo -e "experiment\tcommit\tscore\tgates\tlurker_veto\tstatus\tdescription" > "results_${ARTIFACT_TYPE}.tsv"
    echo "Initialized results_${ARTIFACT_TYPE}.tsv"
fi

# Ensure we're on an experiment branch
BRANCH=$(git branch --show-current 2>/dev/null || echo "none")
if [[ ! "$BRANCH" == experiment/* ]] && [[ ! "$BRANCH" == autoresearch/* ]]; then
    echo "Creating experiment branch..."
    git checkout -b "experiment/launch-copy-${ARTIFACT_TYPE}-$(date +%Y%m%d)"
fi

echo "============================================"
echo "AUTORESEARCH: Launch Video Copy Optimization"
echo "Artifact:     $ARTIFACT_TYPE ($ARTIFACT_FILE)"
echo "Branch:       $(git branch --show-current)"
echo "Judge model:  ${JUDGE_MODEL:-gpt-4.1}"
echo "Max experiments: $MAX_EXPERIMENTS"
echo "Stop after:   $MAX_CONSECUTIVE_REJECTS consecutive rejects"
echo "============================================"
echo ""
echo "Current copy:"
echo "  \"$(cat $ARTIFACT_FILE)\""
echo ""

# Run baseline
if [ ! -f last_eval.json ]; then
    echo "Running baseline eval..."
    python3 eval.py "$ARTIFACT_TYPE"
    BASELINE_SCORE=$(python3 -c "import json; d=json.load(open('last_eval.json')); print(d['final_score'])")
    BASELINE_GATES=$(python3 -c "import json; d=json.load(open('last_eval.json')); print(d['gates_passed'])")
    BASELINE_VETO=$(python3 -c "import json; d=json.load(open('last_eval.json')); print(d['lurker_veto'])")
    COMMIT=$(git rev-parse --short HEAD 2>/dev/null || echo "none")
    echo -e "0\t$COMMIT\t$BASELINE_SCORE\t$BASELINE_GATES\t$BASELINE_VETO\tbaseline\tInitial copy from creative session" >> "results_${ARTIFACT_TYPE}.tsv"
    echo ""
    echo "Baseline score: $BASELINE_SCORE (gates: $BASELINE_GATES, lurker veto: $BASELINE_VETO)"
    echo ""
fi

BEST_SCORE=$(python3 -c "import json; d=json.load(open('last_eval.json')); print(d['final_score'])")

echo "Starting optimization loop (best score: $BEST_SCORE)..."
echo "Press Ctrl+C to stop."
echo ""

while true; do
    EXPERIMENT=$((EXPERIMENT + 1))

    if [ "$EXPERIMENT" -gt "$MAX_EXPERIMENTS" ]; then
        echo "Reached max experiments ($MAX_EXPERIMENTS). Stopping."
        break
    fi

    if [ "$CONSECUTIVE_REJECTS" -ge "$MAX_CONSECUTIVE_REJECTS" ]; then
        echo "Hit $MAX_CONSECUTIVE_REJECTS consecutive rejects. Plateaued. Stopping."
        break
    fi

    echo "--- Experiment $EXPERIMENT (rejects streak: $CONSECUTIVE_REJECTS/$MAX_CONSECUTIVE_REJECTS) ---"

    # Save current copy for rollback
    cp "$ARTIFACT_FILE" "${ARTIFACT_FILE}.backup"

    # Let Claude Code make a modification
    claude --print "Read program.md and last_eval.json. This is experiment $EXPERIMENT for the $ARTIFACT_TYPE. The current best score is $BEST_SCORE. Consecutive rejects so far: $CONSECUTIVE_REJECTS. Analyze the weakest persona scores and dimensions in last_eval.json, make ONE targeted modification to $ARTIFACT_FILE to improve the score, and commit the change. Describe what you changed in the commit message." --allowedTools "Edit,Read,Write,Bash(git *)" 2>/dev/null || {
        echo "  Claude Code error, skipping experiment"
        cp "${ARTIFACT_FILE}.backup" "$ARTIFACT_FILE"
        continue
    }

    # Run eval
    echo "  Running eval..."
    python3 eval.py "$ARTIFACT_TYPE" 2>/dev/null || {
        echo "  Eval crashed, reverting"
        cp "${ARTIFACT_FILE}.backup" "$ARTIFACT_FILE"
        git checkout -- "$ARTIFACT_FILE" 2>/dev/null || true
        COMMIT=$(git rev-parse --short HEAD 2>/dev/null || echo "none")
        echo -e "$EXPERIMENT\t$COMMIT\t0\tFalse\tFalse\tcrash\tEval crashed" >> "results_${ARTIFACT_TYPE}.tsv"
        continue
    }

    # Read new score
    NEW_SCORE=$(python3 -c "import json; d=json.load(open('last_eval.json')); print(d['final_score'])")
    NEW_GATES=$(python3 -c "import json; d=json.load(open('last_eval.json')); print(d['gates_passed'])")
    NEW_VETO=$(python3 -c "import json; d=json.load(open('last_eval.json')); print(d['lurker_veto'])")
    NEW_COPY=$(python3 -c "import json; d=json.load(open('last_eval.json')); print(d['copy_text'])")
    COMMIT=$(git rev-parse --short HEAD 2>/dev/null || echo "none")

    # Compare
    KEEP=$(python3 -c "print('yes' if $NEW_SCORE > $BEST_SCORE else 'no')")

    if [ "$KEEP" = "yes" ]; then
        DELTA=$(python3 -c "print(round($NEW_SCORE - $BEST_SCORE, 1))")
        echo "  KEEP: $NEW_SCORE > $BEST_SCORE (+$DELTA)"
        echo "  New copy: \"$NEW_COPY\""
        BEST_SCORE=$NEW_SCORE
        CONSECUTIVE_REJECTS=0
        DESCRIPTION=$(git log -1 --pretty=%s 2>/dev/null || echo "improvement")
        echo -e "$EXPERIMENT\t$COMMIT\t$NEW_SCORE\t$NEW_GATES\t$NEW_VETO\tkeep\t$DESCRIPTION" >> "results_${ARTIFACT_TYPE}.tsv"
    else
        echo "  DISCARD: $NEW_SCORE <= $BEST_SCORE"
        CONSECUTIVE_REJECTS=$((CONSECUTIVE_REJECTS + 1))
        DESCRIPTION=$(git log -1 --pretty=%s 2>/dev/null || echo "no improvement")
        cp "${ARTIFACT_FILE}.backup" "$ARTIFACT_FILE"
        git checkout -- "$ARTIFACT_FILE" 2>/dev/null || true
        echo -e "$EXPERIMENT\t$COMMIT\t$NEW_SCORE\t$NEW_GATES\t$NEW_VETO\tdiscard\t$DESCRIPTION" >> "results_${ARTIFACT_TYPE}.tsv"
    fi

    rm -f "${ARTIFACT_FILE}.backup"
    echo ""
done

echo ""
echo "============================================"
echo "FINAL RESULTS — $ARTIFACT_TYPE"
echo "  Best score:      $BEST_SCORE"
echo "  Experiments run: $EXPERIMENT"
echo "  Final copy:      \"$(cat $ARTIFACT_FILE)\""
echo ""
echo "  Results log: results_${ARTIFACT_TYPE}.tsv"
echo "============================================"
