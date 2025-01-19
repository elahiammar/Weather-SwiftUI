public class GetWeatherDetailsUseCase: UseCase {
    private let repository: WeatherRepositoryProtocol

    public init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(with input: String) async throws -> WeatherDetails {
        try await repository.fetchWeatherDetails(location: input)
    }
}
