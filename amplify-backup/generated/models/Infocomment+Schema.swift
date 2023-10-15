// swiftlint:disable all
import Amplify
import Foundation

extension Infocomment {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case com_writer
    case com_comment
    case registerdate
    case infoboardID
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let infocomment = Infocomment.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Infocomments"
    
    model.attributes(
      .index(fields: ["infoboardID"], name: "byInfoboard"),
      .primaryKey(fields: [infocomment.id])
    )
    
    model.fields(
      .field(infocomment.id, is: .required, ofType: .string),
      .field(infocomment.com_writer, is: .required, ofType: .string),
      .field(infocomment.com_comment, is: .required, ofType: .string),
      .field(infocomment.registerdate, is: .required, ofType: .dateTime),
      .field(infocomment.infoboardID, is: .required, ofType: .string),
      .field(infocomment.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(infocomment.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension Infocomment: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}