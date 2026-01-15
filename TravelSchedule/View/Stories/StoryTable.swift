import SwiftUI

struct StoryTable: View {
    let stories: [StoryModel]
    let viewedStories: Set<UUID>
    let openStory: (StoryModel) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(stories, id: \.id) { story in

                    Button(action: {
                        openStory(story)
                    }) {
                        ZStack(alignment: .bottom) {
                            Image(story.previewImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 92, height: 140)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                                        .stroke(viewedStories.contains(story.id) ? .clear : Color.ypBlueUniversal, lineWidth: 4)
                                        .padding(2)
                                )
                                .opacity(viewedStories.contains(story.id) ? 0.5 : 1)

                            Text(story.title)
                                .padding(8)
                                .lineLimit(3)
                                .frame(width: 92)
                                .font(.system(size: 12))
                                .foregroundColor(.ypWhiteUniversal)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.leading, 16)
        }
    }
}


#Preview {
    StoryTable(
        stories: [.story1, .story2, .story3, .story4],
        viewedStories: Set<UUID>(),
        openStory: { _ in }
    )
}

