import UIKit

public protocol BaseViewControllerType {
    var coordinator: Coordinator? { get }
}

public extension BaseViewControllerType {
    var coordinator: Coordinator? { return nil }
}

open class BaseViewController: UIViewController, BaseViewControllerType {
    
    deinit {
        coordinator?.childDidFinish(coordinator)
    }
    
}
