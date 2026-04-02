# Missions

> Canonical source of truth for Jake's active missions.
> Marty reads this file when generating standups and nightly reports.
> Add missions here (or via `/mission` in Slack). Do NOT edit missions inside standup docs.
> Last updated: 2026-04-02

---

## Team Goal

**We need to be able to onboard customers to really USE the application ASAP and actually book a trip end to end.** What is stopping us from this reality? This matters more than anything.

---

## Active Missions

### Mission 1: Unified Dashboard View for Standup
**Owner:** Rizwan + Nadeem | **Created:** Apr 1 | **Status:** Done (Rizwan built it)
Single view where Jake can see SC progress, bug counts, PR status, blockers. Dashboard live at cojakestein-sketch.github.io/tryps-exec-dashboard/

### Mission 2: Feedback Mechanism
**Owner:** Nadeem + Asif | **Created:** Apr 1 | **Status:** Partial (shake-to-feedback shipped)
Three channels: shake-to-feedback (done), text keyword `feedback:` to agent, agent-prompted collection. All feedback lands in one triage inbox for Jake.

### Mission 3: Book All Travel — For Yourself or On Behalf
**Owner:** Rizwan + Asif | **Created:** Apr 1 | **Status:** In progress (PR #331)
Flights, hotels, activities, transport — for yourself or on behalf of another traveler. Core value prop.

### Mission 4: Customer Interviews
**Owner:** Asif + Jake | **Created:** Apr 1 | **Status:** Pipeline live at marty.jointryps.com/interview
Automated interview pipeline. Jake provides name + phone, agent calls, runs interview, logs transcript. Goal: first 25 interviews.

### Mission 5: Close the Books
**Owner:** Jake | **Created:** Apr 1 | **Status:** Open
March financials, contractor payments, expenses reconciliation.

### Mission 6: QA Presentation
**Owner:** Asif | **Created:** Apr 1 | **Status:** Done (doc + HTML deck shipped at tryps-docs/QA/)
Asif presents to Jake what QA (Andreas + Warda) is doing. Process, coverage, current state.

### Mission 7: Agent Context Awareness in Group Chats
**Owner:** Asif + Rizwan | **Created:** Apr 2 | **Status:** Open — [Issue #341](https://github.com/cojakestein-sketch/tryps/issues/341)
Agent must know who's in the iMessage group chat. No "send them the link" when they're already here. Native emoji polling for votes.

### Mission 8: Founder Presence Optimization
**Owner:** Jake | **Created:** Apr 2 | **Status:** Open

### Mission 9: Personalized Contact CRM
**Owner:** TBD | **Created:** Apr 2 | **Status:** Open

### Mission 10: Onboarding Flow with Emojis
**Owner:** TBD | **Created:** Apr 2 | **Status:** Open
React with emojis to vote on things, guiding the agent. Emoji-based onboarding that teaches users the interaction model.

---

## Completed Missions

| Mission | Completed | Notes |
|---------|-----------|-------|
| Onboarding Perfection — Deep Rich Link | Mar 25 | OG tags, web landing, trip-card-image, vCard |
| Make the link work | Mar 26 | Duplicate intro fixed, first-touch flow verified |
| Travel booking reality check | Mar 26 | 3-4 week estimate for flight search + pay |
| Calling Tryps | Mar 31 | Voice agent live (ElevenLabs + Linq) |
| Hyper Care (parked post-Apr 2) | Apr 1 | Parked — Rizwan to think about agent-native CS |

---

## Ops Missions (from standup, not Jake-created)

These were identified by Marty from repo/Slack activity — not Jake's direct missions. Track separately.

- Merge PR Backlog (14 open, failing CI)
- Unblock Rizwan SC-59-61 (Asif + Rizwan design session)
- Bug Burn-Down (20 remaining of 78)
