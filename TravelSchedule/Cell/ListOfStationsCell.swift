import SwiftUI

struct ListOfStationsCell: View {
    let company: SelectCompanyModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 8) {
                HStack(spacing: 8) {
                    logoView
                    companyInfoView
                }
                .padding(.leading, 7)
                timeInfoView
            }
            .frame(width: 343, height: 104)
            .padding(.horizontal, 16)
            .background(.ypLightGray)
            .cornerRadius(24)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(.ypWhiteUniversal, lineWidth: 1)
            )
        }
    }
    
    // MARK: - Private Views
    
    private var logoView: some View {
        Group {
            if let logoURL = company.logoURL, !logoURL.isEmpty, let url = URL(string: logoURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        placeholderLogo
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 38, height: 38)
                            .cornerRadius(12)
                    case .failure:
                        placeholderLogo
                    @unknown default:
                        placeholderLogo
                    }
                }
            } else {
                placeholderLogo
            }
        }
    }
    
    private var placeholderLogo: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.ypGrayUniversal)
            .frame(width: 38, height: 38)
    }
    
    private var companyInfoView: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 2) {
                Text(company.companyName)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.ypBlackUniversal)
                if company.needSwapStation, let swapStation = company.swapStation {
                    Text(swapStation)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.ypRedUniversal)
                }
            }
            Spacer()
            Text(company.date)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.ypBlackUniversal)
                .padding(.leading, 7)
        }
    }
    
    private var timeInfoView: some View {
        HStack {
            HStack {
                Text(company.timeToStart)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.ypBlackUniversal)
                VStack {
                    Divider()
                }
                Text(company.allTimePath)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.ypBlackUniversal)
                VStack {
                    Divider()
                }
                Text(company.timeToOver)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.ypBlackUniversal)
            }
            .padding(.horizontal, 7)
            .padding(.top, 6)
        }
    }
}

#Preview {
    if let company = SelectCompanyModel.mockSelectCompany.first {
        ListOfStationsCell(company: company)
    }
}
