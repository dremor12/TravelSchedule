import SwiftUI

struct Colors {
    static let viewBackgroundColor = Color(.systemBackground)
    
    static let blackTopicColor: Color = Color(UIColor { traits in
        if traits.userInterfaceStyle == .light {
            return UIColor.ypBlackDay
        } else {
            return UIColor.ypBlackNight
        }
    })

    static let whiteTopicColor: Color = Color(UIColor { traits in
        if traits.userInterfaceStyle == .light {
            return UIColor.ypWhiteDay
        } else {
            return UIColor.ypWhiteNight
        }
    })
    
    static let searchTopicColor: Color = Color(UIColor { traits in
        if traits.userInterfaceStyle == .light {
            return UIColor.ypLightGray
        } else {
            return UIColor.ypWhiteNight
        }
    })
}
