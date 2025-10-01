import UIKit

// MARK: - View Controllers

final class LoginViewController: UIViewController {

    var onLogin: (() -> Void)?

    var onCancel: (() -> Void)?

    override func viewDidLoad() {

        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = .systemBackground

        let login = UIButton(type: .system)
        login.setTitle("Log In", for: .normal)
        login.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)

        let cancel = UIButton(type: .system)
        cancel.setTitle("Cancel", for: .normal)
        cancel.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)

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
    private func loginTapped() {
        onLogin?()
    }
    
    @objc
    private func cancelTapped() {
        onCancel?()
    }
}
