import SwiftUI

struct WeatherHomeCardStack: View {
    @State private var searchText = ""
    @State private var isSearchBarFocused = false
    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    WeatherSearchView(searchText: $searchText, isSearchBarFocused: $isSearchBarFocused)
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor.systemBackground))
                        .zIndex(1)

                    if !isSearchBarFocused {
                        ScrollView {
                            if let mainWeatherData = viewModel.weatherData {
                                NavigationLink(destination: WeatherDetailView(weatherData: mainWeatherData )) {
                                    WeatherHomeCard(weatherData: mainWeatherData, viewModel: viewModel)
                                        .foregroundColor(.white)
                                }
                            }

                            ForEach(viewModel.additionalWeatherData, id: \.self) { weatherData in
                                NavigationLink(destination: WeatherDetailView(weatherData:weatherData)) {
                                    WeatherHomeCard(weatherData: weatherData, viewModel: viewModel)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Weather")
                .navigationBarItems(trailing: DropDownButton())
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
