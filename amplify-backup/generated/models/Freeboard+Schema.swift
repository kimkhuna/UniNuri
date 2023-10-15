// swiftlint:disable all
import Amplify
import Foundation

extension Freeboard {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case title
    case content
    case writer
    case registerdate
    case updatedate
    case deletedate
    case Freecomments
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let freeboard = Freeboard.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Freeboards"
    
    model.attributes(
      .primaryKey(fields: [freeboard.id])
    )
    
    model.fields(
      .field(freeboard.id, is: .required, ofType: .string),
      .field(freeboard.title, is: .required, ofType: .string),
      .field(freeboard.content, is: .required, ofType: .string),
      .field(freeboard.writer, is: .required, ofType: .string),
      .field(freeboard.registerdate, is: .required, ofType: .dateTime),
      .field(freeboard.updatedate, is: .optional, ofType: .dateTime),
      .field(freeboard.deletedate, is: .optional, ofType: .dateTime),
      .hasMany(freeboard.Freecomments, is: .optional, ofType: Freecomment.self, associatedWith: Freecomment.keys.freeboardID),
      .field(freeboard.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(freeboard.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension Freeboard: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}