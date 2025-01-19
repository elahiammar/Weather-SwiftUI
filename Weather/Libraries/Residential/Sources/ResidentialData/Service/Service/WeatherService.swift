
public protocol WeatherServiceProtocol {
    func fetchWeather(location: String) async throws -> WeatherResponse
}

public class WeatherService: WeatherServiceProtocol {
    private let httpClient: HttpClientProtocol

    public init(httpClient: HttpClientProtocol) {
        self.httpClient = httpClient
    }

    public func fetchWeather(location: String) async throws -> WeatherResponse {
        let request = WeatherEndpoint.urlRequest(location)
        return try await httpClient.execute(request)
    }
}
