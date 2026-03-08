# Project Scaffold & Technical Blueprint

## Goals (product-level)
- **Personal hiking / mountaineering diary**: record activities (hikes, ascents, ski tours), attach notes/photos, and summarize stats.
- **Geo-tracking**: record GPS track (lat/lon/alt/time), distance, ascent/descent, pace/speed.
- **Maps & trails**: visualize recorded tracks on a map; browse/import trails (e.g., GPX) and show POIs/peaks.
- **Gamification**: achievements and “collection” mechanics:
  - “Paint trails by walking them” (track coverage of known trail segments or user-defined routes).
  - Peak/range/country challenges (reach a set of relevant peaks).
  - Milestones (step count, distance, vertical meters, streaks).

## MVP scope (what to scaffold for immediately)
### Mobile app (offline-first)
- Background-capable activity recording (start/pause/stop).
- Activity detail screen with map polyline + stats.
- Basic achievements framework (rules + progress).
- Local storage for activities/tracks/achievements.
- GPX import/export (at least import for trails, export for sharing).

### Optional (scaffold hooks, but not required for MVP)
- Cloud sync & multi-device backup.
- Social sharing / leaderboards.
- Trail catalog with server-side search/routing.

## Core technical constraints (mobile geo realities)
- **Background location** is the hard requirement: needs OS-level background modes (iOS) and foreground services (Android), plus careful battery handling.
- **Permissions & privacy**: clear rationale screens, granular settings (precise location, background location, health permissions if step count).
- **Offline maps**: desirable for mountains; plan for downloading tiles/regions if the chosen map SDK supports it.

## High-level architecture (platform-agnostic)
### App layers
- **UI layer**: screens, navigation, map rendering, charts.
- **Domain layer**: activity tracking, statistics, achievements engine, trail painting logic.
- **Data layer**:
  - Local DB (activities, track points, achievements progress, cached trails/peaks).
  - File storage for GPX, exports, and media.
  - Optional sync adapter (later).

### Key modules
- `tracking`: start/stop session, receive location updates, smooth/filter points, compute stats.
- `maps`: polyline rendering, offline tile management (if supported), layers (trails/peaks).
- `trails`: GPX import + trail indexing; “painted segments” bookkeeping.
- `achievements`: rules engine + progress + badges.
- `sync` (optional): auth + upload/download + conflict resolution.

## Implementation notes to bake in early
- **Background tracking**:
  - Collect points at adaptive frequency (more frequent while moving, less while still).
  - Persist points incrementally (don’t keep all in memory).
  - Record metadata: battery, accuracy, provider, app state if available.
- **Elevation**:
  - GPS altitude is noisy; plan for smoothing and/or later DEM-based correction.
- **Battery/performance**:
  - Downsample for map rendering (e.g., Douglas–Peucker) while keeping raw points for totals.
- **Privacy**:
  - Plan for “private mode” (home redaction) as a future feature.
