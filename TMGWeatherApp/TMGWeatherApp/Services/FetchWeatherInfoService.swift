//
//  FetchWeatherInfoService.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import Foundation
import Combine

protocol FetchWeatherInfoServiceInterface {
    func getWeatherInfoForCity(_ city: String) -> Future<WeatherInfo, Error>
}

final class OpenWeatherMapService: FetchWeatherInfoServiceInterface {
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    private let appIDQuerryParameter = ["appid": "91fcbc3ce738aa384ab12f50ccb1f780"]

    private var cancellables = Set<AnyCancellable>()

    func getWeatherInfoForCity(_ city: String) -> Future<WeatherInfo, Error> {
        Future<WeatherInfo, Error> { [weak self] promise in
            guard let self = self, let urlWithComponents = getWeatherURLWithComponentsForCity(city) else {
                return promise(.failure(NetworkError.invalidURL))
            }

            debugPrint("URL is \(urlWithComponents.absoluteString)")
            URLSession.shared.dataTaskPublisher(for: urlWithComponents)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }

                    return data
                }
                .decode(type: WeatherInfo.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        case let urlError as URLError where urlError.code == .notConnectedToInternet:
                            promise(.failure(NetworkError.noInternet))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { promise(.success($0)) })
                .store(in: &self.cancellables)
        }
    }
}

// MARK: - Private API

private extension OpenWeatherMapService {
    func getWeatherURLWithComponentsForCity(_ city: String) -> URL? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }

        let queryParameters = queryParametersToFetchWeather(for: city)
        urlComponents.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return urlComponents.url
    }

    func queryParametersToFetchWeather(for city: String) -> [String: String] {
        ["q": city].merging(appIDQuerryParameter, uniquingKeysWith: +)
    }
}
