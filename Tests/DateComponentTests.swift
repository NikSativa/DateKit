import DateKit
import Foundation
import XCTest

final class DateComponentTests: DateTestCase {
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
        let format: DateFormat = [
            // year4DigitsWeekBased
            "YYYY", "-", .monthShort, "-", .dayOfMonth2Digits, " ", .time12hAndMinutes
        ]
        XCTAssertEqual(subject.string(withFormat: format, from: date, isUTC: true),
                       "2020-Dec-30 03:49 PM")
    }

    func testEachCase() {
        dateProvider.stub(.timeZone).andReturn(TimeZone.testMake(addHours: 2))

        let date = Date.spry.testMake(year: 2019,
                                      month: 12,
                                      day: 1,
                                      hour: 15,
                                      minute: 49,
                                      second: 11,
                                      nanosecond: 22)
        let s = DateComponent.t("<=**=>")
        let config: [(component: DateComponent, expected: String)] = [
            (.year4Digits, "2019"),
            (.year2Digits, "19"),
            (.monthFull, "December"),
            (.monthShort, "Dec"),
            (.monthNumeric, "12"),
            (.dayOfMonth1Digit, "1"),
            (.dayOfMonth2Digits, "01"),
            (.dayOfTheWeek, "Sunday"),
            (.dayOfTheWeekShort, "Sun"),
            (.t("EEE"), "Sun"), // same as .dayOfTheWeekShort
            (.t("EE"), "Sun"), // same as .dayOfTheWeekShort
            (.t("E"), "Sun"), // same as .dayOfTheWeekShort
            (.time24h, "17"),
            (.time24hAndMinutes, "17:49"),
            (.time12h, "5 PM"),
            (.time12hAndMinutes, "05:49 PM"),
            (.hour, "17"),
            (.minute, "49"),
            (.second, "11")
        ]

        let components: [DateComponent] = config.map(\.component).reduce([]) { partialResult, component in
            var partialResult = partialResult
            partialResult.append(component)
            partialResult.append(s)
            return partialResult
        }.dropLast(1)

        let formatter = subject.formatter(withFormat: .init(components: components), isUTC: false)

        let actual = formatter.string(from: date)
        let actualValues = actual.components(separatedBy: s.asString)
        let expected = config.map(\.expected)
        XCTAssertEqual(actualValues, expected)

        let unexpected = config.enumerated().filter { index, value in
            return actualValues[index] != value.expected
        }

        XCTAssertTrue(unexpected.isEmpty, unexpected.map {
            return [
                "name: " + humanName(for: $0.element.component),
                "expected: " + $0.element.expected,
                "actual: " + actualValues[$0.offset]
            ].joined(separator: ", ")
        }.joined(separator: "\n"))
    }

    func testDesciptions() {
        let format: DateFormat = [
            .dayOfMonth2Digits, "-", .monthShort, "-", .year4Digits
        ]
        XCTAssertEqual(format.description, "dd-MMM-yyyy")
        XCTAssertEqual(format.debugDescription, "dayOfMonth2Digits, text(\"-\"), monthShort, text(\"-\"), year4Digits")
    }
}
