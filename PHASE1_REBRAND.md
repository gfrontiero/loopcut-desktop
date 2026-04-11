# Phase 1: Screenpipe → Loopcut Rebrand

**Goal:** Replace all "screenpipe" references with "Loopcut" to create a white-label fork.

**Approach:** Systematic find/replace across the codebase, starting with the most critical files.

## Priority 1: Package Identifiers (CRITICAL - breaks builds if wrong)

### Rust (Cargo.toml files)
- [ ] `/Cargo.toml` - Main workspace config
  - `repository = "https://github.com/screenpipe/screenpipe"` → `"https://github.com/loopcut/loopcut-desktop"`
  - Package names in `[workspace.package]`
- [ ] `/crates/*/Cargo.toml` - All crate manifests (10+ files)
  - `name = "screenpipe-*"` → `"loopcut-*"`
  - Update dependencies that reference screenpipe crates

### JavaScript/TypeScript (package.json files)
- [ ] `/packages/*/package.json` - All npm packages
  - `"name": "screenpipe-*"` → `"loopcut-*"`
  - Update dependencies

### App Configuration
- [ ] `/apps/screenpipe-app-tauri/src-tauri/tauri.conf.json`
  - `identifier` field (app bundle ID)
  - `productName` field
  - Window titles

## Priority 2: Visible Branding (USER-FACING)

### UI Text
- [ ] All `.tsx` and `.ts` files in `/apps/screenpipe-app-tauri/`
  - Window titles
  - App name in UI
  - Help text
  - Error messages

### Documentation
- [ ] `README.md` - Main project readme
- [ ] `/docs/**/*.md` - All documentation
- [ ] `LICENSE` - Update copyright holder if needed

### Assets
- [ ] App icons (`.icns`, `.ico`, `.png`)
- [ ] Logo files
- [ ] Splash screens

## Priority 3: Code References (INTERNAL)

### Function/Variable Names
- [ ] Search for `screenpipe` in function names
- [ ] Search for `SCREENPIPE` in constants
- [ ] Update only if user-visible or breaks builds

### Comments
- [ ] Update comments that mention "screenpipe" (nice-to-have, not critical)

## Exclusions (DON'T TOUCH)

- ❌ `.git/` directory
- ❌ `node_modules/`
- ❌ `target/` (Rust build artifacts)
- ❌ Binary files
- ❌ Third-party dependencies

## Systematic Approach

1. **Find all occurrences:**
   ```bash
   grep -r "screenpipe" \
     --include="*.rs" \
     --include="*.toml" \
     --include="*.json" \
     --include="*.ts" \
     --include="*.tsx" \
     --include="*.md" \
     . | wc -l
   ```

2. **Replace in batches:**
   - Batch 1: Cargo.toml files (package names)
   - Batch 2: package.json files (npm packages)
   - Batch 3: App config (tauri.conf.json)
   - Batch 4: UI text (.tsx files)
   - Batch 5: Documentation

3. **Test after each batch:**
   - Try to build: `cargo build`
   - Check for broken imports
   - Fix any issues before next batch

## Expected Outcome

After Phase 1:
- ✅ All package names say "loopcut"
- ✅ App displays as "Loopcut" to users
- ✅ Builds successfully with new names
- ✅ No visible "screenpipe" branding
- ⏳ Still needs: custom styling, analysis layer, packaging (Phase 2-3)

## Hand-off to Claude Code

**Task for Claude:**
1. Start with Priority 1 (package identifiers)
2. Work through each Cargo.toml file
3. Update package.json files
4. Verify builds after each batch
5. Report any conflicts or issues
6. Move to Priority 2 only after Priority 1 is complete

**Safety:**
- Don't replace in `.git/`, `node_modules/`, `target/`
- Test builds frequently
- Commit after each successful batch
- If something breaks, revert and try again
