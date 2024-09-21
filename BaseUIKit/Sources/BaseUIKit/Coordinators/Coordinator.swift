import Foundation
import UIKit

public protocol Coordinator: AnyObject {
    /// The navigation controller for the coordinator
    var navigationController: UINavigationController { get set }
    
    /**
     The Coordinator takes control and activates itself.
     - Parameters:
     - animated: Set the value to true to animate the transition. Pass false if you are setting up a navigation controller before its view is displayed.
     
     */
    func start(animated: Bool)
    
    /**
     Pops out the active View Controller from the navigation stack.
     - Parameters:
     - animated: Set this value to true to animate the transition.
     */
    func popViewController(animated: Bool)
    
    /**
     Push the active View Controller to the navigation stack.
     - Parameters:
     - animated: Set this value to true to animate the transition.
     */
    func pushViewController(
        to viewController: UIViewController,
        animated: Bool,
        hideNavigationBar: Bool
    )
    
    /**
     Pops view controllers until the specified view controller is at the top of the navigation stack.
     - Parameters:
     - viewController: The view controller that you want to be at the top of the stack. This view controller must currently be on the navigation stack.
     - animated: Set this value to true to animate the transition.
     */
    func popToViewController(
        to viewController: UIViewController,
        animated: Bool,
        hideNavigationBar: Bool
    )
    
    /**
     Pops view controllers to  the top of the navigation stack.
     - Parameters:
     - animated: Set this value to true to animate the transition.
     */
    func popToRoot(
        animated: Bool,
        hideNavigationBar: Bool
    )
    
}

extension Coordinator {
    
    func popViewController(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
    
    func pushViewController(
        to viewController: UIViewController,
        animated: Bool,
        hideNavigationBar: Bool = false
    ) {
        navigationController.pushViewController(viewController, animated: animated)
        navigationController.hidesBottomBarWhenPushed = hideNavigationBar
    }
    
    func popToViewController(
        to viewController: UIViewController,
        animated: Bool,
        hideNavigationBar: Bool = false
    ) {
        navigationController.popToViewController(viewController, animated: animated)
        navigationController.hidesBottomBarWhenPushed = hideNavigationBar
    }
    
    func popToRoot(
        animated: Bool,
        hideNavigationBar: Bool = false
    ) {
        navigationController.popToRootViewController(animated: animated)
        navigationController.hidesBottomBarWhenPushed = hideNavigationBar
    }
    
}
