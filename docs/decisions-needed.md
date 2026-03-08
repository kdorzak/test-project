# Decisions (resolved)

These decisions are now locked in for the scaffold:

- **Mobile stack:** Native (two separate apps)
  - iOS: SwiftUI / CoreLocation
  - Android: Kotlin / Jetpack Compose / Foreground Service
- **Map SDK:** Mapbox
- **Offline strategy:** Offline-first, local-only MVP (no accounts)
- **Trail sources (initial):** OSM-based trail discovery (Overpass API)
- **Platforms:** iOS + Android
- **Shared core logic:** **None** (duplicate logic in Swift + Kotlin)

## Implication of “no shared core”
- We will keep the *domain model* consistent via `docs/domain-model.md`.
- Shared algorithms (distance/ascent calculation, trail painting, achievements) must be re-implemented on both platforms.
- To avoid drift, treat `docs/domain-model.md` + `docs/native-apps-blueprint.md` as the source of truth and add tests on both platforms for the same fixtures (GPX/JSON tracks).
