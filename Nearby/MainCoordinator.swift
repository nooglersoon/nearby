import BaseUIKit
import UIKit

final class MainCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: Start Navigation

extension MainCoordinator {
    
    func start(animated: Bool) {
        self.pushViewController(to: MainViewController(), animated: true, hideNavigationBar: false)
    }
    
}
