# QA & Testing — Functional Requirements

**Assignee:** Andreas
**Status:** Not Started
**Phase:** P1: Core App

---

## Overview

Quality assurance strategy for the Tryps app. Covers automated testing, manual QA processes, device matrix, and release validation.

## Testing Layers

| Layer | Tool | Coverage |
|-------|------|----------|
| Unit tests | Jest | Utils, hooks, business logic |
| Integration tests | Jest + Supabase test client | API calls, data flow |
| Component tests | React Native Testing Library | UI components |
| E2E tests | Maestro (planned) | Critical user flows |
| Manual QA | Device testing | Visual, UX, edge cases |

## Critical Flows to Test

1. **Onboarding** — Phone OTP, Apple Sign-In, profile setup
2. **Invite → Join** — Deep link, auth, join trip, land on detail
3. **Trip Creation** — Wizard completion, multi-city, date voting
4. **Expenses** — Add, split, settle, receipt OCR
5. **Real-time sync** — Two users on same trip, changes propagate
6. **Offline → Online** — Queued actions sync correctly

## Device Matrix

| Device | OS | Priority |
|--------|-----|---------|
| iPhone 15 Pro | iOS 18 | Primary |
| iPhone 13 | iOS 17 | Primary |
| iPhone SE | iOS 16 | Secondary |
| Pixel 8 | Android 14 | Primary |
| Samsung Galaxy S23 | Android 13 | Secondary |

## Release Process

1. All tests pass (1379+ tests)
2. TypeScript check clean (`npm run typecheck`)
3. Manual QA on primary devices
4. TestFlight build + internal testing
5. App Store submission

## Current Stats

- 1,379 tests passing
- 137K lines of code
- 87 commits in last 7 days
