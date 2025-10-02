import UIKit

final class HomeViewController: UIViewController {
    private let viewModel: HomeViewModeling
    
    /// Navigation: View controllers fire intent closures WHILE coordinators decide/push/present. 👈
    /// Think of VC closures as intent signals (“user tapped X”), and coordinator closures as flow outputs (“this flow is done”). That separation keeps VCs dumb and flows testable.
    ///  var onDetails: (() -> Void)? is just a callback property. The coordinator (MainCoordinator) assigns it to point at its own method. So when the VC calls onDetails?(), it’s effectively calling the coordinator’s method.
    ///  If HomeViewController called navigationController?.pushViewController(...) itself, it would own navigation and get bloated. Using a closure keeps VCs dumb, navigation centralized, and everything easier to test.
    ///  https://chatgpt.com/s/t_68dc6b4fb4448191af27ae687fef65f9
    /*
     var onDetails: (() -> Void)?
     var onSettings: (() -> Void)?
     var onLogout: (() -> Void)?
     */
    
    // UI
    private lazy var details: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(viewModel.detailsTitle, for: .normal)
        button.addTarget(self, action: #selector(detailsTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var settings: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(viewModel.settingsTitle, for: .normal)
        button.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var logout: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(viewModel.logoutTitle, for: .normal)
        button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: HomeViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        
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
    
    @objc private func detailsTapped()  {
        viewModel.detailsTapped()
    }
    @objc private func settingsTapped() {
        viewModel.settingsTapped()
    }
    @objc private func logoutTapped()   {
        viewModel.logoutTapped()
    }
}

// Previously it use to be like this
//    @objc
//    private func detailsTapped()  {
//        onDetails?()
//    }
//    
//    @objc
//    private func settingsTapped() {
//        onSettings?()
//    }
//    
//    @objc
//    private func logoutTapped() {
//        onLogout?()
//    }


