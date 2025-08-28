import SwiftUI

@main
struct TaxonomyApp: App {
    @StateObject var taxStore = TaxonomyStore()
    @StateObject var accessStore = AccessStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(taxStore)
                .environmentObject(accessStore)
                .onAppear { taxStore.loadSampleFromBundle() }
        }
    }
}
