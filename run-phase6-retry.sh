#!/bin/bash
cd /Users/miagrey/.openclaw/workspace/loopcut-desktop

echo "=== PHASE 6: MAC BUILD (RETRY WITH XCODE) ==="
echo "Started: $(date)"
echo ""
echo "Xcode is now configured. Attempting full build..."
echo ""

cd apps/loopcut-app-tauri

# Clean previous failed build attempt
rm -rf src-tauri/target/release/bundle 2>/dev/null

# Attempt build
npm run tauri build 2>&1

BUILD_EXIT=$?

echo ""
echo "========================================="
echo "BUILD EXIT CODE: $BUILD_EXIT"
echo "Finished: $(date)"
echo "========================================="

if [ $BUILD_EXIT -eq 0 ]; then
    echo ""
    echo "SUCCESS! Looking for .dmg..."
    find src-tauri/target/release/bundle -name "*.dmg" -o -name "*.app" 2>/dev/null | head -5
fi

openclaw system event --text "Loopcut Mac build finished (exit $BUILD_EXIT)" --mode now

sleep 999999
