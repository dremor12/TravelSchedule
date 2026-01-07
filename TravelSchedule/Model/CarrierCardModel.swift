import SwiftUI

struct CarrierCardModel: Identifiable {
    let id = UUID()
    let name: String
    let image: ImageResource
    let email: String
    let phone: String
}

extension CarrierCardModel {
    static let card = CarrierCardModel(
        name: "ОАО «РЖД»",
        image: .rgdLogo,
        email: "i.lozgkina@yandex.ru",
        phone: "+7 (904) 329-27-71"
    )
}

