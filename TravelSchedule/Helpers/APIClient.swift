import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

struct APIConfig: Sendable {
    let apiKey: String
    let baseURL: URL
}

actor APIClient {
    private let client: Client
    private let apiKey: String
    
    init(config: APIConfig) {
        self.apiKey = config.apiKey
        let middlewares: [ClientMiddleware] = [
            AuthorizationMiddleware(apiKey: config.apiKey)
        ]
        self.client = Client(
            serverURL: config.baseURL,
            transport: URLSessionTransport(),
            middlewares: middlewares
        )
    }
    
    func getAllStations() async throws -> Components.Schemas.AllStationsResponse {
        do {
            let service = AllStationsService(client: client, apiKey: apiKey)
            let response = try await service.getAllStations()
            return response
        } catch {
            throw error
        }
    }
    
    func getScheduleBetweenStations(from: String, to: String) async throws -> Components.Schemas.Segments {
        do {
            let service = ScheduleBetweenStationsService(client: client, apiKey: apiKey)
            let response = try await service.getScheduleBetweenStations(from: from, to: to)
            return response
        } catch {
            throw error
        }
    }
    
    func getCarrierInfo(code: String) async throws -> Components.Schemas.CarrierResponse {
        do {
            let service = CarrierInfoService(client: client, apiKey: apiKey)
            let response = try await service.getCarrierInfo(code: code)
            return response
        } catch {
            throw error
        }
    }
}
