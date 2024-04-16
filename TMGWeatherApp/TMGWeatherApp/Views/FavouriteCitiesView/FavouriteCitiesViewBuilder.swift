//
//  FavouriteCitiesViewBuilder.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 16.04.24.
//

struct FavouriteCitiesViewBuilder {
    static var favouriteCitiesView: FavouriteCitiesView {
        let viewModel: FavouriteCitiesViewModel = FavouriteCitiesViewModel(
            fetchFavouritesService: ServiceAssembly.fetchFavouritesService,
            fetchWeatherService: ServiceAssembly.fetchWeatherInfoService
        )
        return FavouriteCitiesView(viewModel: viewModel)
    }
}
