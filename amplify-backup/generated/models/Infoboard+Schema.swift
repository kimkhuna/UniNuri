// swiftlint:disable all
import Amplify
import Foundation

extension Infoboard {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case title
    case content
    case writer
    case registerdate
    case updatedate
    case deletedate
    case Infocomments
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let infoboard = Infoboard.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Infoboards"
    
    model.attributes(
      .primaryKey(fields: [infoboard.id])
    )
    
    model.fields(
      .field(infoboard.id, is: .required, ofType: .string),
      .field(infoboard.title, is: .required, ofType: .string),
      .field(infoboard.content, is: .required, ofType: .string),
      .field(infoboard.writer, is: .required, ofType: .string),
      .field(infoboard.registerdate, is: .required, ofType: .dateTime),
      .field(infoboard.updatedate, is: .optional, ofType: .dateTime),
      .field(infoboard.deletedate, is: .optional, ofType: .dateTime),
      .hasMany(infoboard.Infocomments, is: .optional, ofType: Infocomment.self, associatedWith: Infocomment.keys.infoboardID),
      .field(infoboard.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(infoboard.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension Infoboard: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}