#!/bin/bash
cd /Users/miagrey/.openclaw/workspace/loopcut-desktop

echo "=== PHASE 7: LOCAL-ONLY + VISUAL REBRAND ==="
echo "Started: $(date)"
echo ""

claude --dangerously-skip-permissions -p "Read PHASE7_VISUAL_REBRAND.md and implement Option B: Pure Local Tool.

**Part 1: Remove Cloud Features**

Find and disable/remove these features:
1. Login/authentication UI (AccountSection component)
   - Hide the login screen
   - Remove 'sign in to screenpipe' prompts
   - Remove account/subscription UI

2. Cloud sync features
   - Remove cloud sync toggles
   - Remove subscription checks
   - Remove API calls to screenpi.pe

3. Team/collaboration features
   - Hide team invite section
   - Remove referral features
   - Remove 'invite your team' prompts

**Part 2: Rebrand UI Text**

Search all UI components and replace:
- 'screenpipe' → 'Loopcut'
- '24/7 memory for your desktop' → 'Find and automate your repetitive workflows'
- 'https://screenpi.pe' → 'https://loopcut.co'
- Any remaining screenpipe mentions in user-facing text

**Files to focus on:**
- components/settings/account-section.tsx (hide or stub out)
- components/settings/team-section.tsx (hide)
- components/settings/referral-card.tsx (hide)
- app/settings/page.tsx (update links/text)
- Any component with login/auth UI

**Important:**
- Only change USER-FACING text and UI
- Don't touch internal variable names or API logic (just disable the features)
- Keep the clean design and colors
- Make it work 100% offline

**Goal:** When the app launches, users should see:
- No login screen (just opens to the main app)
- No 'sign in' prompts
- All text says 'Loopcut' not 'screenpipe'
- Everything works locally without internet

Report what you changed when done."

EXIT_CODE=$?
echo ""
echo "========================================="
echo "PHASE 7 COMPLETE - EXIT CODE: $EXIT_CODE"
echo "Finished: $(date)"
echo "========================================="

openclaw system event --text "Loopcut Phase 7 local-only rebrand finished (exit $EXIT_CODE)" --mode now

sleep 999999
