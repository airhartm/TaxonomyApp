// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "TagGovernanceKit",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "GovernanceCore", targets: ["GovernanceCore"]),
        .library(name: "FinderTagIO", targets: ["FinderTagIO"]),
        .library(name: "BatchEngine", targets: ["BatchEngine"]),
        .library(name: "ReportKit", targets: ["ReportKit"])
    ],
    targets: [
        .target(name: "GovernanceCore"),
        .target(name: "FinderTagIO", dependencies: ["GovernanceCore"]),
        .target(name: "BatchEngine", dependencies: ["GovernanceCore", "FinderTagIO"]),
        .target(name: "ReportKit"),
        .testTarget(name: "GovernanceCoreTests", dependencies: ["GovernanceCore"]),
        .testTarget(name: "FinderTagIOTests", dependencies: ["FinderTagIO"]),
        .testTarget(name: "BatchEngineTests", dependencies: ["BatchEngine"])
    ]
)
