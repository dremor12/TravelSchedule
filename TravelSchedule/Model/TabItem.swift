import SwiftUI

enum TabItem: CaseIterable {
    case main
    case settings
    
    var iconName: String {
        switch self {
        case .main:
            return "arrow.up.message.fill"
        case .settings:
            return "gearshape.fill"
        }
    }
}

