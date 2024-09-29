import Foundation

public extension Locale {
    static var ua_UA: Self {
        return .init(identifier: "ua_UA_POSIX")
    }

    static var defaultLocale: Self {
        return .current
    }
}
