import BaseUIKit
import UIKit
import Foundation

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
    
    func goToLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        childCoordinators.append(loginCoordinator)  // Retain the loginCoordinator
        loginCoordinator.start(animated: true)
    }
}
