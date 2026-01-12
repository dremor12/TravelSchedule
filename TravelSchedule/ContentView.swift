import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct ContentView: View {
    @State var storyViewModel = StoryViewModel( stories: [.story1, .story2, .story3, .story4])
    @State private var selectedStory: StoryModel = StoryModel.story1
    @State private var selectedTab: TabItem = .main
    
    var body: some View {
        Group {
            switch selectedTab {
            case .main:
                VStack {
                    Spacer()
                        .frame(height: 24)
                    StoryTable(
                        stories: storyViewModel.stories,
                        viewedStories: storyViewModel.viewedStories,
                        openStory: { story in
                            selectedStory = story
                            storyViewModel.isPresentStory = true
                        }
                    )
                    Spacer()
                        .frame(height: 44)
                    DirectionInputView()
                    Spacer()
                }
            case .settings:
                SettingsView()
            }
        }
        .tint(Colors.blackTopicColor)
        .safeAreaInset(edge: .bottom) {
            TabBarView(selectedTab: $selectedTab)
        }
        .fullScreenCover(isPresented: $storyViewModel.isPresentStory) {
            StoriesView(
                model: storyViewModel,
                initialStory: selectedStory
            )
        }
    }
}


#Preview {
    ContentView()
        .environment(ThemeManager())
}
