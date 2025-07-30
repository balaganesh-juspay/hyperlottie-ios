// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "HyperLottie",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "HyperLottie",
            targets: ["HyperLottie", "HyperLottieDependencies"]
        )
    ],
    dependencies: [
        .package(name: "lottie-ios", url: "https://github.com/airbnb/lottie-ios.git", from: "3.5.0"),
    ],
    targets: [
        .target(
            name: "HyperLottie",
            path: "Sources/HyperLottie",
        ),
        .target(
            name: "HyperLottieDependencies",
            dependencies: [
                .product(name: "Lottie", package: "lottie-ios"),
            ]
        )
    ]
)