//
//  CityWeatherViewModel.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

struct CityWeatherViewModel {
    let city: String
    private let weatherInfo: WeatherInfo

    init(city: String, weatherInfo: WeatherInfo) {
        self.city = city
        self.weatherInfo = weatherInfo
    }

    var formattedTemperatureInCelsius: String {
        guard let temperature = weatherInfo.temperatureInfo?.temperature else {
            return ""
        }

        let roundedTemperature = TemperatureConverter.convertKelvinToCelcius(kelvin: temperature).rounded(.toNearestOrAwayFromZero)
        return String("\(Int(roundedTemperature))°C")
    }
}
