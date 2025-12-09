import SwiftUI

struct CitySelectionView: View {
    let onStationSelected: (String, String) -> Void
    @State private var searchText: String = ""
    @State private var navigationPath = NavigationPath()
    @Environment(\.dismiss) var dismiss
    
    private var filteredCities: [SelectPlaceModel] {
        if searchText.isEmpty {
            return SelectPlaceModel.mockCities
        } else {
            return SelectPlaceModel.mockCities.filter {
                $0.city.contains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 0) {
                SearchBar(searchText: $searchText)
                    .padding(.top, 8)
                
                if filteredCities.isEmpty {
                    Spacer()
                    Text("Город не найден")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                } else {
                    List(filteredCities) { city in
                        Button(action: {
                            navigationPath.append(city)
                        }) {
                            HStack {
                                Text(city.city)
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                    .frame(height: 38)
                                
                                Image(systemName: "chevron.right")
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.black)
                            }
                        }
                        .buttonStyle(.plain)
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.inset)
                }
            }
            .background(Color.white)
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
                            .foregroundColor(.black)
                    }
                }
            }
            .navigationDestination(for: SelectPlaceModel.self) { city in
                StationSelectionView(
                    selectedCity: city,
                    onStationSelected: { station in
                        onStationSelected(city.city, station)
                        dismiss()
                    }
                )
            }
        }
    }
}

#Preview {
    CitySelectionView(onStationSelected: { _, _ in })
}

