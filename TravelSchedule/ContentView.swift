import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct ContentView: View {
    var body: some View {
        TabView {
            VStack {
                Spacer()
                    .frame(height: 208)
                DirectionInputView()
                Spacer()
            }
            .tabItem {
                Image(systemName: "arrow.up.message.fill")
            }
            
            ZStack {
                SettingsView()
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
            }
            
        }
        .tint(Colors.blackTopicColor)
    }
}


#Preview {
    ContentView()
}
