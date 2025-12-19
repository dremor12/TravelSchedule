import SwiftUI

struct ListOfStationsCell: View {
    let company: SelectCompanyModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 8) {
                HStack(spacing: 8) {
                    Image(company.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 38, height: 38)
                        .cornerRadius(12)
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(company.companyName)
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.black)
                            if company.needSwapStation, let swapStation = company.swapStation {
                                Text(swapStation)
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(.red)
                            }
                        }
                        Spacer()
                        Text(company.date)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.black)
                            .padding(.leading, 7)
                    }
                }
                .padding(.leading, 7)
                HStack {
                    HStack {
                        Text(company.timeToStart)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.black)
                        VStack {
                            Divider()
                        }
                        Text(company.allTimePath)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.black)
                        VStack {
                            Divider()
                        }
                        Text(company.timeToOver)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 7)
                    .padding(.top, 6)
                }
            }
            .frame(width: 343, height: 104)
            .padding(.horizontal, 8)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(24)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.white, lineWidth: 1)
            )
        }
    }
}

#Preview {
    if let company = SelectCompanyModel.mockSelectCompany.first {
        ListOfStationsCell(company: company)
    }
}
