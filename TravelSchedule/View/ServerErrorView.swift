import SwiftUI

struct ServerErrorView: View {
    var body: some View {
        VStack {
            Image(.serverError)
                .resizable()
                .cornerRadius(70)
                .frame(width: 223, height: 223)
            Text("Ошибка сервера")
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 16)
        }
        .padding()
    }
}

#Preview {
    ServerErrorView()
}
