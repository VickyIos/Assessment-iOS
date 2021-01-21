//
//  NetworkModels.swift
//  assessment-ios
//
//  Created by Vignesh on 22/01/21.
//  Copyright © 2021 Vignesh. All rights reserved.
//

import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Decodable {
    let cod: Int
    let calctime: Double
    let cnt: Int
    let list: [List]
}

// MARK: - List
struct List: Decodable {
    let id: Int
    let name: String
    let coord: Coord
    let main: Main
    let dt: Int
    let wind: Wind
    let rain: Rain?
    let clouds: Clouds?
    let weather: [Weather]
}

// MARK: - Clouds
struct Clouds: Decodable {
    let all: Int?
}

// MARK: - Coord
struct Coord: Decodable {
    let lon: Double?
    let lat: Double?
}

// MARK: - Main
struct Main: Decodable {
    let temp, tempMin, tempMax, pressure: Double
    let seaLevel, grndLevel: Double?
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
    }
}

// MARK: - Rain
struct Rain: Decodable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Decodable {
    let speed, deg: Double
}

