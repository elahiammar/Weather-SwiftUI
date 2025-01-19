public protocol WeatherRepositoryProtocol {
    func saveWeather(location: String) 
    func fetchPersistedWeather() async throws -> WeatherDetails
    func fetchWeatherDetails(location: String) async throws -> WeatherDetails
}
