// swiftlint:disable all
import Amplify
import Foundation

extension TagWithCompositeKey {
  // MARK: - CodingKeys
   public enum CodingKeys: String, ModelKey {
    case id
    case name
    case posts
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema
  
  public static let schema = defineSchema { model in
    let tagWithCompositeKey = TagWithCompositeKey.keys
    
    model.pluralName = "TagWithCompositeKeys"
    
    model.attributes(
      .index(fields: ["id", "name"], name: nil),
      .primaryKey(fields: [tagWithCompositeKey.id, tagWithCompositeKey.name])
    )
    
    model.fields(
      .field(tagWithCompositeKey.id, is: .required, ofType: .string),
      .field(tagWithCompositeKey.name, is: .required, ofType: .string),
      .hasMany(tagWithCompositeKey.posts, is: .optional, ofType: PostTagsWithCompositeKey.self, associatedWith: PostTagsWithCompositeKey.keys.tagWithCompositeKey),
      .field(tagWithCompositeKey.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(tagWithCompositeKey.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
    public class Path: ModelPath<TagWithCompositeKey> { }
    
    public static var rootPath: PropertyContainerPath? { Path() }
}

extension TagWithCompositeKey: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Custom
  public typealias IdentifierProtocol = ModelIdentifier<Self, ModelIdentifierFormat.Custom>
}

extension TagWithCompositeKey.IdentifierProtocol {
  public static func identifier(id: String,
      name: String) -> Self {
    .make(fields:[(name: "id", value: id), (name: "name", value: name)])
  }
}
extension ModelPath where ModelType == TagWithCompositeKey {
  public var id: FieldPath<String>   {
      string("id")
    }
  public var name: FieldPath<String>   {
      string("name")
    }
  public var posts: ModelPath<PostTagsWithCompositeKey>   {
      PostTagsWithCompositeKey.Path(name: "posts", isCollection: true, parent: self)
    }
  public var createdAt: FieldPath<Temporal.DateTime>   {
      datetime("createdAt")
    }
  public var updatedAt: FieldPath<Temporal.DateTime>   {
      datetime("updatedAt")
    }
}
