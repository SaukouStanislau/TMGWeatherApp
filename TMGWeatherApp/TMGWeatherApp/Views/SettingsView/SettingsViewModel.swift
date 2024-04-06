//
//  SettingsViewModel.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 4.04.24.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    private var settingsStorage: SettingsStorageInterface

    @Published var choosedTemperature: TemperatureUnit {
        didSet {
            settingsStorage.set(preferedTemperature: choosedTemperature)
        }
    }

    init(settingsStorage: SettingsStorageInterface) {
        self.settingsStorage = settingsStorage
        choosedTemperature = settingsStorage.preferedTemperature
    }
}
