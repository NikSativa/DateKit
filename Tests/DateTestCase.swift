import DateKit
import DateKitTestHelpers
import Foundation
import SpryKit
import XCTest

open class DateTestCase: XCTestCase {
    public lazy var dateProvider = FakeDateSettingsProvider()
    public lazy var subject = DateHelper(fakeDateProvider: dateProvider)

    override open func setUp() {
        super.setUp()
        subject.defaultLocale = .en_US
    }

    override open func tearDown() {
        super.tearDown()
        subject.defaultLocale = .defaultLocale
        dateProvider.resetCallsAndStubs()
    }
}
