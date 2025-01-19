public protocol WeatherRepositoryProtocol {
    func fetchWeatherDetails(location: String) async throws -> WeatherDetails
}
