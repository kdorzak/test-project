# mountainr-db (Android)

This folder contains Android **Room** entities + migrations aligned with `docs/db/schema-v1.sql`.

It is provided as **starter code** to copy into the Android Studio project that will live under `apps/android/`.

## How to use
Once you create the Android app project:
1. Copy `src/main/java/com/mountainr/db` into your app/module sources.
2. Add Room dependencies and KSP/KAPT as needed.
3. Initialize `MountainrDatabase` via `Room.databaseBuilder(...)`.

## Keeping schema aligned
- iOS schema: `apps/ios/MountainrCore` (GRDB migration)
- Android schema: this folder (Room migration)
- Canonical SQL reference: `docs/db/schema-v1.sql`
