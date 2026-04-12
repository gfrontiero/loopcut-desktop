# Phase 6: Packaging for Mac/Windows

**Goal:** Build distributable installers (.dmg for Mac, .exe for Windows) that customers can download.

**Status:** Phases 1-5 complete (65% done). Now building the deliverable product.

## What We're Building

### Mac (.dmg)
- Disk image installer
- Drag-to-Applications folder experience
- Universal binary (Intel + Apple Silicon)
- (Optional) Code signing (can skip for MVP, add later)

### Windows (.exe)
- NSIS or WiX installer
- Standard Windows install flow
- (Optional) Code signing (can skip for MVP)

## Tauri Build System

The app uses Tauri (Rust + web frontend). Tauri has built-in packaging:

```bash
# Build for current platform
npm run tauri build

# This creates:
# - Mac: src-tauri/target/release/bundle/dmg/*.dmg
# - Windows: src-tauri/target/release/bundle/nsis/*.exe
```

## Pre-Build Checklist

### 1. Tauri Config (tauri.conf.json)
- [x] App identifier already updated (Phase 1)
- [ ] Bundle identifier: com.loopcut.app
- [ ] App name: Loopcut
- [ ] Version: 0.1.0
- [ ] Update check URL (if we have one)

### 2. App Icons
- [ ] Replace screenpipe icons with Loopcut icons
  - Mac: `.icns` file
  - Windows: `.ico` file
  - Sizes: 16x16 up to 1024x1024
- [ ] For MVP: Generate simple green "L" logo or use placeholder

### 3. Dependencies
Check that build dependencies are installed:
- Rust toolchain ✓ (already have it)
- Node.js ✓ (already have it)
- Platform-specific:
  - Mac: Xcode command-line tools
  - Windows: Visual Studio Build Tools (if cross-compiling)

## Build Process

### Mac Build (on Mac)
```bash
cd apps/loopcut-app-tauri
npm install
npm run tauri build
```

Expected output:
- `src-tauri/target/release/bundle/dmg/Loopcut_0.1.0_universal.dmg`
- `src-tauri/target/release/bundle/macos/Loopcut.app`

### Windows Build
**Options:**
1. **Build on Windows machine** (need Windows box)
2. **Cross-compile from Mac** (complex, may not work)
3. **Use GitHub Actions** (free CI/CD)
4. **Skip for now** (ship Mac-only MVP, add Windows later)

**Recommendation for MVP:** Ship Mac-only first (we're on Mac, faster to test).

## Testing

After building:
1. Install the .dmg on a clean Mac (or test VM)
2. Verify app launches
3. Verify it can access screen recording (permissions)
4. Run for a few minutes, check database
5. Generate a test automation report

## Distribution

Once built:
1. Upload .dmg to hosting (Vercel blob storage, S3, or GitHub releases)
2. Add download link to loopcut.co
3. Create installation guide

## Code Signing (Optional - Skip for MVP)

**Unsigned apps:**
- Mac: Users see "unidentified developer" warning (can bypass with right-click → Open)
- Windows: SmartScreen warning (can click "More info" → "Run anyway")

**To sign later:**
- Mac: Apple Developer account ($99/year) + Developer ID cert
- Windows: Code signing cert (~$200-400/year)

**MVP approach:** Ship unsigned, add signing after first revenue.

## Expected Outcome

After Phase 6:
- ✅ Mac .dmg installer ready
- ✅ Can distribute to customers
- ✅ Installable, runnable product
- ⏳ Windows version (later)
- ⏳ Code signing (after revenue)

## Hand-off to Claude Code

**Task:**
1. Check tauri.conf.json - verify all Loopcut branding is set
2. Try to build for Mac: `npm run tauri build` in apps/loopcut-app-tauri
3. Report any build errors
4. If it builds successfully, tell me where the .dmg is located

**If build fails:**
- Show the error
- Check for missing dependencies
- We'll debug together

**Note:** This might take 10-20 minutes to compile. Let it run.
