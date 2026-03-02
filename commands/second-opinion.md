Use the wrapper script to get Codex's second opinion on the current context:

```bash
~/.claude/skills/second-opinion/codex-opinion "Your question or prompt here"
```

The wrapper automatically:
- Passes the current conversation log path so Codex has full context
- Runs with `--full-auto` for tool access
- Works from the current working directory

For richer context, pipe in relevant code or diffs:
```bash
git diff | ~/.claude/skills/second-opinion/codex-opinion "Review these changes"
```

See `~/.claude/skills/second-opinion/SKILL.md` for detailed usage guidance.
