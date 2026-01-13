import SwiftUI

@Observable
final class ThemeManager {
    var currentTheme: AppTheme {
        didSet {
            UserDefaults.standard.set(currentTheme.rawValue, forKey: "appTheme")
        }
    }
    
    var isDarkMode: Bool {
        currentTheme == .dark
    }
    
    init() {
        let savedTheme = UserDefaults.standard.string(forKey: "appTheme")
        if let savedTheme = savedTheme, let theme = AppTheme(rawValue: savedTheme), theme != .system {
            self.currentTheme = theme
        } else {
            self.currentTheme = .light
            UserDefaults.standard.set(AppTheme.light.rawValue, forKey: "appTheme")
        }
    }
}

