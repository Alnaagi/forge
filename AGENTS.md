# AGENTS.md — Forge

## Project identity
Forge is an Android-first, single-user, offline-first Flutter fitness app.
It combines workout tracking, nutrition tracking, body progress, health data sync, analytics, reminders, and explainable smart insights.

The app is not a social network, not a coach marketplace, and not a multi-tenant SaaS product.

## Product goals
Build a premium personal fitness operating system with these priorities:
1. workout tracking
2. food intake tracking
3. consistency tracking
4. body and strength analytics
5. explainable smart recommendations

## Platform scope
- Flutter mobile app
- Android first
- mobile only first
- single user first
- local-first and offline-first
- optional sign-in and cloud sync later

## Tech stack
- Flutter
- Riverpod
- go_router
- Drift + SQLite
- Freezed
- Dio
- local notifications
- barcode scanner
- Health Connect later
- optional Supabase later for auth/sync

## Architecture rules
Use a layered architecture:
- presentation
- application
- domain
- data

Use feature-first folders under `lib/features`.

Never place business logic directly inside widgets.
Never place calculation-heavy logic in UI controllers if it belongs in domain/application layers.
Never make remote APIs the source of truth.

## Source of truth rules
The local database is the source of truth.
Remote APIs are assistive only.
Device integrations are external sources that sync into local storage.
Cloud sync later mirrors local data rather than replacing local behavior.

## Critical business rule: mixed units
For every unit-sensitive metric, preserve:
1. original user-entered value
2. original user-entered unit
3. canonical normalized value for analytics

Examples:
- set weight stores original value + original unit + normalized kg
- bodyweight stores original value + original unit + normalized kg

History screens must show the original entered values.
Analytics must use canonical normalized values.
Changing display units must never overwrite original logged values.

## Training feature rules
Support:
- exercise library
- workout templates
- live workout logging
- normal sets
- warm-up sets
- supersets
- drop sets
- failure sets
- notes
- tempo
- rest timer
- RPE
- estimated 1RM
- PR detection
- workout history
- session summaries

Allow different units across different sets, even in the same session.

## Nutrition feature rules
Support:
- food search
- barcode scan
- custom foods
- edited foods
- saved foods
- saved meals
- hydration tracking
- macro tracking
- local cache of resolved foods
- local barcode memory

If barcode is unknown, user can create a manual food and bind it locally.
If searched macros are incorrect, user can correct them and save a local trusted version.

## Progress feature rules
Support:
- bodyweight
- body fat
- body measurements
- strength PRs
- consistency
- calories
- macros
- water
- steps
- sleep
- energy/mood if added later

No progress photo support in the first milestone.

## Goal engine rules
Goal types:
- cut
- bulk
- recomp
- strength
- maintain
- custom

The selected goal must influence:
- dashboard priorities
- insight rules
- target emphasis
- analytics summaries

## Insight engine rules
Do not build a fake chatbot first.
Build an explainable insight engine first.

Every insight must include:
- category
- title
- short message
- full explanation
- evidence data
- confidence score
- suggested action
- lifecycle state

Early insights must be deterministic and testable.

## Reminder rules
Support reminders for:
- workouts
- meals
- water
- weigh-ins
- sleep
- progress checks

Missed workouts can be smart-rescheduled if enabled.

## Health integration rules
Use Health Connect on Android.
Do not build against Google Fit.
Treat imported health data as external records synced into local storage.

## UX rules
Visual direction:
- hardcore gym vibe
- minimal
- premium
- satisfying micro-interactions
- both light and dark mode

Avoid:
- childish gamification
- noisy UI
- cluttered dashboards
- fake flashy effects without purpose

## Engineering standards
- null-safe code only
- strong typing
- production-minded naming
- deterministic calculations
- testable business logic
- repository abstractions for data access
- concise comments only where useful
- avoid dead code and placeholder logic in core flows

## Testing requirements
At minimum, add tests for:
- unit conversion
- e1RM calculation
- volume calculation
- PR detection
- macro resolution
- strength vs bodyweight ratio
- plateau detection rules
- skipped muscle group detection
- deload trigger rules

## Migration rules
Use explicit schema migrations.
Do not casually break local data.
Preserve backward compatibility where possible.

## Delivery order
1. scaffold
2. database + domain
3. workout engine
4. nutrition
5. dashboards + analytics
6. insights engine
7. Health Connect
8. guest-to-account groundwork
9. polish

## Codex behavior rules
When working on this codebase:
- make the smallest correct change that satisfies the task
- explain tradeoffs briefly before major structural work
- do not refactor unrelated areas
- do not invent missing product requirements that were already decided
- do not remove critical rules like original unit preservation
- prefer maintainability over cleverness
- finish each milestone with a self-review and patch pass
