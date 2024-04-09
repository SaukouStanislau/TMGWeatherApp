//
//  TimeWeatherBasedView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 2.04.24.
//

import SwiftUI

struct TimeWeatherBasedView: View {
    let viewModel: TimeWeatherBasedViewModel

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [viewModel.topColor, viewModel.bottomColor]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

#Preview {
    TimeWeatherBasedView(viewModel: TimeWeatherBasedViewModel(weatherInfo: WeatherInfo()))
}
