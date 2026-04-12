#!/bin/bash
cd /Users/miagrey/.openclaw/workspace/loopcut-desktop

echo "=== PHASE 3: DIRECTORY RENAMES ==="
echo "Started: $(date)"
echo ""

claude --dangerously-skip-permissions -p "Read PHASE3_DIRECTORIES.md and execute the directory renames.

**Important:** Do this systematically:

1. First, rename all crate directories:
   - crates/screenpipe-a11y → crates/loopcut-a11y
   - crates/screenpipe-apple-intelligence → crates/loopcut-apple-intelligence
   - (continue for all 11 crates listed in the plan)

2. Then rename the app directory:
   - apps/screenpipe-app-tauri → apps/loopcut-app-tauri

3. After ALL renames are done, update Rust import statements:
   - Find files with 'use screenpipe_' and replace with 'use loopcut_'
   - Find files with 'screenpipe_' in code and replace with 'loopcut_'

4. Update Cargo.toml path references

5. Try 'cargo check' to verify the build works

Report each step clearly."

EXIT_CODE=$?
echo ""
echo "========================================="
echo "PHASE 3 COMPLETE - EXIT CODE: $EXIT_CODE"
echo "Finished: $(date)"
echo "========================================="

openclaw system event --text "Loopcut Phase 3 directory renames finished (exit $EXIT_CODE)" --mode now

sleep 999999
