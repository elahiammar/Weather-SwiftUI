import Foundation
import ResidentialDomain

public class WeatherRepository: WeatherRepositoryProtocol {
    private let persistentStorage: UserDefaults
    private let weatherService: WeatherServiceProtocol
    
    
    public init(
        weatherService: WeatherServiceProtocol,
        persistentStorage: UserDefaults = UserDefaults.standard
    ) {
        self.weatherService = weatherService
        self.persistentStorage = persistentStorage
    }
    
    public func saveWeather(location: String) {
        persistentStorage.set(location, forKey: "Location")
    }
    
    public func fetchPersistedWeather() async throws -> WeatherDetails {
        if let location = persistentStorage.object(forKey: "Location") as? String {
            return try await fetchWeatherDetails(location: location)
        }
        return WeatherDetails.emptyState
    }
    
    public func fetchWeatherDetails(location: String) async throws -> WeatherDetails {
        let response = try await weatherService.fetchWeather(location: location)
        return WeatherDetails(weather: response)
    }
}
