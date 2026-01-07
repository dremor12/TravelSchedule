import SwiftUI

struct StoryView: View {
    var story: StoryModel
    var imageIndex: Int
    
    var body: some View {
        Image(story.backgroundImage[imageIndex])
            .resizable()
            .cornerRadius(40)
            .overlay(
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 10) {
                        Text(story.title)
                            .font(.bold34)
                            .foregroundColor(.white)
                        Text(story.description)
                            .font(.regular20)
                            .lineLimit(3)
                            .foregroundColor(.white)
                    }
                    .padding(.init(top: 0, leading: 16, bottom: 40, trailing: 16))
                }
            )
    }
}

#Preview {
    StoryView(story: .story1, imageIndex: 0)
}
