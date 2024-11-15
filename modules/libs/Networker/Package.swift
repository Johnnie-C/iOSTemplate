// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networker",
    platforms: [.iOS("14.0")],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Networker",
            type: .dynamic,
            targets: ["Networker"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(
            name: "Alamofire",
            url: "https://github.com/Alamofire/Alamofire.git",
            "5.4.0"..<"6.0.0"
        ),
        .package(name: "Common", path: "../Common")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Networker",
            dependencies: [
                "Alamofire",
                "Common"
            ]
        ),
        .testTarget(
            name: "NetworkerTests",
            dependencies: ["Networker"]
        ),
    ]
)
