// swift-tools-version:5.10
// swiftformat:disable all
import PackageDescription

let package = Package(
    name: "DateKit",
    platforms: [
        .iOS(.v16),
        .macOS(.v14),
        .macCatalyst(.v16),
        .visionOS(.v1),
        .tvOS(.v16),
        .watchOS(.v9)
    ],
    products: [
        .library(name: "DateKit", targets: ["DateKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/NikSativa/SpryKit.git", from: "3.1.0")
    ],
    targets: [
        .target(name: "DateKit",
                dependencies: [
                ],
                path: "Source",
                resources: [
                    .process("PrivacyInfo.xcprivacy")
                ]),
        .testTarget(name: "DateKitTests",
                    dependencies: [
                        "DateKit",
                        "SpryKit"
                    ],
                    path: "Tests")
    ]
)
