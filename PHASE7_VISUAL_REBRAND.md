# Phase 7: Complete Visual Rebrand

**Goal:** Replace all remaining "screenpipe" branding in the UI with "Loopcut" while keeping the clean design.

**Status:** Phases 1-6 complete (75% done). Need to finish UI text, logos, and links.

## What Needs Fixing (Based on Screenshot)

### 1. Login/Welcome Screen
- ❌ "sp" logo → ✅ "L" or "Loopcut" logo
- ❌ "screenpipe" title → ✅ "Loopcut"
- ❌ "24/7 memory for your desktop" → ✅ "Find and automate your repetitive workflows"
- ❌ "sign in to screenpipe" → ✅ "sign in to loopcut" (or remove login entirely for local-only)
- ❌ screenpi.pe links → ✅ loopcut.co links

### 2. Sidebar/Navigation
- ✅ Already shows "loopcut" in top-left (good!)
- Check: "Pipe AI" → "Automation AI" (if applicable)
- Check: "Invite your team to screenpipe" → "Invite your team to Loopcut"

### 3. Notifications/Prompts
- Window title: "screenpipe-app" → "Loopcut"
- Notification text: any remaining screenpipe mentions

### 4. Settings/Help/About
- ❌ URLs: https://screenpi.pe → https://loopcut.co
- ❌ Email: support@screenpi.pe → support@loopcut.co
- ❌ Documentation links
- ❌ Referral links
- ❌ API endpoints (keep as-is if using screenpipe backend, or remove cloud features)

## Implementation Strategy

### Option A: Keep Cloud Features (Partner with Screenpipe)
- Keep backend API calls to screenpi.pe
- Rebrand all UI text and logos
- Users sign in via screenpipe auth, but see "Loopcut" branding
- **Complexity:** Medium (just UI changes)
- **Risk:** Depends on screenpipe allowing this

### Option B: Pure Local Tool (No Cloud)
- Remove all login/auth flows
- Remove cloud sync features
- Remove subscription checks
- 100% local desktop app
- **Complexity:** Low (remove features)
- **Risk:** None - fully independent

**Recommendation:** Start with Option B (pure local) for MVP. Add cloud features later if needed.

## Files to Update

### UI Text (TypeScript/React)
```bash
# Find all remaining UI mentions of screenpipe
grep -r "screenpipe" apps/loopcut-app-tauri/components --include="*.tsx" | grep -v "// screenpipe —"

# Target files:
- components/settings/account-section.tsx (login UI, API URLs)
- components/settings/team-section.tsx ("invite to screenpipe")
- components/settings/referral-card.tsx (referral links)
- app/settings/page.tsx (help text, links)
```

### Replace:
- "screenpipe" → "Loopcut"
- "24/7 memory for your desktop" → "Find and automate your repetitive workflows"
- "100% local. you own your data." → keep (still true)
- https://screenpi.pe → https://loopcut.co
- support@screenpi.pe → support@loopcut.co (if we set up)

### Logos/Icons
Current icons are screenpipe purple "sp" mark. Need Loopcut equivalents:
- **Quick fix:** Use text "L" in green (#00ff88) on dark background
- **Better:** Design actual logo later

Files to update:
```
apps/loopcut-app-tauri/src-tauri/icons/
- 32x32.png, 128x128.png, etc.
- icon.icns (Mac)
- icon.ico (Windows)
```

For MVP: Generate simple green "L" icons with script.

## Cloud Features Decision

**If keeping cloud (Option A):**
- Update all UI text but keep API endpoints
- Add disclaimer: "Powered by screenpipe technology" (if required)
- Test if screenpipe allows this arrangement

**If going local-only (Option B):**
- Remove `AccountSection` login UI
- Remove cloud sync toggles
- Remove subscription checks
- Hide team/referral features
- App works 100% offline

## Testing After Changes

1. Launch the app
2. Verify no "screenpipe" text visible anywhere
3. Check all links go to loopcut.co (or nowhere)
4. Verify branding is consistent
5. Take screenshots for landing page

## Hand-off to Claude Code

**Task:**
1. Decide: Cloud features or local-only? (Get user input first)
2. Search all UI components for "screenpipe" text
3. Replace with "Loopcut" equivalent
4. Update taglines and descriptions
5. Update all https://screenpi.pe links to https://loopcut.co
6. Generate simple green "L" logo icons (or skip for now)
7. Test build and verify UI shows "Loopcut" everywhere

**Scope:** This is purely UI text/links. Don't touch internal code logic, API names, or variable names.
