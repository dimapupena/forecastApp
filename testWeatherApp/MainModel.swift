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
                guard let self = self, let currentWeather = currentWeather else { return }
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
    
    func loadWeatherImage(imageCode: String?, completion: @escaping ((UIImage?) -> Void)) {
        if let imageCode = imageCode {
            networkingService.getWeatherImage(imageCode: imageCode) { data in
                guard let data = data else {
                    completion(nil)
                    return
                }
                completion(UIImage(data: data))
            }
        } else {
            completion(nil)
        }
    }
    
    func getCitiesToShow() -> [Location] {
        return networkingService.getCitiesToShow()
    }
    
    func getCurrentWeather(location: Location, completion: @escaping ((CurrentWeather?) -> Void)) {
        networkingService.getCurrentWeahter(location, completion: completion)
    }
    
}
