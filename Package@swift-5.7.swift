// swift-tools-version:5.7
// swiftformat:disable all
import PackageDescription

let package = Package(
    name: "DateKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .macCatalyst(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "DateKit", targets: ["DateKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/NikSativa/SpryKit.git", .upToNextMajor(from: "2.2.3"))
    ],
    targets: [
        .target(name: "DateKit",
                dependencies: [
                ],
                path: "Source",
                resources: [
                    .copy("../PrivacyInfo.xcprivacy")
                ]),
        .target(name: "DateKitTestHelpers",
                dependencies: [
                    "DateKit",
                    "SpryKit"
                ],
                path: "TestHelpers",
                resources: [
                    .copy("../PrivacyInfo.xcprivacy")
                ]),
        .testTarget(name: "DateKitTests",
                    dependencies: [
                        "DateKit",
                        "DateKitTestHelpers",
                        "SpryKit"
                    ],
                    path: "Tests")
    ]
)
