import DateKit
import Foundation
import XCTest

final class TimeZoneTests: XCTestCase {
    func testUTC() {
        XCTAssertEqual(TimeZone.utc.identifier, "GMT")
        XCTAssertEqual(TimeZone.utc.abbreviation(), "GMT")
        XCTAssertEqual(TimeZone.utc.secondsFromGMT(), 0)
    }
}
