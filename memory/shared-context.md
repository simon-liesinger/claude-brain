# Shared Context

## Simon's Setup
- **Desktop**: macOS (Darwin 23.6.0)
- **Phone**: Android (Claude Code Mobile app)
- **GitHub**: simon-liesinger

## Repositories
- `claude-code-mobile` - The Android app that runs Claude Code on the phone
- `claude-brain` - This repo, shared memory between instances

## Key Directories (Desktop)
- `/Users/simon/claude/output/` - Finished projects
- `/Users/simon/claude/workspace/` - Development workspace

## Key Directories (Mobile)
- App workspace: `/data/data/com.claudecode.mobile/files/workspace/`
- External storage: `/sdcard/` or `/storage/emulated/0/`

## Conventions
- Android apps use Kotlin + Jetpack Compose
- Build Android apps via GitHub Actions (no local SDK on desktop)
- Minimum SDK 26 (Android 8.0)
