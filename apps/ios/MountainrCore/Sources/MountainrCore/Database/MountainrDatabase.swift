import Foundation
import GRDB

/// SQLite database access + migrations.
///
/// This module is intended to be added to the native iOS app via Swift Package Manager.
public final class MountainrDatabase {
  public let dbQueue: DatabaseQueue

  public init(databaseURL: URL) throws {
    // Ensure parent directory exists
    try FileManager.default.createDirectory(
      at: databaseURL.deletingLastPathComponent(),
      withIntermediateDirectories: true
    )

    // Configure GRDB
    var config = Configuration()
    config.foreignKeysEnabled = true

    self.dbQueue = try DatabaseQueue(path: databaseURL.path, configuration: config)

    try migrator.migrate(dbQueue)
  }

  private var migrator: DatabaseMigrator {
    var migrator = DatabaseMigrator()

    // In development, helps detect accidental schema changes
    #if DEBUG
    migrator.eraseDatabaseOnSchemaChange = true
    #endif

    migrator.registerMigration("v1") { db in
      // Keep SQL aligned with `docs/db/schema-v1.sql`.
      try db.execute(sql: SchemaV1.sql)
    }

    return migrator
  }
}

enum SchemaV1 {
  static let sql = """
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

  CREATE TABLE IF NOT EXISTS trails (
    id INTEGER PRIMARY KEY,
    name TEXT,
    tags_json TEXT NOT NULL,
    geometry_json TEXT NOT NULL,
    fetched_at_ms INTEGER NOT NULL
  );

  CREATE TABLE IF NOT EXISTS app_state (
    k TEXT PRIMARY KEY NOT NULL,
    v TEXT
  );
  """
}
