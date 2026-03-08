-- Mountainr schema v1 (SQLite)
-- Units:
-- - timestamps: epoch milliseconds
-- - distance: meters
-- - elevation: meters

PRAGMA foreign_keys = ON;
PRAGMA journal_mode = WAL;

CREATE TABLE IF NOT EXISTS activities (
  id TEXT PRIMARY KEY NOT NULL,
  type TEXT NOT NULL,
  started_at_ms INTEGER NOT NULL,
  ended_at_ms INTEGER,
  note TEXT
);

CREATE TABLE IF NOT EXISTS track_points (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  activity_id TEXT NOT NULL REFERENCES activities(id) ON DELETE CASCADE,
  ts_ms INTEGER NOT NULL,
  lat REAL NOT NULL,
  lon REAL NOT NULL,
  alt_m REAL,
  accuracy_m REAL,
  speed_mps REAL,
  heading_deg REAL
);

CREATE INDEX IF NOT EXISTS idx_track_points_activity_ts
  ON track_points(activity_id, ts_ms);

-- Cached OSM ways (prototype; Overpass)
CREATE TABLE IF NOT EXISTS trails (
  id INTEGER PRIMARY KEY,             -- OSM way id
  name TEXT,
  tags_json TEXT NOT NULL,
  geometry_json TEXT NOT NULL,        -- array of {lat, lon}
  fetched_at_ms INTEGER NOT NULL
);

-- Small key-value state store (e.g., active recording id)
CREATE TABLE IF NOT EXISTS app_state (
  k TEXT PRIMARY KEY NOT NULL,
  v TEXT
);
