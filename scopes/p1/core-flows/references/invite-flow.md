# Invite Flow — Functional Requirements

**Assignee:** Asif
**Status:** In Progress
**Phase:** P1: Core App

---

## Overview

The invite flow is Tryps' primary growth mechanism. Every trip is a growth event. Frictionless invite → join → collaborate is the core loop. Three paths: new user (no app), existing user (has app), and owner inviting others.

## Screens

### Flow 2: Invite → Join — New User (12 screens)

| # | Screen | Description | Status |
|---|--------|-------------|--------|
| 2.1 | App Store Redirect | Tap link → App Store | N/A (system) |
| 2.2-2.5 | Auth Flow | Same as onboarding (1.1-1.4) | In Figma |
| 2.6 | Trip Card Hero | Trip overview + "Join This Trip" button | Needs Design |
| 2.7 | "You're In!" | Celebratory confirmation, RSVP auto-confirmed | Needs Design |
| 2.8 | Enter My Vibe | CTA to take Travel DNA | Needs Design |
| 2.9 | Vibe Selection | 10 DNA A/B choices | Needs Design |
| 2.10 | Land on Trip | → Trip Detail, Itinerary tab | Needs Design |
| 2.11 | Expired/Invalid Invite | Error state with fallback | Dev handles |
| 2.12 | Deep Link Lost | "Enter invite code" fallback | Dev handles |

### Flow 3: Invite → Join — Existing User (9 screens)

| # | Screen | Description | Status |
|---|--------|-------------|--------|
| 3.1 | Trip Card Hero | Trip overview + "Join This Trip" | Needs Design |
| 3.2 | "You're In!" | Confirmation | Needs Design |
| 3.3 | Vibe Defaults | Pre-filled from DNA, accept or edit | Needs Design |
| 3.4 | Land on Trip | → Itinerary tab | Needs Design |
| 3.5 | Inviter Context | "Jake invited you" social proof | Dev handles |
| 3.6 | Decline | "Not for me" option | Dev handles |
| 3.7 | Vibe Pre-Fill | Pre-fill from global DNA | Dev handles |
| 3.8 | Removed User Blocked | "No longer part of this trip" | Dev handles |
| 3.9 | Already a Member | "You're already in!" + Open Trip | Dev handles |

### Flow 5: Invite & Share — Owner (11 screens)

| # | Screen | Description | Status |
|---|--------|-------------|--------|
| 5.1 | Quick Invite | Generate link, clipboard, share sheet | Needs Design |
| 5.2 | In-App Invite | Browse mutuals/friends → tap to invite | Needs Design |
| 5.3 | Text Blast | Bulk SMS with custom message | Needs Design |
| 5.4-5.9 | Error/edge states | Mode picker, copy toast, empty, already member, non-Tryps, compose | Dev handles |
| 5.10 | QR Code | Full-screen QR for in-person sharing | Needs Design |
| 5.11 | Pending Invitees | Invited-not-joined list + "Nudge" button | Needs Design |

## Key Rules

- **Invite flow is sacred** — never add friction to invite → join → collaborate
- Shareable links via `https://jointryps.com/trip/{id}`
- Deep link scheme: `tripful://trip/{id}`
- Decline = out of trip entirely (like declining calendar invite)
- Removed users blocked from rejoining via same link
- Phantom participants: invited by phone, no account yet

## Sub-Tasks

1. Invite link generation + deep linking
2. Trip Card Hero (preview-before-join)
3. Join flow (new user path)
4. Join flow (existing user path)

## Open Questions

- Do invite links expire?
- Deferred deep linking through App Store (Branch.io? Custom?)
