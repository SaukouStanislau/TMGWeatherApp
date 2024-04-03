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
    var locationName: String?

    enum CodingKeys: String, CodingKey {
        case weather
        case temperatureInfo = "main"
        case sunsetSunrise = "sys"
        case locationName = "name"
    }
}

extension WeatherInfo {
    struct WeatherStatus: Decodable {
        enum Status: String, Decodable {
            case thunderstorm = "Thunderstorm"
            case drizzle = "Drizzle"
            case rain = "Rain"
            case snow = "Snow"

            case mist = "Mist"
            case smoke = "Smoke"
            case haze = "Haze"
            case dust = "sand/dust whirls"
            case fog = "Fog"
            case sand = "Sand"
            case ash = "Ash"
            case squall = "Squall"
            case tornado = "Tornado"

            case clear = "Clear"
            case clouds = "Clouds"
        }

        var status: Status?
        var description: String?
        var icon: String?

        enum CodingKeys: String, CodingKey {
            case status = "main"
            case description
            case icon
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

extension WeatherInfo {
    static var previewWeatherInfo: WeatherInfo {
        WeatherInfo(
            weather: [WeatherStatus(status: .clear, description: "clear sky", icon: "01d")],
            temperatureInfo: TemperatureInfo(temperature: 289.72),
            sunsetSunrise: SunsetSunriseInfo(sunriseTime: Date(), sunsetTime: Date())
        )
    }
}
