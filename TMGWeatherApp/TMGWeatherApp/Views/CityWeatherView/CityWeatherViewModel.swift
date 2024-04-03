//
//  CityWeatherViewModel.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import Foundation
import Combine

final class CityWeatherViewModel: ObservableObject {
    private let weatherService: FetchWeatherInfoServiceInterface
    private let weatherIconsService: WeatherIconsService

    private var cancellables: Set<AnyCancellable> = []

    @Published private var weatherInfo: WeatherInfo
    @Published var temperatureUnit: TemperatureUnit = .celsius
    @Published var isRefreshing: Bool = false

    init(
        weatherInfo: WeatherInfo,
        weatherService: FetchWeatherInfoServiceInterface,
        weatherIconsService: WeatherIconsService
    ) {
        self.weatherInfo = weatherInfo
        self.weatherService = weatherService
        self.weatherIconsService = weatherIconsService
    }

    var cityName: String {
        weatherInfo.locationName ?? ""
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

    var sunriseTime: String {
        DateToTimeFormatter.readableTime(date: weatherInfo.sunsetSunrise?.sunriseTime) ?? ""
    }

    var sunsetTime: String {
        DateToTimeFormatter.readableTime(date: weatherInfo.sunsetSunrise?.sunsetTime) ?? ""
    }

    // MARK: - Intents

    func didTriggerNeedToRefresh() {
        isRefreshing = true
        self.weatherService.getWeatherInfoForCity(cityName)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] _ in
                self?.isRefreshing = false
            }, receiveValue: { [weak self] weatherInfo in
                self?.weatherInfo = weatherInfo
                self?.isRefreshing = false
            })
            .store(in: &self.cancellables)
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
