# Claude Brain

Shared repository for Claude Code instances running on Simon's devices.

## Purpose

This repo is the shared memory between:
- **Desktop Claude Code** (macOS, running in terminal/VSCode)
- **Mobile Claude Code** (Android, running as native app)

Both instances should pull at session start and push after making changes.

## Structure

```
skills/       # Reusable slash commands and skill definitions
memory/       # Persistent notes, patterns, and learned information
scripts/      # Useful scripts and automation
configs/      # Shared configuration files
```

## Usage Protocol

1. **Start of session**: `git pull` to get latest changes
2. **After creating/editing shared files**: commit and push
3. **Before editing**: always pull first to avoid conflicts
4. **Conflict resolution**: prefer the most recent version; merge if both are valuable
