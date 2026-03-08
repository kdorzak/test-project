# Decisions (resolved)

These decisions are now locked in for the scaffold:

- **Mobile stack:** Native (two separate apps)
  - iOS: SwiftUI / CoreLocation
  - Android: Kotlin / Jetpack Compose / Foreground Service
- **Map SDK:** Mapbox
- **Offline strategy:** Offline-first, local-only MVP (no accounts)
- **Trail sources (initial):** OSM-based trail discovery (Overpass API)
- **Platforms:** iOS + Android

## Remaining decision (pick one)
### Shared core logic
Even with two native apps, you may want to share *non-UI* logic (stats, achievements rules, trail painting) to avoid divergence.

Pick one:
1. **None** (duplicate logic in Swift + Kotlin; simplest to start)
2. **Kotlin Multiplatform (KMP)** shared module (best long-term for shared algorithms)
3. **Rust core** (shared via FFI; powerful but heavier tooling)

(We will scaffold accordingly once you choose.)
