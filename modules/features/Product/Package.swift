// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Product",
    platforms: [.iOS("16.0")],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Product",
            type: .dynamic,
            targets: ["Product"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "Common", path: "../libs/Common"),
        .package(name: "API", path: "../libs/API"),
        .package(name: "Networker", path: "../libs/Networker"),
        .package(
            name: "SDWebImageSwiftUI",
            url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git",
            "2.2.1"..<"3.0.0"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Product",
            dependencies: [
                "Common",
                "API",
                "Networker",
                "SDWebImageSwiftUI"
            ],
            resources: [.process("Resources")]
        ),
    ]
)
