import DateKitTestHelpers
import Foundation
import SpryKit
import XCTest

import DateKit

final class DateTimeConverterTests: DateTestCase {
    func testDHShortcut() {
        XCTAssertNotNil(DH)
    }

    func test24hTimeFormat() {
        dateProvider.stub(.timeZone).andReturn(TimeZone.testMake())
        dateProvider.stub(.is24h).andReturn(false)

        XCTAssertEqual(subject.time.asString, "hh:mm a")
        XCTAssertFalse(subject.is24h)
        XCTAssertHaveReceived(dateProvider, .is24h)
    }

    func test12hTimeFormat() {
        dateProvider.stub(.timeZone).andReturn(TimeZone.defaultForTests())
        dateProvider.stub(.is24h).andReturn(true)

        XCTAssertEqual(subject.time.asString, "HH:mm")
        XCTAssertTrue(subject.is24h)
    }

    func testDateFromServerWithoutFractionalSeconds() {
        dateProvider.stub(.timeZone).andReturn(TimeZone.defaultForTests())

        let actual = "2023-06-16T15:49:00Z"
        let expected = Date.mock()
        let description = [
            DateFormat.th.isoWithoutFractionalSeconds.asString,
            actual
        ].compactMap { $0 }.joined(separator: " - ")

        XCTAssertEqual(subject.date(withFormat: .th.isoWithoutFractionalSeconds, from: actual, isUTC: false), expected, description)
        XCTAssertNotEqual(subject.date(withFormat: .th.isoWithFractionalSeconds, from: actual, isUTC: false), expected, description)
    }

    func testDateFromServerWithFractionalSeconds() {
        dateProvider.stub(.timeZone).andReturn(TimeZone.defaultForTests())

        let actual = "2023-06-16T15:49:00.000Z"
        let description = [
            DateFormat.th.isoWithFractionalSeconds.asString,
            actual
        ].compactMap { $0 }.joined(separator: " - ")

        let expectedUTC = Date.mock()
        XCTAssertEqual(subject.date(withFormat: .th.isoWithFractionalSeconds, from: actual, isUTC: true), expectedUTC, description)
        XCTAssertNotEqual(subject.date(withFormat: .th.isoWithoutFractionalSeconds, from: actual, isUTC: true), expectedUTC, description)

        let expectedLocal = Date.mock(addHours: -2)
        XCTAssertEqual(subject.date(withFormat: .th.isoWithFractionalSeconds, from: actual, isUTC: false), expectedLocal, description)
        XCTAssertNotEqual(subject.date(withFormat: .th.isoWithoutFractionalSeconds, from: actual, isUTC: false), expectedLocal, description)
    }

    func testDateWithFormat() {
        dateProvider.stub(.timeZone).andReturn(TimeZone.utc)

        for format in DateFormat.th.allTestCases {
            let expected: Date
            let actual: String
            switch format {
            case .th.default:
                actual = "16 June 2023"
                expected = .spry.testMake(year: 2023, month: 6, day: 16)
            case .th.dayOfTheWeek:
                actual = "Friday, 16 June 2023"
                expected = .spry.testMake(year: 2023, month: 6, day: 16)
            case .th.timeFullWith(separator: " * "):
                actual = "June 16 2023 * 03:49 PM"
                expected = .mock()
            case .th.timeShortWith(separator: " * "):
                actual = "Jun 16 2023 * 03:49 PM"
                expected = .mock()
            case .th.server:
                actual = "2023-06-16T15:49:00.000Z"
                expected = .mock()
            case .th.MMMddEEE:
                actual = "Jun 16, Fri"
                expected = .spry.testMake(year: 2000, month: 6, day: 16)
            case .th.monthShort:
                actual = "Jun"
                expected = .spry.testMake(year: 2000, month: 6, day: 1)
            case .th.dayOfMonth1:
                actual = "16"
                expected = .spry.testMake(year: 2000, month: 1, day: 16)
            case .th.dayOfMonth2:
                actual = "16"
                expected = .spry.testMake(year: 2000, month: 1, day: 16)
            case .th.time24h:
                actual = "16"
                expected = .spry.testMake(year: 2000, month: 1, day: 1, hour: 16)
            case .th.time24hAndMinutes:
                actual = "16:30"
                expected = .spry.testMake(year: 2000, month: 1, day: 1, hour: 16, minute: 30)
            case .th.time12h:
                actual = "6 AM"
                expected = .spry.testMake(year: 2000, month: 1, day: 1, hour: 6)
            case .th.time12hAndMinutes:
                actual = "6:30 AM"
                expected = .spry.testMake(year: 2000, month: 1, day: 1, hour: 6, minute: 30)
            case .th.numericDateWith(separator: "-"):
                actual = "2023-06-16"
                expected = .spry.testMake(year: 2023, month: 6, day: 16)
            default:
                XCTFail(humanName(for: format) + " - " + format.asString)
                return
            }

            let description = [
                humanName(for: format),
                format.asString,
                actual
            ].compactMap { $0 }.joined(separator: " - ")

            XCTAssertEqual(subject.date(withFormat: format, from: actual, isUTC: false), expected, description)
        }
    }

    func testConvertFormats() {
        dateProvider.stub(.timeZone).andReturn(TimeZone.utc)

        for format in DateFormat.th.allTestCases {
            let expected: String?
            let actual: String
            switch format {
            case .th.default:
                actual = "16 June 2023"
                expected = "2023-06-16T00:00:00.000Z"
            case .th.dayOfTheWeek:
                actual = "Friday, 16 June 2023"
                expected = "2023-06-16T00:00:00.000Z"
            case .th.timeFullWith(separator: " * "):
                actual = "June 16 2023 * 03:49 PM"
                expected = "2023-06-16T15:49:00.000Z"
            case .th.timeShortWith(separator: " * "):
                actual = "Jun 16 2023 * 03:49 PM"
                expected = "2023-06-16T15:49:00.000Z"
            case .th.server:
                actual = "2023-06-16T15:49:00.000Z"
                expected = "2023-06-16T15:49:00.000Z"
            case .th.MMMddEEE:
                actual = "Jun 16, Fri"
                expected = "2000-06-16T00:00:00.000Z"
            case .th.monthShort:
                actual = "Jun"
                expected = "2000-06-01T00:00:00.000Z"
            case .th.dayOfMonth1:
                actual = "16"
                expected = "2000-01-16T00:00:00.000Z"
            case .th.dayOfMonth2:
                actual = "16"
                expected = "2000-01-16T00:00:00.000Z"
            case .th.time24h:
                actual = "16:00"
                expected = nil
            case .th.time24hAndMinutes:
                actual = "16:30"
                expected = "2000-01-01T16:30:00.000Z"
            case .th.time12h:
                actual = "6 AM"
                expected = "2000-01-01T06:00:00.000Z"
            case .th.time12hAndMinutes:
                actual = "6:30 AM"
                expected = "2000-01-01T06:30:00.000Z"
            case .th.numericDateWith(separator: "-"):
                actual = "2023-06-16"
                expected = "2023-06-16T00:00:00.000Z"
            default:
                XCTFail(humanName(for: format) + " - " + format.asString)
                return
            }

            let description = [
                humanName(for: format),
                format.asString,
                actual
            ].compactMap { $0 }.joined(separator: " - ")

            XCTAssertEqual(subject.convert(stringDate: actual,
                                           from: format,
                                           fromUTC: true,
                                           to: .th.isoWithFractionalSeconds,
                                           toUTC: false),
                           expected,
                           description)
        }
    }

    func testNow() {
        XCTAssertHaveNoRecordedCalls(dateProvider)
        dateProvider.stub(.now).andReturn(Date.mock())
        XCTAssertEqual(subject.now, Date.mock())
        XCTAssertHaveReceived(dateProvider, .now, countSpecifier: .exactly(1))
    }

    func testTimeZone() {
        XCTAssertHaveNoRecordedCalls(dateProvider)
        dateProvider.stub(.timeZone).andReturn(TimeZone.testMake(addHours: 2))
        XCTAssertEqual(subject.timeZone, .testMake(addHours: 2))
        XCTAssertHaveReceived(dateProvider, .timeZone, countSpecifier: .exactly(1))
    }
}
