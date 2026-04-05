# Obsidian 101 for Jake Stein

> Everything you need to know to actually use Obsidian, not just store files in it.
>
> April 2026 · 10 min read
>
> **See also:** [[cs-101-for-jake-stein]] · [[shared/state|Tryps State]] · [[scopes/INDEX|All Scopes]]

---

## What Obsidian Actually Is

Obsidian is a note-taking app that reads plain markdown files from a folder on your computer. That's it. There's no cloud database, no proprietary format. Your notes are `.md` files in `~/tryps-docs`. If Obsidian disappeared tomorrow, all your notes are still there as regular files.

This is why it works perfectly with git repos and Claude Code -- everything is just files.

---

## Your Setup

| Thing | Where |
|-------|-------|
| Vault | `~/tryps-docs` on your Mac |
| Sync | Obsidian Sync (syncs Mac and iPhone) |
| Git | Same folder is also a git repo (agents read/write it) |
| Phone | Obsidian iOS app, connected to `tryps-docs` remote vault |

**The flow:** You write on your phone or Mac. Obsidian Sync keeps them in sync. Claude/Marty read and write the same files via git. Everyone shares one source of truth.

---

## The 10 Things You Actually Need to Know

### 1. Create a note

- **Mac:** Cmd+N (new note) or Cmd+P then type "New note"
- **Phone:** Tap the pencil icon (bottom right)
- Notes are just files. Name them whatever you want.

### 2. Link notes together

This is Obsidian's superpower. Type double brackets to link:

```
Check the [[cs-101-for-jake-stein]] guide for details.
```

This creates a clickable link to that note. If the note doesn't exist yet, it'll be created when you click it. This is how you build a web of connected knowledge instead of a pile of disconnected files.

### 3. Search everything

- **Mac:** Cmd+Shift+F (search all files)
- **Phone:** Tap the search icon (magnifying glass)
- Searches the full text of every note, instantly

### 4. Quick switcher (the best feature)

- **Mac:** Cmd+O
- **Phone:** Tap the quick switcher icon
- Start typing any note name and jump to it instantly. This is how you navigate -- not by scrolling through folders.

### 5. Daily notes

Turn this on: Settings > Core plugins > Daily notes (toggle on)

Then:
- **Mac:** Click the calendar icon in the left sidebar
- **Phone:** Same calendar icon
- Creates a note named `2026-04-05.md` (today's date)

Use this for daily brain dumps, standup prep, random thoughts. One note per day, all searchable later.

**Pro tip:** Set the "New file location" to a `daily/` folder so they don't clutter your root.

### 6. Formatting basics

Obsidian uses markdown -- same format as GitHub READMEs:

```markdown
# Big heading
## Smaller heading
### Even smaller

**bold text**
*italic text*

- bullet point
- another bullet

1. numbered list
2. second item

> this is a quote or callout

`inline code`

- [ ] unchecked todo
- [x] checked todo
```

You don't need to memorize this -- just write naturally and format as needed.

### 7. Tags

Add `#tag` anywhere in a note to tag it:

```
#meeting #gtm #sean
```

Then search for a tag to find all related notes. Good for: `#standup`, `#idea`, `#bug`, `#meeting`, `#decision`.

### 8. Folders vs. links

You have folders already (scopes/, shared/, learning/, etc.). That's fine. But don't obsess over folder structure -- **links are more powerful than folders**.

A note can only be in one folder, but it can be linked from dozens of places. When in doubt, just create the note wherever and link to it from relevant places.

### 9. Command palette

**Cmd+P** (Mac) opens the command palette -- like Spotlight for Obsidian. Every action is searchable here:
- "Create new note"
- "Open daily note"
- "Search and replace"
- "Toggle bold"
- "Open graph view"

If you forget how to do something, Cmd+P and type what you want.

### 10. Graph view

Click the graph icon in the left sidebar. It shows all your notes as dots, with lines connecting linked notes. It's mostly eye candy, but useful for seeing which notes are isolated (no links) and which are highly connected (important hubs).

---

## Workflows That Matter for You

### Morning standup prep
1. Open today's daily note (calendar icon)
2. Write what you want to cover
3. Link to relevant scope notes: `Check [[agent-intelligence]] progress`
4. This is on your phone by the time you sit down

### Brain dump on the go
1. Open Obsidian on your phone
2. Open daily note (or create a new note)
3. Just type. Don't worry about formatting.
4. When you're back at your Mac, clean it up or link it to other notes

### Meeting notes
1. Create a note: `2026-04-05-meeting-sean-brand.md`
2. Write during the meeting
3. After: add links to relevant notes, tag with `#meeting`
4. Searchable forever

### Capturing a decision
When you make a product/strategy decision, write it down:

```markdown
# Decision: Use Duffel for flight booking

**Date:** 2026-04-05
**Context:** Evaluated Duffel, Amadeus, Kiwi
**Decision:** Duffel -- best API, reasonable pricing, sandbox ready
**Why:** Modern REST API, good docs, handles NDC content
**Tags:** #decision #booking #rizwan
```

Now when someone asks "why did we pick Duffel?" you search `#decision booking` and there it is.

---

## Keyboard Shortcuts Worth Knowing

| Action | Mac | What it does |
|--------|-----|-------------|
| Quick switcher | Cmd+O | Jump to any note by name |
| Search all | Cmd+Shift+F | Full-text search everything |
| New note | Cmd+N | Create a new note |
| Command palette | Cmd+P | Do anything |
| Toggle bold | Cmd+B | **bold** |
| Toggle italic | Cmd+I | *italic* |
| Toggle checkbox | Cmd+L | - [ ] / - [x] |
| Back | Cmd+Alt+Left | Go back to previous note |
| Forward | Cmd+Alt+Right | Go forward |
| Close note | Cmd+W | Close current tab |

---

## Plugins You Already Have

Looking at your vault, you have these installed:

- **Git** (community plugin) -- auto-commits and pushes your vault to GitHub. This is how Claude/Marty can read your notes.
- **Daily notes** (core plugin) -- one-tap daily note creation
- **Backlinks** (core plugin) -- shows what other notes link TO the current note
- **Canvas** (core plugin) -- visual boards for brainstorming (like a whiteboard with note cards)
- **Templates** (core plugin) -- reusable note templates

### Plugins worth turning on
- **Starred/Bookmarks** -- pin frequently accessed notes
- **Outline** -- shows a table of contents for long notes
- **Word count** -- shows word count in the status bar (already on based on your screenshots)

---

## Things NOT to Do

1. **Don't over-organize.** Don't spend 2 hours creating the perfect folder structure. Just write notes and link them. Structure emerges naturally.

2. **Don't duplicate information.** Link to existing notes instead of copying content. One source of truth.

3. **Don't worry about "doing it right."** There's no wrong way. The best system is the one you actually use. If you just use daily notes and search, you're already ahead of 90% of people.

4. **Don't install 50 plugins.** The core features (notes, links, search, daily notes) are 95% of the value. Plugins are rabbit holes.

---

## How This Connects to Your Workflow

```
You (phone/Mac)          Claude/Marty (terminal)
      |                        |
      v                        v
  Obsidian  <-- Sync -->   Git (read/write .md files)
      |                        |
      +---------- Both read/write ~/tryps-docs ----------+
```

- **You** write notes, brain dumps, meeting notes in Obsidian
- **Obsidian Sync** keeps your phone and Mac in sync
- **Git plugin** pushes changes to GitHub
- **Claude/Marty** read and write the same files via git
- Everyone is working on the same folder of markdown files

That's the whole system. No fancy databases, no proprietary formats, no lock-in. Just files.

---

*Obsidian 101 for Jake Stein -- April 2026*
