//
//  FetchFavouritesService.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 8.04.24.
//

import Combine

protocol FetchFavouritesServiceInterface {
    func checkIfFavourite(cityName: String) -> Future<Bool, Error>
    func fetchFavouriteCities() -> Future<[String], Error>
    func addToFavourites(cityName: String) -> Future<Void, Error>
    func removeFromFavourites(cityName: String) -> Future<Void, Error>
}

enum FetchFavouritesServiceError: Error {
    case unknown
}

final class FetchFavouritesService {
    let favouriteStorage: FavouriteStorageInterface

    private var cancellables = Set<AnyCancellable>()

    init(favouriteStorage: FavouriteStorageInterface) {
        self.favouriteStorage = favouriteStorage
    }
}

// MARK: - FavouritesFetchServiceInterface

extension FetchFavouritesService: FetchFavouritesServiceInterface {
    func checkIfFavourite(cityName: String) -> Future<Bool, Error> {
        Future<Bool, Error> { [weak self] promise in
            guard let self = self else {
                return promise(.failure(FetchFavouritesServiceError.unknown))
            }

            let favouriteCitiesNames: Result<[String], Never> = .success(self.favouriteStorage.favouriteCitiesNames)
            favouriteCitiesNames
                .publisher
                .sink(receiveValue: { promise(.success($0.contains(cityName))) })
                .store(in: &self.cancellables)
        }
    }

    func fetchFavouriteCities() -> Future<[String], Error> {
        Future<[String], Error> { [weak self] promise in
            guard let self = self else {
                return promise(.failure(FetchFavouritesServiceError.unknown))
            }

            let favouriteCitiesNames: Result<[String], Never> = .success(self.favouriteStorage.favouriteCitiesNames)
            favouriteCitiesNames
                .publisher
                .sink(receiveValue: { promise(.success($0)) })
                .store(in: &self.cancellables)
        }
    }

    func addToFavourites(cityName: String) -> Future<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            guard let self = self else {
                return promise(.failure(FetchFavouritesServiceError.unknown))
            }

            let addFavouriteCityName: Result<Void, Never> = .success(self.favouriteStorage.add(favouriteCityName: cityName))
            addFavouriteCityName
                .publisher
                .sink(receiveValue: { promise(.success($0)) })
                .store(in: &self.cancellables)
        }
    }

    func removeFromFavourites(cityName: String) -> Future<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            guard let self = self else {
                return promise(.failure(FetchFavouritesServiceError.unknown))
            }

            let removeFavouriteCityName: Result<Void, Never> = .success(self.favouriteStorage.remove(favouriteCityName: cityName))
            removeFavouriteCityName
                .publisher
                .sink(receiveValue: { promise(.success($0)) })
                .store(in: &self.cancellables)
        }
    }
}
