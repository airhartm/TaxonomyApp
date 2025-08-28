import SwiftUI
import GovernanceCore
import FinderTagIO

struct TagInspectorView: View {
    @EnvironmentObject var tax: TaxonomyStore
    @EnvironmentObject var access: AccessStore
    @State private var files: [URL] = []
    @State private var selected: URL?

    var body: some View {
        HStack {
            // Left: folder + file list
            VStack(alignment: .leading) {
                Text("Folder: \(access.selectedRoot?.path ?? "None")").font(.headline)
                HStack {
                    Button("Choose Folder…") { access.pickRootFolder(); loadFiles() }
                    Button("Refresh") { loadFiles() }.disabled(access.selectedRoot == nil)
                }
                List(files, id: \.self, selection: $selected) { Text($0.lastPathComponent) }
            }.frame(minWidth: 300)

            Divider()

            // Right: tag details
            VStack(alignment: .leading, spacing: 8) {
                if let url = selected {
                    Text(url.lastPathComponent).font(.headline)
                    let current = (try? FinderTags.getTags(for: url)) ?? []
                    let issues = GovernanceService.evaluate(current, taxonomy: tax.taxonomy)
                    Text("Current Tags: \(current.joined(separator: ", "))").font(.callout)
                    if issues.isEmpty {
                        Text("No issues").foregroundStyle(.green)
                    } else {
                        ForEach(issues) { issue in
                            Text(issue.description)
                                .foregroundStyle(issue.severity == .error ? .red : .orange)
                        }
                    }
                } else {
                    Text("Select a file to inspect.")
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
        .onAppear { loadFiles() }
        .padding(.top, 6)
    }

    private func loadFiles() {
        files.removeAll()
        guard let root = access.selectedRoot else { return }
        let walker = FileWalker()
        walker.walkFiles(root: root) { files.append($0) }
    }
}

#Preview {
    TagInspectorView()
        .environmentObject(TaxonomyStore())
        .environmentObject(AccessStore())
}
