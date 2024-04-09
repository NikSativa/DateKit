import Foundation

public enum DateComponent: Equatable {
    /// yyyy
    /// 2023
    case year4Digits

    /// yy
    /// 23
    case year2Digits

    /// MMMM
    /// August
    case monthFull

    /// MMM
    /// Aug
    case monthShort

    /// MM
    /// 06
    case monthNumeric

    /// d
    /// 6
    case dayOfMonth1Digit

    /// min 2 digits
    /// dd
    /// 06
    case dayOfMonth2Digits

    /// EEEE
    /// Friday
    case dayOfTheWeek

    /// E or EE or EEE
    /// Fri
    case dayOfTheWeekShort

    /// HH
    /// 18
    case time24h

    /// HH:mm
    /// 18:30
    case time24hAndMinutes

    /// h a
    /// 6 AM
    case time12h

    /// hh:mm a
    /// 6:30 AM
    case time12hAndMinutes

    /// HH
    /// 16
    case hour

    /// mm
    /// 49
    case minute

    /// ss
    /// 33
    case second

    case text(String)

    /// short name of case .text
    public static func t(_ v: String) -> Self {
        return .text(v)
    }

    public var asString: String {
        switch self {
        case .year4Digits:
            return "yyyy"
        case .year2Digits:
            return "yy"
        case .monthNumeric:
            return "MM"
        case .monthFull:
            return "MMMM"
        case .monthShort:
            return "MMM"
        case .dayOfMonth1Digit:
            return "d"
        case .dayOfMonth2Digits:
            return "dd"
        case .dayOfTheWeek:
            return "EEEE"
        case .dayOfTheWeekShort:
            return "EE"
        case .time24h:
            return "HH"
        case .time24hAndMinutes:
            return "HH:mm"
        case .time12h:
            return "h a"
        case .time12hAndMinutes:
            return "hh:mm a"
        case .hour:
            return "HH"
        case .minute:
            return "mm"
        case .second:
            return "ss"
        case .text(let v):
            return v
        }
    }
}

// MARK: - ExpressibleByStringLiteral

extension DateComponent: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .t(value)
    }
}
