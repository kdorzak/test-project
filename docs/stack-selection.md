# Stack selection (current)

This repository is currently configured for:

- **Mobile stack:** two separate native apps
  - iOS (SwiftUI + CoreLocation)
  - Android (Kotlin + Jetpack Compose + foreground service)
- **Map SDK:** Mapbox native SDKs
- **Offline strategy:** offline-first, local-only MVP (no accounts)
- **Trail sources (initial):** OSM-based trail discovery (Overpass API)
- **Platforms:** iOS + Android

## Important implications
- Background GPS tracking requires OS-specific implementation:
  - iOS: CoreLocation + `UIBackgroundModes = location`
  - Android: foreground service + background location permission handling
- Both platforms should persist track points incrementally to a local DB (SQLite) to survive process death.
