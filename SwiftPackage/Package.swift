// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftPackage",
    platforms: [
       .iOS(.v13) // Set minimum iOS version here
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftPackage",
            targets: ["SwiftPackage"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", from: "15.0.3"),                              //网络库
        .package(url: "https://github.com/Instagram/IGListKit.git", from: "5.0.0"),                     //CollectionView组件
        .package(url: "https://github.com/scalessec/Toast-Swift.git", from: "5.1.1"),                   //Toast
        .package(url: "https://github.com/CocoaLumberjack/CocoaLumberjack.git", from: "3.8.5"),         //log日志打印记录
        .package(url: "https://github.com/devxoul/Then.git", from: "3.0.0"),                            //Then语法糖
        .package(url: "https://github.com/pujiaxin33/JXSegmentedView.git", from: "1.4.1"),              //TabLayout组件
        .package(url: "https://github.com/CombineCommunity/CombineExt.git", from: "1.8.1")              //Combine拓展库
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftPackage",
            dependencies: [
                .product(name: "Moya", package: "Moya"),
                .product(name: "IGListKit", package: "IGListKit"),
                .product(name: "Toast", package: "Toast-Swift"),
                .product(name: "CocoaLumberjackSwift", package: "CocoaLumberjack"),
                .product(name: "Then", package: "Then"),
                .product(name: "JXSegmentedView", package: "JXSegmentedView"),
                .product(name: "CombineExt", package: "CombineExt"),
            ],
        ),
    ]
)
