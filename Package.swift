// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FusionLocalAuth",
    platforms: [.macOS(.v10_14), .iOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FusionLocalAuth",
            targets: ["FusionLocalAuth"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
         .package(name: "Android", url: "https://github.com/scade-platform/swift-android.git", .branch("android/24"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "FusionLocalAuth",
            dependencies: [
                .target(name: "FusionLocalAuth_Common"),
                .target(name: "FusionLocalAuth_Apple", condition: .when(platforms: [.iOS, .macOS])),
                 .target(name: "FusionLocalAuth_Android", condition: .when(platforms: [.android])),
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
        .target(
            name: "FusionLocalAuth_Android",
            dependencies: [
              .target(name: "FusionLocalAuth_Common"),
              .product(name: "Android", package: "Android", condition: .when(platforms: [.android])),
              .product(name: "AndroidOS", package: "Android", condition: .when(platforms: [.android])),
              .product(name: "AndroidApp", package: "Android", condition: .when(platforms: [.android]))              
            ],
            resources: [.copy("Generated/FusionLocalAuth_Android.java")]         
        )            
    ]
)
