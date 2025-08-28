import Foundation
import GovernanceCore

final class TaxonomyStore: ObservableObject {
    @Published var taxonomy = Taxonomy()
    @Published var isDirty = false

    func importJSON(url: URL) throws {
        let data = try Data(contentsOf: url)
        taxonomy = try JSONDecoder().decode(Taxonomy.self, from: data)
        isDirty = false
    }

    func exportJSON(url: URL) throws {
        let data = try JSONEncoder().encode(taxonomy)
        try data.write(to: url, options: .atomic)
        isDirty = false
    }

    func loadSampleFromBundle() {
        if let url = Bundle.main.url(forResource: "taxonomy", withExtension: "json") {
            try? importJSON(url: url)
        }
    }
}
