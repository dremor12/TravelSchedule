import Foundation
import SwiftUI

@MainActor
final class StationSelectionViewModel: ObservableObject {
    @Published var stations: [String] = []
    @Published var searchText: String = ""
    
    let selectedCity: SelectPlaceModel
    
    var filteredStations: [String] {
        if searchText.isEmpty {
            return stations
        } else {
            return stations.filter { station in
                station.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    init(selectedCity: SelectPlaceModel) {
        self.selectedCity = selectedCity
        self.stations = selectedCity.trainStations
    }
}
