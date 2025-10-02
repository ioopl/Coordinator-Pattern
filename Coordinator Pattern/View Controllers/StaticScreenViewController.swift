import UIKit

final class StaticScreenViewController: UIViewController {
    private let viewModel: StaticScreenViewModeling

    init(viewModel: StaticScreenViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable) required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        view.backgroundColor = .systemBackground

        let label = UILabel()
        label.text = viewModel.message
        label.font = .preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

//final class SettingsViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Settings"
//        view.backgroundColor = .secondarySystemBackground
//
//        let label = UILabel()
//        label.text = "Settings Screen"
//        label.font = .preferredFont(forTextStyle: .title2)
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(label)
//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//}
