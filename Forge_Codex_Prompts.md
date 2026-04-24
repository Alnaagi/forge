# Forge — Codex Prompt Pack

Use these prompts in order.
Do not skip the review prompt after each milestone.

---

## 1) Master prompt

```text
You are building an Android-first Flutter mobile app called Forge, a single-user, offline-first all-in-one fitness tracking app.

Core stack:
- Flutter
- Riverpod
- go_router
- Drift + SQLite
- Freezed
- Dio
- Health Connect integration later
- optional Supabase auth/sync later

Architectural requirements:
- Use a layered architecture with presentation, application, domain, and data layers
- Use feature-first organization under lib/features
- Keep local database as the source of truth
- App must work offline first
- Remote APIs are assistive only, never the primary source of truth
- Do not add multi-user or coach features
- Android only first
- Mobile only first

Critical business rule:
For every unit-sensitive metric, preserve:
1. original user-entered value
2. original user-entered unit
3. canonical normalized value for analytics

Examples:
- workout set weight: original value/unit + normalized kg
- bodyweight: original value/unit + normalized kg

Rules:
- History screens must show the original entered values
- Dashboards/analytics may switch between kg/lb at any time
- Analytics must always use canonical normalized values
- Never overwrite the original entered value or unit when user changes display preference

Main features:
- workout logging
- exercise library
- workout templates
- supersets/drop sets/warm-up sets
- rest timer
- e1RM calculations
- PR detection
- bodyweight/body measurements
- food search
- barcode scan
- custom foods
- meal logging
- hydration
- goals
- analytics dashboards
- explainable smart insights
- reminders
- health integrations later

Deliverables for this step:
1. propose the exact folder structure
2. define the domain entities
3. define the Drift tables
4. define repository interfaces
5. define app-wide enums/value objects
6. define initial routes
7. define milestone order
8. generate the project scaffold code stubs

Constraints:
- production-minded code only
- null-safe
- strongly typed
- testable
- no dead code
- no fake sample data beyond temporary seeds
- no overengineering beyond the required blueprint

When in doubt:
- choose maintainability
- keep business logic out of widgets
- keep calculations deterministic
- explain tradeoffs briefly before implementing
```

---

## 2) Project scaffold

```text
Using the agreed blueprint, generate the Flutter project scaffold.

Tasks:
- set up folders for app, bootstrap, features, shared, data, domain
- configure Riverpod
- configure go_router
- create app theme skeleton for light and dark modes
- create shared error/result types
- create base screen shell and bottom navigation
- create placeholder routes for:
  Home
  Workouts
  Nutrition
  Progress
  More
- create initial feature folders with README notes in each
- do not implement business logic yet
- include clear TODO markers for the next milestones

Output:
- full folder tree
- code for the core files
- concise explanation of why each file exists
```

---

## 3) Database and domain

```text
Implement the domain model and local database layer for the app.

Requirements:
- use Drift + SQLite
- create tables for:
  users
  goals
  exercises
  workout_templates
  workout_template_items
  workout_sessions
  workout_exercise_entries
  set_entries
  body_logs
  foods
  meal_entries
  hydration_logs
  reminders
  health_sync_records
  insights
  app_settings
- use strong types and enums where appropriate
- create indexes where queries will be frequent
- include created_at and updated_at where useful
- create DAOs for each main feature area
- create repository interfaces in domain layer
- create repository implementations in data layer
- include migration strategy for schema evolution

Critical rule:
- every unit-sensitive table must preserve both original entered value/unit and normalized canonical value

Also:
- define value objects for WeightValue, WeightUnit, BodyMetricUnit, GoalType, SetType, ReminderType, InsightSeverity
- add seed data for built-in exercises only
- do not seed fake workouts or fake body logs
```

---

## 4) Workout engine

```text
Implement the workout feature module.

Scope:
- exercise library
- workout templates
- live workout session
- workout history
- session detail screen
- rest timer
- PR detection
- e1RM estimation
- support for:
  normal sets
  warm-up sets
  drop sets
  supersets
  failure sets

Rules:
- preserve original entered weight/unit per set
- compute normalized kg value for analytics
- allow different units in different sets, even within the same session
- history must display original logged values
- analytics must use normalized values
- support notes, RPE, tempo, rest_seconds

UI requirements:
- fast logging UX
- repeat last set button
- unit picker per set
- visible rest timer
- clean session summary at workout end

Deliver:
- models
- repositories
- controllers/providers
- screens
- widgets
- tests for:
  unit conversion
  e1RM
  volume calculation
  PR detection
```

---

## 5) Nutrition module

```text
Implement the nutrition feature module.

Scope:
- food search screen
- barcode scan flow
- custom foods
- local food cache
- meal logging
- saved meals
- hydration tracking
- daily macro dashboard

Data behavior:
- remote nutrition search is assistive only
- local database remains the source of truth
- if barcode is not found, allow manual food creation
- if a food is manually created for a barcode, remember that barcode locally
- allow user to edit food macros and save a corrected local version
- support serving sizes, grams, ml, slices, units, and custom quantities

Architecture:
- remote client abstraction
- DTO to domain mappers
- local repository cache layer
- optimistic offline behavior

Deliver:
- feature module code
- repository interfaces and impls
- local food storage schema refinements if needed
- tests for quantity resolution and macro calculations
```

---

## 6) Dashboards and analytics

```text
Implement the analytics and dashboard module.

Dashboards:
- home dashboard
- workout analytics
- nutrition analytics
- body progress analytics
- strength vs bodyweight analytics
- consistency dashboard

Metrics:
- bodyweight trend
- rolling average bodyweight
- total training volume
- per-exercise strength trend
- estimated 1RM trend
- relative strength = e1RM / bodyweight
- calorie adherence
- protein adherence
- hydration adherence
- consistency streaks
- muscle group balance

Rules:
- analytics always compute from canonical normalized values
- UI can switch display units at any time
- original entry values remain unchanged in history

UI:
- filters by time range
- kg/lb switch
- compare periods
- clean chart cards
- no cluttered dashboards

Deliver:
- data aggregators
- analytics repositories/use cases
- dashboard providers/controllers
- widgets and screens
- tests for strength/bodyweight ratio calculations
```

---

## 7) Smart insights

```text
Implement the smart insights module.

Goal:
Create an explainable insight engine, not a generic chatbot.

Phase 1:
- deterministic rules
Examples:
  missed planned workouts
  protein target missed repeatedly
  steep weight drop during cut
  sleep decline
  skipped muscle group
  stalled exercise performance

Phase 2:
- trend-based insight scoring
Examples:
  plateau likelihood
  fatigue likelihood
  deload suggestion confidence
  strength retention during cut
  recovery mismatch

For every insight:
- category
- title
- short message
- full explanation
- evidence data
- confidence score
- suggested action
- created_at
- dismissed/saved state

UI:
- rotating advice banner on home
- insights archive screen
- insight detail screen with “Why this appeared”

Constraints:
- all logic must be deterministic and testable
- no LLM dependency for MVP
- messages should feel premium, short, and useful

Deliver tests for:
- plateau detection
- deload trigger logic
- cut strength retention logic
- skipped muscle group detection
```

---

## 8) Health Connect

```text
Implement Android health integration using Health Connect.

Scope:
- permission flow
- read steps
- read sleep where available
- read heart rate where available
- sync records into local database
- show synced values in dashboard cards

Rules:
- treat Health Connect as an external source, not the primary source of truth
- imported records should be stored locally in health_sync_records
- support re-sync and deduplication using external record ids when available
- gracefully handle denied permissions and unavailable data types

UI:
- settings screen for permissions
- sync now action
- health summary card on home/progress dashboard

Do not implement Google Fit.
Use architecture that can later support Samsung-specific integrations if needed.
```

---

## 9) Guest mode and future sync

```text
Implement guest-first local usage and optional later account linking.

Requirements:
- app works fully without sign-in
- local data is preserved
- add an optional account system later
- when user signs in later, local data must be linked and synced, not lost
- prepare repository boundaries for future Supabase auth/sync

For now:
- create abstraction interfaces for AuthRepository and SyncRepository
- create no-op/local-only implementations
- add settings UI placeholders for backup/sync
- do not implement cloud sync fully yet unless needed by milestone

Deliver:
- interfaces
- local implementations
- future-proof sync queue design
```

---

## 10) Polish and UX

```text
Polish the UI/UX to fit this visual direction:
- hardcore gym vibe
- minimal
- premium
- responsive
- Android-first
- light and dark mode
- satisfying micro-interactions

Requirements:
- strong typography hierarchy
- cards that feel powerful, not playful
- subtle but satisfying tap/complete animations
- PR celebration animation
- empty states that still look premium
- no childish gamification

Do not redesign architecture.
Focus on:
- theme refinement
- reusable widgets
- motion polish
- spacing consistency
- accessibility basics
```

---

## 11) Review prompt

```text
Review your own implementation critically.

Check:
- architecture consistency
- unit handling correctness
- offline-first behavior
- separation of UI and business logic
- naming clarity
- dead code
- schema problems
- missing tests
- future scaling issues

Return:
1. what is good
2. what is risky
3. what should be improved next
4. exact patches to apply
```
