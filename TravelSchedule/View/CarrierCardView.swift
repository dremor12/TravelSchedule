import SwiftUI

struct CarrierCardView: View {
    let company: SelectCompanyModel
    @StateObject private var viewModel: CarrierCardViewModel
    @State private var isImageLoaded: Bool = false
    @Environment(\.dismiss) var dismiss
    
    init(company: SelectCompanyModel) {
        self.company = company
        _viewModel = StateObject(wrappedValue: CarrierCardViewModel(
            company: company,
            apiClient: GlobalParams.createAPIClient()
        ))
    }

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                if let logoURL = viewModel.logoURL, !logoURL.isEmpty, let url = URL(string: logoURL) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            EmptyView()
                                .onAppear {
                                    isImageLoaded = false
                                }
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 104)
                                .cornerRadius(24)
                                .onAppear {
                                    isImageLoaded = true
                                }
                        case .failure:
                            EmptyView()
                                .onAppear {
                                    isImageLoaded = false
                                }
                        @unknown default:
                            EmptyView()
                                .onAppear {
                                    isImageLoaded = false
                                }
                        }
                    }
                } else {
                    EmptyView()
                        .onAppear {
                            isImageLoaded = false
                        }
                }
            }

            if !isImageLoaded {
                Spacer(minLength: 136)
            }
            
            Text(viewModel.name)
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 16)
            
            VStack(alignment: .leading) {
                Text("E-mail")
                    .font(.system(size: 17, weight: .regular))
                Text(viewModel.email)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.ypBlueUniversal)
            }
            .padding(.top, 12)
            .padding(.bottom, 12)
            
            VStack(alignment: .leading) {
                Text("Телефон")
                    .font(.system(size: 17, weight: .regular))
                Text(viewModel.phone)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.ypBlueUniversal)
            }
            
            Spacer()
                .padding(.top, 12)
                .padding(.bottom, 12)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Colors.viewBackgroundColor)
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17))
                        .foregroundColor(Colors.blackTopicColor)
                }
            }
        }
        .task {
            await viewModel.loadCarrierInfo()
        }
        .errorOverlay(errorType: $viewModel.errorType)
    }
}

#Preview {
    if let company = SelectCompanyModel.mockSelectCompany.first {
        CarrierCardView(company: company)
    }
}
