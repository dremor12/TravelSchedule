import SwiftUI

enum ErrorType {
    case noInternet
    case serverError
}

struct ErrorViewModifier: ViewModifier {
    @Binding var errorType: ErrorType?
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if let errorType = errorType {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        self.errorType = nil
                    }
                
                VStack(spacing: 16) {
                    switch errorType {
                    case .noInternet:
                        NoInternetView()
                    case .serverError:
                        ServerErrorView()
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .padding()
            }
        }
    }
}

extension View {
    func errorOverlay(errorType: Binding<ErrorType?>) -> some View {
        modifier(ErrorViewModifier(errorType: errorType))
    }
}

