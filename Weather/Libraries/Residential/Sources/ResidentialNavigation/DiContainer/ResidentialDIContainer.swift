import ResidentialDomain

public final class ResidentialDIContainer {
    public private(set) lazy var weatherRepository: WeatherRepositoryProtocol = Factory.makeWeatherRepository()

    public init() { }
}
