#!/bin/bash
cd /Users/miagrey/.openclaw/workspace/loopcut-desktop

echo "=== PHASE 6: PACKAGING FOR MAC/WINDOWS ==="
echo "Started: $(date)"
echo ""

claude --dangerously-skip-permissions -p "Read PHASE6_PACKAGING.md and attempt to build the Mac installer.

**Step 1: Verify tauri.conf.json**
Check apps/loopcut-app-tauri/src-tauri/tauri.conf.json:
- Confirm app name is 'Loopcut'
- Confirm bundle identifier (should be com.loopcut.app or similar)
- Confirm version is set

**Step 2: Check build dependencies**
Verify we have:
- Rust toolchain (cargo --version)
- Node.js (node --version)
- Tauri CLI

**Step 3: Attempt Mac build**
Run in apps/loopcut-app-tauri:
- npm install (if needed)
- npm run tauri build

**Expected:** This will compile for 10-20 minutes. Let it run.

**Report:**
- If successful: show where the .dmg is located
- If fails: show the full error message
- If missing dependencies: list what's needed

This is a long-running build. Be patient and let the compiler work."

EXIT_CODE=$?
echo ""
echo "========================================="
echo "PHASE 6 COMPLETE - EXIT CODE: $EXIT_CODE"
echo "Finished: $(date)"
echo "========================================="

openclaw system event --text "Loopcut Phase 6 packaging finished (exit $EXIT_CODE)" --mode now

sleep 999999
