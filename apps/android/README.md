# Android app (native)

This folder is reserved for the **native Android** Mountainr app.

## Tooling
- Android Studio (latest stable)
- Kotlin
- Jetpack Compose for UI
- Foreground Service + location provider for background tracking
- Mapbox Maps SDK for Android

## Create the Android project
1. Android Studio → **New Project**
2. Choose **Empty Activity** (Compose)
3. Name: `Mountainr`
4. Package name: `com.mountainr`
5. Minimum SDK: choose based on your needs (commonly 26+ for modern location behavior)
6. Save it into `apps/android/`.

## Mapbox setup
- Create a Mapbox access token: https://console.mapbox.com/account/access-tokens/
- Store it using one of these patterns:
  - `local.properties` (dev-only) + Gradle `BuildConfig` field
  - Android resources: `res/values/mapbox.xml` (be careful not to commit secrets)

## Background location setup
Typical requirements:
- Runtime permissions: `ACCESS_FINE_LOCATION` (+ `ACCESS_COARSE_LOCATION`)
- For background tracking:
  - `ACCESS_BACKGROUND_LOCATION` (Android 10+)
  - Foreground service with persistent notification
  - `FOREGROUND_SERVICE` + `FOREGROUND_SERVICE_LOCATION` (Android 14+)

## Data storage (offline-first)
A Room-based starter is included in this repo:
- `apps/android/mountainr-db/` (entities, DAOs, migration)

When your Android Studio project exists:
- copy `apps/android/mountainr-db/src/main/java/com/mountainr/db` into your app module
- wire it via `Room.databaseBuilder(...)`

Canonical schema reference:
- `docs/db/schema-v1.sql`

## Next file to implement
- `RecordingService` (foreground service)
- `LocationClient` abstraction (FusedLocationProviderClient or platform LocationManager)
- Compose screens: Home, Record, Map, Trails
