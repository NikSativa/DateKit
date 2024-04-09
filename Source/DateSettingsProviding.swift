import Foundation

public protocol DateSettingsProviding {
    var now: Date { get }
    var is24h: Bool { get }
    var timeZone: TimeZone { get }
}

internal struct DateSettingsProvider: DateSettingsProviding {
    let is24h: Bool

    /// used to check 24h settings on device only. use `defaultLocale` for all other cases
    init(time24hLocale: Locale = .current) {
        let j = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: time24hLocale)
        self.is24h = j?.contains("a") == false
    }

    var now: Date {
        return .init()
    }

    var timeZone: TimeZone {
        return .current
    }
}
