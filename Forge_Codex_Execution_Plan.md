# Forge — Codex Execution Plan

This plan is designed to be run milestone by milestone.
Do not ask Codex to build the entire app in one shot.
Use one milestone prompt at a time.
After each milestone, run a review pass and then patch issues before proceeding.

---

## Phase 0 — project operating setup

### Goal
Establish the working contract for Codex.

### Actions
1. Add `AGENTS.md` to project root.
2. Add this execution plan to project docs.
3. Add a simple `README.md` describing the app and milestone sequence.
4. Ensure Flutter project is initialized and can run.

### Done criteria
- project opens successfully
- AGENTS.md exists
- README exists
- Codex understands stack and rules

---

## Phase 1 — app scaffold

### Goal
Create the app skeleton without heavy business logic.

### Deliverables
- feature-first folder structure
- Riverpod setup
- go_router setup
- light/dark theme skeleton
- bottom navigation shell
- placeholder screens for top-level tabs
- base error/result types
- bootstrap and app wiring

### Done criteria
- app builds and launches
- navigation works
- theme switching skeleton exists
- no fake business logic embedded in widgets

### Review checklist
- are folders aligned with features?
- is routing centralized?
- are widgets thin?
- is app shell scalable?

---

## Phase 2 — domain + database foundation

### Goal
Create domain entities, value objects, enums, Drift schema, DAOs, and repositories.

### Deliverables
- tables for all major entities
- migration structure
- DAOs for workouts, nutrition, body logs, insights, reminders, settings
- repository interfaces in domain
- repository implementations in data
- exercise seed data

### Done criteria
- schema compiles
- DAOs work
- seed loads built-in exercises
- canonical unit storage pattern exists in schema

### Review checklist
- are unit-sensitive fields modeled correctly?
- are indexes added where needed?
- are timestamps consistent?
- is there separation between DTOs and entities?

---

## Phase 3 — workout engine

### Goal
Build workout creation, live logging, history, and workout analytics foundations.

### Deliverables
- exercise library UI
- template list and builder
- live workout session flow
- set logging UI
- rest timer
- repeat last set
- PR detection
- e1RM calculations
- workout session summary

### Done criteria
- user can create and log a full workout offline
- different units can be used in the same session
- history shows original values
- analytics can derive normalized volume

### Review checklist
- is logging fast enough?
- are set types modeled clearly?
- are unit conversions deterministic?
- are PR rules reliable?

---

## Phase 4 — nutrition engine

### Goal
Build food logging and macro tracking.

### Deliverables
- food search screen
- barcode scan flow
- custom food creation
- local corrected foods
- saved foods
- saved meals
- hydration tracking
- daily nutrition summary

### Done criteria
- meals can be logged offline
- remote food search results can be cached locally
- unknown barcodes can be manually mapped
- macros resolve correctly from quantity input

### Review checklist
- is local cache the source of truth?
- are quantity conversions consistent?
- are edited foods preserved locally?

---

## Phase 5 — dashboards and analytics

### Goal
Build analytics views and aggregation logic.

### Deliverables
- home dashboard
- workout analytics dashboard
- nutrition dashboard
- body progress dashboard
- strength vs bodyweight dashboard
- consistency dashboard

### Done criteria
- charts are driven by real aggregates
- unit switching works in analytics
- relative strength metric works
- dashboard cards are not cluttered

### Review checklist
- are computations using normalized values?
- do history screens still show originals?
- are chart time ranges clean and understandable?

---

## Phase 6 — smart insights engine

### Goal
Create explainable recommendations based on deterministic rules and trends.

### Deliverables
- insight model
- rules engine
- trend analysis helpers
- advice banner
- insights archive
- insight detail with explanation
- plateau logic
- deload suggestion logic
- cut strength retention logic
- skipped muscle group detection

### Done criteria
- tips appear from real data only
- every tip has a why/explanation page
- insights are deterministic and testable

### Review checklist
- any fake AI wording?
- are confidence labels justified?
- does every insight include evidence?

---

## Phase 7 — Health Connect integration

### Goal
Import health data from Android’s modern health path.

### Deliverables
- permissions flow
- sync for steps
- sync for sleep where available
- sync for heart rate where available
- local storage of imported records
- dashboard cards using imported data

### Done criteria
- permissions can be granted/denied cleanly
- imported records deduplicate correctly
- lack of available data is handled gracefully

### Review checklist
- is Health Connect isolated behind a repository?
- are external ids stored for dedupe?
- is UI resilient when no health data exists?

---

## Phase 8 — guest-first future sync groundwork

### Goal
Keep the app fully local now, but architect for later account linking and cloud backup.

### Deliverables
- AuthRepository abstraction
- SyncRepository abstraction
- local-only implementations
- sync queue design
- settings placeholders for backup/sync

### Done criteria
- app requires no sign-in
- repository boundaries are ready for future cloud support
- no current feature depends on auth

### Review checklist
- is guest mode truly first-class?
- would future account linking preserve local data?

---

## Phase 9 — polish and hardening

### Goal
Refine the product feel and strengthen reliability.

### Deliverables
- theme refinement
- spacing cleanup
- reusable widgets
- micro-interactions
- PR celebration animation
- empty states
- error states
- accessibility basics
- more tests
- performance pass

### Done criteria
- app feels premium
- motion is subtle and useful
- no obviously rough flows remain

### Review checklist
- any noisy or childish effects?
- any repeated UI patterns not abstracted?
- any unnecessary complexity?

---

## Mandatory post-milestone review prompt
Use this after every phase:

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

---

## Rules for moving forward
Only move to the next phase after:
- compile/build issues are resolved
- review pass is done
- patch pass is done
- milestone done criteria are satisfied
