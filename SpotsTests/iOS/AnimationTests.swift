@testable import Spots
import Foundation
import XCTest

class AnimationTests: XCTestCase {

  func testResolvingAnimations() {
    XCTAssertEqual(Animation.automatic.tableViewAnimation, UITableView.RowAnimation.automatic)
    XCTAssertEqual(Animation.fade.tableViewAnimation, UITableView.RowAnimation.fade)
    XCTAssertEqual(Animation.right.tableViewAnimation, UITableView.RowAnimation.right)
    XCTAssertEqual(Animation.left.tableViewAnimation, UITableView.RowAnimation.left)
    XCTAssertEqual(Animation.top.tableViewAnimation, UITableView.RowAnimation.top)
    XCTAssertEqual(Animation.bottom.tableViewAnimation, UITableView.RowAnimation.bottom)
    XCTAssertEqual(Animation.none.tableViewAnimation, UITableView.RowAnimation.none)
    XCTAssertEqual(Animation.middle.tableViewAnimation, UITableView.RowAnimation.middle)
  }
}
