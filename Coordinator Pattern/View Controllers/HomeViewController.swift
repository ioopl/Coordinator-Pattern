import UIKit

final class HomeViewController: UIViewController {
    
    /// Navigation: View controllers fire intent closures WHILE coordinators decide/push/present. 👈
    /// Think of VC closures as intent signals (“user tapped X”), and coordinator closures as flow outputs (“this flow is done”). That separation keeps VCs dumb and flows testable.
    ///  var onDetails: (() -> Void)? is just a callback property. The coordinator (MainCoordinator) assigns it to point at its own method. So when the VC calls onDetails?(), it’s effectively calling the coordinator’s method.
    ///  If HomeViewController called navigationController?.pushViewController(...) itself, it would own navigation and get bloated. Using a closure keeps VCs dumb, navigation centralized, and everything easier to test.
    ///  https://chatgpt.com/s/t_68dc6b4fb4448191af27ae687fef65f9

    var onDetails: (() -> Void)?

    var onSettings: (() -> Void)?

    var onLogout: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Home"
        view.backgroundColor = .systemBackground

        let details = UIButton(type: .system)
        details.setTitle("Details", for: .normal)
        details.addTarget(self, action: #selector(detailsTapped), for: .touchUpInside)

        let settings = UIButton(type: .system)
        settings.setTitle("Settings", for: .normal)
        settings.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)

        let logout = UIButton(type: .system)
        logout.setTitle("Log out", for: .normal)
        logout.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [details, settings, logout])
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc
    private func detailsTapped()  {
        onDetails?()
    }
    
    @objc
    private func settingsTapped() {
        onSettings?()
    }
    
    @objc
    private func logoutTapped() {
        onLogout?()
    }
}
