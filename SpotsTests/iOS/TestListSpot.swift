@testable import Spots
import Foundation
import XCTest

class ListSpotTests: XCTestCase {

  var cachedSpot: ListSpot!

  override func setUp() {
    cachedSpot = ListSpot(cacheKey: "cached-list-spot")
    Helper.clearCache(for: cachedSpot.stateCache)
  }

  override func tearDown() {
    cachedSpot = nil
  }

  func testDictionaryRepresentation() {
    let component = Component(title: "ListSpot", kind: "list", span: 3, meta: ["headerHeight": 44.0])
    let spot = ListSpot(component: component)
    XCTAssertEqual(component.dictionary["index"] as? Int, spot.dictionary["index"] as? Int)
    XCTAssertEqual(component.dictionary["title"] as? String, spot.dictionary["title"] as? String)
    XCTAssertEqual(component.dictionary["kind"] as? String, spot.dictionary["kind"] as? String)
    XCTAssertEqual(component.dictionary["span"] as? Int, spot.dictionary["span"] as? Int)
    XCTAssertEqual(
      (component.dictionary["meta"] as! [String : Any])["headerHeight"] as? CGFloat,
      (spot.dictionary["meta"] as! [String : Any])["headerHeight"] as? CGFloat
    )
  }

  func testSafelyResolveKind() {
    let component = Component(title: "ListSpot", kind: "custom-list", span: 1.0, items: [Item(title: "foo", kind: "custom-item-kind")])
    let listSpot = ListSpot(component: component)
    let indexPath = IndexPath(row: 0, section: 0)

    XCTAssertEqual(listSpot.identifier(at: indexPath), ListSpot.views.defaultIdentifier)

    ListSpot.views.defaultItem = Registry.Item.classType(ListSpotCell.self)
    XCTAssertEqual(listSpot.identifier(at: indexPath), ListSpot.views.defaultIdentifier)

    ListSpot.views.defaultItem = Registry.Item.classType(ListSpotCell.self)
    XCTAssertEqual(listSpot.identifier(at: indexPath), ListSpot.views.defaultIdentifier)

    ListSpot.views["custom-item-kind"] = Registry.Item.classType(ListSpotCell.self)
    XCTAssertEqual(listSpot.identifier(at: indexPath), "custom-item-kind")

    ListSpot.views.storage.removeAll()
  }

  func testSpotCache() {
    let item = Item(title: "test")

    XCTAssertEqual(cachedSpot.component.items.count, 0)
    cachedSpot.append(item) {
      self.cachedSpot.cache()
    }

    var exception: XCTestExpectation? = self.expectation(description: "Wait for cache")
    Dispatch.after(seconds: 0.25) {
      let cachedSpot = ListSpot(cacheKey: self.cachedSpot.stateCache!.key)
      XCTAssertEqual(cachedSpot.component.items.count, 1)
      cachedSpot.stateCache?.clear()
      exception?.fulfill()
      exception = nil
    }
    waitForExpectations(timeout: 0.5, handler: nil)
  }

  func testSpotConfigurationClosure() {
    Configuration.register(view: TestView.self, identifier: "test-view")

    let items = [Item(title: "Item A", kind: "test-view"), Item(title: "Item B")]
    let spot = ListSpot(component: Component(span: 0.0, items: items))
    spot.setup(CGSize(width: 100, height: 100))
    spot.layout(CGSize(width: 100, height: 100))
    spot.view.layoutSubviews()

    var invokeCount = 0
    spot.configure = { view in
      invokeCount += 1
    }
    XCTAssertEqual(invokeCount, 2)
  }
}
