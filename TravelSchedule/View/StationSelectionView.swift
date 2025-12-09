import SwiftUI

struct StationSelectionView: View {
    let selectedCity: SelectPlaceModel
    let onStationSelected: (String) -> Void
    @State private var searchText: String = ""
    @Environment(\.dismiss) var dismiss
    
    private var filteredStations: [String] {
        if searchText.isEmpty {
            return selectedCity.trainStations
        } else {
            return selectedCity.trainStations.filter { station in
                station.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(searchText: $searchText)
                .padding(.top, 8)
            
            if filteredStations.isEmpty {
                Spacer()
                Text("Станция не найдена")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                Spacer()
            } else {
                List(filteredStations, id: \.self) { station in
                    HStack {
                        Text(station)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.primary)
                        
                        Spacer()
                            .frame(height: 38)
                        
                        Image(systemName: "chevron.right")
                            .frame(width: 24, height: 24)
                            .foregroundColor(.black)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onStationSelected(station)
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.inset)
            }
        }
        .background(Color.white)
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
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    StationSelectionView(selectedCity: SelectPlaceModel.mockCities[0], onStationSelected: { _ in })
}

