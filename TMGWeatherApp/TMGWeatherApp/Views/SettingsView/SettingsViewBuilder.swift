//
//  SettingsViewBuilder.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 16.04.24.
//

struct SettingsViewBuilder {
    static var settingsView: SettingsView {
        let viewModel = SettingsViewModel(settingsStorage: SettingsStorage())
        return SettingsView(viewModel: viewModel)
    }
}
