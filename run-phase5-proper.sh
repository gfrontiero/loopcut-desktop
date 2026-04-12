#!/bin/bash
cd /Users/miagrey/.openclaw/workspace/loopcut-desktop

echo "=== PHASE 5: ENHANCED ANALYSIS (PROPER) ==="
echo "Started: $(date)"
echo ""

claude --dangerously-skip-permissions -p "Implement the enhanced automation analysis properly.

**Part 1: Update PIPE_SUGGESTION_PROMPT** (apps/loopcut-app-tauri/components/notification-panel/page.tsx around line 701)

Replace the current vague prompt with tool-specific analysis based on /Users/miagrey/.openclaw/workspace/loopcut-app/scripts/analyze-workflows.md

The new prompt should instruct the AI to:
- Extract URLs from OCR text (linkedin.com, gmail.com, hubspot.com, gemini.google.com)
- Detect site-to-site transitions (LinkedIn → Gemini → Gmail)
- Calculate precise time savings (5 min × 5 times/week = 25 min/week)
- Show exact triggers ('Calendar event ends', 'Gmail label applied')
- List specific APIs/tools needed for implementation
- Provide ROI calculations

**Part 2: Enhance build_activity_context** (crates/loopcut-core/src/suggestions.rs)

The function currently builds activity context for the AI. Enhance it to:
- Parse OCR text to extract URLs (look for patterns like 'linkedin.com', 'gmail.com')
- Track app transition sequences (Chrome → Claude → Chrome)
- Include site-specific information in the context

**Format:**
Keep the same JSON output structure but make the suggestions tool-specific instead of generic.

**Test:**
After changes, show me an example of what the new prompt looks like so I can verify it matches our template.

Work systematically. This is the core value-add for Loopcut."

EXIT_CODE=$?
echo ""
echo "========================================="
echo "PHASE 5 PROPER COMPLETE - EXIT CODE: $EXIT_CODE"
echo "Finished: $(date)"
echo "========================================="

openclaw system event --text "Loopcut Phase 5 proper implementation finished (exit $EXIT_CODE)" --mode now

sleep 999999
