# Phase 2: UI Branding & Visual Identity

**Goal:** Replace all user-facing "screenpipe" references with "Loopcut" and update visual branding.

**Status:** Phase 1 complete (package identifiers done). Now updating what users actually see.

## Priority 1: UI Text & Labels

### Main App (Tauri/React)
- [ ] `/apps/screenpipe-app-tauri/src/**/*.tsx` - All React components
  - Window titles
  - Button labels
  - Help text
  - Error messages
  - Settings labels
  - Onboarding text

### Specific files to check:
- [ ] App title/name in main window
- [ ] Tray menu text
- [ ] Notification messages
- [ ] Welcome screen
- [ ] Settings panel

## Priority 2: Documentation

### User-facing docs
- [ ] `README.md` - Main readme (keep technical details, update branding)
- [ ] `/docs/**/*.md` - All user documentation
- [ ] Help text in app
- [ ] Tooltips

### Update:
- "screenpipe" → "Loopcut" (the product name)
- Keep technical references to underlying tech if needed
- Update any links to screenpipe.store, Discord, etc.

## Priority 3: Color Scheme

### Current: Purple/Blue theme
### Target: Dark + Neon Green (#00ff88)

Files to update:
- [ ] Tailwind config (if exists)
- [ ] CSS variables
- [ ] Component styling
- [ ] Accent colors

**Match loopcut.co aesthetic:**
- Background: #0a0a0a (very dark)
- Primary accent: #00ff88 (neon green)
- Secondary: #00ccff (cyan)
- Text: white/white-60 for hierarchy

## Priority 4: Assets (Logo/Icons)

### Note: We don't have Loopcut assets yet
For now:
- [ ] Remove screenpipe logo references
- [ ] Use text-based branding ("Loopcut" in green)
- [ ] Update app icon to placeholder (can do proper icon later)

## What NOT to change

- ❌ Technical variable names in code (unless user-facing)
- ❌ Function names (internal code)
- ❌ Git history
- ❌ Third-party dependencies
- ❌ Build artifacts

## Systematic Approach

1. **Find all UI text:**
   ```bash
   grep -r "screenpipe" \
     --include="*.tsx" \
     --include="*.ts" \
     apps/screenpipe-app-tauri/src/ | grep -v node_modules
   ```

2. **Replace in categories:**
   - Batch 1: Component text/labels
   - Batch 2: Documentation
   - Batch 3: Styling (colors)
   - Batch 4: Asset references

3. **Test after each batch:**
   - Run the app to verify UI looks correct
   - Check that no broken references
   - Verify branding is consistent

## Expected Outcome

After Phase 2:
- ✅ All visible text says "Loopcut"
- ✅ Dark theme with green accent
- ✅ No user-facing "screenpipe" references
- ✅ Documentation updated
- ✅ App looks like loopcut.co (color scheme)
- ⏳ Still needs: directory renames (Phase 3), packaging (Phase 4)

## Hand-off to Claude Code

**Task:**
1. Search for user-facing "screenpipe" text in .tsx/.ts files
2. Replace with "Loopcut" 
3. Update any color references to use dark + green theme
4. Update README.md to say "Loopcut" as the product name
5. Report each change made

**Safety:**
- Only change user-visible strings
- Don't rename internal functions/variables yet (Phase 3)
- Ask before changing anything ambiguous
