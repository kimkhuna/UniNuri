// swiftlint:disable all
import Amplify
import Foundation

public struct UserInfo: Model {
  public let id: String
  public var nickname: String
  public var country: String
  public var school: String
  public var entrance_year: String
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      nickname: String,
      country: String,
      school: String,
      entrance_year: String) {
    self.init(id: id,
      nickname: nickname,
      country: country,
      school: school,
      entrance_year: entrance_year,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      nickname: String,
      country: String,
      school: String,
      entrance_year: String,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.nickname = nickname
      self.country = country
      self.school = school
      self.entrance_year = entrance_year
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}