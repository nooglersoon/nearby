import UIKit

/// All the top-level coordinators should conform to this protocol
protocol ParentCoordinator: Coordinator {
    /// Each Coordinator can have its own children coordinators
    var childCoordinators: [Coordinator] { get set }
    /**
     Adds the given coordinator to the list of children.
     - Parameters:
        - child: A coordinator.
     */
    func addChild(_ child: Coordinator?)
    /**
     Tells the parent coordinator that given coordinator is done and should be removed from the list of children.
     - Parameters:
        - child: A coordinator.
     */
    func childDidFinish(_ child: Coordinator?)
}

extension ParentCoordinator {
    //MARK: - Coordinator Functions
    /**
     Appends the coordinator to the children array.
     - Parameters:
     - child: The child coordinator to be appended to the list.
     */
    func addChild(_ child: Coordinator?){
        if let _child = child {
            childCoordinators.append(_child)
        }
    }
    
    /**
     Removes the child from children array.
     - Parameters:
     - child: The child coordinator to be removed from the list.
     */
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
/// All Child coordinators should conform to this protocol
protocol ChildCoordinator: Coordinator {
    /**
     The body of this function should call `childDidFinish(_ child:)` on the parent coordinator to remove the child from parent's `childCoordinators`.
     */
    func coordinatorDidFinish()
    /// A reference to the view controller used in the coordinator.
    var viewControllerRef: UIViewController? {get set}
}
