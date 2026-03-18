# Post Trip Review — Dev Feedback

> **Step:** 8/10
> **Status:** Not started
> **Phase:** P1: Core App

**Dev Feedback:**
1: Post-Trip Flow — Issues & Missing Functionality
 -: Bottom sheet flash on completed trips
When returning to a completed trip's detail screen (e.g., on app reload), the post-trip bottom sheet briefly appears and then dismisses itself, even though the user has already completed the flow. It shouldn't appear at all in this case.
2. No access to Time Capsule after dismissing the bottom sheet
-: After tapping "Maybe Later" on the post-trip bottom sheet, the Time Capsule section disappears from the Vibe tab entirely. There's currently no way to view or add to your time capsule submissions once the post-trip sheet is dismissed. There should be a persistent entry point to access the Time Capsule from the Vibe tab (or elsewhere) regardless of the bottom sheet state.
3. No way to mark favorite activities after dismissal
-: The "Pick your favorite activities" flow is only available inside the post-trip bottom sheet. Once the user taps "Maybe Later", there's no way to revisit this. There should be a way to access the favorite activities selection again — either a button on the trip detail screen, or by allowing the bottom sheet to be re-triggered.
4. No status indicator for montage generation
-: After a trip is completed and submissions exist, there's no visual indicator telling the user that their montage hasn't been generated yet (or is processing/failed). There should be a badge, banner, or status label on the Time Capsule or Vibe tab showing the current montage state (e.g., "Generating...", "Ready to watch", "No submissions yet").
This is my feedback can you please ask to fix these issues.

_Dev Feedback to be generated during pipeline execution._
