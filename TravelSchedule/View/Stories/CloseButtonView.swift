import SwiftUI

struct CloseButtonView: View {
    let action: () -> Void

    var body: some View {
        Button("", image: .close) {
            action()
        }
    }
}


#Preview {
    CloseButtonView(action: { print("Close Story") })
}
