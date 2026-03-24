---
name: tryps-deploy
description: Automate the TestFlight build and submit flow from the production branch
user-invocable: true
---

# Tryps Deploy

Automate the Tryps TestFlight deployment pipeline. This is the exact flow Asif runs locally, documented as a Marty skill.

## Background

- **EAS Build** runs on Expo's cloud servers — triggered locally from a dev's machine
- **Apple credentials are auto-managed by EAS** — when prompted for Apple account during build, always select "no" so EAS picks up credentials automatically
- **Builds always come from the `production` branch**
- **The app is not public yet** — TestFlight is used for internal team testing only
- **OTA updates (`eas update`) are not used currently.** When we go to production with real users, OTA will become relevant for pushing JS-only fixes without a full rebuild. For now, every change goes through a full build + TestFlight submit.
- **EAS Project ID:** `29cef860-587f-4625-ad6c-3f8ece4e311c`
- **TestFlight link:** `https://testflight.apple.com/join/6ya1fwnT`

## The TestFlight Flow

**Trigger:** Manual invocation only. Requires approval from Jake or Asif.

### Steps

```bash
# 1. Switch to production branch and pull latest
cd $TRYPS_REPO  # Default: ~/t4
git checkout production && git pull

# 2. Install dependencies (picks up any new/updated packages)
npm install

# 3. Pre-flight checks
npm run typecheck
npm test

# 4. Clean prebuild — regenerate native iOS project from scratch
npx expo prebuild --clean

# 5. Build production profile on EAS cloud
#    When prompted for Apple account → select NO (EAS auto-picks from config)
eas build --platform ios --profile production

# 6. Submit the latest build to TestFlight
#    Picks up the most recent successful build automatically
eas submit --platform ios
```

### What Each Step Does

| Step | Command | What Happens |
|------|---------|-------------|
| 1 | `git checkout production && git pull` | Ensures we build from production branch with latest code |
| 2 | `npm install` | Installs new/updated dependencies from package.json |
| 3 | `typecheck` + `test` | Catches type errors and test failures before building |
| 4 | `npx expo prebuild --clean` | Regenerates native project (ios/) from scratch. Required when native dependencies change. |
| 5 | `eas build --platform ios --profile production` | Sends build job to EAS cloud. Apple signing handled automatically by EAS. ~7 min. |
| 6 | `eas submit --platform ios` | Picks up the latest successful production build and submits to TestFlight. ~2 min. |

### Important: Apple Account Prompt

During `eas build`, EAS may ask:

```
Would you like to log in to your Apple account? (Y/n)
```

**Always select `n` (no).** EAS has the Apple credentials stored in its config and will use them automatically. Entering credentials manually can cause conflicts.

## What Marty Does Autonomously vs. Human-Gated

| Action | Autonomous? | Why |
|--------|------------|-----|
| Pre-flight checks (typecheck, test) | Yes | Read-only validation |
| Build + submit (`testflight`) | **No — requires Asif or Jake approval** | Sends build to real beta testers |
| App Store production submission | **NEVER** | Manual only, through App Store Connect UI |

## Safeguards — What Marty Must NEVER Do

1. **NEVER submit to App Store production** — only TestFlight. App Store submission is always manual by Jake in App Store Connect.
2. **NEVER build from any branch except `production`**
3. **NEVER skip `npm install`** — new dependencies won't be picked up
4. **NEVER skip `npx expo prebuild --clean`** — building without it can ship stale native code
5. **NEVER enter Apple credentials manually** — always select "no" and let EAS auto-pick
6. **NEVER run `eas update`** — we don't use OTA updates currently. This will change when we go to production.

## Error Recovery

| Error | Cause | Fix |
|-------|-------|-----|
| "Credentials not found" | EAS can't find Apple certs | Run `eas credentials` to check status. Let EAS auto-manage. |
| "Build failed: native dependency" | Pod install or native module issue | Run `npx expo prebuild --clean` and retry |
| "Build number already submitted" | Duplicate build number | Auto-increment should handle this. If not, bump `buildNumber` in app.json |
| New config plugin breaks build | Plugin creates native target without credentials | Run `eas credentials:configure-build -p ios` locally for the new target |

## Known Gotchas

1. **EAS slug is `vamos`** — immutable, tied to EAS project. Don't change it.
2. **Sentry auto-upload disabled** in production profile (`SENTRY_DISABLE_AUTO_UPLOAD: true`) — intentional to speed up builds.
3. **Beta App Review requires:** privacy policy live at `jointripful.com/privacy`, demo account credentials, all permission descriptions present.
4. **Build resource class is `m-medium`** — don't upgrade without checking cost.

## Future: OTA Updates (Post-Launch)

When the app goes to production with real users, we'll add `eas update` as a step after `eas submit` to push JS-only hotfixes without requiring a full rebuild. This will also add a `check` mode to verify the OTA bundle matches the native build. Not needed until we have App Store users.
