import SwiftUI

enum NavigationDestination: Hashable {
    case carrier(SelectCompanyModel)
    case filtration
}

struct ListOfStationsView: View {
    let fromCity: String
    let fromStation: String
    let toCity: String
    let toStation: String
    
    @State private var navigationPath = NavigationPath()
    @Environment(\.dismiss) var dismiss
    @State private var selectedTimePeriods: Set<TimePeriod> = []
    @State private var selectedTransferOption: TransferOption? = nil
    
    private var filteredCompany: [SelectCompanyModel] {
        var companies = SelectCompanyModel.mockSelectCompany

        if !selectedTimePeriods.isEmpty {
            companies = companies.filter { company in
                guard let period = TimePeriod.period(for: company.timeToStart) else { return false }
                return selectedTimePeriods.contains(period)
            }
        }

        if let transferOption = selectedTransferOption {
            switch transferOption {
            case .yes:
                companies = companies.filter { $0.needSwapStation }
            case .no:
                companies = companies.filter { !$0.needSwapStation }
            }
        }
        
        return companies
    }
    
    private var routeTitle: String {
        return "\(fromCity) (\(fromStation)) → \(toCity) (\(toStation))"
    }
    
    private var hasActiveFilters: Bool {
        !selectedTimePeriods.isEmpty || selectedTransferOption != nil
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 0) {
                Text(routeTitle)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Colors.blackTopicColor)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                if filteredCompany.isEmpty {
                    Spacer()
                    Text("Вариантов нет")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Colors.blackTopicColor)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(filteredCompany) { company in
                                NavigationLink(value: NavigationDestination.carrier(company)) {
                                    ListOfStationsCell(company: company)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 100)
                    }
                }
            }
            .background(Colors.viewBackgroundColor)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .carrier(let company):
                    CarrierCardView(company: company)
                case .filtration:
                    FiltrationView(
                        initialTimePeriods: selectedTimePeriods,
                        initialTransferOption: selectedTransferOption
                    ) { timePeriods, transferOption in
                        selectedTimePeriods = timePeriods
                        selectedTransferOption = transferOption
                        navigationPath.removeLast()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17))
                            .foregroundColor(Colors.blackTopicColor)
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                Button {
                    navigationPath.append(NavigationDestination.filtration)
                } label: {
                    HStack(spacing: 8) {
                        Text("Уточнить время")
                            .font(.system(size: 17, weight: .bold))
                        
                        if hasActiveFilters {
                            Circle()
                                .fill(.ypRedUniversal)
                                .frame(width: 8, height: 8)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.ypBlueUniversal)
                    .foregroundColor(.ypWhiteUniversal)
                    .cornerRadius(16)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
                .background(Colors.viewBackgroundColor)
            }
        }
    }
}

#Preview {
    ListOfStationsView(
        fromCity: "Москва",
        fromStation: "Ярославский вокзал",
        toCity: "Санкт Петербург",
        toStation: "Балтийский вокзал"
    )
}
