import Foundation
import SwiftUI
import OpenAPIRuntime

@MainActor
final class ListOfStationsViewModel: ObservableObject {
    @Published var companies: [SelectCompanyModel] = []
    @Published var isLoading: Bool = false
    @Published var errorType: ErrorType? = nil
    @Published var selectedTimePeriods: Set<TimePeriod> = []
    @Published var selectedTransferOption: TransferOption? = nil
    
    let fromCity: String
    let fromStation: String
    let fromStationCode: String?
    let toCity: String
    let toStation: String
    let toStationCode: String?
    
    private let apiClient: APIClient
    
    var routeTitle: String {
        return "\(fromCity) (\(fromStation)) → \(toCity) (\(toStation))"
    }
    
    var hasActiveFilters: Bool {
        !selectedTimePeriods.isEmpty || selectedTransferOption != nil
    }
    
    var filteredCompany: [SelectCompanyModel] {
        var filtered = companies
        if !selectedTimePeriods.isEmpty {
            filtered = filtered.filter { company in
                guard let period = TimePeriod.period(for: company.timeToStart) else { return false }
                return selectedTimePeriods.contains(period)
            }
        }

        if let transferOption = selectedTransferOption {
            switch transferOption {
            case .yes:
                filtered = filtered.filter { $0.needSwapStation }
            case .no:
                filtered = filtered.filter { !$0.needSwapStation }
            }
        }
        return filtered
    }
    
    init(
        fromCity: String,
        fromStation: String,
        fromStationCode: String?,
        toCity: String,
        toStation: String,
        toStationCode: String?,
        apiClient: APIClient
    ) {
        self.fromCity = fromCity
        self.fromStation = fromStation
        self.fromStationCode = fromStationCode
        self.toCity = toCity
        self.toStation = toStation
        self.toStationCode = toStationCode
        self.apiClient = apiClient
    }
    
    func loadSchedule() async {
        isLoading = true
        errorType = nil
        
        do {
            let fromCode: String
            let toCode: String
            
            if let fromStationCode = fromStationCode, !fromStationCode.isEmpty {
                fromCode = fromStationCode.hasPrefix("s") ? fromStationCode : "s\(fromStationCode)"
            } else {
                isLoading = false
                errorType = .serverError
                return
            }
            
            if let toStationCode = toStationCode, !toStationCode.isEmpty {
                toCode = toStationCode.hasPrefix("s") ? toStationCode : "s\(toStationCode)"
            } else {
                isLoading = false
                errorType = .serverError
                return
            }

            let response = try await apiClient.getScheduleBetweenStations(from: fromCode, to: toCode)
            
            if let segments = response.segments {
                companies = convertToSelectCompanyModels(from: segments)
            } else {
                companies = []
            }
            
            isLoading = false
        } catch {
            isLoading = false
            let errorString = String(describing: error)
            if errorString.contains("statusCode: 404") || errorString.contains("404") {
                companies = []
                errorType = nil
            } else {
                errorType = .serverError
            }
        }
    }
    
    func applyFilters(timePeriods: Set<TimePeriod>, transferOption: TransferOption?) {
        selectedTimePeriods = timePeriods
        selectedTransferOption = transferOption
    }
    
    private func convertToSelectCompanyModels(from segments: [Components.Schemas.Segment]) -> [SelectCompanyModel] {
        return segments.map { segment in
            let carrierName = segment.thread?.carrier?.title ?? "Неизвестный перевозчик"
            let carrierLogo = segment.thread?.carrier?.logo
            let carrierCode = segment.thread?.carrier?.code
            let departureTime = formatTime(from: segment.departure)
            let arrivalTime = formatTime(from: segment.arrival)
            let duration = segment.duration ?? 0
            let date = formatDate(from: segment.departure)

            let needSwapStation = false
            let swapStation: String? = nil
            
            return SelectCompanyModel(
                companyName: carrierName,
                image: "",
                logoURL: carrierLogo,
                carrierCode: carrierCode,
                timeToStart: departureTime,
                timeToOver: arrivalTime,
                allTimePath: formatDuration(duration),
                date: date,
                needSwapStation: needSwapStation,
                swapStation: swapStation
            )
        }
    }
    
    private func formatTime(from timeString: String?) -> String {
        guard let timeString = timeString, !timeString.isEmpty else {
            return "--:--"
        }

        if timeString.contains(":") && !timeString.contains("T") && !timeString.contains("-") {
            let components = timeString.components(separatedBy: ":")
            if components.count >= 2 {
                let hours = components[0]
                let minutes = components[1]
                let result = "\(hours):\(minutes)"
                return result
            }
        }

        let formatter1 = ISO8601DateFormatter()
        formatter1.formatOptions = [.withInternetDateTime, .withFractionalSeconds, .withTimeZone]
        
        if let date = formatter1.date(from: timeString) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            let result = timeFormatter.string(from: date)
            return result
        }

        let formatter2 = ISO8601DateFormatter()
        formatter2.formatOptions = [.withInternetDateTime, .withTimeZone]
        if let date = formatter2.date(from: timeString) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            let result = timeFormatter.string(from: date)
            return result
        }

        let formatter3 = ISO8601DateFormatter()
        formatter3.formatOptions = [.withInternetDateTime]
        if let date = formatter3.date(from: timeString) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            let result = timeFormatter.string(from: date)
            return result
        }

        let customFormats = [
            "yyyy-MM-dd'T'HH:mm:ss",
            "yyyy-MM-dd'T'HH:mm:ssZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSS",
            "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
            "yyyy-MM-dd HH:mm:ss",
            "HH:mm:ss",
            "HH:mm"
        ]
        
        for format in customFormats {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            if let date = dateFormatter.date(from: timeString) {
                let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "HH:mm"
                let result = timeFormatter.string(from: date)
                return result
            }
        }
        return "--:--"
    }
    
    private func formatDate(from timeString: String?) -> String {
        guard let timeString = timeString, !timeString.isEmpty else {
            return ""
        }

        let formatter1 = ISO8601DateFormatter()
        formatter1.formatOptions = [.withInternetDateTime, .withFractionalSeconds, .withTimeZone]
        
        var date: Date?
        if let parsedDate = formatter1.date(from: timeString) {
            date = parsedDate
        } else {
            let formatter2 = ISO8601DateFormatter()
            formatter2.formatOptions = [.withInternetDateTime, .withTimeZone]
            if let parsedDate = formatter2.date(from: timeString) {
                date = parsedDate
            } else {
                let formatter3 = ISO8601DateFormatter()
                formatter3.formatOptions = [.withInternetDateTime]
                date = formatter3.date(from: timeString)
            }
        }
        
        guard let date = date else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date)
    }
    
    private func formatDuration(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        if hours > 0 {
            return "\(hours) ч \(minutes) мин"
        } else {
            return "\(minutes) мин"
        }
    }
}
