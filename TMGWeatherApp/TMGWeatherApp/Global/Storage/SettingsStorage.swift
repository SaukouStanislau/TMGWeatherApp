//
//  SettingsStorage.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 5.04.24.
//

enum SettingsOptions: String {
    case preferedTemperature = "Temperature"
}

protocol SettingsStorageInterface {
    var preferedTemperature: TemperatureUnit { get }
    mutating func set(preferedTemperature: TemperatureUnit)
}

final class SettingsStorage {
    private enum SettingsKeys: String {
        case temperature
    }

    @UDStorage(key: SettingsKeys.temperature.rawValue, defaultValue: TemperatureUnit.celsius)
    private var temperature: TemperatureUnit
}

// MARK: - SettingsStorageInterface

extension SettingsStorage: SettingsStorageInterface {
    var preferedTemperature: TemperatureUnit {
        temperature
    }

    func set(preferedTemperature: TemperatureUnit) {
        temperature = preferedTemperature
    }
}
 
