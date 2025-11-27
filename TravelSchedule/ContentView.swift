import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            RequestExamples.testFetchStations()
            RequestExamples.testSearch()
            RequestExamples.testListStation()
            RequestExamples.testThread()
            RequestExamples.testFetchCity()
            RequestExamples.testCopyright()
            RequestExamples.testCarrierInfo()
            RequestExamples.testAllStations()
        }
    }
}


#Preview {
    ContentView()
}
