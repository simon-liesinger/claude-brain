---
name: browser-automation
description: Use when WebFetch fails due to JavaScript-heavy content, access restrictions, or forbidden responses. Uses the Playwright MCP to automate a real browser.
allowed-tools: mcp__playwright__*, Bash
---

**IMPORTANT:** Do NOT use this skill if there is a specialized skill available for the website. For example, use the `zulip` skill for Zulip URLs instead of browser automation.

Use the Playwright MCP tools (`mcp__playwright__*`) to navigate and interact with the page.

## Configuration

The Playwright MCP is configured in `~/.claude.json` under `mcpServers.playwright`.

**Headless mode:** Add `--headless` to args to run without a visible window. Changes require restarting Claude Code.

**Chrome profile:** Use `--user-data-dir=/path/to/profile` to reuse an existing Chrome profile (with logins). Chrome must not be running with that profile simultaneously.

To find Chrome profile name mapping:
```bash
python3 -c "
import json
with open('$HOME/Library/Application Support/Google/Chrome/Local State') as f:
    d = json.load(f)['profile']['info_cache']
    for k, v in d.items():
        print(f'{k}: {v.get(\"name\", \"?\")}')"
```

Profiles live at `~/Library/Application Support/Google/Chrome/{Default,Profile 1,Profile 2,...}`.

## Local Profile Setup

The MCP is configured to use `~/.claude/skills/browser-automation/chrome-profile`. If this directory is missing (e.g., on a new machine), walk the user through creating it:

1. Open Chrome and create a new profile named "claude-playwright"
2. Find its directory with the profile mapping command above
3. Move it: `mv ~/Library/Application\ Support/Google/Chrome/Profile\ N ~/.claude/skills/browser-automation/chrome-profile`
4. Restart Claude Code
