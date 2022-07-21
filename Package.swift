// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WherebySDK",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "WherebySDK",
            targets: ["WherebySDK", "mediasoup_client_ios", "WebRTC"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(name: "WherebySDK", path: "WherebySDK.xcframework"),
        .binaryTarget(name: "mediasoup_client_ios", path: "mediasoup_client_ios.xcframework"),
        .binaryTarget(name: "WebRTC", path: "WebRTC.xcframework")
    ]
)
