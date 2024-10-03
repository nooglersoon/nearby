import UIKit

public protocol BaseViewControllerType {
    var coordinator: Coordinator? { get set }
}

open class BaseViewController: UIViewController, BaseViewControllerType {
    open weak var coordinator: (any Coordinator)?
    
    deinit {
        coordinator?.childDidFinish(coordinator)
    }
    
}
