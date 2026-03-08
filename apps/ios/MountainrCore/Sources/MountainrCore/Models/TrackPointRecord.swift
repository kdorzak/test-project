import Foundation
import GRDB

public struct TrackPointRecord: Codable, FetchableRecord, PersistableRecord {
  public static let databaseTableName = "track_points"

  public var id: Int64?
  public var activityId: String
  public var tsMs: Int64
  public var lat: Double
  public var lon: Double
  public var altM: Double?
  public var accuracyM: Double?
  public var speedMps: Double?
  public var headingDeg: Double?

  public init(
    id: Int64? = nil,
    activityId: String,
    tsMs: Int64,
    lat: Double,
    lon: Double,
    altM: Double? = nil,
    accuracyM: Double? = nil,
    speedMps: Double? = nil,
    headingDeg: Double? = nil
  ) {
    self.id = id
    self.activityId = activityId
    self.tsMs = tsMs
    self.lat = lat
    self.lon = lon
    self.altM = altM
    self.accuracyM = accuracyM
    self.speedMps = speedMps
    self.headingDeg = headingDeg
  }

  public enum Columns {
    public static let id = Column("id")
    public static let activityId = Column("activity_id")
    public static let tsMs = Column("ts_ms")
    public static let lat = Column("lat")
    public static let lon = Column("lon")
    public static let altM = Column("alt_m")
    public static let accuracyM = Column("accuracy_m")
    public static let speedMps = Column("speed_mps")
    public static let headingDeg = Column("heading_deg")
  }
}
