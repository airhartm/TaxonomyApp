import Foundation

public enum FinderTags {
    public static func getTags(for url: URL) throws -> [String] {
        // Ask for the tag names key explicitly
        let values = try url.resourceValues(forKeys: [URLResourceKey.tagNamesKey])
        return values.tagNames ?? []
    }

    public static func setTags(_ tags: [String], for url: URL) throws {
        // Use the Objective-C NSURL API; URL does not expose setResourceValue in Swift.
        try (url as NSURL).setResourceValue(tags, forKey: URLResourceKey.tagNamesKey)
    }
}