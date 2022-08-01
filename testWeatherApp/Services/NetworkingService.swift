//
//  NetworkingService.swift
//  testWeatherApp
//
//  Created by Dmytro Pupena on 31.07.2022.
//

import Foundation

class NetworkingService {
    
    static let apiKey = "0cd74bf29e43ef1ad6afd6861cc99eb2"
    let session: URLSession
    
    enum Endpoints {
        static let base = "https://api.openweathermap.org/"
        static let apiImagesBase = "https://openweathermap.org/"
        
        case getCurrentWeahter
        case getForecase
        case getWeatherImage
        
        var stringValue: String {
            switch self {
            case .getCurrentWeahter:
                return Endpoints.base + "data/2.5/weather"
            case .getForecase:
                return Endpoints.base + "data/2.5/forecast"
            case .getWeatherImage:
                return Endpoints.apiImagesBase + "img/wn"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    init() {
         session = URLSession.shared
    }
    
    func getCitiesToShow() -> [Location] {
        return  [Location(placeName: "London", latitude: 51.5072, longitude: 0.1276),
                 Location(placeName: "Tel­ Aviv", latitude: 32.0853, longitude: 34.7818),
                 Location(placeName: "New­York", latitude: 40.7128, longitude: 74.0060),
                 Location(placeName: "Brussels", latitude: 50.8476, longitude: 50.8476),
                 Location(placeName: "Barcelona", latitude: 41.3874, longitude: 2.1686),
                 Location(placeName: "Paris", latitude: 48.8566, longitude: 2.3522),
                 Location(placeName: "Tokyo", latitude: 35.6762, longitude: 139.6503),
                 Location(placeName: "Beijing", latitude: 39.9042, longitude: 116.4074),
                 Location(placeName: "Sydney", latitude: 33.8688, longitude: 151.2093),
                 Location(placeName: "Buenos­ Aire", latitude: 34.6037, longitude: 58.3816),
                 Location(placeName: "Miami", latitude: 25.7617, longitude: 80.1918),
                 Location(placeName: "Vancouver", latitude: 49.2827, longitude: 123.1207),
                 Location(placeName: "Kyiv", latitude: 50.4501, longitude: 30.5234),
                 Location(placeName: "Bangkok", latitude: 13.7563, longitude: 100.5018),
                 Location(placeName: "Johannesburg", latitude: 26.2041, longitude: 28.0473),
                 Location(placeName: "Tunis", latitude: 36.8065, longitude: 10.1815),
                 Location(placeName: "Manila", latitude: 14.5995, longitude: 120.9842)]
    }
    
    func getCurrentWeahter(_ location: Location, completion: @escaping ((CurrentWeather?) -> Void)) {
        guard var urlComps = URLComponents(string: Endpoints.getCurrentWeahter.stringValue) else { return }
        let queryItems = [URLQueryItem(name: "lat", value: "\(location.latitude)"), URLQueryItem(name: "lon", value: "\(location.longitude)"), URLQueryItem(name: "appid", value: "\(Self.apiKey)")]
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else { return }
         let task = session.dataTask(with: url) { data, response, error in
             guard let data = data, error == nil else { return }
             do {
                 let res = try JSONDecoder().decode(CurrentWeather.self, from: data)
                 completion(res)
             } catch let error as NSError {
                 completion(nil)
                 print("Failed to load: \(error.localizedDescription)")
             }
         }

         task.resume()
    }
    
    func getWeatherImage(imageCode: String, completion: @escaping ((Data?) -> Void)) {
        let urlString = Endpoints.getWeatherImage.stringValue + "/\(imageCode)" + "@2x.png"
        guard let url = URL(string: urlString) else { return }
        let task = session.dataTask(with: url) { data, response, error in
             guard let data = data, error == nil else { return }
             do {
                 completion(data)
             } catch let error as NSError {
                 completion(nil)
                 print("Failed to load: \(error.localizedDescription)")
             }
         }

         task.resume()
    }
    
}
