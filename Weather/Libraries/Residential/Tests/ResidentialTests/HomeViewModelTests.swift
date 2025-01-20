@testable import ResidentialDomain
@testable import ResidentialData
@testable import ResidentialUI
import XCTest

class HomeViewModelTests: XCTestCase {
    private var sut: HomeViewModel!
    private var weatherRepositoryMock: WeatherRepositoryMock!
    
    override func setUpWithError() throws {
        weatherRepositoryMock = .init()
    }

    override func tearDownWithError() throws {
        sut = nil
        weatherRepositoryMock = nil
    }
    
    @MainActor
    func test_savedWeatherLocation_whenOnAppear_thenPublishExpectedDomainModel() async throws {
        // Given
        sut = createViewModel()
        
        let expectedOutput = WeatherDetails.data(.init(
            uv: "8.3",
            imageUrl: URL(string: "https:URL"),
            cityName: "City",
            humidity: "10%",
            feelsLike: "12.1°",
            temperature: "11.2°"
        ))
        
        weatherRepositoryMock.input = .init(
            location: .init(name: "City"),
            current: .init(
                temp_c: 11.2,
                feelslike_c: 12.1,
                humidity: 10,
                uv: 8.3,
                condition: .init(
                    icon: "URL"
                )
            )
        )
        
        // When
        sut.onWeatherSelected(location: "City")
        
        await sut.onAppear()
        
        // Then
        XCTAssertEqual(sut.weatherDetails, expectedOutput)
    }
    
    @MainActor
    func test_onSavedWeatherLocation_returnSuccess() async throws {
        // Given
        sut = createViewModel()

        // When
        sut.onWeatherSelected(location: "City")
        
        // Then
        XCTAssertTrue(sut.weatherSelected)
    }
    
    @MainActor
    func test_onSeachWeatherLocation_thenPublishExpectedDomainModel() async throws {
        // Given
        sut = createViewModel()
        
        let expectedOutput = WeatherDetails.data(.init(
            uv: "2.3",
            imageUrl: URL(string: "https:URL"),
            cityName: "City",
            humidity: "4%",
            feelsLike: "2.1°",
            temperature: "1.2°"
        ))
        
        weatherRepositoryMock.input = .init(
            location: .init(name: "City"),
            current: .init(
                temp_c: 1.2,
                feelslike_c: 2.1,
                humidity: 4,
                uv: 2.3,
                condition: .init(
                    icon: "URL"
                )
            )
        )
        
        // When
        await sut.onSearchWeather("City")
        
        // Then
        XCTAssertEqual(sut.weatherDetails, expectedOutput)
    }
    
    private func createViewModel() -> HomeViewModel {
        .init(
            saveWeatherUseCase: .init(repository: weatherRepositoryMock),
            getWeatherDetailsUseCase: .init(repository: weatherRepositoryMock),
            getPersistedWeatherUseCase: .init(repository: weatherRepositoryMock)
        )
    }
}

private final class WeatherRepositoryMock: WeatherRepositoryProtocol {
    var input: WeatherResponse!
    
    func saveWeather(location: String) {}
    
    func fetchPersistedWeather() async throws -> WeatherDetails {
        .init(weather: input)
    }
    
    func fetchWeatherDetails(location: String) async throws -> WeatherDetails {
        .init(weather: input)
    }
}
