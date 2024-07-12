// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "KochavaMacros",
    platforms: 
    [
        .iOS(.v13),
        .macCatalyst(.v13),
        .macOS(.v12),
        .tvOS(.v13),
        .visionOS(.v1),
        .watchOS(.v6)
    ],
    products: 
    [
        .library(
            name: "KochavaMacros",
            targets: 
            [
                "KochavaMacros"
            ]
        ),
        .executable(
            name: "KochavaMacrosClient",
            targets: 
            [
                "KochavaMacrosClient"
            ]
        )
    ],
    dependencies: 
    [
        .package(
            url: "https://github.com/apple/swift-syntax.git",
            from: "509.0.0"
        )
    ],
    targets: 
    [
        .macro(
            name: "KochavaMacrosMacros",
            dependencies: 
            [
                .product(
                    name: "SwiftSyntaxMacros",
                    package: "swift-syntax"
                ),
                .product(
                    name: "SwiftCompilerPlugin",
                    package: "swift-syntax"
                )
            ]
        ),

        .target(
            name: "KochavaMacros",
            dependencies: 
            [
                "KochavaMacrosMacros"
            ]
        ),

        // A client of the library, which is able to use the macro in its own code.
        .executableTarget(
            name: "KochavaMacrosClient",
            dependencies: 
            [
                "KochavaMacros"
            ]
        ),

        .testTarget(
            name: "KochavaMacrosTests",
            dependencies: 
            [
                "KochavaMacrosMacros",
                .product(
                    name: "SwiftSyntaxMacrosTestSupport",
                    package: "swift-syntax"
                )
            ]
        )
    ]
)
