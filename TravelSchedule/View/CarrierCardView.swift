import SwiftUI

struct CarrierCardView: View {
    let company: SelectCompanyModel
    @Environment(\.dismiss) var dismiss
    
    private var carrierCard: CarrierCardModel {
        CarrierCardModel.card
    }

    var body: some View {
        VStack(alignment: .leading) {
            Image(carrierCard.image)
                .resizable()
                .scaledToFit()
                .padding(.bottom, 16)
            
            Text(carrierCard.name)
                .font(.system(size: 24, weight: .bold))
                .padding(.bottom, 16)
            
            VStack(alignment: .leading) {
                Text("E-mail")
                    .font(.system(size: 17, weight: .regular))
                Text(carrierCard.email)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.ypBlueUniversal)
            }
            .padding(.top, 12)
            .padding(.bottom, 12)
            
            VStack(alignment: .leading) {
                Text("Телефон")
                    .font(.system(size: 17, weight: .regular))
                Text(carrierCard.phone)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.ypBlueUniversal)
            }
            
            Spacer()
                .padding(.top, 12)
                .padding(.bottom, 12)
        }
        .padding()
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
    }
}

#Preview {
    if let company = SelectCompanyModel.mockSelectCompany.first {
        CarrierCardView(company: company)
    }
}
