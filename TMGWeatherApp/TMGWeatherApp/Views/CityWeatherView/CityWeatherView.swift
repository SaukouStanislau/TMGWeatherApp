//
//  CityWeatherView.swift
//  TMGWeatherApp
//
//  Created by Stanislau Saukou on 27.03.24.
//

import SwiftUI
import Kingfisher

struct CityWeatherView: View {
    @ObservedObject var cityWeather: CityWeatherViewModel

    @State var refreshImageOpacity: CGFloat = .zero
    @State var refreshImageScale: CGFloat = .zero
    @State var refreshImageRotation: CGFloat = .zero

    var body: some View {
        ZStack {
            gradientBackground.ignoresSafeArea()
            VStack {
                cityName
                temperature
                weatherStatusImage
                Spacer()
                temperatureUnitPicker
            }
            refreshView
        }.gesture(DragGesture().onChanged(onDragChanged).onEnded(onDragEnded))
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

// MARK: - Private

private extension CityWeatherView {
    var cityName: some View {
        Text(cityWeather.city).font(.title).padding()
    }

    var temperature: some View {
        Text(cityWeather.formattedTemperature).font(.largeTitle).padding()
    }

    @ViewBuilder
    var weatherStatusImage: some View {
        if let iconImageURL = cityWeather.weatherStatusIconImageURL {
            KFImage(iconImageURL)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: CityWeatherView.Constants.weatherStatusImageSize.height)
        }
    }

    var temperatureUnitPicker: some View {
        Menu {
            Picker("Select temperature unit", selection: $cityWeather.temperatureUnit) {
                ForEach(TemperatureUnit.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
        } label: {
            Text("\(cityWeather.temperatureUnit.rawValue) ⇳")
                .foregroundStyle(.red)
                .font(.largeTitle)
        }    }

    var gradientBackground: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.blue, Color.lightBlue]),
            startPoint: .top,
            endPoint: .bottom
        )
    }

    @ViewBuilder
    var refreshView: some View {
        if cityWeather.isRefreshing {
            progressView
        } else {
            refreshImage
        }
    }

    var progressView: some View {
        ProgressView()
            .controlSize(.large)
    }

    var refreshImage: some View {
        Image(systemName: "arrow.clockwise")
            .opacity(refreshImageOpacity)
            .rotationEffect(Angle(degrees: refreshImageRotation))
            .scaleEffect(CGSize(width: refreshImageScale, height: refreshImageScale))
    }

    func onDragChanged(value: DragGesture.Value) {
        if value.translation.height > 0 {
            refreshImageOpacity += CityWeatherView.Constants.refreshImageOpacityOnDragDelta
            refreshImageScale += CityWeatherView.Constants.refreshImageScaleOnDragDelta
            refreshImageRotation += CityWeatherView.Constants.refreshImageRotationOnDragDelta
        }
    }

    func onDragEnded(value: DragGesture.Value) {
        withAnimation {
            refreshImageOpacity = .zero
            refreshImageScale = .zero
            refreshImageRotation = .zero
            cityWeather.didTriggerNeedToRefresh()
        }
    }
}

// MARK: - Constants

private extension CityWeatherView {
    struct Constants {
        static let weatherStatusImageSize: CGSize = CGSize(width: 200.0, height: 200.0)

        // Constants to animate refresh image on dragging

        static let refreshImageOpacityOnDragDelta: Double = 0.1
        static let refreshImageScaleOnDragDelta: Double = 0.1
        static let refreshImageRotationOnDragDelta: Double = 1
    }
}

#Preview {
    let cityWeather = CityWeatherViewModel(
        city: "Warsaw",
        weatherInfo: WeatherInfo.previewWeatherInfo, 
        weatherService: OpenMapFetchWeatherInfoService(), 
        weatherIconsService: OpenMapWeatherIconsService()
    )
    return CityWeatherView(cityWeather: cityWeather)
}
