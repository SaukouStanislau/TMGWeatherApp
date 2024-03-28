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

    @State var refreshImageOpacity: CGFloat = 0.0
    @State var refreshImageScale: CGFloat = 1.0
    @State var refreshImageRotation: CGFloat = 1.0

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

private extension CityWeatherView {
    static let weatherStatusImageSize: CGSize = CGSize(width: 200.0, height: 200.0)

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
                .frame(height: CityWeatherView.weatherStatusImageSize.height)
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
            withAnimation {
                refreshImageOpacity += 0.1
                refreshImageScale += 0.1
                refreshImageRotation += 1
            }
        }
    }

    func onDragEnded(value: DragGesture.Value) {
        withAnimation {
            refreshImageOpacity = 0.0
            refreshImageScale = 1.0
            refreshImageRotation = 0.0
            cityWeather.didTriggerNeedToRefresh()
        }
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
