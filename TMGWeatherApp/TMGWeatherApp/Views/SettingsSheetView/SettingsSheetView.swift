//
//  SettingsSheetView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 4.04.24.
//

import SwiftUI

struct SettingsSheetView: View {
    @ObservedObject var model: SettingsSheetViewModel = SettingsSheetViewModel()

    var body: some View {
        Text("Settings")
    }
}
