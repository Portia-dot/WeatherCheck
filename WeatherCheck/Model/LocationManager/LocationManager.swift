//
//  LocationManager.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-11-28.


import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate{
    static let shared = LocationManager()
    var onLocationUpdate: ((CLLocationCoordinate2D) -> Void)?
    let locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    
    let someAccuracyThreshold: CLLocationDistance = 100
    let minimumTimeInterval: TimeInterval = 60 * 5
    var lastUpdateTime: Date?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 500

    }

    func requestLocation() {
        let status = locationManager.authorizationStatus

        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.requestLocation()
        } else if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            print("Location authorization denied or restricted.")
        }
    }

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            // Request authorization
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            // Start updating location in a non-blocking way
            DispatchQueue.main.async {
                manager.startUpdatingLocation()
            }
        case .restricted, .denied:
            print("Location access was restricted or denied.")
        @unknown default:
            print("Unknown authorization status")
        }
    }


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let location = locations.last else { return }
           currentLocation = location.coordinate

           // Throttle location updates
           let currentTime = Date()
           if let lastUpdate = lastUpdateTime, currentTime.timeIntervalSince(lastUpdate) < minimumTimeInterval {
               return
           }

           if location.horizontalAccuracy < someAccuracyThreshold {
               onLocationUpdate?(location.coordinate)
               lastUpdateTime = currentTime
               locationManager.stopUpdatingLocation()
           }
       }


    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clError = error as? CLError {
            switch clError {
            case CLError.locationUnknown:
                print("Location is currently unknown, but Core Location will keep trying.")
            case CLError.denied:
                print("Access to location or ranging has been denied by the user.")
            case CLError.network:
                print("Network error occurred while trying to determine location.")
            default:
                print("Location error: \(error.localizedDescription)")
            }
        } else {
            print("Other error: \(error.localizedDescription)")
        }
    }

}


