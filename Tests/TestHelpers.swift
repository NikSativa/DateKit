import DateKit
import Foundation
import SpryKit

public enum Constant {
    public static let year: Int = 2023
    public static let month: Int = 6
    public static let day: Int = 16
    public static let hour: Int = 15
    public static let minute: Int = 49
}

public extension TimeZone {
    static func defaultForTests() -> TimeZone {
        return .testMake(secondsFromGMT: 2 * 60 * 60)
    }
}

public extension Date {
    /// 2023-06-16 15:49:00 +0000
    static func mock(startOfDay: Bool = false,
                     endOfDay: Bool = false,
                     addMonths: Int = 0,
                     addDays: Int = 0,
                     addHours: Int = 0,
                     addMinutes: Int = 0,
                     timeZone: TimeZone? = nil) -> Date {
        if startOfDay {
            return .spry.testMake(year: Constant.year,
                                  month: Constant.month + addMonths,
                                  day: Constant.day + addDays,
                                  hour: 0 + addHours,
                                  minute: 0 + addMinutes,
                                  timeZone: timeZone ?? .testMake())
        }

        if endOfDay {
            return .spry.testMake(year: Constant.year,
                                  month: Constant.month + addMonths,
                                  day: Constant.day + addDays,
                                  hour: 23 + addHours,
                                  minute: 59 + addMinutes,
                                  timeZone: timeZone ?? .testMake())
        }

        return .spry.testMake(year: Constant.year,
                              month: Constant.month + addMonths,
                              day: Constant.day + addDays,
                              hour: Constant.hour + addHours,
                              minute: Constant.minute + addMinutes,
                              timeZone: timeZone ?? .testMake())
    }
}

public func humanName(for o: Any) -> String {
    if let format = o as? DateFormat {
        return format.debugDisplayNames.joined(separator: ", ")
    }
    return anyHumanName(for: o)
}

private func anyHumanName(for o: Any) -> String {
    return String(reflecting: o).components(separatedBy: ".").last ?? "<unknown name>"
}

// MARK: - DateFormat.th

public extension DateFormat {
    /// TestHelpers namespace
    enum th {}
}

public extension DateFormat.th {
    static let allTestCases: [DateFormat] = [
        .th.default,
        .th.dayOfTheWeek,
        .th.timeShortWith(separator: " * "),
        .th.timeFullWith(separator: " * "),
        .th.server,
        .th.numericDateWith(separator: "-"),
        .th.MMMddEEE,
        .th.monthShort,
        .th.dayOfMonth1,
        .th.dayOfMonth2,
        .th.time24h,
        .th.time24hAndMinutes,
        .th.time12h,
        .th.time12hAndMinutes
    ]

    /// dd MMMM yyyy
    /// 16 June 2023
    static let `default`: DateFormat = [
        .dayOfMonth2Digits,
        .t(" "),
        .monthFull,
        .t(" "),
        .year4Digits
    ]

    /// EEEE, dd MMMM yyyy
    /// Friday, 16 June 2023
    static let dayOfTheWeek: DateFormat = [
        .dayOfTheWeek,
        .t(", "),
        .dayOfMonth2Digits,
        .t(" "),
        .monthFull,
        .t(" "),
        .year4Digits
    ]

    /// "MMMM dd yyyy" + separator + timeFormat
    /// August 16 2023 at 03:49 PM
    static func timeFullWith(separator: String) -> DateFormat {
        return [
            .monthFull,
            .t(" "),
            .dayOfMonth2Digits,
            .t(" "),
            .year4Digits,
            .t(separator),
            .time12hAndMinutes
        ]
    }

    /// "MMM dd yyyy" + separator + timeFormat
    /// Aug 16 2023 at 03:49 PM
    static func timeShortWith(separator: String) -> DateFormat {
        return [
            .monthShort,
            .t(" "),
            .dayOfMonth2Digits,
            .t(" "),
            .year4Digits,
            .t(separator),
            .time12hAndMinutes
        ]
    }

    /// yyyy-MM-dd'T'HH:mm:ss.SSS'Z'
    /// 2023-06-16T15:49:00.000Z
    static let server: DateFormat = .th.isoWithFractionalSeconds

    /// yyyy-MM-dd'T'HH:mm:ss.SSS'Z'
    /// 2023-06-16T15:49:00.000Z
    static let isoWithFractionalSeconds: DateFormat = [
        .year4Digits,
        .t("-"),
        .monthNumeric,
        .t("-"),
        .dayOfMonth2Digits,
        .t("'T'"),
        .hour,
        .t(":"),
        .minute,
        .t(":"),
        .second,
        .t(".SSS'Z'")
    ]

    /// yyyy-MM-dd'T'HH:mm:ss'Z'
    /// 2023-06-16T15:49:00.000Z
    static let isoWithoutFractionalSeconds: DateFormat = [
        .year4Digits,
        .t("-"),
        .monthNumeric,
        .t("-"),
        .dayOfMonth2Digits,
        .t("'T'"),
        .hour,
        .t(":"),
        .minute,
        .t(":"),
        .second,
        .t("Z")
    ]

    /// MMM dd, EEE
    /// Jun 16, Fri
    static let MMMddEEE: DateFormat = [
        .monthShort,
        .t(" "),
        .dayOfMonth2Digits,
        .t(", "),
        .dayOfTheWeekShort
    ]

    /// MMM
    /// Jun
    static let monthShort: DateFormat = [
        .monthShort
    ]

    /// d
    /// 16
    static let dayOfMonth1: DateFormat = [
        .dayOfMonth2Digits
    ]

    /// dd
    /// 16
    static let dayOfMonth2: DateFormat = [
        .dayOfMonth2Digits
    ]

    /// yyyy-MM-dd
    /// 2023-06-16
    static let numericDate: DateFormat = .th.numericDateWith(separator: "-")

    /// yyyy-MM-dd
    /// where separator is "-"
    /// 2023-06-16
    static func numericDateWith(separator: String) -> DateFormat {
        return [
            .year4Digits,
            .t(separator),
            .monthNumeric,
            .t(separator),
            .dayOfMonth2Digits
        ]
    }

    /// "MMMM dd yyyy" + " " + timeFormat
    /// August 16 2023 * 03:49 PM
    static let timeFull: DateFormat = .th.timeFullWith(separator: " ")

    /// "MMM dd yyyy" + " " + timeFormat
    /// Aug 16 2023 * 03:49 PM
    static let timeShort: DateFormat = .th.timeShortWith(separator: " ")

    /// HH:mm
    /// 18:30
    static let time24hAndMinutes: DateFormat = [
        .time24hAndMinutes
    ]

    /// hh:mm a
    /// 6:30 AM
    static let time12hAndMinutes: DateFormat = [
        .time12hAndMinutes
    ]

    /// HH
    /// 18
    static let time24h: DateFormat = [
        .time24h
    ]

    /// h a
    /// 6 AM
    static let time12h: DateFormat = [
        .time12h
    ]
}
