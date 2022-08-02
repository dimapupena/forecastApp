//
//  Weather.swift
//  testWeatherApp
//
//  Created by Dmytro Pupena on 31.07.2022.
//

import Foundation

struct Weather: Codable {
    let id: Int
    let coord: Coord
    let weather: [WeatherOverall]
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone: Int?
    let name: String?
    let cod: Int?
}

struct Clouds: Codable {
    let all: Int?
}

struct Coord: Codable {
    let lon, lat: Double?
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity, seaLevel, grndLevel: Int?
    let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case tempKf = "temp_kf"
    }
}

struct Sys: Codable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
}

struct WeatherOverall: Codable {
    let id: Int?
    let main, weatherDescription, icon: String?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
