//
//  SettingsView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 4.04.24.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel

    var body: some View {
        Form {
            GenericPickerView(choosedValue: $viewModel.choosedTemperature, title: "Temperature", values: TemperatureUnit.allCases)
        }
        .navigationBarTitle("Settings", displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    SettingsViewBuilder.settingsView
}
