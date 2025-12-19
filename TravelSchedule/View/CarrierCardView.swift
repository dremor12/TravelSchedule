import SwiftUI

struct CarrierCardView: View {
    let company: SelectCompanyModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            // TODO
        }
        .background(Color.white)
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
                        .foregroundColor(.black)
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
