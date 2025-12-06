// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "NebulaKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "NebulaKit",
            targets: ["NebulaKit"]
        ),
    ],
    targets: [
        .target(
            name: "NebulaKit",
            dependencies: [],
            path: "Sources/NebulaKit"
        ),
        .testTarget(
            name: "NebulaKitTests",
            dependencies: ["NebulaKit"],
            path: "Tests/NebulaKitTests"
        ),
    ]
)
