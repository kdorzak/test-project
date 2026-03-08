# Native apps blueprint (iOS + Android)

## Repository layout
```
apps/
  ios/
  android/
  archive/         # optional, old spikes

docs/
  project-blueprint.md
  native-apps-blueprint.md
  osm-overpass.md
```

## Common product concepts (keep consistent on both platforms)
### Activity recording
- Session state machine: `idle → recording → paused → stopped`
- Persist session metadata early (activity id, start time), then append track points incrementally.
- Derive summary statistics either:
  - on the fly while recording, and/or
  - by recomputing from raw points after stop.

### Track point model (shared semantics)
Each recorded point should include:
- timestamp (ms)
- latitude/longitude
- altitude (optional)
- horizontal accuracy (m)
- speed (m/s) + course/heading (optional)

### Battery strategy (baseline)
- Use high accuracy only when recording.
- Use distance filter (e.g., 5–10m) and/or time filter (e.g., 1–5s).
- Allow a “battery saver” mode for long hikes.

## Platform specifics

### iOS
**Key APIs**
- `CLLocationManager` for GPS
- SwiftUI for UI

**Background mode**
- `UIBackgroundModes = [location]`
- request “Always” authorization (`NSLocationAlwaysAndWhenInUseUsageDescription`)

**Persistence**
- SQLite is recommended due to volume of track points.

### Android
**Key APIs**
- Foreground service for long-running recording
- `FusedLocationProviderClient` (or LocationManager fallback)
- Compose for UI

**Permissions**
- Foreground: `ACCESS_FINE_LOCATION`
- Background: `ACCESS_BACKGROUND_LOCATION` (Android 10+)
- Foreground service: `FOREGROUND_SERVICE` + `FOREGROUND_SERVICE_LOCATION` (Android 14+)

## Maps (Mapbox)
- Use the Mapbox “outdoors” style as the default for hiking.
- Start with online tiles; add offline region downloads once the basic recorder is stable.

## Trails (OSM discovery)
- Use Overpass API to query nearby hiking-relevant ways.
- Cache results locally to avoid rate limiting.
- Treat Overpass usage as “prototype-grade” unless you run your own Overpass or proxy.

## Gamification (MVP-friendly)
Build gamification as a rules engine:
- Inputs: activities + track points + peak hits + painted segments
- Outputs: achievement progress + unlocked badges

This allows you to add achievements without rewriting core flows.
