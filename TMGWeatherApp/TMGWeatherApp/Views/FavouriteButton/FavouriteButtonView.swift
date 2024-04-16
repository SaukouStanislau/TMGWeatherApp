//
//  FavouriteButtonView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 8.04.24.
//

import SwiftUI

struct FavouriteButtonView: View {
    @ObservedObject var viewModel: FavouriteButtonViewModel

    var body: some View {
        Button(action: {
            viewModel.didTriggerButton()
        }, label: {
            switch viewModel.favouriteProcessingState {
            case .processing:
                progressView
            case let .favourite(favourite):
                starView(filled: favourite)
            }
        })
    }

    private var progressView: some View {
        ProgressView()
    }

    private func starView(filled: Bool) -> some View {
        filled ? Image(systemName: "star.fill") : Image(systemName: "star")
    }
}

#Preview {
    FavouriteButtonViewBuilder.favouriteButton(for: "Minsk")
}
