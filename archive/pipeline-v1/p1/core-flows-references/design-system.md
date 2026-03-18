# Design System — Functional Requirements

**Assignee:** Krisna
**Status:** In Progress
**Phase:** P1: Core App

---

## Overview

Unified design language for Tryps across all screens. Ensures visual consistency, speeds up designer and developer work, and establishes the brand identity in the product.

## Design Tokens

### From Figma (Krisna's design language)

| Token | Value |
|-------|-------|
| Background | #f5f7fa |
| Card background | #ffffff |
| Primary | brand red (from Tryps palette) |
| Font — Headlines | Helvetica Now Display |
| Font — Body | Inter |
| Card radius | 16px |
| Button radius (pill) | 999px |
| Shadow | subtle drop shadows on cards |

### From Code (theme.ts)

| Token | Value |
|-------|-------|
| Font | Plus Jakarta Sans |
| Palette | Warm dark tones |

**Note:** There is a known mismatch between Figma tokens and code theme.ts. Design system work includes reconciling these.

## Components

| Component | Status |
|-----------|--------|
| Button (primary, secondary, outline, ghost) | In Figma |
| Card (trip card, expense card, activity card) | In Figma |
| Input (text, phone, OTP, search) | In Figma |
| Avatar (user, group) | In Figma |
| Badge (status, role, count) | In Figma |
| Tab bar (bottom nav, trip detail tabs) | In Figma |
| Modal / Bottom sheet | In Figma |
| Toast / Snackbar | Needs Design |
| Empty state template | Needs Design |
| Skeleton loading | Needs Design |

## Sub-Tasks

1. Reconcile Figma tokens with code theme.ts
2. Component library audit (what's in Figma vs what's built)
3. Icon set standardization
