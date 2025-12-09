import SwiftUI

struct DirectionInputView: View {
    @State private var fromCity: String? = nil
    @State private var fromStation: String? = nil
    @State private var toCity: String? = nil
    @State private var toStation: String? = nil
    @State private var showFromSelection = false
    @State private var showToSelection = false
    
    private var fromText: String {
        if let city = fromCity, let station = fromStation {
            return "\(city) (\(station))"
        }
        return "Откуда"
    }
    
    private var toText: String {
        if let city = toCity, let station = toStation {
            return "\(city) (\(station))"
        }
        return "Куда"
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.blue)
            HStack(spacing: 8) {
                VStack(alignment: .leading, spacing: 24) {
                    Button(action: {
                        showFromSelection = true
                    }) {
                        Text(fromText)
                            .padding(.leading)
                            .foregroundColor(fromCity != nil ? .black : .gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    Button(action: {
                        showToSelection = true
                    }) {
                        Text(toText)
                            .padding(.leading)
                            .foregroundColor(toCity != nil ? .black : .gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                }
                .frame(width: 259, height: 96, alignment: .leading)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.leading, 16)
                
                Spacer()
                
                Button(action: buttonChange) {
                    Image("change")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22.22, height: 16.43)
                        .foregroundColor(.blue)
                        .padding(8)
                }
                .frame(width: 36, height: 36)
                .background(Color.white)
                .clipShape(Circle())
                
                Spacer(minLength: 8)
            }
            .padding(.trailing, 6)
        }
        .frame(height: 128)
        .padding(.horizontal, 16)
        .fullScreenCover(isPresented: $showFromSelection) {
            CitySelectionView(
                onStationSelected: { city, station in
                    fromCity = city
                    fromStation = station
                    showFromSelection = false
                }
            )
        }
        .fullScreenCover(isPresented: $showToSelection) {
            CitySelectionView(
                onStationSelected: { city, station in
                    toCity = city
                    toStation = station
                    showToSelection = false
                }
            )
        }
    }
    
    private func buttonChange() {
        let tempCity = fromCity
        let tempStation = fromStation
        fromCity = toCity
        fromStation = toStation
        toCity = tempCity
        toStation = tempStation
    }
}

#Preview {
    DirectionInputView()
}
