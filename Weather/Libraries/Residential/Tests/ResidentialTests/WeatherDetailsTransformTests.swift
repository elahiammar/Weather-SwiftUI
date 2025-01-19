@testable import ResidentialData
@testable import ResidentialDomain
import XCTest

class WeatherDetailsTransformTests: XCTestCase {
    func test_weatherResponse_whenTransform_thenReturnExpectedDomainModel() {
        // Given
        let givenDataModel: WeatherResponse = .init(
            location: .init(
                name: "City"
            ),
            current: .init(
                temp_c: 10.2,
                feelslike_c: 11.1,
                humidity: 4,
                uv: 1.2,
                condition: .init(
                    icon: "iconString"
                )
            )
        )
        
        let expectedDomainModel = WeatherDetails.data(
            .init(
                uv: "1.2",
                imageUrl: URL(string: "https:iconString"),
                cityName: "City",
                humidity: "4%",
                feelsLike: "11.1°",
                temperature: "10.2°"
            )
        )
        // When
        let actualDomainModel = WeatherDetails(weather: givenDataModel)

        // Then
        XCTAssertEqual(expectedDomainModel, actualDomainModel)
    }
}
