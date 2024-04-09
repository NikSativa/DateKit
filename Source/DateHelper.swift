import Foundation

/// shortcut fot DateHelper
public var DH: DateHelper {
    return DateHelper.default
}

public final class DateHelper {
    public static let `default`: DateHelper = .init()

    /// default is `.current`
    public var defaultLocale: Locale = .current

    private let dateSettingsProvider: DateSettingsProviding
    private var cached: [String: DateFormating] = [:]

    public init(dateProvider: DateSettingsProviding? = nil) {
        self.dateSettingsProvider = dateProvider ?? DateSettingsProvider()
    }

    public var now: Date {
        return dateSettingsProvider.now
    }

    public var timeZone: TimeZone {
        return dateSettingsProvider.timeZone
    }

    public var is24h: Bool {
        return dateSettingsProvider.is24h
    }

    public lazy var time: DateFormat = is24h ? [.time24hAndMinutes] : [.time12hAndMinutes]
}

// MARK: -

public extension DateHelper {
    func formatter(withFormat dateFormat: DateFormat,
                   isUTC: Bool,
                   locale: Locale? = nil) -> DateFormating {
        let dateFormat = dateFormat.asString
        let locale = locale ?? defaultLocale

        let key = [
            dateFormat,
            isUTC ? "UTC" : "local",
            locale.identifier
        ].joined(separator: "/")

        if let formatter = cached[key] {
            return formatter
        }

        let formatter = DateFormatter()
        if isUTC {
            formatter.timeZone = .utc
        } else {
            formatter.timeZone = dateSettingsProvider.timeZone
        }

        formatter.locale = locale
        formatter.dateFormat = dateFormat
        cached[key] = formatter
        return formatter
    }

    func date(withFormat f: DateFormat,
              from str: String,
              isUTC: Bool,
              locale: Locale? = nil) -> Date? {
        let formatter = formatter(withFormat: f,
                                  isUTC: isUTC,
                                  locale: locale)
        let date = formatter.date(from: str)
        return date
    }

    func string(withFormat f: DateFormat,
                from date: Date,
                isUTC: Bool,
                locale: Locale? = nil) -> String? {
        let formatter = formatter(withFormat: f,
                                  isUTC: isUTC,
                                  locale: locale)
        let str = formatter.string(from: date)
        return str
    }

    func convert(stringDate str: String,
                 from: DateFormat,
                 fromUTC: Bool,
                 to: DateFormat,
                 toUTC: Bool) -> String? {
        let fromFormatter = formatter(withFormat: from, isUTC: fromUTC)
        guard let date = fromFormatter.date(from: str) else {
            return nil
        }

        let toFormatter = formatter(withFormat: to, isUTC: toUTC)
        let str = toFormatter.string(from: date)
        return str
    }
}
