//
//  FavouriteButtonViewModel.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 11.04.24.
//

import Foundation
import Combine

enum FavouriteProcessingState {
    case processing
    case favourite(Bool)
}

final class FavouriteButtonViewModel: ObservableObject {
    private let cityName: String
    private let fetchFavouritesService: FetchFavouritesServiceInterface

    private let operationDelay: DispatchQueue.SchedulerTimeType.Stride = 1.0

    @Published var favouriteProcessingState: FavouriteProcessingState = .processing
    private var cancellables: Set<AnyCancellable> = []

    init(
        cityName: String,
        fetchFavouritesService: FetchFavouritesServiceInterface
    ) {
        self.cityName = cityName
        self.fetchFavouritesService = fetchFavouritesService
        checkFavourite()
    }

    // MARK: - Intents

    func didTriggerButton() {
        switch favouriteProcessingState {
        case .processing:
            break
        case let .favourite(favourite):
            if favourite {
                processRemoveFromFavourites()
            } else {
                processAddToFavourites()
            }
        }
    }
}

// MARK: - Private API

private extension FavouriteButtonViewModel {
    func checkFavourite() {
        favouriteProcessingState = .processing
        // delay added to demonstrate work
        fetchFavouritesService.checkIfFavourite(cityName: cityName)
            .delay(for: operationDelay, scheduler: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] favourite in
                self?.favouriteProcessingState = .favourite(favourite)
            })
            .store(in: &self.cancellables)
    }

    func processRemoveFromFavourites() {
        favouriteProcessingState = .processing
        fetchFavouritesService.removeFromFavourites(cityName: cityName)
            .delay(for: operationDelay, scheduler: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] in
                self?.favouriteProcessingState = .favourite(false)
            })
            .store(in: &self.cancellables)
    }

    func processAddToFavourites() {
        favouriteProcessingState = .processing
        fetchFavouritesService.addToFavourites(cityName: cityName)
            .delay(for: operationDelay, scheduler: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] in
                self?.favouriteProcessingState = .favourite(true)
            })
            .store(in: &self.cancellables)
    }
}
