import Foundation

//
// This is a special fork of Spots, only for the Diplom-Isbilen project
//
// In this fork of Spots, StateCache has been disabled on June 29, 2020. Reason: Diplom-Isbilen doesn't
// use StateCahe and upgrading StateCache to use Cache 5.3.0 (which is required by another dependency of
// Diplom-Isbilen (Imaginery)) would have been a more complex solution (and it wouldn't have been
// used at all)
//

/// A StateCache class used for Controller and Component object caching
public final class StateCache {
  /// Remove state cache for all controllers and components.
  public static func removeAll() {
  }

  /// A unique identifer string for the StateCache
  public let key: String

  // MARK: - Initialization

  /// Initialize a StateCache with a unique cache key
  ///
  /// - parameter key: A string that is used as an identifier for the StateCache
  ///
  /// - returns: A StateCache object
  public init(key: String) {
    self.key = key
  }

  // MARK: - Cache

  /// Save JSON to the StateCache
  ///
  /// - parameter json: A JSON object
  public func save<T: Codable>(_ object: T) {
  }

  /// Load JSON from cache
  ///
  /// - returns: A Swift dictionary
  public func load<T: Codable>() -> T? {
    return nil
  }

  /// Clear the current StateCache
  public func clear(completion: (() -> Void)? = nil) {
    completion?()
  }

  /// The StateCache file name
  ///
  /// - returns: An md5 representation of the StateCache's file name, computed from the StateCache key
  func fileName() -> String {
    return ""
  }
}
