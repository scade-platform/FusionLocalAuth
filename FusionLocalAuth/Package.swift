// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FusionLocalAuth",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FusionLocalAuth",
            targets: ["FusionLocalAuth"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "FusionLocalAuth",
            dependencies: [
                .target(name: "FusionLocalAuth_Common"),
                .target(name: "FusionLocalAuth_Apple", condition: .when(platforms: [.iOS, .macOS])),
            ]),
        .target(
            name: "FusionLocalAuth_Common"
        ),
        .target(
            name: "FusionLocalAuth_Apple",
            dependencies: [
                .target(name: "FusionLocalAuth_Common"),
            ]
        ),
        .testTarget(
            name: "FusionLocalAuthTests",
            dependencies: ["FusionLocalAuth"]),
    ]
)
