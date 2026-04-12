#!/bin/bash
cd /Users/miagrey/.openclaw/workspace/loopcut-desktop

echo "=== PHASE 4: COLOR SCHEME UPDATE ==="
echo "Started: $(date)"
echo ""

claude --dangerously-skip-permissions -p "Read PHASE4_COLORS.md and update the color scheme.

Search for screenpipe's purple/blue colors and replace with Loopcut's dark + green theme:

**Colors to find and replace:**
- Purple hex: #5E6AD2 → #00ff88 (neon green)
- Purple variants: #4e5ac2, #6b7df2 → #00ff88
- Tailwind purple classes (bg-purple-*, text-purple-*) → equivalent green

**Where to look:**
- apps/loopcut-app-tauri/src/**/*.tsx (component files)
- apps/loopcut-app-tauri/src/**/*.css (stylesheets)
- tailwind.config.* (Tailwind configuration)

**Focus on:**
- Button colors
- Accent colors
- Highlighted elements
- Brand colors

Leave semantic colors (error red, success green, warning yellow) unchanged.

Report each file you modify and what colors you changed."

EXIT_CODE=$?
echo ""
echo "========================================="
echo "PHASE 4 COMPLETE - EXIT CODE: $EXIT_CODE"
echo "Finished: $(date)"
echo "========================================="

openclaw system event --text "Loopcut Phase 4 color scheme finished (exit $EXIT_CODE)" --mode now

sleep 999999
