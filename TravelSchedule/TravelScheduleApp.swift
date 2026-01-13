import SwiftUI

@main
struct TravelScheduleApp: App {
    private let themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(themeManager.currentTheme.colorScheme)
                .environment(themeManager)
        }
    }
}
