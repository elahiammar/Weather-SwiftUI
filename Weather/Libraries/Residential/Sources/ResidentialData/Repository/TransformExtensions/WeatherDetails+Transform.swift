import Foundation
import ResidentialDomain

extension WeatherDetails {
    init(weather: WeatherResponse) {
        self = WeatherDetails.data(
            .init(
                uv: String(weather.current.uv),
                imageUrl: URL(string: "https:" + weather.current.condition.icon),
                cityName: weather.location.name,
                humidity: "\(weather.current.humidity)%",
                feelsLike: "\(weather.current.feelslike_c)°",
                temperature: "\(weather.current.temp_c)°"
            )
        )
    }
}

