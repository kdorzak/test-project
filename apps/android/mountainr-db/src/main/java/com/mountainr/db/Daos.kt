package com.mountainr.db

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query

@Dao
interface ActivitiesDao {
  @Insert(onConflict = OnConflictStrategy.ABORT)
  suspend fun insert(activity: ActivityEntity)

  @Query("UPDATE activities SET ended_at_ms = :endedAtMs WHERE id = :activityId")
  suspend fun endActivity(activityId: String, endedAtMs: Long)

  @Query("SELECT * FROM activities ORDER BY started_at_ms DESC LIMIT :limit")
  suspend fun listRecent(limit: Int = 50): List<ActivityEntity>
}

@Dao
interface TrackPointsDao {
  @Insert(onConflict = OnConflictStrategy.ABORT)
  suspend fun insertAll(points: List<TrackPointEntity>)

  @Query("SELECT * FROM track_points WHERE activity_id = :activityId ORDER BY ts_ms ASC")
  suspend fun getForActivity(activityId: String): List<TrackPointEntity>
}

@Dao
interface TrailsDao {
  @Insert(onConflict = OnConflictStrategy.REPLACE)
  suspend fun upsertAll(trails: List<TrailEntity>)

  @Query("SELECT * FROM trails ORDER BY fetched_at_ms DESC LIMIT :limit")
  suspend fun listCached(limit: Int = 200): List<TrailEntity>
}

@Dao
interface AppStateDao {
  @Insert(onConflict = OnConflictStrategy.REPLACE)
  suspend fun put(entry: AppStateEntity)

  @Query("SELECT v FROM app_state WHERE k = :key LIMIT 1")
  suspend fun get(key: String): String?
}
