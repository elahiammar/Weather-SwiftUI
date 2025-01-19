import Foundation

public struct WeatherUiModel {
    public let uv: String
    public let imageUrl: URL?
    public let humidity: String
    public let cityName: String
    public let feelsLike: String
    public let temperature: String

    public init(
        uv: String,
        imageUrl: URL?,
        cityName: String,
        humidity: String,
        feelsLike: String,
        temperature: String
    ) {
        self.uv = uv
        self.imageUrl = imageUrl
        self.cityName = cityName
        self.humidity = humidity
        self.feelsLike = feelsLike
        self.temperature = temperature
    }
}
