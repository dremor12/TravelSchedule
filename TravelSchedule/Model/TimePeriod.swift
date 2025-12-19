import Foundation

enum TimePeriod: String, CaseIterable, Hashable {
    case morning = "Утро"
    case day = "День"
    case evening = "Вечер"
    case night = "Ночь"
    
    var timeRange: String {
        switch self {
        case .morning: return "06:00 - 12:00"
        case .day: return "12:00 - 18:00"
        case .evening: return "18:00 - 00:00"
        case .night: return "00:00 - 06:00"
        }
    }
    
    /// Определяет, попадает ли время в этот период
    static func period(for timeString: String) -> TimePeriod? {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        guard let time = formatter.date(from: timeString) else { return nil }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: time)
        guard let hour = components.hour else { return nil }
        
        switch hour {
        case 6..<12:
            return .morning
        case 12..<18:
            return .day
        case 18..<24:
            return .evening
        case 0..<6:
            return .night
        default:
            return nil
        }
    }
}

