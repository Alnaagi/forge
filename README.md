# Forge

Forge is an Android-first, single-user, offline-first fitness app built with Flutter.

## Current state

The current codebase is beyond scaffold stage. Core areas that are real today:

- workout logging with mixed-unit set support
- workout templates, history, and session detail
- nutrition logging, food search, barcode lookup, saved meals, and hydration
- body progress logging for weight, waist, and body fat
- health profile and health status timeline logging
- Health Connect read/sync for steps, heart rate, sleep, and body weight
- dashboard, analytics, deterministic insights, and smart reminders
- Android reminder delivery with notification tap routing
- first-run onboarding and active-goal management
- optional account linking, cloud backup upload, and controlled restore/import preview
- Flutter web build support for live testing, with honest platform fallbacks for Android-only features

## Platform notes

- Android remains the primary platform.
- Web is supported for testing and review, not as the full primary target.
- Health Connect and Android notification delivery remain Android-only.
- Barcode scanning can work on web when the browser supports camera access over HTTPS, but manual barcode entry remains available.

## Architecture rules

- local Drift database is the source of truth
- remote APIs are assistive only
- preserve original entered units and canonical normalized values together
- keep business logic in application/domain layers, not widgets

## Deployment docs

- Web build and GitHub Pages instructions: [WEB_DEPLOYMENT.md](WEB_DEPLOYMENT.md)
