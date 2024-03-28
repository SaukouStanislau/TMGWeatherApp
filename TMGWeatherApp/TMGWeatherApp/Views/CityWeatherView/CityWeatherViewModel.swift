//
//  CityWeatherViewModel.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import Foundation

struct CityWeatherViewModel {
    let city: String
    private let weatherInfo: WeatherInfo
    private let weatherIconsService: WeatherIconsService

    init(city: String, weatherInfo: WeatherInfo, weatherIconsService: WeatherIconsService) {
        self.city = city
        self.weatherInfo = weatherInfo
        self.weatherIconsService = weatherIconsService
    }

    var formattedTemperatureInCelsius: String {
        guard let temperature = weatherInfo.temperatureInfo?.temperature else {
            return ""
        }

        let roundedTemperature = TemperatureConverter.convertKelvinToCelcius(kelvin: temperature).rounded(.toNearestOrAwayFromZero)
        return String("\(Int(roundedTemperature))°C")
    }

    var weatherStatusIconImageURL: URL? {
        guard 
            let weatherStatus = weatherInfo.weather?.first,
            let stringURL = weatherIconsService.getIconStringURLForWeatherStatus(weatherStatus)
        else {
            return nil
        }

        return URL(string: stringURL)
    }
}
