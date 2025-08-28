import Foundation

public enum CSVEncoder {
    public static func encode(rows: [[String]]) -> String {
        rows.map { row in
            row.map { field in
                let needsQuotes = field.contains(",") || field.contains("\"") || field.contains("\n")
                var f = field.replacingOccurrences(of: "\"", with: "\"\"")
                return needsQuotes ? "\"\(f)\"" : f
            }.joined(separator: ",")
        }.joined(separator: "\n")
    }
}
