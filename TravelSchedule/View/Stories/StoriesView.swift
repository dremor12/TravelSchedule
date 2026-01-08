import SwiftUI

struct StoriesView: View {
    @Bindable  var model: StoryViewModel
    var initialStory: StoryModel
    
    init(model: StoryViewModel, initialStory: StoryModel) {
        self.model = model
        self.initialStory = initialStory
        
        if let index = model.stories.firstIndex(where: { $0.id == initialStory.id }) {
            model.currentStoryIndex = index
            model.currentImageIndex = 0
            model.progress = 0
        }
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            StoryView(story: model.currentStory,
                      imageIndex: model.currentImageIndex)
            .animation(.linear(duration: 0.2), value: model.currentImageIndex)
            
            ProgressBar(
                numberOfSections: model.currentStory.backgroundImage.count,
                currentImage: model.currentImageIndex,
                progress: model.progress
            )
            .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            
            CloseButton {
                model.isPresentStory = false}
            .padding(.top, 57)
            .padding(.trailing, 12)
        }
        .contentShape(Rectangle())
        .onAppear {
            model.markCurrentStoryAsViewed()
            model.startTimer()
        }
        .onDisappear { model.stopTimer() }
        .onTapGesture { location in
            let width = UIScreen.main.bounds.width
            if location.x < width / 2 {
                model.previousImage()
            } else {
                model.nextImage()
            }
        }
        .gesture(
            DragGesture(minimumDistance: 50)
                .onEnded { value in
                    if value.translation.width < 0 {
                        model.nextStory()
                    } else if value.translation.width > 0 {
                        model.previousStory()
                    }
                }
        )
        .background(.ypBlackUniversal)
    }
    
}

#Preview {
    StoriesView(
        model: StoryViewModel(stories: [.story1, .story2, .story3, .story4]),
        initialStory: .story1
    )
}
