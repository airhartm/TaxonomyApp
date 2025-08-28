import SwiftUI
import GovernanceCore
import UniformTypeIdentifiers

struct TaxonomyEditorView: View {
    @EnvironmentObject var store: TaxonomyStore
    @State private var selectedFacet: String?
    @State private var newFacet = ""
    @State private var newValue = ""
    
    var body: some View {
        HStack {
            // Facets
            VStack(alignment: .leading) {
                Text("Facets").font(.headline)
                List(selection: $selectedFacet) {
                    ForEach(store.taxonomy.facets, id: \.self) { Text($0) }
                        .onDelete { idx in
                            for i in idx { store.taxonomy.values.removeValue(forKey: store.taxonomy.facets[i]) }
                            store.taxonomy.facets.remove(atOffsets: idx)
                            store.isDirty = true
                        }
                }
                HStack {
                    TextField("Add facet", text: $newFacet)
                    Button("Add") {
                        guard !newFacet.isEmpty else { return }
                        store.taxonomy.facets.append(newFacet)
                        store.taxonomy.values[newFacet] = []
                        newFacet = ""; store.isDirty = true
                    }
                }
            }
            .frame(minWidth: 240)
            
            Divider()
            
            // Values for selected facet
            VStack(alignment: .leading) {
                Text(selectedFacet ?? "Select a facet").font(.headline)
                if let f = selectedFacet {
                    List {
                        ForEach(store.taxonomy.values[f] ?? [], id: \.self) { Text($0) }
                            .onDelete {
                                store.taxonomy.values[f]?.remove(atOffsets: $0)
                                store.isDirty = true
                            }
                    }
                    HStack {
                        TextField("Add value", text: $newValue)
                        Button("Add") {
                            guard !newValue.isEmpty else { return }
                            store.taxonomy.values[f, default: []].append(newValue)
                            newValue = ""; store.isDirty = true
                        }
                    }
                }
                Spacer()
                HStack {
                    Button("Import JSON") { importJSON() }
                    Button("Export JSON") { exportJSON() }
                }
            }
        }
    }
    
    private func importJSON() {
        let p = NSOpenPanel()
        p.allowedContentTypes = [.json]        // ← was: allowedFileTypes = ["json"]
        if p.runModal() == .OK, let url = p.url { try? store.importJSON(url: url) }
    }
    private func exportJSON() {
        let p = NSSavePanel()
        p.allowedContentTypes = [.json]        // ← was: allowedFileTypes = ["json"]
        p.nameFieldStringValue = "taxonomy.json"
        if p.runModal() == .OK, let url = p.url { try? store.exportJSON(url: url) }
    }
}
#Preview {
    TaxonomyEditorView().environmentObject(TaxonomyStore())
}
