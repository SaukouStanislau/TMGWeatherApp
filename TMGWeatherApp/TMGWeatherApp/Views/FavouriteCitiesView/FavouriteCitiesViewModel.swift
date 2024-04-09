//
//  FavouriteCitiesViewModel.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 9.04.24.
//

import Foundation
import Combine

final class FavouriteCitiesViewModel: ObservableObject {
    private let fetchFavouritesService: FetchFavouritesServiceInterface
    private let fetchWeatherService: FetchWeatherInfoServiceInterface

    private var cancellables: Set<AnyCancellable> = []

    @Published var citiesWeather: [String: WeatherInfo] = [:]

    init(fetchFavouritesService: FetchFavouritesServiceInterface, fetchWeatherService: FetchWeatherInfoServiceInterface) {
        self.fetchFavouritesService = fetchFavouritesService
        self.fetchWeatherService = fetchWeatherService
    }

    // MARK: - Intents

    func viewDidTriggerAppear() {
        fetchFavouriteCities()
    }
}

// MARK: - Private API

private extension FavouriteCitiesViewModel {
    func fetchFavouriteCities() {
        fetchFavouritesService.fetchFavouriteCities()
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] favouriteCitiesNames in
                self?.fetchWeatherFor(cities: favouriteCitiesNames)
            })
            .store(in: &self.cancellables)
    }

    func fetchWeatherFor(cities: [String]) {
        cities.forEach { city in
            fetchWeatherService.getWeatherInfoForCity(city)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { _ in
                }, receiveValue: { [weak self] weatherInfo in
                    self?.citiesWeather[city] = weatherInfo
                })
                .store(in: &self.cancellables)
        }
    }
}
