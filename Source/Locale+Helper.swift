import Foundation

public extension Locale {
    @inline(__always)
    static var en_US: Self {
        return .init(identifier: "en_US_POSIX")
    }
}
