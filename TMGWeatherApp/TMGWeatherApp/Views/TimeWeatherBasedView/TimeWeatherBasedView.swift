//
//  TimeWeatherBasedView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 2.04.24.
//

import SwiftUI

struct TimeWeatherBasedView: View {
    let model: TimeWeatherBasedViewModel

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [model.topColor, model.bottomColor]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

#Preview {
    TimeWeatherBasedView(model: TimeWeatherBasedViewModel(weatherInfo: WeatherInfo()))
}
