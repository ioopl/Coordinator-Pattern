import UIKit

// MARK: - View Controllers

final class LoginViewController: UIViewController {
    
    private let viewModel: LoginViewModeling
    
    // UI
    private lazy var login: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(viewModel.loginTitle, for: .normal)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancel: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(viewModel.cancelTitle, for: .normal)
        button.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: LoginViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = .systemBackground
        
        let stack = UIStackView(arrangedSubviews: [login, cancel])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc
    private func loginTapped()  {
        viewModel.loginTapped()
    }
    
    @objc
    private func cancelTapped() {
        viewModel.cancelTapped()
    }
    
    /*
    var onLogin: (() -> Void)?
    var onCancel: (() -> Void)?
    @objc private func loginTapped() { onLogin?() }
    @objc private func cancelTapped() { onCancel?() }
     */

}
