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
            targets: ["HyperLottie"]
        )
    ],
    dependencies: [
        .package(name: "lottie-ios", url: "https://github.com/airbnb/lottie-ios.git", "3.5.0"..<"5.0.0"),
    ],
    targets: [
        .target(
            name: "HyperLottie",
            dependencies: [
                .product(name: "Lottie", package: "lottie-ios"),
            ],
            path: "Sources/HyperLottie",
        )
    ]
)