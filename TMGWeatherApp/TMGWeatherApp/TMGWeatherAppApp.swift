//
//  TMGWeatherAppApp.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import SwiftUI

@main
struct TMGWeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            EnterCityView(model: EnterCityViewModel(weatherService: OpenMapFetchWeatherInfoService()))
        }
    }
}
