import BaseUIKit
import UIKit
import Foundation

enum SignUpNavigation {
    case login
    case forgotPassword
}

final class SignUpCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        let signUpViewController = SignUpViewController()
        signUpViewController.coordinator = self
        self.pushViewController(to: signUpViewController, animated: true)
    }
    
    func navigate(to navigation: SignUpNavigation) {
        switch navigation {
        case .login:
            let coordinator = LoginCoordinator(navigationController: navigationController)
            coordinator.parentCoordinator = self
            childCoordinators.append(coordinator)
            coordinator.start(animated: true)
            
        case .forgotPassword:
            if !childCoordinators.isEmpty {
                self.popToRoot(animated: true)
            }
            let coordinator = ForgotPasswordCoordinator(navigationController: navigationController)
            coordinator.parentCoordinator = self
            childCoordinators.append(coordinator)
            coordinator.start(animated: true)
        }
    }
}
