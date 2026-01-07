import SwiftUI

struct NoInternetView: View {
    var body: some View {
        VStack {
            Image(.noInternet)
                .resizable()
                .cornerRadius(70)
                .frame(width: 223, height: 223)
            Text("Нет интернета")
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 16)
        }
        .padding()
    }
}

#Preview {
    NoInternetView()
}
