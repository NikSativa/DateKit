import Foundation

public extension TimeZone {
    /// default UTC
    static func testMake(secondsFromGMT: Int = 0) -> Self {
        return .init(secondsFromGMT: secondsFromGMT)!
    }

    /// UTC + hours
    static func testMake(addHours: Int) -> Self {
        return .testMake(secondsFromGMT: 60 * 60 * addHours)
    }

    static var defaultTimeZone: Self {
        return .current
    }
}
