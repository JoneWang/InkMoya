// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InkMoya",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v11),
        .watchOS(.v6),
    ],
    products: [
        .library(
            name: "InkMoya",
            targets: ["InkMoya"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "InkMoya",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
            ]),
        .testTarget(
            name: "InkMoyaTests",
            dependencies: ["InkMoya"]),
    ]
)
