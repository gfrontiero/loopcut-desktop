#!/bin/bash
cd /Users/miagrey/.openclaw/workspace/loopcut-desktop

echo "=== PHASE 2: UI BRANDING ==="
echo "Started: $(date)"
echo ""

claude --dangerously-skip-permissions -p "Read PHASE2_UI_BRANDING.md and execute Priority 1.

Find all .tsx and .ts files under apps/screenpipe-app-tauri/src/ that contain user-facing text with 'screenpipe' and replace with 'Loopcut'.

Focus on:
- Window titles
- Button labels  
- Help text
- Error messages
- Any text the user sees

Report each file you modify and what you changed."

EXIT_CODE=$?
echo ""
echo "========================================="
echo "PHASE 2 COMPLETE - EXIT CODE: $EXIT_CODE"
echo "Finished: $(date)"
echo "========================================="

openclaw system event --text "Loopcut Phase 2 UI branding finished (exit $EXIT_CODE)" --mode now

sleep 999999
