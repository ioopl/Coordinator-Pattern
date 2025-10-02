import UIKit

// MARK: - ViewModels

protocol LoginViewModeling {
    
    var loginTitle: String { get }
    var cancelTitle: String { get }

    // Outputs to Coordinator
    var onLogin: (() -> Void)? { get set }
    var onCancel: (() -> Void)? { get set }

    // Intents from View
    func loginTapped()
    func cancelTapped()
}

final class LoginViewModel: LoginViewModeling {
    
    private let model: LoginModel
    init(model: LoginModel = LoginModel()) {
        self.model = model
    }

    var onLogin: (() -> Void)?
    var onCancel: (() -> Void)?

    var loginTitle: String {
        model.loginButtonTitle
    }
    
    var cancelTitle: String {
        model.cancelButtonTitle
    }

    func loginTapped()  {
        onLogin?()
    }
    func cancelTapped() {
        onCancel?()
    }
}
