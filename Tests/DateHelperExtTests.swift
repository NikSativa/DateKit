import Foundation
import XCTest

import DateKit

final class DateExtTests: DateTestCase {
    func testUTCStringWithFormat() {
        dateProvider.stub(.timeZone).andReturn(TimeZone.utc)
        let date = Date.mock()
        for format in DateFormat.th.allTestCases {
            let expectation: String
            switch format {
            case .th.default:
                expectation = "16 June 2023"
            case .th.dayOfTheWeek:
                expectation = "Friday, 16 June 2023"
            case .th.timeFullWith(separator: " * "):
                expectation = "June 16 2023 * 03:49 PM"
            case .th.timeShortWith(separator: " * "):
                expectation = "Jun 16 2023 * 03:49 PM"
            case .th.server:
                expectation = "2023-06-16T15:49:00.000Z"
            case .th.MMMddEEE:
                expectation = "Jun 16, Fri"
            case .th.monthShort:
                expectation = "Jun"
            case .th.dayOfMonth1:
                expectation = "16"
            case .th.dayOfMonth2:
                expectation = "16"
            case .th.time24h:
                expectation = "15"
            case .th.time24hAndMinutes:
                expectation = "15:49"
            case .th.time12h:
                expectation = "3 PM"
            case .th.time12hAndMinutes:
                expectation = "03:49 PM"
            case .th.numericDateWith(separator: "-"):
                expectation = "2023-06-16"
            default:
                XCTFail(humanName(for: format) + " - " + format.asString)
                return
            }

            let description = [
                humanName(for: format),
                format.asString
            ].compactMap { $0 }.joined(separator: " - ")

            XCTAssertEqual(subject.string(withFormat: format, from: date, isUTC: true), expectation, description)
        }
    }

    func testLocalStringWithFormat() {
        dateProvider.stub(.timeZone).andReturn(TimeZone.defaultForTests())

        let date = Date.mock()
        for format in DateFormat.th.allTestCases {
            let localExpectation: String
            switch format {
            case .th.default:
                localExpectation = "16 June 2023"
            case .th.dayOfTheWeek:
                localExpectation = "Friday, 16 June 2023"
            case .th.timeFullWith(separator: " * "):
                localExpectation = "June 16 2023 * 05:49 PM"
            case .th.timeShortWith(separator: " * "):
                localExpectation = "Jun 16 2023 * 05:49 PM"
            case .th.server:
                localExpectation = "2023-06-16T17:49:00.000Z"
            case .th.MMMddEEE:
                localExpectation = "Jun 16, Fri"
            case .th.monthShort:
                localExpectation = "Jun"
            case .th.dayOfMonth1:
                localExpectation = "16"
            case .th.dayOfMonth2:
                localExpectation = "16"
            case .th.time24h:
                localExpectation = "17"
            case .th.time24hAndMinutes:
                localExpectation = "17:49"
            case .th.time12h:
                localExpectation = "5 PM"
            case .th.time12hAndMinutes:
                localExpectation = "05:49 PM"
            case .th.numericDateWith(separator: "-"):
                localExpectation = "2023-06-16"
            default:
                XCTFail(humanName(for: format) + " - " + format.asString)
                return
            }

            let description = [
                humanName(for: format),
                format.asString
            ].compactMap { $0 }.joined(separator: " - ")

            XCTAssertEqual(subject.string(withFormat: format, from: date, isUTC: false), localExpectation, description)
        }
    }
}
