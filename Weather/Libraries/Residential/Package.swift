// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Residential",
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Residential",
            targets: [
                "ResidentialNavigation"
            ]
        ),
    ],
    dependencies: [
        .package(path: "../SharedUI")
    ],
    targets: [
        .target(
            name: "ResidentialUI",
            dependencies: [
                .product(name: "SharedUI", package: "SharedUI")
            ]
        ),
        .target(
            name: "ResidentialDomain"
        ),
        .target(
            name: "ResidentialData",
            dependencies: [
                "ResidentialDomain"
            ]
        ),
        .target(
            name: "ResidentialNavigation",
            dependencies: [
                "ResidentialUI",
                "ResidentialData",
                "ResidentialDomain"
            ]
        ),
        .testTarget(
            name: "ResidentialTests",
            dependencies: [
                "ResidentialData",
                "ResidentialDomain",
                "ResidentialUI"
            ]
        ),
    ]
)
