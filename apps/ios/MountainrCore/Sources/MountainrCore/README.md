# MountainrCore (iOS)

This is a small Swift Package that provides:
- SQLite schema migrations aligned with `docs/db/schema-v1.sql`
- GRDB models for `activities` and `track_points`

## Integrate into the iOS app
In Xcode:
- File → Add Package Dependencies…
- Add **Local** package from `apps/ios/MountainrCore`

Then initialize the DB (example):
- choose a database path under Application Support
- create `MountainrDatabase(databaseURL: ...)`

## Note
This repo is intentionally **not** sharing code with Android. The schema must remain aligned by convention + tests.
