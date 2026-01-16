import Foundation

struct SelectPlaceModel: Hashable, Identifiable {
    var id = UUID()
    var city: String
    var cityCode: String?
    var trainStations: [String]
    var stationCodes: [String: String]
}

extension SelectPlaceModel {
    static let mockCities: [SelectPlaceModel] = [

        SelectPlaceModel(
            city: "Москва",
            trainStations: [
                "Киевский вокзал",
                "Курский вокзал",
                "Ярославский вокзал",
                "Белорусский вокзал",
                "Савеловский вокзал",
                "Ленинградский вокзал",
            ],
            stationCodes: [:]
        ),
    
        SelectPlaceModel(
            city: "Санкт Петербург",
            trainStations: [
                "Московский вокзал",
                "Ладожский вокзал",
                "Витебский вокзал",
                "Финляндский вокзал"
            ],
            stationCodes: [:]
        ),

        SelectPlaceModel(
            city: "Сочи",
            trainStations: [
                "Сочи",
                "Адлер",
                "Хоста",
                "Лазаревская"
            ],
            stationCodes: [:]
        ),

        SelectPlaceModel(
            city: "Горный воздух",
            trainStations: [
                "Южно-Сахалинск",
                "Холмск",
                "Томари"
            ],
            stationCodes: [:]
        ),

        SelectPlaceModel(
            city: "Краснодар",
            trainStations: [
                "Краснодар-1",
                "Краснодар-2",
                "Краснодар-Сортировочный"
            ],
            stationCodes: [:]
        ),

        SelectPlaceModel(
            city: "Казань",
            trainStations: [
                "Казань-Пассажирская",
                "Восстание-Пассажирская",
                "Казань-2"
            ],
            stationCodes: [:]
        ),

        SelectPlaceModel(
            city: "Омск",
            trainStations: [
                "Омск-Пассажирский",
                "Омск-Северный",
                "Омск-Восточный"
            ],
            stationCodes: [:]
        )
    ]
}
