//
//  CityWeatherViewBuilder.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 16.04.24.
//

struct CityWeatherViewBuilder {
    static func cityWeatherView(for weatherInfo: WeatherInfo) -> CityWeatherView {
        let viewModel = CityWeatherViewModel(
            weatherInfo: weatherInfo,
            weatherService: ServiceAssembly.fetchWeatherInfoService,
            weatherIconsService: ServiceAssembly.weatherIconsService,
            settingsStorage: SettingsStorage()
        )
        return CityWeatherView(cityWeather: viewModel)
    }

    static func shortCityWeatherView(for weatherInfo: WeatherInfo) -> ShortCityWeatherView {
        let viewModel = CityWeatherViewModel(
            weatherInfo: weatherInfo,
            weatherService: ServiceAssembly.fetchWeatherInfoService,
            weatherIconsService: ServiceAssembly.weatherIconsService,
            settingsStorage: SettingsStorage()
        )
        return ShortCityWeatherView(cityWeather: viewModel)
    }
}
