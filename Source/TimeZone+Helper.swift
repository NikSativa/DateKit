import Foundation

public extension TimeZone {
    static let utc: TimeZone = {
        if #available(iOS 16, macOS 13, tvOS 16, watchOS 9, *) {
            return .gmt
        }

        if let timeZone = TimeZone(abbreviation: "UTC") ?? TimeZone(secondsFromGMT: 0) {
            return timeZone
        }
        assertionFailure("Failed to create UTC TimeZone")
        return .current
    }()
}
