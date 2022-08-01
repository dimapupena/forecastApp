//
//  ForecastViewModel.swift
//  testWeatherApp
//
//  Created by Dmytro Pupena on 01.08.2022.
//

import Foundation

class ForecastViewModel {
    
    var weatherData: LocationWeatherData
    var model: MainModel!
    
    init(weatherData: LocationWeatherData, model: MainModel) {
        self.weatherData = weatherData
        self.model = model
    }
    
    func loadForecast(completion: @escaping (() -> Void)) {
        
    }
}
