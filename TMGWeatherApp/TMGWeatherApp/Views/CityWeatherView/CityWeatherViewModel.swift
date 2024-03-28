//
//  CityWeatherViewModel.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import Foundation

final class CityWeatherViewModel: ObservableObject {
    let city: String
    private let weatherInfo: WeatherInfo
    private let weatherIconsService: WeatherIconsService

    @Published var temperatureUnit: TemperatureUnit = .celsius

    init(city: String, weatherInfo: WeatherInfo, weatherIconsService: WeatherIconsService) {
        self.city = city
        self.weatherInfo = weatherInfo
        self.weatherIconsService = weatherIconsService
    }

    var formattedTemperature: String {
        switch temperatureUnit {
        case .celsius:
            formattedTemperatureInCelsius
        case .fahrenheit:
            formattedTemperatureInFahrenheit
        }
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

// MARK: - Private

private extension CityWeatherViewModel {
    var formattedTemperatureInFahrenheit: String {
        guard let temperature = weatherInfo.temperatureInfo?.temperature else {
            return ""
        }

        let roundedTemperature = TemperatureConverter.convertKelvinToFahrenheit(kelvin: temperature).rounded(.toNearestOrAwayFromZero)
        return String("\(Int(roundedTemperature))°F")
    }

    var formattedTemperatureInCelsius: String {
        guard let temperature = weatherInfo.temperatureInfo?.temperature else {
            return ""
        }

        let roundedTemperature = TemperatureConverter.convertKelvinToCelcius(kelvin: temperature).rounded(.toNearestOrAwayFromZero)
        return String("\(Int(roundedTemperature))°C")
    }
}
