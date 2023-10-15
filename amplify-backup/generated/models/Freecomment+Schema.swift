// swiftlint:disable all
import Amplify
import Foundation

extension Freecomment {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case com_writer
    case com_comment
    case registerdate
    case freeboardID
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let freecomment = Freecomment.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Freecomments"
    
    model.attributes(
      .index(fields: ["freeboardID"], name: "byFreeboard"),
      .primaryKey(fields: [freecomment.id])
    )
    
    model.fields(
      .field(freecomment.id, is: .required, ofType: .string),
      .field(freecomment.com_writer, is: .required, ofType: .string),
      .field(freecomment.com_comment, is: .required, ofType: .string),
      .field(freecomment.registerdate, is: .required, ofType: .dateTime),
      .field(freecomment.freeboardID, is: .required, ofType: .string),
      .field(freecomment.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(freecomment.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension Freecomment: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}