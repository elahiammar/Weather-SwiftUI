import Foundation
import ResidentialDomain

@MainActor
public final class HomeViewModel: ObservableObject {
    @Published public var errorMessage: String?
    @Published private(set) var locationSelected: Bool = false
    @Published private(set) var weatherDetails: WeatherDetails?
    
    private let getWeatherDetailsUseCase: GetWeatherDetailsUseCase

    @preconcurrency public init(
        getWeatherDetailsUseCase: GetWeatherDetailsUseCase
    ) {
        self.getWeatherDetailsUseCase = getWeatherDetailsUseCase
    }

    public func onAppear() async {
        await loadWeatherDetails("")
    }
    
    public func onSearchWeather(_ text: String) async {
        guard !text.isEmpty else { return }
        removeData()
        await loadWeatherDetails(text)
    }
    
    public func onAlertDismissed()  {
        errorMessage = nil
    }
    
    public func onLocationSelected()  {
        locationSelected = true
    }

    private func loadWeatherDetails(_ searchText: String) async {
        do {
            weatherDetails = try await getWeatherDetailsUseCase.execute(with: searchText)
        } catch {
            removeData()
            errorMessage = error.localizedDescription
        }
    }
    
    private func removeData() {
        weatherDetails = nil
        locationSelected = false
    }
}
