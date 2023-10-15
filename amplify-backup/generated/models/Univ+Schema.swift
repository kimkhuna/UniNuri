// swiftlint:disable all
import Amplify
import Foundation

extension Univ {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case groupName
    case groupInfo
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let univ = Univ.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Univs"
    
    model.attributes(
      .primaryKey(fields: [univ.id])
    )
    
    model.fields(
      .field(univ.id, is: .required, ofType: .string),
      .field(univ.groupName, is: .required, ofType: .string),
      .field(univ.groupInfo, is: .optional, ofType: .string),
      .field(univ.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(univ.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension Univ: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}