# Mountainr

Mobile mountaineering / hiking diary focused on **geo-tracking**, **trail maps**, and **gamified personal achievements**.

## What this repo is (right now)
This repository is scaffolded for **two separate native apps**:
- `apps/ios` — SwiftUI + CoreLocation + Mapbox
- `apps/android` — Kotlin + Jetpack Compose + foreground service + Mapbox

## Planned core features
- **Activity recording**: start/pause/stop GPS tracking; store track + stats (distance, ascent/descent, time).
- **Maps**: render recorded tracks; show trails layers.
- **Trail discovery**: OSM-based trail discovery via Overpass API (prototype, cache locally).
- **Gamification**:
  - “Paint trails by walking them” (coverage/progress over known trails).
  - Peak/range challenges (reach a set of peaks).
  - Milestones (distance, elevation gain, step count, streaks).

## Docs
- `docs/project-blueprint.md` — product + architecture overview
- `docs/native-apps-blueprint.md` — iOS/Android-specific blueprint
- `docs/osm-overpass.md` — Overpass query notes and constraints
- `docs/domain-model.md` — stack-agnostic data model
- `docs/stack-selection.md` — current stack decisions

## Repo layout
```
.
├─ apps/
│  ├─ ios/
│  ├─ android/
│  └─ archive/           # optional, old spikes
└─ docs/
   ├─ project-blueprint.md
   ├─ native-apps-blueprint.md
   ├─ osm-overpass.md
   ├─ domain-model.md
   ├─ stack-selection.md
   └─ decisions-needed.md
```

## Next step
Decide whether you want a **shared core logic** module across iOS and Android (see `docs/decisions-needed.md`). Then we can scaffold the corresponding structure (e.g., no shared module vs Kotlin Multiplatform vs Rust core) and outline the first native screens/services to implement.
