import Foundation
import SwiftUI

@Observable
final class StoryViewModel {

    var stories: [StoryModel] = []
    var viewedStories: Set<UUID> = []
    var isPresentStory: Bool = false

    var currentStoryIndex: Int = 0
    var currentImageIndex: Int = 0
    var progress: CGFloat = 0

    var currentStory: StoryModel {
        return stories[currentStoryIndex]
    }

    private var timer: Timer?
    
    init(stories: [StoryModel]) {
        self.stories = stories
        startTimer()
    }

    func startTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            self?.onTick()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }

    private func onTick() {
        let secondsPerImage: CGFloat = 5
        let step = 0.05 / secondsPerImage
        
        progress += step
        
        if progress >= 1 {
            progress = 0
            nextImage()
        }
    }
    
    func nextImage() {
        if currentImageIndex + 1 < currentStory.backgroundImage.count {
            currentImageIndex += 1
        } else {
            nextStory()
        }
        progress = 0
    }
    
    func previousImage() {
        if currentImageIndex > 0 {
            currentImageIndex -= 1
        } else {
            previousStory()
        }
        progress = 0
    }
    func markCurrentStoryAsViewed() {
        let story = stories[currentStoryIndex]
        viewedStories.insert(story.id)
    }

    func nextStory() {
        currentStoryIndex = (currentStoryIndex + 1) % stories.count
        currentImageIndex = 0
        progress = 0
    }
    
    func previousStory() {
        
        currentStoryIndex = (currentStoryIndex - 1 + stories.count) % stories.count
        currentImageIndex = 0
        progress = 0
    }
    
}
