import Foundation
import GRDB

public struct AppStateRecord: Codable, FetchableRecord, PersistableRecord {
  public static let databaseTableName = "app_state"

  public var key: String
  public var value: String?

  public init(key: String, value: String?) {
    self.key = key
    self.value = value
  }

  public enum Columns {
    public static let key = Column("k")
    public static let value = Column("v")
  }
}
