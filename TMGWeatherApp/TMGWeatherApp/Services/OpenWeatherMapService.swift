//
//  OpenWeatherMapService.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import Foundation
import Combine

enum Endpoint: String {
    case flights
    case details
}

final class OpenWeatherMapService {
    private var cancellables = Set<AnyCancellable>()

    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    private let appID = "91fcbc3ce738aa384ab12f50ccb1f780"

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
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { promise(.success($0)) })
                .store(in: &self.cancellables)
        }
    }

    private func getWeatherURLWithComponentsForCity(_ city: String) -> URL? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }

        let parameters = [
            "q": city,
            "appid": appID
        ]

        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return urlComponents.url
    }
}


enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}
