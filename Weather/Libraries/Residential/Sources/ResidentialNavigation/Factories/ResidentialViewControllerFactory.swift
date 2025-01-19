import SwiftUI
import ResidentialDomain
import ResidentialUI

final class ResidentialViewControllerFactory: ResidentialViewControllerFactoryProtocol {
    
    private let weatherRepository: WeatherRepositoryProtocol

    public init(weatherRepository: WeatherRepositoryProtocol) {
        self.weatherRepository = weatherRepository
    }
    
    @MainActor
    public func makeHomeViewController() -> UIViewController {
        let viewModel = HomeViewModel(
            getWeatherDetailsUseCase: GetWeatherDetailsUseCase(repository: weatherRepository)
        )
        return UIHostingController(rootView: HomeView(viewModel: viewModel))
    }
}

