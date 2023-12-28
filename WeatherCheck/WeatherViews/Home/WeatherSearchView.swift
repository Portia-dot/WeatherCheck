//
//  WeatherSearchView.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-11-24.
//

import SwiftUI

struct WeatherSearchView: View {
    @Binding var searchText: String
    @Binding var isSearchBarFocused: Bool
    @FocusState var isTextFieldFocused: Bool
    @EnvironmentObject var viewModel: WeatherViewModel
    @State private var selectedLocation: SearchModelElement?
    @State private var cardDataToShow: WeatherCardData?
    private let debouncer = Debouncer(interval: 0.5)

    var body: some View {
        VStack(alignment: .leading) {
            searchField
            if !searchText.isEmpty {
                searchResultsList
            }
        }
        .sheet(item: $selectedLocation) { _ in
            if let cardData = cardDataToShow {
                NavigationView {
                    WeatherDetailView(cardData: cardData, currentLocation: false)
                        .navigationBarItems(
                            leading: Button("Cancel") {
                                self.selectedLocation = nil
                            },
                            trailing: Button("Add") {
                                viewModel.addLocationWeatherData(cardData)
                                self.selectedLocation = nil
                            }
                        )
                }
            }
        }
    }

    private var searchField: some View {
        HStack {
            TextField("Search By City Or AirPort", text: $searchText)
                .focused($isTextFieldFocused)
                .onChange(of: searchText) { newValue in
                    debouncer.debounce {
                        viewModel.searchWeather(query: newValue)
                    }
                }
                .padding(7)
                .padding(.horizontal)
                .background(Color(.systemGray4))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .font(.footnote)
                .onTapGesture {
                    self.isSearchBarFocused = true
                }
                .onSubmit {
                    self.isSearchBarFocused = false
                }

            if isSearchBarFocused {
                Button(action: {
                    self.searchText = ""
                    self.isSearchBarFocused = false
                    self.isTextFieldFocused = false
                }) {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }
        .overlay(
            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15)
                    .foregroundColor(.gray)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 15)
            }
        )
    }

    private var searchResultsList: some View {
        Group {
            if viewModel.searchResults.count <= 3 {
                VStack { contentStack }
            } else {
                ScrollView { contentStack }
            }
        }
        .transition(.opacity)
        .animation(.easeInOut)
    }

    private var contentStack: some View {
        VStack(alignment: .leading) {
            ForEach(viewModel.searchResults, id: \.id) { location in
                Button(action: {
                    self.selectedLocation = location
                    loadWeatherDataForLocation(location)
                }) {
                    Text("\(location.name ?? "Unknown Value"), \(location.state ?? ""), \(location.country ?? "")")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                .padding()
            }
        }
        .padding()
    }
    

    private func loadWeatherDataForLocation(_ location: SearchModelElement) {
        viewModel.loadWeatherDataForSelectedLocation(location) { cardData in
            self.cardDataToShow = cardData
        }
    }
}

struct WeatherSearchView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherSearchView(
            searchText: .constant(""),
            isSearchBarFocused: .constant(true)
//            cardDataToShow: WeatherCardData(cityName: "Saskatoon", weatherData: mockWeatherData)
        )
        .environmentObject(WeatherViewModel())
    }
}

       
       


