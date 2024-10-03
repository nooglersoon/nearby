import BaseUIKit
import UIKit

final class ForgotPasswordCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        let forgotPasswordViewController = ForgotPasswordViewController()
        forgotPasswordViewController.coordinator = self
        self.pushViewController(to: forgotPasswordViewController, animated: animated)
    }
}
