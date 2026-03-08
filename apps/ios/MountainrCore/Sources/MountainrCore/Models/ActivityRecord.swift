import Foundation
import GRDB

public struct ActivityRecord: Codable, FetchableRecord, PersistableRecord {
  public static let databaseTableName = "activities"

  public var id: String
  public var type: String
  public var startedAtMs: Int64
  public var endedAtMs: Int64?
  public var note: String?

  public init(
    id: String,
    type: String,
    startedAtMs: Int64,
    endedAtMs: Int64? = nil,
    note: String? = nil
  ) {
    self.id = id
    self.type = type
    self.startedAtMs = startedAtMs
    self.endedAtMs = endedAtMs
    self.note = note
  }

  public enum Columns {
    public static let id = Column("id")
    public static let type = Column("type")
    public static let startedAtMs = Column("started_at_ms")
    public static let endedAtMs = Column("ended_at_ms")
    public static let note = Column("note")
  }
}
