// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "SharedUI",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "SharedUI",
            targets: ["SharedUI"]),
    ],
    targets: [
        .target(
            name: "SharedUI")
    ]
)
