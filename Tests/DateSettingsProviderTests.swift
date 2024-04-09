import Foundation
import XCTest

@testable import DateKit

final class DateSettingsProviderTests: XCTestCase {
    let subject = DateSettingsProvider()

    func testNow() {
        XCTAssertEqual(subject.now.timeIntervalSince1970, Date().timeIntervalSince1970, accuracy: 0.5)
    }

    func testTimeZone() {
        XCTAssertEqual(subject.timeZone, .current)
    }
}
