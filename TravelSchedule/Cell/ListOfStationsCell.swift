import SwiftUI

struct ListOfStationsCell: View {
    let company: SelectCompanyModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 8) {
                HStack(spacing: 8) {
                    if let logoURL = company.logoURL, !logoURL.isEmpty, let url = URL(string: logoURL) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.ypGrayUniversal)
                                    .frame(width: 38, height: 38)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 38, height: 38)
                                    .cornerRadius(12)
                            case .failure:
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.ypGrayUniversal)
                                    .frame(width: 38, height: 38)
                            @unknown default:
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.ypGrayUniversal)
                                    .frame(width: 38, height: 38)
                            }
                        }
                    } else {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.ypGrayUniversal)
                            .frame(width: 38, height: 38)
                    }
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
                .padding(.leading, 7)
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
}

#Preview {
    if let company = SelectCompanyModel.mockSelectCompany.first {
        ListOfStationsCell(company: company)
    }
}
