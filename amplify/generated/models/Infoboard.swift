// swiftlint:disable all
import Amplify
import Foundation

public struct Infoboard: Model {
  public let id: String
  public var title: String
  public var content: String
  public var writer: String
  public var registerdate: Temporal.DateTime?
  public var updatedate: Temporal.DateTime?
  public var deletedate: Temporal.DateTime?
  public var Infocomments: List<Infocomment>?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      title: String,
      content: String,
      writer: String,
      registerdate: Temporal.DateTime? = nil,
      updatedate: Temporal.DateTime? = nil,
      deletedate: Temporal.DateTime? = nil,
      Infocomments: List<Infocomment>? = []) {
    self.init(id: id,
      title: title,
      content: content,
      writer: writer,
      registerdate: registerdate,
      updatedate: updatedate,
      deletedate: deletedate,
      Infocomments: Infocomments,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      title: String,
      content: String,
      writer: String,
      registerdate: Temporal.DateTime? = nil,
      updatedate: Temporal.DateTime? = nil,
      deletedate: Temporal.DateTime? = nil,
      Infocomments: List<Infocomment>? = [],
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.title = title
      self.content = content
      self.writer = writer
      self.registerdate = registerdate
      self.updatedate = updatedate
      self.deletedate = deletedate
      self.Infocomments = Infocomments
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}