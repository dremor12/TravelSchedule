import Foundation

struct SelectCompanyModel: Identifiable, Hashable {
    var id = UUID()
    var companyName: String
    var image: String
    var logoURL: String?
    var carrierCode: Int?
    var timeToStart: String
    var timeToOver: String
    var allTimePath: String
    var date: String
    var needSwapStation: Bool
    var swapStation: String?
}

extension SelectCompanyModel {
    static let mockSelectCompany: [SelectCompanyModel] = [
        SelectCompanyModel(
            companyName: "РЖД",
            image: "rgd",
            logoURL: nil,
            carrierCode: 680,
            timeToStart: "22:30",
            timeToOver: "08:15",
            allTimePath: "20 часов",
            date: "14 января",
            needSwapStation: true,
            swapStation: "С пересадкой в Костроме"
        ),
        SelectCompanyModel(
            companyName: "ФГК",
            image: "fgk",
            logoURL: nil,
            carrierCode: nil,
            timeToStart: "01:15",
            timeToOver: "09:00",
            allTimePath: "9 часов",
            date: "15 января",
            needSwapStation: false,
            swapStation: nil
        ),
        SelectCompanyModel(
            companyName: "Урал логистика",
            image: "urallog",
            logoURL: nil,
            carrierCode: nil,
            timeToStart: "12:30",
            timeToOver: "21:00",
            allTimePath: "9 часов",
            date: "16 января",
            needSwapStation: false,
            swapStation: nil
        ),
        SelectCompanyModel(
            companyName: "РЖД",
            image: "rgd",
            logoURL: nil,
            carrierCode: 680,
            timeToStart: "22:30",
            timeToOver: "08:15",
            allTimePath: "20 часов",
            date: "17 января",
            needSwapStation: true,
            swapStation: "С пересадкой в Костроме"
        ),
        SelectCompanyModel(
            companyName: "РЖД",
            image: "rgd",
            logoURL: nil,
            carrierCode: 680,
            timeToStart: "22:30",
            timeToOver: "08:15",
            allTimePath: "20 часов",
            date: "17 января",
            needSwapStation: true,
            swapStation: "С пересадкой в Костроме"
        ),
    ]
}
