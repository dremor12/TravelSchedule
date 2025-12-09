import Foundation

struct SelectPlaceModel: Hashable, Identifiable {
    var id = UUID()
    var city: String
    var trainStations: [String]
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
            ]
        ),
    
        SelectPlaceModel(
            city: "Санкт Петербург",
            trainStations: [
                "Московский вокзал",
                "Ладожский вокзал",
                "Витебский вокзал",
                "Финляндский вокзал"
            ]
        ),

        SelectPlaceModel(
            city: "Сочи",
            trainStations: [
                "Сочи",
                "Адлер",
                "Хоста",
                "Лазаревская"
            ]
        ),

        SelectPlaceModel(
            city: "Горный воздух",
            trainStations: [
                "Южно-Сахалинск",
                "Холмск",
                "Томари"
            ]
        ),

        SelectPlaceModel(
            city: "Краснодар",
            trainStations: [
                "Краснодар-1",
                "Краснодар-2",
                "Краснодар-Сортировочный"
            ]
        ),

        SelectPlaceModel(
            city: "Казань",
            trainStations: [
                "Казань-Пассажирская",
                "Восстание-Пассажирская",
                "Казань-2"
            ]
        ),

        SelectPlaceModel(
            city: "Омск",
            trainStations: [
                "Омск-Пассажирский",
                "Омск-Северный",
                "Омск-Восточный"
            ]
        )
    ]
}
