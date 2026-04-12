# Phase 3: Directory Renames

**Goal:** Rename all `screenpipe-*` directories to `loopcut-*` and update references.

**Status:** Phases 1-2 complete (package IDs + UI text). Now renaming actual directories.

## Directories to Rename

### Crates (Rust libraries)
- [ ] `crates/screenpipe-a11y/` → `crates/loopcut-a11y/`
- [ ] `crates/screenpipe-apple-intelligence/` → `crates/loopcut-apple-intelligence/`
- [ ] `crates/screenpipe-audio/` → `crates/loopcut-audio/`
- [ ] `crates/screenpipe-config/` → `crates/loopcut-config/`
- [ ] `crates/screenpipe-connect/` → `crates/loopcut-connect/`
- [ ] `crates/screenpipe-core/` → `crates/loopcut-core/`
- [ ] `crates/screenpipe-db/` → `crates/loopcut-db/`
- [ ] `crates/screenpipe-engine/` → `crates/loopcut-engine/`
- [ ] `crates/screenpipe-events/` → `crates/loopcut-events/`
- [ ] `crates/screenpipe-screen/` → `crates/loopcut-screen/`
- [ ] `crates/screenpipe-vault/` → `crates/loopcut-vault/`

### App Directory
- [ ] `apps/screenpipe-app-tauri/` → `apps/loopcut-app-tauri/`

## After Renaming: Update References

All import statements that reference the old paths need updating:
- `use screenpipe_core::` → `use loopcut_core::`
- `../screenpipe-db` → `../loopcut-db`
- Package dependencies in Cargo.toml files

## Approach

**Do NOT use `git mv`** - it can cause conflicts. Instead:

1. **Rename directories with regular `mv`:**
   ```bash
   mv crates/screenpipe-core crates/loopcut-core
   ```

2. **Find and replace import statements:**
   ```bash
   # Find all Rust files with screenpipe imports
   grep -r "use screenpipe_" crates/ apps/ --include="*.rs"
   
   # Replace in files
   find . -name "*.rs" -exec sed -i '' 's/use screenpipe_/use loopcut_/g' {} +
   find . -name "*.rs" -exec sed -i '' 's/screenpipe_/loopcut_/g' {} +
   ```

3. **Update path references in Cargo.toml:**
   ```bash
   find . -name "Cargo.toml" -exec sed -i '' 's/screenpipe-/loopcut-/g' {} +
   ```

4. **Test build:**
   ```bash
   cargo check
   ```

## Expected Outcome

After Phase 3:
- ✅ All directories named `loopcut-*`
- ✅ All imports updated
- ✅ Project builds successfully
- ⏳ Still needs: color scheme (Phase 4), packaging (Phase 5+)

## Safety

- Work in batches (rename 3-4 dirs, update refs, test)
- Commit after each successful batch
- If build breaks, revert last change and debug

## Hand-off to Claude Code

**Task:**
1. Rename all `crates/screenpipe-*` directories to `crates/loopcut-*`
2. Rename `apps/screenpipe-app-tauri` to `apps/loopcut-app-tauri`
3. Update all Rust import statements (`use screenpipe_*` → `use loopcut_*`)
4. Update all path references in Cargo.toml files
5. Try to build (`cargo check`) and report any errors
6. Commit successful changes

Work systematically. Report each directory renamed and reference updated.
