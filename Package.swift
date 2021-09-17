// swift-tools-version:1.0.1
import PackageDescription

let package = Package(
    name: "JJCSwiftTools",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "JJCSwiftTools", targets: ["JJCSwiftTools"])
    ],
    targets: [
        .target(
            name: "JJCSwiftTools",
            path: "Sources"
        )
    ]
)
