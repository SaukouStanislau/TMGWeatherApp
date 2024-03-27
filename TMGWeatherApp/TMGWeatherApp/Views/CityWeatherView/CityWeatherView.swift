//
//  CityWeatherView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import SwiftUI

struct CityWeatherView: View {
    let cityWeather: CityWeatherViewModel

    var body: some View {
        ShortCityWeatherView(cityWeather: cityWeather)
            .navigationBarTitle(cityWeather.city, displayMode: .inline)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}
