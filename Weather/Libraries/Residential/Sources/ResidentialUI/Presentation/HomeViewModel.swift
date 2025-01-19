import Foundation
import ResidentialDomain

@MainActor
public final class HomeViewModel: ObservableObject {
    @Published public var errorMessage: String?
    @Published private(set) var weatherSelected: Bool = true
    @Published private(set) var weatherDetails: WeatherDetails?
    
    private let saveWeatherUseCase: SaveWeatherUseCase
    private let getWeatherDetailsUseCase: GetWeatherDetailsUseCase
    private let getPersistedWeatherUseCase: GetPersistedWeatherUseCase
    
    @preconcurrency public init(
        saveWeatherUseCase: SaveWeatherUseCase,
        getWeatherDetailsUseCase: GetWeatherDetailsUseCase,
        getPersistedWeatherUseCase: GetPersistedWeatherUseCase
    ) {
        self.saveWeatherUseCase = saveWeatherUseCase
        self.getWeatherDetailsUseCase = getWeatherDetailsUseCase
        self.getPersistedWeatherUseCase = getPersistedWeatherUseCase
    }

    public func onAppear() async {
        await loadPersistedWeather()
    }
    
    public func onSearchWeather(_ text: String) async {
        guard !text.isEmpty else { return }
        removeData()
        await loadWeatherDetails(text)
    }
    
    public func onAlertDismissed()  {
        errorMessage = nil
    }
    
    public func onWeatherSelected(location: String)  {
        weatherSelected = true
        saveWeather(location: location)
    }

    private func loadWeatherDetails(_ searchText: String) async {
        do {
            weatherDetails = try await getWeatherDetailsUseCase.execute(with: searchText)
        } catch {
            removeData()
            errorMessage = error.localizedDescription
        }
    }
    
    private func loadPersistedWeather() async {
        do {
            weatherDetails = try await getPersistedWeatherUseCase.execute(with: ())
        } catch {
            removeData()
            errorMessage = error.localizedDescription
        }
    }
    
    private func saveWeather(location: String) {
        saveWeatherUseCase.execute(with: location)
    }
    
    private func removeData() {
        weatherDetails = nil
        weatherSelected = false
    }
}
