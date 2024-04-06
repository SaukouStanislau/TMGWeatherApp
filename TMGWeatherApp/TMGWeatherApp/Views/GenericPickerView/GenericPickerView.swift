//
//  GenericPickerView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 5.04.24.
//

import SwiftUI

struct GenericPickerView<T>: View where T: Hashable, T: ShortNamed {
    @Binding var choosedValue: T

    let title: String
    let values: [T]

    var body: some View {
        HStack {
            Text(title)
            Color.clear
            Picker("What's your value", selection: $choosedValue) {
                ForEach(values, id: \.self) { value in
                    Text(value.shortName).tag(value)
                }
            }.pickerStyle(.segmented)
        }
    }
}
