//
//  WeatherInfo.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import Foundation

struct WeatherInfo: Decodable {
    var weather: [WeatherStatus]?
    var temperatureInfo: TemperatureInfo?
    var sunsetSunrise: SunsetSunriseInfo?

    enum CodingKeys: String, CodingKey {
        case weather
        case temperatureInfo = "main"
        case sunsetSunrise = "sys"
    }
}

extension WeatherInfo {
    struct WeatherStatus: Decodable {
        var status: String?
        var description: String?

        enum CodingKeys: String, CodingKey {
            case status = "main"
            case description
        }
    }

    struct TemperatureInfo: Decodable {
        var temperature: Double?

        enum CodingKeys: String, CodingKey {
            case temperature = "temp"
        }
    }

    struct SunsetSunriseInfo: Decodable {
        var sunriseTime: Date?
        var sunsetTime: Date?

        enum CodingKeys: String, CodingKey {
            case sunriseTime = "sunrise"
            case sunsetTime = "sunset"
        }
    }
}