//
//  ServiceAssembly.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 16.04.24.
//

struct ServiceAssembly {
    static var fetchFavouritesService: FetchFavouritesServiceInterface {
        FetchFavouritesService(favouriteStorage: FavouriteStorage())
    }

    static var fetchWeatherInfoService: FetchWeatherInfoServiceInterface {
        OpenMapFetchWeatherInfoService()
    }

    static var weatherIconsService: WeatherIconsServiceInterface {
        OpenMapWeatherIconsService()
    }
}
