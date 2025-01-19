import UIKit
import ResidentialUI
import SharedUI

public class ResidentialAppCoordinator: BaseCoordinator {
    
    private let navigation: UINavigationController
    private let viewControllerFactory: ResidentialViewControllerFactoryProtocol
    
    public init(
        navigation: UINavigationController,
        viewControllerFactory: ResidentialViewControllerFactoryProtocol
    ) {
        self.navigation = navigation
        self.viewControllerFactory = viewControllerFactory
        
        super.init()
    }
    
    override public func start() {
        showHomeScreen()
    }
    
    private func showHomeScreen() {
        let viewController = viewControllerFactory.makeHomeViewController()
        navigation.setViewControllers([viewController], animated: false)
        navigation.isNavigationBarHidden = true
    }
}

extension ResidentialAppCoordinator {
    public static func coordinator(
        navigation: UINavigationController,
        diContainer: ResidentialDIContainer
    ) -> ResidentialAppCoordinator {
        return ResidentialAppCoordinator(
            navigation: navigation,
            viewControllerFactory: ResidentialViewControllerFactory(
                weatherRepository: diContainer.weatherRepository
            )
        )
    }
}
