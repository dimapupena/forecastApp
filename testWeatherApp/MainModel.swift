//
//  MainModel.swift
//  testWeatherApp
//
//  Created by Dmytro Pupena on 31.07.2022.
//

import Foundation
import UIKit

class MainModel {
    
    var dataSource: [LocationWeatherData] = []
    private let cachedStorage = CachedStorage.shared
    
    private let networkingService = NetworkingService()
    
    func loadDataSource(completion: @escaping (([LocationWeatherData]) -> Void)) {
        for location in networkingService.getCitiesToShow() {
            dataSource.append(LocationWeatherData(location: location, currentWeather: nil))
        }
        let semaphore = DispatchSemaphore(value: 1)
        let dispatchGroup = DispatchGroup()
        for source in dataSource {
            dispatchGroup.enter()
            getCurrentWeather(location: source.location) { [weak self] currentWeather in
                guard let self = self, let currentWeather = currentWeather else {
                    dispatchGroup.leave()
                    return
                }
                self.loadWeatherImage(imageCode: currentWeather.weather.first?.icon) { image in
                    semaphore.wait()
                    if let index = self.dataSource.firstIndex(where: {$0.location == source.location}) {
                        self.dataSource[index].currentWeather = currentWeather
                        self.dataSource[index].currentWeatherImage = image
                    }
                    semaphore.signal()
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            completion(self.dataSource)
        }
    }
    
    func loadForecast(location: Location, completion: @escaping ((Forecast?) -> Void)) {
        networkingService.getForecase(location) { [weak self] forecastModel in
            guard let self = self, let listOfWeather = forecastModel?.list else { return }
            let semaphore = DispatchSemaphore(value: 1)
            let dispatchGroup = DispatchGroup()
            var forecast = Forecast(cod: forecastModel?.cod, message: forecastModel?.message, cnt: forecastModel?.cnt, list: [], city: forecastModel?.city)
            var listOfForecast: [ForecastWeather] = []
            for forecastModel in listOfWeather {
                dispatchGroup.enter()
                self.loadWeatherImage(imageCode: forecastModel.weather?.first?.icon) { image in
                    if let image = image  {
                        semaphore.wait()
                        listOfForecast.append(ForecastWeather(forecast: forecastModel, image: image))
                        semaphore.signal()
                    }
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .global(qos: .userInitiated)) {
                forecast.list = listOfForecast
                completion(forecast)
            }
        }
    }
    
    func loadWeatherImage(imageCode: String?, completion: @escaping ((UIImage?) -> Void)) {
        if let imageCode = imageCode {
            if let image = cachedStorage.getCachedImage(code: imageCode) {
                completion(image)
            } else {
                networkingService.getWeatherImage(imageCode: imageCode) { [weak self] data in
                    guard let self = self, let data = data else {
                        completion(nil)
                        return
                    }
                    if let image = UIImage(data: data) {
                        self.cachedStorage.putCacheImage(code: imageCode, image: image)
                        completion(image)
                    } else {
                        completion(nil)
                    }
                   
                }
            }
        } else {
            completion(nil)
        }
    }
    
    func getCitiesToShow() -> [Location] {
        return networkingService.getCitiesToShow()
    }
    
    func getCurrentWeather(location: Location, completion: @escaping ((Weather?) -> Void)) {
        networkingService.getCurrentWeahter(location, completion: completion)
    }
    
}
