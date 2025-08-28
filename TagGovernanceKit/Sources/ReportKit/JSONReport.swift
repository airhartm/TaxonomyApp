import Foundation

public enum JSONReport {
    public static func dump<T: Encodable>(_ value: T) -> String {
        let e = JSONEncoder()
        e.outputFormatting = [.prettyPrinted, .sortedKeys]
        if let data = try? e.encode(EncodableBox(value)) {
            return String(decoding: data, as: UTF8.self)
        }
        return "{}"
    }
}

// Helper to encode any Encodable without exposing its concrete type.
private struct EncodableBox<T: Encodable>: Encodable {
    let value: T
    init(_ v: T) { value = v }
    func encode(to encoder: Encoder) throws { try value.encode(to: encoder) }
}
