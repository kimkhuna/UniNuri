// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "94597b845af56eec488680ed1cba3a20"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: UserInfo.self)
    ModelRegistry.register(modelType: Infocomment.self)
    ModelRegistry.register(modelType: Infoboard.self)
    ModelRegistry.register(modelType: Freecomment.self)
    ModelRegistry.register(modelType: Freeboard.self)
  }
}