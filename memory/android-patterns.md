# Android Development Patterns

## Build Process (No Local SDK)
1. Create project in workspace
2. Push to GitHub
3. GitHub Actions builds the APK
4. Download artifact or use `gh run download`
5. Install on phone via ADB or file transfer

## Project Template
- Kotlin + Jetpack Compose
- compileSdk 34, minSdk 26, targetSdk 34
- AGP 8.2.2, Kotlin 1.9.22
- Gradle 8.5 wrapper
- Java 17

## Common Dependencies
- compose-bom:2024.02.00
- okhttp:4.12.0
- coroutines:1.7.3
- lifecycle-viewmodel-compose:2.7.0
