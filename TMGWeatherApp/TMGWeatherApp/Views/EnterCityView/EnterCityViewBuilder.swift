//
//  EnterCityViewBuilder.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 16.04.24.
//

struct EnterCityViewBuilder {
    static var enterCityView: EnterCityView {
        let viewModel = EnterCityViewModel(weatherService: ServiceAssembly.fetchWeatherInfoService)
        return EnterCityView(viewModel: viewModel)
    }
}
