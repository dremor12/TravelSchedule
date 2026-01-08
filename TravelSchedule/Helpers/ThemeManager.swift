import SwiftUI

enum AppTheme: String, CaseIterable {
    case system = "system"
    case light = "light"
    case dark = "dark"
    
    var colorScheme: ColorScheme? {
        switch self {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

class ThemeManager: ObservableObject {
    @Published var currentTheme: AppTheme {
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
            // Default to light theme and migrate old system value
            self.currentTheme = .light
            UserDefaults.standard.set(AppTheme.light.rawValue, forKey: "appTheme")
        }
    }
}

