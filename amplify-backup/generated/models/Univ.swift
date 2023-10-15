// swiftlint:disable all
import Amplify
import Foundation

public struct Univ: Model {
  public let id: String
  public var groupName: String
  public var groupInfo: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      groupName: String,
      groupInfo: String? = nil) {
    self.init(id: id,
      groupName: groupName,
      groupInfo: groupInfo,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      groupName: String,
      groupInfo: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.groupName = groupName
      self.groupInfo = groupInfo
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}