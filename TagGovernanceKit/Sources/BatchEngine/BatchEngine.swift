import Foundation
import FinderTagIO

public final class BatchEngine {
    public init() {}

    public func apply(tags: [String], root: URL, remove: Bool) -> BatchResult {
        var r = BatchResult()
        let walker = FileWalker()
        walker.walkFiles(root: root) { url in
            do {
                var cur = try FinderTags.getTags(for: url)
                if remove {
                    let set = Set(tags)
                    cur.removeAll { set.contains($0) }
                } else {
                    for t in tags where !cur.contains(t) { cur.append(t) }
                }
                try FinderTags.setTags(cur, for: url)
                r.updated += 1
            } catch {
                r.errors += 1
            }
        }
        return r
    }
}
