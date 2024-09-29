import DateKit
import Foundation
import SpryKit

public final class FakeDateSettingsProvider: DateSettingsProviding, Spryable {
    public enum ClassFunction: String, StringRepresentable {
        case empty
    }

    public enum Function: String, StringRepresentable {
        case now
        case is24h
        case timeZone
    }

    public init() {}

    public var now: Date {
        return spryify()
    }

    public var is24h: Bool {
        return spryify()
    }

    public var timeZone: TimeZone {
        return spryify()
    }
}
