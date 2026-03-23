---
name: tryps-release-check
description: Verify EAS build and OTA update alignment before/after releases
user-invocable: true
---

The #1 deployment gotcha: `eas build` ≠ `eas update`. They are independent systems. OTA always wins over the embedded bundle.

### Pre-Release Checks
1. Check latest EAS build status
2. Check latest OTA update on production branch: `eas update:list --branch production --limit 1`
3. Compare OTA update commit hash with latest main: `git log main --oneline -1`
4. If OTA is stale (older than latest build), flag: "⚠️ OTA update is behind the native build. Run `eas update` after submit."
5. Check that `npm install` has been run (new packages from merged PRs)

### Post-Release Checklist
1. Verify `eas submit` completed successfully
2. Verify `eas update --branch production` was run AFTER submit
3. Check TestFlight for new build availability
4. Verify OTA and native build are in sync

### Report Format
```
**Release Check — [date]**

**Native Build:** [version] ([status])
**OTA Update:** [commit] ([date])
**Main HEAD:** [commit] ([date])
**Sync Status:** ✅ In sync / ⚠️ OTA behind / ❌ Mismatch

**Action needed:** [specific commands to run, if any]
```
