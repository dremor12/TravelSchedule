import SwiftUI

struct DirectionInputView: View {
    @StateObject private var viewModel = DirectionInputViewModel()

    var body: some View {
        VStack(spacing: 0) {
            directionInputCard
            findButton
        }
        .fullScreenCover(isPresented: $viewModel.showFromSelection) {
            CitySelectionView(
                onStationSelected: { city, station, stationCode in
                    viewModel.selectFromStation(city: city, station: station, stationCode: stationCode)
                }
            )
        }
        .fullScreenCover(isPresented: $viewModel.showToSelection) {
            CitySelectionView(
                onStationSelected: { city, station, stationCode in
                    viewModel.selectToStation(city: city, station: station, stationCode: stationCode)
                }
            )
        }
        .fullScreenCover(isPresented: $viewModel.showListOfStations) {
            Group {
                if let fromCity = viewModel.fromCity,
                   let fromStation = viewModel.fromStation,
                   let toCity = viewModel.toCity,
                   let toStation = viewModel.toStation {
                    ListOfStationsView(
                        fromCity: fromCity,
                        fromStation: fromStation,
                        fromStationCode: viewModel.fromStationCode,
                        toCity: toCity,
                        toStation: toStation,
                        toStationCode: viewModel.toStationCode
                    )
                }
            }
        }
        .errorOverlay(errorType: $viewModel.errorType)
    }

    private var directionInputCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(.ypBlueUniversal)
            
            HStack {
                VStack(alignment: .leading, spacing: 24) {
                    Button(action: {
                        viewModel.showFromSelection = true
                    }) {
                        Text(viewModel.fromText)
                            .padding(.leading)
                            .foregroundColor(viewModel.fromCity != nil ? .ypBlackUniversal : .ypGrayUniversal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    Button(action: {
                        viewModel.showToSelection = true
                    }) {
                        Text(viewModel.toText)
                            .padding(.leading)
                            .foregroundColor(viewModel.toCity != nil ? .ypBlackUniversal : .ypGrayUniversal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                }
                .frame(height: 96)
                .background(.ypWhiteUniversal)
                .cornerRadius(20)

                Button(action: {
                    viewModel.swapDirections()
                }) {
                    Image("change")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22.22, height: 16.43)
                        .foregroundColor(.ypBlueUniversal)
                }
                .frame(width: 36, height: 36)
                .background(.ypWhiteUniversal)
                .clipShape(Circle())
                .padding(.leading, 8)
                .padding(.trailing, 16)
            }
            .padding(.leading, 16)
        }
        .frame(height: 128)
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    private var findButton: some View {
        if viewModel.isRouteSelected {
            Button {
                viewModel.showRouteList()
            } label: {
                Text("Найти")
                    .font(.system(size: 17, weight: .bold))
                    .frame(width: 150, height: 60)
                    .background(.ypBlueUniversal)
                    .foregroundColor(.ypWhiteUniversal)
                    .cornerRadius(16)
            }
            .padding(.top, 16)
        }
    }
}

#Preview {
    DirectionInputView()
}
