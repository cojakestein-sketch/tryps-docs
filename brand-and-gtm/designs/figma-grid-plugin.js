// ============================================================
// Tryps Brand Book — Grid Setup Plugin
// ============================================================
// Run this on the "Building the world" page in Figma.
//
// How to run:
//   1. Open Figma, navigate to "Building the world" page
//   2. Plugins > Development > New Plugin...
//   3. Name: "Brand Book Grid" > click "Figma design"
//   4. In the code editor, replace ALL of code.ts with this script
//   5. Click the Run button (play icon)
//
// What it creates:
//   - 22 white text labels across the top row
//   - 62 white 1920x1080 frames, named and positioned
//   - Vertical stacking for multi-slide sections
//
// After running:
//   - Right-click the canvas > "Set canvas color" > #1A1A1A
//   - Zoom to fit (Shift+1) to see the full grid
// ============================================================

const columns = [
  { label: "Cover",               prefix: "01-Cover",             count: 1 },
  { label: "TOC",                 prefix: "02-TOC",               count: 1 },
  { label: "01 Brand Story",      prefix: "03-Brand-Story",       count: 3 },
  { label: "02 Mission & Vision", prefix: "04-Mission-Vision",    count: 2 },
  { label: "03 Brand Values",     prefix: "05-Brand-Values",      count: 3 },
  { label: "04 Brand Personality", prefix: "06-Brand-Personality", count: 3 },
  { label: "05 Our Audience",     prefix: "07-Our-Audience",      count: 3 },
  { label: "06 Brand Essence",    prefix: "08-Brand-Essence",     count: 2 },
  { label: "07 Visual Territory", prefix: "09-Visual-Territory",  count: 3 },
  { label: "08 Photography",      prefix: "10-Photography",       count: 3 },
  { label: "09 Color System",     prefix: "11-Color-System",      count: 4 },
  { label: "10 Typography",       prefix: "12-Typography",        count: 3 },
  { label: "11 Voice & Tone",     prefix: "13-Voice-Tone",        count: 4 },
  { label: "12 Social Media",     prefix: "14-Social-Media",      count: 3 },
  { label: "13 Logo",             prefix: "15-Logo",              count: 4 },
  { label: "14 Applications",     prefix: "16-Applications",      count: 3 },
  { label: "15 Brand in the Wild", prefix: "17-Brand-Wild",       count: 3 },
  { label: "16 Motion & Icons",   prefix: "18-Motion-Icons",      count: 3 },
  { label: "17 App Design",       prefix: "19-App-Design",        count: 3 },
  { label: "18 Glimmers",         prefix: "20-Glimmers",          count: 4 },
  { label: "19 Discover Tab",     prefix: "21-Discover",          count: 2 },
  { label: "20 Assets & Contact", prefix: "22-Assets-Contact",    count: 2 },
];

// Layout constants
const SLIDE_W    = 1920;
const SLIDE_H    = 1080;
const COL_GAP    = 180;              // horizontal gap between slides
const COL_STRIDE = SLIDE_W + COL_GAP; // 2100px column-to-column
const ROW_GAP    = 200;              // vertical gap between stacked slides
const ROW_STRIDE = SLIDE_H + ROW_GAP; // 1280px row-to-row
const LABEL_Y    = 0;                // label top
const SLIDES_Y   = 120;              // first slide top (below 48px label + 72px breathing room)

async function main() {
  // ---- Load font (Plus Jakarta Sans Bold, fall back to Inter Bold) ----
  let fontName;
  try {
    await figma.loadFontAsync({ family: "Plus Jakarta Sans", style: "Bold" });
    fontName = { family: "Plus Jakarta Sans", style: "Bold" };
  } catch (_) {
    try {
      await figma.loadFontAsync({ family: "Inter", style: "Bold" });
      fontName = { family: "Inter", style: "Bold" };
      figma.notify("Plus Jakarta Sans not found — using Inter as fallback", { timeout: 3000 });
    } catch (__) {
      figma.notify("Could not load any font. Make sure Plus Jakarta Sans or Inter is available.", { error: true });
      figma.closePlugin();
      return;
    }
  }

  const page = figma.currentPage;
  let totalFrames = 0;
  const allNodes = [];

  for (let col = 0; col < columns.length; col++) {
    const { label, prefix, count } = columns[col];
    const x = col * COL_STRIDE;

    // ---- Section label ----
    const text = figma.createText();
    text.fontName = fontName;
    text.fontSize = 48;
    text.characters = label;
    text.fills = [{ type: "SOLID", color: { r: 1, g: 1, b: 1 } }]; // white (pops on #1A1A1A canvas)
    text.x = x;
    text.y = LABEL_Y;
    text.name = `Label — ${label}`;
    allNodes.push(text);

    // ---- Slide frames ----
    for (let i = 0; i < count; i++) {
      const frame = figma.createFrame();
      frame.resize(SLIDE_W, SLIDE_H);
      frame.x = x;
      frame.y = SLIDES_Y + i * ROW_STRIDE;
      frame.name = `${prefix}-${String(i + 1).padStart(2, "0")}`;

      // White fill
      frame.fills = [{ type: "SOLID", color: { r: 1, g: 1, b: 1 } }];

      // Optional: remove default clip content so paste-in designs aren't clipped
      frame.clipsContent = true;

      allNodes.push(frame);
      totalFrames++;
    }
  }

  // ---- Select everything and zoom to fit ----
  page.selection = allNodes;
  figma.viewport.scrollAndZoomIntoView(allNodes);

  figma.notify(`Done — ${columns.length} columns, ${totalFrames} slides created`);
  figma.closePlugin();
}

main();
