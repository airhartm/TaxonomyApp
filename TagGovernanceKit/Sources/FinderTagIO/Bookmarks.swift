import Foundation

public enum Bookmarks {
    public static func makeBookmark(for url: URL) throws -> Data {
        try url.bookmarkData(options: .withSecurityScope,
                             includingResourceValuesForKeys: nil,
                             relativeTo: nil)
    }

    public static func resolve(_ data: Data) throws -> URL {
        var stale = false
        let url = try URL(resolvingBookmarkData: data,
                          options: [.withSecurityScope],
                          relativeTo: nil,
                          bookmarkDataIsStale: &stale)
        _ = url.startAccessingSecurityScopedResource()
        return url
    }
}
