import SwiftUI
import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var showUserAgreement = false
    
    
    func openUserAgreement() {
        showUserAgreement = true
    }
    
    func closeUserAgreement() {
        showUserAgreement = false
    }
}

