# Database scaffold (v1)

This repo includes a **matched** database schema for iOS and Android.

## Canonical schema (reference)
- `docs/db/schema-v1.sql`

This file is the source of truth for table/column names and units.

## iOS implementation (Swift / GRDB)
- Package: `apps/ios/MountainrCore`
- Migration: `MountainrDatabase` runs schema `v1` on first open.
- Models:
  - `ActivityRecord`
  - `TrackPointRecord`
  - `TrailRecord`
  - `AppStateRecord`

How to integrate:
- In Xcode, add local package dependency pointing at `apps/ios/MountainrCore`.

## Android implementation (Kotlin / Room)
- Starter code: `apps/android/mountainr-db`
- Entities + DAOs + `Migration(0,1)` that executes SQL aligned to `schema-v1.sql`.

How to integrate:
- Copy `apps/android/mountainr-db/src/main/java/com/mountainr/db` into your Android project.
- Add Room + KSP/KAPT dependencies.

## Tables included in v1
- `activities`
- `track_points`
- `trails` (cached OSM ways; prototype)
- `app_state` (small key/value)

## Conventions
- timestamps: epoch milliseconds
- distance: meters
- elevation: meters

## Keeping iOS/Android aligned (no shared code)
Because the project does not share a core module, alignment is maintained by:
- keeping SQL identical between migrations
- adding unit tests on both platforms using the same fixture tracks
