// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "MountainrCore",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(name: "MountainrCore", targets: ["MountainrCore"])
  ],
  dependencies: [
    .package(url: "https://github.com/groue/GRDB.swift.git", from: "6.0.0")
  ],
  targets: [
    .target(
      name: "MountainrCore",
      dependencies: [
        .product(name: "GRDB", package: "GRDB.swift")
      ]
    )
  ]
)
