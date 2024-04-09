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
    private let settingsStorage: SettingsStorageInterface
    private let favouritesService: FetchFavouritesServiceInterface

    private var cancellables: Set<AnyCancellable> = []

    @Published var weatherInfo: WeatherInfo
    @Published var isRefreshing: Bool = false
    @Published var favouriteProcessingState: FavouriteProcessingState = .favourite(false)

    private let operationDelay: DispatchQueue.SchedulerTimeType.Stride = 1.0

    init(
        weatherInfo: WeatherInfo,
        weatherService: FetchWeatherInfoServiceInterface,
        weatherIconsService: WeatherIconsService,
        settingsStorage: SettingsStorageInterface,
        favouritesService: FetchFavouritesServiceInterface
    ) {
        self.weatherInfo = weatherInfo
        self.weatherService = weatherService
        self.weatherIconsService = weatherIconsService
        self.settingsStorage = settingsStorage
        self.favouritesService = favouritesService
        checkFavourite()
    }

    var cityName: String {
        weatherInfo.locationName ?? ""
    }

    var formattedTemperature: String {
        switch settingsStorage.preferedTemperature {
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

    func didTriggerFavouriteButton() {
        switch favouriteProcessingState {
        case .processing:
            break
        case let .favourite(favourite):
            if favourite {
                processRemoveFromFavourites()
            } else {
                processAddToFavourites()
            }
        }
    }
}

// MARK: - Private

private extension CityWeatherViewModel {
    func checkFavourite() {
        favouriteProcessingState = .processing
        // delay added to demonstrate work
        favouritesService.checkIfFavourite(cityName: cityName)
            .delay(for: operationDelay, scheduler: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] favourite in
                self?.favouriteProcessingState = .favourite(favourite)
            })
            .store(in: &self.cancellables)
    }

    func processRemoveFromFavourites() {
        favouriteProcessingState = .processing
        favouritesService.removeFromFavourites(cityName: cityName)
            .delay(for: operationDelay, scheduler: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] in
                self?.favouriteProcessingState = .favourite(false)
            })
            .store(in: &self.cancellables)
    }

    func processAddToFavourites() {
        favouriteProcessingState = .processing
        favouritesService.addToFavourites(cityName: cityName)
            .delay(for: operationDelay, scheduler: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] in
                self?.favouriteProcessingState = .favourite(true)
            })
            .store(in: &self.cancellables)
    }

    var formattedTemperatureInFahrenheit: String {
        guard let temperature = weatherInfo.temperatureInfo?.temperature else {
            return ""
        }

        let roundedTemperature = TemperatureConverter.convertKelvinToFahrenheit(kelvin: temperature).rounded(.toNearestOrAwayFromZero)
        return String("\(Int(roundedTemperature))\(TemperatureUnit.fahrenheit.shortName)")
    }

    var formattedTemperatureInCelsius: String {
        guard let temperature = weatherInfo.temperatureInfo?.temperature else {
            return ""
        }

        let roundedTemperature = TemperatureConverter.convertKelvinToCelcius(kelvin: temperature).rounded(.toNearestOrAwayFromZero)
        return String("\(Int(roundedTemperature))\(TemperatureUnit.celsius.shortName)")
    }
}
