import UIKit

protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController { get }
    
    func start()
}

class BaseCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        /* override in subclass */
    }

    func add(child: Coordinator) {
        childCoordinators.append(child)
    }

    func remove(child: Coordinator) {
        childCoordinators.removeAll { $0 === child } //     === is the identity operator in Swift. It answers: “Are these two references pointing to the exact same object instance in memory?”
    }
}
