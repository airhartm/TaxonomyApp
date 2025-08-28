import Foundation

public enum IssueSeverity { case warning, error }

public struct Issue: Identifiable {
    public let id = UUID()
    public let severity: IssueSeverity
    public let description: String
}

public enum GovernanceService {
    /// Very lightweight validator (aliases + trivial mutex).
    public static func evaluate(_ currentTags: [String], taxonomy: Taxonomy) -> [Issue] {
        var issues: [Issue] = []

        // Alias suggestions
        for tag in currentTags {
            if let canonical = taxonomy.aliases[tag], canonical != tag {
                issues.append(.init(severity: .warning, description: "Alias: “\(tag)” → “\(canonical)”"))
            }
        }

        // Mutex (simple: if more than one from a mutex set is present)
        let set = Set(currentTags)
        for group in taxonomy.rules.mutex {
            let present = group.filter { set.contains($0) }
            if present.count > 1 {
                issues.append(.init(severity: .error, description: "Mutex conflict: \(present.joined(separator: ", "))"))
            }
        }

        return issues
    }
}
