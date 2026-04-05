# Slideshow Tools: Research & Recommendation

> Generated 2026-04-05. Research across 5 categories: Marp, Obsidian Slides, Slidev, PPTX pipelines, AI-native tools.

---

## TL;DR Recommendation

**Your files are raw idea docs, not slide-formatted markdown.** Every tool needs a transformation step first. Here's the play:

| Goal | Tool | Why |
|------|------|-----|
| **Fast polished deck NOW** | Claude + Gamma ($8/mo) | Best visual quality, paste synthesized content, done in 30 min |
| **Iterate in markdown, version-controlled** | Claude + Marp CLI (free) | Change .md, deck updates. PDF/HTML export. Best for ongoing iteration |
| **Hand someone an editable .pptx** | Claude + Pandoc (free) | Real editable PowerPoint with branded template |
| **Deploy as a live web app** | Claude + Slidev (free) | Share a URL instead of a file. Best dev experience |

**Primary recommendation: Marp** for your day-to-day iteration workflow, with **Pandoc** as the escape hatch when you need real .pptx output.

---

## The Setup Plan (Marp + Pandoc)

### Step 1: Install tools

```bash
# Marp CLI
npm install -g @marp-team/marp-cli

# Pandoc (for PPTX when needed)
brew install pandoc

# VS Code extension for live preview
code --install-extension marp-team.marp-vscode
```

### Step 2: Create slide-formatted versions of your idea docs

Your current files (01-the-story.md through 09-path-to-the-plane.md) are prose docs with TODOs and research notes. They need to be converted to slide-formatted markdown.

Create a new directory structure:

```
pitch-deck-ideas/
  ideas/                    # Move current raw idea docs here
    01-the-story.md
    02-traveler-dna-and-trip-vibe.md
    ...
  slides/                   # Slide-formatted versions
    01-the-story.md
    02-traveler-dna.md
    03-why-now.md
    ...
  deck.md                   # Master file that concatenates all slides
  theme/
    tryps.css               # Marp custom theme
  tryps-template.pptx       # Pandoc reference template (for PPTX export)
  build.sh                  # Build script
```

Use Claude to convert each idea doc into slide-formatted markdown with `---` separators.

### Step 3: Create the Tryps Marp theme

```css
/* theme/tryps.css */
/* @theme tryps */

@import 'default';
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap');

section {
  font-family: 'Inter', sans-serif;
  background: #ffffff;
  color: #1a1a1a;
}

section.lead {
  background: #1a1a2e;
  color: #ffffff;
  text-align: center;
}

section.lead h1 {
  color: #ffffff;
  font-size: 2.5em;
}

h1 {
  color: #1a1a2e;
  font-weight: 700;
}

h2 {
  color: #333;
  font-weight: 600;
}

/* Accent color for highlights */
strong {
  color: #e94560;
}

/* Footer with logo */
footer {
  font-size: 0.6em;
  color: #999;
}

/* Slide numbers */
section::after {
  content: attr(data-marpit-pagination) ' / ' attr(data-marpit-pagination-total);
  font-size: 0.6em;
  color: #999;
}
```

### Step 4: Create the master deck file

```markdown
<!-- deck.md -->
---
marp: true
theme: tryps
paginate: true
---

<!-- Then concatenate all slide files in order -->
```

### Step 5: Build script

```bash
#!/bin/bash
# build.sh

# Concatenate all slide files into one deck
cat slides/*.md > /tmp/tryps-deck-combined.md

# Prepend the frontmatter
cat > /tmp/tryps-deck.md << 'EOF'
---
marp: true
theme: tryps
paginate: true
header: 'Tryps'
---

EOF
cat /tmp/tryps-deck-combined.md >> /tmp/tryps-deck.md

# Build outputs
marp /tmp/tryps-deck.md --theme theme/tryps.css -o deck.html          # Web
marp /tmp/tryps-deck.md --theme theme/tryps.css --pdf -o deck.pdf     # PDF
marp /tmp/tryps-deck.md --theme theme/tryps.css --pptx -o deck.pptx  # PPTX (images)

# For editable PPTX, use pandoc instead:
pandoc slides/*.md --reference-doc=tryps-template.pptx --slide-level=2 -o deck-editable.pptx

echo "Built: deck.html, deck.pdf, deck.pptx, deck-editable.pptx"
```

### Step 6: Iterate

```bash
# Live preview while editing (watches for changes)
marp --theme theme/tryps.css -w slides/01-the-story.md

# Or use VS Code with Marp extension for side-by-side preview
```

---

## Tool-by-Tool Research Summary

### 1. Marp (marp.app) -- RECOMMENDED PRIMARY

**What:** CLI tool + VS Code extension. Markdown in, slides out.

**Multi-file:** Requires ONE .md file. Use a build script to concatenate separate files. CLI does NOT support folder input or glob patterns natively.

**Theming:** Full CSS control. Define custom themes with fonts, colors, layouts. Supports `<!-- _class: lead -->` for per-slide layout variants. Custom CSS themes are loaded via `--theme` flag.

**Features:**
- Speaker notes (HTML comments)
- Slide transitions (CSS-based, v3.4+)
- Image sizing directives (`![w:500](image.png)`)
- Code syntax highlighting
- Math (KaTeX)
- Slide numbering (paginate: true)
- Background images/colors per slide

**Export:** HTML, PDF (high quality via Chrome), PPTX. PPTX caveat: default exports slides as background images (not editable text). `--pptx-editable` flag produces editable text but with lower fidelity and no speaker notes.

**Iteration:** VS Code extension gives live preview. CLI `--watch` mode auto-rebuilds on save. Fast feedback loop.

**Verdict:** Best balance of simplicity, theming control, and output quality. The concatenation step for multi-file is the only friction point, easily solved with a 5-line shell script.

---

### 2. Obsidian Slides -- NOT RECOMMENDED

**What:** Obsidian plugins for in-vault presentations. Best option is **Slides Extended** (actively maintained fork of discontinued Advanced Slides).

**Multi-file:** Single file with `---` separators only. Can embed other notes with `![[note]]` syntax, but NOT a folder-to-deck workflow.

**Theming:** CSS-based (reveal.js under the hood). Grid/split layout components. 10+ built-in themes.

**Features:** Speaker notes, presenter view (browser), fragments/animations, Excalidraw support, chalkboard drawing, slide backgrounds (color/image/video).

**Export:** HTML (self-contained), PDF (via browser print). NO PPTX export from the reveal.js plugins. Only the Marp-based Obsidian plugin (stale, unmaintained) exports PPTX.

**Verdict:** If you already lived in Obsidian and wanted slides alongside your notes, Slides Extended is good. But for your use case (separate .md files, branded deck, multiple export formats), it adds complexity without benefit. The single-file-only constraint is a dealbreaker for modular content.

---

### 3. Slidev (sli.dev) -- STRONG ALTERNATIVE

**What:** Vue/Vite-powered presentation framework. 45k GitHub stars. Developer-focused.

**Multi-file:** YES. Best multi-file support of all tools. Use `src` frontmatter to import from separate .md files:

```md
---
src: ./pages/01-cover.md
---

---
src: ./pages/02-problem.md
---
```

Can even import specific slide ranges: `src: ./file.md#2,5-7`.

**Theming:** Excellent. Custom fonts via frontmatter, UnoCSS utility classes (like Tailwind), per-slide scoped CSS, eject-and-customize themes. 18+ built-in layouts (cover, two-cols, image-right, etc.).

**Features:** The most feature-rich option by far. Presenter mode, speaker notes, transitions, click animations, Vue components in slides, Monaco live code editor, drawing/annotations, camera overlay, recording, dark mode, Mermaid diagrams, LaTeX. Deploy as a web app.

**Export:** PDF (high quality), PNG, PPTX (**images only, not editable**), SPA web app.

**Iteration:** Best-in-class. Vite HMR updates in ~100ms. No rebuild needed. VS Code extension available.

**Is it overkill?** Yes and no. The developer features (Monaco, TwoSlash, code highlighting) are wasted on a pitch deck. But the modular file support, layout system, and deploy-as-web-app are genuinely useful. The ecosystem has zero pitch deck themes -- you'd build your own.

**Verdict:** If you want the best editing experience and plan to share the deck as a live URL (not a file), Slidev is excellent. The PPTX limitation (images only) is the main drawback. Best for: "here's a link to our deck" instead of "here's a file."

---

### 4. Pandoc / md2pptx / python-pptx -- RECOMMENDED FOR PPTX

**When you need real editable PowerPoint**, this is the path.

#### Pandoc (RECOMMENDED for PPTX)

**Multi-file:** Native. `pandoc 01.md 02.md 03.md -o deck.pptx` -- just list the files.

**Reference template:** Create a branded .pptx template with your fonts, colors, logos in the Slide Master. Pandoc uses the template's layouts but fills them with your markdown content.

```bash
# Generate default template to customize
pandoc -o tryps-template.pptx --print-default-data-file reference.pptx
# Open in PowerPoint, customize Slide Master, save
# Then use it:
pandoc slides/*.md --reference-doc=tryps-template.pptx --slide-level=2 -o deck.pptx
```

**Layout mapping:**
- `#` heading = Section Header slide
- `##` heading = Title and Content slide (the workhorse)
- `---` horizontal rule = force new slide
- `:::: {.columns}` = Two Content layout
- Speaker notes via `::: {.notes}` div

**Quality:** Real editable text, bullets, tables, images in PowerPoint. Not screenshots. Investors can edit, forward, annotate. The layout intelligence is basic (7 fixed layout types) but sufficient for most pitch decks.

#### md2pptx

More formatting control than pandoc (50+ metadata keys for fonts, sizes, colors, card layouts, funnels). Actively maintained (v6.3, Mar 2026). But reads from stdin only -- need to `cat` files together. Best for when pandoc's 7 layouts aren't enough.

#### python-pptx script

Total pixel-perfect control. You write a Python script that reads your .md files and generates .pptx programmatically. Maximum effort, maximum control. Best for: when you have a very specific template to match exactly.

**Verdict:** Pandoc is the right default. Use it alongside Marp -- Marp for your iteration/preview workflow, Pandoc for final .pptx export.

---

### 5. AI-Native Tools

#### Gamma (gamma.app) -- BEST FOR QUICK POLISH

- Paste content (no .md file import yet -- it's a requested feature)
- AI generates beautiful card-based presentations
- Export to PDF, PPTX, PNG, Google Slides
- Brand kit on Pro ($15/mo) with custom fonts, colors, logos
- **Best path:** Claude synthesizes your 9 docs into a narrative outline, paste into Gamma, get a polished deck in 30 min

#### Beautiful.ai -- $12/mo

- Smart auto-layout adjusts spacing/alignment as you add content
- No markdown import
- PPTX export preserves formatting well
- Good for pitch decks but less flexible than Gamma

#### Pitch.com -- Best for collaboration

- Real-time co-editing, async comments
- AI-assisted generation from prompts
- Analytics on who viewed what
- $8/mo Pro. Best if you need Cameron or team to co-edit

#### Tome -- DEAD

Pivoted away from presentations April 2025. Do not use.

#### Claude + Marp workflow

The FreeCodeCamp article "[How I Use Claude Code + Marp to Think Through Presentations](https://www.freecodecamp.org/news/how-to-use-claude-code-and-marp-to-think-through-presentations/)" describes exactly your use case. Claude reads your idea docs, generates Marp-formatted slides, you iterate.

#### FlashDocs (flashdocs.com)

Bridge between LLM output and polished slides. Has an MCP integration. Claude generates structured content, FlashDocs renders branded PPTX/Google Slides. Worth exploring if the Marp visual quality isn't enough.

#### Alai (getalai.com)

AI trained on 1,000+ real pitch decks. Generates 4 layout options per slide. Knows pitch-deck patterns (TAM pyramids, competitive matrices, traction timelines). Purpose-built for fundraising decks.

---

## Decision Matrix

| Criterion | Marp | Slidev | Pandoc | Gamma | Obsidian |
|-----------|------|--------|--------|-------|----------|
| Multi-file support | Script needed | Native (best) | Native | No (paste) | No |
| Theming/branding | CSS (good) | CSS + Vue (best) | Template .pptx | Brand kit | CSS |
| PDF export | High quality | High quality | N/A (use Marp) | Yes | Via print |
| Editable PPTX | Images only | Images only | **Real editable** | Yes (export) | No |
| Iteration speed | Fast (watch) | Fastest (HMR) | Slow (rebuild) | GUI-based | Medium |
| Deploy as web app | No | **Yes** | No | Shareable link | No |
| Learning curve | Low | Medium | Low | Very low | Low |
| Version controlled | Yes (.md) | Yes (.md) | Yes (.md) | No | Yes (.md) |
| Cost | Free | Free | Free | $8-15/mo | Free |
| Pitch deck quality | Good | Good (w/ effort) | Good (w/ template) | **Excellent** | Good |

---

## Concrete Next Steps

1. **Install Marp CLI + VS Code extension** (`npm i -g @marp-team/marp-cli`)
2. **Move raw idea docs** to `pitch-deck-ideas/ideas/`
3. **Ask Claude to convert** each idea doc into slide-formatted .md in `pitch-deck-ideas/slides/`
4. **Create the Tryps CSS theme** (fonts, colors, layouts)
5. **Write the build script** (concatenate + export)
6. **Create a Pandoc reference template** for when you need editable .pptx
7. **Optionally:** Paste the synthesized content into Gamma for a quick polished version to share while you iterate on the markdown version

---

## Sources

- [Marp CLI](https://github.com/marp-team/marp-cli) (v4.3.1)
- [Slidev](https://sli.dev/) (v52.14.2)
- [Pandoc Manual](https://pandoc.org/MANUAL.html)
- [md2pptx](https://github.com/MartinPacker/md2pptx) (v6.3)
- [python-pptx](https://python-pptx.readthedocs.io/) (v1.0.0)
- [Slides Extended](https://github.com/ebullient/obsidian-slides-extended) (v2.3.3)
- [Gamma](https://gamma.app/)
- [Beautiful.ai](https://www.beautiful.ai/)
- [Pitch.com](https://pitch.com/)
- [FlashDocs](https://www.flashdocs.com/)
- [Claude Code + Marp (FreeCodeCamp)](https://www.freecodecamp.org/news/how-to-use-claude-code-and-marp-to-think-through-presentations/)
