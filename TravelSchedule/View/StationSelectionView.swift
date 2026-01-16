import SwiftUI

struct StationSelectionView: View {
    let selectedCity: SelectPlaceModel
    let onStationSelected: (String, String?) -> Void
    @StateObject private var viewModel: StationSelectionViewModel
    @Environment(\.dismiss) var dismiss
    
    init(selectedCity: SelectPlaceModel, onStationSelected: @escaping (String, String?) -> Void) {
        self.selectedCity = selectedCity
        self.onStationSelected = onStationSelected
        _viewModel = StateObject(wrappedValue: StationSelectionViewModel(selectedCity: selectedCity))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(searchText: $viewModel.searchText)
                .padding(.top, 8)
            
            if viewModel.filteredStations.isEmpty {
                Spacer()
                Text("Станция не найдена")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Colors.blackTopicColor)
                Spacer()
            } else {
                List(viewModel.filteredStations, id: \.self) { station in
                    HStack {
                        Text(station)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(Colors.blackTopicColor)
                        
                        Spacer()
                            .frame(height: 38)
                        
                        Image(systemName: "chevron.right")
                            .frame(width: 24, height: 24)
                            .foregroundColor(Colors.blackTopicColor)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        let stationCode = selectedCity.stationCodes[station]
                        onStationSelected(station, stationCode)
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.inset)
            }
        }
        .background(Colors.viewBackgroundColor)
        .navigationTitle("Выбор станции")
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
    }
}

#Preview {
    StationSelectionView(selectedCity: SelectPlaceModel.mockCities[0], onStationSelected: { _, _ in })
}

