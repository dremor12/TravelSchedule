import SwiftUI

struct CitySelectionView: View {
    let onStationSelected: (String, String, String?) -> Void
    @StateObject private var viewModel = CitySelectionViewModel(apiClient: GlobalParams.createAPIClient())
    @State private var navigationPath = NavigationPath()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 0) {
                SearchBar(searchText: $viewModel.searchText)
                    .padding(.top, 8)
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else if viewModel.filteredCities.isEmpty {
                    Spacer()
                    Text("Город не найден")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Colors.blackTopicColor)
                    Spacer()
                } else {
                    List(viewModel.filteredCities) { city in
                        Button(action: {
                            navigationPath.append(city)
                        }) {
                            HStack {
                                Text(city.city)
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(Colors.blackTopicColor)
                                
                                Spacer()
                                    .frame(height: 38)
                                
                                Image(systemName: "chevron.right")
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(Colors.blackTopicColor)
                            }
                        }
                        .buttonStyle(.plain)
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.inset)
                }
            }
            .background(Colors.viewBackgroundColor)
            .navigationTitle("Выбор города")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
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
            .navigationDestination(for: SelectPlaceModel.self) { city in
                StationSelectionView(
                    selectedCity: city,
                    onStationSelected: { station, stationCode in
                        onStationSelected(city.city, station, stationCode)
                        dismiss()
                    }
                )
            }
            .task {
                await viewModel.loadCities()
            }
            .errorOverlay(errorType: $viewModel.errorType)
        }
    }
}

#Preview {
    CitySelectionView(onStationSelected: { _, _, _ in })
}

