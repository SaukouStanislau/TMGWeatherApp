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
    }

    private let weatherService: FetchWeatherInfoServiceInterface
    private var cancellables: Set<AnyCancellable> = []

    @Published var status: EnterCityFetchingStatus?

    init(weatherService: OpenWeatherMapService) {
        self.weatherService = weatherService
    }

    // MARK: - Intents

    func didTriggerChangeCity(_ newCity: String) {
        cancelFetching()
        startFetchingWeatherInfo(for: newCity)
    }
}

// MARK: - Private API

private extension EnterCityViewModel {
    func cancelFetching() {
        cancellables.forEach { $0.cancel() }
    }

    func startFetchingWeatherInfo(for city: String) {
        weatherService.getWeatherInfoForCity(city)
            .delay(for: .seconds(1), scheduler: DispatchQueue.global(qos: .userInitiated))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.handleError(error)
                }
            }, receiveValue: { [weak self] weatherInfo in
                self?.status = .fetched(cityWeather: CityWeatherViewModel(city: city, weatherInfo: weatherInfo))
            })
            .store(in: &cancellables)
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
