import Foundation

public final class FileWalker {
    public init() {}

    public func walkFiles(root: URL, visit: (URL) -> Void) {
        guard let e = FileManager.default.enumerator(at: root,
                                                     includingPropertiesForKeys: [.isRegularFileKey],
                                                     options: [.skipsHiddenFiles]) else { return }
        for case let fileURL as URL in e {
            if (try? fileURL.resourceValues(forKeys: [.isRegularFileKey]).isRegularFile) ?? false {
                visit(fileURL)
            }
        }
    }
}
