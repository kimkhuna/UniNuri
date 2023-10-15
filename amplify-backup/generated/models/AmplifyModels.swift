// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "b76a6e639622b4eca875846715c39ac3"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Freecomment.self)
    ModelRegistry.register(modelType: Infocomment.self)
    ModelRegistry.register(modelType: Infoboard.self)
    ModelRegistry.register(modelType: Freeboard.self)
    ModelRegistry.register(modelType: Univ.self)
  }
}