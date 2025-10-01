import UIKit

enum AuthResult {
    case LoginSuccess
    case LoginCancelled
}

final class AuthCoordinator: BaseCoordinator {

    var onFinish: ((AuthResult) -> Void)?

    override func start() {
        
        let vc = LoginViewController()
        
        vc.onLogin = { [weak self] in
            self?.onFinish?(.LoginSuccess)
        }
        
        vc.onCancel = { [weak self] in
            self?.onFinish?(.LoginSuccess)
        }
        
        navigationController.setViewControllers([vc], animated: false)
    }
}
