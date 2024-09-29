import DateKit
import Foundation
import XCTest

final class DateFormatTests: DateTestCase {
    override func setUp() {
        super.setUp()
        subject.defaultLocale = .en_US
    }

    override func tearDown() {
        super.tearDown()
        subject.defaultLocale = .defaultLocale
    }

    func testStringLiteral() {
        let date = Date.spry.testMake(year: 2019,
                                      month: 12,
                                      day: 30,
                                      hour: 15,
                                      minute: 49,
                                      second: 11,
                                      nanosecond: 22)
        XCTAssertEqual(subject.string(withFormat: "yyyy-MMM-dd hh:mm a", from: date, isUTC: true), "2019-Dec-30 03:49 PM")
    }

    func testDesciptions() {
        let format: DateFormat = [
            .dayOfMonth2Digits,
            .t("-"),
            .monthShort,
            .t("-"),
            .year4Digits
        ]
        XCTAssertEqual(format.description, "dd-MMM-yyyy")
        XCTAssertEqual(format.debugDescription, "dayOfMonth2Digits, text(\"-\"), monthShort, text(\"-\"), year4Digits")
    }
}
