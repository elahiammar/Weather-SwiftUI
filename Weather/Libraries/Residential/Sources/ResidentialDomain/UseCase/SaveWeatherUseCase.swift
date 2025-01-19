public class SaveWeatherUseCase: UseCase {
    private let repository: WeatherRepositoryProtocol

    public init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(with input: String)   {
        repository.saveWeather(location: input)
    }
}
