//
//  FavouriteStorage.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 8.04.24.
//

protocol FavouriteStorageInterface {
    var favouriteCitiesNames: [String] { get }
    func add(favouriteCityName: String)
    func remove(favouriteCityName: String)
}

final class FavouriteStorage {
    private enum FavouriteKeys: String {
        case favouriteCities
    }

    @UDStorage(key: FavouriteKeys.favouriteCities.rawValue, defaultValue: [])
    private var favouriteCities: [String]
}

// MARK: - FavouritesStorageInterface

extension FavouriteStorage: FavouriteStorageInterface {
    var favouriteCitiesNames: [String] {
        favouriteCities
    }

    func add(favouriteCityName: String) {
        favouriteCities.append(favouriteCityName)
    }

    func remove(favouriteCityName: String) {
        favouriteCities = favouriteCities.filter { $0 != favouriteCityName }
    }
}
