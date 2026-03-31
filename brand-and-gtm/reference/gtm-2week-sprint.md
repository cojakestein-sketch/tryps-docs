---
title: "GTM 2-Week Sprint — What the Team Ships Before Launch"
date: 2026-03-31
owner: jake
status: active
---

# GTM 2-Week Sprint

> 10 deliverables. 2 weeks. Every item has a verifiable "done" test.
> This is what the Growth Engineer and Infra Engineer ship between hire date and launch prep.

## The 10 Things

| # | Deliverable | Owner | Scope | Done when... |
|---|-------------|-------|-------|-------------|
| 1 | **15-sec product demo clip** — screen-record the Tryps app, edit into a polished product demo with text overlays, transitions, and branded elements. Reference: @claudeai on X, Partiful's App Store video. | Growth Eng | 09 App Store | A 15-sec clip exists that Jake and Sean both say "yes, this is the quality bar." This is the audition. |
| 2 | **App Store copy** — title (30 chars), subtitle (30 chars), description (4000 chars), keyword field. Submitted to Apple for review. | Growth Eng | 09 App Store | Copy is live in App Store Connect and approved by Apple. |
| 3 | **10 social content pieces** — screen recordings, carousels, or clip edits using brand templates. Scheduled in Buffer. | Growth Eng | 02 Socials | 10 posts visible in Buffer queue, approved by Sean. |
| 4 | **Landing page copy + design** — jointryps.com redesign with clear value prop, "text Tryps" demo, download CTA, email capture. | Growth Eng | 07 SEO | New landing page is live, loads in under 2 seconds, has email capture working. |
| 5 | **Ad-hoc design tasks** — link preview card for trip invites, logo finalization, any blocking design needs from product or Sean. | Growth Eng | Various | Each task marked done by requester (Jake/Sean/Asif). |
| 6 | **Social scheduling connected** — Buffer or Metricool set up across all 8 platforms (TikTok, IG, X, YouTube, Facebook, LinkedIn, Snapchat, Pinterest). Auto-repost configured. | Infra Eng | 02 Socials | Post one test post from Buffer, verify it appears on all 8 platforms. |
| 7 | **Meta pixel + Loops + email capture** — Meta pixel firing on jointryps.com with conversion events. Loops configured with welcome email. Waitlist capturing emails. | Infra Eng | 10, 11 | Open jointryps.com, submit email, receive welcome email. Check Meta Events Manager shows pixel firing. |
| 8 | **Creator tool recommendation** — trial Stormy AI, Modash, and HypeAuditor. Run Sean's criteria through each. Written recommendation with pros/cons. | Infra Eng | 03 UGC | 1-page doc delivered to Sean + Jake with tool recommendation and reasoning. Sean agrees. |
| 9 | **Affiliate links + Branch** — jointryps.com/go/{creator} redirect pages live. Branch SDK deployed (coordinated with Asif). Click tracking verified. | Infra Eng | 03, 08 | Click a /go/ link, verify it opens iMessage pre-filled with Tryps number. Branch dashboard shows the click. |
| 10 | **App Store keyword tracking + Slack alerts** — ASO.dev configured with initial keyword targets. n8n automation: new App Store reviews auto-post to Slack. UTM naming convention doc shared so every link is trackable. | Infra Eng | 09, 13 | ASO.dev shows keyword rankings for "group trip planner." A test review appears in Slack automatically. UTM doc is in shared drive. |

## What's NOT in this sprint

- **Paid ads** (scope 10) — Meta pixel is installed but campaigns don't start until post-launch, after organic content proves what works.
- **Press pitches** (scope 12) — journalist list gets built in week 2, but pitches go out launch week, not before.
- **Dashboards** (scope 13) — Looker Studio comes in weeks 3-4. No data to track until we're live.
- **Remotion templates** (scope 02) — the Growth Engineer does clips manually first. Infra Engineer builds the template pipeline in weeks 3-4 after seeing the pattern.
- **App Store video** (scope 09) — the Growth Engineer drafts from whatever app state exists, but final video waits until core flows are stable.
- **Referral strategy** (scope 08) — Jake sets strategy, product team builds. GTM just needs Branch deployed.

## Success test at day 14

| Role | The hire was worth it if... |
|------|---------------------------|
| **Growth Engineer** | They've produced content that is fast, high quality, and aligned with Jake and Sean's vision. The 15-sec demo clip is the proof. |
| **Infra Engineer** | All 8 social platforms are connected, Meta pixel is firing, emails are capturing, creator tool is recommended, and Sean can see the system working. |
