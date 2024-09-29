import DateKit
import Foundation

public extension DateHelper {
    convenience init(fakeDateProvider dateProvider: FakeDateSettingsProvider) {
        self.init(dateProvider: dateProvider)
    }
}
