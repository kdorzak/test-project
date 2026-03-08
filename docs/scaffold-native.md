# Native project scaffold guide (Mountainr)

This guide explains how to initialize the **two native apps** in this repo and align them to the same product architecture.

## Repository structure
- `apps/ios` — iOS app (SwiftUI)
- `apps/android` — Android app (Kotlin + Jetpack Compose)
- `docs/native-apps-blueprint.md` — architecture + platform constraints
- `docs/domain-model.md` — shared data model semantics

## Shared requirements to implement first (both platforms)
1. **Recording session state machine**: `idle → recording → paused → stopped`
2. **Local persistence (SQLite)**:
   - `activities` table
   - `track_points` table (high volume)
3. **Map screen**:
   - show user location
   - render a recorded polyline
4. **Trails discovery (OSM / Overpass)**:
   - query nearby ways (prototype)
   - cache results locally

## iOS setup (SwiftUI + CoreLocation + Mapbox)
See also: `apps/ios/README.md`

### 1) Create the Xcode project
- Xcode → New Project → iOS App → SwiftUI → save into `apps/ios/`

### 2) Configure Mapbox
- Add Mapbox via Swift Package Manager.
- Add token to `Info.plist` as `MBXAccessToken`.

### 3) Configure background location
Add these keys:
- `NSLocationWhenInUseUsageDescription`
- `NSLocationAlwaysAndWhenInUseUsageDescription`
- `UIBackgroundModes`: include `location`

Implementation direction:
- a `LocationRecorder` that appends points to SQLite incrementally
- on stop: finalize the activity, compute summary stats

## Android setup (Kotlin + Compose + Foreground Service + Mapbox)
See also: `apps/android/README.md`

### 1) Create the Android Studio project
- Android Studio → New Project → Empty Activity (Compose) → save into `apps/android/`

### 2) Configure Mapbox
- Add Mapbox dependency according to Mapbox’s Android SDK docs.
- Store token via `local.properties` → Gradle `BuildConfig` field (recommended for dev).

### 3) Configure background location
- Use a **foreground service** while recording.
- Ensure runtime permission flows cover:
  - fine/coarse location
  - background location (where applicable)
  - foreground service location (Android 14+)

## Trail discovery (OSM / Overpass)
See: `docs/osm-overpass.md`

Pragmatic approach:
- Use Overpass for discovery only.
- Cache to SQLite (avoid repeated network calls).
- Consider a proxy/server later if you hit rate limits.

## Gamification hook (early design)
Implement achievements as a rules engine driven by:
- activities
- track_points
- (later) peaks + painted segments

This keeps UI thin and makes it easier to add achievements incrementally.
