import UIKit

enum AuthResult {
    case LoginSuccess
    case LoginCancelled
}

final class AuthCoordinator: BaseCoordinator {

    var onFinish: ((AuthResult) -> Void)?

    override func start() {
        
        /*
        let vc = LoginViewController()
        
        vc.onLogin = { [weak self] in
            self?.onFinish?(.LoginSuccess)
        }
        
        vc.onCancel = { [weak self] in
            self?.onFinish?(.LoginSuccess)
        }
        */
        
        let vm = LoginViewModel()
        vm.onLogin  = { [weak self] in
            self?.onFinish?(.LoginSuccess)
        }
        vm.onCancel = { [weak self] in
            self?.onFinish?(.LoginCancelled)
        }

        // Inject VM into VC
        let vc = LoginViewController(viewModel: vm)
        navigationController.setViewControllers([vc], animated: false)
    }
}
