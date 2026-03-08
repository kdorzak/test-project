# Native MVP checklist (iOS + Android)

This checklist is the “definition of scaffold complete” for Mountainr’s first usable end-to-end recording loop.

## 0) Non-negotiables
- Offline-first: app should work without network (except optional trail discovery).
- Background-safe: while recording, location continues when screen locks / app backgrounds.
- Data durability: track points are persisted incrementally (not only kept in memory).

## 1) Domain model alignment (both platforms)
Use `docs/domain-model.md` as the shared contract.

Minimal tables/collections to implement:
- `activities`
- `track_points`
- `trails` (optional for caching Overpass)

All units:
- distance: meters
- elevation: meters
- timestamps: epoch milliseconds

## 2) iOS MVP tasks (SwiftUI)
### Recording
- `LocationRecorder` based on `CLLocationManager`
- permission flow: When In Use → Always (recording requires Always)
- background mode: `UIBackgroundModes = location`

### Persistence
- SQLite layer (GRDB recommended)
- batch inserts for track points

### UI
- Home screen: start/stop recording
- Activity detail: map + stats

### Map
- Mapbox map view
- polyline overlay for recorded track

## 3) Android MVP tasks (Kotlin + Compose)
### Recording
- Foreground service for recording session
- Location updates via `FusedLocationProviderClient`
- runtime permission flow:
  - fine location
  - background location (Android 10+)
  - foreground service location (Android 14+)

### Persistence
- Room DB
- batch inserts for track points

### UI
- Home screen: start/stop recording
- Activity detail: map + stats

### Map
- Mapbox map view
- polyline layer for recorded track

## 4) Trail discovery (OSM Overpass) — prototype
- Implement “discover trails around me” behind a rate-limited button.
- Cache results locally.

Reference: `docs/osm-overpass.md`

## 5) Stats + gamification (MVP-friendly order)
Because there is **no shared core**, keep these algorithms small and testable.

Recommended order:
1. Distance calculation (haversine + filtering by accuracy)
2. Elevation gain/loss (smoothed altitude)
3. Personal bests (longest hike, biggest ascent)
4. Simple achievements engine:
   - rules as data (JSON/plist)
   - progress derived from activities

## 6) Cross-platform consistency strategy (no shared code)
- Create a small set of fixture tracks (e.g., 3 GPX files) and expected stats.
- Implement unit tests on both platforms to validate:
  - total distance
  - total ascent/descent
  - moving time vs elapsed time

This prevents iOS/Android logic drift over time.
