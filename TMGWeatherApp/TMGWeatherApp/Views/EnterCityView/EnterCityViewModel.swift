//
//  EnterCityViewModel.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import Combine

final class EnterCityViewModel: ObservableObject {
    private let weatherService: OpenWeatherMapService
    private var cancellables: Set<AnyCancellable> = []

    @Published var cityWeather: CityWeatherViewModel?

    init(weatherService: OpenWeatherMapService) {
        self.weatherService = weatherService
    }

    // MARK: - Intents

    func didTriggerChangeCity(_ newCity: String) {
        startFetchingWeatherInfo(for: "Warsaw")
    }
}

// MARK: - Private API

private extension EnterCityViewModel {
    func startFetchingWeatherInfo(for city: String) {
        weatherService.getWeatherInfoForCity(city)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    switch error {
                    case let decodingError as DecodingError:
                        debugPrint("DecodingError")
//                        promise(.failure(decodingError))
                    case let apiError as NetworkError:
                        debugPrint("NetworkError")
//                        promise(.failure(apiError))
                    default:
                        debugPrint("unknown")
//                        promise(.failure(NetworkError.unknown))
                    }
                }
            }, receiveValue: { [weak self] weatherInfo in
                self?.cityWeather = CityWeatherViewModel(city: city, weatherInfo: weatherInfo)
            })
            .store(in: &cancellables)
    }
}
