import SwiftUI

struct WeatherHomeCardStack: View {
    @State private var searchText = ""
    @State private var isSearchBarFocused = false
    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView {
                    VStack {
                        WeatherSearchView(searchText: $searchText, isSearchBarFocused: $isSearchBarFocused)
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor.systemBackground))
                            .zIndex(1)

                        if !isSearchBarFocused {
                            ScrollView {
                                if let mainWeatherData = viewModel.weatherData {
                                    NavigationLink(destination: WeatherDetailView(weatherData: mainWeatherData)) {
                                        WeatherHomeCard(cardData: WeatherCardData(cityName: viewModel.cityName ?? "Unknown", weatherData: mainWeatherData))
                                            .foregroundColor(.white)
                                    }
                                }

                                ForEach(viewModel.additionalWeatherData, id: \.self) { cardData in
                                    NavigationLink(destination: WeatherDetailView(weatherData: cardData.weatherData)) {
                                        WeatherHomeCard(cardData: cardData)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                    }
                    .navigationTitle("Weather")
                    .navigationBarItems(trailing: DropDownButton())
                }
            }

            if isSearchBarFocused && searchText.isEmpty {
                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct WeatherHomeCardStack_Previews: PreviewProvider {
    static var previews: some View {
        WeatherHomeCardStack()
            .environmentObject(WeatherViewModel())
    }
}

