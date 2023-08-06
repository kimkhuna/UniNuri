// swiftlint:disable all
import Amplify
import Foundation

public struct Freecomment: Model {
  public let id: String
  public var com_writer: String
  public var com_content: String
  public var registerdate: Temporal.DateTime?
  public var freeboardID: String
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      com_writer: String,
      com_content: String,
      registerdate: Temporal.DateTime? = nil,
      freeboardID: String) {
    self.init(id: id,
      com_writer: com_writer,
      com_content: com_content,
      registerdate: registerdate,
      freeboardID: freeboardID,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      com_writer: String,
      com_content: String,
      registerdate: Temporal.DateTime? = nil,
      freeboardID: String,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.com_writer = com_writer
      self.com_content = com_content
      self.registerdate = registerdate
      self.freeboardID = freeboardID
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}