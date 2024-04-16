//
//  FavouriteButtonViewBuilder.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 16.04.24.
//

struct FavouriteButtonViewBuilder {
    static func favouriteButton(for cityName: String) -> FavouriteButtonView {
        let viewModel: FavouriteButtonViewModel = FavouriteButtonViewModel(
            cityName: cityName,
            fetchFavouritesService: ServiceAssembly.fetchFavouritesService
        )
        return FavouriteButtonView(viewModel: viewModel)
    }
}
