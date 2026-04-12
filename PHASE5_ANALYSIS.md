# Phase 5: Custom Analysis Layer

**Goal:** Add Loopcut's tool-specific automation detection that generates reports like loopcut.co/demo.

**Status:** Phases 1-4 complete (55% done). Now building the core differentiator.

## What Makes Loopcut Different

Screenpipe detects patterns but reports are generic. Loopcut needs to:
1. **Parse Chrome OCR data** to extract specific sites (LinkedIn, Gmail, HubSpot, Gemini)
2. **Detect tool-specific workflows** (e.g., "LinkedIn → Gemini → Gmail" not just "Chrome → Chrome")
3. **Calculate precise ROI** (time saved per automation)
4. **Generate actionable recommendations** (exact trigger, exact actions, exact tools)

## Implementation Approach

### Option A: Enhance Existing Reports
Modify screenpipe's automation report generation to be more specific:
- Location: Likely in `crates/loopcut-engine/` or wherever reports are generated
- Find the AI prompt that analyzes patterns
- Update it to use the template from `/Users/miagrey/.openclaw/workspace/loopcut-app/scripts/analyze-workflows.md`

### Option B: Add Parallel Analysis
Create a new Loopcut-specific analysis module:
- Keep screenpipe's reports as-is
- Add `crates/loopcut-analysis/` with our custom logic
- Run both engines, combine results

**Recommendation: Start with Option A** (modify existing) - simpler, less code.

## Files to Find and Modify

### 1. Locate Report Generation Code
```bash
# Find where automation reports are created
grep -r "automation_report\|automation.candidate\|repetitive.*task" crates/loopcut-engine/
grep -r "AI.*prompt\|llm.*prompt" crates/loopcut-engine/
```

### 2. Find the Analysis Prompt
Look for the prompt that analyzes screen data. It's probably something like:
- "Analyze this screen activity data and find repetitive patterns..."
- Likely in a Rust string or external file

### 3. Update the Prompt
Replace the generic prompt with our tool-specific one from:
`/Users/miagrey/.openclaw/workspace/loopcut-app/scripts/analyze-workflows.md`

Key additions:
- Extract URLs from OCR (linkedin.com, gmail.com, hubspot.com)
- Track site-to-site transitions (LinkedIn → Gemini → Gmail)
- Identify exact tools, not just "browser"
- Calculate weekly frequency (5x/week not "sometimes")
- Show exact triggers ("Calendar event ends" not "after meetings")

## Example Transformation

### Before (Generic):
```
Title: "Email Management Automation"
Description: "Automate email-related tasks"
Time Savings: "2-3 hours/week"
```

### After (Tool-Specific):
```
Title: "Gmail → HubSpot Deal Notes Sync"
Description: "After customer emails, you switch from Gmail to HubSpot, find the deal, and copy/paste key details into deal notes. Happens 12-15 times/week."
Implementation: "TRIGGER: Apply Gmail label 'Log to CRM'. ACTION: Gmail API extracts email → Gemini API summarizes → HubSpot API appends to deal notes."
Time Savings: "60 min/week (4 min × 15 emails)"
ROI: "$2,550/year at $50/hr"
```

## Testing

After changes:
1. Run Loopcut on test data
2. Generate a report
3. Verify it shows tool-specific recommendations (not generic ones)
4. Compare to loopcut.co/demo quality

## Expected Outcome

After Phase 5:
- ✅ Reports show specific tools (LinkedIn, Gmail, HubSpot)
- ✅ Recommendations include exact triggers and actions
- ✅ ROI calculations are precise
- ✅ Matches loopcut.co/demo quality
- ⏳ Still needs: Packaging (Phase 6+)

## Hand-off to Claude Code

**Task:**
1. Find where screenpipe generates automation reports (likely in `crates/loopcut-engine/`)
2. Locate the AI prompt used for analysis
3. Read `/Users/miagrey/.openclaw/workspace/loopcut-app/scripts/analyze-workflows.md`
4. Update the prompt to include:
   - URL extraction from OCR
   - Tool-specific pattern detection
   - Precise time calculations
   - Actionable implementation steps
5. Test if possible, or document where changes were made

**If you can't find the report generation:**
- Search for database writes to `automation_reports` table
- Look for LLM/AI API calls
- Check for prompts mentioning "pattern" or "repetitive"
- Report what you find and we'll investigate together
