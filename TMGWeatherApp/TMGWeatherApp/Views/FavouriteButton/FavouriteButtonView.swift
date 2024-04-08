//
//  FavouriteButtonView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 8.04.24.
//

import SwiftUI

enum FavouriteProcessingState {
    case processing
    case favourite(Bool)
}

struct FavouriteButtonView: View {
    @Binding var state: FavouriteProcessingState
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }, label: {
            switch state {
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

struct FavouriteButtonViewPreviewContainer: View {
    @State private var favourite: Bool = false
    @State private var state: FavouriteProcessingState = .favourite(false)

    var body: some View {
        FavouriteButtonView(state: $state, action: {
            state = .processing
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                favourite.toggle()
                state = .favourite(favourite)
            })
        })
    }
}

#Preview {
    FavouriteButtonViewPreviewContainer()
}
