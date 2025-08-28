import SwiftUI
import BatchEngine

struct ApplyRemoveView: View {
    @EnvironmentObject var access: AccessStore
    @State private var tagsText = ""
    @State private var removeMode = false
    @State private var last: BatchResult?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Target Folder: \(access.selectedRoot?.path ?? "None")").font(.headline)
            HStack {
                TextField("Tags (comma-separated, e.g., DocType/Invoice, Year/2025)", text: $tagsText)
                Toggle("Remove", isOn: $removeMode)
                Button("Run") { run() }.disabled(access.selectedRoot == nil || tagsText.isEmpty)
            }
            if let r = last {
                Text("Updated: \(r.updated), Skipped: \(r.skipped), Errors: \(r.errors)")
            }
            Spacer()
        }
        .padding(.top, 6)
    }

    private func run() {
        guard let root = access.selectedRoot else { return }
        let tags = tagsText.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        let engine = BatchEngine()
        last = engine.apply(tags: tags, root: root, remove: removeMode)
    }
}

#Preview {
    ApplyRemoveView().environmentObject(AccessStore())
}
