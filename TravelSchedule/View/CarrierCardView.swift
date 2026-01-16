import SwiftUI

struct CarrierCardView: View {
    let company: SelectCompanyModel
    @StateObject private var viewModel: CarrierCardViewModel
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
            logoView
            
            if !viewModel.isImageLoaded {
                Spacer(minLength: 136)
            }
            
            nameView
            emailSection
            phoneSection
            
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
                backButton
            }
        }
        .task {
            await viewModel.loadCarrierInfo()
        }
        .errorOverlay(errorType: $viewModel.errorType)
    }
    
    // MARK: - Private Views
    
    private var logoView: some View {
        Group {
            if let logoURL = viewModel.logoURL, !logoURL.isEmpty, let url = URL(string: logoURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        EmptyView()
                            .onAppear {
                                viewModel.isImageLoaded = false
                            }
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 104)
                            .cornerRadius(24)
                            .onAppear {
                                viewModel.isImageLoaded = true
                            }
                    case .failure:
                        EmptyView()
                            .onAppear {
                                viewModel.isImageLoaded = false
                            }
                    @unknown default:
                        EmptyView()
                            .onAppear {
                                viewModel.isImageLoaded = false
                            }
                    }
                }
            } else {
                EmptyView()
                    .onAppear {
                        viewModel.isImageLoaded = false
                    }
            }
        }
    }
    
    private var nameView: some View {
        Text(viewModel.name)
            .font(.system(size: 24, weight: .bold))
            .padding(.top, 16)
    }
    
    private var emailSection: some View {
        VStack(alignment: .leading) {
            Text("E-mail")
                .font(.system(size: 17, weight: .regular))
            Text(viewModel.email)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.ypBlueUniversal)
        }
        .padding(.top, 12)
        .padding(.bottom, 12)
    }
    
    private var phoneSection: some View {
        VStack(alignment: .leading) {
            Text("Телефон")
                .font(.system(size: 17, weight: .regular))
            Text(viewModel.phone)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.ypBlueUniversal)
        }
    }
    
    private var backButton: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "chevron.left")
                .font(.system(size: 17))
                .foregroundColor(Colors.blackTopicColor)
        }
    }
}

#Preview {
    if let company = SelectCompanyModel.mockSelectCompany.first {
        CarrierCardView(company: company)
    }
}
