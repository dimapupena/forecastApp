//
//  Forecast.swift
//  testWeatherApp
//
//  Created by Dmytro Pupena on 01.08.2022.
//

import Foundation
import UIKit

struct Forecast {
    let cod: String?
    let message, cnt: Int?
    var list: [ForecastWeather]?
    let city: City?
}

struct ForecastWeather {
    let forecast: ForecastWeatherModel?
    let image: UIImage
}

struct ForecastModel: Codable {
    let cod: String?
    let message, cnt: Int?
    let list: [ForecastWeatherModel]?
    let city: City?
}

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

struct ForecastWeatherModel: Codable {
    let dt: Int?
    let main: Main?
    let weather: [WeatherOverall]?
    let clouds: Clouds?
    let wind: Wind?
    let visibility: Int?
    let pop: Double?
    let sys: ForecastSys?
    let dtTxt: String?
    let rain, snow: Rain?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain, snow
    }
}

struct ForecastSys: Codable {
    let pod: Pod?
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

struct Rain: Codable {
    let the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}
