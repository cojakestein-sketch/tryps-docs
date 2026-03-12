# Auth & Onboarding — Functional Requirements

**Assignee:** Asif
**Status:** In Progress
**Phase:** P1: Core App

---

## Overview

Complete authentication and onboarding system. Users can sign up via Phone OTP or Apple Sign-In, set up their profile, and land on the app ready to create or join trips.

## Screens

### Flow 1: New User Onboarding (12 screens)

| # | Screen | Description | Status |
|---|--------|-------------|--------|
| 1.1 | Welcome | Logo, tagline, CTA | In Figma |
| 1.2 | Phone Entry | Phone number + country code + Apple Sign-In | In Figma |
| 1.3 | OTP Verify | 6-digit code, resend countdown | In Figma |
| 1.4 | Profile Setup | Display name, avatar, countries visited | In Figma |
| 1.5 | Contacts Permission | Optional contacts access (can skip) | Needs Design |
| 1.6 | Trips Home (empty) | Empty state: "Create your first trip" | Needs Design |
| 1.7 | Phone — Invalid | Inline error for bad phone | Dev handles |
| 1.8 | OTP — Wrong Code | "Incorrect code, try again" | Dev handles |
| 1.9 | OTP — Expired | "Code expired" + resend CTA | Dev handles |
| 1.10 | OTP — Max Retries | "Too many attempts, wait X minutes" | Dev handles |
| 1.11 | Apple Sign-In | Apple ID flow, prompt for phone if not linked | Dev handles |
| 1.12 | Loading States | Spinners between OTP → profile → home | Dev handles |

## Technical Details

- **Supabase Auth** for Phone OTP
- **Apple Sign-In** via Expo AuthSession
- **Profile stored in** `user_profiles` table with RLS
- **Phone normalization:** strip `+` prefix before comparing with `auth.users`
- **ensureProfile pattern:** on `SIGNED_IN`, check profile exists
- **Display name fallback:** `display_name` → `full_name` → email split → "Guest"
- **Onboarding gate:** check `onboarding_completed` before routing

## Sub-Tasks

1. Phone OTP flow (send, verify, session)
2. Apple Sign-In integration
3. Profile setup screen + storage
4. Contacts permission flow
5. Onboarding gate + routing logic

## Open Questions

- Is display name required or can user skip?
- Does Apple Sign-In skip OTP entirely, or is phone still required?
- Deferred deep linking through App Store?
