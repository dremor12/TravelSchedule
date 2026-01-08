import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

struct ContentView: View {
    @State var storyViewModel = StoryViewModel( stories: [.story1, .story2, .story3, .story4])
    @State private var selectedStory: StoryModel = StoryModel.story1
    
    var body: some View {
        TabView {
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
            .tabItem {
                Image(systemName: "arrow.up.message.fill")
            }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
            
        }
        .tint(Colors.blackTopicColor)
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
        .environmentObject(ThemeManager())
}
