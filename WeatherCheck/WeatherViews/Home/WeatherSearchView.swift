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
    private let debouncer = Debouncer(interval: 0.5)
    @State private var isLoadingWeatherData = false
    
    var body: some View {
        VStack(alignment: .leading) {
            searchField
            if !searchText.isEmpty {
                searchResultsList
            }
        }
        .sheet(item: $selectedLocation) {_ in 
            if let weatherData = viewModel.weatherData{
                NavigationView{
                    WeatherDetailView(weatherData: weatherData)
                        .navigationBarItems(
                            leading: Button("Cancel"){
                                self.selectedLocation = nil
                            },
                            trailing: Button("Add"){
                                addCard()
                            }
                        )
                }
            }
        }
        
    }
    
    private var searchField: some View {
        VStack {
            HStack {
                TextField("Search By City Or AirPort", text: $searchText)
                    .focused($isTextFieldFocused)
                    .onChange(of: searchText) { newValue in
                        print("Search text changed: \(newValue)")
                        debouncer.debounce {
                            print("Debouncer triggered for query: \(newValue)")
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
                        withAnimation {
                            self.isSearchBarFocused = true
                        }
                    }
                    .onSubmit {
                        withAnimation {
                            self.isSearchBarFocused = false
                        }
                    }
                
                if isSearchBarFocused {
                    Button(action: {
                        withAnimation {
                            self.searchText = ""
                            self.isSearchBarFocused = false
                            self.isTextFieldFocused = false
                        }
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
        .onAppear {
            print("WeatherHomeCardStack appeared. Main weather data: \(String(describing: viewModel.weatherData))")
        }
        .onChange(of: viewModel.weatherData) { newData in
            print("Main weather data changed: \(String(describing: newData))")
        }

    }
    
//    private var searchResultsList: some View {
//        VStack(alignment: .leading){
//            ForEach(viewModel.searchResults, id: \.id) { location in
//                Button(action: {
//                    self.selectedLocation = location
//                    viewModel.loadWeatherDataForSelectedLocation(location)
//                }){
//                    Text("\(location.name ?? "Unknown Value"), \(location.state ?? ""), \(location.country ?? "")")
//                        .fontWeight(.bold)
//                        .foregroundColor(.black)
//                }
//                .padding()
//            }
//            .onAppear{
//                print("Search results list appeared with \(viewModel.searchResults.count) results")}
//
//        }
//        .padding()
//    }
//
    
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
//                    viewModel.loadWeatherDataForSelectedLocation(location)
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

    
//   private func addCard(){
//       if let weatherData = viewModel.weatherData {
//           viewModel.addLocationWeatherData(weatherData)
//        }
//        self.selectedLocation = nil
//    }
    
    private func addCard() {
        if let selectedLocation = selectedLocation {
            viewModel.loadWeatherDataForSelectedLocation(selectedLocation)
        }
        self.selectedLocation = nil
    }

}

struct WeatherSearchView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherSearchView(searchText: .constant(""), isSearchBarFocused: .constant(true))
            .environmentObject(WeatherViewModel())
    }
}


