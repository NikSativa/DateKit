import Foundation

public struct DateFormat: Equatable {
    private let components: [DateComponent]
    public let asString: String

    public init(components: [DateComponent]) {
        self.components = components
        self.asString = components.map(\.asString).joined()
    }

    public var debugDisplayNames: [String] {
        return components.map {
            return String(reflecting: $0).components(separatedBy: ".").last.unsafelyUnwrapped
        }
    }
}

// MARK: - ExpressibleByStringLiteral

extension DateFormat: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.components = [.t(value)]
        self.asString = value
    }
}

// MARK: - ExpressibleByArrayLiteral

extension DateFormat: ExpressibleByArrayLiteral {
    public init(arrayLiteral components: DateComponent...) {
        self.init(components: components)
    }
}

// MARK: - CustomStringConvertible

extension DateFormat: CustomStringConvertible {
    public var description: String {
        return asString
    }
}

// MARK: - CustomDebugStringConvertible

extension DateFormat: CustomDebugStringConvertible {
    public var debugDescription: String {
        return debugDisplayNames.joined(separator: ", ")
    }
}
