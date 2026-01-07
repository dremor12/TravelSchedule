import SwiftUI

struct StoryModel: Identifiable, Hashable {
    let id = UUID()
    let previewImage: ImageResource
    let backgroundImage: [ImageResource]
    let title: String
    let description: String

    static let story1 = StoryModel(
        previewImage: .stories1,
        backgroundImage: [.stories11, .stories12],
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    )
 
    static let story2 = StoryModel(
        previewImage: .stories2,
        backgroundImage: [.stories21, .stories22],
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    )
    
    static let story3 = StoryModel(
        previewImage: .stories3,
        backgroundImage: [.stories31, .stories32],
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    )
    static let story4 = StoryModel(
        previewImage: .stories4,
        backgroundImage: [.stories41, .stories42],
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    )
}
