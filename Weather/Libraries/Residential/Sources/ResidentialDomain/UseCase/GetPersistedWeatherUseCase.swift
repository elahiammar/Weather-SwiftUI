public class GetPersistedWeatherUseCase: UseCase {
    private let repository: WeatherRepositoryProtocol

    public init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(with input: Void) async throws -> WeatherDetails {
        try await repository.fetchPersistedWeather()
    }
}
