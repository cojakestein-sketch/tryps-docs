"""
Eval harness for Tryps launch video copy optimization.
Runs copy through 4 judge personas, scores on engagement dimensions.
"""
import json
import os
import re
import sys
import time
from pathlib import Path

try:
    from openai import OpenAI
except ImportError:
    print("ERROR: openai package not installed. Run: pip install openai")
    sys.exit(1)

# ---------------------------------------------------------------------------
# Config
# ---------------------------------------------------------------------------
EXPERIMENT_DIR = Path(__file__).parent
RUBRIC_FILE = EXPERIMENT_DIR / "rubric.json"
PERSONAS_DIR = EXPERIMENT_DIR / "personas"
JUDGE_MODEL = os.environ.get("JUDGE_MODEL", "gpt-4.1")

# Artifact type is passed as arg or defaults to hook
ARTIFACT_TYPE = os.environ.get("ARTIFACT_TYPE", "hook")
ARTIFACT_FILES = {
    "hook": EXPERIMENT_DIR / "hook.txt",
    "script": EXPERIMENT_DIR / "script.txt",
    "caption": EXPERIMENT_DIR / "caption.txt",
}

# Banned words from Tryps brand
BANNED_WORDS = [
    "crew", "journey", "adventure", "robust", "delve", "travelers",
    "users", "revolutionize", "seamless", "leverage", "elevate",
    "game-changer", "disrupt",
]

EMOJI_PATTERN = re.compile(
    "[\U0001f600-\U0001f64f\U0001f300-\U0001f5ff\U0001f680-\U0001f6ff"
    "\U0001f1e0-\U0001f1ff\U00002702-\U000027b0\U000024c2-\U0001f251"
    "\U0001f900-\U0001f9ff\U0001fa00-\U0001fa6f\U0001fa70-\U0001faff"
    "\U00002600-\U000026ff\U0000fe0f]+",
    flags=re.UNICODE,
)


def load_files():
    rubric = json.loads(RUBRIC_FILE.read_text())
    personas = []
    for pfile in sorted(PERSONAS_DIR.glob("*.json")):
        personas.append(json.loads(pfile.read_text()))

    artifact_file = ARTIFACT_FILES[ARTIFACT_TYPE]
    if not artifact_file.exists():
        print(f"ERROR: {artifact_file} not found. Paste your baseline copy there first.")
        sys.exit(1)

    copy_text = artifact_file.read_text().strip()
    if not copy_text:
        print(f"ERROR: {artifact_file} is empty. Paste your baseline copy there first.")
        sys.exit(1)

    return rubric, personas, copy_text


# ---------------------------------------------------------------------------
# Hard gate checks
# ---------------------------------------------------------------------------
def check_hard_gates(copy_text, artifact_type):
    """Run hard gate checks. Returns (passed: bool, failures: list[str])."""
    failures = []

    # Word count (hook only)
    word_count = len(copy_text.split())
    if artifact_type == "hook" and word_count > 15:
        failures.append(f"GATE FAIL: hook is {word_count} words (max 15)")

    # Character count (caption only)
    if artifact_type == "caption" and len(copy_text) > 150:
        failures.append(f"GATE FAIL: caption is {len(copy_text)} chars (max 150)")

    # Word count (script only)
    if artifact_type == "script" and word_count > 200:
        failures.append(f"GATE FAIL: script is {word_count} words (max 200)")

    # Must reference group/friends/people
    group_words = ["friend", "friends", "group", "people", "everyone", "squad",
                   "them", "they", "we", "us", "together", "chat", "gc"]
    text_lower = copy_text.lower()
    has_group_ref = any(re.search(r'\b' + re.escape(w) + r'\b', text_lower) for w in group_words)
    if not has_group_ref:
        failures.append("GATE FAIL: no reference to friends/group/people — sounds like solo travel")

    # Banned words
    for word in BANNED_WORDS:
        if re.search(r'\b' + re.escape(word) + r'\b', text_lower):
            failures.append(f"GATE FAIL: banned word '{word}'")

    # No emojis
    if EMOJI_PATTERN.search(copy_text):
        failures.append("GATE FAIL: contains emoji")

    # No questions in hook
    if artifact_type == "hook":
        # Check if the copy starts with or is primarily a question
        sentences = re.split(r'[.!?]+', copy_text)
        first_sentence = sentences[0].strip() if sentences else ""
        question_starters = ["do you", "have you", "ever ", "tired of", "what if",
                             "why do", "why is", "how many", "is your", "are you",
                             "can't", "don't you", "remember when", "you know when"]
        for starter in question_starters:
            if first_sentence.lower().startswith(starter):
                failures.append(f"GATE FAIL: hook opens with a question ('{starter}...')")
                break
        if copy_text.strip().endswith("?"):
            failures.append("GATE FAIL: hook ends with question mark")

    # Brand name rules
    has_tryps = "tryps" in text_lower
    if artifact_type == "hook" and has_tryps:
        failures.append("GATE FAIL: hook contains 'Tryps' — let curiosity work, no brand in hook")
    if artifact_type == "caption" and not has_tryps:
        failures.append("GATE FAIL: caption must mention 'Tryps'")

    # No corporate language
    corporate_phrases = [
        "revolutionize", "transform the way", "next-generation", "cutting-edge",
        "best-in-class", "synergy", "holistic", "streamline your", "empower",
        "unlock the power", "state-of-the-art", "industry-leading",
    ]
    for phrase in corporate_phrases:
        if phrase.lower() in text_lower:
            failures.append(f"GATE FAIL: corporate language '{phrase}'")

    return len(failures) == 0, failures


# ---------------------------------------------------------------------------
# LLM-as-judge scoring per persona
# ---------------------------------------------------------------------------
def judge_with_persona(client, rubric, persona, copy_text, artifact_type):
    """One persona judge scores the copy on all dimensions."""

    dimensions_text = "\n".join(
        f"- **{d['name']}** (weight {d['weight']}): {d['description']}\n"
        f"  Scoring guide: {json.dumps(d['scoring'])}"
        for d in rubric["dimensions"]
    )

    artifact_label = {
        "hook": "a video hook (first 1-3 seconds, text overlay or voiceover opening line)",
        "script": "a full video script (15-60 second narrative arc)",
        "caption": "a social media caption (text below the video on TikTok/IG/Twitter)",
    }[artifact_type]

    judge_prompt = f"""{persona['system_prompt']}

## What you're evaluating

This is {artifact_label} for the launch of Tryps — a group trip planning app. Think "Partiful but for travel." The target audience is 20-somethings who plan group trips with friends.

## The copy to evaluate

\"\"\"{copy_text}\"\"\"

## Scoring dimensions

{dimensions_text}

## Your output

Score each dimension 0-10 based on the scoring guide. Include a one-sentence reason for each score that reflects YOUR specific perspective and personality.

Return a JSON object:
{{"scroll_stop": {{"score": N, "reason": "..."}}, "share_impulse": {{"score": N, "reason": "..."}}, "identity_resonance": {{"score": N, "reason": "..."}}, "curiosity_gap": {{"score": N, "reason": "..."}}, "brand_clarity": {{"score": N, "reason": "..."}}}}

Return ONLY the JSON object, no other text."""

    try:
        resp = client.responses.create(
            model=JUDGE_MODEL,
            input=judge_prompt,
        )

        judge_text = ""
        for item in resp.output:
            if item.type == "message":
                for content in item.content:
                    if hasattr(content, "text"):
                        judge_text += content.text

        json_match = re.search(r'\{[\s\S]*\}', judge_text)
        if json_match:
            scores = json.loads(json_match.group())
            return scores
        return None

    except Exception as e:
        print(f"  Judge error ({persona['id']}): {e}")
        return None


# ---------------------------------------------------------------------------
# Main eval loop
# ---------------------------------------------------------------------------
def run_eval(verbose=True):
    """Run copy through all judge personas. Returns composite score and details."""
    rubric, personas, copy_text = load_files()
    client = OpenAI()

    if verbose:
        print(f"\n{'='*60}")
        print(f"EVAL RUN — {ARTIFACT_TYPE} — {len(personas)} judges — model: {JUDGE_MODEL}")
        print(f"{'='*60}")
        print(f"\nCopy ({len(copy_text.split())} words, {len(copy_text)} chars):")
        print(f"  \"{copy_text}\"")
        print()

    # Hard gates first
    gates_passed, gate_failures = check_hard_gates(copy_text, ARTIFACT_TYPE)

    if not gates_passed:
        if verbose:
            for f in gate_failures:
                print(f"  {f}")
            print()

    # Judge scoring
    persona_results = []
    all_persona_composites = []
    lurker_veto = False

    for persona in personas:
        if verbose:
            print(f"[{persona['name']}] (weight: {persona['weight']})...")

        scores = judge_with_persona(client, rubric, persona, copy_text, ARTIFACT_TYPE)

        if scores is None:
            if verbose:
                print("  SCORING FAILED — skipping persona")
            continue

        # Calculate per-persona composite
        composite = 0
        for dim in rubric["dimensions"]:
            name = dim["name"]
            if name in scores and scores[name] is not None:
                composite += scores[name]["score"] * dim["weight"] * 10

        # Check lurker veto
        if persona.get("veto_power"):
            avg_score = sum(
                scores[d["name"]]["score"]
                for d in rubric["dimensions"]
                if d["name"] in scores
            ) / len(rubric["dimensions"])

            veto_threshold = persona.get("veto_threshold", 3)
            if avg_score < veto_threshold:
                lurker_veto = True
                if verbose:
                    print(f"  ** VETO ** avg score {avg_score:.1f} < {veto_threshold} threshold")

        persona_result = {
            "persona": persona["id"],
            "name": persona["name"],
            "weight": persona["weight"],
            "scores": {
                name: scores[name] for name in [d["name"] for d in rubric["dimensions"]] if name in scores
            },
            "composite": round(composite, 1),
        }
        persona_results.append(persona_result)
        all_persona_composites.append((persona["weight"], composite))

        if verbose:
            print(f"  composite: {composite:.1f}")
            for dim in rubric["dimensions"]:
                name = dim["name"]
                if name in scores:
                    print(f"    {name}: {scores[name]['score']}/10 — {scores[name]['reason']}")
            print()

        time.sleep(0.3)

    # Weighted composite across personas
    if all_persona_composites:
        total_weight = sum(w for w, _ in all_persona_composites)
        weighted_composite = sum(w * c for w, c in all_persona_composites) / total_weight
    else:
        weighted_composite = 0

    # Apply penalties
    final_score = weighted_composite
    if not gates_passed:
        final_score *= 0.5  # 50% penalty for gate failures
    if lurker_veto:
        final_score = 0  # Lurker veto = auto-reject

    summary = {
        "artifact_type": ARTIFACT_TYPE,
        "copy_text": copy_text,
        "word_count": len(copy_text.split()),
        "char_count": len(copy_text),
        "gates_passed": gates_passed,
        "gate_failures": gate_failures if not gates_passed else [],
        "lurker_veto": lurker_veto,
        "persona_results": persona_results,
        "raw_composite": round(weighted_composite, 1),
        "final_score": round(final_score, 1),
    }

    if verbose:
        print(f"{'='*60}")
        print(f"RESULTS")
        print(f"  Gates:           {'PASS' if gates_passed else 'FAIL'}")
        print(f"  Lurker veto:     {'YES — AUTO-REJECT' if lurker_veto else 'No'}")
        print(f"  Raw composite:   {weighted_composite:.1f}/100")
        print(f"  Final score:     {final_score:.1f}/100")
        print(f"{'='*60}\n")

    return summary


if __name__ == "__main__":
    api_key = os.environ.get("OPENAI_API_KEY")
    if not api_key:
        env_file = EXPERIMENT_DIR / ".env"
        if env_file.exists():
            for line in env_file.read_text().splitlines():
                if line.startswith("OPENAI_API_KEY="):
                    os.environ["OPENAI_API_KEY"] = line.split("=", 1)[1].strip()
                    break

    if not os.environ.get("OPENAI_API_KEY"):
        print("ERROR: OPENAI_API_KEY not set. Add it to .env or export it.")
        sys.exit(1)

    # Allow artifact type override from command line
    if len(sys.argv) > 1 and sys.argv[1] in ARTIFACT_FILES:
        ARTIFACT_TYPE = sys.argv[1]

    summary = run_eval(verbose=True)

    results_file = EXPERIMENT_DIR / "last_eval.json"
    results_file.write_text(json.dumps(summary, indent=2))
    print(f"Results written to {results_file}")
