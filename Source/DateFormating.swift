import Foundation

public protocol DateFormating {
    func string(from date: Date) -> String
    func date(from string: String) -> Date?
}

extension DateFormatter: DateFormating {}

public extension DateFormatter {
    func set(dateFormat: DateFormat) {
        self.dateFormat = dateFormat.asString
    }
}
