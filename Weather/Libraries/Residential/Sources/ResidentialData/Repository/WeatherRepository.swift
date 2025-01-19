import ResidentialDomain

public class WeatherRepository: WeatherRepositoryProtocol {
    private let weatherService: WeatherServiceProtocol

    public init(
        weatherService: WeatherServiceProtocol
    ) {
        self.weatherService = weatherService
    }
    
    public func fetchWeatherDetails(location: String) async throws -> WeatherDetails {
        let response = try await weatherService.fetchWeather(location: location)
        return WeatherDetails(weather: response)
    }
}
