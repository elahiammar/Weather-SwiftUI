import Foundation

public struct WeatherEndpoint {
    private static let apiKey = "3a47d0fb0f614e6da6a174845251701"
    
    public static func urlRequest(_ searchText: String) -> URLRequest {
        let url = URL(
            string: "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(searchText)"
        )
        let request = URLRequest(url: url!)
        return request
    }
}
