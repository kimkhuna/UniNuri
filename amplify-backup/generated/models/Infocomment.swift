// swiftlint:disable all
import Amplify
import Foundation

public struct Infocomment: Model {
  public let id: String
  public var com_writer: String
  public var com_comment: String
  public var registerdate: Temporal.DateTime
  public var infoboardID: String
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      com_writer: String,
      com_comment: String,
      registerdate: Temporal.DateTime,
      infoboardID: String) {
    self.init(id: id,
      com_writer: com_writer,
      com_comment: com_comment,
      registerdate: registerdate,
      infoboardID: infoboardID,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      com_writer: String,
      com_comment: String,
      registerdate: Temporal.DateTime,
      infoboardID: String,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.com_writer = com_writer
      self.com_comment = com_comment
      self.registerdate = registerdate
      self.infoboardID = infoboardID
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}