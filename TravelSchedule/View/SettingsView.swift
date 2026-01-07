import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @State private var showUserAgreement = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    Section {
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
                        .listRowBackground(Colors.viewBackgroundColor)
                        
                        Button(action: {
                            showUserAgreement = true
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
                        .listRowBackground(Colors.viewBackgroundColor)
                        .padding(.top, 16)
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)

                
                VStack(spacing: 8) {
                    Text("Приложение использует API «Яндекс.Расписания»")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Colors.blackTopicColor)
                    
                    Text("Версия 1.0 (beta)")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Colors.blackTopicColor)
                }
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
            .background(Colors.viewBackgroundColor)
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showUserAgreement) {
                NavigationStack {
                    UserAgreementView()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(ThemeManager())
}
