import Foundation

struct RouteModel {
    let fromCity: String
    let fromStation: String
    let fromStationCode: String?
    let toCity: String
    let toStation: String
    let toStationCode: String?
    
    var routeTitle: String {
        "\(fromCity) (\(fromStation)) → \(toCity) (\(toStation))"
    }
}
