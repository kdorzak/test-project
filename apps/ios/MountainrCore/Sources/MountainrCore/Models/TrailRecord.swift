import Foundation
import GRDB

public struct TrailRecord: Codable, FetchableRecord, PersistableRecord {
  public static let databaseTableName = "trails"

  public var id: Int64
  public var name: String?
  public var tagsJson: String
  public var geometryJson: String
  public var fetchedAtMs: Int64

  public init(
    id: Int64,
    name: String? = nil,
    tagsJson: String,
    geometryJson: String,
    fetchedAtMs: Int64
  ) {
    self.id = id
    self.name = name
    self.tagsJson = tagsJson
    self.geometryJson = geometryJson
    self.fetchedAtMs = fetchedAtMs
  }

  public enum Columns {
    public static let id = Column("id")
    public static let name = Column("name")
    public static let tagsJson = Column("tags_json")
    public static let geometryJson = Column("geometry_json")
    public static let fetchedAtMs = Column("fetched_at_ms")
  }
}
