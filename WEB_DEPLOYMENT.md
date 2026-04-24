# Forge Web Deployment

Forge is Android-first, but the current app can be built for Flutter web for live testing and review.

## What works on web

- onboarding
- workouts, templates, and history
- nutrition logging
- manual barcode lookup
- barcode camera scanning when the browser supports `mobile_scanner` on HTTPS and the user grants camera access
- body progress
- analytics
- insights
- reminders UI and reminder planning
- optional Supabase-backed sign-in, backup upload, and restore/import preview when configured
- local-first storage through Drift web persistence

## What is Android-only

- Health Connect read/sync
- Android local notification scheduling and delivery
- Android permission/rationale activity plumbing

On web, these areas must stay honest:

- Health Connect shows unavailable / Android-only messaging
- Android notifications do not schedule
- backup/auth stays optional and only works when Supabase values are provided

## Run locally in Chrome

From the project root:

```powershell
& 'C:\src\flutter\bin\flutter.bat' pub get
& 'C:\src\flutter\bin\flutter.bat' run -d chrome
```

With optional Supabase config:

```powershell
& 'C:\src\flutter\bin\flutter.bat' run -d chrome `
  --dart-define=FORGE_SUPABASE_URL=https://YOUR_PROJECT.supabase.co `
  --dart-define=FORGE_SUPABASE_PUBLISHABLE_KEY=YOUR_PUBLISHABLE_KEY
```

## Build web

For a GitHub Pages build under a repository named `forge`:

```powershell
& 'C:\src\flutter\bin\flutter.bat' build web `
  --release `
  --base-href="/forge/" `
  --pwa-strategy=none `
  --no-wasm-dry-run
```

With optional Supabase config:

```powershell
& 'C:\src\flutter\bin\flutter.bat' build web `
  --release `
  --base-href="/forge/" `
  --pwa-strategy=none `
  --no-wasm-dry-run `
  --dart-define=FORGE_SUPABASE_URL=https://YOUR_PROJECT.supabase.co `
  --dart-define=FORGE_SUPABASE_PUBLISHABLE_KEY=YOUR_PUBLISHABLE_KEY
```

If your repository name is not `forge`, change the base href to match the repository path:

- repo `forge` -> `--base-href="/forge/"`
- repo `my-fitness-app` -> `--base-href="/my-fitness-app/"`

## GitHub Pages deployment

The workflow file is:

- [.github/workflows/deploy_web.yml](.github/workflows/deploy_web.yml)

It:

- runs on pushes to `main`
- runs manually with `workflow_dispatch`
- installs Flutter
- runs `flutter pub get`
- runs `flutter analyze`
- runs `flutter test`
- builds `build/web`
- deploys to GitHub Pages using the official Pages actions flow

The workflow automatically uses the repository name for `--base-href`, so the same workflow can work for `forge` or another repo name without code changes.

GitHub Pages deployment also disables Flutter's PWA service worker with `--pwa-strategy=none` to avoid stale cached assets causing blank-page deploys after updates.

## GitHub secrets for Supabase

If you want optional web sign-in and backup upload in GitHub Pages builds, set these repository secrets:

- `FORGE_SUPABASE_URL`
- `FORGE_SUPABASE_PUBLISHABLE_KEY`

On GitHub:

1. Open the repository
2. Go to `Settings`
3. Go to `Secrets and variables` -> `Actions`
4. Add the two secrets above

If secrets are not set, Forge still builds and deploys. The app will just show honest local-only / backup-unavailable states.

## Enable GitHub Pages

After the workflow is pushed:

1. Open the repository on GitHub
2. Go to `Settings` -> `Pages`
3. Set `Source` to `GitHub Actions`
4. Push to `main` or run the `Deploy Flutter Web` workflow manually

## Notes for web testing

- Browser camera scanning usually needs HTTPS and explicit camera permission
- Manual barcode entry remains available even if scanning is denied or unsupported
- Drift web persistence is browser-local, so data stays tied to the current browser storage unless you explicitly sign in and upload backups
- Forge does not fake restore/sync features that are not implemented yet
