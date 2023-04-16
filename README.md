# FusionLocalAuth

A cross-platform Fusion library to implement the local authentication using Biometry, or device password. It is fully compatible cross-platform for iOS and Android.

Features:

### 1.) detect whether the device has Biometry enabled or not


    
                canAuthenticateWithBiometrics()
   


### 2.) request for only Biometry authentication (face auth or fingerprint)


    
    
                requestBiometricAuthentication()
  
                
    
### 3.) request for Biometry authentication (face auth or fingerprint or pin/password)


   
                requestDeviceAuthentication()


## Integration

### Add to `Package.swift`

```swift
// swift-tools-version:5.3
import Foundation
import PackageDescription

let SCADE_SDK = ProcessInfo.processInfo.environment["SCADE_SDK"] ?? ""

let package = Package(
  name: "LocalAuthDemo",
  platforms: [
    .macOS(.v10_14)
  ],
  products: [
    .library(
      name: "LocalAuthDemo",
      type: .static,
      targets: [
        "LocalAuthDemo"
      ]
    )
  ],
  dependencies: [
    .package(
      name: "FusionLocalAuth", url: "https://github.com/scade-platform/FusionLocalAuth.git",
      .branch("android_impl")),
   
  ],
  targets: [
    .target(
      name: "LocalAuthDemo",
      dependencies: [
        .product(name: "FusionLocalAuth", package: "FusionLocalAuth"),
      ],
      exclude: ["main.page"],
      swiftSettings: [
        .unsafeFlags(["-F", SCADE_SDK], .when(platforms: [.macOS, .iOS])),
        .unsafeFlags(["-I", "\(SCADE_SDK)/include"], .when(platforms: [.android])),
      ]
    )
  ]
)
```

