// swiftlint:disable all
import Amplify
import Foundation

extension UserInfo {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case nickname
    case country
    case school
    case entrance_year
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let userInfo = UserInfo.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "UserInfos"
    
    model.attributes(
      .primaryKey(fields: [userInfo.id])
    )
    
    model.fields(
      .field(userInfo.id, is: .required, ofType: .string),
      .field(userInfo.nickname, is: .required, ofType: .string),
      .field(userInfo.country, is: .required, ofType: .string),
      .field(userInfo.school, is: .required, ofType: .string),
      .field(userInfo.entrance_year, is: .required, ofType: .string),
      .field(userInfo.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(userInfo.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension UserInfo: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}