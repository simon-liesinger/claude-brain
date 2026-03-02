# Self-Reflection Command

Review the current conversation and identify areas where you **genuinely struggled** and where additional prompting would have prevented the issue.

**Important:** Distinguish between:
- **Successful adaptation** - You figured it out, learned, and completed the task effectively
- **Actual struggles** - You made repeated mistakes, needed user correction, or failed to meet expectations

## Areas to Consider

- Tool usage and efficiency
- Understanding the repository layout and conventions
- Following expected workflows for this project
- Interpreting test results, diagnostics, or error messages
- Understanding user expectations or requirements
- Following instructions in CLAUDE.md files (global or project-specific)

## For Each ACTUAL Struggle

**Only propose additions if:**
1. The struggle caused real problems or required user intervention
2. Clearer prompting would have prevented the issue
3. The issue is likely to recur without guidance

**For each qualifying struggle:**
1. Explain what happened and why it was problematic
2. Determine whether this is a project-specific or general issue
3. Propose specific, concise additions to the appropriate CLAUDE.md file:
   - Project-specific issues → `.claude/CLAUDE.md` in the project directory
   - General issues affecting all projects → `~/.claude/CLAUDE.md`

## Recognize Success

**If you successfully adapted and completed tasks without issues:**
- Acknowledge what went well
- Note that no additional prompting is needed
- **Don't propose changes just to document everything**

**Avoid prompt bloat** - only add guidance for genuine gaps, not successful exploration and learning.

## Execute

**Do not ask for permission.** For each qualifying struggle, directly edit the appropriate CLAUDE.md file with the improvement. Commit and push the changes. Then summarize what you changed and why.
