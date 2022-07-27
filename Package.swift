// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WherebySDK",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "WherebySDK",
            targets: ["WherebySDK", "mediasoup_client_ios", "WebRTC"])
    ],
    targets: [
        .binaryTarget(name: "WherebySDK", path: "WherebySDK.xcframework"),
        .binaryTarget(name: "mediasoup_client_ios", path: "mediasoup_client_ios.xcframework"),
        .binaryTarget(name: "WebRTC", path: "WebRTC.xcframework")
    ]
)
