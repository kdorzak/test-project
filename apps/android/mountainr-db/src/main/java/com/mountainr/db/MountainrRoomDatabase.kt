package com.mountainr.db

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import androidx.room.migration.Migration
import androidx.sqlite.db.SupportSQLiteDatabase

@Database(
  entities = [
    ActivityEntity::class,
    TrackPointEntity::class,
    TrailEntity::class,
    AppStateEntity::class
  ],
  version = 1,
  exportSchema = true
)
abstract class MountainrRoomDatabase : RoomDatabase() {
  abstract fun activitiesDao(): ActivitiesDao
  abstract fun trackPointsDao(): TrackPointsDao
  abstract fun trailsDao(): TrailsDao
  abstract fun appStateDao(): AppStateDao

  companion object {
    const val DB_NAME = "mountainr.db"

    /**
     * Create the Room database instance.
     *
     * Note: if you start at version=1 you could omit migrations. We keep MIGRATION_0_1 explicit
     * so schema creation matches iOS + `docs/db/schema-v1.sql`.
     */
    fun open(context: Context): MountainrRoomDatabase {
      return Room.databaseBuilder(context, MountainrRoomDatabase::class.java, DB_NAME)
        .addMigrations(MIGRATION_0_1)
        .build()
    }

    val MIGRATION_0_1 = object : Migration(0, 1) {
      override fun migrate(db: SupportSQLiteDatabase) {
        // Keep SQL aligned with `docs/db/schema-v1.sql`.
        db.execSQL("PRAGMA foreign_keys = ON")
        db.execSQL("PRAGMA journal_mode = WAL")

        db.execSQL(
          """
          CREATE TABLE IF NOT EXISTS activities (
            id TEXT NOT NULL,
            type TEXT NOT NULL,
            started_at_ms INTEGER NOT NULL,
            ended_at_ms INTEGER,
            note TEXT,
            PRIMARY KEY(id)
          )
          """.trimIndent()
        )

        db.execSQL(
          """
          CREATE TABLE IF NOT EXISTS track_points (
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            activity_id TEXT NOT NULL,
            ts_ms INTEGER NOT NULL,
            lat REAL NOT NULL,
            lon REAL NOT NULL,
            alt_m REAL,
            accuracy_m REAL,
            speed_mps REAL,
            heading_deg REAL,
            FOREIGN KEY(activity_id) REFERENCES activities(id) ON DELETE CASCADE
          )
          """.trimIndent()
        )

        db.execSQL(
          "CREATE INDEX IF NOT EXISTS idx_track_points_activity_ts ON track_points(activity_id, ts_ms)"
        )

        db.execSQL(
          """
          CREATE TABLE IF NOT EXISTS trails (
            id INTEGER NOT NULL,
            name TEXT,
            tags_json TEXT NOT NULL,
            geometry_json TEXT NOT NULL,
            fetched_at_ms INTEGER NOT NULL,
            PRIMARY KEY(id)
          )
          """.trimIndent()
        )

        db.execSQL(
          """
          CREATE TABLE IF NOT EXISTS app_state (
            k TEXT NOT NULL,
            v TEXT,
            PRIMARY KEY(k)
          )
          """.trimIndent()
        )
      }
    }
  }
}
