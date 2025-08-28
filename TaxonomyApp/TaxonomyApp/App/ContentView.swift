import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TaxonomyEditorView()
                .tabItem { Text("Taxonomy") }
            TagInspectorView()
                .tabItem { Text("Inspector") }
            ApplyRemoveView()
                .tabItem { Text("Apply/Remove") }
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environmentObject(TaxonomyStore())
        .environmentObject(AccessStore())
}
