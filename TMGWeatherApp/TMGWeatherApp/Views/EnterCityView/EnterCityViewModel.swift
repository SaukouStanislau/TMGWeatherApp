//
//  EnterCityViewModel.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import Foundation
import Combine

final class EnterCityViewModel: ObservableObject {
    enum EnterCityFetchingStatus {
        case fetched(cityWeather: CityWeatherViewModel)
        case noInternet
        case noCity
        case unknownError
        case processing
    }

    private let weatherService: FetchWeatherInfoServiceInterface

    var weatherInfo: WeatherInfo?
    @Published var status: EnterCityFetchingStatus?

    private var enteredCity: String = ""
    private var cancellables: Set<AnyCancellable> = []

    init(weatherService: OpenMapFetchWeatherInfoService) {
        self.weatherService = weatherService
    }

    // MARK: - Intents

    func didTriggerChangeCity(_ newCity: String) {
        cancelFetching()
        enteredCity = newCity
        startFetchingWeatherInfo(for: newCity)
    }
}

// MARK: - Private API

private extension EnterCityViewModel {
    func cancelFetching() {
        cancellables.forEach { $0.cancel() }
    }

    func startFetchingWeatherInfo(for city: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [self] in
            guard city == enteredCity else {
                return
            }

            status = .processing
            self.weatherService.getWeatherInfoForCity(city)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    if case let .failure(error) = completion {
                        self?.handleError(error)
                    }
                }, receiveValue: { [weak self] weatherInfo in
                    self?.weatherInfo = weatherInfo
                    self?.status = .fetched(cityWeather: CityWeatherViewModel(
                        city: city,
                        weatherInfo: weatherInfo, 
                        weatherService: OpenMapFetchWeatherInfoService(),
                        weatherIconsService: OpenMapWeatherIconsService()
                    ))
                })
                .store(in: &self.cancellables)
        }
    }

    func handleError(_ error: Error) {
        switch error {
        case let networkError as FetchWeatherInfoServiceError where networkError == .noInternet:
            status = .noInternet
        case let networkError as FetchWeatherInfoServiceError where networkError == .wrongCityName:
            status = .noCity
        default:
            status = .unknownError
        }
    }
}
