package com.mountainr.db

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.Index
import androidx.room.PrimaryKey

@Entity(tableName = "activities")
data class ActivityEntity(
  @PrimaryKey
  @ColumnInfo(name = "id")
  val id: String,

  @ColumnInfo(name = "type")
  val type: String,

  @ColumnInfo(name = "started_at_ms")
  val startedAtMs: Long,

  @ColumnInfo(name = "ended_at_ms")
  val endedAtMs: Long? = null,

  @ColumnInfo(name = "note")
  val note: String? = null
)

@Entity(
  tableName = "track_points",
  indices = [Index(value = ["activity_id", "ts_ms"], name = "idx_track_points_activity_ts")]
)
data class TrackPointEntity(
  @PrimaryKey(autoGenerate = true)
  @ColumnInfo(name = "id")
  val id: Long = 0,

  @ColumnInfo(name = "activity_id")
  val activityId: String,

  @ColumnInfo(name = "ts_ms")
  val tsMs: Long,

  @ColumnInfo(name = "lat")
  val lat: Double,

  @ColumnInfo(name = "lon")
  val lon: Double,

  @ColumnInfo(name = "alt_m")
  val altM: Double? = null,

  @ColumnInfo(name = "accuracy_m")
  val accuracyM: Double? = null,

  @ColumnInfo(name = "speed_mps")
  val speedMps: Double? = null,

  @ColumnInfo(name = "heading_deg")
  val headingDeg: Double? = null
)

@Entity(tableName = "trails")
data class TrailEntity(
  // OSM way id
  @PrimaryKey
  @ColumnInfo(name = "id")
  val id: Long,

  @ColumnInfo(name = "name")
  val name: String? = null,

  @ColumnInfo(name = "tags_json")
  val tagsJson: String,

  @ColumnInfo(name = "geometry_json")
  val geometryJson: String,

  @ColumnInfo(name = "fetched_at_ms")
  val fetchedAtMs: Long
)

@Entity(tableName = "app_state")
data class AppStateEntity(
  @PrimaryKey
  @ColumnInfo(name = "k")
  val key: String,

  @ColumnInfo(name = "v")
  val value: String?
)
