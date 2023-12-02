//
//  NetworkManager.swift
//  WeatherCheck
//
//  Created by Oluwayomi M on 2023-11-24.
//

import Foundation

class NetworkManager {
    func fetchWeather(lat: Double, lon: Double, completion: @escaping(Result<Weathernetworkmodel, Error>) -> Void) {
        guard let apikey = ProcessInfo.processInfo.environment["apiKey"] else {
            print("Api Key not Found")
            return
        }
        
        let urlString = "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&appid=\(apikey)"
        
        guard let url  = URL(string: urlString) else {return}
        print("URL String: \(urlString)")
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            if let error = error{
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            guard let data = data else {
                print("No data received")
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            do {
                let weatherData = try JSONDecoder().decode(Weathernetworkmodel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(weatherData))
                }
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        }
        .resume()
    }
    
    func featchLocation( for query: String, completion: @escaping(Result<[SearchModelElement], Error>) -> Void){
        guard let apikey = ProcessInfo.processInfo.environment["apiKey"] else {
            print("Api Key not Found")
            return
        }
        let urlString = "https://api.openweathermap.org/geo/1.0/direct?q=\(query)&limit=5&appid=\(apikey)"
        print("URL String: \(urlString)")
               guard let url = URL(string: urlString) else {
                   completion(.failure(NetworkError.invalidURL))
                   return
               }

               // Create a data task to fetch the data
               let task = URLSession.shared.dataTask(with: url) { data, response, error in
                   if let error = error {
                       completion(.failure(error))
                       return
                   }

                   guard let data = data else {
                       completion(.failure(NetworkError.noData))
                       return
                   }
                   
//                   print(String(data: data, encoding: .utf8) ?? "No raw data")
                   
                   do {
                       
                       let locations = try JSONDecoder().decode([SearchModelElement].self, from: data)
                       completion(.success(locations))
                   } catch {
                       print("Decoding error: \(error)")
                       completion(.failure(error))
                   }
               }

               task.resume()
           }
    }

enum NetworkError: Error {
    case invalidURL
    case noData
}
