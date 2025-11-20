import OpenAPIRuntime
import OpenAPIURLSession

typealias RouteStations = Components.Schemas.ThreadStationsResponse

protocol RouteStationsServiceProtacol {
    func getRouteStations(uid: String)  async throws -> RouteStations
}

final class RouteStationsService: RouteStationsServiceProtacol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getRouteStations(uid: String) async throws -> RouteStations {
        let response = try await client.getRouteStations(query: .init(
            apikey: apiKey,
            uid: uid
        ))
        return try response.ok.body.json
    }
}
