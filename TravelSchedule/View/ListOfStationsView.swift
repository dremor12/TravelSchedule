import SwiftUI

enum NavigationDestination: Hashable {
    case carrier(SelectCompanyModel)
    case filtration
}

struct ListOfStationsView: View {
    let fromCity: String
    let fromStation: String
    let fromStationCode: String?
    let toCity: String
    let toStation: String
    let toStationCode: String?
    
    @StateObject private var viewModel: ListOfStationsViewModel
    @State private var navigationPath = NavigationPath()
    @Environment(\.dismiss) var dismiss
    
    init(
        fromCity: String,
        fromStation: String,
        fromStationCode: String?,
        toCity: String,
        toStation: String,
        toStationCode: String?
    ) {
        self.fromCity = fromCity
        self.fromStation = fromStation
        self.fromStationCode = fromStationCode
        self.toCity = toCity
        self.toStation = toStation
        self.toStationCode = toStationCode
        _viewModel = StateObject(wrappedValue: ListOfStationsViewModel(
            fromCity: fromCity,
            fromStation: fromStation,
            fromStationCode: fromStationCode,
            toCity: toCity,
            toStation: toStation,
            toStationCode: toStationCode,
            apiClient: GlobalParams.createAPIClient()
        ))
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 0) {
                Text(viewModel.routeTitle)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Colors.blackTopicColor)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else if viewModel.filteredCompany.isEmpty {
                    Spacer()
                    Text("Вариантов нет")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Colors.blackTopicColor)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(viewModel.filteredCompany) { company in
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
                        initialTimePeriods: viewModel.selectedTimePeriods,
                        initialTransferOption: viewModel.selectedTransferOption
                    ) { timePeriods, transferOption in
                        viewModel.applyFilters(timePeriods: timePeriods, transferOption: transferOption)
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
                        
                        if viewModel.hasActiveFilters {
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
            .task {
                await viewModel.loadSchedule()
            }
            .errorOverlay(errorType: $viewModel.errorType)
        }
    }
}

#Preview {
    ListOfStationsView(
        fromCity: "Москва",
        fromStation: "Ярославский вокзал",
        fromStationCode: "s2000001",
        toCity: "Санкт Петербург",
        toStation: "Балтийский вокзал",
        toStationCode: "s9600213"
    )
}
