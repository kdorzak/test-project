# Domain model (initial)

This is a minimal model that supports GPS recording, maps, and achievements while remaining stack-agnostic.

## Entities

### Activity
- `id`
- `type` (hike/peak/run/ski)
- `startTime`, `endTime`
- `distanceM`, `movingTimeS`, `elevationGainM`, `elevationLossM`
- `notes`
- `photos[]`
- `source` (recorded/imported)

### TrackPoint
- `activityId`
- `timestamp`
- `lat`, `lon`, `altM`, `accuracyM`
- `speedMps?`, `headingDeg?`

### Trail
- `id`, `name`
- `source` (gpx/osm/manual)
- `geometry` (polyline)
- optional metadata (difficulty, tags, etc.)

### PaintProgress
- `trailId`
- coverage representation (segments, sampled indices, or a spatial index)

### Peak
- `id`, `name`, `lat`, `lon`, `elevationM`, `regionCode`

### SummitLog
- `peakId`, `activityId`, `timestamp`
- optional photo/note

### Achievement
- `id`, `name`
- `criteria` (serialized rule)

### AchievementProgress
- `achievementId`
- `value`
- `completedAt?`

## Storage notes
- Prefer a real local DB over JSON files due to trackpoint volume.
- Index points by `activityId` and `timestamp`.
- Consider storing a downsampled polyline for fast map previews.
