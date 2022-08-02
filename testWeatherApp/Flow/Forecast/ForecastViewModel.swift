//
//  ForecastViewModel.swift
//  testWeatherApp
//
//  Created by Dmytro Pupena on 01.08.2022.
//

import Foundation
import MapKit

class ForecastViewModel {
    
    var weatherData: LocationWeatherData
    private var model: MainModel!
    
    init(weatherData: LocationWeatherData, model: MainModel) {
        self.weatherData = weatherData
        self.model = model
    }
    
    func getLocationMapConfiguration() -> (MKPlacemark?, [String: Any]?) {
        let latitude: CLLocationDegrees = weatherData.location.latitude
        let longitude: CLLocationDegrees = weatherData.location.longitude
        
        let regionDistance: CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        return (placemark, options)
    }
    
    func loadForecast(completion: @escaping (() -> Void)) {
        model.loadForecast(location: weatherData.location) { [weak self] forecast in
            self?.weatherData.forecase = forecast
            completion()
        }
    }
}
