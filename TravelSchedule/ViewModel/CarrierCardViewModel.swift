import Foundation
import SwiftUI
import OpenAPIRuntime

@MainActor
final class CarrierCardViewModel: ObservableObject {
    @Published var logoURL: String? = nil
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var isLoading: Bool = false
    @Published var errorType: ErrorType? = nil
    @Published var isImageLoaded: Bool = false
    
    private let apiClient: APIClient
    private let company: SelectCompanyModel
    
    init(company: SelectCompanyModel, apiClient: APIClient) {
        self.company = company
        self.apiClient = apiClient
        self.logoURL = company.logoURL
    }
    
    func loadCarrierInfo() async {
        isLoading = true
        errorType = nil

        guard let carrierCodeInt = company.carrierCode else {
            isLoading = false
            errorType = .serverError
            return
        }

        let carrierCode = String(carrierCodeInt)
        
        do {
            let response = try await apiClient.getCarrierInfo(code: carrierCode)
            
            if let carrier = response.carrier {
                name = carrier.title ?? company.companyName
                email = carrier.email ?? ""
                phone = carrier.phone ?? ""
                logoURL = carrier.logo ?? company.logoURL
            } else {
                logoURL = company.logoURL
            }
            isImageLoaded = false
            isLoading = false
        } catch {
            isLoading = false
            errorType = .serverError
        }
    }
}
