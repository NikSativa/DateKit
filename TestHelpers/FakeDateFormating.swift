import DateKit
import Foundation
import SpryKit

public final class FakeDateFormating: DateFormating, Spryable {
    public enum ClassFunction: String, StringRepresentable {
        case empty
    }

    public enum Function: String, StringRepresentable {
        case string = "string(from:)"
        case date = "date(from:)"
    }

    public init() {}

    public func string(from date: Date) -> String {
        return spryify()
    }

    public func date(from string: String) -> Date? {
        return spryify()
    }
}
