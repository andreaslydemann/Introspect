@testable import UI
import XCTest

final class UITests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Introspect().text, "Hello, World!")
    }

    static var allTests = [("testExample", testExample)]
}
