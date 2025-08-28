import Testing
@testable import BatchEngine

@Test func placeholder_batch() {
    let r = BatchEngine().apply(tags: [], root: URL(fileURLWithPath: "/"), remove: false)
    #expect(r.updated >= 0 || r.errors >= 0)
}
