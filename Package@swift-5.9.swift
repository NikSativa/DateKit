// swift-tools-version:5.9
// swiftformat:disable all
import PackageDescription

let package = Package(
    name: "DateKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .macCatalyst(.v13),
        .visionOS(.v1),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "DateKit", targets: ["DateKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/NikSativa/SpryKit.git", .upToNextMinor(from: "3.0.2"))
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
