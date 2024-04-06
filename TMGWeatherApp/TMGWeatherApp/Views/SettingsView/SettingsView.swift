//
//  SettingsView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 4.04.24.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var model: SettingsViewModel

    var body: some View {
        Form {
            GenericPickerView(choosedValue: $model.choosedTemperature, title: "Temperature", values: TemperatureUnit.allCases)
        }
        .navigationBarTitle("Settings", displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    let model = SettingsViewModel(settingsStorage: SettingsStorage())
    return SettingsView(model: model)
}
