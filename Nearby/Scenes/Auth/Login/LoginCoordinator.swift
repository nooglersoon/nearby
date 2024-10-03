import BaseUIKit
import UIKit

final class LoginCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        let loginViewController = LoginViewController()
        loginViewController.coordinator = self
        self.pushViewController(to: loginViewController, animated: animated)
    }
}
