import SwiftUI
import Foundation

@MainActor
final class DirectionInputViewModel: ObservableObject {
    
    @Published var fromCity: String? = nil
    @Published var fromStation: String? = nil
    @Published var fromStationCode: String? = nil
    @Published var toCity: String? = nil
    @Published var toStation: String? = nil
    @Published var toStationCode: String? = nil
    
    @Published var showFromSelection = false
    @Published var showToSelection = false
    @Published var showListOfStations = false
    
    @Published var errorType: ErrorType? = nil

    
    var fromText: String {
        if let city = fromCity, let station = fromStation {
            return "\(city) (\(station))"
        }
        return "Откуда"
    }
    
    var toText: String {
        if let city = toCity, let station = toStation {
            return "\(city) (\(station))"
        }
        return "Куда"
    }
    
    var isRouteSelected: Bool {
        fromCity != nil && fromStation != nil && toCity != nil && toStation != nil
    }
    
    init() {
    }
    
    func swapDirections() {
        let tempCity = fromCity
        let tempStation = fromStation
        let tempStationCode = fromStationCode
        fromCity = toCity
        fromStation = toStation
        fromStationCode = toStationCode
        toCity = tempCity
        toStation = tempStation
        toStationCode = tempStationCode
    }
    
    func selectFromStation(city: String, station: String, stationCode: String?) {
        fromCity = city
        fromStation = station
        fromStationCode = stationCode
        showFromSelection = false
    }
    
    func selectToStation(city: String, station: String, stationCode: String?) {
        toCity = city
        toStation = station
        toStationCode = stationCode
        showToSelection = false
    }
    
    func showRouteList() {
        guard isRouteSelected else {
            return
        }
        showListOfStations = true
    }
    
}

