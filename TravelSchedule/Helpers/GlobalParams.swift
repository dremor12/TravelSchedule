import Foundation
import OpenAPIRuntime

enum GlobalParams {
    static let apiKey = "107a4958-7ac1-48c0-97ed-2cdf2cf02f7b"
    
    static func createAPIClient() -> APIClient {
        do {
            let baseURL = try Servers.Server1.url()
            let config = APIConfig(apiKey: apiKey, baseURL: baseURL)
            return APIClient(config: config)
        } catch {
            preconditionFailure("Failed to create API client: \(error)")
        }
    }
}
