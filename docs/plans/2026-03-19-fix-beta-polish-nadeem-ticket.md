---
title: "Beta Polish — Consolidated Bug & UX List"
type: fix
date: 2026-03-19
---

# Beta Polish — Consolidated Bug & UX List

> Source: Jake's morning testing Mar 18 + Mar 19
> Assignee: Nadeem (reassign individual items at standup)
> Deadline: 2pm TestFlight build today for critical items; rest this week

---

## Home Tab

| # | Issue | Status |
|---|-------|--------|
| 1 | **"My Trip" → "My Trips"** — Tab name is singular, should be plural everywhere | ⬜ |
| 2 | **Trip cards not branded** — Still not matching Tryps brand (Krisna designed these?) | ⬜ |
| 3 | **Trip cards not easily shared** — Need to long press or swipe up to share | ⬜ |
| 4 | **Trip cards not easily customizable** — Can't personalize from home | ⬜ |
| 5 | **Swipe pagination dots lag** — Navigation squares lag when swiping between trips | ⬜ |
| 6 | **Vote on activities from home tab** — Need to vote without opening the trip | ⬜ |
| 7 | **Edit dates with long press** — Long press on trip should let you edit dates | ⬜ |

## Calendar

| # | Issue | Status |
|---|-------|--------|
| 8 | **Calendar UI/UX doesn't match Figma** — Whole tab is not right | ⬜ |
| 9 | **Can't toggle between years** — No easy year navigation | ⬜ |
| 10 | **Green vs gray highlighting unclear** — Hard to see why, looks ugly | ⬜ |
| 11 | **"Your Tryps" section doesn't match design** — Layout/content wrong | ⬜ |
| 12 | **Can't select date when tapping March 2026** — Date selection broken | ⬜ |

## People Tab

| # | Issue | Status |
|---|-------|--------|
| 13 | **People tab needs redesign** — (Arslan did this originally?) | ⬜ |
| 14 | **Still on cream background** — Should match current theme | ⬜ |
| 15 | **"All Tripmates and Contacts" too many fields** — Simplify, too cluttered | ⬜ |
| 16 | **Countries I've been to screen doesn't match** — Design/data mismatch | ⬜ |
| 17 | **Unable to add flights in people tab** — Feature broken | ⬜ |
| 18 | **Offline/online toggle needs to be OFF** — Remove or default to off | ⬜ |

## Itinerary Tab

| # | Issue | Status |
|---|-------|--------|
| 19 | **Landing on Activities tab instead of Itinerary** — Default should be Itinerary | ⬜ |
| 20 | **Left-hand slider doesn't work properly** — Interaction broken | ⬜ |
| 21 | **Date picker at top doesn't move** — Dates don't scroll/update when tapped | ⬜ |

## Discover / Explorer

| # | Issue | Status |
|---|-------|--------|
| 22 | **Explorer globe not loading** — Globe visualization broken | ⬜ |
| 23 | **Light mode background too dark** — Should be lighter per brand | ⬜ |
| 24 | **"Trending in NYC" (trending songs) not working** — Feature broken or stubbed | ⬜ |

## Vibe / DNA

| # | Issue | Status |
|---|-------|--------|
| 25 | **Group vibe tab not saving** — Set vibe but it doesn't persist | ⬜ |
| 26 | **Dress code feature needs rework** — Current implementation not right | ⬜ |

## Activities / Voting

| # | Issue | Status |
|---|-------|--------|
| 27 | **Can't drag activities from Discover to voting block** — Drag missing | ⬜ |
| 28 | **Can't drag back from voting to Discover to remove** — No undo via drag | ⬜ |

## Media

| # | Issue | Status |
|---|-------|--------|
| 29 | **Unable to remove photos from mood board** — Delete not working | ⬜ |

## Sharing

| # | Issue | Status |
|---|-------|--------|
| 30 | **Share should be a bottom pop-up modal** — Not current implementation | ⬜ |

---

## Priority for 2pm Build

Items that directly affect the two beta flows (sign up → create trip → invite → join → vibe quiz → play around):

**Must fix for 2pm:**
- #1 (My Trips naming)
- #19 (land on Itinerary, not Activities)
- #25 (group vibe saving)

**Should fix for 2pm:**
- #12 (calendar date selection)
- #14 (people tab background)
- #18 (offline toggle off)

**Fix this week (not blocking beta):**
- Everything else

> Final priority call happens at standup after Asif's walkthrough of current state.
