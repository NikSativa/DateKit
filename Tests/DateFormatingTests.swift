import Foundation
import XCTest

import DateKit

final class DateFormatingTests: XCTestCase {
    func testUTC() {
        let formatter = DateFormatter()
        XCTAssertEqual(formatter.dateFormat, "")

        formatter.set(dateFormat: [.time24hAndMinutes])
        XCTAssertEqual(formatter.dateFormat, "HH:mm")
    }
}
