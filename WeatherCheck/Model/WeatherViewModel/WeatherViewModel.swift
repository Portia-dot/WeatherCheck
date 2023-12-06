//
//  WeatherViewModel.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-11-28.
//


import SwiftUI
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var weatherData: Weathernetworkmodel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var cityName: String?
    private var weatherService = NetworkManager()
    private var locationManager = LocationManager.shared
    private var lastFetchedLocation: CLLocationCoordinate2D?
    private var lastFetchTime: Date?
    
    @Published var searchResults: [SearchModelElement] = []
    @Published var additionalWeatherData: [Weathernetworkmodel] = []
    
    
    init() {
        locationManager.onLocationUpdate = { [weak self] location in
            self?.loadWeatherData(for: location)
        }
//        locationManager.requestLocation()
    }
    
    // MARK: - Fetch Weather
    func loadWeatherData(for location: CLLocationCoordinate2D) {
        guard shouldFetchNewData(for: location) else { return }
        
        print("Loading weather data for location: \(location)")
        isLoading = true
        
        // Reverse Geocoding to get location name
        let geocoder = CLGeocoder()
        let clLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        geocoder.reverseGeocodeLocation(clLocation) { [weak self] (placemarks, error) in
            if let error = error {
                print("Reverse geocoding failed: \(error.localizedDescription)")
                self?.errorMessage = "Reversed geocoding failed: \(error.localizedDescription)"
                return
            }
            if let placemark = placemarks?.first {
                self?.cityName = placemark.locality ?? "Unknown"
                print("Location: \(self?.cityName ?? "Unknown")")
            }
        }
        
        // Fetch Weather Data
        weatherService.fetchWeather(lat: location.latitude, lon: location.longitude) { [weak self] result in
            DispatchQueue.main.async {
                print("Weather Data Fetch Completed")
                self?.isLoading = false
                switch result {
                case .success(let weatherData):
                    print("Weather data fetched successfully")
                    self?.weatherData = weatherData
                case .failure(let error):
                    print("Failed to fetch weather data \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
        
        lastFetchedLocation = location
    }
    
    //MARK: - Prevent Mutiple API call
    private func shouldFetchNewData(for newLocation: CLLocationCoordinate2D) -> Bool {
        let currentTime = Date()
        let minimumTimeInterval: TimeInterval = 60 * 5 // 5 minutes

        guard let lastLocation = lastFetchedLocation,
              let lastTime = lastFetchTime else {
            lastFetchTime = currentTime
            return true
        }

        let distance = CLLocation(latitude: newLocation.latitude, longitude: newLocation.longitude)
            .distance(from: CLLocation(latitude: lastLocation.latitude, longitude: lastLocation.longitude))
        if distance > 500 || currentTime.timeIntervalSince(lastTime) > minimumTimeInterval {
            lastFetchTime = currentTime
            return true
        }

        return false
    }
    
    //MARK: - Get time
    func formatUnixTimeStamp(_ timestamp: Int, timezone: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        formatter.timeZone = TimeZone(identifier: timezone)
        return formatter.string(from: date)
    }
    func requestLocation(){
        locationManager.requestLocation()
    }
    
    //MARK: -  Background
    
    var isDayTime: Bool{
        if let current = weatherData?.current{
            let now = Date().timeIntervalSince1970
            return now >= Double(current.sunrise ?? 0 ) && now < Double(current.sunset ?? 0)
        }
        return true
    }
    
 //MARK: - Search Weather
    func searchWeather(query: String) {
        isLoading = true
        weatherService.featchLocation(for: query) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let locations):
//                    print("Search successful. Locations found: \(locations)")
                    self?.searchResults = locations
                case .failure(let error):
                    print("Search failed with error: \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                }
            }
        }

    }
    
    
    func loadWeatherDataForSelectedLocation(_ location: SearchModelElement) {
        loadWeatherData(for: CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon))
    }
    

    //MARK: - Add Weather Card Logic
    
    func addLocationWeatherData(_ weatherData: Weathernetworkmodel){
        DispatchQueue.main.async {
            self.additionalWeatherData.append(weatherData)
        }
       
    }
    
    
}


extension Notification.Name {
    static let locationDidUpdate = Notification.Name("locationDidUpdate")
}
