#!/bin/bash
cd /Users/miagrey/.openclaw/workspace/loopcut-desktop

echo "=== PHASE 5: CUSTOM ANALYSIS LAYER ==="
echo "Started: $(date)"
echo ""

claude --dangerously-skip-permissions -p "Read PHASE5_ANALYSIS.md and locate the automation report generation code.

**Your mission:**
1. Find where automation reports are generated in the codebase
   - Search in crates/loopcut-engine/ first
   - Look for database writes to 'automation_reports'
   - Find AI/LLM prompts that analyze screen data

2. Once you find the prompt, read the template at:
   /Users/miagrey/.openclaw/workspace/loopcut-app/scripts/analyze-workflows.md

3. Update the analysis prompt to be tool-specific:
   - Extract URLs from OCR (linkedin.com, gmail.com, hubspot.com)
   - Detect site-to-site transitions
   - Calculate precise time savings
   - Show exact triggers and actions

4. If the code is complex or you're unsure:
   - Document what you found
   - Show me the current prompt
   - Explain where it's used
   - I'll help decide the best way to modify it

**Take your time.** This is the most important phase - it's what makes Loopcut valuable."

EXIT_CODE=$?
echo ""
echo "========================================="
echo "PHASE 5 COMPLETE - EXIT CODE: $EXIT_CODE"
echo "Finished: $(date)"
echo "========================================="

openclaw system event --text "Loopcut Phase 5 analysis layer finished (exit $EXIT_CODE)" --mode now

sleep 999999
