# Phase 4: Color Scheme Update

**Goal:** Replace purple/blue screenpipe colors with Loopcut's dark + neon green theme.

**Status:** Phases 1-3 complete. Now updating visual branding to match loopcut.co.

## Target Color Scheme (from loopcut.co)

### Primary Colors
- **Background:** `#0a0a0a` (very dark, almost black)
- **Primary accent:** `#00ff88` (neon green)
- **Secondary accent:** `#00ccff` (cyan)
- **Text primary:** `#ffffff` (white)
- **Text secondary:** `rgba(255, 255, 255, 0.6)` (white 60% opacity)
- **Borders:** `rgba(255, 255, 255, 0.1)` (white 10% opacity)

### Current Screenpipe Colors (to replace)
- Purple: `#5E6AD2`, `#4e5ac2`, etc.
- Blue variants
- Light backgrounds

## Files to Update

### CSS/Tailwind Configuration
- [ ] `apps/loopcut-app-tauri/src/styles/globals.css` (or similar)
- [ ] `tailwind.config.js` or `tailwind.config.ts`
- [ ] Any CSS variable definitions

### Component Styling
- [ ] Look for hardcoded colors in `.tsx` files:
  - `className="bg-purple-*"`
  - `className="text-purple-*"`
  - `style={{ color: '#5E6AD2' }}`
  - Any inline styles with old colors

### Theme Configuration
- [ ] Check for theme files or color constants
- [ ] Look for `colors.ts` or similar config files

## Search Strategy

1. **Find color references:**
   ```bash
   # Purple hex codes
   grep -r "#5E6AD2\|#4e5ac2\|#6b7df2" apps/loopcut-app-tauri/
   
   # Tailwind purple classes
   grep -r "purple-" apps/loopcut-app-tauri/ --include="*.tsx"
   
   # CSS variables
   grep -r "var(--" apps/loopcut-app-tauri/ --include="*.css"
   ```

2. **Replace with Loopcut colors:**
   - Purple → `#00ff88` (green)
   - Blue accents → `#00ccff` (cyan)
   - Light backgrounds → `#0a0a0a` (dark)
   - Borders → `rgba(255, 255, 255, 0.1)`

## Expected Outcome

After Phase 4:
- ✅ App uses dark + green theme matching loopcut.co
- ✅ No purple/blue screenpipe branding
- ✅ Consistent visual identity
- ⏳ Still needs: custom analysis layer, packaging

## Hand-off to Claude Code

**Task:**
1. Search for all color references in the app (hex codes, Tailwind classes, CSS vars)
2. Replace screenpipe purple/blue with Loopcut dark + green:
   - `#5E6AD2` → `#00ff88`
   - Purple Tailwind classes → green equivalents
   - Update CSS variables if they exist
3. Focus on user-visible UI (buttons, accents, highlights)
4. Report each file changed and colors updated

**Safety:**
- Only change UI colors (don't touch error/warning/success colors if they're semantic)
- Test that the app still looks good after changes
- If unsure about a color, ask
