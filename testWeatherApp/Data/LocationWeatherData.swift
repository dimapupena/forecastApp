//
//  LocationWeatherData.swift
//  testWeatherApp
//
//  Created by Dmytro Pupena on 01.08.2022.
//

import Foundation
import UIKit

struct LocationWeatherData {
    let location: Location
    var currentWeather: Weather?
    var currentWeatherImage: UIImage?
    var forecase: Forecast?
}

struct Location: Hashable {
    let placeName: String
    let latitude: Double
    let longitude: Double
}
