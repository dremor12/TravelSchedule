import SwiftUI

extension CGFloat {
    static let progressBarCornerRadius: CGFloat = 6
    static let progressBarHeight: CGFloat = 6
}

struct ProgressBarView: View {
    let numberOfSections: Int
    var currentImage: Int
    let progress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {

                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(width: geometry.size.width, height: .progressBarHeight)
                    .foregroundColor(.ypWhiteUniversal)

                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(
                        width: geometry.size.width * filledProgress(),
                        height: .progressBarHeight
                    )
                    .foregroundColor(.ypBlueUniversal)
            }
            .mask {
                MaskView(numberOfSections: numberOfSections)
            }
        }
    }
    
    private func filledProgress() -> CGFloat {
        guard numberOfSections > 0 else { return 0 }
        let completedSections = CGFloat(currentImage)
        let totalSections = CGFloat(numberOfSections)
        return min((completedSections + progress) / totalSections, 1)
    }
}

private struct MaskView: View {
    let numberOfSections: Int
    var body: some View {
        HStack {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                MaskFragmentView()
            }
        }
    }
}

private struct MaskFragmentView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: .progressBarCornerRadius)
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: .progressBarHeight)
            .foregroundStyle(.ypWhiteUniversal)
    }
}

#Preview {
    Color.orange
        .ignoresSafeArea()
        .overlay(
            ProgressBarView(numberOfSections: 2, currentImage: 1, progress: 0.5)
                .padding()
        )
}
