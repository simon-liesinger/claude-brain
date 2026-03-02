---
name: acquiring-skills
description: Create new Claude Code skills. Use when the user asks to write, create, or add a new skill, or asks to document a workflow as a skill. Also use when the user mentions SKILL.md or ~/.claude/skills/.
allowed-tools: Read, Write, Edit, Bash, Glob
---

# Creating Claude Code Skills

This skill covers how to create new skills for Claude Code.

## Skill Locations

Skills can be stored at three levels:

| Location | Path | Applies to |
|----------|------|------------|
| **Personal** | `~/.claude/skills/<skill-name>/` | You, across all projects |
| **Project** | `.claude/skills/<skill-name>/` | Anyone working in this repository |
| **Plugin** | Bundled with plugins | Anyone with the plugin installed |

**Project skills** are committed to version control - anyone who clones the repository gets them automatically.

**Personal skills** are for workflows you use across multiple projects.

## Skill File Structure

Each skill directory contains a `SKILL.md` file with:

1. **YAML frontmatter** (required)
2. **Markdown content** describing the skill

## YAML Frontmatter Format

```yaml
---
name: skill-name
description: One-line description of when to use this skill. Use when the user asks X, wants Y, or needs Z.
allowed-tools: Read, Edit, Write, Bash, Glob, Grep
---
```

### Frontmatter Fields

- **name**: Short identifier for the skill (should match directory name)
- **description**: Explains when Claude should activate this skill. Write it as trigger conditions:
  - "Use when the user asks to..."
  - "Use when the user wants to..."
  - "Use when working with X and Y happens..."
- **allowed-tools**: Comma-separated list of tools the skill may use

### Available Tools

Common tools to include in `allowed-tools`:
- `Read` - Read files
- `Write` - Create new files
- `Edit` - Modify existing files
- `Bash` - Run shell commands
- `Glob` - Find files by pattern
- `Grep` - Search file contents
- `WebFetch` - Fetch web pages
- `WebSearch` - Search the web

## Markdown Content Guidelines

After the frontmatter, write clear documentation:

1. **Overview** - What the skill does and when to use it
2. **Principles** - Key rules or constraints to follow
3. **Workflow** - Step-by-step process
4. **Commands/Examples** - Specific commands or code snippets
5. **Common Patterns** - Frequently used approaches
6. **Notes** - User-specific context (locations, preferences, etc.)

## Example Skill

```markdown
---
name: example-skill
description: Handle X tasks. Use when the user asks about X, wants to do Y, or needs help with Z.
allowed-tools: Read, Edit, Bash
---

# Example Skill

This skill handles X.

## Overview

Brief description of what this skill does.

## Workflow

1. First step
2. Second step
3. Third step

## Commands

\`\`\`bash
example command
\`\`\`

## Notes

- User-specific detail 1
- User-specific detail 2
```

## Creating a New Skill

### Personal Skill (applies to all your projects)

1. **Create the directory**:
   ```bash
   mkdir -p ~/.claude/skills/<skill-name>
   ```

2. **Create SKILL.md** with frontmatter and content

3. **Commit to the .claude repo**:
   ```bash
   cd ~/.claude
   git add skills/<skill-name>
   git commit -m "Add <skill-name> skill"
   git push
   ```

### Project Skill (shared with collaborators)

1. **Create the directory** in the project:
   ```bash
   mkdir -p .claude/skills/<skill-name>
   ```

2. **Create SKILL.md** with frontmatter and content

3. **Commit to the project repository** so collaborators get the skill too

## Writing Good Descriptions

The `description` field determines when Claude activates the skill. Write it to match user intent:

**Good descriptions:**
- "Manage the user's TODO list. Use when the user asks about tasks, wants to add/update TODOs, or asks what needs to be done."
- "Create minimal working examples from Lean errors. Use when the user asks to minimize an error or create an MWE."
- "Synchronize the home git repo. Use when git pull fails or the user asks to sync their home directory."

**Bad descriptions:**
- "A skill for TODOs" (too vague, no trigger conditions)
- "This handles git stuff" (unclear when to activate)

## Skill Development Process

Creating a good skill requires practice and iteration, not just documentation.

**Personal vs. project skill?** Before you start, decide where the skill belongs:
- **Project skill** (`.claude/skills/`): Only useful for this specific codebase
- **Personal skill** (`~/.claude/skills/`): Useful across multiple projects

**Default to personal.** If there's any doubt, put it in `~/.claude/skills/`. You can always move it later, and personal skills are easier to maintain (one location, synced across machines).

### 1. Practice First

Before writing SKILL.md, perform the workflow manually in the current session. If you've already been doing the task, you have the context you need. If not, do it now.

**Why this matters:**
- Instructions grounded in real experience are more accurate
- You'll discover edge cases and gotchas
- You'll know which steps are error-prone

**Don't skip this.** Theoretical documentation leads to skills that don't work in practice.

### 2. Identify Helper Scripts

During practice, note:
- Commands you type repeatedly
- Multi-step operations that could be a single script
- Complex logic that's easy to get wrong

These are candidates for helper scripts that live alongside SKILL.md:

```
~/.claude/skills/my-skill/
├── SKILL.md
├── search.sh          # Helper script
├── process.py         # Another helper
└── templates/         # Supporting files
```

### 3. Helper Script Conventions

- **Location**: Store in the skill directory
- **Permissions**: Make executable (`chmod +x`)
- **Documentation**: Include usage comments at the top
- **References**: Call from SKILL.md with the full path (`~/.claude/skills/my-skill/search.sh`)

Example helper script header:
```bash
#!/bin/bash
# Usage: search.sh <query> [--after DATE] [--before DATE]
# Searches the corpus and formats results for the skill workflow
```

### 4. Practice With the Skill

After creating SKILL.md and any helper scripts:

1. Invoke the skill on a real task (not a toy example)
2. Note friction points:
   - Unclear instructions?
   - Missing steps?
   - Scripts that need different arguments?
3. Update immediately based on what you learned

### 5. Iterate

Skills improve through use. Each time you invoke a skill and hit friction:

1. **Stop** and fix the skill right now
2. Don't just work around the problem
3. Commit and push the improvement

A skill that gets used and updated is better than a "perfect" skill written once.

## Updating Existing Skills

When modifying skills, always commit and push to keep machines in sync:

```bash
cd ~/.claude
git add -A
git commit -m "Update <skill-name> skill"
git push
```
