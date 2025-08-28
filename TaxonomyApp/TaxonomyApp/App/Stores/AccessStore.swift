import Foundation
import AppKit

final class AccessStore: ObservableObject {
    @Published var roots: [URL] = []

    func pickRootFolder() {
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false
        if panel.runModal() == .OK, let url = panel.url {
            roots = [url]
        }
    }

    var selectedRoot: URL? { roots.first }
}
