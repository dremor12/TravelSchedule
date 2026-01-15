import SwiftUI

struct SettingsView: View {
    @Environment(ThemeManager.self) private var themeManager
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                settingsContent
                Spacer()
                footer
            }
            .background(Colors.viewBackgroundColor)
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $viewModel.showUserAgreement) {
                NavigationStack {
                    UserAgreementView()
                }
            }
        }
    }

    private var settingsContent: some View {
        VStack {
            darkThemeToggle
            userAgreementButton
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
    }
    
    private var darkThemeToggle: some View {
        HStack {
            Text("Темная тема")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(Colors.blackTopicColor)
            Spacer()
            Toggle("", isOn: Binding(
                get: { themeManager.isDarkMode },
                set: { newValue in
                    themeManager.currentTheme = newValue ? .dark : .light
                }
            ))
            .tint(.ypBlueUniversal)
        }
    }
    
    private var userAgreementButton: some View {
        Button(action: {
            viewModel.openUserAgreement()
        }) {
            HStack {
                Text("Пользовательское соглашение")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(Colors.blackTopicColor)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .frame(width: 24, height: 24)
                    .foregroundColor(Colors.blackTopicColor)
            }
        }
        .padding(.top, 16)
    }
    
    private var footer: some View {
        VStack(spacing: 16) {
            Text("Приложение использует API «Яндекс.Расписания»")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(Colors.blackTopicColor)
            
            Text("Версия 1.0 (beta)")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(Colors.blackTopicColor)
        }
        .padding(.top, 16)
        .padding(.bottom, 94)
    }
}

#Preview {
    SettingsView()
        .environment(ThemeManager())
}
