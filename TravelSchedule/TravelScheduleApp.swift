import SwiftUI

@main
struct TravelScheduleApp: App {
    @StateObject private var themeManager = ThemeManager()
    
    init() {
        configureTabBarAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(themeManager.currentTheme.colorScheme)
                .environmentObject(themeManager)
        }
    }
    
    
    private func configureTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        
        tabBarAppearance.shadowColor = UIColor.separator
        tabBarAppearance.shadowImage = nil
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}
