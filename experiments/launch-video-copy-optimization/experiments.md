# Launch Video Copy Optimization

> Auto-research experiment: optimize Tryps launch video copy using Karpathy's auto-research loop with LLM-as-judge eval.
> Created: 2026-03-27
> Status: Pending baseline (creative session this afternoon)

## Hypothesis

**H2:** The auto-research loop can systematically find copy variants that score measurably higher on social engagement dimensions than the human-authored baseline.

This is NOT testing whether synthetic engagement predicts real-world engagement (H1). That's a separate, future experiment — potentially using OASIS (camel-ai/oasis) once we have real-world data to calibrate against.

## What We're Optimizing

Video copy only. Not the video itself (visuals, pacing, music, edit). Three sequential experiments:

| Experiment | Artifact | Format | Run |
|-----------|----------|--------|-----|
| 1. Hook | `hook.txt` | First 1-3 seconds, text overlay / voiceover opening | Tonight (post-creative session) |
| 2. Script | `script.txt` | Full 15-60s narrative arc | Tomorrow night |
| 3. Caption | `caption.txt` | Platform-specific text below the video | Night 3 |

Sequential, not parallel. Freeze the winner from each before starting the next.

## Target Persona

The **23yo planner** — the person who makes the restaurant reservation, creates the Google Doc, and holds the Venmo balance. When she sees this ad, she adds the phone number to the group chat and/or creates the trip on Tryps alongside it. She's the distribution vector.

## Eval Rubric

### Scoring Dimensions (LLM-as-Judge)

| Dimension | Weight | What It Measures |
|-----------|--------|-----------------|
| Scroll-stop power | 25% | Would this make someone pause mid-feed? |
| Share impulse | 25% | Would someone tag a friend or send this in a group chat? |
| Identity resonance | 20% | Does this feel like something the target demo reposts to say "this is so me"? |
| Curiosity gap | 15% | Does it create enough tension to watch/click/learn more? |
| Brand clarity | 15% | Do you know what Tryps is and why it exists within 3 seconds? |

Composite score: 0-100, weighted sum across all judges.

### Judge Personas (4-person panel)

Each judge scores independently. Composite is weighted by persona.

#### 1. The Social Planner (30% weight)
- 24F, plans trips as social currency
- Heavy IG/TikTok user, follows travel creators
- Shares things that make her look like the fun, organized friend
- Will screenshot and send to the group chat immediately if it resonates
- Decides based on: "Does this make me look good for sharing it?"

#### 2. The Reluctant Planner (25% weight)
- 26F, ends up planning because nobody else will
- Frustrated by the Google Docs + Splitwise + iMessage chaos
- Wants something that makes coordination effortless
- Lower social media engagement, but high intent when something solves her pain
- Decides based on: "Does this actually fix my problem?"

#### 3. The Group Chat Lurker (25% weight, VETO power if score < 3/10)
- 23M, doesn't plan but forwards things that are funny/relatable
- High meme literacy, low patience for ads
- If the hook doesn't land in 2 seconds, he's gone
- Gateway to the group — if he shares it, 6 people see it
- Decides based on: "Is this funny/real enough to send without comment?"
- **VETO: If Lurker scores < 3/10, variant is auto-rejected regardless of composite**

#### 4. The Hyper-Planner (20% weight)
- 27F, has a Notion template for every trip
- Will research the app before sharing, reads the caption
- Already uses multiple tools — needs to understand why Tryps is different
- Lowest weight because she'll download anything useful — not the hard conversion
- Decides based on: "Is this actually better than what I'm already doing?"

### Hard Gates (deterministic, auto-fail before judges)

| Gate | Rule | Applies To |
|------|------|-----------|
| Length | Hook: max 15 words. Caption: max 150 characters. Script: max 200 words | All |
| Group travel | Must reference friends/group/people — not solo travel | All |
| Banned words | "crew", "journey", "adventure", "robust", "delve", "travelers", "users", "revolutionize", "seamless", "leverage" | All |
| No emojis | Zero emojis in any variant | All |
| No questions | Cannot open with a question (e.g. "Tired of...?", "Ever tried...?") | Hook only |
| Brand name | Must NOT appear in hook (let curiosity work). Must appear in caption. | Hook, Caption |
| Tone | No corporate language. Must feel like group chat energy, not a press release | All |

If the no-questions gate blocks too many variants after 15 iterations, relax it.

## Auto-Research Loop Config

Based on the existing setup at `~/autoresearch/`.

### Loop Mechanics
1. Claude mutates the artifact (hook.txt / script.txt / caption.txt)
2. Hard gates run (deterministic Python checks) — fail = auto-revert
3. Each judge persona scores independently on the 5 dimensions
4. Composite score calculated with persona weights
5. Lurker veto check (< 3/10 = auto-revert)
6. If composite > previous best: keep. Otherwise: revert.
7. Repeat.

### Parameters

| Parameter | Value |
|-----------|-------|
| Max iterations per experiment | 30 |
| Stop condition | 5 consecutive rejects |
| Cost per eval | ~$0.50-1.00 |
| Total budget | ~$100 across all 3 experiments |
| Judge model | GPT-4.1 (same as existing eval) |
| Mutation model | Claude (via `claude --print`) |
| Run mode | Overnight, unattended |
| Results tracking | `results.tsv` + full git history per experiment |

### Baseline

Baseline hook/script/caption come from the Jake + Sean creative session (2026-03-27 afternoon). They are watching ~20 launch videos, articulating what they like, then drafting with Claude in a separate /grill-me session.

The auto-research loop receives the draft — it does not generate it.

## End-to-End Process

### Phase 1: Creative Session (this afternoon)
1. Jake + Sean watch ~20 launch videos, articulate preferences
2. Claude internalizes taste preferences
3. /grill-me session produces the launch video script including hook
4. Output: `hook.txt`, `script.txt`, `caption.txt` baselines

### Phase 2: Hook Optimization (tonight)
1. Copy `hook.txt` into experiment directory
2. Run baseline eval to get starting score
3. Kick off `./optimize.sh 30` (or until 5 consecutive rejects)
4. Review results in the morning
5. Pick winning hook variant (or keep baseline if delta is marginal)

### Phase 3: Script Optimization (tomorrow night)
1. Freeze winning hook
2. Copy `script.txt` into experiment directory
3. Same loop: `./optimize.sh 30`
4. Review next morning

### Phase 4: Caption Optimization (night 3)
1. Freeze winning hook + script
2. Copy `caption.txt` into experiment directory
3. Same loop: `./optimize.sh 30`
4. Review next morning

### Phase 5: Human Evaluation
1. Jake + Sean review all winning variants vs baselines
2. Bring top candidates to Jackson for outside perspective
3. Final pick is a human decision — the loop output is a recommendation

## Future: OASIS Calibration (parked)

If this experiment produces variants that perform well in the real world, run a calibration:
1. Take 5 hook variants (including the winner and baseline)
2. Rank them by real-world engagement (post them, measure)
3. Run the same 5 through OASIS agent simulation
4. Compare rankings — if they correlate, OASIS becomes a valid eval for future creative work

This is a separate experiment. Don't conflate it with the current one.

## Success Targets

Based on the system prompt experiment (baseline 85.7, peaked 87.5 after 20 experiments), calibrated for creative copy being harder to score consistently.

### Score Targets

| Metric | Red (Fail) | Yellow (Decent) | Green (Good) | Blue (Exceptional) |
|--------|-----------|-----------------|--------------|-------------------|
| Baseline score | < 40 | 40-55 | 55-70 | 70+ |
| Post-optimization score | < 55 | 55-65 | 65-75 | 75+ |
| Delta (improvement) | < +2 | +2 to +5 | +5 to +10 | +10+ |
| Lurker avg score | < 3 (veto) | 3-4 | 5-6 | 7+ |
| Gate pass rate | < 80% | 80-90% | 90-100% | 100% |

### What to shoot for

**Hook experiment (tonight):**
- Baseline: Expect **55-65** from a strong creative session. If baseline is 70+, your creative session crushed it.
- Target: **70+** post-optimization. This means all 4 personas find the hook genuinely engaging.
- Lurker must score **4+ avg** — no veto. If the Lurker is vetoing your baseline, the hook smells like an ad.
- Gate pass rate should be **100%** — if the hook is hitting gates, it has structural problems (too long, has a question, etc.)

**Script experiment (tomorrow):**
- Baseline: Expect **50-60** (harder to score well on a longer artifact).
- Target: **65+** post-optimization.
- Key dimension: Identity resonance should score **7+ from the Reluctant Planner** — she needs to see her exact pain reflected.

**Caption experiment (night 3):**
- Baseline: Expect **55-65** (constrained by 150 char limit + must include Tryps).
- Target: **70+** post-optimization.
- Key dimension: Brand clarity should score **8+ from the Hyper-Planner** — she needs to understand what makes Tryps different.

### Interpretation guide

- **Baseline < 40:** The creative session output needs rework before optimizing. Don't waste iterations on weak starting copy.
- **Baseline 40-55:** Decent starting point. The loop has room to improve. Run all 30 iterations.
- **Baseline 55-70:** Strong starting point. The loop will find refinements but may plateau fast. Stop after 5 rejects is appropriate.
- **Baseline 70+:** Your creative session nailed it. The loop will barely move the needle. That's a **good result** — it means human taste is already near-optimal for this rubric.
- **Loop improves < +2:** The rubric may not capture what makes copy better. Review the persona definitions and scoring guides.
- **Loop improves +5 to +10:** The sweet spot. Real improvement with clear signal about what the judges value.
- **Loop improves +10+:** Suspicious. Check if the loop is gaming the rubric (e.g., making copy that judges like but humans wouldn't).
- **Lurker vetoes everything:** The copy is too corporate/ad-like. Rethink the angle entirely before running more iterations.

### Minimum bar for shipping

The final copy (after human review by Jake + Sean + Jackson) should:
- Score **65+ final** from the eval panel
- Pass **all hard gates**
- **No Lurker veto**
- The Social Planner scores **7+ on share impulse** (she would actually send this to a group chat)
- Jake and Sean independently say "I'd watch this" without seeing the scores

If the optimized copy meets the score bar but Jake/Sean/Jackson don't feel it, **trust the humans**. The rubric is a tool, not a decision-maker.

## Files

All files are built and ready. Only the `.txt` artifact files need your content from the creative session.

```
~/tryps-docs/experiments/launch-video-copy-optimization/
  experiments.md            # This file — full experiment design
  eval.py                   # Eval script — 4 judge personas + hard gates (READY)
  optimize.sh               # Auto-research loop with stop-after-5-rejects (READY)
  program.md                # Instructions for Claude mutation agent (READY)
  rubric.json               # Scoring dimensions + weights (READY)
  hook.txt                  # ← PASTE HOOK HERE after creative session
  script.txt                # ← PASTE SCRIPT HERE after creative session
  caption.txt               # ← PASTE CAPTION HERE after creative session
  personas/
    social-planner.json     # Maya, 24F (READY)
    reluctant-planner.json  # Priya, 26F (READY)
    lurker.json             # Marcus, 23M — veto power (READY)
    hyper-planner.json      # Lena, 27F (READY)
  results_hook.tsv          # Auto-generated during run
  results_script.tsv        # Auto-generated during run
  results_caption.tsv       # Auto-generated during run
  last_eval.json            # Auto-generated during run
```

## Kickoff (copy/paste after creative session)

### Step 1: Paste your copy

Open each file and replace the placeholder with your actual copy from the creative session:

```bash
# Edit these with your baseline copy:
nano ~/tryps-docs/experiments/launch-video-copy-optimization/hook.txt
nano ~/tryps-docs/experiments/launch-video-copy-optimization/script.txt
nano ~/tryps-docs/experiments/launch-video-copy-optimization/caption.txt
```

### Step 2: Run baseline eval (see where you stand)

```bash
cd ~/tryps-docs/experiments/launch-video-copy-optimization
python3 eval.py hook
```

Check the score. If baseline is < 40, rework the copy before optimizing.

### Step 3: Initialize git branch and kick off the loop

```bash
cd ~/tryps-docs/experiments/launch-video-copy-optimization
git checkout -b experiment/launch-copy-hook-$(date +%Y%m%d)
git add -A && git commit -m "baseline: hook from creative session"
./optimize.sh hook 30
```

### Step 4: Review in the morning

```bash
# See the results log
cat results_hook.tsv

# See the winning copy
cat hook.txt

# Compare to your original
git diff experiment/launch-copy-hook-*..HEAD -- hook.txt
```

### Step 5: Repeat for script and caption

```bash
# Freeze winning hook, start script experiment
./optimize.sh script 30

# Then caption
./optimize.sh caption 30
```

### Step 6: Human review

Bring the top variants (original + optimized) to Jake, Sean, and Jackson. Final pick is a human call.
