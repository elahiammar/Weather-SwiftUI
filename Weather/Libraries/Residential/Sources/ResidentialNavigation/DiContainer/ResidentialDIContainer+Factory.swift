import Foundation
import ResidentialData


extension ResidentialDIContainer {
    enum Factory {
        static func makeWeatherRepository() -> WeatherRepository {
            let session: URLSession = {
                let sessionConfiguration = URLSessionConfiguration.default
                return URLSession(configuration: sessionConfiguration)
            }()
            let httpClient = NetworkClient(
                decoder: JSONDecoder(),
                encoder: JSONEncoder(), 
                session: session
            )
            let weatherService = WeatherService(
                httpClient: httpClient
            )
            return WeatherRepository(weatherService: weatherService)
        }
    }
}
