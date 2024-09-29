import Foundation

#if swift(>=6.0)
public protocol DateFormating: Sendable {
    func string(from date: Date) -> String
    func date(from string: String) -> Date?
}
#else
public protocol DateFormating {
    func string(from date: Date) -> String
    func date(from string: String) -> Date?
}
#endif

extension DateFormatter: DateFormating {}

public extension DateFormatter {
    func set(dateFormat: DateFormat) {
        self.dateFormat = dateFormat.asString
    }
}
