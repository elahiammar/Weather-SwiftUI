import Foundation
import ResidentialDomain

extension WeatherUiModel {
    init(weather: Weather) {
        self = .init(
            uv: weather.uv,
            imageUrl: weather.imageUrl,
            cityName: weather.cityName,
            humidity: weather.humidity,
            feelsLike: weather.feelsLike,
            temperature: weather.temperature
        )
    }
}

