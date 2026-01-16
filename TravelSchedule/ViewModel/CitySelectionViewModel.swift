import Foundation
import SwiftUI
import OpenAPIRuntime

@MainActor
final class CitySelectionViewModel: ObservableObject {
    @Published var cities: [SelectPlaceModel] = []
    @Published var isLoading: Bool = false
    @Published var errorType: ErrorType? = nil
    @Published var searchText: String = ""
    
    private let apiClient: APIClient
    
    var filteredCities: [SelectPlaceModel] {
        if searchText.isEmpty {
            return cities
        } else {
            return cities.filter {
                $0.city.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func loadCities() async {
        isLoading = true
        errorType = nil
        
        do {
            let response = try await apiClient.getAllStations()
            cities = convertToSelectPlaceModels(from: response)
            isLoading = false
        } catch {
            isLoading = false
            errorType = .serverError
        }
    }
    
    private func convertToSelectPlaceModels(from response: Components.Schemas.AllStationsResponse) -> [SelectPlaceModel] {
        var citiesMap: [String: (code: String?, stations: [(name: String, code: String?)])] = [:]
        
        guard let countries = response.countries else {
            return []
        }
        
        for country in countries {
            guard let regions = country.regions else { continue }
            
            for region in regions {
                guard let settlements = region.settlements else { continue }
                
                for settlement in settlements {
                    guard let title = settlement.title,
                          let stations = settlement.stations else { continue }
                    
                    let cityCode = settlement.codes?.yandex_code

                    var stationData: [(name: String, code: String?)] = []
                    for station in stations {
                        if let stationTitle = station.title {
                            let stationCode = station.codes?.yandex_code
                            stationData.append((name: stationTitle, code: stationCode))
                        }
                    }
                    
                    if !stationData.isEmpty {
                        if citiesMap[title] == nil {
                            citiesMap[title] = (code: cityCode, stations: [])
                        }
                        citiesMap[title]?.stations.append(contentsOf: stationData)
                    }
                }
            }
        }
        
        let result = citiesMap.map { city, data in
            var seenNames = Set<String>()
            var uniqueStations: [(name: String, code: String?)] = []
            var stationCodes: [String: String] = [:]
            
            for station in data.stations {
                if !seenNames.contains(station.name) {
                    seenNames.insert(station.name)
                    uniqueStations.append(station)
                    if let code = station.code {
                        stationCodes[station.name] = code
                    }
                }
            }
            
            let sortedStations = uniqueStations.sorted { $0.name < $1.name }

            return SelectPlaceModel(
                city: city,
                cityCode: data.code,
                trainStations: sortedStations.map { $0.name },
                stationCodes: stationCodes
            )
        }.sorted { $0.city < $1.city }
        return result
    }
}
