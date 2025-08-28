import Foundation

public struct Taxonomy: Codable, Equatable {   // ← Codable is required
    public var version: Int = 1
    public var separator: String = "/"
    public var facets: [String] = []
    public var values: [String: [String]] = [:]
    public var aliases: [String: String] = [:]
    public var rules: Rules = .init()
    public var bundles: [String: [String]] = [:]
    public init() {}
}

public struct Rules: Codable, Equatable {
    public var requires: [RequireRule] = []
    public var mutex: [[String]] = []
    public init() {}
}

public struct RequireRule: Codable, Equatable {
    public var `if`: String
    public var then: [String]
}
